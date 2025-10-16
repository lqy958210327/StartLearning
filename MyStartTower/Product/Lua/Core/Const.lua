-- 定义Lua中用到的常量数据
local Const = {}

------------------------------------------ ↓ 临时用 ↓ ------------------------------------------
Const.CSHARP_EDIT_VERSION = 500000
------------------------------------------ ↑ 临时用 ↑ ------------------------------------------
Const.GAME_NAME_FULL = "高能手办团"
Const.SUBPACKAGE_MINIMAL = 350 -- 已有资源需要达到这个大小(MB)才能进入到登录界面，否则启动分包下载

Const.DEFAULT_LOCATION = "CN"  -- CN, JP, EN
Const.MAIN_MENU_MODEL_STAGE = "ModelStage/NewDisplayModelStage"

Const.SWITCH_ACCOUNT_CHANNELS = {
    ['gionee'] = 1,
    ['yeshen'] = 1,
    ['leidian'] = 1,
    ['meizu'] = 1,
    ['nubia'] = 1,
}

-- 游戏状态
Const.STATE_LOGIN = "STATE_LOGIN" -- 游戏状态 登录
Const.STATE_MAIN = "STATE_MAIN" -- 游戏状态 主界面
Const.STATE_BATTLE = "STATE_BATTLE"-- 游戏状态 战斗

Const.AudioType = {
    SFX = 0,   -- 音效
    VOCAL = 1, -- 人声
}


Const.STATE_ENTER_REASON_JUMP          = 1 -- 因为跳转规则触发了状态改变

-- 相机相关
Const.CAMERA_GROUP_PREFAB              = "Prefab/Other/CameraGroup.prefab"
Const.CAMERA_CONTROL_NODE_FREE         = "Prefab/Other/FreeControllerNode.prefab"
Const.CAMERA_CONTROL_NODE_BATTLE       = "Prefab/Other/BattleTargetControllerNode.prefab"
Const.CAMERA_CONTROL_NODE_ANIMATOR     = "Prefab/Other/AnimatorControllerNode.prefab"
Const.CAMERA_CONTROL_NODE_SCENIC       = 'Prefab/Other/ScenicControllerNode.prefab'

-- 消息频道
Const.CHANNEL_WORLD                    = "kMsgChannelTypeGlobal" --世界
Const.CHANNEL_GUILD                    = "kMsgChannelTypeClan" --同盟
Const.CHANNEL_SHOUT                    = "kMsgChannelTypeHorn" --喇叭
Const.CHANNEL_NOTICE                   = "clientChannelNotice" --提示
Const.CHANNEL_TASK                     = "clientChannelTaskTip" --任务完成提示

Const.CHAT_SPEC_NOTICE_TYPE            = {
    NONE          = "kCSSpecialNoticeTypeNone",
    TRIGGER       = "kCSSpecialNoticeTypeTrigger",
    CIRCLE_BATTLE = "kCSSpecialNoticeTypeClanBattle",
    CIRCLE_SHARE  = "kCSSpecialNoticeTypeClanShare",
    DYNAMIC_ICON  = "kCSSpecialNoticeTypeDynamicExpression",
}

Const.STAGE_BONUS_STATE                =
{
    DIS = 1,
    NEXT = 2,
    GOT = 3,
    GET = 4,
}

-- 游戏跨天时间点
Const.TIME_NEXT_DAY                    = 6 * 3600 - 1 --早上6点
Const.TIME_ONE_DAY                     = 86400
Const.TIME_ONE_WEEK                    = 604800

-- 报错ID
Const.MONITOR_ID                       = {
    RECHARGE_FAILED = 100001,
    LOGIN_FAILED = 100002,
}

-- 功能开关key enmModuleSwitchKey
Const.SWITCH_KEY                       = {
    ANTI_ADDICTION = "kModuleSwitchKeyAntiAddiction",
}

Const.TEST_TYPE_A                      = 1
Const.TEST_TYPE_B                      = 2

-- Reload透传数据，用于Lua虚拟机重启
Const.RELOAD_KEY_SILENT_LOGIN          = "kReloadKeySilentLogin"
Const.RELOAD_KEY_OPEN_ID               = "kReloadKeyOpenID"
Const.RELOAD_KEY_OPEN_TOKEN            = "kReloadKeyOpenToken"
Const.RELOAD_KEY_SERVER_INFO           = "kReloadKeyServerInfo"

-- UserData的Key，避免碰撞
Const.UD_KEY_SVRLIST_ENTRY             = "kUserDataKeySvrlistEntry" --首次
Const.UD_KEY_SVRLIST_FULL              = "kUserDataKeySvrlistFull" --2次及多次
Const.UD_KEY_DEBUG_OPENID              = "kUserDataKeyOpenID"
Const.UD_KEY_DEBUG_TOKEN               = "kUserDataKeyToken"
Const.UD_KEY_NOTI_PERMISSION_REQUESTED = "kUserDataKeyNotiPermissionRequested"
Const.UD_KEY_NOTCH_ADAPT               = "kUserDataKeyNotchAdapt"
Const.UD_KEY_AGREEMENT                 = "kUserDataKeyAgreement"
Const.UD_KEY_LOGIN_TOKEN0              = "kUserDataKeyLoginToken0"
Const.UD_KEY_BATTLE_NEW_PLAN           = "kUserDataKeyBattleNewPlan"

-- ServerState
Const.SERVER_STATE_NORMAL              = 0
Const.SERVER_STATE_HIGH                = 1
Const.SERVER_STATE_RECOMMEND           = 2
Const.SERVER_STATE_MAINTAIN            = 3

-- RemoteConfig
Const.REMOTE_CONFIG_REVIEW             = "review"
Const.REMOTE_CONFIG_AGREEMENT          = "agreement"
Const.REMOTE_CONFIG_NO_OPEN_AGREEMENT  = "open_agreement"
Const.REMOTE_CONFIG_HIDE_BLOG          = "blog"
Const.REMOTE_CONFIG_HIDE_CONTACT       = "contact"
Const.REMOTE_CONFIG_HIDE_TMALL         = "tmall"
Const.REMOTE_CONFIG_HIDE_ACT_MALL      = "act_mall"
Const.REMOTE_CONFIG_HIDE_GIFT_EXCHANGE = "gift_exchange"
Const.REMOTE_CONFIG_HIDE_BBS           = "bbs"
Const.REMOTE_CONFIG_HIDE_LOGIN_MOVIE   = "login_movie"
Const.REMOTE_CONFIG_HIDE_SOCIAL_SHARE  = "social_share"
Const.REMOTE_CONFIG_HIDE_AR_DLG        = "ar_dlg"

-------------------------------------- ↓ 本地化相关↓ -------------------------------------
-- 移到RegionConst
-------------------------------------- ↑ 本地化相关 ↑ --------------------------------------

------------------------------------------ ↓ Account ↓ ------------------------------------------
-- 角色默认信息


-- RoleCreate 错误码
Const.CREATE_ROLE_NOERROR              = "kRoleCreateNoError"
Const.CREATE_ROLE_SYSTEM               = "kRoleCreateErrorSystem"
Const.CREATE_ROLE_INVALIDNAME          = "kRoleCreateErrorInvalidName"
Const.CREATE_ROLE_NAMEDUPLICATE        = "kRoleCreateErrorNameDuplicate"
Const.CREATE_ROLE_INVALIDNAMELENGTH    = "kRoleCreateErrorInvalidNameLength"
Const.CREATE_ROLE_DIRTYWORD            = "kRoleCreateErrorDirtyWord"
Const.CREATE_ROLE_INVALIDUTF8          = "kRoleCreateErrorInvalidUTF8"
Const.CREATE_ROLE_INVALIDRULE          = "kRoleCreateErrorInvalidRule"
Const.CREATE_ROLE_INVALIDLANG          = "kRoleCreateErrorInvalidLang"

--Rename 错误码
Const.RENAME_NO_ERROR                  = "kRoleRenameNoError"
Const.RENAME_ERROR_SYSTEM              = "kRoleRenameErrorSystem"
Const.RENAME_ERROR_INVALID_NAME        = "kRoleRenameErrorInvalidName"
Const.RENAME_ERROR_DUPLICATE           = "kRoleRenameErrorDuplicate"
Const.RENAME_ERROR_INVALID_NAME_LENGTH = "kRoleRenameErrorInvalidNameLength"
Const.RENAME_ERROR_DIRTY_WORD          = "kRoleRenameErrorDirtyWord"
Const.RENAME_ERROR_INVALIDUTF8         = "kRoleRenameErrorInvalidUTF8"
Const.RENAME_ERROR_INVALIDRULE         = "kRoleRenameErrorInvalidRule"
Const.RENAME_ERROR_INVALIDLANG         = "kRoleRenameErrorInvalidLang"
Const.RENAME_ERROR_NOT_ENOUGH_ITEM     = "kRoleRenameErrorNotEnoughItem"
Const.RENAME_ERROR_CD                  = "kRoleRenameErrorCD"
Const.RENAME_ERROR_NOT_ENOUGH_DIAMOND  = "kRoleRenameErrorNotEnoughDiamond"

-- Rename costType --改名消耗





Const.RECHARGE_TYPE_MONTHCARD          = 12
Const.RECHARGE_TYPE_MULTIPLE           = 14

-- 第五关前的详细节点类型














------------------------------------------ ↑ Account ↑ ------------------------------------------

------------------------------------------ ↓ Entity ↓ ------------------------------------------
-- Entity的类型
Const.WORLD_ENTITY_UNKNOWN             = 0
Const.WORLD_ENTITY_BATTLE_HERO         = 1
Const.WORLD_ENTITY_NPC                 = 3

-- 模型类型
Const.MODEL_TYPE                       = {
    ["Default"] = 0, -- 默认，用通用模型id加载模型，animator需要额外指认，可使用LOD
    ["Simple"] = 1,  -- 简单模型，直接指认avatar的path

    -- Old
    ["ShowMain"] = "show_info_main",       -- 展示（主界面），通用模型id里的展示信息，animator不需要指认
    ["ShowStepOne"] = "show_info_hero1",   -- 展示（英雄阶段1）
    ["ShowStepTwo"] = "show_info_hero2",   -- 展示（英雄阶段2）
    ["ShowDrag"] = "show_info_drag",       -- 布阵
    ["ShowResult"] = "show_info_result",   -- 结算
    ["PerformAct"] = "show_info_perform",  -- 挂机表演
    ["ARAct"] = "show_info_ar",            -- AR表演
    ["ShowSkinStatic"] = "show_info_skin", -- 皮肤的主界面显示规则
    ["RearHouse"] = "show_info_rear",      -- 后宅

    -- New
    ["ShowHero"] = "show_hero",   -- 展示
    ["ShowMain"] = "show_main",   -- 篝火
    ["ShowStory"] = "show_story", -- 剧情
}

Const.HERO_BASE_TYPE                   = {
    ["Main"] = "base_info_main",
    ["Hero1"] = "base_info_hero1",
    ["Battle"] = "base_info_battle",
    ["Rear"] = "base_info_rear",
}

Const.MODEL_LOD_LV0                    = 0
Const.MODEL_LOD_LV1                    = 1
Const.MODEL_LOD_LV2                    = 2

-- Layer采用int来表示，提高传输效率
Const.LAYER_UNDEFINED                  = -1
Const.LAYER_DEFAULT                    = 0
Const.LAYER_UI                         = 5
Const.LAYER_GROUND                     = 8
Const.LAYER_PLAYER                     = 9
Const.LAYER_NPC                        = 10
Const.LAYER_EFFECT                     = 11
Const.LAYER_PREVIEW                    = 12
Const.LAYER_DRAG                       = 13
Const.LAYER_MAINPLAYER                 = 14
Const.LAYER_DRAG_FIELD                 = 15
Const.LAYER_ROLE2                      = 19
Const.LAYER_PLAYER_HIDE                = 20
Const.LAYER_AVG_ROLE                   = 21
Const.LAYER_AR                         = 23
Const.LAYER_AVG_OUTSIDE                = 24

-- Entity可供注册的委托事件
Const.ENTITY_DELEGATE_EVENT            = {
    OnLoadEnd = 0,
    OnObjectSelected = 1,
    OnPartLoaded = 2,
    OnEnterTrigger = 3,
    OnExitTrigger = 4,
    OnObjectLongTap = 5,
    OnDisable = 6,
}

------------------------------------------ ↑ Entity ↑ ------------------------------------------


------------------------------------------ ↓ Effect ↓ ------------------------------------------
-- Effect的生命周期类型
Const.EFFECT_LIFE_MODE              = {
    ["JustPlay"] = 0,     -- 只管播放，不受逻辑管理, 自生自灭
    ["LogicControl"] = 1, -- 逻辑管理, 逻辑保证回收, 不随状态清除
    ["StateControl"] = 2, -- 随状态清除, 按组回收
}

-- DoTween所用到的变化曲线
Const.TWEEN_EASE                    = {}
Const.TWEEN_EASE.Linear             = 1
Const.TWEEN_EASE.InSine             = 2
Const.TWEEN_EASE.OutSine            = 3
Const.TWEEN_EASE.InOutSine          = 4
Const.TWEEN_EASE.InQuad             = 5
Const.TWEEN_EASE.OutQuad            = 6
Const.TWEEN_EASE.InOutQuad          = 7
Const.TWEEN_EASE.InCubic            = 8
Const.TWEEN_EASE.OutCubic           = 9
Const.TWEEN_EASE.InOutCubic         = 10
Const.TWEEN_EASE.InQuart            = 11
Const.TWEEN_EASE.OutQuart           = 12
Const.TWEEN_EASE.InOutQuart         = 13
Const.TWEEN_EASE.InQuint            = 14
Const.TWEEN_EASE.OutQuint           = 15
Const.TWEEN_EASE.InOutQuint         = 16
Const.TWEEN_EASE.InExpo             = 17
Const.TWEEN_EASE.OutExpo            = 18
Const.TWEEN_EASE.InOutExpo          = 19
Const.TWEEN_EASE.InCirc             = 20
Const.TWEEN_EASE.OutCirc            = 21
Const.TWEEN_EASE.InOutCirc          = 22
Const.TWEEN_EASE.InElastic          = 23
Const.TWEEN_EASE.OutElastic         = 24
Const.TWEEN_EASE.InOutElastic       = 25
Const.TWEEN_EASE.InBack             = 26
Const.TWEEN_EASE.OutBack            = 27
Const.TWEEN_EASE.InOutBack          = 28
Const.TWEEN_EASE.InBounce           = 29
Const.TWEEN_EASE.OutBounce          = 30
Const.TWEEN_EASE.InOutBounce        = 31

-- 效果屏蔽的flag
Const.SKIP_SCREEN_EFX               = false -- 屏蔽Effect中的screen特效
Const.SKIP_MODEL_EFX                = false -- 屏蔽模型特效
Const.SKIP_IMAGE_EFX                = false -- 屏蔽屏幕后处理

-- 场景中后处理文件的名字
Const.SCENE_PPB_DEFAULT             = "PostFxDefault"
Const.SCENE_PPB                     = {
    --[0] = "PostFxBattleEnd0",
    --[1] = "PostFxBattleEnd1",
    --[2] = "PostFxBattleEnd2",
    --[3] = "PostFxBattleEnd3",
}

Const.SCENE_LIGHT_DEFAULT           = "LightDefault"
Const.SCENE_LIGHT                   = {
    [-1] = "LightFormation",
    --[0] = "LightBattleEnd0",
    --[1] = "LightBattleEnd1",
    --[2] = "LightBattleEnd2",
    --[3] = "LightBattleEnd3",
}

------------------------------------------ ↑ Effect ↑ ------------------------------------------

------------------------------------------ ↓ UI ↓ ------------------------------------------
Const.NUMBER_TO_WORD                = {
    [1] = "一",
    [2] = "二",
    [3] = "三",
    [4] = "四",
    [5] = "五",
    [6] = "六",
    [7] = "七",
    [8] = "八",
    [9] = "九",
    [10] = "十",
}

------------------------------------------ ↑ UI ↑ ------------------------------------------

------------------------------------------ ↓ 邮件 ↓ ------------------------------------------
Const.MAIL_ATTACH_TYPE              = {
    ["None"] = "kMsgMailAttachExtendTypeNone",
    ["Hero"] = "kMsgMailAttachExtendTypeHero",
}

Const.MAX_MAIL_NUM                  = 50
Const.MAIL_TYPE_GVG                 = 1
Const.MAIL_TYPE_CIRCLE              = 2
Const.MAIL_TYPE_ASYNCPVP            = 3
Const.MAIL_TYPE_ASYNCPVP_DAILY      = 4
Const.MAIL_TYPE_CIRCLE_USER_DEFINED = 5

--发件人需要转换playername的邮件类型
Const.SHOW_PLAYERNAME_MAIL_TYPE     =
{
    [Const.MAIL_TYPE_CIRCLE_USER_DEFINED] = true,
}
------------------------------------------ ↑ 邮件 ↑ ------------------------------------------


