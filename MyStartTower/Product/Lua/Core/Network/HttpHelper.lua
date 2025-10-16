-- HttpHelper
local LuaToolkit = Framework.Tools.LuaToolkit
local HttpUtils = Framework.Network.HttpUtils
local UrlGroup = Framework.Network.UrlGroup
local UrlGroupLegacy = require("Core/Network/UrlGroupLegacy")
local VersionUtils = VersionUtils
local HttpHelper = {}
local self = HttpHelper

function HttpHelper.createUrlGroup(urls, append)
    local group = nil
    if VersionUtils.hasAbilityUrlGroup() then
        group = UrlGroup(unpack(urls))
    else
        group = UrlGroupLegacy(urls)
    end
    group:SetUrlAppend(append)
    return group
end

function HttpHelper.post(urlGroup, strData, callback, retryTimes, timeout)
    if nil == urlGroup then
        return
    end
    if nil == retryTimes then
        retryTimes = 1
    end
    if nil == timeout then
        timeout = 5
    end

    if HttpHelper._isGroupLagecy(urlGroup) then
        HttpUtils.Post(urlGroup:Get(), strData, callback, retryTimes)
    else
        HttpUtils.Post(urlGroup, strData, callback, retryTimes, timeout)
    end
end

function HttpHelper.get(urlGroup, callback, retryTimes, timeout, headers)
    if nil == retryTimes then
        retryTimes = 1
    end
    if nil == timeout then
        timeout = 5
    end

    --消息頭
    if "string" == type(urlGroup) then
        if headers then
            HttpUtils.GetAndHeader(urlGroup, callback, retryTimes, headers)
        else
            HttpUtils.Get(urlGroup, callback, retryTimes)
        end
    elseif HttpHelper._isGroupLagecy(urlGroup) then
        HttpUtils.Get(urlGroup:Get(), callback, retryTimes)
    else
        HttpUtils.Get(urlGroup, callback, retryTimes, timeout)
    end
end

function HttpHelper._isGroupLagecy(urlGroup)
    return type(urlGroup) == "table" and urlGroup:getType() == "UrlGroupLegacy"
end


return HttpHelper
