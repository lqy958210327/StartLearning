local UIGMGameplay = Class("UIGMGameplay")

function UIGMGameplay:SetDBData()
    ---@type GMDB
    local db = GameDB.GetDB(DBId.GM)
    self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBGameplay)
    if not self.debugInfoList then
        db:SetGMData(GMEmun.GMDBGameplay, GameplayFun)
        self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBGameplay)
    end
    return self.debugInfoList
end

function UIGMGameplay.winBattle(gmStr, menu, value)
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 1)
end

function UIGMGameplay.loseBattle()
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 2)
end

function UIGMGameplay.enterTestLv()
    --WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 2)
end

function UIGMGameplay:UILiftOnClose()
    
end

function UIGMGameplay.qmzy(value)
    SendHandlers.ReqGmcmd("qmzy:"..value)
end

function UIGMGameplay.bossTowerSweep(value)
    SendHandlers.ReqGmcmd("bossTowerSweep:"..value)
end

function UIGMGameplay.resetRankScore(value)
    SendHandlers.ReqGmcmd("resetRankScore:"..value)
end

function UIGMGameplay.resetArenaWeekCount(value)
    SendHandlers.ReqGmcmd("resetArenaWeekCount:"..value)
end

function UIGMGameplay.arenaWeekCount(value)
    SendHandlers.ReqGmcmd("arenaWeekCount:"..value)
end

function UIGMGameplay.zzcw(value)
    SendHandlers.ReqGmcmd("zzcw:"..value)
end

function UIGMGameplay.rentLv(value)
    SendHandlers.ReqGmcmd("rentLv:"..value)
end

function UIGMGameplay.rentReset()
    SendHandlers.ReqGmcmd("rentReset")
end

function UIGMGameplay.zyst(value)
    SendHandlers.ReqGmcmd("zyst:"..value)
end

function UIGMGameplay.completeRentTask()
    SendHandlers.ReqGmcmd("completeRentTask")
end

function UIGMGameplay.endlessWarChallenge()
    SendHandlers.ReqGmcmd("endlessWarChallenge")
end

function UIGMGameplay.guildBossBuffPoint()
    SendHandlers.ReqGmcmd("guildBossBuffPoint")
end

function UIGMGameplay.guildBossLayer()
    SendHandlers.ReqGmcmd("guildBossLayer")
end

function UIGMGameplay.challengeCount()
    SendHandlers.ReqGmcmd("challengeCount")
end


function UIGMGameplay.main(value)
    if string.find(value, "-") then
        local args = string.split(value, "-")
        local key1, key2, key3
        if table.count(args) == 2 then
            key1 = 1
            key2 = tonumber(args[1])
            key3 = tonumber(args[2])
        elseif table.count(args) == 3 then
            key1 = tonumber(args[1])
            key2 = tonumber(args[2])
            key3 = tonumber(args[3])
        end
        if key1 and key2 and key3 then
            value = DataTable.ResStage[key1][key2][key3].idx
        end
    end
    -- main关卡进度
    SendHandlers.ReqGmcmd("main"..value)
end


function UIGMGameplay.multiMain(value)
    if string.find(value, "-") then
        local args = string.split(value, "-")
        local key1, key2, key3
        if table.count(args) == 2 then
            key1 = 1
            key2 = tonumber(args[1])
            key3 = tonumber(args[2])
        elseif table.count(args) == 3 then
            key1 = tonumber(args[1])
            key2 = tonumber(args[2])
            key3 = tonumber(args[3])
        end
        if key1 and key2 and key3 then
            value = DataTable.ResStageMulti[key1][key2][key3].idx
        end
    end
    -- main关卡进度
    SendHandlers.ReqGmcmd("multipleMain:"..value)
end



---@type table
GameplayFun = {
    { name = "资源洞窟跳关", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.qmzy , showTips = "1:1"},
    { name = "资源洞窟重置扫荡", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.bossTowerSweep , showTips = "1"},
    { name = "竞技场更改积分", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.resetRankScore , showTips = "1:1"},
    { name = "竞技场增加周场数", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.arenaWeekCount, showTips = "1:1" },
    { name = "竞技场重置周场数", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.resetArenaWeekCount, showTips = "1"},
    { name = "竞技场1v1日结算", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.zzcw},
    { name = "竞技场周结算", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.zzcw},
    { name = "竞技场赛季结算", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.zzcw},
    { name = "迷宫跳关", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.zyst, showTips = "1:1"},
    { name = "一键完成悬赏任务", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.completeRentTask},
    { name = "悬赏等级", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.rentLv, showTips = "1" },
    { name = "悬赏重置今日次数", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.rentReset},
    { name = "世界boss次数", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.endlessWarChallenge },
    { name = "世界boss日结算", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.setWorldBossTime },
    { name = "世界boss周结算", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.setWorldBossTime },
    { name = "主线进度", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.main, showTips = "1-1"},
    { name = "困难主线进度", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMGameplay.multiMain, showTips = "1-1" },
    { name = "修改公会祝福积分", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.guildBossBuffPoint},
    { name = "公会boss跳关", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.guildBossLayer},
    { name = "增加公会boss次数", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMGameplay.challengeCount},
}

return UIGMGameplay