------------------------------------------ ↓ Setting ↓ ------------------------------------------
-- 画质的分级
Const.GAME_QUALITY = {
    Low = 0,
    Fast = 1,
    Mid = 2,
    High = 3,
    Artist = 3,
}

Const.CV_LIST = {1,2,}

Const.CV_FIELD_ID_CN = 1
Const.CV_FIELD_ID_JP = 2
Const.CV_FIELD_ID_EN = 3
Const.CV_FIELD_ID_TW = 4
Const.CV_FIELD_ID_KR = 5

-- 资源的后缀
Const.CV_TYPE_STRING = {
    [Const.CV_FIELD_ID_CN] = "",
    [Const.CV_FIELD_ID_JP] = "JP",
    [Const.CV_FIELD_ID_EN] = "EN",
    [Const.CV_FIELD_ID_TW] = "TW",
    [Const.CV_FIELD_ID_KR] = "KR",
}
-- 按钮配置
Const.CV_BTN_NAME = {
    [Const.CV_FIELD_ID_CN] = { "中文配音", "Chinese" },
    [Const.CV_FIELD_ID_JP] = { "日文配音", "Japanese" },
    [Const.CV_FIELD_ID_EN] = { "英文配音", "English" },
    [Const.CV_FIELD_ID_TW] = { "台湾配音", "TW" },
    [Const.CV_FIELD_ID_KR] = { "韩国配音", "Koera" },
}
Const.CV_ID_FIELD_DIC = {
    [Const.CV_FIELD_ID_CN] = "cn_cv_name",
    [Const.CV_FIELD_ID_JP] = "jp_cv_name",
    [Const.CV_FIELD_ID_EN] = "en_cv_name",
    [Const.CV_FIELD_ID_TW] = "tw_cv_name",
    [Const.CV_FIELD_ID_KR] = "kr_cv_name",
}
Const.CV_ID_DESC_DIC = {
    [Const.CV_FIELD_ID_CN] = "中",
    [Const.CV_FIELD_ID_JP] = "日",
    [Const.CV_FIELD_ID_EN] = "英",
    [Const.CV_FIELD_ID_TW] = "台",
    [Const.CV_FIELD_ID_KR] = "韩",
}

Const.VOLUME_TYPE_MUSIC = 1
Const.VOLUME_TYPE_SFX = 2
Const.VOLUME_TYPE_VOCAL = 3

Const.HERO_VOCAL_VICTORY = "victory"
Const.HERO_VOCAL_FAIL = "fail"
Const.HERO_VOCAL_GET = "get"
Const.HERO_VOCAL_DRAG = "drag"
Const.HERO_VOCAL_HOME = "home"
Const.HERO_VOCAL_RISK = "risk"
Const.HERO_VOCAL_CHOOSE = "choose"
Const.HERO_VOCAL_CLEAN = "clean"
Const.HERO_VOCAL_UPGRADE = "upgrade"
Const.HERO_VOCAL_STARUP = "starup"
Const.HERO_VOCAL_SKILLUP = "skillup"
Const.HERO_VOCAL_ULTIMATEX1 = "ultimate_x1"
Const.HERO_VOCAL_ULTIMATESHORTX1 = "ultimate_short_x1"
Const.HERO_VOCAL_ULTIMATEX2 = "ultimate_x2"
Const.HERO_VOCAL_ULTIMATESHORTX2 = "ultimate_short_x2"
Const.HERO_VOCAL_ULTIMATEX4 = "ultimate_x4"
Const.HERO_VOCAL_ULTIMATESHORTX4 = "ultimate_short_x4"
Const.HERO_VOCAL_QUICK_UPGRADE = "quick_upgrade"
------------------------------------------ ↑ Setting ↑ ------------------------------------------

------------------------------------------ ↓ Counter ↓ ------------------------------------------
-- Day TI Counter Type
Const.DayTICounterTypeRecharge = 1
Const.DayTICounterTypeDraw = 2
Const.DayTICounterTypeShop = 3
Const.DayTICounterTypePvp = 4
Const.DayTICounterTypePower = 5
Const.DayTICounterTypeMultiPVP = 7

--pvp counterid
Const.DayPvpCountId = 6
--multiPvp.counterid
Const.DayMultiPvpCountId = 9

--Power Counter ID
Const.DayPowerCountId = 7

-- Draw Counter id
Const.DayDrawCounterFree = 1
Const.DayDrawCounterStandard = 2
Const.DayDrawCounterStandardTen = 3

-- Draw Counter Limit
Const.DayDrawMaxCountFree = 50
Const.DayDrawMaxCountStandard = 20
Const.DayDrawMaxCountStandardTen = 3

-- Time Counter Limit
Const.TimeTICounterTypeShop = 0

------------------------------------------ ↑ Counter ↑ ------------------------------------------
Const.AUTO_LOGIN = 1
Const.AUTO_SWITCH_ACCOUNT = 2

--跳字类型
Const.NUM_TYPE = {
    LOSE_L = 10,      --普伤左侧
    LOSE_R = 11,      --普伤右侧
    CRIT_L = 20,      --暴击左侧
    CRIT_R = 21,      --暴击右侧

    ADD = 30,         --恢复
    STATE_B = 41,     --状态蓝色(我方增益/敌方减益)
    STATE_R = 42,     --状态红色(我方减益/敌方增益)
    KILL_B = 51,      --击杀蓝色
    KILL_R = 52,      --击杀红色

    SKILLLOSE_L = 60, --大招普伤左侧
    SKILLLOSE_R = 61, --大招普伤右侧
    SKILLCRIT_L = 70, --大招暴击左侧
    SKILLCRIT_R = 71, --大招暴击右侧

    EQUIP_ATTR = 80   --装备属性变化跳字
}

--聊天频道
Const.CHANNEL_WORLD = "kMsgChannelTypeWorld"        --世界
Const.CHANNEL_AOI = "kMsgChannelTypeAoi"            --附近
Const.CHANNEL_GUILD = "kMsgChannelTypeClan"         --同盟
Const.CHANNEL_PRIVATE = "kMsgChannelTypeP2P"        --私聊
Const.CHANNEL_SERVER = "kMsgChannelTypeSvr"         --同服

Const.CHANNEL_PERSON = "kMsgSubChannelPersonal"     --个人
Const.CHANNEL_DECLEAR = "kMsgSubChannelNotice"      --公告
Const.CHANNEL_DYNAMICS = "kMsgSubChannelActive"     --动态
Const.CHANNEL_SYSTEM = "kMsgSubChannelSys"          --系统

Const.MAIN_CHANNEL_SYSTEM = "kMsgChannelTypeSystem" --系统主频道
Const.CHANNEL_NOTICE = "clientChannelNotice"        --提示

--这个是客户端自己做的
Const.CHANNEL_NONE = "kMsgChannelTypeNone"
Const.WORLD_CHANNEL_SYSTEM = "kMsgChannelTypeWorldSystem" --世界频道的系统消息
Const.GUILD_CHANNEL_SYSTEM = "kMsgChannelTypeGuildSystem" --公会系统消息


--聊天频道类型和服务端的对应
Const.CHANNEL_TO_TYPE                        = {
    ["kMsgChannelTypeP2P"] = 1,
    ["kMsgChannelTypeClan"] = 2,
    ["kMsgChannelTypeWorld"] = 3,
    ["kMsgChannelTypeSvr"] = 4
}

Const.CHANNEL_TABS                           = {
    { name = "世界", sendChannel = Const.CHANNEL_WORLD, receiveChannels = { Const.CHANNEL_WORLD }, canBullet = false },
    { name = "语言", sendChannel = Const.CHANNEL_SERVER, receiveChannels = { Const.CHANNEL_SERVER, Const.MAIN_CHANNEL_SYSTEM }, canBullet = false },
    { name = "公会", sendChannel = Const.CHANNEL_GUILD, receiveChannels = { Const.CHANNEL_GUILD }, canBullet = false },
    { name = "私聊", sendChannel = Const.CHANNEL_PRIVATE, receiveChannels = { Const.CHANNEL_PRIVATE }, canBullet = false },
}

Const.CHAT_SHARE_TYPE                        = {
    REPLAY = "kMsgShareTypeReplay",
    RED_PACKET = "kMsgShareTypeRedPacket",
    SPE_NOTICE = "kMsgShareTypeSpecialNotice",
}

Const.MAX_RED_PACKET_USE_NUM                 = 10 --一次性最多使用10个红包

Const.GENDER_MAN                             = 1 --性别男
Const.GENDER_WOMAN                           = 0 --性别女
Const.GENDER_OTGER                           = 2
Const.CHAT_TIME_INTERVAL                     = 1800 --聊天显示时间间隔(s)
Const.MAX_PRIVATE_FRIEND                     = 20 --私聊对象最多数量
Const.MAX_CHAT_CHARACTER                     = 60 --聊天最多字符,中文算两个字符
Const.BULLET_NUM_LIMIT                       = 10 --单个频道显示最多条数



-- 主频道 发送时可能带有子频道
Const.SUB_MAIN_CHANNEL                       = {
    [Const.CHANNEL_PERSON] = Const.MAIN_CHANNEL_SYSTEM,
    [Const.CHANNEL_DECLEAR] = Const.MAIN_CHANNEL_SYSTEM,
    [Const.CHANNEL_DYNAMICS] = Const.MAIN_CHANNEL_SYSTEM,
    [Const.CHANNEL_SYSTEM] = Const.MAIN_CHANNEL_SYSTEM,
}
--弹幕初始频道
Const.DEFAULT_BULLET_CHANNELS                = {
    [Const.CHANNEL_WORLD] = 1,
    [Const.CHANNEL_GUILD] = 2,
    [Const.CHANNEL_SERVER] = 3
}

--聊天各频道配置,必须要配置limitCount removeNum
Const.CHANNEL_CONFIG                         = {
    [Const.CHANNEL_WORLD] = { limitCount = 300, removeNum = 150 },
    [Const.CHANNEL_GUILD] = { limitCount = 300, removeNum = 150 },
    [Const.CHANNEL_SERVER] = { limitCount = 300, removeNum = 150 },
}

Const.DEFAULT_MAX_MSG_COUNT                  = 300
Const.DEFAULT_REMOVE_MSG_COUNT               = 150

Const.MAX_THX_MSG_NUM                        = 10 --红包感谢最多条数
Const.FOLD_MSG_NUM                           = 5 --红包感谢折叠条数
Const.THX_MSG_NUM                            = 5 -- 每个红包显示的感谢消息数量
Const.CUSTOM_MSG_DATA_TYPE                   = {
    RED_THX = "1",         --红包感谢
    RED_CLAIM = "2",       --红包领取
}

Const.CAMERA_BATTLE_NEAR                     = 0.1
Const.CAMERA_BATTLE_FAR                      = 2000

-- 物品品质
Const.OBJ_QUALITY_UNKNOWN                    = 0
Const.OBJ_QUALITY_WHITE                      = 1
Const.OBJ_QUALITY_GREEN                      = 2
Const.OBJ_QUALITY_BLUE                       = 3
Const.OBJ_QUALITY_PURPLE                     = 4
Const.OBJ_QUALITY_GOLD                       = 5

-- 装备品质
Const.EQUIP_QUALITY_UNKNOWN                  = 0
Const.EQUIP_QUALITY_WHITE                    = 1
Const.EQUIP_QUALITY_GREEN                    = 2
Const.EQUIP_QUALITY_GREEN_PLUS               = 3
Const.EQUIP_QUALITY_BLUE                     = 4
Const.EQUIP_QUALITY_BLUE_PLUS                = 5
Const.EQUIP_QUALITY_PURPLE                   = 6
Const.EQUIP_QUALITY_FUCHSIA                  = 7
Const.EQUIP_QUALITY_GOLD                     = 8
Const.EQUIP_QUALITY_GOLD_PLUS                = 9
Const.EQUIP_QUALITY_PINK                     = 10
Const.EQUIP_QUALITY_PINK_PLUS                = 11
Const.EQUIP_QUALITY_RED                      = 12
Const.EQUIP_QUALITY_RED_PLUS                 = 13

Const.EQUIP_QUALITY_SCORE                    =
{
    [Const.EQUIP_QUALITY_FUCHSIA] = 1,
    [Const.EQUIP_QUALITY_GOLD] = 2,
    [Const.EQUIP_QUALITY_GOLD_PLUS] = 4,
    [Const.EQUIP_QUALITY_PINK] = 6,
}

--开始可进化的装备等级
Const.EQUIP_EVO_QUALITY                      = Const.EQUIP_QUALITY_PINK
Const.EQUIP_PLAN_MAX_HERO_COUNT              = 30
Const.EQUIP_PLAN_CREATE_ID                   = 99
Const.EQUIP_MAX_PLAN_COUNT                   = 10
Const.EQUIP_MAX_PLAN_COUNT_NEW               = 30
Const.EQUIP_PLAN_EDIT_ID                     = 999

--进化上限
Const.EQUIP_EVO_MAX                          = 2
Const.MAX_PAINT_ABILITY_COUNT                = 5 --涂装最大赋能格子数
--涂装表现图片类型
Const.PAINT_HERO_CARD                        = 1
Const.PAINT_HERO_BASEPANEL                   = 2
Const.PAINT_HERO_HEAD                        = 3
Const.PAINT_HERO_GRID                        = 4

Const.ROOM_HERO_GROUP_AREA                   = 1
Const.ROOM_HERO_GROUP_TEAM                   = 2

Const.RELATION_DESC_LETTER                   = 1
Const.RELATION_DESC_ITEM                     = 2
Const.RELATION_DESC_AVG                      = 3

Const.RELATION_HINT_OPEN_TYPE_TEAM           = "kCSHeroDevelopOpenTypeTeam"
Const.RELATION_HINT_OPEN_TYPE_STAGE          = "kCSHeroDevelopOpenTypeStage"

-- 英雄品质
Const.HERO_QUALITY_N                         = 1
Const.HERO_QUALITY_B                         = 2
Const.HERO_QUALITY_A                         = 3
Const.HERO_QUALITY_S                         = 4
Const.HERO_QUALITY_SS                        = 5

Const.HERO_PROP_INVALID_TYPE_NO_SUPPORT      = 1 --无支援
Const.HERO_PROP_INVALID_TYPE_NO_ACCURACY     = 2 --无效果
Const.HERO_PROP_INVALID_TYPE_NO_ALL          = 3 --无支援也无效果
Const.HERO_PROP_INVALID_TYPE_ALL             = 0 --无屏蔽词条

--基本不会改，所以直接写在代码里，防止配在表里策划自己改了不知道会导致什么后果，策划已周知（先游）
Const.HERO_PROP_INVALID_BAN                  =
{
    [Const.HERO_PROP_INVALID_TYPE_NO_SUPPORT] = { [23] = 1, },
    [Const.HERO_PROP_INVALID_TYPE_NO_ACCURACY] = { [26] = 1, },
    [Const.HERO_PROP_INVALID_TYPE_NO_ALL] = { [26] = 1, [23] = 1, },
    [Const.HERO_PROP_INVALID_TYPE_ALL] = {},
}
-- 抽卡类型
Const.DrawTypeNone                           = "kDrawTypeNone"
Const.DrawTypeFree                           = "kDrawTypeFree"
Const.DrawTypeStandard                       = "kDrawTypeStandard"
Const.DrawTypeNewbie                         = "kDrawTypeNewbie"
Const.DrawTypeGroup                          = "kDrawTypeCamp"
Const.DrawTypeCustom                         = "DrawTypeCustom"
Const.DrawTypeLightDark                      = "kDrawTypeCampLightDark"

Const.DrawPoolIdStandard                     = 1
Const.DrawPoolIdFree                         = 2
Const.DrawPoolIdNewbie                       = 3
Const.DrawPoolIdCamp                         = 4
Const.DrawPoolIdLightDark                    = 6

Const.DrawCampLightDark                      = 100

-- 抽卡消耗类型
Const.DrawCostTypeNone                       = "kDrawCostTypeNone" --    = 0;
Const.DrawCostTypeItem                       = "kDrawCostTypeItem" --    = 1; // 道具
Const.DrawCostTypeConsume                    = "kDrawCostTypeConsume" -- = 2; // 货币

--进入英雄界面ContentPanel初始化选择的Panel页
Const.HERO_CONTENT_PANEL                     = {
    BASE_INFO = 1,
    HERO_EQUIP = 2,
    STAGE_UP = 3,
    SKIN_INFO = 4,
}
Const.STAR_STEP_LEVEL                        = 5
--英雄升星材料类型
Const.HERO_STARUP_MATERIAL_TYPE              = {
    SAME_ID = "sameGid",
    SPECIAL_ID = "specialGid",
    ANY_ID = "anyGid",
    SAME_CAMP = "campGid"
}

--英雄重置类型
Const.HERO_RESET_LEVEL                       = 1
Const.HERO_RESET_STEP                        = 2
Const.HERO_RESET_ALL                         = 3
Const.HERO_RESET_CLOSE_STEP                  = 10 --超过此阶数后无法进行升阶重置
Const.HERO_CANT_RESET_STEP_REASON            = {}
Const.HERO_CANT_RESET_STEP_REASON.CLOSE_STEP = 1
Const.HERO_CANT_RESET_STEP_REASON.IS_INCD    = 2
Const.HERO_CANT_RESET_STEP_REASON.IS_LOCKED  = 3

