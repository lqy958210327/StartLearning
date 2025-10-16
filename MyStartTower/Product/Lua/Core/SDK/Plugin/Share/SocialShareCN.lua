local SocialShareAgent = Framework.Plugin.SocialShareAgent
local MsgManager = MsgManager
local FileUtils = Framework.Tools.FileUtils
local DeviceHelper = require("Core/Helper/DeviceHelper")
local VersionUtils = require("Core/System/VersionUtils")
local SocialShareBase = require("Core/SDK/Plugin/Share/SocialShareBase")

local SocialShareCN = Class("SocialShareCN", SocialShareBase)
--local self = SocialShareCN

local SocialShareEventType = {
    SHARE_FINISH = 0,
}

local SocialShareType =
{
    Auto = 0,              -- 自动(iOS为自动，安卓仅为Text)
    Text = 1,              -- 文字分享
    Image = 2,             -- 图文分享
    Webpage = 4,           -- 链接分享
    Music = 5,             -- 音乐分享
    Video = 6,             -- 视频分享
    App = 7,               -- 应用分享
    File = 8,              -- 附件分享
    Emoji = 9,             -- 表情分享
}
SocialShareCN.SocialShareType = SocialShareType

local Platform =
{
    SINA_WEIBO = 1,          -- Sina Weibo
    QZONE = 6,               -- QZone
    WECHAT = 22,             -- WeChat Friends
    WECHAT_MOMENTS = 23,     -- WeChat WechatMoments
    QQ = 24,                 -- QQ
    WECHAT_PLATFORM_ANDROID = 22,
    QQ_PLATFORM_ANDROID = 24,
    WECHAT_FAV = 37,
    WECHAT_PLATFORM_IOS = 997,   -- Wechat Series
    QQ_PLATFORM_IOS = 998,       -- QQ Series

    FACEBOOK = 10,
    TWITTER = 11,
    INSTAGRAM = 15,
    LINE = 42,
}

SocialShareCN.SocialSharePlatform = Platform

local paramKeys = {
    TITLE           = "title",               --/*iOS/Android*/
    TITLE_URL       = "titleUrl",            --/*iOS/Android*/
    TEXT            = "text",                --/*iOS/Android*/
    URL             = "url",                 --/*iOS/Android*/
    IMG_URL         = "imageUrl",            --/*iOS/Android*/
    COMMENT         = "comment",             --/*iOS/Android*/
    SITE            = "site",                --/*iOS/Android*/
    THUMB_IMG_URL   = "thumbImageUrl",       --/*iOS Only - QQ/Wechat/Yixin*/
    CLIENT_SHARE    = "clientShare",         --/*FaceBook*/
}

SocialShareCN.enableEdit = false

local APP_KEY = "30024dc36b5d0";
local APP_SECRET = "f5ab96c32b81004262386fe8ea1b4d47";

local SinaParams = {
            ["Enable"] = "true",
            ["AppSecret"] = "e997eb397314ec44e710a775b31724b5",
            ["AppKey"] = "1330572700",
            ["RedirectUrl"] = "https://s8etk.share2dlink.com/",
        }

