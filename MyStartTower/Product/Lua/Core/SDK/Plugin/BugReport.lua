local BugReport = {}
-- 先存在本地，以后把插件的key和id放一处统一管理
--local PluginConfig = require "Core/SDK/Plugin/PluginConfig"
--local BugReportAgent = Framework.Plugin.BugReportAgent
--local VersionUtils = require("Core/System/VersionUtils")

local INVALID_PARAM = "Unknown"

function BugReport.setStrategy(newStrategyNo)
    --BugReportAgent.SetStrategy(newStrategyNo or 0)
end

function BugReport.init(newStrategyNo)

end

function BugReport.setUserId(userId)
    --[[local _userId = tostring(userId) or INVALID_PARAM
    BugReportAgent.SetUserId(_userId)]]
end

function BugReport.setScene(sceneId)
    --[[local _sceneId = tonumber(sceneId) or 0
    BugReportAgent.SetScene(_sceneId)]]
end

function BugReport.configDebugMode(enable)
    --[[local _enable = enable == true
    BugReportAgent.ConfigDebugMode(_enable)]]
end

-- Type. Default=0, 1=Bugly v2.x MSDK=2
-- Log level. Off=0,Error=1,Warn=2,Info=3,Debug=4
function BugReport.configCrashReporter(type, logLevel)
    --[[local _type = tonumber(type) or 0
    local _logLevel = tonumber(logLevel) or 1
    BugReportAgent.ConfigCrashReporter(_type, _logLevel)]]
end

function BugReport.reportException(name, message, stackTrace)
    --[[local _name = tostring(name) or INVALID_PARAM
    local _message = tostring(message) or INVALID_PARAM
    local _stackTrace = tostring(stackTrace) or INVALID_PARAM
    BugReportAgent.ReportException(_name, _message, _stackTrace)]]
end

function BugReport.addSceneData(key, value)
    --BugReportAgent.AddSceneData(key, tostring(value))
end

return BugReport