Const.HERO_CANT_COMPOSE_REASON               = {}
Const.HERO_CANT_COMPOSE_REASON.RAND          = 1 --随机光暗碎片无法合成
Const.HERO_CANT_COMPOSE_REASON.DEFINE        = 2 --固定光暗碎片无法合成

Const.HERO_STARUP_GRID_STATUS_NONE           = 1
Const.HERO_STARUP_GRID_STATUS_BE_STARUP      = 2
Const.HERO_STARUP_GRID_STATUS_CAN_MATERIAL   = 3
Const.HERO_STARUP_GRID_STATUS_BE_MATERIAL    = 4
Const.HERO_STARUP_GRID_STATUS_LOCK           = 5
Const.HERO_STARUP_GRID_STATUS_CANT_UP        = 6

Const.STAR_REVERT_HELP_REASON_EIGHT          = 1 --升星回退因为七升八出现
Const.STAR_REVERT_HELP_REASON_NINE           = 2 --升星回退因为八升九出现

Const.HERO_WEARPANEL_STATUS_PRE              = 1 --预备替换面板
Const.HERO_WEARPANEL_STATUS_CANPRE           = 2 --可以被预备替换面板
Const.HERO_WEARPANEL_STATUS_CANSWAP          = 3 --可以互换面板
Const.HERO_WEARPANEL_STATUS_NONE             = 4 --无法替换

--英雄获取途径
Const.HERO_GET_TYPE_OTHER                    = 0 --其它
Const.HERO_GET_TYPE_DRAW                     = 1 --抽卡
Const.HERO_GET_TYPE_ACHIEVE_AWARD            = 2 --成就任务奖励
Const.HERO_GET_TYPE_TASK_AWARD               = 3 --任务奖励
Const.HERO_GET_TYPE_BOOK_TASK_AWARD          = 4 --图鉴任务奖励
Const.HERO_GET_TYPE_ROLE_INIT                = 5 --角色初始化
Const.HERO_GET_TYPE_STAGE_WIN                = 6 --主线推图胜利
Const.HERO_GET_TYPE_FRAG_COMPOUND            = 7 --碎片合成
Const.HERO_GET_TYPE_RAND_FRAG_COMPOUND       = 53 --随机碎片合成
Const.HERO_GET_TYPE_GIFT_CHOOSE              = 24 --礼包兑换

--英雄删除原因
Const.HERO_DEL_TYPE_RECYCLE                  = 1009 --英雄回收
Const.HERO_DEL_TYPE_STAR_UP                  = 1007 --英雄升星


Const.NEED_NOTICE_HERO_GET_TYPE =
{
    [Const.HERO_GET_TYPE_OTHER] = true,
}

Const.NEED_DLG_HERO_GET_TYPE =
{
    -- [Const.HERO_GET_TYPE_ACHIEVE_AWARD] = true,
    -- [Const.HERO_GET_TYPE_TASK_AWARD] = true,
    [Const.HERO_GET_TYPE_GIFT_CHOOSE] = true,
}

Const.NEED_CACHE_HERO_FOR_DLG =
{
    [Const.HERO_GET_TYPE_STAGE_WIN] = true
}



--Const.HERO_SKILL_FIELD.ATTACK = "skillBase"
--Const.HERO_SKILL_FIELD.SKILL = "skillLast"
--Const.HERO_SKILL_FIELD.HERO_PASSIVE = "skillPassive2"
--Const.HERO_SKILL_FIELD.ENTER_PASSIVE = "skillPassive1"
--Const.HERO_SKILL_FIELD.BATTLE_PASSIVE = "skillPassive3"

Const.HERO_SKILL_ID = {}
Const.HERO_SKILL_ID.ATTACK = 1
Const.HERO_SKILL_ID.SKILL = 2
Const.HERO_SKILL_ID.HERO_PASSIVE = 3
Const.HERO_SKILL_ID.ENTER_PASSIVE = 4





Const.HERO_SKILL_STYLE = {}
Const.HERO_SKILL_STYLE.ATTACK = 0
Const.HERO_SKILL_STYLE.SKILL = 1
Const.HERO_SKILL_STYLE.PASSIVE = 2









Const.HERO_PROPS_INC_DIC =
{
    ["inc_atk"] = "atk",
    ["inc_p_def"] = "p_def",
    ["inc_m_def"] = "m_def",
    ["inc_mhp"] = "mhp",
    ["inc_cri_rate"] = "cri_rate",
}

--策划让我写死id，在excel表里加备注，如果改光暗英雄碎片一定要通知我 桂轶琦。
Const.LIGHT_BLACK_FRAG_ID_DIC =
{
    [516006] = true
}

--打开穿戴界面的类型
Const.WEAR_TYPE_EQUIP = 1
Const.WEAR_TYPE_ARTIFACT = 2
Const.WEAR_TYPE_RELIC = 3

--打开强化界面的类型
Const.UPGRADE_TYPE_EQUIP = 1
Const.UPGRADE_TYPE_ARTIFACT = 2
Const.PART_OF_ARTIFACT = 7
Const.PART_OF_RELIC = 8
Const.PART_OF_RELIC_PET = 8
Const.EQUIP_RAND_POS = 7

--精准穿戴选择套装按钮状态
Const.CUSTOM_SUIT_INFO_STATUS_ACTIVE = 1    --激活状态
Const.CUSTOM_SUIT_INFO_STATUS_NO_ENOUGH = 2 --背包中件数不够
Const.CUSTOM_SUIT_INFO_STATUS_SEL_MAX = 3   --选择已达6件

Const.BAG_TYPE_EQUIP = "kCSBagTypeCodeEquip"
Const.BAG_TYPE_ARTIFACT = "kCSBagTypeCodeArtifact"
Const.BAG_TYPE_HERO = "kCSBagTypeCodeHero"

Const.MAX_NUMBER_ARTIFACT_ATTR = 2 -- 副属性条目数


Const.BAG_TYPE_ID =
{
    [Const.BAG_TYPE_EQUIP] = 1,
    [Const.BAG_TYPE_ARTIFACT] = 2,
    [Const.BAG_TYPE_HERO] = 3
}

Const.BAG_TYPE_NAME =
{
    [Const.BAG_TYPE_EQUIP] = "配件",
    [Const.BAG_TYPE_ARTIFACT] = "徽章",
    [Const.BAG_TYPE_HERO] = "手办"
}

Const.HREO_OFF_ALL_EQUIPS_TYPE_NORMAL = "kCSHeroOPOffWearsTypeNormal" --只脱没进化过的装备
Const.HREO_OFF_ALL_EQUIPS_TYPE_ALL = "kCSHeroOPOffWearsTypeAll"       --脱下所有装备
Const.WEAR_EQUIP_ANIM = "wear"
Const.OFF_EQUIP_ANIM = "off"

Const.JUMP_HERO_LIST = 6      --跳转到英雄列表
Const.JUMP_BAG_COMMON = 10    --跳转到道具背包
Const.JUMP_BAG_EQUIP = 11     --跳转到装备背包
Const.JUMP_BAG_ARTIFACT = 12  --跳转到神器背包
Const.JUMP_RECYCLE_SHOP = 162 --跳转到回收商店
Const.RELIC_SPEICAL_SIGN_FULI = 0
Const.RELIC_SPEICAL_SIGN_SPRING = 1
Const.RELIC_SPEICAL_SIGN_SUMMER = 2
Const.RELIC_SPEICAL_SIGN_AUTUMN = 3
Const.RELIC_SPEICAL_SIGN_WINTER = 4

Const.BAG_TYPE_GUIDE =
{
    [Const.BAG_TYPE_HERO] = Const.JUMP_HERO_LIST,
    [Const.BAG_TYPE_EQUIP] = Const.JUMP_BAG_EQUIP,
    [Const.BAG_TYPE_ARTIFACT] = Const.JUMP_BAG_ARTIFACT
}

Const.MODE_COMMON = 1
Const.MODE_EQUIP = 2
Const.MODE_GOD = 3
Const.MODE_FRAG = 4
Const.MODE_WEAR = 5
Const.MODE_RELIC = 6
Const.MODE_SKIN = 7

Const.RELIC_BGM_TYPE_HERO_DLG = 1
Const.RELIC_BGM_TYPE_BATTLE = 2
Const.RELIC_BGM_TYPE_VICTORY = 3

Const.RELIC_DLG_CUE = 'hero_cue'
Const.RELIC_BATTLE_CUE = 'battle_cue'
Const.RELIC_WEATHER_EFF = 'battle_weather_eff'

-- reskey 策划填写的子类型
Const.ITEM_STYPE_HERO_FRAG = 1                   -- 英雄碎片
Const.ITEM_STYPE_MATERIAL = 2                    -- 材料
Const.ITEM_STYPE_GIFT_PKG = 3                    -- 礼包
Const.ITEM_STYPE_RAND_HERO_FRAG = 4              -- 随机英雄碎片
Const.ITEM_STYPE_RAND_EQUIP_FRAG = 5             -- 随机配件碎片
Const.ITEM_STYPE_RAND_ARTIFACT_FRAG = 6          -- 随机徽章碎片
Const.ITEM_STYPE_RAND_GIFT_PKG = 7               -- 随机礼包
Const.ITEM_STYPE_RAND_SELECT_GIFT_PKG = 8        -- 可选礼包
Const.ITEM_STYPE_RAND_DEPOSIT_GIFT_PKG = 9       -- 挂机道具
Const.ITEM_STYPE_RENAME_TICKET = 10              -- 改名卡
Const.ITEM_STYPE_STEP_MATERIAL = 11              -- 升阶材料
Const.ITEM_STYPE_ACTIVITY_PROGRESS = 12          -- 一些特殊活动用到的进度道具展示
Const.ITEM_STYPE_ARTIFACT_BREAK_MATERIAL = 13    -- 神器突破材料
Const.ITEM_STYPE_EQUIP_EVOLVE_MATERIAL = 14      --装备进化材料
Const.ITEM_STYPE_CASH = 17                       --代金券
Const.ITEM_STYPE_RECHARGE_ITEM = 19              --充值道具
Const.ITEM_STYPE_HERO_PAINT_MATERIAL = 20        --英雄专属涂装道具

Const.ITEM_STYPE_RAND_LIMIT_SELECT = 21          -- 可选限制礼包
Const.ITEM_STYPE_RED_PACKET = 22                 --红包

Const.ITEM_STYPE_HEAD_FRAME = 105                -- 头像框
Const.JP_HOMEPAGE_GUIDE_ID = 164                 -- 论坛跳转完成任务
Const.TW_HOMEPAGE_GUIDE_ID = 100                 -- 论坛跳转完成任务

Const.ITEM_STYPE_MONEY = 51                      -- 金币
Const.ITEM_STYPE_DIAMOND = 52                    -- 钻石
Const.ITEM_STYPE_POWER = 53                      -- 体力
Const.ITEM_STYPE_XP = 54                         -- exp
Const.ITEM_STYPE_BP = 58                         -- BP点
Const.ITEM_STYPE_VIP_EXP = 59                    -- VIP经验
Const.ITEM_STYPE_ENERGY = 60                     -- 推图能量
Const.ITEM_STYPE_CLAN_COIN = 61                  -- 圈子币

Const.ITEM_STYPE_HERO_NORMAL = 81                -- 英雄普通
Const.ITEM_STYPE_HERO_MATERIAL = 82              -- 英雄材料
Const.ITEM_STYPE_EQUIP_UPGRADE_MATERIAL = 101    -- 装备强化材料
Const.ITEM_STYPE_ARTIFACT_UPGRADE_MATERIAL = 102 -- 神器强化材料

Const.ITEM_STYPE_REAR_HOUSE_PROPS = 103          --后宅道具
Const.ITEM_STYPE_PREVIEW_PKG = 106               --预览礼包
Const.ITEM_STYPE_RELIC_PKG = 107                 --圣物卡包
Const.ITEM_STYPE_RELIC_MATERIAL = 108            --圣物强化材料
Const.ITEM_STYPE_CIRCLE_HEAD = 109               --圈子头像
Const.ITEM_STYPE_DYNAMIC_ICON = 110              --动态表情

Const.HIDE_GRID_NUM_TYPE =
{
    [Const.ITEM_STYPE_CIRCLE_HEAD] = 1,
    [Const.ITEM_STYPE_ACTIVITY_PROGRESS] = 1,
    [Const.ITEM_STYPE_BP] = 1,
}
Const.ITEM_CHOOSE_GIFT_GROUP = 1
Const.ITEM_CHOOSE_GIFT_HERO = 2
Const.ITEM_CHOOSE_GIFT_EQUIP = 3
Const.ITEM_CHOOSE_GIFT_BADGE = 4
Const.ITEM_CHOOSE_GIFT_ITEM = 5
Const.ITEM_CHOOSE_GIFT_EQUIP_DEFINE = 6

Const.GIFT_TYPE_BAG =
{
    [Const.ITEM_CHOOSE_GIFT_GROUP] = Const.BAG_TYPE_HERO,
    [Const.ITEM_CHOOSE_GIFT_HERO] = Const.BAG_TYPE_HERO,
    [Const.ITEM_CHOOSE_GIFT_EQUIP_DEFINE] = Const.BAG_TYPE_EQUIP,
    [Const.ITEM_CHOOSE_GIFT_EQUIP] = Const.BAG_TYPE_EQUIP,
    [Const.ITEM_CHOOSE_GIFT_BADGE] = Const.BAG_TYPE_ARTIFACT,
}

Const.SKIN_TYPE_SKIN = "kSkinTypeSkin" --皮肤类型 皮肤
Const.SKIN_TYPE_BASE = "kSkinTypeBase" --皮肤类型 底座
-------------------------------------背包里各种分类的类型定义--------------------------------------
Const.ITEM_DICT_COMMON = {
    [Const.ITEM_STYPE_MATERIAL] = true,
    [Const.ITEM_STYPE_GIFT_PKG] = true,
    [Const.ITEM_STYPE_MONEY] = true,
    [Const.ITEM_STYPE_DIAMOND] = true,
    [Const.ITEM_STYPE_POWER] = true,
    [Const.ITEM_STYPE_CLAN_COIN] = true,
    -- [Const.ITEM_STYPE_XP] = true,
    [Const.ITEM_STYPE_EQUIP_UPGRADE_MATERIAL] = true,
    [Const.ITEM_STYPE_ARTIFACT_UPGRADE_MATERIAL] = true,
}

Const.ITEM_DICT_MONEY = {
    [Const.ITEM_STYPE_MONEY] = true,
    [Const.ITEM_STYPE_DIAMOND] = true,
    [Const.ITEM_STYPE_POWER] = true,
    [Const.ITEM_STYPE_CLAN_COIN] = true,
    -- [Const.ITEM_STYPE_XP] = true,
}

Const.ITEM_DICT_REAR_HOUSE = {
    [Const.ITEM_STYPE_REAR_HOUSE_PROPS] = true
}

Const.ITEM_DICT_BREAK = {
}

Const.BAG_HIDE_STYPE =
{
    [Const.ITEM_STYPE_XP] = true,
    [Const.ITEM_STYPE_BP] = true,
    [Const.ITEM_STYPE_VIP_EXP] = true,
    [Const.ITEM_STYPE_ENERGY] = true,
    [Const.ITEM_STYPE_RELIC_MATERIAL] = true,
}

Const.BAG_CANUSE_STYPE =
{
    [Const.ITEM_STYPE_RAND_GIFT_PKG] = true,
    [Const.ITEM_STYPE_RAND_SELECT_GIFT_PKG] = true,
    [Const.ITEM_STYPE_RAND_DEPOSIT_GIFT_PKG] = true,
    [Const.ITEM_STYPE_RENAME_TICKET] = true,
    [Const.ITEM_STYPE_RED_PACKET] = true,
}

Const.BAG_USE_BUTTON_STYPE =
{
    [Const.ITEM_STYPE_RAND_GIFT_PKG] = true,
    [Const.ITEM_STYPE_RECHARGE_ITEM] = true,
    [Const.ITEM_STYPE_RAND_DEPOSIT_GIFT_PKG] = true,
    [Const.ITEM_STYPE_RENAME_TICKET] = true,
    [Const.ITEM_STYPE_RED_PACKET] = true,
}

Const.ITEM_DICT_OTHER = {
    [Const.ITEM_STYPE_GIFT_PKG] = true,
    [Const.ITEM_STYPE_MATERIAL] = true,
}

Const.ITEM_DICT_FRAG = {
    [Const.ITEM_STYPE_HERO_FRAG] = true,
    [Const.ITEM_STYPE_RAND_HERO_FRAG] = true,
    [Const.ITEM_STYPE_RAND_ARTIFACT_FRAG] = true,
    [Const.ITEM_STYPE_RAND_EQUIP_FRAG] = true,
}

