local SDKHandler = Framework.SDK.SDKHandler

local UrlConst = require("Core/Network/UrlConst")
local Base64 = require("Core/Common/Tools/Base64")
local LanguageConst = require("Game/Logic/LanguageConst")
local SDKConst = require("Core/SDK/SDKConst")

local EventType = SDKConst.EventType
local LanguageAtt = SDKConst.LanguageAtt
local PharosConst = SDKConst.PharosConst

local SDKAgent = {}
local self = SDKAgent
SDKAgent.lastRechargeTime = 0
SDKAgent.isPaying = false --是否正在支付
--货币代码
SDKAgent.CurrencyCode = ""
--支付渠道
SDKAgent.PayChannel = ""
SDKAgent.productList = {}

function SDKAgent.onGameStart()
    SDKHandler.SetLuaEventCallback(SDKAgent.onGetSDKEvent)

    SDKAgent.init()
    Analytics.init()
    SimpleLoginTool.init()
end

function SDKAgent.onGameStop()
    SDKAgent.isPaying = false
    SDKHandler.SetLuaEventCallback(nil)
end

function SDKAgent.init()
    SDKAgent.isPaying = false
    self._newAccount = false
    SDKAgent._userCallbackDict = {}

    SDKAgent.acSdkInited = nil
    self._sauthJson = nil
    self._logSdkBaseInfoJson = {}
    self._language = nil

    self.protocolCode = -1

    -- 设置 初始化用户协议URL 用心中心语言
    if SDKAgent.isNetEaseChannel() then
        SDKAgent.setCompactUrl(RegionUtils.curLanguage)
        SDKAgent.setLanguage(RegionUtils.curLanguage)
         --使用测试支付开关,ios在构建的时候用宏定义处理了

    end
end

function SDKAgent.login()
    print("---   SDKAgent.login()")
    SDKAgent.isPaying = false
    SDKHandler.Login()
end

function SDKAgent.loginSuccess()
    SDKHandler.LoginSuccess()
end

function SDKAgent.loginFinish()
    SDKHandler.LoginFinish()
end

function SDKAgent.logout(callback)
    SDKHandler.Logout()
    SDKAgent.isPaying = false
end



------------------------------- 网易UniSDK ---------------------
function SDKAgent.getChannelId()
    local channelId = SDKHandler.GetChannelId()
    -- print("channelId = ", channelId)
    return channelId
end

function SDKAgent.getAccountType()
    return SDKHandler.GetAccountType()
end

function SDKAgent.getChannel()

    local channelId = SDKAgent.getChannelId()
    if not SDKAgent.isChannelLogin() then
        channelId = ChannelDefine.Channel_Development
    end

    local channelName = ChannelDefine.ChannelDic[channelId]
    -- print("channelName = ", channelName)
    if channelName then
        return channelName
    end
end

function SDKAgent.getAccid()

    if not SDKAgent.isChannelLogin() then
        return SimpleLoginTool.GetAccid()
    end

    return SDKAgent.userName or ""
end

function SDKAgent.getValueByKey(key)
    if not SDKAgent.isChannelLogin() then
        return ""
    end
    local channelId = SDKAgent.getChannelId()
    if channelId == ChannelDefine.Channel_Netease then
        local sJson = SDKAgent.getSauthJson()
        if not sJson then
            return ""
        end
        local sauthTable = ClientUtils.string2Table(sJson)
        return sauthTable[key]
    end
end

function SDKAgent.getCountryCode()
    if not SDKAgent.isChannelLogin() then
        return ""
    end
    local channelId = SDKAgent.getChannelId()
    if channelId == ChannelDefine.Channel_Netease then
        local sJson = SDKAgent.getSauthJson()
        if not sJson then
            return ""
        end
        local sauthTable = ClientUtils.string2Table(sJson)
        return sauthTable.country_code
    end
end

function SDKAgent.getLoginSdkStr()

    if not SDKAgent.isChannelLogin() then
        return ""
    end

    local channelId = SDKAgent.getChannelId()
    if channelId == ChannelDefine.Channel_Netease then
        local sJson = SDKAgent.getSauthJson()
        if not sJson then
            return ""
        end

        local baseInfo = Base64.enc(sJson)
        print("sJson =")
        string.multiprint(sJson)
        print("baseInfo =")
        string.multiprint(baseInfo)
        return baseInfo
    end

    return ""
