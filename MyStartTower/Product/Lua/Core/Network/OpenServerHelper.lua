-- OpenServerHelper
local LuaToolkit = Framework.Tools.LuaToolkit
--local HttpUtils = Framework.Network.HttpUtils
local HttpHelper = require("Core/Network/HttpHelper")
local UrlConst = require("Core/Network/UrlConst")

local OpenServerHelper = {}
--local self = OpenServerHelper

function OpenServerHelper.httpPost(url, data, callback, retryTimes, timeout)
    print("---   Lua : OpenServerHelper.httpPost()   ", url, ClientUtils.table2String(data))
    --data = self._fillUUID(data)
    HttpHelper.post(url, ClientUtils.table2String(data), callback, retryTimes, timeout)
end

function OpenServerHelper.httpGet(url, data, callback, retryTimes, timeout, headers)
    -- 如果存在自定义网络请求返回的数据，直接返回自定义数据
    if UrlConst.NETWORK_CUSTOM_DATA and UrlConst.NETWORK_CUSTOM_DATA[url] then
        -- 0 : 成功
        callback(0, UrlConst.NETWORK_CUSTOM_DATA[url])
        return
    end

    print("---   Lua : OpenServerHelper.httpGet()   ", url, ClientUtils.table2String(data))
    --签名时，uuid的每次变更导致算法不对
    if not headers then
        --data = self._fillUUID(data)
    end
    url = data == nil and url or ClientUtils.composeGetUrl(url, data)
    HttpHelper.get(url, callback, retryTimes, timeout, headers)
end

function OpenServerHelper._fillUUID(data)
    if nil == data then
        data = {}
    end
    data["uuid"] = LuaToolkit.GetOpenDataUUID()
    return data
end


return OpenServerHelper