Const.ITEM_DICT_HERO_FRAG = {
    [Const.ITEM_STYPE_RAND_HERO_FRAG] = true,
    [Const.ITEM_STYPE_HERO_FRAG] = true,
}

Const.ITEM_DICT_ARTIFACT_FRAG = {
    [Const.ITEM_STYPE_RAND_ARTIFACT_FRAG] = true,
}

Const.ITEM_DICT_EQUIP_FRAG = {
    [Const.ITEM_STYPE_RAND_EQUIP_FRAG] = true,
}

-- 道具类型
Const.ITEM_TYPE_ITEM = "item"                     --道具
Const.ITEM_TYPE_ITEM_CURRENCY = "currency"        --货币
Const.ITEM_TYPE_ITEM_SKIN = "itemSkin"            --道具-皮肤
Const.ITEM_TYPE_ITEM_PHOTOFRAME = "photoFrame"    --道具-头像框
Const.ITEM_TYPE_FRAG_ITEM = "fragitem"            --碎片
Const.ITEM_TYPE_RAND_FRAG_ITEM = "randfragitem"   --任意碎片
Const.ITEM_TYPE_EQUIP = "equip"                   --装备
Const.ITEM_TYPE_ARTIFACT = "artifact"             --神器
Const.ITEM_TYPE_RELIC_PET = "relic_pet"           --宠物
Const.ITEM_TYPE_RELIC = "relic"                   --圣物
Const.ITEM_TYPE_EQUIP_TEMPLETE = "equip_templete" --装备模版
Const.ITEM_TYPE_HERO = "hero"                     --英雄
Const.ITEM_TYPE_SKIN = "skin"                     --英雄皮肤
Const.ITEM_TYPE_PET = "pet"
Const.ITEM_TYPE_PET_AMULET = "petAmulet"
Const.ITEM_TYPE_PET_GEM = "petGem"
Const.ITEM_TYPE_DRAGON = "pet_dragon"
Const.ITEM_TYPE_SoulStone = "soulStone" --魂石


--item序号范围
Const.itemRange = {
    [1] = { min = 20000, max = 29999, itemType = Const.ITEM_TYPE_HERO, DataTable = DataTable.ResHero },          --英雄
    [2] = { min = 100001, max = 100021, itemType = Const.ITEM_TYPE_ITEM_CURRENCY, DataTable = DataTable.ResItem }, --货币道具
    [11] = { min = 200000, max = 299999, itemType = Const.ITEM_TYPE_ITEM, DataTable = DataTable.ResItem }, --升星道具
    [4] = { min = 500000, max = 599999, itemType = Const.ITEM_TYPE_ITEM, DataTable = DataTable.ResItem },        --道具
    [7] = { min = 800000, max = 809999, itemType = Const.ITEM_TYPE_ITEM_SKIN, DataTable = DataTable.ResItem },   --皮肤道具
    [8] = { min = 810000, max = 819999, itemType = Const.ITEM_TYPE_ITEM_PHOTOFRAME, DataTable = DataTable.ResItem }, --头像框道具
    [9] = { min = 3000000, max = 4999999, itemType = Const.ITEM_TYPE_EQUIP, DataTable = DataTable.ResEquipData }, --装备
    [10] = { min = 900000, max = 909999, itemType = Const.ITEM_TYPE_SoulStone, DataTable = DataTable.ResHeroSoulStoneData } --魂石
}
Const.HAVE_PREVIEW_TIPS_TYPE_DIC =
{
    [Const.ITEM_TYPE_HERO] = true,
    [Const.ITEM_TYPE_SKIN] = true,
}


-- 道具品质
Const.ITEM_QUALITY_UNKNOWN = 0
Const.ITEM_QUALITY_WHITE = 1
Const.ITEM_QUALITY_GREEN = 2
Const.ITEM_QUALITY_BLUE = 3
Const.ITEM_QUALITY_PURPLE = 4
Const.ITEM_QUALITY_GOLD = 5
Const.ITEM_QUALITY_PINK = 6
Const.ITEM_QUALITY_RED = 7

Const.QUALITY_COLOR_NAME = {
    [Const.ITEM_QUALITY_WHITE] = "凡品",
    [Const.ITEM_QUALITY_GREEN] = "良品",
    [Const.ITEM_QUALITY_BLUE] = "上品",
    [Const.ITEM_QUALITY_PURPLE] = "珍品",
    [Const.ITEM_QUALITY_GOLD] = "绝品",
}

Const.ITEM_ID_HERO_LV_MATERIAL = 500000

Const.RANK_TYPE_ONCETOWER = "kRankTypeOnceTower"
Const.RANK_TYPE_BOSSTOWER1 = "kRankTypeBossTower1"
Const.RANK_TYPE_BOSSTOWER2 = "kRankTypeBossTower2"
Const.RANK_TYPE_BOSSTOWER3 = "kRankTypeBossTower3"
Const.RANK_TYPE_BOSSTOWER4 = "kRankTypeBossTower4"
Const.RANK_TYPE_MAINSTAGE = "kRankTypeStage"
Const.RANK_TYPE_ASYNCPVP = "kRankTypeAsyncPvp"
Const.RANK_TYPE_GROUP1 = "kRankTypeCamp1Score"
Const.RANK_TYPE_GROUP2 = "kRankTypeCamp2Score"
Const.RANK_TYPE_GROUP3 = "kRankTypeCamp3Score"
Const.RANK_TYPE_MULTIPVP = "kRankTypeMultiPvp"
Const.RANK_TYPE_WORLDBOSS = "kRankTypeWorldBoss"
Const.RANK_TYPE_ACTIVITY_PLOT = "kRankTypeActivityPlot"
Const.RANK_TYPE_HOUSEFAVOR = "kRankTypeHouseFavor"
Const.RANK_TYPE_SEASON_TOWER_SCORE = "kRankTypeOpactTowerScore"
Const.RANK_TYPE_SEASON_TOWER_LAYER = "kRankTypeOpactTowerLayer"
Const.RANK_TYPE_OPACTPVP = "kRankTypeOpactArena"
Const.RANK_TYPE_CIRCLE_BATTLE_FEAT = "kRankTypeCircleBattleFeat"
Const.RANK_TYPE_CIRCLE_BATTLE_LAYER = "kRankTypeCircleBattleLayer"

Const.RANK_TYPE_BOSS_EXPAND_MAP = {}
for i = 1, 9 do
    Const["RANK_TYPE_BOSS_EXPAND_" .. i] = "kRankTypeCampTower" .. i
    Const.RANK_TYPE_BOSS_EXPAND_MAP["kRankTypeCampTower" .. i] = true
end




Const.RANK_CACHE_TYPE_SEASON_TOWER = 3
Const.RANK_CACHE_TYPE_CIRCLE_LAYER = 4
Const.RANK_CACHE_TYPE_WORLD_BOSS = 5

Const.CACHE_TYPE_TO_RANK_TYPE =
{
    [Const.RANK_CACHE_TYPE_SEASON_TOWER] = Const.RANK_TYPE_SEASON_TOWER_SCORE,
    [Const.RANK_CACHE_TYPE_CIRCLE_LAYER] = Const.RANK_TYPE_CIRCLE_BATTLE_LAYER,
    [Const.RANK_CACHE_TYPE_WORLD_BOSS] = Const.RANK_TYPE_WORLDBOSS,
}

Const.MONUMENT_TYPE_GROUP1 = 1
Const.MONUMENT_TYPE_GROUP2 = 2
Const.MONUMENT_TYPE_GROUP3 = 3
Const.MONUMENT_TYPE_STAGE = 4
Const.MONUMENT_TYPE_ONCE_TOWER = 5

Const.MONUMENT_RANK_TYPE =
{
    [Const.MONUMENT_TYPE_GROUP1] = Const.RANK_TYPE_GROUP1,
    [Const.MONUMENT_TYPE_GROUP2] = Const.RANK_TYPE_GROUP2,
    [Const.MONUMENT_TYPE_GROUP3] = Const.RANK_TYPE_GROUP3,
    [Const.MONUMENT_TYPE_STAGE] = Const.RANK_TYPE_MAINSTAGE,
    [Const.MONUMENT_TYPE_ONCE_TOWER] = Const.RANK_TYPE_ONCETOWER,
}

Const.SPE_EMPTY_PROGRESS_SHOW_TYPE =
{
    [Const.RANK_TYPE_ASYNCPVP] = true,
    [Const.RANK_TYPE_ACTIVITY_PLOT] = true,
    [Const.RANK_TYPE_HOUSEFAVOR] = true,
    [Const.RANK_TYPE_CIRCLE_BATTLE_LAYER] = true,
    [Const.RANK_TYPE_CIRCLE_BATTLE_FEAT] = true,
}

Const.PVP_RANK_TYPE_ASYNC = 1 --异步pvp
Const.PVP_RANK_TYPE_MULTI = 2 --多队竞技场
Const.PVP_RANK_TYPE_OPACT = 3 --跨服竞技场

--排行奖励类型
Const.RANK_AWARD_TYPE_WORLDBOSS = 3
Const.RANK_AWARD_TYPE_OPACTPVP = 4
Const.RANK_AWARD_TYPE_SEASON_TOWER = 5
Const.RANK_AWARD_TYPE_CIRLCE_BATTLE_LAYER = 6

Const.RANK_AWARD_TYPE_DIC =
{
    [Const.RANK_TYPE_WORLDBOSS] = Const.RANK_AWARD_TYPE_WORLDBOSS,
    [Const.RANK_TYPE_SEASON_TOWER_SCORE] = Const.RANK_AWARD_TYPE_SEASON_TOWER,
    [Const.RANK_TYPE_CIRCLE_BATTLE_LAYER] = Const.RANK_AWARD_TYPE_CIRLCE_BATTLE_LAYER,
}
--领取丰碑奖励发送感谢话语的CD
Const.MONUMENT_AWARD_GET_MSG_CD = 30



-- Const.ARTIFACT_MAX_LEVEL = ResArtifactLevelUp[Const.ARTIFACT_MAX_BREAK_LEVEL].limit_level

--物品货币获取通知类型定义
Const.LISTATTR_USETYPE_DRAW = "kListAttrUseTypeDraw"
Const.LISTATTR_USETYPE_PVESTAGE = "kListAttrUseTypePVEStage"
Const.LISTATTR_USETYPE_DEPOSIT = "kListAttrUseTypeDeposit"
Const.LISTATTR_USETYPE_PVETOWER = "kListAttrUseTypePVETower"
Const.LISTATTR_USETYPE_PVETOWER_SWEEP = "kListAttrUseTypePVETowerSweep"
Const.LISTATTR_USETYPE_MAIL = "kListAttrUseTypeMail"
Const.LISTATTR_USETYPE_EQUIPTOWER_SWEEP = "kListAttrUseTypePVEEquipTowerSweep"
Const.LISTATTR_USETYPE_BOSSTOWER_SWEEP = "kListAttrUseTypePVEBossTowerSweep"
Const.LISTATTR_USETYPE_BOSSTOWER_AWARD = "kListAttrUseTypePVEBossTowerAward"
Const.LISTATTR_USETYPE_ACHIEVE = "kListAttrUseTypeAchieve"
Const.LISTATTR_USETYPE_TASK = "kListAttrUseTypeTask"
Const.LISTATTR_USETYPE_WEEKLYTASK = "kListAttrUseTypeWeeklyTask"
Const.LISTATTR_USETYPE_SHOP = "kListAttrUseTypeShop"
Const.LISTATTR_USETYPE_RECYCLE = "kListAttrUseTypeHeroRecycle"
Const.LISTATTR_USETYPE_ASYNC_PVP_SWEEP = "kListAttrUseTypeAsyncPVPSweep"
Const.LISTATTR_USETYPE_MONUMENT = "kListAttrUseTypeMonument"
Const.LISTATTR_USETYPE_ITEMUSE = "kListAttrUseTypeItemUse"
Const.LISTATTR_USETYPE_FUND = "kListAttrUseTypeFund"
Const.LISTATTR_USETYPE_REAR_HOUSE_UNLOCK = "kListAttrUseTypeHouseUnlock"
Const.LISTATTR_USETYPE_ITEM_COMPOUND = "kListAttrUseTypeItemCompound"
Const.LISTATTR_USETYPE_RECHARGE = "kListAttrUseTypeItemUseRecharge"
Const.LISTATTR_USETYPE_MONTH_CARD = "kListAttrUseTypeMonthCard"
Const.LISTATTR_USETYPE_BP = "kListAttrUseTypeBattlePass"
Const.LISTATTR_USETYPE_FIRST_RECHARGE = "kListAttrUseTypeFirstRecharge"
Const.LISTATTR_USETYPE_HERO_RESET = "kListAttrUseTypeHeroReset"
Const.LISTATTR_USETYPE_OPACT_ACHIEVE = "kListAttrUseTypeOpActAchieve"
Const.LISTATTR_USETYPE_OPACT = "kListAttrUseTypeOpAct"
Const.LISTATTR_USETYPE_OPACT_DRAW = "kListAttrUseTypeOpActDraw"
Const.LISTATTR_USETYPE_COMFORT_AWARD = "kListAttrUseTypeHouseComfortable"
Const.LISTATTR_USETYPE_BINGO = "kListAttrUseTypeBingo"
Const.LISTATTR_USETYPE_VIP = "kListAttrUseTypeVIP"
Const.LISTATTR_USETYPE_ACHIEVE_STAGE = "kListAttrUseTypeOpActAchieveStage"
Const.LISTATTR_USETYPE_BOSSTOWER = "kListAttrUseTypePVEBossTower"
Const.LISTATTR_USETYPE_OPACT_WISHSIGNIN = "kListAttrUseTypeWish"
Const.LISTATTR_USETYPE_SEASONTOWER_SWEEP = "kListAttrUseTypeOpActTowerSweep"
Const.LISTATTR_USETYPE_SEASONTOWER_ACHIEVE = "kListAttrUseTypeOpActTowerAchieve"
Const.LISTATTR_USETYPE_QQ_BLUE = "kListAttrUseTypeQQBlue"
Const.LISTATTR_USETYPE_MAZE_SWEAP = "kListAttrUseTypeOpMazeAutoSweep"
Const.LISTATTR_USETYPE_OPACT_SHARE = "kListAttrUseTypeOpActShare"
Const.LISTATTR_USETYPE_RECHARGE_MULITY_GETAWARD = "kListAttrUseTypeRechargeMulityGetAward"
Const.LISTATTR_USETYPE_RENT_BATTLE = "kListAttrUseTypeRentBattle"
Const.LISTATTR_USETYPE_ADVANCE_TASK = "kListAttrUseTypeAdvanceStepAward"
Const.LISTATTR_USETYPE_CLAN_CLEAR = "kListAttrUseTypeOpActClanBossStage"
Const.LISTATTR_USETYPE_BOSS_EXPAND_SWEEP = "kListAttrUseTypeCampTowerSweep"
Const.LISTATTR_USETYPE_HERO_EQUIP = "kListAttrUseTypeHeroEquip"

Const.RECHARGE_PRICE_UNKNOWN = '--'

--Const.LISTATTR_TYPE_MAP = {
--    ["kListAttrUseTypeNone"] = 0,
--    ["kListAttrUseTypeDraw"] = 1,
--    ["kListAttrUseTypePVEStage"] = 2,
--    ["kListAttrUseTypeDeposit"] = 3,
--    ["kListAttrUseTypePVETower"] = 4,
--    ["kListAttrUseTypePVETowerSweep"] = 5,     --升阶塔扫荡奖励
--    ["kListAttrUseTypeShop"] = 6,              --商店
--    ["kListAttrUseTypeMail"] = 7,              --邮件
--    ["kListAttrUseTypePVEEquipTower"] = 8,
--    ["kListAttrUseTypePVEEquipTowerSweep"] = 9, --装备塔扫荡奖励
--    ["kListAttrUseTypePVEBossTower"] = 10,
--    ["kListAttrUseTypePVEBossTowerSweep"] = 11, --装备塔扫荡奖励
--    ["kListAttrUseTypePVEBossTowerAward"] = 12, --装备塔累积伤害
--    ["kListAttrUseTypeHeroRecycle"] = 13,      --英雄回收
--    ["kListAttrUseTypeHeroStarUp"] = 14,       --英雄升星
--    ["kListAttrUseTypeItemCompound"] = 15,     --道具合成
--    ["kListAttrUseTypeHeroRecharge"] = 16,     --英雄充能
--    ["kListAttrUseTypeAsyncPVPBattle"] = 17,   --异步pvp挑战
--    ["kListAttrUseTypeAsyncPVPSweep"] = 18,    --异步pvp扫荡
--    ["kListAttrUseTypePVEOnceTower"] = 19,
--    ["kListAttrUseTypeAchieve"] = 20,
--    ["kListAttrUseTypeTask"] = 21,
--    ["kListAttrUseTypeWeeklyTask"] = 23,
--    ["kListAttrUseTypeHeroReset"] = 25,
--    ["kListAttrUseTypeGM"] = 100,            --GM
--    ["kListAttrUseTypeItemUseRecharge"] = 31, --充值返回
--    ["kListAttrUseTypeMonthCard"] = 33,      --月卡充值返回
--    ["kOssReasonFirstRecharge"] = 34,        --首充领取返回
--}

