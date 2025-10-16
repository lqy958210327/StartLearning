
local tab = {}

function tab.SetQualityLevel(level)
    if type(level) == "number" then
        CS_LuaCallCs.GameQualitySetQualityLevel(level)
    else
        LuaCallCs.LogError("---   设置游戏画质失败：更换QualitySetting, level类型必须是number...", true)
    end
end

function tab.SetCameraProcessing(enable)
    if type(enable) == "boolean" then
        CS_LuaCallCs.GameQualitySetCameraProcessing(enable)
    else
        LuaCallCs.LogError("---   设置游戏画质失败：开关相机后期渲染，enable类型必须是boolean...", true)
    end
end

function tab.SetEfxLevel(level)
    if type(level) == "number" then
        CS_LuaCallCs.GameQualitySetEfxLevel(level)
    else
        LuaCallCs.LogError("---   设置游戏画质失败：更换特效分级, level类型必须是number...", true)
    end
end

function tab.SetFrameRate(value)
    if type(value) == "number" then
        CS_LuaCallCs.GameQualitySetFrameRate(value)
    else
        LuaCallCs.LogError("---   设置游戏画质失败：更换帧率, value类型必须是number...", true)
    end
end

LuaCallCs.GameQuality = tab