end

function SDKAgent.isChannelLogin()
    return SDKHandler.IsUnityPackage()
end

function SDKAgent.IsDisableLogin()
    return SDKHandler.IsDisableLogin();
end

function SDKAgent.isNetEaseChannel()
    local channelId = SDKAgent.getChannelId()
    return channelId == ChannelDefine.Channel_Netease
end

function SDKAgent.setSauthJson(data)
    print("SDKAgent.setSauthJson= ", data)
    self._sauthJson = data
end

function SDKAgent.getSauthJson()
    print("SDKAgent.getSauthJson= ", self._sauthJson)
    return self._sauthJson
end

function SDKAgent.setLogSdkBaseInfoJson(data)
    print("SDKAgent.setLogSdkBaseInfoJson1 =", data)
    data = data["sdkJson"]
    self._logSdkBaseInfoJson = data
end

function SDKAgent.getLogSdkBaseInfoJson()
    print("SDKAgent.getLogSdkBaseInfoJson= ", self._logSdkBaseInfoJson)
    return self._logSdkBaseInfoJson
end

function SDKAgent.sendUnisdkLoginJson(data)
    data = ClientUtils.table2String(data)
    -- print("SDKAgent.sendUnisdkLoginJson =", data)
    SDKHandler.SendUnisdkLoginJson(data)
end

function SDKAgent.questionnaire()
    SDKHandler.Questionnaire(NetEaseDefine.QUESTIONNAIRE_URL)
end

--打开webview,是否小窗口模式，小窗口模式不影响游戏生命周期（问卷需要小窗口模式），问卷默认有关闭不需要设置
function SDKAgent.openQuestionnaire(url,isFloatView,isFullView,isShowCloseBtn)
    --小窗口模式
    if isFloatView then
        url = url..'#'..1
    else
        url = url..'#'..0
    end
    --全屏模式
    if isFullView then
        url = url..'#'..1
    else
        url = url..'#'..0
    end
    --显示原生关闭按钮
    if isShowCloseBtn then
        url = url..'#'..1
    else
        url = url..'#'..0
    end
    SDKHandler.Questionnaire(url)
end

function SDKAgent.openWebView(url,isFloatView,isFullView,isShowNavigationBar)
    --小窗口模式
    if isFloatView then
        url = url..'#'..1
    else
        url = url..'#'..0
    end
    --全屏模式
    if isFullView then
        url = url..'#'..1
    else
        url = url..'#'..0
    end
    --显示原生关闭按钮
    if isShowNavigationBar then
        url = url..'#'..1
    else
        url = url..'#'..0
    end
    SDKHandler.OpenWebview(url)
end

function SDKAgent.hasPackageInstalled(packageName)
    SDKHandler.HasPackageInstalled(packageName)
end

function SDKAgent.toApp(info)
    local arr = string.split(info,'#')
    SDKHandler.ToApp(arr[1],arr[2])
end

function SDKAgent.hasUserCenter()
    return SDKHandler.HasUserCenter()
end

function SDKAgent.openUserCenter()
    SDKHandler.OpenUserCenter()
end

function SDKAgent.openCustomerService(roleid)
    print("SDKAgent.openCustomerService= ", roleid)
    SDKHandler.OpenCustomerService(roleid)
end

function SDKAgent.hasAgreement()
    return SDKHandler.HasAgreement()
end

function SDKAgent.openAgreement()
    SDKHandler.OpenAgreement()
end

function SDKAgent.isLoginSuccess()
    return SDKHandler.IsLoginSuccess()
end

function SDKAgent.isUnityPackage()
    return SDKHandler.IsUnityPackage()
end

