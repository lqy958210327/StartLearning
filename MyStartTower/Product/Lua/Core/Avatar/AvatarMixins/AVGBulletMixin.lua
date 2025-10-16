--local UrlConfig = require("Core/Network/UrlConfig")
local SDKConst = require("Core/SDK/SDKConst")
local ResponseCode = SDKConst.ResponseCode

local AvgConfig = ConstTable.AvgConfig

--local HttpUtils = Framework.Network.HttpUtils

local AVGBulletMixin = {}

local REQUEST_TYPE = {
    GET_COMMENT = 1,        -- 获得评论     参数: entry_id(string)评论对象id , uid(string)玩家uid
    POST_COMMENT = 2,       -- 发表评论
    GET_RATE = 3,           -- 获取评分     参数: id 评论对象id
    POST_RATE = 4,          -- 发表评分
    FAVOR = 5,              -- 评论点赞
    GET_MYRATE = 6,         -- 我是否评分
}

local URL_POSTFIX = {
    [REQUEST_TYPE.GET_COMMENT] = "/discuss/comment",
    [REQUEST_TYPE.POST_COMMENT] = "/discuss/comment",
    [REQUEST_TYPE.GET_RATE] = "/discuss/rate",
    [REQUEST_TYPE.POST_RATE] = "/discuss/rate",
    [REQUEST_TYPE.FAVOR] = "/discuss/favor",
    [REQUEST_TYPE.GET_MYRATE] = "/discuss/rate",
}

local URL_TYPE = {
    GET = "Get",
    POST = "Post",
}

local emojiDic={single={},more={}}--single表示必须单发的，more表示可以多发

local RETRY_TIMES = 3



function AVGBulletMixin:requestBulletData(pageID, index, callback)
    if not pageID then 
        return 
    end
    local jsonData = self:_getAVGBulletUserInfo()
    jsonData.entry_id = pageID
    jsonData.page = index
    jsonData.limit = AvgConfig.BULLET_PAGE_LIMIT  -- 每页请求的数据量
    jsonData.orderby = "-created"
    
    local url = self:_getAVGBulletUrl( REQUEST_TYPE.GET_COMMENT, URL_TYPE.GET, jsonData)
    local requestCallback = Functor(self._onAVGBulletRequestCallback, self, REQUEST_TYPE.GET_COMMENT, callback)
    -- local url = self:_getCommentUrl( REQUEST_TYPE.GET_COMMENT, URL_TYPE.GET, jsonData)
    -- local requestCallback = Functor(self._onAVGBulletRequestCallback, self, REQUEST_TYPE.GET_COMMENT, callback)


    HttpHelper.get(url, requestCallback, RETRY_TIMES)

    --  return bulletData
end

function AVGBulletMixin:_onAVGBulletRequestCallback(requestType, callback, responseCode, dataString)
    local succ = false
    local AllData
    if responseCode == ResponseCode.SUCC and dataString then
        AllData = ClientUtils.string2Table(dataString)
        succ = true
        if AllData then
            if requestType == REQUEST_TYPE.GET_COMMENT then
                self.allCommentData = AllData
                if callback then
                    callback(AllData.data,responseCode)
                end
            end
        end
    else 
        print("_onAVGBulletRequestCallback request fail")
        if callback then
            local data = {}
            callback(data,responseCode)
        end

        self:_onAVGBulletHttpError()
    end

   
end

-- 注意发送时间间隔
function AVGBulletMixin:postButtlet(pageID, text, callback, type, item_id)

    if not self:checkAVGBulletPostCD() then 
        MsgManager.notice("操作过于频繁")
        return false
    end
    local name = CurAvatar.name
    if  not name or name == "" then
        -- 未注册的提供一个fakeName供发送弹幕
        name = "unregisteredPlayer"
    end

    self.lastPostTime = TimeUtils.getServerTime()

    local jsonData = self:_getAVGBulletUserInfo()
    local uid = CurAvatar.uid

    local content = self:checkBulletContent(text)

    jsonData.uid = uid 
    jsonData.entry_id = pageID
    jsonData.content = content
    jsonData.name = name 
    jsonData.item_id = item_id -- 动态表情的商品id
    jsonData.type = type
 

    local url = self:_getAVGBulletUrl(REQUEST_TYPE.POST_COMMENT, URL_TYPE.POST, jsonData)
    local postCallback = Functor(self._onAVGBulletPostCallback, self, uid, pageID, REQUEST_TYPE.POST_COMMENT, callback) 

    HttpHelper.post(url, ClientUtils.table2String(jsonData), postCallback, 3)
    return true
