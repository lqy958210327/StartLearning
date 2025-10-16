local DebugConst = require("Core/Debug/DebugConst")

local DebugModule = {}

--入口中文描述
DebugModule.ENTRY_NAME = "程序自主测试"

function DebugModule._onGetToken(token)
    token = token or "nil"
    MsgManager.notice("token:" .. token)
end


function DebugModule.openRandomSeed()
    Const.openRandomSeed = true
end

function DebugModule.deleteRedisDatabase(sender, menu, value)
    DebugModule.reqNamedGM('deleteRedisDatabase:',value)
end

function DebugModule.refreshRedPoint(sender, menu, value)
    if string.find(value, "-") then
        local args = string.split(value, "-")
        local key1, key2
        key1 = args[1]
        key2 = (args[2] == "1") and true or false
        Util.RedPoint.UpdateRedPoint(key1, key2)
    end
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


function DebugModule.doScript(sender, menu, value)
    local f = loadstring(value)
    f()
end

--功能列表
DebugModule.FUNC_MENU = {
    {name = "开启战斗随机种子监控",typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.openRandomSeed},
    { name = "清库", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.deleteRedisDatabase},
    { name = "强刷红点", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.refreshRedPoint },
}

return DebugModule

