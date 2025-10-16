

---@class RechargeSdkPayInfo
local RechargeSdkPayInfo = Class("RechargeSdkPayInfo")
function RechargeSdkPayInfo:Init()

end


---@class RechargeOrderInfo
RechargeOrderInfo = Class("RechargeOrderInfo")

---@param sdkPay SC_RechargeSdkPay
function RechargeOrderInfo:Init(orderId, activityId, bundleId, status, orderTime, getRewardTime, sdkPay)
    ---@type string 订单ID
    self._id = orderId
    ---@type number 活动ID
    self._activityId = activityId
    ---@type number 礼包ID
    self._bundleId = bundleId
    ---@type string 订单状态(服务器定义)，将RechargeDefine.ServerOrderStatus定义
    self._orderStatus = status
    ---@type number 下单时间
    self._orderTime = orderTime
    ---@type number 领取奖励时间
    self._getRewardTime = getRewardTime
    ---@type RechargeSdkPayInfo 支付信息,对接SDK
    self._sdkPayInfo = nil
end