Const.EQUIP_TOWER_LAYER_TYPE_NORMAL = 1
Const.EQUIP_TOWER_LAYER_TYPE_WEEK = 2 -- 装备塔的顶层可以每周打的

------------------------------------------ ↓ 关卡推图 ↓ ------------------------------------------
Const.FORMATION_POWER_OPACTPVP = 2 --个人信息那边取战力跨服竞技,比服务端那边大1
Const.FORMATION_POWER_ASYNCPVP = 3 --异步竞技场

Const.STAGE_STATE_PASSED = 1       --过站
Const.STAGE_STATE_ATK_BF = 2       --占领前(包含探索前和可攻击)
Const.STAGE_STATE_ATK_AF = 3       --占领后
Const.STAGE_STATE_LOCK = 4         --未解锁(包含可解锁和不可解锁)

Const.STAGE_HOOK_UPDATE_CD = 6     --主线挂机刷新间隔
Const.STAGE_HOOK_BASE_AWARD_ID =   --主线挂机默认奖励
{ 100001, 100004, 500000, }


Const.MAIN_STAGE_CHAPTER_NUM = 6                  --主线关卡最大章节数
Const.MAIN_STAGE_DEPOSIT_MAX_TIME = 3600 * 24     -- 挂机奖励最大十二小时
Const.MAIN_STAGE_DEPOSIT_INTERVAL_TIME = 3600 * 1 --挂机奖励跳转时间间隔

------------------------------------------ ↑ 关卡推图 ↑ ------------------------------------------

------------------------------------------ ↓ 货币资源 ↓ ------------------------------------------

-- 服务器用货币类型
Const.MONEY_TYPE_GOLD = "kRoleAttrResourceGold"
Const.MONEY_TYPE_DIAMOND = "kRoleAttrResourceDiamond"
Const.MONEY_TYPE_POWER = "kRoleAttrResourcePower"
Const.MONEY_TYPE_LEVEL = "kRoleAttrLevel"
Const.MONEY_TYPE_EXP = "kRoleAttrXP"
Const.MONEY_TYPE_PVP_SCORE = "kRoleAttrAsyncPVPScore"
Const.MONEY_TYPE_FRIEND_GIFT = "kRoleAttrBuddyGift"
Const.MONEY_TYPE_FURNITURE_COIN = "kRoleAttrFurnitureCoin"
Const.MONEY_TYPE_REAR_HOUSE_COIN = "kRoleAttrHouseCoin"
Const.MONEY_TYPE_BP = "kRoleAttrBP"
Const.MONEY_TYPE_VIP = "kRoleAttrVIP"
Const.MONEY_TYPE_ENERGY = "kRoleAttrEnergy"
Const.MONEY_TYPE_CIRCLE = "kRoleAttrClanCoin"
Const.MONEY_TYPE_ARTIFACT_COIN = "kRoleAttrArtifactCoin"
Const.MONEY_TYPE_HIGH_FURNITURE = "kRoleAttrHighFurnitureCoin"
Const.MONEY_TYPE_REFUND_COIN = "kRoleAttrRefundCoin"
Const.MONEY_TYPE_SKIN_COIN = "kRoleAttrSkinCoin"
Const.MONEY_TYPE_DIAMOND_BUY = "kRoleAttrResourceDiamondBuy" --付费钻石
Const.MONEY_TYPE_ADV_CIRCLE_COIN = "kRoleAttrAdvClanCoin"

Const.MONEY_ID_FAKE_DIAMOND = 100006  -- 假钻石
-- 客户端用货币ID(道具ID)
Const.MONEY_ID_GOLD = 100001          -- 金币
Const.MONEY_ID_DIAMOND = 100002       -- 钻石
Const.MONEY_ID_POWER = 100003         -- 小鱼干 体力
Const.MONEY_ID_EXP = 100004           -- 玩家经验
Const.MONEY_ID_PVP = 510004           -- PVP点
Const.MONEY_ID_MAZE = 510005          -- 迷宫点
Const.MONEY_ID_PVP_TICKET = 510003    -- 竞技场票
Const.MONEY_ID_FRIEND_GIFT = 100011   -- 好友度
Const.MONEY_ID_FURNITURE = 100013     -- 家具币
Const.MONEY_ID_REAR_HOUSE_COIN = 100012 -- 后宅币
Const.MONEY_ID_STAGE_ENERGY = 100016  -- 推图能量

--Const.MONEY_ID_DRAW_BY_GOLD = 510002    -- 金币抽卡道具？
Const.MONEY_ID_DRAW_BY_DIAMOND = 510001 -- 钻石抽卡道具？   zzc 英雄招募卷轴
Const.MONEY_ID_HERO_EXP = 500000        -- 手办经验
Const.MONEY_ID_HERO_EXP2 = 500001       -- 手办邮票
Const.MONEY_ID_VIP_POINT = 100015       -- VIP经验
Const.MONEY_ID_BP = 100014              -- bp点数
Const.MONEY_ID_CIRCLE_COIN = 100017     -- 圈子币
Const.MONEY_ID_GOLD_LEAF = 510009       -- 金叶子
Const.MONEY_ID_ARTIFACT_COIN = 100018   --神器币
Const.MONEY_ID_HIGH_FURNITURE = 100019  --高级家具币
Const.MONEY_ID_REFUND_COIN = 100020     --退款代币
Const.MONEY_ID_SKIN_COIN = 100021       --皮肤代币
Const.MONEY_ID_ADV_CIRCLE_COIN = 100026 --高级公会币
Const.STAR_HEALING_POTION = 510028      --升星复原药水

-- 货币类型到ID转换
Const.MONEY_TYPE2ID = {
    [Const.MONEY_TYPE_GOLD] = Const.MONEY_ID_GOLD,
    [Const.MONEY_TYPE_REFUND_COIN] = Const.MONEY_ID_REFUND_COIN,
    [Const.MONEY_TYPE_DIAMOND] = Const.MONEY_ID_DIAMOND,
    [Const.MONEY_TYPE_DIAMOND_BUY] = Const.MONEY_ID_FAKE_DIAMOND,
    [Const.MONEY_TYPE_POWER] = Const.MONEY_ID_POWER,
    [Const.MONEY_TYPE_EXP] = Const.MONEY_ID_EXP,
    [Const.MONEY_TYPE_FRIEND_GIFT] = Const.MONEY_ID_FRIEND_GIFT,
    [Const.MONEY_TYPE_FURNITURE_COIN] = Const.MONEY_ID_FURNITURE,
    [Const.MONEY_TYPE_REAR_HOUSE_COIN] = Const.MONEY_ID_REAR_HOUSE_COIN,
    [Const.MONEY_TYPE_BP] = Const.MONEY_ID_BP,
    [Const.MONEY_TYPE_VIP] = Const.MONEY_ID_VIP_POINT,
    [Const.MONEY_TYPE_ENERGY] = Const.MONEY_ID_STAGE_ENERGY,
    [Const.MONEY_TYPE_CIRCLE] = Const.MONEY_ID_CIRCLE_COIN,
    [Const.MONEY_TYPE_ARTIFACT_COIN] = Const.MONEY_ID_ARTIFACT_COIN,
    [Const.MONEY_TYPE_HIGH_FURNITURE] = Const.MONEY_ID_HIGH_FURNITURE,
    [Const.MONEY_TYPE_SKIN_COIN] = Const.MONEY_ID_SKIN_COIN,
    [Const.MONEY_TYPE_ADV_CIRCLE_COIN] = Const.MONEY_ID_ADV_CIRCLE_COIN,
}

Const.CAN_JUMP_BUY_MONEY_ID = {
    [Const.MONEY_ID_DIAMOND] = 1,
    [Const.MONEY_ID_POWER] = 1,
}

Const.FUND_DEFAULT_CONFIG = { Const.MONEY_ID_POWER, Const.MONEY_ID_GOLD, Const.MONEY_ID_DIAMOND } -- 默认的上方货币显示:体力  金钱  钻石
Const.FUND_SIMPLE_CONFIG = { Const.MONEY_ID_GOLD, Const.MONEY_ID_DIAMOND }                      -- 简略的上方货币显示:金钱  钻石

--货币兑换 100钻石兑换量


------------------------------------------ ↑ 货币资源 ↑ ------------------------------------------

------------------------------------------ ↓ 成就&任务 ↓ ------------------------------------------
-- 客户端成就类型
Const.CLIENT_ACHEVE_TYPE_TEST = -1
Const.ACHIEVE_TYPE_FORUM = 106
Const.ACHIEVE_TYPE_RENT_HELP = 125
Const.ACHIEVE_TYPE_SHARE_STANDARDDRAW = 126
Const.ACHIEVE_TYPE_SHARE_LIGHTDRAW = 127
Const.ACHIEVE_TYPE_SHARE_NEWSKIN = 128

-- 服务器成就类型
Const.ACTION_TYPE_STAGE_NUM = 49

-- 成就上位系统类型
Const.ACHEVE_UPPER_SYSTEM_BRANCHTASK = 0
Const.ACHEVE_UPPER_SYSTEM_TRUNKTASK = 1
Const.ACHEVE_UPPER_SYSTEM_LOGINTASK = 2


Const.ACHIEVE_SPECIAL_SECOND_RECHARGE      = 1971 -- 特殊的二次充值的成就ID

-- 任务类型
Const.TASK_TYPE                            = {
    ["DAILY"] = "kCSTaskTypeCodeDaily",
    ["WEEKLY"] = "kCSTaskTypeCodeWeak",
    ["NEWBIE"] = "kCSTaskTypeCodeNewbie",
}

-- 任务的状态code
Const.TASK_STATUS                          = {
    ["NOT_ACTIVE"] = -1,
    ["IN_PROCESS"] = 0,
    ["COMPLETE"] = 1,
    ["FAIL"] = 2,
    ["AWARD_GOT"] = 3
}

-- 成就的状态code
Const.ACHIEVE_STATUS                       = {
    ["IN_PROCESS"] = 1,
    ["COMPLETE"] = 2,
    ["AWARD_GOT"] = 3
}

Const.DAILY_TASK_GROUPID                   = 1
Const.WEEKLY_TASK_GROUPID                  = 2

Const.NEWBIE_DRAWCARD_TASKID               = 100
Const.NEWBIE_DRAWCARD_JUMPID               = 30

--图鉴成就类型
Const.HANDBOOK_AWARD_HERODEFINE            = 1
Const.HANDBOOK_AWARD_CAMPDEFINE            = 2

Const.HANDBOOK_JUMP_HERO_ID                = 43

--ClientNotice的id
Const.HANDBOOK_GET_AWARD_NOTICE            = 122
Const.HERO_NOT_FILETER_HERO_NOTICE         = 127
Const.HANDBOOK_NOT_FILETER_HERO_NOTICE     = 128
Const.HANDBOOK_NOT_FILETER_ARTIFACT_NOTICE = 129

------------------------------------------ ↑ 成就&任务 ↑ ------------------------------------------

------------------------------------------ ↓ 商城活动 ↓ ------------------------------------------
Const.WELFARETYPE                          = {}
Const.WELFARETYPE_SHOP                     = "CommonShop" -- 商店
Const.WELFARETYPE_SKINSHOP                 = "SkinShop" --皮肤商店
Const.WELFARETYPE_RELICSHOP                = "RelicShop" --圣物商店
Const.WELFARETYPE_FUND                     = "Fund" -- 基金
Const.WELFARETYPE_NEWBEE                   = "NewBee" -- 礼包
Const.WELFARETYPE_NEWBEE2                  = "NewBee2" -- 礼包
Const.WELFARETYPE_DAYBEE                   = "DayBee" -- 每日礼包
Const.WELFARETYPE_WEEKBEE                  = "WeekBee" -- 每周礼包
Const.WELFARETYPE_MONTHBEE                 = "MonthBee" -- 每月礼包
Const.WELFARETYPE_MONTHCARD                = "MonthCard" -- 月卡福利
Const.WELFARETYPE_BPAWARD                  = "BPAward" -- BP福利
Const.WELFARETYPE_BPTASK                   = "BPTask" -- BP任务
Const.WELFARETYPE_VIPBENEFIT               = "VipBenefit" -- vip特权
Const.WELFARETYPE_RECHARGEGIFT             = "RechargeGift" -- 充值礼包(常规)
Const.WELFARETYPE_ACTGIFT                  = "ActivityGift" --运营活动礼包
Const.MALL_TYPE_JUMP_TMALL                 = "JumpTmall" --周边商城
Const.WELFARETYPE_ACTSHOP                  = "ActivityShop" --运营活动礼包
Const.MALL_TYPE_MULTI_TMALL                = "MultiTmall" --多商城

Const.WELFARETYPE_NEWBEE_GROUP             = {
    NewBee = true,
    NewBee2 = true
}

Const.MALL_TYPE_FULI_TAB                   = 2 -- 页签2 = FULI会员

Const.NO_RECHARGE_WELFARETYPE_DIC          =
{
    [Const.WELFARETYPE_SHOP] = true,
    [Const.WELFARETYPE_SKINSHOP] = true,
    [Const.WELFARETYPE_RELICSHOP] = true,
}

Const.SHOP_ENTER_WELFARETYPE_DIC           =
{
    [Const.WELFARETYPE_SHOP] = true,
    [Const.WELFARETYPE_SKINSHOP] = true,
    [Const.WELFARETYPE_RELICSHOP] = true,
}
--oc的商城跳转，传递页签id
Const.JUMPSHOPTYPE                         = {}
Const.JUMPSHOPTYPE_NORMALSHOP              = 110 --普通商店
Const.JUMPSHOPTYPE_PVPSHOP                 = 102 --荣誉商店
Const.JUMPSHOPTYPE_CIRCLESHOP              = 103 --公会商店
Const.JUMPSHOPTYPE_FRIENDSHOP              = 104 --萌宅商店
Const.JUMPSHOPTYPE_MAZESHOP                = 105 --桌游商店
Const.JUMPSHOPTYPE_BACKYARDSHOP            = 6 --后宅商店
Const.JUMPSHOPTYPE_WORLDBOSS               = 211 --世界boss商店
Const.JUMPSHOPTYPE_OPACTPVP                = 213 --跨服pvp商店
Const.JUMPSHOPTYPE_RECYCLESHOP             = 106 --回收商店
Const.JUMPSHOPTYPE_OdysseyShop             = 54 --奥德赛商店
Const.SHOP_TYPE_HOUSE                      = 3 --后宅商城

--商品表里的type
Const.SHOP_ENTER_TYPE_MAZE                 = 2
Const.SHOP_ENTER_TYPE_SKIN                 = 7
Const.SHOP_ENTER_TYPE_RELIC                = 8

Const.ACT_CONDITION_TYPE_ACHIEVE           = 1 -- 活动解锁的成就类型

------------------------------------------ ↑ 商城活动 ↑ ------------------------------------------

------------------------------------------ ↓ 条件解锁 ↓ ------------------------------------------
Const.CONDITION_LIMIT_HANDBOOK             = 11                     -- 图鉴
Const.CONDITION_LIMIT_HANDBOOK_HERO        = 81                     --战斗mvp开放随机的限制条件
Const.CONDITION_LIMIT_HANDBOOK_ARTIFACT    = 82                     --战斗mvp开放随机的限制条件
Const.CONDITION_LIMIT_ACHIEVE              = 12                     -- 成就
Const.CONDITION_LIMIT_YARD                 = 13                     -- 后宅
Const.CONDITION_LIMIT_SHOP                 = 14                     -- 商店
Const.CONDITION_LIMIT_DRAW                 = 15                     -- 召唤
Const.CONDITION_LIMIT_HERO                 = 16                     -- 手办
Const.CONDITION_LIMIT_NEWBIE_TASK          = 17                     -- 新手任务
Const.CONDITION_LIMIT_MAIL                 = 18                     -- 邮件系统
Const.CONDITION_LIMIT_CIRCLE               = 19                     -- 公会系统
Const.CONDITION_LIMIT_BAG                  = 20                     -- 背包
Const.CONDITION_LIMIT_OTHER_BATTLE         = 21                     -- 其他战斗
Const.CONDITION_LIMIT_STEP_TOWER           = 22                     -- 升阶塔
Const.CONDITION_LIMIT_BOSS_TOWER           = 23                     -- 玩法2 BOSS塔解锁ID
Const.CONDITION_LIMIT_BOSS_TOWER_EX        = 24                     --boss挑战神器
Const.CONDITION_LIMIT_ONCE_TOWER           = 25
Const.CONDITION_LIMIT_PVP                  = 26                     -- 竞技场
Const.CONDITION_LIMIT_EQUIP_TOWER          = 27                     -- 装备塔
Const.CONDITION_LIMIT_MAZE                 = 28                     -- 迷宫
Const.CONDITION_LIMIT_BATTLE_AUTO          = 29                     -- 战斗：自动
Const.CONDITION_LIMIT_BATTLE_SPEED         = 30                     -- 战斗：速度
Const.CONDITION_LIMIT_RECHARGE             = 36                     -- 战斗：速度
Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT   = 55                     -- 战斗：简化大招解锁
Const.CONDITION_LIMIT_FORMATION_LIMIT      = 40                     -- 上阵人数检测
Const.CONDITION_LIMIT_HERO_RESET           = 41                     -- 英雄重置
Const.CONDITION_LIMIT_DIAMOND_BUY_JUMP     = 42                     -- 钻石购买跳转
Const.CONDITION_LIMIT_POWER_BUY_JUMP       = 43                     -- 体力购买跳转
Const.CONDITION_LIMIT_HERO_STARUP          = 45                     -- 英雄升星
Const.CONDITION_LIMIT_HERO_RECYCLE         = 46                     -- 英雄回收
Const.CONDITION_LIMIT_STAGE_RANK           = 48                     -- 排行榜
Const.CONDITION_LIMIT_PET_SYSYTEM          = 49                     -- 宠物系统
Const.CONDITION_LIMIT_PET_GEM_SYSYTEM      = 338                    -- 宠物宝石系统
Const.CONDITION_LIMIT_PET_RUNE_SYSYTEM     = 340                    -- 宠物符文系统
Const.CONDITION_LIMIT_NEWBIE_DRAW_VISIBLE  = 50                     -- 新手抽卡的可见性
Const.CONDITION_LIMIT_NEWBIE_DRAWCARD      = 51                     -- 新手抽卡的可购买
Const.CONDITION_LIMIT_BULLET_SCREEN        = 56                     --弹幕
Const.CONDITION_LIMIT_SPEAKER_BOX          = 57                     --走马灯
Const.CONDITION_LIMIT_MONUMENT             = 58                     --丰碑
Const.CONDITION_LIMIT_HOOK                 = 59                     --收菜
Const.CONDITION_LIMIT_ITEM_GUILD           = 60                     --获取途径
Const.CONDITION_LIMIT_MULTIPVP             = 72                     --三队竞技场
Const.CONDITION_LIMIT_BATTLE_CAMERA        = 76                     -- 战斗：表演视角

