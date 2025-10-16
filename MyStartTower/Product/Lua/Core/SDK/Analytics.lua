local LuaToolkit = Framework.Tools.LuaToolkit
local AnalyticsString = ConstTable.AnalyticsString
local Analytics = {}
Analytics.roleName = ""
local self = Analytics

-- 网易埋点 Start
function Analytics.init()
    --print("Analytics.init")
end

function Analytics.reviewNicknameV2(content)
    if SDKAgent.isNetEaseChannel() and content then
        local envStr = SDKAgent.reviewNicknameV2(content)
        print("SDKAgent envStr =", envStr)
        if envStr then
            local envtable = ClientUtils.string2Table(envStr)
            local code = tonumber(envtable['code'])
            print("SDKAgent code =", code)
            if code == 202 then
                -- 昵称违规  弹框提示
                print("SDKAgent name is error")
                MsgManager.notice(AnalyticsString.nick_name_error)
                return false
            end
        end
    end

    return true
end

function Analytics.reviewWordsV2(level, channel, content)
    -- 网易渠道 关键字屏蔽校验
    if SDKAgent.isNetEaseChannel() and content then
        local envStr = SDKAgent.reviewWordsV2(level ,channel, content)
        print("SDKAgent reviewWordsV2 envStr =", envStr)
        if envStr then
            local envtable = ClientUtils.string2Table(envStr)
            local code = tonumber(envtable['code'])
            print("SDKAgent reviewWordsV2 code =", code)
            if code == 202 or code == 201 or code == 206 then
                -- 昵称违规  弹框提示
                MsgManager.notice(AnalyticsString.input_content_error)
                return
            end
        end
    end

    return true
end

-- 次留天数 广告埋点
function Analytics.retentionDays(data)
    if not (data["account"] and data["account"]["oLog"]) then
        return
    end

    local oLog = data["account"]["oLog"]
    print("oLog =", oLog)
    oLog = ClientUtils.string2Table(oLog)
    local day7 = oLog["day7"]
    local dayCount = oLog["dayCount"]

    if dayCount ~= 1 and #day7 ~= 8 then
        return
    end

    --对应的天数有日期（也就是大于100），并且dayCount == 1，满足留存条件
    local signDay = 0
    if day7[1] > 100 and day7[2] > 100 and day7[3] < 100 and day7[4] < 100 and day7[5] < 100 and day7[6] < 100 and day7[7] < 100 and day7[8] < 100 then
        signDay = 2
    end

    if day7[1] > 100 and day7[3] > 100 and day7[4] < 100 and day7[5] < 100 and day7[6] < 100 and day7[7] < 100 and day7[8] < 100 then
        signDay = 3
    end

    if day7[1] > 100 and day7[7] > 100 and day7[8] < 100 then
        signDay = 7
    end

    if signDay > 0 then
        local trackCEvents = {}
        local key = "retention_" .. signDay .. "d"
        print("key = ", key)
        --trackCEvents[key] = signDay
        SDKAgent.trackCustomEvent(key, trackCEvents)
    end
end

function Analytics.trackCustomEvent(eventKey, eventValue)

    local key = eventKey..Util.Account.PlayerUid()
    local pint = LuaCallCs.PlayerPrefs.GetInt(key)
    if pint <= 0 then
        local trackCEvents = {}
        --trackCEvents[eventKey] = eventValue
        SDKAgent.trackCustomEvent(eventKey, trackCEvents)
        LuaCallCs.PlayerPrefs.SetInt(key, 1)
    end

end

-- 玩家等级 打点
function Analytics.levelUpLog(data)

    local playerLevel = Util.Account.PlayerLv()
    if playerLevel == 10 or playerLevel == 20 then
        local key = "playerlevelup_" .. playerLevel
        local pkey = key .. Util.Account.PlayerUid()
        local pint = LuaCallCs.PlayerPrefs.GetInt(pkey)
        if pint <= 0 then
            local trackCEvents = {}
            --trackCEvents[key] = playerLevel

            LuaCallCs.PlayerPrefs.SetInt(pkey, playerLevel)
            SDKAgent.trackCustomEvent(key, trackCEvents)
        end
    end

end

