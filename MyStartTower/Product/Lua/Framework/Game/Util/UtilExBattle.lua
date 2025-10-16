


-- 战斗

local tab = {}

function tab.GetSpeed()
    local tog = LuaCallCs.PlayerPrefs.GetString(Util.Battle.SPEED_KEY(), Util.Battle.SPEED_NORMAL())
    local speed = nil
    if tog == Util.Battle.SPEED_NORMAL() then
        speed = 1
    elseif tog == Util.Battle.SPEED_UP1() then
        speed = 1.55
    elseif tog == Util.Battle.SPEED_UP2() then
        speed = 2.55
    end
    return speed
end

function tab.BattlePause(isPause)
    -- 老功能
    if not GameFsm.InterfaceIsInState(Const.STATE_BATTLE) then
        return
    end
    if isPause then
        GameFsm.getCurState():onPause()
    else
        GameFsm.getCurState():onResume()
    end
end

function tab.IS_MANUAL_KEY() -- 是否手动操作  1是  0否
    return "Manual_"..Util.Account.PlayerUid()
end

function tab.SPEED_KEY()
    return "SPEED_KEY"..Util.Account.PlayerUid()
end

function tab.EXTRA_SPEED_KEY()
    return "EXTRA_SPEED_KEY"..Util.Account.PlayerUid()
end

function tab.SPEED_NORMAL() -- 写作normal实际是加速的关闭状态
    return "SPEED_NORMAL"..Util.Account.PlayerUid()
end

function tab.SPEED_UP1()
    return "SPEED_UP1"..Util.Account.PlayerUid()
end

function tab.SPEED_UP2()
    return "SPEED_UP2"..Util.Account.PlayerUid()
end

function tab.SHORT_SKILL_KEY() --是否使用简化技能，1是(不播放大招视频)   0否(播放大招视频)
    return "SHORT_SKILL_KEY"..Util.Account.PlayerUid()
end

---@return BBClassBattleResult
function tab.GetBattleResultData()
    ---@type BBClassBattleResult
    local info = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.BattleResultData)
    return info
end

---@param data BBClassBattleResult
function tab.WriteBattleResultData(data)
    Blackboard.WriteBBItemTable(BbKey.Global, BbItemKey.BattleResultData, data)
end

---@return BBClassBattleResultDropDown
function tab.GetBattleResultDropDownData()
    ---@type BBClassBattleResultDropDown
    local info = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.BattleResultDropDownData)
    return info
end

---@param data BBClassBattleResultDropDown
function tab.WriteBattleResultDropDownData(data)
    Blackboard.WriteBBItemTable(BbKey.Global, BbItemKey.BattleResultDropDownData, data)
end

---@return BBClassBattleResultSpecialData
function tab.GetBattleResultSpecialData()
    ---@type BBClassBattleResultSpecialData
    local info = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.BattleResultRewardData)
    return info
end

---@param data BBClassBattleResultSpecialData
function tab.WriteBattleResultSpecialData(data)
    Blackboard.WriteBBItemTable(BbKey.Global, BbItemKey.BattleResultRewardData, data)
end


Util.Battle = tab