-- 设置用户协议 对应语言
function SDKAgent.setCompactUrl(language)
    print("SDKAgent.setCompactUrl", language)
    local url = ""
    if language == LanguageAtt.CHS then        -- 简体中文
        url = NetEaseDefine.COMPACT_URL_CHS
    elseif language == LanguageAtt.EN then    -- 英文
        url = NetEaseDefine.COMPACT_URL_EN
    else
        url = NetEaseDefine.COMPACT_URL_DEFAULT
    end

    SDKHandler.SetCompactUrl(url, "")
end

-- 设置用户中心语言
function SDKAgent.setLanguage(language)
    print("SDKAgent.setLanguage", language)
    local url = ""
    if language == LanguageAtt.CHS then        -- 简体中文
        url = "ZH_CN"
    elseif language == LanguageAtt.EN then    -- 英文
        url = "EN"
    else
        url = "AUTO"
    end

    self._language = language
    SDKHandler.SetLanguage(url)
end

function SDKAgent.getCustomerTokenLanguage(language)
    local la = "en_us"
    if language == LanguageAtt.CHS then        -- 简体中文
        la = "zh_cn"
    elseif language == LanguageAtt.EN then    -- 英文
        la = "en_us"
    end

    return la
end

--设置测试支付地址(如果需要正式地址，该方法注释点即可，因为在sdk中设置过正式地址)
--注意：请确保在调用初始化ntInit之前将UNISDK_JF_GAS3_URL设置为GAS3【正式】支付地址
--如需切到GAS3测试地址，可以在ntInit之后，ntLogin之前，通过脚本修改UNISDK_JF_GAS3_URL。正式放出的包只能使用GAS3正式地址
function SDKAgent.setUnisdkJfGas3Url()
    SDKHandler.SetUnisdkJfGas3Url(NetEaseDefine.UNISDKJFGAS3_URL_TEST)
end

function SDKAgent.uploadRoleInfo(data)
    data = ClientUtils.table2String(data)
    --print("SDKAgent.uploadRoleInfo =", data)
    SDKHandler.UploadRoleInfo(data)
end

function SDKAgent.trackCustomEvent(key, data)
    data = ClientUtils.table2String(data)
    --print("SDKAgent.trackCustomEvent =", key, data)
    SDKHandler.TrackCustomEvent(key, data)
end

-- Draf日志
function SDKAgent.onEvent(key, data)
    data = ClientUtils.table2String(data)
    print("SDKAgent.onEvent =", data)
    SDKHandler.OnEvent(key, data)
end

function SDKAgent.getAppInstanceId()
    return SDKHandler.GetAppInstanceId()
end

function SDKAgent.setNewAccount(isNew)
    self._newAccount = isNew
end

function SDKAgent.isNewAccount()
    return self._newAccount
end

function SDKAgent.setOpenId(openId)
    self._openId = openId
end

function SDKAgent.getOpenId()
    return self._openId
end

function SDKAgent.setToken(token)
    self._token = token
end

function SDKAgent.getToken()
    return self._token
end

function SDKAgent.setWhiteUser(whiteUser)
    self.whiteUser = whiteUser
end

function SDKAgent.getWhiteUser()
    return self.whiteUser
end

function SDKAgent.setHostID(hostID)
    self.hostID = hostID
end

function SDKAgent.getHostID()
    return self.hostID
end

function SDKAgent.setSDKLoginResponeData(data)
    self._sdkLoginResponeData = data
end

function SDKAgent.getSDKLoginResponeData()
    return self._sdkLoginResponeData
end

function SDKAgent.reviewNicknameV2(nickName)
    print("SDKAgent.reviewNicknameV2 =", nickName)
    local envStr = SDKHandler.ReviewNicknameV2(nickName)
    print("SDKAgent.envStr =", envStr)
    return envStr
end

function SDKAgent.reviewWordsV2(level, channel, content)
    print("SDKAgent.reviewWordsV2 =", level, channel, content)
    local envStr = SDKHandler.ReviewWordsV2(level, channel, content)
    print("SDKAgent.envStr =", envStr)
    return envStr
end

function SDKAgent.shareFunc(shareInfo)
    print("SDKAgent.shareFunc shareInfo = ", shareInfo)
    SDKHandler.ShareFunc(shareInfo)
end

function SDKAgent.crashFunc()
    SDKHandler.CrashFunc()
