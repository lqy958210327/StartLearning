-- 只客户端使用的一些工具函数
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local LuaToolkit = Framework.Tools.LuaToolkit

local VersionUtils = {}

-- 能力对应的Engine版本
local ABILITY_VERSION = {
    ABILITY_WARM_UP_SHADER_LUA = 77824,         -- shader的warmup接口暴露给lua, LuaToolkit.WarmUpShader
    ABILITY_AR_ANDROID_OTHER_CAMERA = 89298,    -- AR使用另一个Android相机，ARUtils.UseOtherAndroidCamera
    ABILITY_FORUM = 89198,                      -- 打开论坛，SDKAgent.openForum
    ABILITY_PATCH_V2 = 91611,                   -- Patch迭代，每次都会有文件（size/md5）对比，用md5作为索引进行下载
    ABILITY_FORUM_V2 = 91812,                   -- 新的论坛,Android更换内核，解决Android6.0以下的白屏问题
    READ_BYTES_CSHARP = 98822,                  -- C#提供的加载bytes接口，可支持中文路径和读取包体里的文件
    LOCALIZATION = 101618,                      -- 本地化相关接口
    SUBPACKAGE_V2 = 99106,                      -- 包体内资源过少时，在patch后提早下载分包，主要涉及一些已下载文件大小的接口
    URL_GROUP = 112975,                         -- url组，用在多线容错，对应的HTTP服务会在连接失败后切换url
    NETSERVICE_JSON = 114672,                   -- NetService连接游戏服务器时是否有额外参数json
    QUALITY_SETTINGS_V1 = 112000,               -- 画质选项的c#版本1， 包含Flare，HeightFog，SoftMask
    SUBPACKAGE_V3 = 118075,                     -- 使用patch_info_full的版本，整合patch和分包功能，支持lazyRes
    NEW_CUSTOMERSERVICE = 121817,               -- 客服网址更新
    CIRCLE_BATTLE = 119292,                     -- 公会战玩法支持
    PERMISSION_V2 = 141395,                     -- 申请权限的原因（rationale）单独设置
    UNITY_GC = 144654,                          -- lua调用c# 的UnityGC
    EMULATOR_CHECK = 144931,                    -- 模拟器的判定
    FONT_TEXTURE = 150000,                      -- 字体Texture的生成
}

VersionUtils.ABILITY_VERSION = ABILITY_VERSION

function VersionUtils.getVersionName()
    return LuaToolkit.GetVersionName()
end

function VersionUtils.getBattleDataVersion()
    local BattleMiscConfig = require "Core/Common/BattleMiscConfig"
    return BattleMiscConfig.BATTLE_MODIFY_VERSION
end

function VersionUtils.getDocumentPatchVersion()
    return LuaToolkit.GetLocalPatchVersionLCR()
end

VersionUtils.fakeEngineVersion = -1

function VersionUtils.getEngineVersion()
    if VersionUtils.fakeEngineVersion >= 0 then
        return VersionUtils.fakeEngineVersion
    end

    if IS_EDITOR then
        return Const.CSHARP_EDIT_VERSION
    end

    local pkgPV = LuaToolkit.GetPkgPatchVersion()
    return pkgPV.engineRvn
end

function VersionUtils.IsReviewVersion(ignoreRemoteConfig)
    local isReview = false
    local spMark = LuaToolkit.GetPatchSPMark()
    local postfix = LuaToolkit.GetPatchPostfix()
    if spMark and postfix ~= "pre" then
        if string.find(spMark, "review") then
            isReview = true
        end
    end
    if not ignoreRemoteConfig then
        isReview = isReview or false
    end
    return isReview
end

function VersionUtils.isSpMark(needMark)
    local spMark = LuaToolkit.GetPatchSPMark()
    return needMark == spMark
end

function VersionUtils.IsRechargeDisabled()
    --return true
    if VersionUtils._IsRechargeDisabled == nil then
        local isDisabled = false
        VersionUtils._IsRechargeDisabled = isDisabled
    end
    return VersionUtils._IsRechargeDisabled
end



function VersionUtils._hasEngineAbility(ability)
    local version = ABILITY_VERSION[ability]
    if version and version <= VersionUtils.getEngineVersion() then
        return true
    end
    return false
end

function VersionUtils.hasAbilityWarmUpShaderByLua()
    return VersionUtils._hasEngineAbility('ABILITY_WARM_UP_SHADER_LUA')
end

function VersionUtils.hasAbilityAROtherCamera()
    return VersionUtils._hasEngineAbility('ABILITY_AR_ANDROID_OTHER_CAMERA')
end



function VersionUtils.hasAbilityPatchV2()
    return VersionUtils._hasEngineAbility('ABILITY_PATCH_V2')
end

function VersionUtils.hasAbilityLocalization()
    return VersionUtils._hasEngineAbility('LOCALIZATION') and LuaToolkit.GetRegion() ~= RegionConst.REGION_CN
end

function VersionUtils.hasAbilitySubpackageV2()
    return VersionUtils._hasEngineAbility('SUBPACKAGE_V2')
end

function VersionUtils.hasAbilityUrlGroup()
    return VersionUtils._hasEngineAbility('URL_GROUP') and Framework.Network.UrlGroup ~= nil
end

function VersionUtils.hasAbilitySubpackageV3()
    return VersionUtils._hasEngineAbility('SUBPACKAGE_V3')
end

function VersionUtils.hasAbilityNetserviceJson()
    return VersionUtils._hasEngineAbility('NETSERVICE_JSON')
end

function VersionUtils.hasAbilityQualitySettingsV1( )
    return VersionUtils._hasEngineAbility("QUALITY_SETTINGS_V1")
end

function VersionUtils.hasAbilityNewCustomerService()
    return VersionUtils._hasEngineAbility("NEW_CUSTOMERSERVICE")
end

function VersionUtils.hasAbilityCircleBattle( ... )
    return VersionUtils._hasEngineAbility("CIRCLE_BATTLE")
end

function VersionUtils.hasAbilityShareCN()
    if RegionUtils.isCN() then
        local version = VersionUtils.getEngineVersion()
        if version >= 138478 and version < 161238 then
            return false
        end
    end
    return true
    -- local engineRvn = VersionUtils.getEngineVersion()
    -- return engineRvn < 137876
end

function VersionUtils.hasAbilityPermissionV2()
    return VersionUtils._hasEngineAbility("PERMISSION_V2")
end

function VersionUtils.hasAbilityUnityGC(  )
    return VersionUtils._hasEngineAbility("UNITY_GC")
end

function VersionUtils.hasAbilityEmulatorCheck(  )
    return VersionUtils._hasEngineAbility("EMULATOR_CHECK")
end

return VersionUtils