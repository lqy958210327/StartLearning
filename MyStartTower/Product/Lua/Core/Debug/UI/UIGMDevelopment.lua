local UIGMDevelopment = Class("UIGMDevelopment")

function UIGMDevelopment:SetDBData()
    ---@type GMDB
    local db = GameDB.GetDB(DBId.GM)
    self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBDevelopment)
    if not self.debugInfoList then
        db:SetGMData(GMEmun.GMDBDevelopment, DevelopmentFun)
        self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBDevelopment)
    end
    return self.debugInfoList
end

function UIGMDevelopment.winBattle(gmStr, menu, value)
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 1)
end

function UIGMDevelopment.loseBattle()
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 2)
end

function UIGMDevelopment.enterTestLv()
    --WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 2)
end

function UIGMDevelopment:UILiftOnClose()
    
end

function UIGMDevelopment.addItem(value)
    SendHandlers.ReqGmcmd("addItem:"..value)
end

function UIGMDevelopment.starterPack()
    SendHandlers.ReqGmcmd("starterPack")
end

function UIGMDevelopment.clearBagItem()
    SendHandlers.ReqGmcmd("clearBagItem")
end

function UIGMDevelopment.addHero()
    SendHandlers.ReqGmcmd("addHero")
end

function UIGMDevelopment.clearHero()
    SendHandlers.ReqGmcmd("clearHero")
end

function UIGMDevelopment.heroUpLevel(value)
    SendHandlers.ReqGmcmd("heroUpLevel:"..value)
end

function UIGMDevelopment.minLvs()
    SendHandlers.ReqGmcmd("minLvs")
end

function UIGMDevelopment.maxLvs()
    SendHandlers.ReqGmcmd("maxLvs")
end

function UIGMDevelopment.clearAllElement()
    SendHandlers.ReqGmcmd("clearAllElement")
end

function UIGMDevelopment.clearEquip()
    SendHandlers.ReqGmcmd("clearEquip")
end

function UIGMDevelopment.suitLevelEquip(value)
    SendHandlers.ReqGmcmd("suitLevelEquip:"..value)
end

function UIGMDevelopment.qualityLevelEquip(value)
    SendHandlers.ReqGmcmd("qualityLevelEquip:"..value)
end

function UIGMDevelopment.qualityLevelElement(value)
    SendHandlers.ReqGmcmd("qualityLevelElement:"..value)
end

function UIGMDevelopment.proPlayers()
    SendHandlers.ReqGmcmd("proPlayers")
end

function UIGMDevelopment.sendMail(value)
    SendHandlers.ReqGmcmd("sendMail:"..value)
end



---@type table
DevelopmentFun = {
    { name = "添加物品(ID:数量)", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMDevelopment.addItem, showTips = "100001:100000" },
    { name = "清空背包", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.clearBagItem },
    { name = "获得全部英雄", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.addHero },
    { name = "清空英雄", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.clearHero },
    { name = "英雄一键升级", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMDevelopment.heroUpLevel, showTips="1"  },
    { name = "英雄一键1级", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.minLvs },
    { name = "英雄一键满级", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.maxLvs },
    { name = "装备依品质获得", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMDevelopment.qualityLevelEquip, showTips="1:1:1" },
    { name = "装备依套装获得", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMDevelopment.suitLevelEquip, showTips="1:1:1:1" },
    { name = "清空装备", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.clearEquip },
    { name = "圣徽依套装获得", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMDevelopment.qualityLevelElement, showTips="1:1:1:1" },
    { name = "清空圣徽", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.clearAllElement },
    { name = "一键养成大礼包", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.starterPack },
    { name = "顶级账号", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMDevelopment.proPlayers },
    { name = "发送邮件", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMDevelopment.sendMail },
}

return UIGMDevelopment