end

function SDKAgent.CopyTextToClipboard(content)
    SDKHandler.CopyTextToClipboard(content)
end

--手机震动
--milliseconds震动时长(毫秒)，为0是取消震动
function SDKAgent.Vibrate(milliseconds)
    SDKHandler.Vibrate(milliseconds)
end

function SDKAgent._setUserCallback(event, callback)
    SDKAgent._userCallbackDict[event] = callback
end

function SDKAgent._callUserCallback(event, ...)
    local callback = SDKAgent._userCallbackDict[event]
    if callback ~= nil then
        callback(...)
        SDKAgent._userCallbackDict[event] = nil
    end
end

--------------------- SDKAppUtils ---------------------
function SDKAgent.getLoginParams()
    local params = {
        ["accid"] = SDKAgent.getAccid(),
        ["channel_id"] = SDKAgent.getChannel(),
        ["sdk_str"] = SDKAgent.getLoginSdkStr(),
        ["system_id"] = LuaToolkit.GetOSName(),
        ["country_id"] = SDKAgent.getCountryCode(),
        ["version"] = LuaToolkit.GetVersionName(),
        ["Resversion"] = "",
        ["device_id"] = SDKAgent.getNativeDeviceID()
    }

    return params
end

function SDKAgent.getNativeDeviceID()
    if SDKAgent.deviceId then
        return SDKAgent.deviceId
    end
    local channelId = SDKAgent.getChannelId()
    if channelId == ChannelDefine.Channel_Netease then
        SDKAgent.deviceId = SDKAgent.unisdk_devideid
    else
        SDKAgent.deviceId = SDKHandler.GetDeviceId()
    end
    print('SDKAgent.getNativeDeviceID====='..SDKAgent.deviceId)
    return SDKAgent.deviceId
    --[[
    if SDKAgent._cachedNativeDeviceID == nil then
        local platformData = SDKAgent.getPlatformData()
        SDKAgent._cachedNativeDeviceID = platformData and platformData[AttName.NATIVE_DEVICE_ID]
    end
    ]]
    --if SDKAgent._cachedNativeDeviceID == nil then
    --    print("native deviceID is nil, fallback to unity deviceID")
    --    SDKAgent._cachedNativeDeviceID = "UNITY-" .. UnityEngine.SystemInfo.deviceUniqueIdentifier
    --end
    --
    --return SDKAgent._cachedNativeDeviceID
end
-------------------------------------------------------

--------------------- SDKCore -------------------------

-- 更新UserData（附加）
function SDKAgent.addUserData(paramUserData)

end

function SDKAgent.getUserValue(attName)

end

-- 获取整个UserData,返回table
function SDKAgent.getUserData()

end

-- 如果常用需要缓存
function SDKAgent.getPlatformData()

end

-------------------------------------------------------

----------------- EventCallback -----------------------

local callbackDict = {
    [EventType.EVENT_INIT_FINISH] = "_onSDKInitFinish",
    [EventType.EVENT_LOGIN_SUCCESS] = "_onSDKLoginSucc",
    [EventType.EVENT_LOGIN_CANCEL] = "_onSDKLoginCancel",
    [EventType.EVENT_LOGIN_FAIL] = "_onSDKLoginFail",
    [EventType.EVENT_LOGOUT] = "_onSDKLogoutSuccess",
    [EventType.EVENT_SWITCHACCOUNT] = "_onSDKSwitchAccount",
    [EventType.EVENT_REQTOKEN_CUSTOMERSERVICE] = "_onSDKReqCustomerToken",
    [EventType.EVENT_WEBVIEW_NATIVECALL] = "_onWebViewNativeCall",
    [EventType.EVENT_CLOSE_WEBVIEW] = "_onCloseWebview",
    [EventType.EVENT_TO_APP] = "_onToApp",
    [EventType.EVENT_PHAROS] = "_onPharos",
}

