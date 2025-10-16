


local __sdkEnable = function()
    return LuaCallCs.IsEditor()
end


---@class RechargeSystem : SystemBase
RechargeSystem = Class("RechargeSystem", SystemBase)

function RechargeSystem:OnInit()
    self._evtReqOrder = function(activityId, orderId)self:__sendCurOrder(activityId, orderId) end
    self._evtSdkResult = function(orderId, result, msg) self:__clientReceiveSdkRechargeResult(orderId, result, msg) end
    self._evtReceiveServerMsg = function(msg) self:__receiveRechargeGameOrderList(msg) end
    EventManager.Global.RegisterEvent(EventType.RechargeReqOrder, self._evtReqOrder)
    EventManager.Global.RegisterEvent(EventType.RechargeSdkResult, self._evtSdkResult)
    EventManager.Global.RegisterEvent(EventType.RechargeReceiveServerMsg, self._evtReceiveServerMsg)
end

function RechargeSystem:OnClear()
    EventManager.Global.UnRegisterEvent(EventType.RechargeReqOrder, self._evtReqOrder)
    EventManager.Global.UnRegisterEvent(EventType.RechargeSdkResult, self._evtSdkResult)
    EventManager.Global.UnRegisterEvent(EventType.RechargeReceiveServerMsg, self._evtReceiveServerMsg)
end

function RechargeSystem:OnGameStart()
    ---@type table<string, RechargeOrderInfo> 订单列表
    self._orderList = {} --客户端用不上，没必要存
    ---@type RechargeOrderInfo 当前正在处理的订单
    self._curOrder = nil
    ---@type string[] 异常的订单
    self._errorOrderList = {}
    ---@type boolean true:充值保护中，不允许二次充值。false:保护取消，可以进行其他充值
    self._rechargeProtection = false
end

function RechargeSystem:OnGameEnd()
    self:__breakTimer()
    self._curOrder = nil
    self._errorOrderList = {}
    self._rechargeProtection = false
end

function RechargeSystem:__breakTimer()
    if self._timer then
        Util.Timer.BreakTimer(self._timer)
        self._timer = nil
    end
end


function RechargeSystem:__rechargeError()
    local error = ""
    if self._curOrder then
        error = "---   充值失败：orderId = "..self._curOrder.orderId
        table.insert(self._errorOrderList, self._curOrder._id)
    else
        error = "---   充值失败：orderId = nil，请求订单消息后一直没有收到订单消息."
    end
    self:__removeOrderInfo()
    self:__setRechargeProtection(false)
end

function RechargeSystem:__rechargeFinish()
    self:__removeOrderInfo()
    self:__setRechargeProtection(false)
end


-- 充值流程超时，客户端保护机制取消
function RechargeSystem:__rechargeTimeout()
    local error = self:__rechargeError()
    LuaCallCs.LogError(error)
    Util.MsgBox.OpenShowInfo(error)
end

-- 充值流程结束，结果可能是成功，失败等因素
function RechargeSystem:__rechargeFinish()
    self:__setRechargeProtection(false)
end


function RechargeSystem:__setRechargeProtection(isOpen)
    self._rechargeProtection = isOpen
end

-- 记录订单信息
function RechargeSystem:__cacheOrderInfo(orderId, activityId, bundleId, status, orderTime, getRewardTime, sdkPay)
    if self._curOrder then
        LuaCallCs.LogError("---   支付数据异常：有订单未完成，新订单无法记录，orderId = "..orderId.."   activityId = "..activityId.."   bundleId = "..bundleId.."   status = "..status)
        return false
    else
        local info = RechargeOrderInfo()
        info:Init(orderId, activityId, bundleId, status, orderTime, getRewardTime, sdkPay)
        self._curOrder = info
        return true
    end
end
-- 移除订单信息
function RechargeSystem:__removeOrderInfo()
    self._curOrder = nil
end

-- 客户端收到SDK支付回调
function RechargeSystem:__clientReceiveSdkRechargeResult(orderId, result, msg)
    self:__sendRechargeSdkResult(orderId, result, msg)
end

------------------------------------------- 前后端通信部分 ----------------------------------------------
-- 请求当前支付订单
function RechargeSystem:__sendCurOrder(activityId, bundleId)
    if self._rechargeProtection then
        print("---   充值保护中，不允许二次充值...")
        return
    end

    SendHandlers.ReqRechargeGameOrder(activityId, bundleId)

    self:__setRechargeProtection(true)
    self._timer = Util.Timer.AddTimer(120, function()
        self:__rechargeTimeout()
    end)
