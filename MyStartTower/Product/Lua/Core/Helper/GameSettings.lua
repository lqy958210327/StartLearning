-- 游戏设置数据类，同时负责与c#通信

local GameSettingHelper = Framework.Settings.GameSettingHelper
local GameQualitySettings = Framework.Settings.GameQualitySettings
local UIUtils = Framework.UI.UIUtils
local AudioType = Framework.AudioSystem.AudioType
local SystemInfo = UnityEngine.SystemInfo
local NativeUtils = Framework.Plugin.NativeUtils
local ScreenUtils = CS.Externals.Native.ScreenUtils
local SettingConfig = ConstTable.SettingConfig
local QualityLevelByGpu = require("Core/Helper/GpuQualityLevel")
local UserData = require "Core/Helper/UserData"
local VersionUtils = require("Core/System/VersionUtils")
local ClientUtils = require("Core/System/ClientUtils")

local GameSettings = {}
local self = GameSettings

local GamePrefKeys = {
    -- SoundIsMute = "SoundIsMute",
    -- SoundVolume = "SoundVolume",
    BGMIsMute = "BGMIsMute",
    BGMVolume = "BGMVolume",
    SFXIsMute = "SFXIsMute",
    SFXVolume = "SFXVolume",
    VocalIsMute = "VocalIsMute",
    VocalVolume = "VocalVolume",
    GameQuality = "GameQuality",
    QualityNoticed = "QualityNoticed",
    VocalLanguage = "VocalLanguage",
    CustomQuality = "CustomQuality",
    BulletInBattle = "BulletInBattle",
    Cookie = "Cookie",
    ShowLamp = "ShowLamp",
}

-- just temp logic

-- init data
GameSettings.gameQuality = Const.GAME_QUALITY.MID
GameSettings.customQuality = false
-- GameSettings.soundVolume = 1.0
-- GameSettings.soundIsMute = false
GameSettings.bgmVolume = 1.0
GameSettings.bgmIsMute = false
GameSettings.sfxVolume = 1.0
GameSettings.sfxIsMute = false
GameSettings.vocalVolume = 1.0
GameSettings.vocalIsMute = false
GameSettings.bulletInBattle = false
GameSettings.cookie = true
GameSettings.showLamp = false




---------Init-------------------------
function GameSettings.initGameSettings(  )
    self._loadPreferences()
    self.setUIIndents()
end

function GameSettings._loadPreferences()
    -- 音乐
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.BGMIsMute) then
        self.bgmIsMute = LuaCallCs.PlayerPrefs.GetInt(GamePrefKeys.BGMIsMute) ~= 0 and true or false
    end
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.BGMVolume) then
        self.bgmVolume = LuaCallCs.PlayerPrefs.GetFloat(GamePrefKeys.BGMVolume)
    end
    self._realSetSoundVolume(Const.VOLUME_TYPE_MUSIC, self.bgmVolume, self.bgmIsMute)

    -- 音效
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.SFXIsMute) then
        self.sfxIsMute = LuaCallCs.PlayerPrefs.GetInt(GamePrefKeys.SFXIsMute) ~= 0 and true or false
    end
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.SFXVolume) then
        self.sfxVolume = LuaCallCs.PlayerPrefs.GetFloat(GamePrefKeys.SFXVolume)
    end
    self._realSetSoundVolume(Const.VOLUME_TYPE_SFX, self.sfxVolume, self.sfxIsMute)

    -- 语音
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.VocalIsMute) then
        self.vocalIsMute = LuaCallCs.PlayerPrefs.GetInt(GamePrefKeys.VocalIsMute) ~= 0 and true or false
    end
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.VocalVolume) then
        self.vocalVolume = LuaCallCs.PlayerPrefs.GetFloat(GamePrefKeys.VocalVolume)
    end
    self._realSetSoundVolume(Const.VOLUME_TYPE_VOCAL, self.vocalVolume, self.vocalIsMute)

    -- 语音语言切换
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.VocalLanguage) then
        self.vocalLang = LuaCallCs.PlayerPrefs.GetString(GamePrefKeys.VocalLanguage)
    else
        self.vocalLang = Const.CV_TYPE_STRING[Const.CV_LIST[1]]
    end
    self._realSetVocalLang(self.vocalLang)

    -- 画质
    if not self.gameQualityProposed then
        self.gameQualityProposed = self._proposeQualityLevel()
    end
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.GameQuality) then
        self.gameQuality = LuaCallCs.PlayerPrefs.GetInt(GamePrefKeys.GameQuality)
    else
        self.gameQuality = self.gameQualityProposed
    end
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.CustomQuality) then
        self.customQuality = LuaCallCs.PlayerPrefs.GetInt(GamePrefKeys.CustomQuality) ~= 0 and true or false
    else
        self.customQuality = false
    end

    self.gameQuality = Const.GAME_QUALITY.High

    -- 画质提醒
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.QualityNoticed) then
        self.qualityAlreadyNoticed = true
    end

    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.BulletInBattle) then
        self.bulletInBattle = LuaCallCs.PlayerPrefs.GetInt(GamePrefKeys.BulletInBattle) ~= 0 and true or false
    end

    -- cookie
    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.Cookie) then
        self.cookie = LuaCallCs.PlayerPrefs.GetInt(GamePrefKeys.Cookie) ~= 0 and true or false
    end

    if LuaCallCs.PlayerPrefs.HasKey(GamePrefKeys.ShowLamp) then
        self.showLamp = LuaCallCs.PlayerPrefs.GetInt(GamePrefKeys.ShowLamp) ~= 0 and true or false
    end