-- 获得从SDK发送回来Event的处理函数
function SDKAgent.onGetSDKEvent(eventType, data)
    print("---   SDKAgent.onGetSDKEvent()", eventType, data)
    if eventType == nil then
        logerror("invalid eventType, data:" .. (data or ""))
        return
    end

    local funcName = callbackDict[eventType]
    if funcName == nil then
        logerror("invalid funcName, eventType:" .. eventType)
        return
    end

    local callback = self[funcName]
    if callback == nil then
        logerror("invalid callback, funcName:" .. funcName)
        return
    end

    local tableData = ClientUtils.string2Table(data)
    callback(tableData)
end

function SDKAgent._onSDKInitFinish(data)
    
end










function SDKAgent._onSDKLoginSucc(data)

    local jsonStr = ClientUtils.table2String(data)
    print("---   Lua   SDKAgent._onSDKLoginSucc()   jsonStr = ", jsonStr)
    SDKAgent.isNeedUpPlayerInfo = nil
    if SDKAgent.isNetEaseChannel() then
        self.setLogSdkBaseInfoJson(data)
        self.setSauthJson(jsonStr)
        SDKAgent.SetAcSdkAccountParams()
        SDKAgent.unisdk_devideid = data["unisdk_deviceid"] or ""
        SDKAgent.isNeedUpPlayerInfo = true
    end

    SimpleLoginTool.requestServerSdkLogin()  -- SDK 登录成功后，拿着sdk信息请求服务端
end

function SDKAgent._onSDKLoginCancel()

end

function SDKAgent._onSDKLoginFail()
    SDKAgent.loginFinish()
end

function SDKAgent._onSDKSwitchAccount(data)

    local jsonStr = ClientUtils.table2String(data)
    print("SDKAgent._onSDKSwitchAccount= ", jsonStr)
    --SimpleLoginTool.resetStart()
    LuaCallCs.LogError("---   老代码：_onSDKSwitchAccount，这里需不需要处理，待定...")
    SDKHandler.LoginSuccess()
    SDKAgent.isNeedUpPlayerInfo = nil
    if SDKAgent.isNetEaseChannel() then
        self.setLogSdkBaseInfoJson(data)
        self.setSauthJson(jsonStr)
        SDKAgent.SetAcSdkAccountParams()

        SDKAgent.isNeedUpPlayerInfo = true
    end
    SimpleLoginTool.requestServerSdkLogin(true)  -- SDK 登录成功后，拿着sdk信息请求服务端
end

local sdkEventCode =
{
    MINOR_STATUS_LOGOUT_CODE = 101,  -- 未成年强制退出
    LOGOUT_CANCEL = 1,               -- 取消登录
    LOGOUT_SUCCESS = 0,               -- 登出成功
}

function SDKAgent._onSDKLogoutSuccess(data)
    print("SDKImpBase:_onSDKLogoutSuccess")
    local jsonStr = ClientUtils.table2String(data)
    print("_onSDKLogoutSuccess jsonStr =", jsonStr)

    SDKAgent.SetAcSdkAccountParams()

    if data["login_out_code"] and data["login_out_code"] == sdkEventCode.MINOR_STATUS_LOGOUT_CODE then
        -- 弹框提示退出 未成年提示  未成年拒绝服务
        GameFsm.InterfaceLogout("SDK消息: 未成年提示")
    elseif data["login_out_code"] and data["login_out_code"] == sdkEventCode.LOGOUT_CANCEL then
        -- 取消登录
        GameFsm.InterfaceLogout("SDK消息: 取消登录")
    elseif data["logout_out_code"] and data["logout_out_code"] == sdkEventCode.LOGOUT_SUCCESS then
        -- 登出成功,sdk中设置了ConstProp.LOGIN_TYPE为0，会重新调起渠道选择界面
        GameFsm.InterfaceLogout(1)
    end
end