end

-- 解析当前支付订单
---@param msg table<number, SC_RechargeOrder>
function RechargeSystem:__receiveCurOrder(msg)
    for k, v in pairs(msg) do
        local orderId = v.gameOrderId
        local activityId = v.activityId
        local bundleId = v.bundleId
        local status = v.status
        local orderTime = v.openTime
        local getRewardTime = v.closeTime
        local sdkPay = v.sdkPay

        if status == RechargeDefine.ServerOrderStatus.SdkRequest then
            -- 记录当前订单
            -- 请求订单信息成功，记录订单信息
            local requestSuccess = self:__cacheOrderInfo(orderId, activityId, bundleId, status, orderTime, getRewardTime, sdkPay)
            if requestSuccess then
                if __sdkEnable() then
                    -- 调起支付SDK，等SDK回调
                    -- 接入SDK支付接口
                else
                    -- 跳过SDK支付，立即通知服务器支付成功，同时发送GM指令
                    SendHandlers.ReqGmcmd("Pay:"..orderId)
                    self:__sendRechargeSdkResult(orderId, "1", "SDK支付跳过，使用GM指令领取支付奖励")
                end
                break
            end
        end
    end
end


-- 客户端收到sdk的结果，然后通知服务器
---@param result string SDK返回的结果，类型是SDK定义的string
---@param code string SDK返回的code，类型是SDK定义的string
function RechargeSystem:__sendRechargeSdkResult(orderId, result, code)
    ---@type SC_RechargeSdkResult
    local resultMsg = {}
    resultMsg.success = result
    resultMsg.msg = code
    SendHandlers.ReqRechargeSdkResult(orderId, resultMsg)
end

-- 服务器通知客户端充值结果
---@param msg table<number, SC_RechargeOrder>
function RechargeSystem:__receiveRechargeSdkResult(msg)
    for k, v in pairs(msg) do
        local orderId = v.gameOrderId
        local status = v.status
        if self._curOrder and self._curOrder._id == orderId then
            -- 订单状态更新
            if status == RechargeDefine.ServerOrderStatus.SdkLocking then
                -- 客户端登录的时候服务器会通知这个状态。但因为客户端有充值保护机制，在这个机制下，这个状态客户端不处理。
            elseif status == RechargeDefine.ServerOrderStatus.SdkTimeout then
                -- 服务器充值超时，服务器的超时时间比客户端长，这个消息服务器会下发，但客户端不需要处理
                print("---   充值数据异常：服务器充值已超时， orderId= "..orderId.."   status = "..status)
            elseif status == RechargeDefine.ServerOrderStatus.SdkFailure then
                -- 明确结果：充值失败
                Util.Notice.Show("充值失败...")
                self:__rechargeError()
            elseif status == RechargeDefine.ServerOrderStatus.SdkSuccess then
                -- 明确结果：充值成功, 正常情况不会推送给客户端
            elseif status == RechargeDefine.ServerOrderStatus.PaySuccess then
                -- 这个状态是服务器收到SDK回调的状态，正常情况不会推送给客户端，客户端收到这个状态说明服务器有错误
            elseif status == RechargeDefine.ServerOrderStatus.RewardItem then
                -- 领奖成功，奖励进入背包。
                -- 充值保护机制取消
                self:__rechargeFinish()
            elseif status == RechargeDefine.ServerOrderStatus.RewardMail then
                -- 服务器把充值奖励以邮件的方式下发，客户端不处理
                -- 充值保护机制取消
                self:__rechargeFinish()
            end
        end
    end
end



---@param msg table<number, SC_RechargeOrder>
function RechargeSystem:__receiveRechargeGameOrderList(msg)
    if not self._rechargeProtection then
        -- 充值流程中，允许处理订单数据。
        -- 充值流程之外，所有订单数据都不处理，客户端暂时用不上。2025.9.16
        return
    end

    -- 这段代码写的有点乱，是因为服务器返回的协议号是一个，客户端无法通过协议号区分不同的情况，只能遍历所有订单信息反向推断当前的状态
    self:__receiveCurOrder(msg)
    self:__receiveRechargeSdkResult(msg)
end


------------------------------------------- 前后端通信部分 ----------------------------------------------




