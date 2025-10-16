
local tab = {}

function tab.ChangeStageBackGround(go, texturePath)
    CS_LuaCallCs.ChangeBackGround(go, texturePath)
end

function tab.EnableStageBackGround(go, isEnable)
    CS_LuaCallCs.EnableBackGround(go, isEnable)
end


LuaCallCs.Scenic = tab