function SDKAgent._onSDKReqCustomerToken(data)
    local jsonStr = ClientUtils.table2String(data)
    print("SDKAgent._onSDKReqCustomerToken jsonStr=", jsonStr)
    
    -- 向服务端请求客服token
    print("SDKAgent.reqCustomerToken =", jsonStr)
    local params = ClientUtils.string2Table(jsonStr)
    params["lang"] = self.getCustomerTokenLanguage(self._language)

    if DataCore.account and Util.Account.PlayerUid() then
        params["game_uid"] = Util.Account.PlayerUid()
        params["nickname"] = Util.Account.PlayerName()
    else
        local lastUid = LuaCallCs.PlayerPrefs.GetString(UrlConst.Last_UID)
        local arr = string.split(lastUid, ";")
        if table.count(arr) == 2 then
            params["game_uid"] = arr[1]
            params["nickname"] = arr[2]
        end
    end

    local function TokenReponse(code,data)
        print("reqCustomerToken TokenReponse =",data, code)
        if code == 0 then
            SDKHandler.SetCustomerServiceTokenInfo(data)
        end
    end

    OpenServerHelper.httpPost(UrlConst.NETWORK_ADDRESS_TABLE.ACCOUNT_TOKEN, params ,TokenReponse)
end

function SDKAgent._onWebViewNativeCall(data)
    local jsonStr = ClientUtils.table2String(data)
    print("SDKAgent._onWebViewNativeCall jsonStr=", jsonStr)
    local params = ClientUtils.string2Table(jsonStr)
    local action = params["action"]
    if action == "finish" then
        EventCenter.sendEvent(EventConst.COMPLETE_QUESTIONINFO)
    end
end

function SDKAgent._onCloseWebview(data)
    local jsonStr = ClientUtils.table2String(data)
    print("SDKAgent._onCloseWebview jsonStr=", jsonStr)
    local params = ClientUtils.string2Table(jsonStr)
    print('Send Close WebView Event niu----')
    EventCenter.sendEvent(EventConst.CLOSE_WEBVIEW)
end

function SDKAgent._onToApp(data)
    local jsonStr = ClientUtils.table2String(data)
    local params = ClientUtils.string2Table(jsonStr)
    local result = params["result"]
    local toAppId = params["appId"]
    print('SDKAgent._onToApp',result,toAppId)
    EventCenter.sendEvent(EventConst.SDK_TO_APP,{result,toAppId})
end




------------------------------------begin灯塔

--灯塔接口callback
function SDKAgent._onPharos(data)
    local methodId = data.getString("methodId");
    if methodId == PharosConst.Method_OnPharosServer then                 --获取加速IP列表成功

    elseif methodId == PharosConst.Method_PharosNetLags then              --触发网络延迟探测

    elseif methodId == PharosConst.Method_PharosNetLagsCancel then        --取消网络延迟探测

    elseif methodId == PharosConst.Method_PharosStartQOS then             --开启QOS服务

    elseif methodId == PharosConst.Method_PharosStopQOS then              --停止QOS服务
    end
end

--灯塔探针，灯塔获取加速IP列表，或者叫网络加速查询
function SDKAgent.PharosHarhor(ip,port)
    local data = {}
    data.methodId = PharosConst.Method_PharosHarhor
    data.project = PharosConst.Project
    data.area = "1"                                         --发行区域，国内为0， 海外为1 (或者2均可)
    data.netid = "gamelogin_"..TimeUtils.getServerTime()    --调用标记，可定义为  gamelogin_{TIMESTAMP}
    data.force = "true"                                     --是否强制打开灯塔开关，不设置为true 触发无效, 主要是母包在调用
    data.timeout = "60"                                     --timeout 为web接口请求超时时间，即在弱网络情况下，回调时间可能需要最长 60 秒 (参数定义) 左右
    data.cache_expire = "1800"                              --cache_expire 建议设置30分钟，即30分钟内的请求都不会额外查询web来提升响应速度 (查询web一般需要200ms，而查询cache只需要5ms。如果业务场景并没有频繁运维变更(例如新增机器)，建议加长该时间，可以提升客户查询性能)
    data.logopen = "true"                                   --打开日志，会写落地，方便debug排查

    data.ips = {}                           --放入要加速的ip
    data.ips[ip] = {}
    table.insert(data.ips[ip],port)



    print("灯塔探针SDKAgent.PharosHarhor =", table.dump(data))
    SDKHandler.NtExtendFunc(data)
end

