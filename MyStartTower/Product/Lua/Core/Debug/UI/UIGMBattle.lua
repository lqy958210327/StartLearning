local UIGMBattle = Class("UIGMBattle")

function UIGMBattle:SetDBData()
    ---@type GMDB
    local db = GameDB.GetDB(DBId.GM)
    self.debugInfoList = db:GetGMUIDataList(GMEmun.Battle)
    if not self.debugInfoList then
        db:SetGMData(GMEmun.Battle, BattleFun)
        self.debugInfoList = db:GetGMUIDataList(GMEmun.Battle)
    end
    return self.debugInfoList
end

function UIGMBattle.winBattle(gmStr, menu, value)
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 1)
end

function UIGMBattle.loseBattle()
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 2)
end

function UIGMBattle.enterTestLv()

end

function UIGMBattle.guildBossDeductHp()
    SendHandlers.ReqGmcmd("guildBossDeductHp")
end

---@type table
BattleFun = {
    { name = "战斗胜利", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMBattle.winBattle },
    { name = "战斗失败", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMBattle.loseBattle },
    { name = "进入测试关", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMBattle.enterTestLv },
    { name = "减敌人20%生命", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMBattle.guildBossDeductHp },
}

return UIGMBattle

