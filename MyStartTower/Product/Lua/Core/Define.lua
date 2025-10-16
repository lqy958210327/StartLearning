-- 脚本层默认导入的文件和全局变量，放在这里的不需要在使用的时候提前require
-- 如果频繁使用的模块建议在使用之前用 local A = require("Core/module/A") 这种方式来变为临时变量

------------------- CS --------------------------
UnityEngine=CS.UnityEngine
Framework = CS.Framework
DebugHelper= Framework.DebugHelper

CameraManager = Framework.CameraSystem.CameraManager
CameraControllerNodeType = Framework.CameraSystem.CameraControllerNodeType
SceneLightManager = Framework.SceneSystem.SceneLightManager
SceneSettingsManager = Framework.SceneSystem.SceneSettingsManager


DynamicScene=CS.DynamicScene

Framework.Plugin={
    PermissionManager= Framework.Plugin.PermissionUtils,
    NativeHelper= Framework.Plugin.NativeUtils,
    CustomerServiceAgent=  Framework.Plugin.CustomerServiceAgent,
    DataAnalysisAgent=  Framework.Plugin.DataAnalysisAgent,
    BugReportAgent=Framework.Plugin.BugReportAgent,
    LocalNotificationAgent= Framework.Plugin.LocalNotificationAgent,
    PushNotificationAgent= Framework.Plugin.PushNotificationAgent,
    WebViewAgent=Framework.Plugin.WebViewAgent,
    GPMAgent=Framework.Plugin.GPMAgent,
    NativeUtils=Framework.Plugin.NativeUtils,
}

MaterialVideoPlayer = typeof(CS.Externals.Video.MaterialVideoPlayer)--typeof(Framework.UI.MaterialVideoPlayer)

tolua = {
    isnull = IsNull
}

-- Lua虚拟机初始化之后调用的逻辑，保证在其他所有Lua逻辑执行之前。
LuaToolkit = Framework.Tools.LuaToolkit
IS_PUBLISH_VERSION = LuaToolkit.IsPublishVersion()
SP_MARK = LuaToolkit.GetPatchSPMark()
IS_EDITOR = CS_LuaCallCs.IsEditor() -- 先不优化这个顺序
IS_ANDROID = LuaToolkit.IsAndroid()
IS_VERIFY_VERSION = false
POST_FIX = LuaToolkit.GetPatchPostfix()
IS_FORCE_INTRANET = true --LuaToolkit.IsForceIntranet()
NO_CSHARP = false
if not IS_EDITOR then
	function assert(condition, message)
        if not condition then
            print("Assertion failed: " .. (message or ""))
            -- return false
        end
        return condition
    end
end

if jit then
    if jit.opt then
        jit.opt.start(3)
    end
	if IS_EDITOR then
		jit.on()
	    print("jit on")
	else
    	jit.off()
	    print("jit off")
	end
    jit.flush()
    local blob = {}
    setmetatable(blob,{
        __index = function() return blob end,
        __lt = function() return false end,
            })
    LazyTable = function (...)
        local ok, ret = pcall(require, ...)
        return ok and ret or blob
    end
    DeleteTable = function(...)
        return {}
    end
    table.unpack = unpack
else
    unpack = table.unpack
    require("Config/LazyTable")
end

if IS_EDITOR then
    HOOK = {}
    HookFiles = {}
    local function setHook()
        debug.sethook(function (event, line)
            local path = debug.getinfo(2).source
            if string.find(path, "Res") then return end
            if string.sub(path, 1, 1) == '@' then
                if not HookFiles[path] then
                    HookFiles[path] = {}
                end
                HookFiles[path][line] = (HookFiles[path][line] or 0) + 1
            end
        end, "l")
    end
    HOOK.writeFilesToFile = function()
        local logfile = io.open("coverage/coverage/files_output.log", "w")

        if logfile then
            for path, lines in pairs(HookFiles) do
                logfile:write(path, "|")
                for line, num in pairs(lines) do
                    logfile:write(line, "-", num, ",")
                end
                logfile:write("\n")
                logfile:flush()
            end
            logfile:close()
            local result = os.execute("coverage\\coverage.exe")
            if result ~= 0 then
                print("Failed to execute coverage.exe")
            else
                local htmlFilePath = "coverage/coverage/index.html"  -- 假设生成的 HTML 文件路径
            local openBrowserCommand = string.format('start "" "%s"', htmlFilePath)
            os.execute(openBrowserCommand)
            end
        else
            print("Failed to open file for writing.")
        end
        debug.sethook(nil)
    end

    HOOK.setGameHook = function(enable)
        if enable then
            setHook()
        else
            debug.sethook(nil)
        end
    end

    HOOK.LoadGameHook = function()
        local logfile = io.open("coverage/coverage/files_output.log", "r")
        if logfile then
            for line in logfile:lines() do
                local path, lines = line:match("^@([^|]+)|(.+)$")
                if path and lines then
                    if not HookFiles[path] then
                        HookFiles[path] = {}
                    end
                    for linenum, num in lines:gmatch("(%d+)-(%d+),?") do
                        HookFiles[path][tonumber(linenum)] = tonumber(num)
                    end
                end
            end
            logfile:close()
        else
            print("Failed to open file for reading.")
        end
        setHook()
    end