--触发网络延迟探测
function SDKAgent.PharosNetLags()
    local data = {}
    data.methodId = PharosConst.Method_PharosNetLags
    data.project = PharosConst.Project
    data.lag_id = ""                        --必填参数 String, 可以是任意的字符串, 表示这一次探测的任务id
    data.counter = 0                        --必填参数 Int, 单位个数, 0表示一直探测, >0 则表示只探测N次
    data.interval = 30                      --可选参数 Int, 单位秒, 默认值30秒, 表现每次执行的间隔; 有效值在 (5 ~ 3600)
    data.logopen = "true"                   --可选参数 Bool, 是否打开debug日志 (注意, 如果unisdk 为debug模式, 会强制为DEBUG模式)
    data.area = "1"                         --发行区域，国内为0， 海外为1 (或者2均可)

    data.server = {}                        --必填参数, 表示需要探测的游戏服tag, ip, port 信息

    print("灯塔触发网络延迟探测SDKAgent.PharosNetLags =", table.dump(data))
    SDKHandler.NtExtendFunc(data)
end

--取消网络延迟探测
function SDKAgent.PharosNetLagsCancel()
    local data = {}
    data.methodId = PharosConst.Method_PharosNetLagsCancel
    data.lag_id = ""                        --任务id，如果传空字符串，则取消所有的任务
    print("灯塔取消网络延迟探测SDKAgent.PharosNetLagsCancel =", table.dump(data))
    SDKHandler.NtExtendFunc(data)
end

--开启QOS服务
function SDKAgent.PharosStartQOS()
    local data = {}
    data.methodId = PharosConst.Method_PharosStartQOS
    data.project = PharosConst.Project
    data.game_id = PharosConst.GameId
    data.area = "1"                         --发行区域，国内为0， 海外为1 (或者2均可)
    data.debug_mode = "true"                --调试模式，影响qos服务端测试环境

    data.qos_info = {}                      --加速信息 （必填）


    data.qos_info_sign = ""                 --加速信息签名 （必填， 注意由服务端生成）
    data.logopen = "true"                   --打开日志，会写落地，方便debug排查
    data.lag_id = ""                        --任务id，如果传空字符串，则取消所有的任务
    print("灯塔开启QOS服务SDKAgent.PharosStartQOS =", table.dump(data))
    SDKHandler.NtExtendFunc(data)
end

--禁用QOS服务
function SDKAgent.PharosStopQOS()
    local data = {}
    data.methodId = PharosConst.Method_PharosStopQOS
    data.project = PharosConst.Project
    data.game_id = PharosConst.GameId
    data.area = "1"                         --发行区域，国内为0， 海外为1 (或者2均可)
    data.debug_mode = "true"                --调试模式，影响qos服务端测试环境
    data.logopen = "true"                   --打开日志，会写落地，方便debug排查
    print("灯塔禁用QOS服务SDKAgent.PharosStopQOS =", table.dump(data))
    SDKHandler.NtExtendFunc(data)
end

------------------------------------end灯塔


function SDKAgent.InitAcSdk(sdkParams)
    SDKAgent.adSdkParam = sdkParams
    local jsonStr = ClientUtils.table2String(SDKAgent.adSdkParam)
    print('acsdk initSdkJson jsonStr==='..jsonStr)
    if SDKAgent.isNetEaseChannel() then
        --请务必确保终端用户有效同意《隐私政策》后再初始化反外挂SDK
        if self.protocolCode >= 0 and self.protocolCode ~= 2 then--0确定   1接受  2拒绝   3无需显示
            
            SDKHandler.StartAcSdkThread(jsonStr)
        end
    end
end

function SDKAgent.SetAcSdkAccountParams()
    if SDKAgent.isNetEaseChannel() then
        SDKHandler.SetAccountParams()
    end
end

