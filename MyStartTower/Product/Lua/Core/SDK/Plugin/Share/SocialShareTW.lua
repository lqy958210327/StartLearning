local SocialShareBase = require("Core/SDK/Plugin/Share/SocialShareBase")
local SocialShareTW = Class("SocialShareTW", SocialShareBase)

--local DeviceHelper = require("Core/Helper/DeviceHelper")
local SDKConst = require("Core/SDK/SDKConst")
local AttName = SDKConst.AttName

local Platform =
{
    FACEBOOK_WITH_CONTENT = 1001,
    FACEBOOK_WITH_IMAGE = 1002,
    TWITTER_WITH_CONTENT = 1101,
    TWITTER_WITH_IMAGE = 1102,
}

function SocialShareTW:getShareConfig()
    local config = {
        [Platform.FACEBOOK_WITH_IMAGE] = {false},
        [Platform.TWITTER_WITH_IMAGE] = {true},
    }
    return config
end

function SocialShareTW:getSharePlatforms()
    local sharePlatforms = {}
    local platform1 = {
        platform = Platform.FACEBOOK_WITH_IMAGE,
        filePath = "Atlas/ArAtlas",
        spriteName = "BtnFacebook"
    }
    table.insert(sharePlatforms, platform1)

    --local platform2 = {
    --    platform = Platform.TWITTER_WITH_IMAGE,
    --    filePath = "Atlas/ArAtlas",
    --    spriteName = "BtnTwitter"
    --}
    --table.insert(sharePlatforms, platform2)

    return sharePlatforms
end

function SocialShareTW:sharePicture(platform, picPath, text)
    local data = {}
    data[AttName.SHARE_ID] = platform
    data[AttName.SHARE_IMG_LOCAL_URL] = picPath
    if not text then
        text = "《高能手办团》来了额"
    end
    data[AttName.SHARE_INFO_CONTENT] = text
    SDKAgent.share(data)
end

function SocialShareTW:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
    local data = {}
    data[AttName.SHARE_ID] = platform
    data[AttName.SHARE_TARGET_URL] = url
    data[AttName.SHARE_INFO_CONTENT] = text
    SDKAgent.share(data)
end

function SocialShareTW:onShareFinish(ret, data)
    local result = tonumber(data[AttName.RESULT]) == 1
    local msg
    if result then
        msg = "分享成功"
    else
        msg = "分享失败"
    end
    MsgManager.notice(msg)
end


return SocialShareTW