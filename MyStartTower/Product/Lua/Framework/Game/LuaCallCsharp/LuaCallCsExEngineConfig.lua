


local tab = {}

function tab.GmOpen()
    return CS_LuaCallCs.EngineConfigGmOpen()
end

function tab.BattleLogOpen()
    return CS_LuaCallCs.EngineConfigBattleLogOpen()
end

LuaCallCs.EngineConfig = tab
