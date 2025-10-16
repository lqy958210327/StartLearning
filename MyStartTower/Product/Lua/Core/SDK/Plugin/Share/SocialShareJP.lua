local SDKConst = require("Core/SDK/SDKConst")
local AttName = SDKConst.AttName
local SocialShareBase = require("Core/SDK/Plugin/Share/SocialShareBase")
local DeviceHelper = require("Core/Helper/DeviceHelper")
local VersionUtils = require("Core/System/VersionUtils")
local SocialShareJP = Class("SocialShareJP", SocialShareBase)

local GMShareContentType =
{
    GMShareContentTypeText = 0,
    GMShareContentTypeImage = 1,
    GMShareContentTypeWebPage = 3,
    GMShareContentTypeVideo = 4
}

SocialShareJP.sharePlatform = {
    GMUGShareSourceNone = 0,
    --/*** 国内支持渠道 ***/
    GMUGShareSourceQQZone = 1, --/** 支持：链接 */
    GMUGShareSourceQQFriend = 2, --/** 支持：文本，图片，链接 */
    GMUGShareSourceWeChatFriend = 3, --/** 支持：文本，图片，链接，视频 */
    GMUGShareSourceWeChatTimeLine = 4, --/** 支持：文本，图片，链接，视频 */
    GMUGShareSourceWeibo = 5, --/** 支持：文本，图片，链接 */
    GMUGShareSourceAwe = 6, --/** 支持：图片，视频 */
    --/*** 海外支持渠道 ***/
    GMUGShareSourceFacebook = 7, --/** 支持：图片，链接，视频 */
    GMUGShareSourceMessenger = 8, --/** 支持：图片，链接 */
    GMUGShareSourceInstagram = 9, --/** 支持：图片，视频 */
    GMUGShareSourceWhatsApp = 10, --/** 支持：文本，图片，链接，视频 */
    GMUGShareSourceLine = 11, --/** 支持：文本，图片，链接 */
    GMUGShareSourceKakao = 12, --/** 支持：图片，链接 */
    GMUGShareSourceTiktok = 13, --/** 支持：视频 */
    GMUGShareSourceTwitter = 14, --/** 支持：文本，图片，链接，视频 */
    GMUGShareSourceSystem = 15, --/** 支持：文本，图片，链接 */
    --/*** 国内支持渠道 ***/
    GMUGShareSourceAweIM = 16, --/** 支持：图片，链接 */
}
local idx2Platform = {
    "GMUGShareSourceNone",
    "GMUGShareSourceQQZone",
    "GMUGShareSourceQQFriend",
    "GMUGShareSourceWeChatFriend",
    "GMUGShareSourceWeChatTimeLine",
    "GMUGShareSourceWeibo",
    "GMUGShareSourceAwe",
    "GMUGShareSourceFacebook",
    "GMUGShareSourceMessenger",
    "GMUGShareSourceInstagram",
    "GMUGShareSourceWhatsApp",
    "GMUGShareSourceLine",
    "GMUGShareSourceKakao",
    "GMUGShareSourceTiktok",
    "GMUGShareSourceTwitter",
    "GMUGShareSourceSystem",
    "GMUGShareSourceAweIM",
}

function SocialShareJP:getShareConfig()
    if DeviceHelper.isIOS() then
        return nil
    elseif DeviceHelper.isAndroid() then
        local config = {
            [self.sharePlatform.GMUGShareSourceTwitter] = {true},
            -- [self.sharePlatform.GMUGShareSourceTiktok] = {true},
        }
        return config
    end
end

