local UIGMProgrammingTool = Class("UIGMProgrammingTool")

function UIGMProgrammingTool:SetDBData()
    ---@type GMDB
    local db = GameDB.GetDB(DBId.GM)
    self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBProgrammingTool)
    if not self.debugInfoList then
        db:SetGMData(GMEmun.GMDBProgrammingTool, ProgrammingToolFun)
        self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBProgrammingTool)
    end
    return self.debugInfoList
end

function UIGMProgrammingTool.configJumpTest(value)
    local jumpId = tonumber(value)
    ConfigJumpHelper.Jump(jumpId)
end

function UIGMProgrammingTool.openGuide()
    EventManager.Global.Dispatch(EventType.GuideSystemEnable, true)
end

function UIGMProgrammingTool.closeGuide()
    EventManager.Global.Dispatch(EventType.GuideSystemEnable, false)
end

function UIGMProgrammingTool.findInvalidUI()
    for k,v in pairs(DataTable.ResUIMap) do
        local temp =LuaCallCs.CheckLocationValid("Prefab/UI/"..v.prefab)
        if not temp then
            LuaCallCs.LogError("---   id = "..v.id.."   uiName = "..v.uiName.."   prefab = "..v.prefab)
        end
    end
end
function UIGMProgrammingTool.setLeagueBossMsg(value)
    if string.find(value, ":") then
        local args = string.split(value, ":")
        local indexId = tonumber(args[1])
        local layer = tonumber(args[2])
        local totalBuff = tonumber(args[3])
        local challengeCount = tonumber(args[4])
        local ProtoMap = require "Game/RPC/ProtoMap"
        ProtoMap.receiveHandlers.Imp.ResGuildBoss(indexId, nil, layer, nil, totalBuff, challengeCount)
    end
end

function UIGMProgrammingTool.setLeagueBossRankMsg(value)
    if string.find(value, ":") then
        local args = string.split(value, ":")
        local score = tonumber(args[1])
        local damage = tonumber(args[2])
        local myMember = LeagueHelper.GetMySelf()
        if myMember then
            myMember.buffScore = score
            myMember.bossDamage = damage
        end
    end
end

function UIGMProgrammingTool.setLeagueBossProgressRankMsg(value)
    local msg = {}
    if string.find(value, ":") then
        local args = string.split(value, ":")
        local guildId = tonumber(args[1])
        local layer = tonumber(args[2])
        local per = tonumber(args[3])
        ---@type SC_GuildRankDataInfo
        local data = {}
        data.layer = layer
        data.damagePercent = per
        data.guild = {}
        data.guild.leader = {}
        data.guild.brand = {}
        data.guild.leader.name = "GM会长"
        data.guild.brand.guildId = guildId
        data.guild.brand.name = "GM工会名字"
        data.guild.brand.flag = {2,2,2,2}
        msg = {data}
    end
    local ProtoMap = require "Game/RPC/ProtoMap"
    ProtoMap.receiveHandlers.Imp.ResRankData(nil, nil, nil, nil, nil, msg)
end

---@type table
ProgrammingToolFun = {
    { name = "新手引导开", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMProgrammingTool.openGuide },
    { name = "新手引导屏蔽", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMProgrammingTool.closeGuide },
    { name = "跳转配置测试", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMProgrammingTool.configJumpTest},
    { name = "输出无效的UI", btnType = GMBtnEmun.BTN_TYPE_BUTTON, func = UIGMProgrammingTool.findInvalidUI },
    { name = "工会boss测试数据", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMProgrammingTool.setLeagueBossMsg },
    { name = "工会boss排行榜测试数据", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMProgrammingTool.setLeagueBossRankMsg },
    { name = "工会boss进度排行榜测试数据", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMProgrammingTool.setLeagueBossProgressRankMsg },
}

return UIGMProgrammingTool

