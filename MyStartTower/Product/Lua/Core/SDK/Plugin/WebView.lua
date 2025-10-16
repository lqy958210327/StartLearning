local WebView = {}
local DeviceHelper = require("Core/Helper/DeviceHelper")
local VersionUtils = require("Core/System/VersionUtils")
local SDKConst = require("Core/SDK/SDKConst")
local AttName = SDKConst.AttName
local WebViewAgent = Framework.Plugin.WebViewAgent

local WebViewEventType =
{
    ON_OPEN = 0,
    ON_CLOSE = 1, -- upload success
}

function WebView.setStrategy(newStrategyNo)
    WebViewAgent.SetStrategy(newStrategyNo or 0)
end

function WebView.init(strategyNo)
    local strategyNo = strategyNo or 0
    WebViewAgent.Init()
    WebViewAgent.SetLuaEventCallback(WebView.onGetEvent)
    WebView._closeCallback = nil
end

function WebView.openWebView(url, closeCallback, hasQuestionMark)
    if (IS_EDITOR or DeviceHelper.isWindows()) then
        -- UIBrowser，内嵌在GameObject的浏览器，目前只有PC版支持
        --UIManager.getUI("browserDlg", true):onShow(url);
    elseif RegionUtils.isJP() then
        local parameter = {}
        if CurAvatar then
            parameter["role_id"] = CurAvatar.uid
            parameter["server_id"] = SvrListManager.getSelectedSvrID()
        end
        local customerServiceData = {}
        customerServiceData[AttName.WEB_TITLE] = ""
        customerServiceData[AttName.WEB_CALLBACK ] = 0
        customerServiceData[AttName.WEB_URL] = ClientUtils.composeGetUrl(url, parameter, hasQuestionMark)
        customerServiceData[AttName.WEB_ORIENTATION] = 0
    else
        if url == nil then
            url = "about:blank"
        end
        WebView._closeCallback = closeCallback
        WebView.onOpen()
        WebViewAgent.OpenWebView(url)
    end
end

function WebView.closeWebView()
    WebViewAgent.CloseWebView()
end

function WebView.onOpen()
    -- if not DeviceHelper:isWindows() then
    --     UIManager.getUI("captureui"):capture()
    -- end
end

function WebView.onClose(isSucc)
    -- if not DeviceHelper:isWindows() then
    --     UIManager.getUI("captureui"):hide()
    -- end
    if nil ~= WebView._closeCallback then
        WebView._closeCallback()
        WebView._closeCallback = nil
    end
end

WebView._CSEventHandler = {
    [WebViewEventType.ON_CLOSE] = WebView.onClose,
}

function WebView.onGetEvent(eventType, ret, arg1)
    local func = WebView._CSEventHandler[eventType]
    if func then
        func(ret, arg1)
    end
end

-- WebView._funcUnityOpenUrl = nil
function WebView.unityOpenUrl(url)
    Framework.Tools.LuaToolkit.UnityOpenURL(url)
end

return WebView
