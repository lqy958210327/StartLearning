-- 设备信息和设备的参数设置等相关内容放置在本文件中

local Screen = UnityEngine.Screen
local GameSettingHelper = Framework.Settings.GameSettingHelper
local LuaToolkit = Framework.Tools.LuaToolkit
local LoaderFactory = Framework.Resource.LoaderFactory
local ScreenUtils = CS.Externals.Native.ScreenUtils
local SystemInfo = UnityEngine.SystemInfo
local UIUtils = Framework.UI.UIUtils
local GameSettings = require("Core/Helper/GameSettings")
local DebugHelper = DebugHelper

local DeviceHelper = {}

-- 网络类型
-- 对应 UnityEngine.NetworkReachability
DeviceHelper.NET_NONE = 0
DeviceHelper.NET_DATA = 1
DeviceHelper.NET_WIFI = 2

DeviceHelper.PLATFORM_IOS = "iOS"
DeviceHelper.PLATFORM_ANDROID = "Android"
DeviceHelper.PLATFORM_WINDOWS = "Windows"
DeviceHelper.PLATFORM_MACOS = "MacOS"

-- 运行平台
DeviceHelper.runtimePlatform = GameSettingHelper.GetPlatformName()
-- 屏幕的宽度和高度
local origWidth, origHeight = GameSettings.getOrigResolution()
DeviceHelper.screenWidth = origWidth
DeviceHelper.screenHeight = origHeight
DeviceHelper.curWidth = Screen.width
DeviceHelper.curHeight = Screen.height

-- 系统内存
DeviceHelper.systemMemorySize = SystemInfo.systemMemorySize

function DeviceHelper._isLowMemoryDevice()
    local lowMemorySize = 2050  -- 默认小于2G的内存认为是低内存设备
    if DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS then
        lowMemorySize = 1025    -- iOS设备小于1G的内存认为是低内存设备
    end
    return (DeviceHelper.systemMemorySize < lowMemorySize)
end

--是否是低内存设备
DeviceHelper.IsLowMemoryDevice = DeviceHelper._isLowMemoryDevice()

--默认亮度
-- DeviceHelper.DefaultScreenBrightness = Framework.Plugin.NativeUtils.GetScreenBrightness()

-- 设备模型名称
DeviceHelper.deviceModel = SystemInfo.deviceModel
-- 快速判断是否是ipad的变量
DeviceHelper.isIPad = false
if DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS then
    DeviceHelper.isIPad = (string.match(DeviceHelper.deviceModel, "iPad") ~= nil)
end


-- 计算屏幕英寸大小，运行期间不会变化
function DeviceHelper._calsDiagonalInches()
    local dpi = Screen.dpi
    return math.sqrt(math.pow(DeviceHelper.screenWidth / dpi, 2) + math.pow(DeviceHelper.screenHeight / dpi, 2))
end
-- 设备屏幕英寸大小
DeviceHelper.diagonalInches = DeviceHelper._calsDiagonalInches()

-- 判断是否是平板
function DeviceHelper._isTablet()
    if DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS then
        -- 苹果设备标记为ipad的认为是平板
        return DeviceHelper.isIPad
    elseif DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_ANDROID then
        -- 安卓设备尺寸大于6.5的认为是平板
        return DeviceHelper.diagonalInches > 6.5
    end
    -- 默认设备是非平板
    return false
end
-- 是否是平板设备
DeviceHelper.isTablet = DeviceHelper._isTablet()

function DeviceHelper.setMsaa( msaaSample, quality )
    local needMsaa = msaaSample~=1

    DebugHelper.SetQualitySettingAntiAliasing(msaaSample)
    -- local needOpt = quality <= Const.GAME_QUALITY.Fast
    -- DebugHelper.SetModelStageMSAAOptimization(needMsaa and needOpt)
    -- DebugHelper.SetMainCameraMSAAOptimization(needMsaa and needOpt)

    CameraModeManager.setMSAA( msaaSample )
end