end



-----------Public-------------------------
-- 音乐
function GameSettings.setBGMVolume(vol)
    self.bgmVolume = vol
    self._realSetSoundVolume(Const.VOLUME_TYPE_MUSIC, vol, self.bgmIsMute)
end

function GameSettings.setBGMMute( isMute )
    self.bgmIsMute = isMute
    self._realSetSoundVolume(Const.VOLUME_TYPE_MUSIC, self.bgmVolume, isMute )
end

function GameSettings.getBGMVolume()
    return self.bgmVolume, self.bgmIsMute
end

-- 音效
function GameSettings.setSFXVolume(vol)
    self.sfxVolume = vol
    self._realSetSoundVolume(Const.VOLUME_TYPE_SFX, vol, self.sfxIsMute)
end

function GameSettings.setSFXMute( isMute )
    self.sfxIsMute = isMute
    self._realSetSoundVolume(Const.VOLUME_TYPE_SFX, self.sfxVolume, isMute )
end

function GameSettings.getSFXVolume()
    return self.sfxVolume, self.sfxIsMute
end

-- 语音
function GameSettings.setVocalVolume(vol)
    self.vocalVolume = vol
    self._realSetSoundVolume(Const.VOLUME_TYPE_VOCAL, vol, self.vocalIsMute)
end

function GameSettings.setVocalMute( isMute )
    self.vocalIsMute = isMute
    self._realSetSoundVolume(Const.VOLUME_TYPE_VOCAL, self.vocalVolume, isMute )
end

function GameSettings.getVocalVolume()
    return self.vocalVolume, self.vocalIsMute
end

function GameSettings.setVocalLanguage( langStr )
    self.vocalLang = langStr
    self._realSetVocalLang(langStr)
end

function GameSettings.getVocalLanguage(  )
    return self.vocalLang
end

-- 外部使用语音的接口
function GameSettings.isAllVoiceClosed()    -- 是否全部静音了
    return self.bgmIsMute and self.sfxIsMute and self.vocalIsMute
end



function GameSettings.revertVoiceSetting()  -- 根据设置刷新一遍
    self.setBGMMute(self.bgmIsMute)
    self.setSFXMute(self.sfxIsMute)
    self.setVocalMute(self.vocalIsMute)
end

---- Quality
--function GameSettings.setGameQuality(level)
--    -- 这里暂时保留当作备份，如果效果出了问题可以复查一下   --2025.10.13
--
--    --self.gameQuality = level     -- 这个gameQuality只能是预设的四个画质
--    --
--    --level = level < 1 and 1 or level
--    --
--    --self.setQualityFlag(level)
--    --
--    --self.initCustomSettings(self.customQuality, level)
--    --GameSettingHelper.SetGameQuality(level)
--end



function GameSettings.isLowQuality(  )
    return self.gameQuality <= Const.GAME_QUALITY.Fast
end