Const.CONDITION_LIMIT_ACTIVITY_STORE       = 37                     --活动界面金叶子商店
Const.CONDITION_LIMIT_BAGWEAR              = 10                     --背包穿戴界面解锁条件

Const.CONDITION_TASK_GOT_UNLOCK            = 1                      -- 成就任务解锁条件：领取奖励后解锁
Const.CONDITION_TASK_QUALIFY_UNLOCK        = 2                      -- 成就任务解锁条件：完成即解锁

Const.CONDITION_PUSHGIFT                   = 70                     --推送礼包条件区分
--Const.CONDITION_MORE_PUSHGIFT = 71       --推送礼包条件区分
Const.CONDITION_MVP_RAND                   = 71                     --战斗mvp开放随机的限制条件
Const.CONDITION_BATTLE_PASS_REPLAY         = 182                    --主线推图的路线按钮
Const.CONDITION_RECOMMEND_TRAIN            = 84                     --推荐培养入口限制条件
Const.CONDITION_HERO_EXCHANGE              = 85                     --英雄互换入口限制条件

Const.CONDITION_LIMIT_OPACTPVP             = 184                    --跨服竞技场开放条件

Const.CONDITION_LIMIT_MAIN_SETTING_BLOG    = 87                     -- 设置界面 微博入口

Const.CONDITION_LIMIT_HANDBOOK_TEAM        = 80                     --练度入口
Const.CONDITION_LIMIT_HANDBOOK_PLOTREWIND  = 91                     --剧情回看入口
Const.CONDITION_STAR_UP_REVERT             = 90                     --升星回退入口
Const.CONDITION_LIMIT_BOSS_EXPAND          = 188                    --终焉扩展开放
Const.CONDITION_LIMIT_ARTIFACT             = 397                    --符石开放
Const.CONDITION_LIMIT_RELATION             = 189                    --羁绊系统

Const.CONDITION_LIMIT_RECYCLESHOP          = 200                    --回收商店
Const.MONEY_BUY_JUMP_CONDITION             =
{
    [Const.MONEY_ID_DIAMOND] = Const.CONDITION_LIMIT_DIAMOND_BUY_JUMP,
    [Const.MONEY_ID_POWER] = Const.CONDITION_LIMIT_POWER_BUY_JUMP
}
------------------------------------------ ↑ 条件解锁 ↑ ------------------------------------------

Const.TEAM_PAGEIDX_DIC                     =
{
    [1] = 5,
    [2] = 2,
    [3] = 6,
    [4] = 3,
    [5] = 1,
    [6] = 4,
}
Const.PAGEIDX_TEAM_DIC                     = {}
for k, v in pairs(Const.TEAM_PAGEIDX_DIC) do
    Const.PAGEIDX_TEAM_DIC[v] = k
end

------------------------------------------ ↓ 玩法信息ID ↓ ------------------------------------------
Const.GAME_PLAY_NOTICE_EQUIP_TOWER = 1
Const.GAME_PLAY_NOTICE_CHALLENGE_BOSS = 2
Const.GAME_PLAY_NOTICE_ARENA = 3
Const.GAME_PLAY_NOTICE_ONCE_TOWER = 4
Const.GAME_PLAY_NOTICE_TOWER = 5
Const.GAME_PLAY_NOTICE_MAZE = 6
Const.GAME_PLAY_NOTICE_BOSS_EXPAND = 18
------------------------------------------ ↑ 玩法信息ID ↑ ------------------------------------------
--主线通关预览界面开关
if not NO_CSHARP and RegionUtils and (RegionUtils.isCN() or RegionUtils.isTW()) then
    Const.FORCE_OPEN_MAIN_STAGE_PREVIEW = true
else
    Const.FORCE_OPEN_MAIN_STAGE_PREVIEW = false
end

------------------------------------------ ↓ 异步pvp ↓ ------------------------------------------
Const.ASYNC_PVP_MATCH_SHOW_COUNT = 6 --异步pvp匹配显示的数量
Const.ASYNC_PVP_MATCHED_UIDS_KEY = "AsyncPvpMatchedUids"
Const.ASYNCPVP_DETAIL_TYPE_MATCH = "kCSAsyncPVPDetailTypeMatch"
Const.ASYNCPVP_DETAIL_TYPE_REPORT = "kCSAsyncPVPDetailTypeReport"
Const.ASYNCPVP_DETAIL_TYPE_RANK = "kCSAsyncPVPDetailTypeRank"
Const.FORMATION_GET_INTERVAL = 300 --竞技场刷新防守阵容的间隔
Const.PVP_SCORE_GET_INTERVAL = 60
------------------------------------------ ↑ 异步pvp ↑ ------------------------------------------

------------------------------------------ ↓ 新手相关 ↓ ------------------------------------------
-- 触发类型


-- 条件类型



------------------------------------------ ↑ 新手相关 ↑ ------------------------------------------

------------------------------------------ ↓ 好友相关 ↓ ------------------------------------------
Const.MAX_BUDDY_BLACKLISTNUM = 10   -- 黑名单上限
Const.MAX_FRIEND_NUM = 30           -- 好友上限
Const.MAX_FRIEND_REQUEST_NUM = 30   -- 好友申请列表上限
Const.MAX_FRIEND_GIFT_SEND_NUM = 30 -- 每天发送好友度数量
Const.MAX_FRIEND_GIFT_GET_NUM = 20  -- 每天接受好友度数量
------------------------------------------ ↑ 好友相关 ↑ ------------------------------------------

------------------------------------------ ↓ UI相关 ↓ ------------------------------------------
Const.ON_WINDOW_OPEN = 2  --开启界面
Const.ON_WINDOW_CLOSE = 3 --关闭界面
------------------------------------------ ↑ UI相关 ↑ ------------------------------------------
-- Const.ALL_SERVER_LIST = {}      -- 全部服务器名字存储
-- Const.PLAYER_SERVER_NAME = ""   -- 玩家自己服务器名字存储
-- Const.PLAYER_SERVER_GID = ""    -- 玩家自己服务器名字GID


Const.BYTE_ZERO = string.char(0)
Const.EQUIP_TOWER_HIGH_DEF_SWEEP_LAYER = 35 --转高默认扫荡次数的层

------------------------------------------ ↓ 迷宫 ↓ ------------------------------------------
Const.MAZE_CHALLENGED_NODE = "keyMazeChallengedNode" --本地保存的后缀
Const.MAZE_NEXT_OPEN_ID = "keyMazeNextOpenId"      --迷宫下一个应该开放的迷宫id

Const.MAZE_DIE_BATTLE_NODE = 5                     --死战节点
Const.MAZE_BLOOD_BATTLE_NODE = 7                   --血战节点
Const.MAZE_MAX_HERO_LIMIT = 30                     --迷宫最多上阵人数
------------------------------------------ ↑ 迷宫 ↑ ------------------------------------------


------------------------------------------ ↓ 个人信息 ↓ ------------------------------------------
Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP = 1
Const.ROLEINFO_ROBOT_TYPE_MULTIPVP = 2

Const.ROLEINFO_REFRESH_INTERVAL = 60                       --个人信息获取时间间隔
Const.ROLEINFO_CACHE_COUNT = 300                           --个人信息缓存的个数
Const.PERSONAL_HEAD_ID = 500                               --暂定的个人头像id
Const.CHECK_HEAD_STATUS_INTERVAL = 300                     --获取自己头像状态的间隔（审核中的时候）
Const.CHECK_HEAD_OTHER_INTERVAL = 3600 * 3                 --获取他人头像间隔
Const.POST_HEAD_INTERVAL = 8 * 3600                        --上传头像间隔
Const.EDIT_SIGN_INTERVAL = 3                               --编辑签名的时间间隔（秒）
Const.EDIT_SIGN_DAY_TIMES = 3                              --一天编辑签名的次数

Const.DEFAULT_CIRCLE_FRAME_ID = 0                          --默认的公会头像框（空的）

Const.WEB_REQ_STATE_CODE = {
    ["SUCCESS"] = 0,
    ["FAIL"] = 1,
    ["TIME_OUT"] = 2,
    ["ABORT"] = 3,
    ["UNKNOWN"] = 4,
}

Const.POST_STATUS = {
    OK = 0,         --通过
    REVIEWING = 1,  --审核中
    FAIL = 2,       --审核失败
    WILL_REVIEW = 3 --待审核
}

Const.CUSTOM_HEAD_STATUS = { --服务端返回的错误码
    --服务端返回的
    TOO_BIG = 1001,
    REVIEWING = 1002,
    FORBID = 1003,         --审核失败返回这个
    NOT_FIND = 1004,
    TOO_FREQUENTLY = 1005, --上传太频繁
    --客户端自己加的
    UP_LOADING = 1100,
    UP_LOAD_FAILD = 1101,
    DOWN_OK = 1102,
    POST_OK = 1103,
}
--按位或或者要请求的数据
Const.ROLECOMM_GET_TPYE = {
    ALL = 0,
    SIMPLE = 1,
    SIMPLE_PERSONAL = 3,
    SIMPLE_POWER = 5,
}

Const.HERO_SKIN_QUALITY_COLLECTOR = 4 --大收藏家

Const.DEFAULT_COMMINFO = {
    uid = "0",
    level = 1,
    head = 1,
    headFrameId = 0,
    head_frame_end_time = 0,
    name = "",
}


if not NO_CSHARP and RegionUtils and (RegionUtils.isCN()) then
    Const.FORBID_INFO_MODIFY = true
else
    Const.FORBID_INFO_MODIFY = false
end
------------------------------------------ ↑ 个人信息 ↑ ------------------------------------------

------------------------------------------ ↓ 共鸣水晶 ↓ ------------------------------------------
Const.TYPE_CRYSTAL_NONE                = 0 --none
Const.TYPE_CRYSTAL_PRIESTS             = 1 --祭司
Const.TYPE_CRYSTAL_SYMPATHIZER         = 2 --共鸣者
Const.TYPE_CRYSTAL_MAX                 = 3 --max
------------------------------------------ ↑ 共鸣水晶 ↑ ------------------------------------------

------------------------------------------ ↓ 特权 ↓ ------------------------------------------
Const.PRIVITY_KEY_GOLD                 = 1 -- 挂机金币
Const.PRIVITY_KEY_HERO_EXP             = 2 -- 挂机经验
Const.PRIVITY_KEY_HOUSE_COIN           = 3 -- 挂机后宅币
Const.PRIVITY_KEY_FURNITURE_COIN       = 4 -- 挂机家具币
Const.PRIVITY_KEY_MAZE_COIN            = 5 -- 迷宫获取迷宫币
Const.PRIVITY_KEY_ARENA_COUNT          = 6 -- 竞技场每日次数
Const.PRIVITY_KEY_POWER_LIMIT          = 7 -- 体力自然恢复上限
Const.PRIVITY_KEY_POWER_RECOVERY       = 8 -- 体力每小时回复速度
Const.PRIVITY_KEY_POWER_BUY_COUNT      = 9 -- 体力每日购买次数
Const.PRIVITY_KEY_HERO_BAG_LIMIT       = 10 -- 英雄背包上限
Const.PRIVITY_KEY_EQUIP_BAG_LIMIT      = 11 -- 装备背包上限
Const.PRIVITY_KEY_DEPOSIT_TIME_LIMIT   = 12 -- 挂机时间上限
Const.PRIVITY_KEY_ARTIFACT_BAG_LIMIT   = 13 -- 神器背包上限
Const.PRIVITY_KEY_MAZE_GOLD            = 14 -- 迷宫金币
Const.PRIVITY_KEY_EQUIP_OFF_COST       = 15 -- 加固装备脱下打折
Const.PRIVITY_KEY_EQUIP_TOWER_SWEEP    = 16 -- 装备塔额外次数
Const.PRIVITY_KEY_EBONUS_WORLD_BOSS    = 17 -- 终焉之战额外奖励
Const.PRIVITY_KEY_EBONUS_MAZE          = 18 -- 迷宫额外奖励
Const.PRIVITY_KEY_EBONUS_DAILY_TASK    = 19 -- 每日任务额外奖励

Const.PRIVITY_EFFECT_TYPE              = {}
Const.PRIVITY_EFFECT_TYPE.CONTINUE     = 1 --持续特权
Const.PRIVITY_EFFECT_TYPE.ONCE         = 2 --瞬时特权

Const.PRIVITY_KEY_EFFECT_DIC           =
{
    [Const.PRIVITY_KEY_GOLD] = Const.PRIVITY_EFFECT_TYPE.CONTINUE,
    [Const.PRIVITY_KEY_HERO_EXP] = Const.PRIVITY_EFFECT_TYPE.CONTINUE,
    [Const.PRIVITY_KEY_HOUSE_COIN] = Const.PRIVITY_EFFECT_TYPE.CONTINUE,
    [Const.PRIVITY_KEY_FURNITURE_COIN] = Const.PRIVITY_EFFECT_TYPE.CONTINUE,
    [Const.PRIVITY_KEY_MAZE_COIN] = Const.PRIVITY_EFFECT_TYPE.ONCE,
    [Const.PRIVITY_KEY_ARENA_COUNT] = Const.PRIVITY_EFFECT_TYPE.ONCE,
    [Const.PRIVITY_KEY_POWER_LIMIT] = Const.PRIVITY_EFFECT_TYPE.CONTINUE,
    [Const.PRIVITY_KEY_POWER_RECOVERY] = Const.PRIVITY_EFFECT_TYPE.CONTINUE,
    [Const.PRIVITY_KEY_POWER_BUY_COUNT] = Const.PRIVITY_EFFECT_TYPE.ONCE,
    [Const.PRIVITY_KEY_HERO_BAG_LIMIT] = Const.PRIVITY_EFFECT_TYPE.ONCE,
    [Const.PRIVITY_KEY_EQUIP_BAG_LIMIT] = Const.PRIVITY_EFFECT_TYPE.ONCE,
    [Const.PRIVITY_KEY_DEPOSIT_TIME_LIMIT] = Const.PRIVITY_EFFECT_TYPE.ONCE,
    [Const.PRIVITY_KEY_ARTIFACT_BAG_LIMIT] = Const.PRIVITY_EFFECT_TYPE.ONCE,
    [Const.PRIVITY_KEY_MAZE_GOLD] = Const.PRIVITY_EFFECT_TYPE.ONCE,
    [Const.PRIVITY_KEY_EQUIP_OFF_COST] = Const.PRIVITY_EFFECT_TYPE.ONCE,
}

Const.EQUIP_OFF_PRIVILEGE_SHOP_ITEM_ID = 25017
Const.EQUIP_OFF_PRIVILEGE_ID           = 1401

Const.PRIVILEGE_SHOP_ITEM_ID_DIC       =
{
    [Const.EQUIP_OFF_PRIVILEGE_ID] = Const.EQUIP_OFF_PRIVILEGE_SHOP_ITEM_ID
}
-- 使用 CurAvatar:getPrivilegeValue(const.key, value) 得到修正后的值

