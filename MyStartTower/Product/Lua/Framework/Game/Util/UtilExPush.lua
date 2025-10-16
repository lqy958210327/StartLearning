
-- 付费商城 工具

-- 获取 付费商店 配置
local _getPushWindow = function(pushId)
    local cfg = DataTable.ResActivityPushWindow[pushId]
    assert(cfg, "---   数据异常：ResCountdownBundleData配置数据空 pushId = "..pushId)
    return cfg
end

-- 获取 显示礼包模版表
local _getPushCountdownBundleCfg = function(pushId)
    local cfg = DataTable.ResActivityPushCountdownBundle[pushId]
    assert(cfg, "---   数据异常：ResCountdownBundlePushGroup配置数据空 groupId = "..pushId)
    return cfg
end


-- 获取 显示礼包模版表
local _getPushUpHeroCfg = function(pushId)
    local cfg = DataTable.ResActivityPushUpHero[pushId]
    assert(cfg, "---   数据异常：ResCountdownBundlePushGroup配置数据空 groupId = "..pushId)
    return cfg
end

-- 获取 付费商店组 配置
local _pushDB = function()
    ---@type PushDB
    local db = GameDB.GetDB(DBId.Push)
    return db
end

local tab = {}

-- 获取礼包类型
function tab.GetTypeByPushId(pushId)
    local cfg = _getPushWindow(pushId)
    return cfg.type
end

-- 获取礼包组
function tab.GetUITempByPushId(pushId)
    local cfg = _getPushWindow(pushId)
    return cfg.entranceGroupID
end

-- 推送礼包列表
function tab.GetPushIdsByType(typeId)
    local db = _pushDB()
    return db:GetPushIdsByType(typeId)
end

function tab.UpdateMsg(addPush, delPush)
    local db = _pushDB()
    db:UpdateMsg(addPush, delPush)

    ---同时UI刷新
    Blackboard.UIEvent.SendMessage(UIName.UIPushWindow, UIEventID.UIPushWindow_Refresh)
end


-- 业务侧设置是否可推送  根据类型传
---@param pushId number 推送类型  PushDefine.TempID.MonthlyCard
---@param isAutoPush boolean 功能是否开启
function tab.UpdateAutoPushByPushType(pushType, isAutoPush, rewardList)
    local db = _pushDB()
    db:UpdateAutoPushByType(pushType, isAutoPush, rewardList)
end

-- 业务侧设置是否可推送
---@param pushId number 推送类型  PushDefine.TempID.MonthlyCard
---@param isAutoPush boolean 功能是否开启
function tab.UpdateAutoPushByPushId(pushId, isAutoPush, rewardList)
    local db = _pushDB()
    db:UpdateAutoPushById(pushId, isAutoPush, rewardList)
end

-- 推送礼包列表
---@return number[]
function tab.GetAllAutoPushIds()
    local db = _pushDB()
    return db:GetAllAutoPushIds()
end

---@return PushData
function tab.GetPushDataById(pushId)
    local db = _pushDB()
    local pushData = db:GetPushDataById(pushId)
    return pushData
end

---@return number
function tab.GetPushTypeById(pushId)
    local db = _pushDB()
    local pushData = db:GetPushDataById(pushId)
    return pushData.pushType
end

function tab.ShowAutoPushUI(pushId)
    local pushType = tab.GetPushTypeById(pushId)
    if pushType == PushDefine.TempID.FirstRecharge then
        local isNotTodayPush = Util.ClientPeriodHint.EverydayFirstHint(ClientPeriodHintDefine.ID.FirstRecharge) --今日是否弹出
        if isNotTodayPush then
            UIJump.ToOpenUIFirstRechargePush()
            return true
        end
    end
    if pushType == PushDefine.TempID.MonthlyCard then
        local isNotTodayPush = Util.ClientPeriodHint.EverydayFirstHint(ClientPeriodHintDefine.ID.MonthlyCard) --今日是否弹出
        if isNotTodayPush then
            UIJump.ToOpenUIMonthlyCardPush()
            return true
        end
    end
    if pushType == PushDefine.TempID.UpDraw then
        UIJump.ToOpenUIPushWindowById(pushId)
        return true
    end
    if pushType == PushDefine.TempID.PushGift then
        UIJump.ToOpenUIPushWindowById(pushId)
        return true
    end
    return false
end

function tab.ShowPushUIByType(pushType, pushId)
    if pushType == PushDefine.TempID.FirstRecharge then
        UIJump.ToOpenUIFirstRechargePush()
    end
    if pushType == PushDefine.TempID.MonthlyCard then
        UIJump.ToOpenUIMonthlyCardPush()
    end
    --if pushType == PushDefine.TempID.UpDraw then
    --    UIJump.ToOpenUIPushWindow(pushType)
    --end
    --if pushType == PushDefine.TempID.PushGift then
    --    UIJump.ToOpenUIPushWindow(pushType)
    --end
end

function tab.GetPushUIShowId(pushId)
    local pushCfg = _getPushWindow(pushId)
    return pushCfg.uiShowID
end

function tab.GetPushGiftUICfg(pushId)
    local uiShowId = tab.GetPushUIShowId(pushId)
    local uiCfg = _getPushCountdownBundleCfg(uiShowId)
    return uiCfg
end

function tab.GetPushUpHeroUICfg(pushId)
    local uiShowId = tab.GetPushUIShowId(pushId)
    local uiCfg = _getPushUpHeroCfg(uiShowId)
    return uiCfg
end

Util.Push = tab