function SDKAgent.SetAcSdkPlayerParams()
    if SDKAgent.isNetEaseChannel() then
        if SDKAgent.isNeedUpPlayerInfo then
            local pInfo = SDKHandler.GetPlayerDrpfJson()
            local params = ClientUtils.string2Table(pInfo)
            if SDKAgent.adSdkParam == nil then
                SDKAgent.adSdkParam = {}
            end
            SDKAgent.adSdkParam.role_id = params["role_id"]
            SDKAgent.adSdkParam.server =  params["server"]

            local vipLevel = 0

            SDKAgent.adSdkParam.vip_level = vipLevel
            local jsonStr = ClientUtils.table2String(SDKAgent.adSdkParam)
            SDKHandler.SetPlayerParams(jsonStr)
            SDKAgent.isNeedUpPlayerInfo = nil
        end
    end
end

--礼包码功能
function SDKAgent.SetAcSdkGiftPackageCode(keyCode)
    local codeData = {}
    local cdk_url = "https://cdkeynaeast.matrix.easebar.com"--正式地址

    local path = "/sdk/"..PharosConst.Project.."/cdkey_sn"
    --附带参数
    codeData["gameid"] = PharosConst.Project                                        --游戏标识（如g12，g17）
    codeData["sn"] = keyCode         --玩家输入的序列号
    codeData["acct"] = SDKAgent.getAccid() --"1144053176@netease_global.win.163.com"                                         --玩家帐号渠道账号
    codeData["aid"] = SDKAgent.aid or 0--"41915"                                          --调用计费sauth登录时返回的账号唯一标识aid
    codeData["hostnum"] = SDKAgent.hostID--"2"                                               --服务器数字编号
    codeData["unum"] = Util.Account.PlayerUid()--"352338313229"                                         --全服唯一的角色id
    codeData["app_channel"] = SDKAgent.getChannelId() or "netease%02unknown" --\"2\"        --发行(分发）渠道，拿不到该参数的，该字段固定传neteaseunknown，由计费查询玩家首次登录的app_channel做校验
    codeData["deviceid"] = SDKAgent.getNativeDeviceID() or "" --"e5a2ce19b10df356"                       --玩家登录的移动设备号，取不到则填''
    --acct=&aid=41915&hostnum=2&unum=352338313229&app_channel=1&deviceid=e5a2ce19b10df356        aid=1144053176@netease_global.win.163.com      可在编辑器直接测试账号

    --可不传参数
    codeData["type"] = 0                                --唯一性标识(玩家选择的奖励入口)，无法确认的不传该值(或传0)，否则可能导致激活失败
    --codeData["logic_hostnum"] = 0                             --服务器逻辑服编号，若传了该参数，则校验游戏服激活限制时优先使用该参数
    --codeData["special_limit"] = 0                             --游戏定制激活限制，若有多个限制，使用逗号分隔
    --codeData["query"] = 0                             --1，表示只查询序列号信息，不激活序列号; 2, 表示查询账号/角色是否能够使用序列号激活，不激活序列号

    --必传参数      网易提供的秘钥
    local key = "Qo4b4d0fohrBRcL9bjAF5SNV4ILZqfkp";
    local message = string.format("GET%s", path)
    --local uuidData = OpenServerHelper._fillUUID(codeData)
    message = ClientUtils.composeGetUrl(message, codeData)
    local headers = {
        ["X-Client-Sign"]=SDKHandler.CalculateHMACSHA256Signature(key, message)
    }
    OpenServerHelper.httpGet(cdk_url..path, codeData, SDKAgent.GetAcSdkGiftPackageCode, nil, nil, headers)
end

function SDKAgent.GetAcSdkGiftPackageCode(succ, strData)
    local tableData = ClientUtils.string2Table(strData)
    if tableData and tableData.retcode then
        local retcode = tonumber(tableData.retcode)
        if retcode == 200 then
            MsgManager.notice(LanguageConst.GiftCode0)--不存在
            return
        elseif retcode == 402 then
            MsgManager.notice(LanguageConst.GiftCode1)--不存在
        elseif retcode == 404 then
            MsgManager.notice(LanguageConst.GiftCode2)--上限
        elseif retcode == 406 then
            MsgManager.notice(LanguageConst.GiftCode3)--过期
        elseif retcode == 409 then
            MsgManager.notice(LanguageConst.GiftCode4)--已使用
        else
            MsgManager.notice(LanguageConst.GiftCode20..retcode)--错误，并提示错误码
        end
    end
end

return SDKAgent