end
------------------- Config --------------------------
require("Config/I18NTable")
require("Config/DataTable")
require("Config/AVGTable")
require("Config/EditorTable")
require("Config/ConstTable")

------------------- Profiler --------------------------
DebugProfiler = require("Core/Debug/DebugProfiler")

------------------- Core --------------------------
require("Core/Framework/Global")

Const = require("Core/Const")
utils = require("Core/Common/Tools/utils")
SensitiveCfg = require("Core/SensitiveCfg")
BaseObject = require("Core/Common/Object/BaseObject")

VersionUtils = require("Core/System/VersionUtils")
BattleConst = require("Core/Common/FrameBattle/BattleConst")

ConditionLimitManager = require("Core/System/ConditionLimitManager")

require("Core/UI/UIControls")
UIManager = require("Core/UI/UIManager")
MsgManager = require("Core/System/MsgManager")

GameFsm = require("Core/GameFsm/GameFsm")
CueManager = require("Core/System/CueManager")
ClientUtils = require("Core/System/ClientUtils")
ClientTimerManager = require("Core/System/ClientTimerManager")
SDKAgent = require("Core/SDK/SDKAgent")
SDKReportPlayer = require("Core/SDK/SDKReportPlayer")
ChannelDefine = require("Core/SDK/ChannelDefine")
NetEaseDefine = require("Core/SDK/NetEaseDefine")
SvrListManager = require("Core/System/SvrListManager")
TouchManager = require("Core/System/TouchManager")

HttpHelper = require("Core/Network/HttpHelper")
Analytics = require("Core/SDK/Analytics")
SimpleLoginTool = require("Game/UI/UISimpleLogin/SimpleLoginTool")

------------------- Utils --------------------------
BattleUtils = require("Core/Common/Utils/BattleUtils")
ModelUtils = require("Core/Common/Utils/ModelUtils")
TimeUtils = require("Core/Common/Utils/TimeUtils")
NumUtils = require("Core/Common/Utils/NumUtils")

------------------- Manager --------------------------
BattleManager = require("Core/System/BattleManager")
CameraModeManager = require("Core/System/CameraModeManager")
CustomShadowManager = require("Core/System/CustomShadowManager")
EventCenter = require("Core/Framework/EventCenter")
EventConst = require("Core/EventConst")

ProtoProcessor = require("Game/RPC/ProtoProcessor")
LibConApi = require("Game/RPC/LibConApi")
SendHandlers = require("Game/RPC/ProtoHandlers/SendHandlers")
OpenServerHelper = require("Core/Network/OpenServerHelper")
RequestDefine = require("Game/RPC/RequestDefine/RequestDefine")

------------------- UIMediator --------------------------
BattleUIMediator = require("Core/Logic/Battle/BattleUIMediator")
CueUIMediator = require("Core/System/CueUIMediator")
------------------- CueMediator --------------------------
AudioCueMediator = require("Core/System/AudioCueMediator")
EffectCueMediator = require("Core/System/EffectCueMediator")
------------------- LogicMediator --------------------------
CueLogicMediator = require("Core/System/CueLogicMediator")

------------------- Tools --------------------------
DataCore = require("Game/RPC/DataCore")
DataCoreTools = require("Game/RPC/DataCoreTools")


------------------- Avatar --------------------------
RPC = require("Core/Avatar/RPC")
Avatar = require("Core/Avatar/Avatar")

------------------- Activity ---------------------
MoneyConst = require("Config/ConstTable/MoneyConst")

------------------- Helper --------------------------
--ModelHelper = require("Game/Helper/ModelHelper")

------------------- UIView ---------------------------
UIViewConst = require("Game/UI/UIViewConst")
LightColor = 1
DarkColor = 0