Const.BAG_TYPE_PRIVATE                 =
{
    [Const.BAG_TYPE_EQUIP] = Const.PRIVITY_KEY_EQUIP_BAG_LIMIT,
    [Const.BAG_TYPE_ARTIFACT] = Const.PRIVITY_KEY_ARTIFACT_BAG_LIMIT,
    [Const.BAG_TYPE_HERO] = Const.PRIVITY_KEY_HERO_BAG_LIMIT
}

Const.RED_PACKET_PRIVILE_ACT_ID        = 1902
Const.PRIVILEGE_UPDATE_REASON_ITEM_GM  = 1
Const.PRIVILEGE_UPDATE_REASON_ITEM_USE = 2
Const.PRIVILEGE_UPDATE_REASON_VIP      = 3
------------------------------------------ ↑ 特权 ↑ ------------------------------------------

------------------------------------------ ↓ 运营活动 ↓ ------------------------------------------
Const.OPACT_STATE_NONE                 = "kResActStateNone" -- 无状态
Const.OPACT_STATE_PREOPEN              = "kResActStatePreOpen" -- 预开启
Const.OPACT_STATE_OPEN                 = "kResActStateOpen" -- 打开, (读写数据)
Const.OPACT_STATE_FREEZE               = "kResActStateFreeze" -- 冻结, (只读数据)
Const.OPACT_STATE_CLOSE                = "kResActStateClose" -- 关闭
Const.OPACT_STATE_SUSPEND              = "kResActStateSuspend" -- 暂停
Const.OPACT_STATE_MAX                  = "kResActStateMax" -- Max

Const.ACT_TYPE_ACHIEVE                 = "kResOpActTypeAchieve"
Const.ACT_TYPE_GIFT                    = "kResOpActTypeGift"
Const.ACT_TYPE_MONOPOLY                = "kResOpActTypeMonopoly"
Const.ACT_TYPE_SHOP                    = "kResOpActTypeShop"
Const.ACT_TYPE_DEPOSIT                 = "kResOpActTypeDeposit"
Const.ACT_TYPE_UPDRAW                  = "kResOpActTypeDraw"
Const.ACT_TYPE_BINGO                   = "kResOpActTypeBingo"
Const.ACT_TYPE_PLOT                    = "kResOpActTypePlot"
Const.ACT_TYPE_WORLD_BOSS              = "kResOpActTypeWorldBoss"
Const.ACT_TYPE_RECHARGE_REBATE         = "kResOpActTypeRechargeRebate"
Const.ACT_TYPE_REPLACE_POOL            = "kResOpActTypeDrawReplace"
Const.ACT_TYPE_LOTTERY                 = "kResOpActTypeLottery"
Const.ACT_TYPE_ARENA                   = "kResOpActTypeArena"  --跨服竞技场
Const.ACT_TYPE_WISH                    = "kResOpActTypeWish"   --许愿签到活动
Const.ACT_TYPE_SEASON_TOWER            = "kResOpActTypeTower"  -- 赛季爬塔
Const.ACT_TYPE_FIREPLACE               = "kResOpActTypeFirePlace" --许愿壁炉
Const.ACT_TYPE_STAGE_DEPOSIT           = "kResOpActTypeStageDepositUp" --主线挂机提升
Const.ACT_TYPE_RENT_UP                 = "kResOpActTypeRentUp" -- 悬赏的up
Const.ACT_TYPE_PRIVILEGE               = "kResOpActTypePrivilege" -- 特权
Const.ACT_TYPE_NEW_YEAR_DINNER         = "kResOpActTypeOnHook" -- 年夜饭
Const.ACT_TYPE_Hatsune                 = "kResOpActTypeHatsune" -- 初音应援
Const.ACT_TYPE_CIRCLE_BATTLE           = "kResOpActTypeClanBattle" --公会战
Const.ACT_TYPE_CLAN_CLEAR              = "kResOpActTypeClanBoss" --大扫除
Const.ACT_TYPE_FASHION_LOTTERY         = "kResOpActTypeFashionLottery" --夏日时装抽奖

Const.ACT_TYPE_ID_DIC                  =
{
    [Const.ACT_TYPE_ACHIEVE] = 1,
    [Const.ACT_TYPE_GIFT] = 2,
    [Const.ACT_TYPE_MONOPOLY] = 3,
    [Const.ACT_TYPE_SHOP] = 4,
    [Const.ACT_TYPE_DEPOSIT] = 5,
    [Const.ACT_TYPE_UPDRAW] = 6,
    [Const.ACT_TYPE_BINGO] = 7,
    [Const.ACT_TYPE_PLOT] = 8,
    [Const.ACT_TYPE_WORLD_BOSS] = 9,
    [Const.ACT_TYPE_RECHARGE_REBATE] = 10,
    [Const.ACT_TYPE_REPLACE_POOL] = 11,
    [Const.ACT_TYPE_LOTTERY] = 12,
    [Const.ACT_TYPE_ARENA] = 13,
    [Const.ACT_TYPE_WISH] = 14,
    [Const.ACT_TYPE_SEASON_TOWER] = 15,
    [Const.ACT_TYPE_FIREPLACE] = 16,
    [Const.ACT_TYPE_STAGE_DEPOSIT] = 17,
    [Const.ACT_TYPE_RENT_UP] = 18,
    [Const.ACT_TYPE_PRIVILEGE] = 19,
    [Const.ACT_TYPE_NEW_YEAR_DINNER] = 20,
    [Const.ACT_TYPE_Hatsune] = 21,
    [Const.ACT_TYPE_CIRCLE_BATTLE] = 22,
    [Const.ACT_TYPE_CLAN_CLEAR] = 23,
    [Const.ACT_TYPE_FASHION_LOTTERY] = 24,
}


Const.ACT_ACHIEVE_STATE_GOT = 1        -- 已经完成
Const.ACT_ACHIEVE_STATE_ENOUGH = 2     -- 进度满足 可以领取
Const.ACT_ACHIEVE_STATE_NOT_ENOUGH = 3 -- 进度不满足 不可以领取
Const.ACT_ACHIEVE_STATE_LOCK = 4       -- 被锁了 比如没充值 不可以领取

Const.MENU_BANNER_TYPE_ACTIVITY = 1
Const.MENU_BANNER_TYPE_ACTIVITY_GROUP = 2
Const.MENU_BANNER_TYPE_ACTIVITY_NO_GROUP = 3

Const.ACT_TYPE_PLOT_MODE_HOT = 1     -- 预热章节
Const.ACT_TYPE_PLOT_MODE_STORY = 2   -- 故事模式章节
Const.ACT_TYPE_PLOT_MODE_BATTLE = 3  -- 战斗模式章节

Const.ACT_ACHIEVE_TYPE_STAGE = 5     -- 成就活动目标类型是主线任务关卡
Const.ACT_ACHIEVE_TYPE_RECHARGE = 30 -- 成就活动目标类型是充值金额


Const.ACT_PRIVILEGE_TYPE_EQUIP_COST_OFF = 1     -- 加固装备脱下打折
Const.ACT_PRIVILEGE_TYPE_BY_ACHIEVE = 2         -- 关联成就活动
Const.ACT_PRIVILEGE_TYPE_EQUIP_SWEEP = 3        -- 装备塔额外扫荡次数

Const.ACT_PRIVILEGE_TYPE_EQUIP_DEBUFF_ID = 1903 -- 装备塔惩戒活动id
Const.ACT_PRIVILEGE_TYPE_CELL_CLASS_COMMON = "PrivilegeCell"
Const.ACT_PRIVILEGE_TYPE_CELL_CLASS_PROGRESS = "PrivilegeProgressCell"
Const.ACT_PRIVILEGE_TYPE_CELL_CLASS_DEBUFF = "DebuffPrivilegeCell"
Const.BTN_TYPE_ACTIVITY = 1
Const.BTN_TYPE_RENT = 3

Const.SHOW_STATE_LOCK = 0
Const.SHOW_STATE_PREDICT = 1
Const.SHOW_STATE_OPEN = 2
------------------------------------------ ↑ 运营活动 ↑ ------------------------------------------

------------------------------------------ ↓ 圈子系统 ↓ ------------------------------------------

Const.CIRCLE_DUTY_MEMBER = 0    --圈子成员
Const.CIRCLE_DUTY_MANAGER = 1   --圈子管理
Const.CIRCLE_DUTY_ASSISTANT = 2 --圈子副会长
Const.CIRCLE_DUTY_BOSS = 3      --圈子会长
--local ResClanPermission = require "Core/ClientData/ResClanPermission"
--Const.CIRCLE_DUTY_NAME_DIC =
--{
--    [Const.CIRCLE_DUTY_MEMBER] = ResClanPermission[Const.CIRCLE_DUTY_MEMBER].duty_name,
--    [Const.CIRCLE_DUTY_MANAGER] = ResClanPermission[Const.CIRCLE_DUTY_MANAGER].duty_name,
--    [Const.CIRCLE_DUTY_ASSISTANT] = ResClanPermission[Const.CIRCLE_DUTY_ASSISTANT].duty_name,
--    [Const.CIRCLE_DUTY_BOSS] = ResClanPermission[Const.CIRCLE_DUTY_BOSS].duty_name,
--}

--Const.CIRCLE_DUTY_DES_DIC =
--{
--    [Const.CIRCLE_DUTY_MEMBER] = ResClanPermission[Const.CIRCLE_DUTY_MEMBER].duty_des,
--    [Const.CIRCLE_DUTY_MANAGER] = ResClanPermission[Const.CIRCLE_DUTY_MANAGER].duty_des,
--    [Const.CIRCLE_DUTY_ASSISTANT] = ResClanPermission[Const.CIRCLE_DUTY_ASSISTANT].duty_des,
--    [Const.CIRCLE_DUTY_BOSS] = ResClanPermission[Const.CIRCLE_DUTY_BOSS].duty_des,
--}

Const.CIRCLE_DUTY_ICON_DIC =
{
    [Const.CIRCLE_DUTY_MEMBER] = "",
    [Const.CIRCLE_DUTY_MANAGER] = "<9008>",
    [Const.CIRCLE_DUTY_ASSISTANT] = "<9009>",
    [Const.CIRCLE_DUTY_BOSS] = "<9010>",
}

Const.CIRCLE_ACTIVITY_PANEL = 1
Const.CIRCLE_HOMEPAGE_PANEL = 2
Const.CIRCLE_MEMBER_LIST_PANEL = 3
Const.CIRCLE_APPLY_LIST_PANEL = 4

Const.CIRCLE_SEARCH_BYLIST = 1             --公会列表搜索
Const.CIRCLE_SEARCH_DETAIL = 2             --公会详情获取

Const.MAX_CIRCLE_NAME_MAXLEN = 14          --公会名字长度
Const.MAX_CIRCLE_TITLE_MAXLEN = 30         --公会标题长度
Const.MAX_CIRCLE_CONTENT_MAXLEN = 160      --公会公告长度
Const.MAX_CIRCLE_MAIL_TITLE_MAXLEN = 26    --公会邮件标题长度
Const.MAX_CIRCLE_MAIL_CONTENT_MAXLEN = 200 --公会邮件内容长度
Const.MAX_CIRCLE_EXIT_REASON_MAXLEN = 60   --公会退出理由长度
Const.MAX_CIRCLE_INVITE_NUM = 30           --公会最多邀请30个人
Const.MAX_CIRCLE_INVITED_NUM = 20          --最多被20个公会邀请
Const.MAX_CIRCLE_APPLYLIST_COUNT = 30      --公会申请列表上限

Const.MAX_EQUIPPLAN_NAME_MAXLEN = 16       --方案名称名字长度
Const.CIRCLE_JOIN_TYPE_APPLY = 0           --申请
Const.CIRCLE_JOIN_TYPE_INVITE = 2          --接受邀请

Const.CIRCLE_RECOMMEND_COUNT_PER_PAGE = 30 --公会申请列表上限

Const.CIRCLE_SHARE_CHARACTER = 60          -- 公会分享字符数，中文算两个

Const.DUTY_RELIEVE_DIC =
{
    [Const.CIRCLE_DUTY_MANAGER] = "relieve_manager",
    [Const.CIRCLE_DUTY_ASSISTANT] = "relieve_vleader",
    [Const.CIRCLE_DUTY_BOSS] = "relieve_manager",
}

Const.APPOINT_DUTY_DIC =
{
    ["appoint_manager"] = Const.CIRCLE_DUTY_MANAGER,
    ["appoint_vleader"] = Const.CIRCLE_DUTY_ASSISTANT,
    ["appoint_leader"] = Const.CIRCLE_DUTY_BOSS,
}

Const.CIRCLE_MAX_ASSISTANT_COUNT = 2
Const.CIRCLE_MAX_MANAGER_COUNT = 4

Const.CIRCLE_BOSS_AWARD_DAY_SA = 0  --公会boss日结结算奖励
Const.CIRCLE_BOSS_AWARD_WEEK_SA = 1 --公会boss周结结算奖励
Const.CIRCLE_BOSS_AWARD_SA_WDAY = 1 --公会boss周结算时跨周的是周几

--公会战格子类型
Const.CIRCLE_GRID_TYPE = {
    NORMAL = { [0] = true },
    SPACE = { [1] = true, [2] = true },
    STATUE = { [3] = true, [4] = true, [5] = true },
    START = { [6] = true, [7] = true },
    END = { [8] = true },

}
--公会战格子翻开类型
Const.CIRCLE_GRID_OPEN_TYPE = {
    NONE = 50, --空白
    SCORE = 51,
    BOX = 52,
    RUNE = 53, --符文
    MONSTER = 54,
    BOSS = 55,
    HINDER = 56, --障碍
    TRAP = 57,
}

--公会战格子状态
Const.CIRCLE_GRID_STATUS = {
    HIDE = 0,          --未翻开的状态
    GUARD = 1,         --被守护
    PREVIEW = 2,       --预览
    PREVIEW_GUARD = 3, --可预览但被守护
    SHOW = 4,          --翻开的状态，但是有东西占领
    OPEN = 8,          --翻开的状态，可以走
}

Const.CIRCLE_COMMON_MODEL_TYPE = {
    PLAYER = 1,
    OTHER = 2,
}

Const.CIRCLE_TIMER_TYPE = {
    NONE = 0,
    OCCUPY = 1,
    FORMATION = 2,
    BATTLE = 3,
}

Const.CIRCLE_PLAYER_STATE = {
    NONE = 0,
    SEARCH = 1,    --占用
    FORMATION = 2, --布阵
    BATTLE = 3,    -- 战斗

}

Const.CIRCLE_LOGO_TYPE = {
    PLAYER = 1,
    GRID = 2,
}
--公会战需要处理的倒计时类型
--Const.CIRCLE_TIMER_CONFIG = {
--    [Const.CIRCLE_TIMER_TYPE.OCCUPY] = { name = "circleBattleTimer1", tick = 10, cbName = "_occupyOverTimeCB" },
--    [Const.CIRCLE_TIMER_TYPE.FORMATION] = { name = "circleBattleTimer2", tick = 300, cbName = "_formationOverTimeCB" },
--    [Const.CIRCLE_TIMER_TYPE.BATTLE] = { name = "circleBattleTimer3", tick = 300, cbName = "_battleOverTimeCB" },
--}

Const.CIRCLE_BATTLE_MSG_TYPE = {
    MOVE_POINT = 1,
    SCORE = 2,
    PROFICIENCY_SEARCH = 3, --熟练度
    PROFICIENCY_BATTLE = 4,
}

--提示玩家的表现类型
Const.CIRCLE_BATTLE_SHOW_TYPE = {
    BOX = 1,
    BOSS = 2,
    END = 3,
}

Const.CIRCLE_BATTLE_SKILL_ID = {
    SHOW_BOSS = 201,
    SHOW_BOX = 202,
    SHOW_RUNE = 203,
}

Const.CIRCLE_BATTLE_SKILL_OPLOG_TYPE = {
    BUY = 0,
    USE = 1,
}

Const.CIRCLE_BATTLE_ENTER_CD = 30             --进入公会战的cd
Const.CIRCLE_BATTLE_BOSS = 3                  --公会战首领
Const.CIRCLE_SHOW_MODEL_NUM = 20              --公会战场景显示最多玩家数量
Const.CIRCLE_MODEL_YOFFSET = 0.05             --模型y偏移
Const.CIRCLE_CLICK_GRID_INTERVAL = 3          --取消后点击格子的cd
Const.CIRCLE_MODEL_MAX_MOVE_TIME = 3          --公会战场景模型移动最大耗时秒
Const.CIRCLE_OCCUPY_CANCEL_TIME = 1.5         --玩家占用后x秒内没有翻就取消
Const.CIRCLE_MODEL_SINGLE_MOVE_TIME = 0.5     --公会战场景单个格子默认移动时间
Const.CIRCLE_MODEL_SINGLE_ROTATE_TIME = 0.12  --公会战场景旋转耗时
Const.CIRCLE_FORMATION_TIP_TIME = 10          --公会战布阵x秒需要特殊提示
Const.CIRCLE_BATTLE_ZOOM_DURATION = 1.5       --公会战镜头变化时间
Const.CIRCLE_BATTLE_MAX_MODEL_SHOW_NUM = 15   --公会战最多显示玩家模型数量
Const.CIRCLE_BATTLE_SCENE_SHADOW_DIS = 40     --公会战场景投影距离
Const.CIRCLE_BATTLE_MAX_PLAYER_MODEL_NUM = -1 --公会战场景最多允许移动的模型数量,负数不生效
Const.CIRCLE_BATTLE_DEBUG_MODE = false

