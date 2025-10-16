
local SocialShareBase = Class("SocialShareBase")
local SDKConst = require("Core/SDK/SDKConst")
SocialShareBase.AttName = SDKConst.AttName

function SocialShareBase:ctor()

end

function SocialShareBase:setStrategy(newStrategyNo)

end

function SocialShareBase:init(strategyNo)

end

function SocialShareBase:getShareConfig()
    return nil
end

function SocialShareBase:getSharePlatforms()
    return {  }
end

function SocialShareBase:getPhotoResolution()
    return nil
end

function SocialShareBase:shareText(platform, title)

end

function SocialShareBase:sharePicture(platform, picPath, text)

end

function SocialShareBase:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)

end

function SocialShareBase:shareVideo(platform, videoUrl, videoLocal)

end

function SocialShareBase:shareWebpageJson(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)

end

function SocialShareBase:onGetEvent(eventType, ret, arg1, arg2)

end

function SocialShareBase:onShareFinish(ret, resultJson)

end


return SocialShareBase