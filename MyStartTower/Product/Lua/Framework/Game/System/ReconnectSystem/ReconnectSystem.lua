


local NetService = require("Core/Network/NetService")

---@class ReconnectSystem : SystemBase
ReconnectSystem = Class("ReconnectSystem", SystemBase)

function ReconnectSystem:OnInit()
    -- 老代码的写法，留着备份
    NetService.setReconnectNoticeCallback(self.__netDisconnectCB, self.__reconnectSuccessCB, self.__reconnectFailedCB)
end

function ReconnectSystem:OnClear()

end

function ReconnectSystem:OnGameStart()

end

function ReconnectSystem:OnGameEnd()

end


function ReconnectSystem:__netDisconnectCB()
    LuaCallCs.LogError("---   老代码：断线重连日志，断线...")
end

function ReconnectSystem:__reconnectSuccessCB()
    LuaCallCs.LogError("---   老代码：断线重连日志，重连成功...")
end

function ReconnectSystem:__reconnectFailedCB()
    Util.MsgBox.OpenShowInfo("断线重连失败")
    LuaCallCs.LogError("---   老代码：断线重连日志，重连失败...")
end