DeviceHelper.screenScale = 1
DeviceHelper.screenScaleT = {0.6,0.70,0.80,0.95}
function DeviceHelper._setResolution(w, h)
    w = math.floor(w*DeviceHelper.screenScale)
    h = math.floor(h*DeviceHelper.screenScale)
    GameSettings.setResolution(w, h)
    DeviceHelper.curWidth = w
    DeviceHelper.curHeight = h
    print ("[Info] Device resolution is set to ", w, h)
end

-- 设置设备渲染的分辨率
function DeviceHelper.setRenderResolution()
    -- 设置是否用高适配
    DeviceHelper.setUIMatchHeight()
    local screenWidth = DeviceHelper.screenWidth
    local screenHeight = DeviceHelper.screenHeight
    local resolutionLv = GameSettings.getCustomSetting("ResolutionLv")

    if DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS then
        local raduceRatio = 1
        -- 处理iOS平台，ios设备下iPad设备大版本号小于5的统一设置分辨率为(1024. 768)
        if DeviceHelper.isIPad then
            local model = DeviceHelper.deviceModel
            local commaIdx = string.find(model, ",")
            if commaIdx > 0 then
                local ver = tonumber(string.sub(model, 5, commaIdx - 1))
                if ver < 5 and resolutionLv <= 1 then
                    raduceRatio = 1.5
                end
            end
        elseif DeviceHelper.deviceModel == "iPhone7,1" then
            -- 对iPhone 6 Plus 降分辨率
            raduceRatio = 1.5
        end

        DeviceHelper._setResolution(screenWidth/raduceRatio, screenHeight/raduceRatio)
    elseif DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_ANDROID then
        -- 安卓平台，只有最低两档画质限制分辨率
        local designW, designH = screenWidth, screenHeight
        DeviceHelper.screenScale = DeviceHelper.screenScaleT[resolutionLv]

        if resolutionLv == 1 or designH * DeviceHelper.screenScale < 640 then
            designW, designH = 1136, 640
        end

        local screenRatio = screenWidth / screenHeight
        local designRatio = designW / designH
        if screenRatio > designRatio then
            designW =  screenRatio * designH
        elseif screenRatio < designRatio then
            designH = designW / screenRatio
        end
        -- 设计分辨率比设备分辨率大的话则使用设备分辨率
        if designW > screenWidth then
            designW = screenWidth
            designH = screenHeight
        end

        -- if resolutionLv==1 or resolutionLv==3 then
        --     DeviceHelper.screenScale = 0.75
        -- else
        --     DeviceHelper.screenScale = 1
        -- end

        -- 对于超过20:9的屏幕，强制拉伸
        local aspect = designW / designH
        local maxAspect = 20 / 9
        if maxAspect < aspect then
            designW = math.floor(designH * maxAspect)
        end

        DeviceHelper._setResolution(designW, designH)
    end
end

function DeviceHelper.setUIMatchHeight()
    local width = DeviceHelper.curWidth
    local height = DeviceHelper.curHeight
    if width and height then
        if width < height then
            width, height = height, width
        end
        local matchHeight = width/height > (16/9 + 0.01)
        UIUtils.SetMatchHeight(matchHeight)
    end
end

function DeviceHelper.isIOS()
    return DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS
end

function DeviceHelper.isAndroid()
    return DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_ANDROID
end

function DeviceHelper.isWindows()
    return DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_WINDOWS
end

function DeviceHelper.getDesignScreenRatio( ... )
    return GameSettingHelper.GetDesignScreenRatio()
end

-- function DeviceHelper.getNetworkType()
--     local networkType = LuaToolkit.GetNetworkType()
--     return networkType
-- end

function DeviceHelper.getNetworkTypeText(isEng)
    local networkType = LuaToolkit.GetNetworkType()
    local text = isEng and "NO" or "无"
    if networkType == DeviceHelper.NET_DATA then
        text = isEng and "DATA" or "流量"
    elseif networkType == DeviceHelper.NET_WIFI then
        text = "WIFI"
    end
    return text
end

------Loader Memory Control----------
function DeviceHelper.loaderDelayDisposeOn( level )
    LoaderFactory.LingerAddCache = level * 5
    LoaderFactory.LingerMaxTime = level * 60
end