function GameSettings.setUIIndents()
    local indent = nil
    -- 如果有自定义走自定义缩进
    local customIndent = tonumber(UserData.loadCommonData(Const.UD_KEY_NOTCH_ADAPT))
    if customIndent then
        indent = customIndent
    else
        -- 暂时只用Unity获取是刘海数据，直到接入SDK相关逻辑再考虑开启，
        indent = ScreenUtils.GetUnityNotch()
        --[[
        local unityNotch = ScreenUtils.GetUnityNotch()
        if 0.001 < unityNotch then
            indent = unityNotch
            -- Unity可以检测到刘海，已在C#层处理，这里不做处理
        else
            -- 如果获Unity取不到刘海，尝试用NativeUtils来获取
            ScreenUtils.GetNativeNotchFullScreen(GameSettings._setNotch)
        end
        ]]
    end
    -- 如果没检测到刘海屏，且分辨率宽于预设的比例(16:9)，缩进一点，以解决很多圆角屏幕的问题
    local DeviceHelper = require("Core/Helper/DeviceHelper")
    if DeviceHelper.isAndroid() and (nil == indent or indent < 0.001) then
        local screenWidth = DeviceHelper.screenWidth
        local screenHeight = DeviceHelper.screenHeight
        print(" screenWidth / screenHeight:",  screenWidth, screenHeight)
        if 17 / 9 <= screenWidth / screenHeight then    -- 比16:9大，暂用17:9
            indent = 0.025
        end
    end
    GameSettings._setNotch(indent)
end

function GameSettings.clearCallback()
    ScreenUtils.ClearNotchCallback()
end

function GameSettings._setNotch(indent)
    if indent and 0 < indent then
        self._indent = indent
        UIUtils.SetAdaptConfig(indent)
    end
end

-- helper



function GameSettings.setResolution(width, height)
    GameSettingHelper.SetResolution(width, height)
end

function GameSettings.getOrigResolution()
    local platform = GameSettingHelper.GetPlatformName()
    if platform == "Android" then
        if not self.gameQualityProposed then
            self.gameQualityProposed = self._proposeQualityLevel()
        end
        if self.gameQualityProposed >= Const.GAME_QUALITY.Mid then
            local width, height, density = GameSettings.getScreenRealMetrics()
            if density then
                -- mumu直接修正到1080
                local model = string.lower(SystemInfo.deviceModel)
                if string.find(model, "mumu") then
                    if height <= 720 then
                        return 1920, 1080
                    else
                        return width, height
                    end
                end

                -- 各路狗比厂商开始做游戏优化模式，粗暴的降低分辨率，这里给修复回来
                if density<=2 and height <= 720 then
                    -- 大部分厂商是从1080P+的分辨率直接降到720P，后续有变化再迭代这里
                    return math.floor(width * 1.35), math.floor(height * 1.35) -- 1.5*0.9
                end
            end
        end
    end
    local resolution = GameSettingHelper.GetOrigResolution()
    return resolution.width, resolution.height
end

function GameSettings.getScreenRealMetrics()
    local str = NativeUtils.GetScreenRealMetrics()
    if str then
        local metrics = ClientUtils.string2Table(str)
        if metrics["widthPixels"] and metrics["heightPixels"] and metrics["density"] then
            return metrics["widthPixels"], metrics["heightPixels"], metrics["density"]
        end
    end
    return nil
end




----------Private----------------------
-- 设置游戏总体音量，是使用AudioListener.volume来控制听到的音量
function GameSettings._realSetSoundVolume(volumeType, vol, isMute )
    -- GameSettingHelper.SetSoundVolume(not isMute and vol or 0)

    -- set baseVolume in AudioManager
    if volumeType == Const.VOLUME_TYPE_SFX then
        AudioCueMediator.changeSettingVolume( AudioType.SFX, not isMute and vol or 0 )
        AudioCueMediator.changeSettingVolume( AudioType.UISfx, not isMute and vol or 0 )
    elseif volumeType == Const.VOLUME_TYPE_MUSIC then
        AudioCueMediator.changeSettingVolume( AudioType.Music, not isMute and vol or 0 )
        AudioCueMediator.changeSettingVolume( AudioType.Noise, not isMute and vol or 0 )
    elseif volumeType == Const.VOLUME_TYPE_VOCAL then
        AudioCueMediator.changeSettingVolume( AudioType.Vocal, not isMute and vol or 0 )
    end
end

function GameSettings._realSetVocalLang( langStr )
    AudioCueMediator.setVocalLanguage(langStr)
end

