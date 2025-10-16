local UIGMSystem = Class("UIGMSystem")

function UIGMSystem:SetDBData()
    ---@type GMDB
    local db = GameDB.GetDB(DBId.GM)
    self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBSystem)
    if not self.debugInfoList then
        db:SetGMData(GMEmun.GMDBSystem, SystemFun)
        self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBSystem)
    end
    return self.debugInfoList
end

function UIGMSystem.winBattle(gmStr, menu, value)
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 1)
end

function UIGMSystem.loseBattle()
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 2)
end

function UIGMSystem.enterTestLv()
    --WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 2)
end

function UIGMSystem:UILiftOnClose()
    
end

local function AttachID(res,key,attach)
    for id, data in pairs(res) do
        local suffix = '[' .. id .. ']'
        if attach then
            data[key] = (data[key] or '') .. suffix
        else
            data[key] = string.replace(data[key], suffix, '')
        end
    end
end

local _showID = false
function UIGMSystem.showID()
    _showID = not _showID

    AttachID(DataTable.ResItem,'name',_showID)
    AttachID(DataTable.ResHero,'full_name',_showID)
    AttachID(DataTable.ResHero,'hero_name',_showID)

    AttachID(DataTable.ResClientNotice,'notice',_showID)
    AttachID(DataTable.ResInfoNotice,'title',_showID)
    AttachID(DataTable.ResClientConfirm,'title',_showID)

    IS_EDITOR_ID = _showID
    return _showID and "隐藏ID" or "显示ID"
end

function UIGMSystem.protectorPlan(value)
    SendHandlers.ReqGmcmd("protectorPlan:"..value)
end

function UIGMSystem.updatePlayerCreateDate(value)
    SendHandlers.ReqGmcmd("updatePlayerCreateDate:"..value)
end

function UIGMSystem.updateServerDate(value)
    SendHandlers.ReqGmcmd("updateServerDate:"..value)
end

function UIGMSystem.addTaskCompleted(value)
    SendHandlers.ReqGmcmd("addTaskCompleted:"..value)
end

---@type table
SystemFun = {
    { name = "显示ID", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMSystem.showID },
    { name = "魔王阶梯完成任务", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMSystem.protectorPlan, showTips="1011" },
    { name = "完成指定任务多次", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMSystem.addTaskCompleted, showTips="1:1011:200404:2"  },
    { name = "修改创角时间", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMSystem.updatePlayerCreateDate, showTips="@2025-07-21 23:58:30" },
    { name = "修改服务器时间", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMSystem.updateServerDate },
}

return UIGMSystem