Const.FORCE_OPEN_CIRCLE_BATTLE = true

Const.CIRCLE_BATTLE_FRAME_EXPIRE_TIME = 1209600

Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE = 1
Const.CIRCLE_BATTLE_SKILL_TYPE_PASSIVE = 2
Const.CIRCLE_BATTLE_SKILL_TYPE_BATTLE = 3

Const.CIRCLE_BATTLE_SKILL_TYPE_NAME =
{
    [Const.CIRCLE_BATTLE_SKILL_TYPE_BATTLE] = "战斗特技",
    [Const.CIRCLE_BATTLE_SKILL_TYPE_PASSIVE] = "游园特技",
    [Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE] = "探索特技",
}

--公会战层目标，策划说写死
Const.CIRCLE_BATTLE_LAYER_TARGET_KILL_BOSS = 1     --层目标发现BOSS
Const.CIRCLE_BATTLE_LAYER_TARGET_FIND_TREASURE = 2 --层目标发现宝箱进度
Const.CIRCLE_BATTLE_LAYER_TARGET_THROUGH_PATH = 3  --层目标打通路径

Const.CIRCLE_BATTLE_LAYER_TARGET_INFO =
{
    [Const.CIRCLE_BATTLE_LAYER_TARGET_KILL_BOSS] = { percent = 30, },
    [Const.CIRCLE_BATTLE_LAYER_TARGET_FIND_TREASURE] = { percent = 30, },
    [Const.CIRCLE_BATTLE_LAYER_TARGET_THROUGH_PATH] = { percent = 40, },
}

Const.CIRCLE_TALENT_TYPE_SEARCH = 1
Const.CIRCLE_TALENT_TYPE_BATTLE = 2

Const.CIRCLE_BATTLE_TALENT_SCORE_UP_BATTLE = 1     --战斗积分增益
Const.CIRCLE_BATTLE_TALENT_SCORE_ADD_BATTLE = 2    --战斗积分增加

Const.CIRCLE_BATTLE_TALENT_EXPLORE_CRIT = 5        --探索天赋额外翻开一个格子
Const.CIRCLE_BATTLE_TALENT_EXPLORE_EXRTA_SCORE = 2 --探索到空白区域时，15%几率获得额外10兑奖币

Const.CIRCLE_POINT_STATUS =
{
    DIS = 1,
    NEXT = 2,
    GET = 3,
    GOT = 4,
}

Const.CIRCLE_ACTION_RECORD_TYPE =
{
    SEARCH = 3,
    SKILL = 4,
    BATTLE = 2,
}
Const.CIRCLE_ACHIEVE_TYPE =
{
    CIRCLE = 1,
    MEMBER = 2,
}

Const.CIRCLE_ACHIEVE_ACT_TYPE =
{
    COST_ACTION_POINT = 1,         --公会累积消耗行动点数量达到一定值
    PUSH_LAYER = 2,                --公会战推进层数达到一定值
    OPEN_GRID = 3,                 --公会累积翻开的格子数量达到一定值
    KILL_MONSTER = 4,              --公会累积击败的敌人数量达到一定值
    EXPLORE_PROFICIENCY_X_CNT = 5, --探索熟练度达到x的人数
    EXPLORE_PROFICIENCY_Y_CNT = 6, --探索熟练度达到y的人数
    EXPLORE_PROFICIENCY_Z_CNT = 7, --探索熟练度达到z的人数
    BATTLE_PROFICIENCY_X_CNT = 8,  --战斗熟练度达到x的人数
    BATTLE_PROFICIENCY_Y_CNT = 9,  --战斗熟练度达到y的人数
    BATTLE_PROFICIENCY_Z_CNT = 10, --战斗熟练度达到z的人数
}

Const.MEMBER_ACHIEVE_ACT_TYPE =
{
    COST_ACTION_POINT = 1,       --消耗行动点数量达到一定值
    GET_EXPLORE_PROFICIENCY = 2, --获得探索熟练度数量达到一定值
    GET_BATTLE_PROFICIENCY = 3,  --获得战斗熟练度数量达到一定值
    GET_ANY_PROFICIENCY = 4,     --获得战斗或者探索数量度数量达到一定值
}

Const.DEFAULT_TARGET_CIRCLE_ACHIEVE = Const.CIRCLE_ACHIEVE_ACT_TYPE.PUSH_LAYER

Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE =
{
    MEMBER_ACHIEVE = 1,
    OPEN_GRID = 2,
    BATTLE = 3,
    CIRCLE_ACHIEVE = 4,
    FIND_BOX = 5,
}
Const.CIRCLE_BATTLE_SCORE_LOG_CONTENT =
{
    [Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.MEMBER_ACHIEVE] = "达成成就",
    [Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.OPEN_GRID] = "翻开格子",
    [Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.BATTLE] = "进行战斗",
    [Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.FIND_BOX] = "发现宝箱",
}
Const.CIRCLE_EDIT_HEAD_STATUS_HEAD = 1
Const.CIRCLE_EDIT_HEAD_STATUS_HEADFRAME = 2
--为了拆出限时活动里button写死的公会战活动id，跟策划已确认
Const.CIRCLE_BATTLE_ACTIVITY_ID = 1304
------------------------------------------ ↑ 圈子系统 ↑ ------------------------------------------
------------------------------------------ ↓ 后宅 ↓ ------------------------------------------

Const.REARHOUSE_WALL_NUM = 2      --后宅墙面数量

Const.REARHOUSE_WALL_LOCK_NUM = 6 --后宅每面墙锁定区域数量

Const.REARHOUSE_LOAD_CONFIG = {
    LOADEND = { HERO = true, PART = false },
    DELAY = { HERO_HIGH = true }
}

Const.REARHOUSE_CREATE_MODE = {
    MINE = 1,    --查看自己
    VISIT = 2,   --查看他人
    PREVIEW = 3, --预览模式
}

Const.REARHOUSE_GRID_SIZE = 0.55             --后宅物件格子大小
Const.REARHOUSE_UP_OFFSET = 3                --后宅操作限制向上延展格子数
--后宅特权相关
Const.REARHOUSE_CLEAN_TIMES = 1              --每日扫灰次数
Const.REARHOUSE_CLEAN_AWARD = 2              --扫灰奖励
Const.REARHOUSE_DISPATCH_REFRESH_TIMES = 3   --每日免费刷新次数
Const.REARHOUSE_DISPATCH_CRI_AWARD = 5       --派遣暴击奖励随机id
Const.REARHOUSE_DISPATCH_NUM = 7             --每日派遣数量
Const.REARHOUSE_QUICK_DISPATCH = 8           --一键派遣

Const.REARHOUSE_TYPE_SHELF = 8               --架子
Const.REARHOUSE_TYPE_HERO = 5                --手办
Const.REARHOUSE_TYPE_PARTS = 7               --配件

Const.REARHOUSE_VISIT_REFRESH_INTERVAL = 300 --访问相关信息的刷新时间

Const.REARHOUSE_FAVOR_LIMIT = 20             --后宅每日限制点赞次数
------------------------------------------ ↑ 后宅 ↑ ------------------------------------------
------------------------------------------ ↓ 活动相关子类型 ↓ ------------------------------------------
Const.BOSS_TOWER_TYPE_SINGLE = 1
Const.BOSS_TOWER_TYPE_AOE = 2
Const.BOSS_TOWER_TYPE_ZOMBIE = 3
------------------------------------------ ↑ 活动相关子类型 ↑ ------------------------------------------

-------------------------------------------判断是否商务包------------------------------------------------
Const.IS_BUSINESS_PACkAGE = false --是否是商务包，用来实现控制隐藏主界面
-------------------------------------------判断是否商务包------------------------------------------------

------------------------------------------ ↓ 结算相关 ↓ ------------------------------------------
Const.BOSS_AWARD_TYPE_NORMAL = 1 --挑战boss正常的结算奖励
Const.BOSS_AWARD_TYPE_PASSED = 2 --挑战boss通关的结算奖励
------------------------------------------ ↑ 结算相关 ↑ ------------------------------------------

------------------------------------------ ↓ 通用的一些宏定义 ↓ ------------------------------------------
Const.COMMON_STATE_NML = 1      -- 除此之外的其他
Const.COMMON_STATE_PASSED = 2   -- 已通过但是还未完成(比如星级没达到要求  一般不会出现)
Const.COMMON_STATE_COMPLETE = 3 -- 已完成
Const.COMMON_STATE_NEXT = 4     -- 下一个节点
Const.COMMON_STATE_LOCK = 5     -- 在被锁

-- Touch类型
Const.TOUCH_SIMPLETAP = 1
Const.TOUCH_DOWN = 2
Const.TOUCH_PINCHIN = 3
Const.TOUCH_PINCHOUT = 4
Const.TOUCH_SWIPE = 5
Const.TOUCH_UP = 6
Const.TOUCH_LONGTAP = 7
Const.TOUCH_DRAGSTART = 8

------------------------------------------ ↑ 通用的一些宏定义 ↑ ------------------------------------------

------------------------------------------ ↓ 三队竞技场 ↓ ------------------------------------------
Const.SENIORPVP_RANK_COUNT = 50 --三队竞技场排行人数
------------------------------------------ ↑ 三队竞技场 ↑ ------------------------------------------


------------------------------------------ ↓ 跨服竞技场 ↓ ------------------------------------------
Const.OPACTPVP_GET_REPORT_CD            = 300 --跨服竞技场拉取cd
Const.OPACTPVP_NEAR_PULL_NUM            = 10 --跨服竞技场排位相近信息每次拉取
------------------------------------------ ↑ 跨服竞技场 ↑ ------------------------------------------

------------------------------------------ ↓ 特殊失败新手的头像框提示 ↓ ------------------------------------------



------------------------------------------ ↑ 特殊失败新手的头像框提示 ↑ ------------------------------------------

------------------------------------------ ↓ 战斗录像类型 ↓ ------------------------------------------
Const.BATTLE_REPLAY_PASS                = 1 -- 主线推图
Const.BATTLE_REPLAY_ONCE_TOWER          = 2 -- 雨夜噩梦
Const.BATTLE_REPLAY_EQUIP_TOWER         = 3 -- 装备塔
Const.BATTLE_REPLAY_BOSS_TOWER          = 4 -- 终焉之战
Const.BATTLE_REPLAY_SEASON_TOWER        = 5 -- 赛季爬塔
Const.BATTLE_REPLAY_BOSS_EXPAND         = 6 -- 终焉扩展
------------------------------------------ ↑ 战斗录像类型 ↑ ------------------------------------------

------------------------------------------ ↓ 悬赏任务 ↓ ------------------------------------------
Const.RENT_TASK_TYPE                    = {
    ["Normal"]    = 1,   -- 低级
    ["Advanced"]  = 2,   -- 高级
    ["Rare"]      = 3,   -- 稀有
    ["ExtraRare"] = 4,   -- 稀有-回流
}

Const.RENT_GROUPTASK_STATUS             = {
    ["Complete"] = 1, --完成
    ["Thanked"] = 2, --已感谢
    ["OverDue"] = 10, --已过期，客户端状态
}

Const.RENT_TASK_STATUS                  = {
    ["New"]        = 1,  --一场未打
    ["FinishHalf"] = 2,  --完成了自己那场
    ["Complete"]   = 3,  -- 两场完成
}

-- 主动借别人的队伍，有此状态
Const.RENT_BORROW_STATUS                = {
    ["Wait"]           = 1,   --等待
    ["Success"]        = 2,   --成功
    ["Fail"]           = 3,   --失败
    ["RenterCancel"]   = 4,   --撤回
    ["OwnerCancel"]    = 5,   --撤回
    ["RentFull"]       = -6,  -- 申请数量已满
    ["AcceptFull"]     = -5,  -- 同意数量已满
    ["NotInMatchList"] = -4,  -- 不在匹配列表中
    ["ApplyFull"]      = -3,  -- 对方申请列表满
    ["InUse"]          = -2,  -- 队伍已经借出
}

-- 队伍被别人借，有此状态
Const.RENT_APPLY_STATUS                 = {
    ["Applying"]     = 1, -- 申请中
    ["Accept"]       = 2, -- 接受
    ["Refuse"]       = 3, -- 拒绝
    ["RenterCancel"] = 4, -- 租借者撤回
    ["Complete"]     = 5, -- 完成
    ["OwnerCancel"]  = 6, -- 被租者撤回
    ["OverDue"]      = 10, -- 客户端状态：请求过期
    ["OtherRented"]  = 11, -- 客户端状态：被别人借走
}

Const.RENT_NOTICE_TYPE                  = {
    ["ReqMsg"] = 1,
    ["RespMsg"] = 2,
    ["Letter"] = 3,
    ["CircleInvite"] = 4,
}

Const.RENT_LETTER_MAX_LENGTH            = 256 -- 感谢信最大长度

------------------------------------------ ↑ 悬赏任务 ↑ ------------------------------------------
--字节消费提示用
Const.CONSUME_DIAMOND_SHOP_ITEM         = "buy_shop_item"      --在商店购买道具
Const.CONSUME_DIAMOND_REFRESH_SHOP      = "refresh_shop_item"  --刷新商店商品
Const.CONSUME_DIAMOND_BUY_FISHBONE      = "buy_fish"           --追加小鱼骨
Const.CONSUME_DIAMOND_REFRESH_PHOTOTASK = "refresh_photo_task" --更新拍摄任务
Const.CONSUME_DIAMOND_UPGRADE_BAG       = "upgrade_bag"        --扩张格子（手办、装备、徽章）
Const.CONSUME_DIAMOND_CHANGE_NAME       = "change_name"        --変更玩家昵称
Const.CONSUME_DIAMOND_RESET_LEVEL       = "reset_level"        --重置手办的等级
Const.CONSUME_DIAMOND_RESET_STEP        = "reset_step"         --重制手札开放
Const.CONSUME_DIAMOND_RESET_ALL         = "reset_all"          --重制手札开放


------------------------ ↓ 练度 ↓ --------------------------------

Const.IS_SHOW_OTHER_TEAM_PROFICIENT = true

Const.OTHER_TEAM_INDEX = 7 --设置一个假的代表其他团队
------------------------ ↑ 练度 ↑ --------------------------------

------------------------ ↓ 盛旺 声音 ↓ --------------------------------
Const.M_LoadingID = 1001
Const.M_MainID = 1002
Const.M_DragID = 1003
Const.M_Battle_1_ID = 1004
Const.M_Battle_2_ID = 1005
Const.M_Battle_End_ID = 1006
Const.M_Hero_ID = 1007

------------------------ ↑ 声音 ↑ --------------------------------


--UIHeroAlbum

------------------------ ↓ 分包下载 ↓ --------------------------------
Const.SUBPACKAGE_TYPE_DANCE = 0
Const.SUBPACKAGE_TYPE_PLOTVIDIO = 1
------------------------ ↑ 分包下载 ↑ --------------------------------
if not NO_CSHARP and RegionUtils and RegionUtils.isCN() then
    Const.IS_NEW_BOSSTOWER_SHOW = true
else
    Const.IS_NEW_BOSSTOWER_SHOW = false
end

if not NO_CSHARP and RegionUtils and (RegionUtils.isJP() or RegionUtils.isKR()) then
    Const.HIDE_CIRCLE_INVITE = true
else
    Const.HIDE_CIRCLE_INVITE = false
end

if not NO_CSHARP and RegionUtils then
    if RegionUtils.isJP() then
        Const.SHOP_DISCOUNT_MODE = 1 -- 商城商品打折信息显示模式为 60%而不是打折这种
    elseif RegionUtils.isKR() then
        Const.SHOP_DISCOUNT_MODE = 1
    end
end
--------------------------------OC---------------------------------------
---聊天
---聊天频道
Const.WORLD = 0                   --世界
Const.GUILD = 1                   --公会
Const.SERVER = 2                  --系统
Const.PRIVATE = 3                 --私聊
Const.OC_CHAT_TIME_INTERVAL = 180 --聊天显示时间间隔(秒)180秒
--私聊对象
Const.PRIVATEROLEROLE = "PRIVATEROLEROLE"
--私聊对象的消息
Const.PRIVATEROLEMESS = "PRIVATEROLEMESS"
--篝火场景本地储存的Key
Const.BonfireSceneKey = "BonfireSceneKey"
-----------------------------------------------------------------------------

---------------------------ResClientVersionFlag---------------------------------------

Const.PET_SECOND_SECTION_OPEN = true
Const.PET_RUNE_OPEN = true


Const.PET_RUNE_TYPE_NORMAL = 1
Const.PET_RUNE_TYPE_EXCLUSIVE = 2


return Const
