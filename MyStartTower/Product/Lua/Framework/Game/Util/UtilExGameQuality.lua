

local __prefKeyQualityLevel = "__prefKeyQualityLevel"
local __prefKeyIsUltraFps = "__prefKeyIsUltraFps"
local __prefKeyIsCameraProcessing = "__prefKeyIsCameraProcessing"

local __qualityLevel = {
    Low = 0,
    Mid = 1,
    High = 2,
    Ultra = 3,
}
local __efxLevel = {
    None = 0,
    Low = 1,
    Medium = 2,
    High = 3,
    Ultra = 4,
}
-- 游戏画质的处理太简单，不额外做数据管理器了



-- 画质接口
local tab = {}

function tab.InitGameQuality()
    local level = Util.GameQuality.GetGameQuality()
    Util.GameQuality.SetGameQuality(level)
end

---@param level GameQualityLevel
function tab.SetGameQuality(level)
    local qualityLevel = __qualityLevel.Low
    local efxLevel = __efxLevel.Low
    local camera = false
    if level == GameQualityLevel.Mid then
        qualityLevel = __qualityLevel.Mid
        efxLevel = __efxLevel.Medium
        camera = true
    elseif level == GameQualityLevel.High then
        qualityLevel = __qualityLevel.High
        efxLevel = __efxLevel.High
        camera = true
    elseif level == GameQualityLevel.Ultra then
        qualityLevel = __qualityLevel.Ultra
        efxLevel = __efxLevel.Ultra
        camera = true
    end
    LuaCallCs.GameQuality.SetQualityLevel(qualityLevel)
    LuaCallCs.GameQuality.SetEfxLevel(efxLevel)
    Util.GameQuality.SetCameraProcessing(camera)


    LuaCallCs.PlayerPrefs.SetInt(__prefKeyQualityLevel, level)
end

---@return GameQualityLevel
function tab.GetGameQuality()
    -- 根据GPU精准控制画质的话参考oc的老配置 QualityLevelByGpu
    return LuaCallCs.PlayerPrefs.GetInt(__prefKeyQualityLevel, GameQualityLevel.High)
end

---@param enable boolean
function tab.SetCameraProcessing(enable)
    LuaCallCs.GameQuality.SetCameraProcessing(enable)
    LuaCallCs.PlayerPrefs.SetInt(__prefKeyIsCameraProcessing, enable and 1 or 0)
end

---@return boolean
function tab.GetCameraProcessing()
    local value = LuaCallCs.PlayerPrefs.GetInt(__prefKeyIsCameraProcessing)
    return value == 1
end

---@param isUltra boolean
function tab.SetUltraFps(isUltra)
    local value = (isUltra) and 45 or 30
    LuaCallCs.GameQuality.SetFrameRate(value)
    LuaCallCs.PlayerPrefs.SetInt(__prefKeyIsUltraFps, isUltra and 1 or 0)
end

---@return boolean
function tab.GetUltraFps()
    local value = LuaCallCs.PlayerPrefs.GetInt(__prefKeyIsUltraFps)
    return value == 1
end

Util.GameQuality = tab