function GameSettings._proposeQualityLevel()
    local platform = GameSettingHelper.GetPlatformName()
    if platform ~= "iOS" and platform ~= "Android" then
        return Const.GAME_QUALITY.Mid
    end

    local gpuName = SystemInfo.graphicsDeviceName
    if platform == "iOS" then
        return GameSettings._proposeIOSQualityLevel()
    end
    print(string.format("proposeQualityLevel device gpuName %s", gpuName))
    for i, info in ipairs(QualityLevelByGpu) do
        if string.find(gpuName, info[1], 1, true) ~= nil then
            print(string.format("proposeQualityLevel choose level %s", info[2]))
            return info[2]
        end
    end
    return Const.GAME_QUALITY.Mid
end

-- iOS设备的设置，ref：https://support.hockeyapp.net/kb/client-integration-ios-mac-os-x-tvos/ios-device-types
function GameSettings._proposeIOSQualityLevel()
    local targetLV = Const.GAME_QUALITY.Mid
    local dModel = SystemInfo.deviceModel
    local commaIdx = string.find(dModel, ",")
    if commaIdx ~= nil then
        if string.match(dModel, "iPad") ~= nil then
            local ver = tonumber(string.sub(dModel, 5, commaIdx - 1))
            if ver > 5 then
                targetLV = Const.GAME_QUALITY.High
            end
        elseif string.match(dModel, "iPhone") ~= nil then
            local ver = tonumber(string.sub(dModel, 7, commaIdx - 1))
            if ver > 8 then
                targetLV = Const.GAME_QUALITY.High
            end
        end
    end
    -- 1G设备额外调整
    local memorySize = UnityEngine.SystemInfo.systemMemorySize
    if memorySize < 1025 then
        targetLV = Const.GAME_QUALITY.Fast
    end

    logerror(string.format("proposeiOSQualityLevel device model %s, quality setting %d", dModel, targetLV))
    return targetLV
end



-- 设置逻辑用的ShadowDistance
-- 逻辑的分为Stable和Changeable，Changeable只在没有Stable的时候才生效
function GameSettings.setShadowDistance( v, usage )
    GameSettingHelper.SetLogicShadowDistance(v, usage)
end

function GameSettings.resetShadowDistance( usage )
    GameSettingHelper.ResetLogicShadowDistance(usage)
end

-- 强行设置影子距离
function GameSettings._realSetShadowDistance( v )
    GameSettingHelper.SetShadowDistance(v)
end

function GameSettings._realResetShadowDistance( ... )
    GameSettingHelper.ResetShadowDistance()
end

-------------------GameQualitySetting--------------------------
GameSettings.QUALITY_MAP = { -- 小于此值则使用Low版本(使用Low即是全程不low，使用Artist即是全程low)
    ["CharacterPBR"]    = {Const.GAME_QUALITY.Low, "LowCharacterPBR" },
    ["GlobalShaderLOD"] = {Const.GAME_QUALITY.Fast, "LowGlobalShaderLOD" },
    ["HDR"]             = {Const.GAME_QUALITY.Low, "LowHDR"},
    ["Shadow"]          = {Const.GAME_QUALITY.Mid, "LowShadow"},
    ["BlurImage"]       = {Const.GAME_QUALITY.Mid, "LowBlurImage"},
    ["UnionTexture"]    = {Const.GAME_QUALITY.Mid, "LowUnionTexture"},
    ["Reflection"]      = {Const.GAME_QUALITY.Mid, "LowReflection"},

    ["PostProcess"]     = {Const.GAME_QUALITY.Low, "LowPostProcess"},
    ["Tonemapping"]     = {Const.GAME_QUALITY.Low, "LowTonemapping"},
    ["Vignette"]        = {Const.GAME_QUALITY.Fast, "LowVignette"},
    ["Bloom"]           = {Const.GAME_QUALITY.Low, "LowBloom"},
    ["Dof"]             = {Const.GAME_QUALITY.High, "LowDof"},
    ["AO"]              = {Const.GAME_QUALITY.High, "LowAO"},
    ["AA"]              = {Const.GAME_QUALITY.Artist, "LowAA"},
}
if VersionUtils.hasAbilityQualitySettingsV1( ) then
    GameSettings.QUALITY_MAP["Flare"] = {Const.GAME_QUALITY.Artist, "LowFlare"}
    GameSettings.QUALITY_MAP["HeightFog"] = {Const.GAME_QUALITY.Artist, "LowHeightFog"}
    GameSettings.QUALITY_MAP["SoftMask"] = {Const.GAME_QUALITY.Mid, "LowSoftMask"}
end

