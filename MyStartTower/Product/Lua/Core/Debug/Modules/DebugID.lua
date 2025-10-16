local DebugConst = require "Core/Debug/DebugConst"
--local ChatService = require("Core/Network/ChatService")
local DebugModule = {}

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
function DebugModule.showID(sender, menu)
    _showID = not _showID

    AttachID(DataTable.ResItem,'name',_showID)
    AttachID(DataTable.ResHero,'full_name',_showID)
    AttachID(DataTable.ResHero,'hero_name',_showID)

    AttachID(DataTable.ResClientNotice,'notice',_showID)
    AttachID(DataTable.ResInfoNotice,'title',_showID)
    AttachID(DataTable.ResClientConfirm,'title',_showID)
    --AttachID(DataTable.ResArtifact,'name',_showID)

    IS_EDITOR_ID = _showID
    return _showID and "隐藏ID" or "显示ID"
end






--切换账号
function DebugModule.changeAccount()
    print("---   还没做这个接口...")
end
function DebugModule.SkipYuye(sender, menu, value)
    -- main关卡进度
    DebugModule.reqNamedGM('skipNightmareLevel:',value)
end
function DebugModule.SkipTrail(sender, menu, value)
    -- main关卡进度
    DebugModule.reqNamedGM('skipTrialLevel:',value)
end
function DebugModule.reqNamedGM(name, value)

    local split = utils.splitString(value, ":")
    local gm = nil
    if #split == 1 then
        gm = string.format('%s%d', name, split[1])
    elseif #split == 2 then
        gm = string.format('%s%d:%d', name, split[1], split[2])
    end

    DebugModule.reqGM(gm)
end
function DebugModule.reqGM(value)
    log("gm send to server:"..value)
    SendHandlers.ReqGmcmd(value)
end
function DebugModule.setWorldBossLevel(sender, menu, value)
    -- main关卡进度
    DebugModule.reqNamedGM('endlessWarLevel:',value)
end
function DebugModule.setWorldBossTime(sender, menu, value)
    -- main关卡进度
    DebugModule.reqNamedGM('endlessWarChallenge:',value)
end


function DebugModule.setGuildBossTime(sender, menu, value)
    DebugModule.reqNamedGM('setGuildBossTime:',value)
end

function DebugModule.addMainStoryEnergy(sender, menu, value)
    -- main关卡进度
    DebugModule.reqNamedGM('principalLineEnergy:',value)
end
function DebugModule.jumpID(sender, menu, value)
    -- main关卡进度
    ConfigJumpHelper.Jump(tonumber(value))
end

function DebugModule.JumpOdyssey()
    --进入奥德赛

end

function DebugModule.JumpRentTask()
    UIManager.getUI("UIRentTask",true)
end

function DebugModule.protectorPlan(sender, menu, value)
    SendHandlers.ReqGmcmd("protectorPlan:"..value)
end

function DebugModule.addChaffer(sender, menu, value)
    SendHandlers.ReqGmcmd("addChaffer:"..value)
end

function DebugModule.addBaseInfo()
    SendHandlers.ReqGmcmd("addBaseInfo:")
end

function DebugModule.setPlayerCreate(sender, menu, value)
    SendHandlers.ReqGmcmd("setplayercreate:"..value)
end

function DebugModule.addBattlePass(sender, menu, value)
    SendHandlers.ReqGmcmd("addBattlePass:"..value)
end

function DebugModule.setGuildBossInfo()
    SendHandlers.ReqGmcmd("setGuildBossInfo:")
end


function DebugModule.setGuildBossInput(sender, menu, value)
    SendHandlers.ReqGmcmd("setGuildBossInfo:"..value)
end

function DebugModule.MailsRewardSettlement(sender, menu, value)
    SendHandlers.ReqGmcmd("MailsRewardSettlement:"..value)
end

function DebugModule.setServerCommand(sender, menu, value)
    SendHandlers.ReqGmcmd(value)
end

function DebugModule.proPlayers()
    SendHandlers.ReqGmcmd("proPlayers")
end

function DebugModule.guideGifts()
    SendHandlers.ReqGmcmd("addItem100001:9999999")
    SendHandlers.ReqGmcmd("addItem100002:9999999")
    SendHandlers.ReqGmcmd("addItem500001:9999999")
    SendHandlers.ReqGmcmd("addItem500000:9999999")
    SendHandlers.ReqGmcmd("addHero22001:1")
    SendHandlers.ReqGmcmd("addHero25001:1")
end
DebugModule.ENTRY_NAME = "调试"
--功能列表
DebugModule.FUNC_MENU = {
    { name = "显示ID", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.showID },
    { name = "新手礼包", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.guideGifts },
    { name = "切换账号", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.changeAccount },
    { name = "绝望梦魇（层）", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.SkipYuye },
    { name = "试炼之境（关：层）", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.SkipTrail },
    { name = "世界boss（等级）", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.setWorldBossLevel },
    { name = "世界boss（次数）", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.setWorldBossTime },
    { name = "主线添加体力", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.addMainStoryEnergy },
    { name = "跳转界面id(跳转表id)", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.jumpID },
    { name = "圣地巡礼", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.JumpOdyssey },
    { name = "悬赏任务", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.JumpRentTask },
    { name = "守护者计划", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.protectorPlan },
    { name = "公会砍价次数", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.addChaffer },
    { name = "一键添加玩家资源", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.addBaseInfo },
    { name = "修改创角时间", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.setPlayerCreate },
    { name = "战令加经验", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.addBattlePass},
    { name = "公会boss（次数）", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.setGuildBossTime },
    --{ name = "公会宝箱", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.setGuildBossInfo },
    { name = "公会boss", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.setGuildBossInput },
    { name = "邮件结算奖励", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.MailsRewardSettlement },
    { name = "服务器命令", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.setServerCommand },
    { name = "顶级账号", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.proPlayers },
}

return DebugModule