local platformConfig = {
    -- iOS
    ["com.ffg.antman"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["app_universalLink"] = "https://s8etk.share2dlink.com/",
            ["app_secret"] = "cd4de354c31aab317c733c3e5506c92e",
            ["app_id"] = "wx388f3ac0c499e0c0",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["app_universalLink"] = "https://s8etk.share2dlink.com/qq_conn/1110395842",
            ["app_secret"] = "QUzoTCeLkmf0nRSm",
            ["app_id"] = "1110395842",
        },

        [tostring(Platform.SINA_WEIBO)] = {
            ["Enable"] = "true",
            ["redirect_uri"] = "https://s8etk.share2dlink.com/",
            ["app_secret"] = "e997eb397314ec44e710a775b31724b5",
            ["app_key"] = "1330572700",
        },
    },

    -- Android
    --tap&好游快爆
    ["com.gnsbt.Shgame"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "c8cbf28e7d2780f4287fb98976f6eb44",
            ["AppId"] = "wx5d7cf5507391aa00",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "13b07bf5a5ac78ce1db76810bd7712e7",
            ["AppId"] = "101903294",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- B站
    ["com.gnsbt.Shgame.bilibili"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "e9c8b6eef2096d9855271f9325d32f41",
            ["AppId"] = "wx7a3b53d02c2e29f5",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "13b07bf5a5ac78ce1db76810bd7712e7",
            ["AppId"] = "101903294",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- OPPO
    ["com.gnsbt.Shgame.nearme.gamecenter"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "f541f584cfff5effe1f5988b896e8df5",
            ["AppId"] = "wx8294e7f8befe8e5f",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "13b07bf5a5ac78ce1db76810bd7712e7",
            ["AppId"] = "101903294",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- aligames
    ["com.gnsbt.Shgame.aligames"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "c9243e01b1a317ff27efed19b8365dc3",
            ["AppId"] = "wxe668ab1d9903eafe",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "13b07bf5a5ac78ce1db76810bd7712e7",
            ["AppId"] = "101903294",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- 4399
    ["com.gnsbt.Shgame.m4399"] = {
         [tostring(Platform.WECHAT)] = {
             ["Enable"] = "true",
             ["AppSecret"] = "210de333263ee11e8b78dc8b1107d15d",
             ["AppId"] = "wxce3bd15f0742fb2f",
         },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "13b07bf5a5ac78ce1db76810bd7712e7",
            ["AppId"] = "101903294",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- VIVO
    ["com.gnsbt.Shgame.vivo"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "cd919c7f790217644096544f65486591",
            ["AppId"] = "wxece496f59bebf976",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "13b07bf5a5ac78ce1db76810bd7712e7",
            ["AppId"] = "101903294",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- YYB
    ["com.tencent.tmgp.gnsbt"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "cd4de354c31aab317c733c3e5506c92e",
            ["AppId"] = "wx388f3ac0c499e0c0",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "QUzoTCeLkmf0nRSm",
            ["AppId"] = "1110395842",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- XY
    ["com.sh.figurestory"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "3b414621cb2e27a3237fc79d90a90aed",
            ["AppId"] = "wx3c384a379ef67680",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "f0357f4b6c8e26cd9da440ebac396cef",
            ["AppId"] = "101903304",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- 华为
    ["com.gnsbt.Shgame.huawei"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "3e690db3a50153cf69f83a68cd538dea",
            ["AppId"] = "wx7b20e0f14fc6d246",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "f0357f4b6c8e26cd9da440ebac396cef",
            ["AppId"] = "101903304",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- 魅族
    ["com.gnsbt.Shgame.mz"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "e2a2c66839bf7417a247fd928890e6a5",
            ["AppId"] = "wx4f2421a5433d34b5",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "f0357f4b6c8e26cd9da440ebac396cef",
            ["AppId"] = "101903304",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- 小米
    ["com.gnsbt.Shgame.mi"] = {
        [tostring(Platform.WECHAT)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "16f81aba9167ac184fd1950fc41af395",
            ["AppId"] = "wxadc3be9695d09387",
        },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "f0357f4b6c8e26cd9da440ebac396cef",
            ["AppId"] = "101903304",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- VIVO子包
    ["com.gnsbt.Shgame.vivoad.vivo"] = {
        -- [tostring(Platform.WECHAT)] = {
        --     ["Enable"] = "true",
        --     ["AppSecret"] = "cd919c7f790217644096544f65486591",
        --     ["AppId"] = "wxece496f59bebf976",
        -- },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "f0357f4b6c8e26cd9da440ebac396cef",
            ["AppId"] = "101903304",
        },
    },

    -- 360
    ["com.gnsbt.Shgame.qh360"] = {
        -- [tostring(Platform.WECHAT)] = {
        --     ["Enable"] = "true",
        --     ["AppSecret"] = "cd919c7f790217644096544f65486591",
        --     ["AppId"] = "wxece496f59bebf976",
        -- },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "8f45100bc529b0837b1150568ebc47c8",
            ["AppId"] = "101899289",
        },
    },

    -- baidu
    ["com.gnsbt.Shgame.g.baidu"] = {
        -- [tostring(Platform.WECHAT)] = {
        --     ["Enable"] = "true",
        --     ["AppSecret"] = "cd919c7f790217644096544f65486591",
        --     ["AppId"] = "wxece496f59bebf976",
        -- },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "8f45100bc529b0837b1150568ebc47c8",
            ["AppId"] = "101899289",
        },
    },

    -- 金立
    ["com.gnsbt.Shgame.am"] = {
        -- [tostring(Platform.WECHAT)] = {
        --     ["Enable"] = "true",
        --     ["AppSecret"] = "cd919c7f790217644096544f65486591",
        --     ["AppId"] = "wxece496f59bebf976",
        -- },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "8f45100bc529b0837b1150568ebc47c8",
            ["AppId"] = "101899289",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- 联想
    ["com.gnsbt.Shgame.lenovo"] = {
        -- [tostring(Platform.WECHAT)] = {
        --     ["Enable"] = "true",
        --     ["AppSecret"] = "cd919c7f790217644096544f65486591",
        --     ["AppId"] = "wxece496f59bebf976",
        -- },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "8f45100bc529b0837b1150568ebc47c8",
            ["AppId"] = "101899289",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- 酷派
    ["com.gnsbt.Shgame.coolpad"] = {
        -- [tostring(Platform.WECHAT)] = {
        --     ["Enable"] = "true",
        --     ["AppSecret"] = "cd919c7f790217644096544f65486591",
        --     ["AppId"] = "wxece496f59bebf976",
        -- },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "8f45100bc529b0837b1150568ebc47c8",
            ["AppId"] = "101899289",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- 努比亚
    ["com.gnsbt.Shgame.nubia"] = {
        -- [tostring(Platform.WECHAT)] = {
        --     ["Enable"] = "true",
        --     ["AppSecret"] = "cd919c7f790217644096544f65486591",
        --     ["AppId"] = "wxece496f59bebf976",
        -- },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "8f45100bc529b0837b1150568ebc47c8",
            ["AppId"] = "101899289",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- mumu
    ["com.gnsbt.Shgame.yofun"] = {
        -- [tostring(Platform.WECHAT)] = {
        --     ["Enable"] = "true",
        --     ["AppSecret"] = "cd919c7f790217644096544f65486591",
        --     ["AppId"] = "wxece496f59bebf976",
        -- },

        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "f0357f4b6c8e26cd9da440ebac396cef",
            ["AppId"] = "101903304",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- 快手
    ["com.gnsbt.Shgame.kuaishou"] = {
        [tostring(Platform.QQ)] = {
            ["Enable"] = "true",
            ["AppSecret"] = "e00ac96a1c4420239ecfa266887cd2b1",
            ["AppId"] = "101916497",
        },

        [tostring(Platform.SINA_WEIBO)] = SinaParams,
    },

    -- FLOW
    ["com.xgjoy.antman"] = {
        [tostring(Platform.WECHAT)] = {
            -- ["BypassApproval"] = "true",
            -- ["Path"] = "/page/API/pages/share/share",
            ["Enable"] = "true",
            ["AppSecret"] = "b75e7d6479200aa82ac14410ee61ee73",
            ["AppId"] = "wxf226020e7669c95b",
        },

        -- [tostring(Platform.QQ)] = {
        --     ["Enable"] = "true",
        --     ["app_secret"] = "QUzoTCeLkmf0nRSm",
        --     ["app_id"] = "1110395842",
        -- },
    },
}

SocialShareCN.platformConfig = platformConfig

local showWeChat =
{
    -- iOS
    ["com.ffg.antman"] = true,

    -- Android
    --tap&好游快爆
    ["com.gnsbt.Shgame"] = true,

    -- B站
    ["com.gnsbt.Shgame.bilibili"] = true,

    -- OPPO
    ["com.gnsbt.Shgame.nearme.gamecenter"] = true,

    -- aligames
    ["com.gnsbt.Shgame.aligames"] = true,

    -- 4399
    ["com.gnsbt.Shgame.m4399"] = true,

    -- VIVO
    ["com.gnsbt.Shgame.vivo"] = true,

    -- YYB
    ["com.tencent.tmgp.gnsbt"] = true,

    -- XY
    ["com.sh.figurestory"] = true,

    -- 华为
    ["com.gnsbt.Shgame.huawei"] = true,

    -- 魅族
    --["com.gnsbt.Shgame.mz"],

    -- 小米
    ["com.gnsbt.Shgame.mi"] = true,

    -- VIVO子包
    --["com.gnsbt.Shgame.vivoad.vivo"],

    -- 360
    --["com.gnsbt.Shgame.qh360"],

    -- baidu
    --["com.gnsbt.Shgame.g.baidu"],

    -- 金立
    --["com.gnsbt.Shgame.am"],

    -- 联想
    --["com.gnsbt.Shgame.lenovo"],

    -- 酷派
    --["com.gnsbt.Shgame.coolpad"],

    -- 努比亚
    --["com.gnsbt.Shgame.nubia"],

    -- mumu
    --["com.gnsbt.Shgame.yofun"],

    -- 快手
    --["com.gnsbt.Shgame.kuaishou"],

    -- FLOW
    --["com.xgjoy.antman"],
}
SocialShareCN.showWeChat = showWeChat

function SocialShareCN:setStrategy(newStrategyNo)
    self.packageName = UnityEngine.Application.identifier --"com.ffg.antman"
    self.curConfig = platformConfig[self.packageName]
    -- dev use yyb as falllback
    if not IS_PUBLISH_VERSION then
        if self.curConfig == nil then
            self.curConfig = platformConfig["com.tencent.tmgp.gnsbt"]
        end
    end
    -- no config, fallback to dummy
    if not self.curConfig then
        newStrategyNo = 0
    end
    SocialShareAgent.SetStrategy(newStrategyNo)
end

function SocialShareCN:init(strategyNo)
    local curConfig = self.curConfig
    if curConfig then
        local jsonConfig = ClientUtils.table2String(curConfig)
        -- print("jsonConfig:", jsonConfig)
        SocialShareAgent.Init(APP_KEY, APP_SECRET, jsonConfig)
        SocialShareAgent.SetLuaEventCallback(SocialShareCN.onGetEvent)
    end
end

function SocialShareCN:getShareConfig()
    local config = {
        [Platform.WECHAT]         = {false},
        [Platform.WECHAT_MOMENTS] = {true},
        [Platform.SINA_WEIBO]     = {true},
        [Platform.QQ]             = {false},
        [Platform.QZONE]          = {true},
        [Platform.FACEBOOK]       = {false},
    }
    return config
end

function SocialShareCN:getSharePlatforms()
    if not VersionUtils.hasAbilityShareCN() then
        return {}
    end
    local sharePlatforms = {}
    if  SocialShareCN.platformConfig[self.packageName] and SocialShareCN.platformConfig[self.packageName][tostring(Platform.SINA_WEIBO)] then
        local platform0 = {
            platform = Platform.SINA_WEIBO,
            filePath = "Atlas/ArAtlas",
            spriteName = "BtnWeiBo"
        }
        if DeviceHelper.isAndroid() then
            table.insert(sharePlatforms, platform0)
        elseif DeviceHelper.isIOS() then
            if VersionUtils.getEngineVersion() >= 110692 then       -- 110692   111398
                table.insert(sharePlatforms, platform0)
            end
        end
    end

    if SocialShareCN.showWeChat[self.packageName] then  -- 用于微信分享一个个开放
        local platform1 = {
            platform = Platform.WECHAT,
            filePath = "Atlas/ArAtlas",
            spriteName = "BtnWeChat"
        }
        local platform2 = {
            platform = Platform.WECHAT_MOMENTS,
            filePath = "Atlas/ArAtlas",
            spriteName = "BtnWeChatCircle"
        }
        if DeviceHelper.isAndroid() then
            local androidVersion = UnityEngine.SystemInfo.operatingSystem
            if not string.find(androidVersion, "API-30") or VersionUtils.getEngineVersion() > 110692 then       -- Android11 不能微信分享，或者换了新包
                table.insert(sharePlatforms, platform1)
                table.insert(sharePlatforms, platform2)
            end
        elseif DeviceHelper.isIOS() then
            table.insert(sharePlatforms, platform1)
            table.insert(sharePlatforms, platform2)
        end
    end

    local platform3 = {
        platform = Platform.QQ,
        filePath = "Atlas/ArAtlas",
        spriteName = "BtnQQ"
    }
    table.insert(sharePlatforms, platform3)

    local platform4 = {
        platform = Platform.QZONE,
        filePath = "Atlas/ArAtlas",
        spriteName = "BtnQQSpace"
    }
    table.insert(sharePlatforms, platform4)

    return sharePlatforms
end

SocialShareCN.MAX_PIXEL_COUNT = 1920 * 1080

function SocialShareCN:getPhotoResolution()
    local width, height = DeviceHelper.curWidth, DeviceHelper.curHeight
    if width and height then
        local pixelNum = width * height
        if pixelNum > SocialShareCN.MAX_PIXEL_COUNT then
            local scale = (SocialShareCN.MAX_PIXEL_COUNT / pixelNum) ^ 0.5
            scale = math.floor(scale * 20) / 20
            width = math.floor(width * scale)
            height = math.floor(height * scale)
        end
    else
        width, height = 0, 0
    end
    print(width, height)
    return width, height
end




function SocialShareCN:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
    if platform and (picPath or imageUrl) and title and text then
        SocialShareAgent.ShareContent(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
    else
        MsgManager.notice("title、image、url这三个参数不能为空")
    end
end



SocialShareCN._CSEventHandler = {
    [SocialShareEventType.SHARE_FINISH] = "onShareFinish",
}

function SocialShareCN.onGetEvent(eventType, ret, arg1, arg2)
    print("onGetEvent", eventType, ret, arg1, arg2)
    local funcName = SocialShareCN._CSEventHandler[eventType]
    if funcName then
        local func = SocialShareCN[funcName]
        if func then
            func(ret, arg1)
        end
    end
end


local ResponseState = {
    Begin = 0,              -- Begin
    Success = 1,            -- Success
    Fail = 2,               -- Failure
    Cancel = 3,             -- Cancel
    BeginUPLoad = 4,        -- iOS 视频开始上传 youtube facebook Twitter v3.6.3
}

function SocialShareCN:onShareFinish(ret, resultJson)
    print("result", ret, resultJson, SocialShareCN.reqId)
    local msg = "分享结束"
    if ret == ResponseState.Success then
        msg = "分享成功"
    elseif ret == ResponseState.Fail then
        msg = "分享失败"
    elseif ret == ResponseState.Cancel then
        msg = "分享取消"
    end
    MsgManager.notice(msg)
end



return SocialShareCN