function SocialShareJP:getSharePlatforms()
    local sharePlatforms = {}
    if VersionUtils.IsReviewVersion() then
        return sharePlatforms
    end

    local platform1 = {
        platform = self.sharePlatform.GMUGShareSourceTwitter,
        filePath = "Atlas/ArAtlas",
        spriteName = "BtnTwitter"
    }
    table.insert(sharePlatforms, platform1)
    -- if DeviceHelper.isAndroid() then        -- 字节的iOS分享不支持   or IS_EDITOR
    --      local platform2 = {
    --          platform = self.sharePlatform.GMUGShareSourceFacebook,
    --          filePath = "Atlas/ArAtlas",
    --          spriteName = "BtnFacebook"
    --      }
    --      table.insert(sharePlatforms, platform2)
    -- end

    return sharePlatforms
end

function SocialShareJP:shareText(platform, title)
    local shareData = {}
    shareData[AttName.SHARE_TYPE] = GMShareContentType.GMShareContentTypeText
    shareData[AttName.SHARE_PLATFORM] = platform  -- 14    -- SocialShareJP.sharePlatform.GMUGShareSourceTwitter
    shareData[AttName.SHARE_INFO_TITLE] = title
    SDKAgent.share(shareData)
end

function SocialShareJP:sharePicture(platform, picPath, text)
    if VersionUtils.getEngineVersion() <= 152097 then
        local platformData = SDKAgent.getPlatformData()
        if platformData and platformData["phone_model"] then
            if string.find(platformData["phone_model"], "iPad") then
                UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "确认", "現在iPadでTwiiterへのシェアはサポートできない仕様となっております、スマートフォンにて操作してください。" )
                return
            end
        end
    end
    local shareData = {}
    shareData[AttName.SHARE_TYPE] = GMShareContentType.GMShareContentTypeImage
    shareData[AttName.SHARE_PLATFORM] = platform  -- 14    -- SocialShareJP.sharePlatform.GMUGShareSourceTwitter
    shareData[AttName.SHARE_IMG_LOCAL_URL] = picPath
    shareData[AttName.SHARE_INFO_TITLE] = text
    SDKAgent.share(shareData)
    self:sendByteShareLog(platform)
end

function SocialShareJP:sendByteShareLog(platform)
    --platform = tonumber(platform)
    if CurAvatar then

    end
end

function SocialShareJP:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
    local shareData = {}
    shareData[AttName.SHARE_TYPE] = GMShareContentType.GMShareContentTypeWebPage
    shareData[AttName.SHARE_PLATFORM] = platform  -- 14    -- SocialShareJP.sharePlatform.GMUGShareSourceTwitter
    shareData[AttName.SHARE_TARGET_URL] = url
    -- shareData[AttName.SHARE_IMG_LOCAL_URL] = picPath
    shareData[AttName.SHARE_INFO_CONTENT] = text
    shareData[AttName.SHARE_INFO_TITLE] = title
    SDKAgent.share(shareData)
end

function SocialShareJP:shareVideo(platform, videoUrl, videoLocal)
    local shareData = {}
    shareData[AttName.SHARE_TYPE] = GMShareContentType.GMShareContentTypeVideo
    shareData[AttName.SHARE_PLATFORM] = platform  -- 14    -- SocialShareJP.sharePlatform.GMUGShareSourceTwitter
    -- shareData[AttName.SHARE_VIDEO_URL] = videoUrl
    shareData[AttName.SHARE_VIDEO_LOCAL_URL] = videoLocal
    SDKAgent.share(shareData)
end

function SocialShareJP:onShareFinish(ret, data)
    if DeviceHelper.isIOS() then
        local result = tonumber(data[AttName.RESULT]) == 1
        local msg
        if result then
            msg = "分享成功"
        else
            msg = "分享失败"
        end
        MsgManager.notice(msg)
    elseif DeviceHelper.isAndroid() then
        local errorCode = tonumber(data["code"])
        -- local errorMsg = data["message"]
        if errorCode == 10000 then
            MsgManager.notice("分享成功")
        elseif errorCode == 10014 then
            MsgManager.notice("シェア失敗しました。Twitterをインストールしてください。")
        else
            MsgManager.notice("分享失败")
        end
    end
end

return SocialShareJP