-- 上传角色信息
function Analytics.uploadRoleInfo(data)
    -- 上传角色信息和名称到unisdk
    local gradekey = "roleGrade" .. Util.Account.PlayerLv() .. Util.Account.PlayerUid()
    local pgrade = LuaCallCs.PlayerPrefs.GetInt(gradekey)
    local nameIsDiff = Analytics.roleName ~= Util.Account.PlayerName()
    if pgrade <= 0 or nameIsDiff then
        local uploadJson = {}
        uploadJson["roleId"] = Util.Account.PlayerUid()
        uploadJson["roleName"] = Util.Account.PlayerName()
        uploadJson["roleGrade"] = Util.Account.PlayerLv()
        uploadJson["roleLevelTime"] = TimeUtils.getServerTime()

        local serverInfo = SimpleLoginTool.getServerInfo()
        uploadJson["serverId"] = Analytics.getServerName()
        uploadJson["serverName"] = serverInfo.name
        LuaCallCs.PlayerPrefs.SetInt(gradekey, Util.Account.PlayerLv())
        SDKAgent.uploadRoleInfo(uploadJson)

        DataCore.setLastUserInfo(Util.Account.PlayerUid(),Util.Account.PlayerName())
    end

    Analytics.roleName = Util.Account.PlayerName()
end

function Analytics.getServerName()
    local serverInfo = SimpleLoginTool.getServerInfo()
    local serverName = Util.Account.PlayerServerName()
    print("serverName = ", serverName)
    if serverName and string.len(serverName)> 6 then
        serverName = string.sub(serverName, 7)
    else
        serverName = serverInfo.id
    end

    return serverName
end

function Analytics.uploadRoleInfo2()
    -- 上传服务器信息和名称到unisdk
    local uploadServerJson = {}
    local trackCEvents = {}
    local serverInfo = SimpleLoginTool.getServerInfo()
    uploadServerJson["serverId"] = Analytics.getServerName()
    uploadServerJson["serverName"] = serverInfo.name
    uploadServerJson["roleId"] = Util.Account.PlayerUid()
    uploadServerJson["roleName"] = Util.Account.PlayerName()
    uploadServerJson["roleGrade"] = Util.Account.PlayerLv()

    local _uploadInfoKey = "_uploadInfoKey" .. Util.Account.PlayerUid()
    if SDKAgent.isNewAccount() == 1 then
        -- 上传角色信息和名称到unisdk
        if LuaCallCs.PlayerPrefs.GetInt(_uploadInfoKey) > 0 then
            return
        end

        LuaCallCs.PlayerPrefs.SetInt(_uploadInfoKey, 1)
        uploadServerJson["roleCreateTime"] = TimeUtils.getServerTime()

        -- sdk广告埋点
        --trackCEvents['complete_registration'] = ""
        --SDKAgent.trackCustomEvent("complete_registration", trackCEvents) --移除埋点complete_registration

        SDKAgent.trackCustomEvent("create_role", trackCEvents)--无参数的

        trackCEvents['app_instance_id'] = SDKAgent.getAppInstanceId()
        SDKAgent.trackCustomEvent("ne_create_role", trackCEvents)--有参数的
    end
    SDKAgent.uploadRoleInfo(uploadServerJson)
end

function Analytics.onEvent(key)

    if key == nil then
        return
    end

    local data = {}
    if key == "LoginUI" then
        data["app_ver"] = LuaToolkit.GetVersionName()
        data["reach_login_time"] = TimeUtils.getServerTime()
    elseif key == "" then

    end

    SDKAgent.onEvent(key, data)
end

-- 网易埋点 end

function Analytics.onLineRecord()
    self.adSdkTimerNum = self.adSdkTimerNum + 1
    print("adSdkTimerNum =", self.adSdkTimerNum)

    if self.adSdkTimerNum == 3 then
        return
    end

    local rate = self.adSdkTimerNum * 15
    local trackCEvents = {}
    local key = 'gameplay_' .. rate ..'mins'
    print("key = ", key)
    --trackCEvents[key] = rate
    SDKAgent.trackCustomEvent(key, trackCEvents)

    if self.adSdkTimerNum == 4 then
        self.adSdkTimerStop()
    end

end

-- 在线时长打点
function Analytics.adSdkTimerStart()
    if not SDKAgent.isNetEaseChannel() then
        return
    end

    self.adSdkTimerNum = 0
    if SDKAgent.isNetEaseChannel() then
        if not self.adSdkTimer then
            self.adSdkTimer = Timer.New(self.onLineRecord, 900, 4)
        end
        self.adSdkTimer:Restart()
    end

end

function Analytics.adSdkTimerStop()
    if not SDKAgent.isNetEaseChannel() then
        return
    end

    self.adSdkTimerNum = 0
    if self.adSdkTimer then
        self.adSdkTimer:Stop()
    end
end

return Analytics