require "Core/Common/OfflineApiInit"
--require "Core/Network/protobuf"
local ServerBattleReplay = require "Core/ServerBattle/ServerBattleReplay"

local function _initProtobufLib()
    local pbfiles = { 
        'roledata.pb'
        }
    for _, pbfile in pairs(pbfiles) do
        local bpfilename = "proto/"..pbfile
        local pbfhandle = io.open(bpfilename, "rb")
        local buffer = pbfhandle:read "*a"
        pbfhandle:close()
        protobuf.register(buffer)
    end
end

local function _relayReplayStart(ssmsg)
    local t = protobuf.decode("datap.BattleData", ssmsg, string.len(ssmsg))
    return ServerBattleReplay._realReplayStart(t)       -- 返回0 代表胜利结果一致  无异常
end

local function _onReplayResult(ssmsg)
    local t = protobuf.decode("datap.BattleData", ssmsg, string.len(ssmsg))
    return ServerBattleReplay._onReplayResult(t)      -- 返回0 代表胜利结果一致  无异常
end

GLDeclare("initProtobufLib", _initProtobufLib)
GLDeclare("relayReplayStart", _relayReplayStart)
GLDeclare("onReplayResult", _onReplayResult)

-- if jit then
--     jit.off()
--     jit.flush()
-- end