end

function AVGBulletMixin:_onAVGBulletPostCallback(uid, pageID, requestType, callback, responseCode, dataString)
    local succ = false
    if responseCode == ResponseCode.SUCC and dataString then
        succ = true
        local data = ClientUtils.string2Table(dataString)
        if data then 
            if requestType == REQUEST_TYPE.POST_COMMENT then 
                if callback then 
                    callback(uid, pageID, data.filtered)
                end
            end
        end
    else 
        print("_onAVGBulletPostCallback request fail")
        self:_onAVGBulletHttpError()
    end

end

function AVGBulletMixin:_onAVGBulletHttpError()
    local url = SvrListManager.getRaidersSvr()
    url:Next()
end

function AVGBulletMixin:_getAVGBulletUrl(requestType, urlType, data)
    local url = SvrListManager.getRaidersSvr()

    if urlType == URL_TYPE.GET then
        local append = URL_POSTFIX[requestType] .."?".. ClientUtils.composeGetParams(data)
        url:SetUrlAppend(append)
    elseif urlType == URL_TYPE.POST then
        local append = URL_POSTFIX[requestType].."?uuid="..self:encryptAVGBulletUrl(data)
        url:SetUrlAppend(append)
    end

    return url
end

function AVGBulletMixin:checkAVGBulletPostCD()
    if not self.lastPostTime then
        return true
    end
    local timePeriod = TimeUtils.getServerTime() - self.lastPostTime
    if timePeriod < self.postBulletCD then
        return false
    else
        return true
    end
end

-- uuid生成规则
function AVGBulletMixin:encryptAVGBulletUrl(jsonData)
    -- uuid : md5(timestamp + nonce + key + md5(concat(data_json))) + nonce + timestamp

    local timestamp = string.format("%x", os.time())       -- 1
    if string.len(timestamp) < 11 then
        for i = 1, 11 - string.len(timestamp) do
            timestamp = "0"..timestamp
        end
    end

    math.randomseed(tostring(os.time()):reverse():sub(1, 7))
    local nonce = string.format("%x", math.random(1, 65535))       -- 2
    if string.len(nonce) < 16 then
        for i = 1, 16 - string.len(nonce) do
            nonce = "0"..nonce
        end
    end

    local key = string.format("%x", AccountManager.getOpenID())        -- 3

    local concat = ""                                                            -- 4
    local jsonDataKeys = {}
    for i, v in pairs(jsonData) do
        table.insert(jsonDataKeys, i)
    end
    table.sort(jsonDataKeys)
    for i, v in pairs(jsonDataKeys) do
        concat = concat..v..jsonData[v ]
    end

    concat = Framework.Tools.LuaToolkit.md5(concat)

    local md = Framework.Tools.LuaToolkit.md5(timestamp..nonce..key..concat)     -- 11

    local uuid = md..nonce..timestamp
    return uuid
end

function AVGBulletMixin:checkBulletContent(text)
    local res=string.gsub(text,"\r\n","")
    local largeLength=0
    for s in string.gmatch(res,"<.->") do
        if emojiDic.single[s] then
            largeLength=string.len(s)
            if string.len(res)~=largeLength then
                res=string.gsub(res,s,"*")
                break
            end
        elseif not emojiDic.more[s] then
            res=string.gsub(res,s,"*")
        end
    end
    return res
end

function AVGBulletMixin:_getAVGBulletUserInfo()
    local curToken = AccountManager.getToken()
    local data = {token = curToken}
    return data
end

return AVGBulletMixin