function GameSettings.setQualityFlag(curQuality, flags)
    local flagTable = {}
    if curQuality ~= nil then
        for k, mapInfo in pairs(GameSettings.QUALITY_MAP) do
            flagTable[mapInfo[2]] = (curQuality < mapInfo[1])
        end
    end
    if flags ~= nil then
        for k, v in pairs(flags) do
            flagTable[k] = v
        end
    end
    if table.count(flagTable) < 1 then
        return
    end
    local flagJson = ClientUtils.table2String(flagTable)
    GameQualitySettings.SetQualityFlag(flagJson)
end



GameSettings.CUSTOM_SETTINGS = {
    -- setting           存储类型   各画质下的默认值           设置函数
    ["HighFramerate"] = {"bool", {false, false, false, false}, "setHighFramerate", },
    ["ResolutionLv"]  = {"int",  {1, 2, 3, 4},                 "setResolutionLv",  },
    -- ["ShadowEnable"]  = {"bool", {false, false, true, true},   "setShadowEnable",  },
    ["MSAAEnable"]    = {"int",  {1, 1, 1, 1},                 "setMSAAEnable",    },
    -- 默认开启2倍抗锯齿
    --["MSAAEnable"]    = {"int",  {2, 2, 2, 2},                 "setMSAAEnable",    },
    ["BloomLv"] = { "int", { 1, 2, 3, 4 }, "setBloomLv", },
}



function GameSettings.initCustomSettings( isCustom, quality )
    local customSettings = GameSettings.CUSTOM_SETTINGS
    if isCustom then
        for settingName, info in pairs(customSettings) do
            if info[1] == "bool" then
                self[settingName] = LuaCallCs.PlayerPrefs.GetInt(settingName) ~= 0 and true or false
            else
                self[settingName] = LuaCallCs.PlayerPrefs.GetInt(settingName, 1)
            end
            self._realSetCustomSetting(settingName, self[settingName], true)
        end
    else
        for settingName,_ in pairs(customSettings) do
            self[settingName] = self.getCustomSettingDefault( settingName, quality )
            self._realSetCustomSetting(settingName, self[settingName], true)
        end
    end
end

function GameSettings.saveCustomPreferences(  )
    for settingName, info in pairs(GameSettings.CUSTOM_SETTINGS) do
        if info[1] == "bool" then
            LuaCallCs.PlayerPrefs.SetInt(settingName, self[settingName] and 1 or 0)
        else
            LuaCallCs.PlayerPrefs.SetInt(settingName, self[settingName])
        end
    end
end

function GameSettings.getCustomSettingDefault( settingName, quality )
    local info = GameSettings.CUSTOM_SETTINGS[settingName]
    if info and info[2] then
        return info[2][quality+1]
    end
end

-- 给设置界面调用的接口
function GameSettings.setCustomSetting( name, value )
    self[name] = value
    self._realSetCustomSetting( name, value )
end
function GameSettings.getCustomSetting( name )
    return self[name]
end

-- 真正修改的接口
function GameSettings._realSetCustomSetting( name, value, changeLater )
    local info = GameSettings.CUSTOM_SETTINGS[name]
    if info and info[3] and self[info[3]] then
        return self[info[3]](value, changeLater)
    end
end

function GameSettings.setHighFramerate( fps )
    local value = (fps == 1) and 45 or 30
    GameSettingHelper.SetTargetFrameRate(value)
end
function GameSettings.setResolutionLv( lv, changeLater )
    local DeviceHelper = require("Core/Helper/DeviceHelper")
    DeviceHelper.setRenderResolution()
end



GameSettings.msaaSample = 1
function GameSettings.setMSAALv( lv, changeLater )
    if lv==1 then
        self.msaaSample = 1
    elseif lv == 2 then
        self.msaaSample = 2
    elseif lv == 3 then
        self.msaaSample = 4
    end
    local DeviceHelper = require("Core/Helper/DeviceHelper")
    DeviceHelper.setMsaa(self.msaaSample, self.gameQuality)
end

local bloomPyramidSizeLevelValue = { 0, 1, 2, 3 }
local bloomBufferRateLevelValue = { 0, 8, 4, 4 }
function GameSettings.setBloomLv(lv, changeLater)
    GameSettingHelper.SetBloomPyramidSize(bloomPyramidSizeLevelValue[lv])
    GameSettingHelper.SetBloomBufferRate(bloomBufferRateLevelValue[lv])
end

return GameSettings