function DeviceHelper.loaderDelayDisposeOff(  )
    LoaderFactory.LingerMaxTime = LoaderFactory.DefaultLingerTime
end

function DeviceHelper.onLowMemory(  )
    DeviceHelper.loaderDelayDisposeOff()
    DeviceHelper.setUICache(true)
    EffectCueMediator.changePoolCleanCount(30)
end

function DeviceHelper.initLoaderMemoryControl(  )
    local memoryLv = 1
    local memorySize = DeviceHelper.systemMemorySize
    if memorySize <2050 then  -- 小于2G都是低内存
        memoryLv = 1
    elseif memorySize < 3100 then -- 小于3G是普通
        memoryLv = 2
    else                        -- 高于3G是非常吊
        memoryLv = 3
    end
    if memoryLv==1 then
        -- 低内存设备
        DeviceHelper.loaderDelayDisposeOn(0)
        DeviceHelper.setUICache(true)
        EffectCueMediator.changePoolCleanCount( 10 )
    elseif memoryLv==2 then
        DeviceHelper.loaderDelayDisposeOn(1)
        DeviceHelper.setUICache(true)
        EffectCueMediator.changePoolCleanCount( 30 )
    else
        -- 高内存设备
        DeviceHelper.loaderDelayDisposeOn(2)
        DeviceHelper.setUICache(false)
        EffectCueMediator.changePoolCleanCount( 60 )
    end

    GameSettingHelper.RegisterLowMemoryCallback(DeviceHelper.onLowMemory)
end

function DeviceHelper.clearCallback()
    GameSettingHelper.RegisterLowMemoryCallback(nil)
end

--[[
DeviceHelper._shaderWarmUpCalled = false
function DeviceHelper.tryWarmUpShader()
    -- 防止多次调用
    if DeviceHelper._shaderWarmUpCalled then
        return
    end
    DeviceHelper._shaderWarmUpCalled = true
    -- 老版本在C#调用了WarmUp，在这里不做处理
    if VersionUtils.hasAbilityWarmUpShaderByLua() then
        if not (DeviceHelper.isIOS() and DeviceHelper.IsLowMemoryDevice) then
            LuaToolkit.WarmUpShader()
        end
    end
end

function DeviceHelper.cleanWarmUpedShader()
    if VersionUtils.hasAbilityWarmUpShaderByLua() then
        if not (DeviceHelper.isIOS() and DeviceHelper.IsLowMemoryDevice) then
            LuaToolkit.StopWarmUpShader()
            LuaToolkit.UnloadShaderWarmUp()
        end
    end
end
]]

function DeviceHelper.setUICache( inLowMemory )
    UIManager.setUICache(inLowMemory)
end

local _isiPhoneWithNotch = nil
DeviceHelper._debugiPhoneWithNotch = nil        -- 调试用
function DeviceHelper.isiPhoneWithNotch()
    if nil ~= DeviceHelper._debugiPhoneWithNotch then
        return DeviceHelper._debugiPhoneWithNotch
    end

    if nil == _isiPhoneWithNotch then
        _isiPhoneWithNotch = false
        if DeviceHelper.isIOS() then
            local unityNotch = ScreenUtils.GetUnityNotch()
            if 0.001 < unityNotch then
                _isiPhoneWithNotch = true
            end
        end
    end
    return _isiPhoneWithNotch
end

---- Unity GC -------------------------------------------------------
DeviceHelper.GC_PERIOD = 600
if SystemInfo.systemMemorySize < 4800 then
    DeviceHelper.GC_PERIOD = 300
end
function DeviceHelper._onGCTimer()
    Framework.Tools.LuaToolkit.UnityGC()
end

DeviceHelper._gcTimer = Timer.New(DeviceHelper._onGCTimer, DeviceHelper.GC_PERIOD, -1)

function DeviceHelper.resetGCTimer()
    if VersionUtils.hasAbilityUnityGC() then
        DeviceHelper._gcTimer:Restart()
    end
end

function DeviceHelper.forceGC()
    DeviceHelper._onGCTimer()
    DeviceHelper.resetGCTimer()
end

---- Unity GC -------------------------------------------------------



return DeviceHelper