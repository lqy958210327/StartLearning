local SDKConst = {}
local AttName = {}
local LanguageAtt = {}
local PayType = {}
local RoleInfoType = {}
local EventType = {}
local LoginState = {}
local ResponseCode = {}
local PharosConst = {}

local Tip = {}
local ChannelID = {}

SDKConst.LoginState = LoginState
SDKConst.AttName = AttName
SDKConst.LanguageAtt = LanguageAtt
SDKConst.PayType = PayType
SDKConst.RoleInfoType = RoleInfoType
SDKConst.EventType = EventType
SDKConst.ResponseCode = ResponseCode
SDKConst.Tip = Tip
SDKConst.ChannelID = ChannelID
SDKConst.PharosConst = PharosConst

-- ChannelID.PLAYWITH = "playwith"
-- ChannelID.PLAYWITHMC = "playwithmc"
ChannelID.FLOW = "flow"
ChannelID.XIAOMI = "xiaomi"
ChannelID.PLAT = "plat"
-- ChannelID.VN = "vn"
ChannelID.MULTI = "multi"
ChannelID.BYTED = "byted"
ChannelID.KOMOE = "komoe"
ChannelID.BILIKOREA = "kr"

ChannelID.SUB_QQGAME = "wanfutengxun"
ChannelID.SUB_DALAN = "dalan"

--gzw add demo tag
ChannelID.DEMO = "demo"

ChannelID.DOWNLOAD_URL_CONFIG = {
    ['bilibili'] = 'https://pkg.biligame.com/games/gnsbt_1.2.1_20210415_120632_ca71d.apk',
    ['oppo'] = 'https://storedl.nearme.com.cn/apk/202104/14/bb69e976070e1742761219f4f528408c.apk',
    ['vivo'] = 'http://appstore.vivo.com.cn/appinfo/downloadApkFile?id=2944950',
    ['uc'] = 'http://downali.game.uc.cn/wm/2/2/uc_v1.2.1_2021-04-12_release_encrypted_38935522_150746aa056b.apk',
    ['ssjj'] = 'http://sj.img4399.com/game_list/258/com.gnsbt.Shgame.m4399/game.v8034308.apk',
    ['haoyoukuaibao'] = 'https://d.3839app.net/video/hykb/HYKB15550420210223pc.apk',
    ['yyb'] = 'https://imtt.dd.qq.com/16891/apk/F931CFDB469B1F62D5D45B82C49EEAC3.apk?fsname=com.tencent.tmgp.gnsbt_1121.apk',
    ['moniqi'] = 'https://mumu-apk.fp.ps.netease.com/file/60793366143cfa1a21b60b71sZFyLTgk03.apk',
    ['nubia'] = 'https://c1-appstore.nubia.com/Developer/app/2021/04/14/135411/7a36a2f2069a4e178b4bca1fb751af8e.apk',
    ['huawei'] = 'https://appgallery.huawei.com/#/app/C101994793?sharePrepath=gs&locale=zh_CN&source=appshare&subsource=C101994793&shareTo=weixin&shareFrom=gamebox',
    ['meizu'] = 'http://app.flyme.cn/games/public/detail?package_name=com.gnsbt.Shgame.mz',
    ['xiaomi'] = 'https://game.xiaomi.com/game/62294868',
    ['taptap'] = 'https://www.taptap.com/app/187667',
    ['xy'] = 'https://www.shouyou.xy.com/cps/show/hxLNY5',
    ['gionee'] = 'http://game.gionee.com/Front/Core/detail/?from=gn&id=18799&keyword=%E9%AB%98%E8%83%BD%E6%89%8B%E5%8A%9E%E5%9B%A2&cku=3019146606_null&action=visit&object=gamedetail18799_gn&intersrc=isearch_gn_gid18799',
}

LoginState.UNLOGIN = 0
LoginState.IN_PROCESS = 1
LoginState.LOGIN = 2

AttName.USE_BUGLY = "use_bugly"                                         --是否使用Bugly
AttName.BUGLY_KEY = "bugly_key"                                         --是否使用Bugly
AttName.USE_GCLOUDVOICE = "use_gcloudvoice"                             -- 是否使用腾讯语音
AttName.GCLOUDVOICE_KEY = "gcloudvoice_key"                             -- gcloudvoice的key

AttName.GAME = "game"                                                   -- 游戏代号
AttName.PATCH_VERSION = "patch_version"                                 -- patch版本
AttName.ENGINE_VERSION = "engine_version"                               -- c#引擎代码版本
AttName.FLOW_UUID = "flow_uuid"

AttName.APP_NAME = "app_name"                                           --应用安装后显示的名称
AttName.APP_KEY = "app_key"                                             --应用的app key
AttName.APP_ID = "app_id"                                               --应用的 app id
AttName.REDIRECT_URI = "redirect_uri"                                   --陌陌的 redirect uri
AttName.SECRET_KEY = "secret_key"                                       --应用的 secret key
AttName.CHANNEL_ID = "channel_id"                                       --应用的 渠道id
AttName.SUB_CHANNEL_ID = "sub_channel_id"

AttName.PAY_KEYSTORE = "pay_keystore"                                   --支付用的 keystore密码
AttName.PAY_PASSWORD = "pay_password"                                   --支付用的 密钥
AttName.CP_ID = "cp_id"                                                 --应用开发者自己的id
AttName.SDK_CP_ID = "sdk_cp_id"                                         --渠道分配给cp的id
AttName.SDK_NAME = "sdk_name"                                           --应用所接渠道的sdk标识
AttName.PLATFORM = "platform"                                           --应用的平台（ANDROID/IOS）
AttName.VERSION = "version"                                             --应用的版本号
AttName.BUNDLE_INDENTIFLER = "bundle_indentifler"                       --应用的包名
AttName.BUNDLE_NAME = "bundle_name"                                     --ios中的应用（bundle name）
AttName.PRODUCT_PACKAGE_NAME = "product_package_name"                   --安卓中应用的包名
AttName.PRODUCE_KEY = "product_key"                                     --应用的product key
AttName.PRODUCT_ID = "product_id"                                       --应用的 product id
AttName.BUNDLE_DISPLAY_NAME = "bundle_display_name"                     --iso中应用的 bundle display name
AttName.PAY_CALL_BACK_URL = "pay_call_back_url"                         --支付回调的url地址
AttName.PAY_BASE_RATE = "pay_base_rate"                                 --支付兑换的比例
AttName.PAY_BASE_VALUE = "pay_base_value"                               --支付兑换的默认价格（分）
AttName.EXTRA = "extra"                                                 --通用的额外数据

AttName.IS_LANDSPACE_GAME = "is_landspace_game"                         --是否是横屏游戏（1/0）
AttName.IS_SUPPORT_ROATED = "is_support_roated"                         --是否支持旋转（1/0）
AttName.IS_SHOW_LOG = "is_show_log"                                     --是否输出debug信息（1/0）
AttName.IS_LONG_COMET = "is_long_comet"                                 --应用是否和渠道为长链接
AttName.IS_OPEN_RECHARGE = "is_open_recharge"                           --应用是否开放内部支付
AttName.IS_LOGOUT_AUTO_LOGIN = "is_logout_auto_login"                   --应用是否登出后自动显示登录界面
AttName.IS_DEBUG_MODEL = "is_debug_model"                               --应用是否处于debug模式下（1/0）
AttName.CLOSE_RECHARGE_MSG = "close_recharge_msg"                       --当支付未开启时显示的提示信息

AttName.USER_NAME = "user_name"                                         --用户名
AttName.USER_PASS_WORD = "user_pass_word"                               --用户密码
AttName.USER_TOKEN = "user_token"                                       --用户验证用token
AttName.USER_SESSION_ID = "user_session_id"                             --用户验证用sessionID
AttName.USER_ID = "user_id"                                             --用户id
AttName.USER_INFO = "user_info"                                             --用户info
AttName.OPEN_ID = "open_id"                                             -- 公共平台的id
AttName.SDK_OPEN_ID = "sdk_open_id"                                     -- SDK的OpenId(字节)
AttName.OPEN_TOKEN = "open_token"                                       -- 公共平台的token
AttName.USER_HEAD_ID = "user_head_id"                                   --用户头像id
AttName.USER_HEAD_URL = "user_head_url"                                 --用户头像url
AttName.AGE_ENUM = "age_enum"                                           -- 用户年龄
AttName.TIME_STAMP = "time_stamp"                                       -- 时间戳
AttName.LOGIN_ERROR_CODE = "login_error_code"                           -- 登录错误码
AttName.IS_GUEST = "is_guest"                                           --是否是游客账号
AttName.IS_BIND = "is_bind"                                           --是否是绑定的
AttName.SUCCESSION_ID = "succession_id"
AttName.SUCCESSION_CODE = "succession_code"
AttName.TENCENT_OPEN_ID = "tencent_open_id"                             --QQ的open_id
AttName.TENCENT_OPEN_KEY = "tencent_open_key"                           --QQ的open_key
AttName.TENCENT_PF = "tencent_pf"                                       --QQ的pf

AttName.ROLE_ID = "role_id"                                             --角色id
AttName.ROLE_NAME = "role_name"                                         --角色名字
AttName.ROLE_LEVEL = "role_level"                                       --角色等级
AttName.ROLE_GENDER = "role_gender"                                     -- 角色性别
AttName.ROLE_CREATE_TIME = "role_create_time"                           --角色创建时间，服务器时间（单位/秒）例：
AttName.ROLE_LEVELUP_TIME = "role_levelup_time"                         --角色升级时间
AttName.ZONE_ID = "zone_id"                                             --所在大区id
AttName.ZONE_NAME = "zone_name"                                         --所在大区名称
AttName.SERVER_ID = "server_id"                                         --所在服务器id
AttName.SERVER_NAME = "server_name"                                     --所在服务器名字

AttName.PROFESSION_ID = "profession_id"                                 --职业ID
AttName.PROFESSION_NAME = "profession_name"                             --职业名称
AttName.BALANCE_ID = "balance_id"                                       --角色余额类型ID
AttName.BALANCE_NAME = "balance_name"                                   --角色余额类型名称

AttName.ROLE_TYPE = "role_type"                                         -- 角色统计信息类型即调用时机
AttName.SAVED_BALANCE = "saved_balance"                                 -- 当前角色余额（RMB购买的游戏币），默认为0
AttName.VIP_LEVEL = "vip_level"                                         -- VIP等级，没有传0
AttName.PARTY_ID = "party_id"                                           -- 工会ID
AttName.PARTY_NAME = "party_name"                                       -- 工会名称
AttName.PARTY_ROLE_ID = "party_role_id"                                 -- 工会ID
AttName.PARTY_ROLE_NAME = "party_role_name"                             -- 工会名称
AttName.FRIEND_LIST = "friend_list"                                     -- 好友列表
AttName.POWER = "power"                                                 -- 战力值
AttName.RANKING = "ranking"                                             -- 排行榜数据
AttName.STAGE_PROGRESS = "stage_progress"                               -- 关卡进度

AttName.REAL_PRICE = "real_price"                                       --实际支付价格
AttName.ORIGIN_PRICE = "origin_price"                                   --原始价格
AttName.DISCOUNT = "discount"                                           --折扣比例（n%）
AttName.ITEM_COUNT = "item_count"                                       --商品数量
AttName.ITEM_LOCAL_ID = "item_local_id"                                 --商品在应用本地的id
AttName.ITEM_SERVER_ID = "item_server_id"                               --商品在渠道的id
AttName.ITEM_NAME = "item_name"                                         --商品名字
AttName.ITEM_DESC = "item_desc"                                         --商品描述
AttName.BILL_NUMBER = "bill_number"                                     --订单号
AttName.PAY_CALLBACK_INFO = "pay_callback_info"                         -- 支付回传信息
AttName.PAY_SIGN_TYPE = "pay_sign_type"                                 -- 支付信息的签名类型
AttName.PAY_SIGN = "pay_sign"                                           -- 支付信息的签名
AttName.PAY_TYPE = "pay_type"                                           -- 支付类型

AttName.OPEN_ORDER_ID = "open_order_id"                                 -- OpenServer上的唯一订单号
AttName.ITEM_INFO = "item_info"                                         -- 商品信息
AttName.ITEM_PLATFORM = "item_platform"                                 -- 商品平台 0：Android游戏，1：IOS游戏，2：Android和IOS游戏
AttName.CURRENCY_CODE = "currency_code"                                 -- 货币种类
AttName.SDK_ORDER_ID = "sdk_order_id"                                   -- SDK 的订单号
AttName.RANDOM_STR = "random_str"                                       -- 随机字符串

AttName.RESULT = "common_result"                                        -- 结果（1/0）成功／失败
AttName.REASON = "common_reason"                                        -- 失败原因

AttName.PAY_RESULT = "pay_result"                                       --支付结果（1/0）成功／失败
AttName.PAY_RESULT_REASON = "pay_result_reason"                         --支付结果的原因（失败原因）
AttName.PAY_RESULT_DATA = "pay_result_data"                             --支付结果的返回数据
AttName.PAY_RESULT_SIGNATURE = "pay_result_signature"                   --本次支付的签名
AttName.PAY_RESULT_CODE = "pay_result_code"                             --本次支付结果

AttName.SHARE_ID = "share_id"                                           --分享id，分享消息的唯一标识，每次分享时id不能相同
AttName.SHARE_TARGET_URL = "share_target_url"                           --点击跳转的地址
AttName.SHARE_IMG_LOCAL_URL = "share_img_local_url"                     --分享图片的本地url
AttName.SHARE_VIDEO_LOCAL_URL = "share_video_local_url"                 --分享本地的视频
AttName.SHARE_VIDEO_URL = "share_video_url"                             --分享视频的url
AttName.SHARE_SENDER_ID = "share_sender_id"                             --分享的发起人id
AttName.SHARE_SENDER_NAME = "share_sender_name"                         --分享的发起人名字
AttName.SHARE_RECEIVER_ID = "share_receiver_id"                         --分享的接受人id
AttName.SHARE_RECEIVER_NAME = "share_receiver_name"                     --分享的接受人名字
AttName.SHARE_INFO_TITLE = "share_info_title"                           --分享的标题
AttName.SHARE_INFO_CONTENT = "share_info_content"                       --分享的文字内容
AttName.SHARE_IMG_URL = "share_img_url"                                 --分享的图片url
AttName.SHARE_TYPE = "share_type"                                       --分享的类型
AttName.SHARE_PLATFORM = "share_platform"                               --分享的平台

AttName.REQUEST_INIT_WITH_SEVER = "request_init_with_sever"             --init的时候 需要传入服务器id
AttName.SUPPORT_SHARE = "support_share"                                 --支持分享接口
AttName.NOT_ALLOW_PUSH_NOTIFY = "not_allow_push_notify"                 --不允许使用任何推送
AttName.SUPPORT_PERSON_CENTER = "support_person_center"                 --支持显示个人中心接口

AttName.DEVICE_ID = "device_id"                                         --设备号
AttName.NATIVE_DEVICE_ID = "native_device_id"                           --原生设备号
AttName.UNITY_DEVICE_ID = "unity_device_id"                             --Unity设备号
AttName.SDK_DEVICE_ID = "sdk_device_id"									--sdk接口返回的deviceID

--推送相关

AttName.PUSH_TYPE = "push_type"                                         --推送的类型 int 0,1,2…
AttName.PUSH_TYPE_DATA = "push_type_data"                               --推送类型的可自定义内容 string
AttName.PUSH_TYPE_APNS = "push_type_apns"                               --推送渠道APNS
AttName.PUSH_TYPE_GGP = "push_type_ggp"                                 --推送渠道GOOGLE
AttName.PUSH_ID = "push_id"                                             --推送的token
AttName.PUSH_TITLE = "push_tile"                                        --推送的标题 string xxxx
AttName.PUSH_INFO = "push_info"                                         --推送的内容 string xxxx
AttName.PUSH_REPEAT_INTERVAL = "push_repeat_interval"                   --重复的时间间隔
AttName.PUSH_ALERT_DATE = "push_alert_date"                             --推送的出现时间
AttName.PUSH_NEED_NOTIFY = "push_need_notify"                           --推送是否需要将收到的信息发送给客户端
AttName.PUSH_RECEIVE_TYPE = "push_receive_type"                         --推送反馈客户端的信息类型
AttName.PUSH_RECEIVE_INFO = "push_receive_info"                         --推送反馈客户端的信息附带数据

--手机信息相关
AttName.APP_VERSION_NAME = "app_version_name"                           --当前应用的版本号
AttName.CURRENT_TIMEZONE ="current_timezone"                            --设备的当前时区
AttName.CURRENT_TIME = "current_time"                                   --设备的当前时间
AttName.CURRENT_LANGUAGE = "current_language"                           --设备当前语言环境
AttName.SIM_OPERATOR_NAME = "sim_operator_name"                         --运营商
AttName.SIM_OPERATOR_ID = "sim_operator_id"                             --运营商id
AttName.NETWORK_TYPE = "network_type"                                   --网络类型
AttName.PHONE_IP= "phone_ip"                                            --设备当前的Ip地址
AttName.PHONE_MODEL = "phone_model"                                     --设备型号
AttName.PHONE_PRODUCTOR = "phone_productor"                             --设备生产商
AttName.CPU_TYPE = "cpu_type"                                           --cpu型号
AttName.SYSTEM_VERSION = "system_version"                               --系统版本
AttName.SCREEN_HEIGHT = "screen_height"                                 --屏高
AttName.SCREEN_WIDTH = "screen_width"                                   --屏宽
AttName.ROOT_AHTH = "root_ahth"                                         --是否获得Root权限
AttName.MEMORY_TOTAL_MB = "memory_total_mb"                             --设备运行内存
AttName.MAC_ADDRESS = "mac_address"                                     --设备Mac地址
AttName.IMEI = "imei"                                                   --移动设备国际身份码
AttName.SIM_SERIAL_NUMBER = "sim_serial_number"                         --SIM卡序列号
AttName.ANDROID_ID = "android_id"                                       --安卓设备唯一编号


AttName.KEY = "key"                                                     --哈希表的key
AttName.DATA = "data"                                                   --哈希表的 data

--应用宝专用字段
AttName.SDK_NAME_QQ = "sdk_name_qq"                                     -- QQ标识
AttName.SDK_NAME_WX = "sdk_name_wx"                                     -- 微信标识
AttName.TECENT_TYPE = "tencent_type"                                    -- 用来标记登录时的channel_id
AttName.OPENID = "openid"                                               -- 从手Q登录态或微信登录态中获取的openid的值
AttName.OPENKEY = "openkey"                                             -- 从手Q登录态中获取的pay_token的值或微信登录态中获取的access_token
AttName.PF = "pf"                                                       -- 平台来源，平台-注册渠道-系统运行平台-安装渠道-业务自定义
AttName.PFKEY = "pfkey"                                                 -- pf校验Key
AttName.PAY_TOKEN = "pay_token"                                         -- 手Q登录时从手Q登录态中获取的pay_token的值,使用YSDK登录后获取到的eToken_QQ_Pay返回内容就是pay_token；
-- 微信登录时特别注意该参数传空。
AttName.EXTRA_FUNCTION_KEY     = "extra_function_key"
AttName.EXTRA_FUNCTION_VALUE   = "extra_function_value"
AttName.EXTRA_FUNCTION_VALUE_2 = "extra_function_value_2"

-- OpenServer添加字段
AttName.OPENSERVER_RESPONSE_OPENID_JSON  = "openserver_response_openid_json"

-- 选择图片相关字段
AttName.IMAGE_PICK_SOURCE = "image_pick_source"                         -- 0:PhotoLibary 1:Camera
AttName.IMAGE_RES_WIDTH = "image_res_width"                             -- 输出分辨率宽度
AttName.IMAGE_RES_HEIGHT = "image_res_height"                           -- 输出分辨率高度
AttName.IMAGE_ASPECT_RATIO_X = "image_aspect_ratio_x"                   -- 选择高宽比X
AttName.IMAGE_ASPECT_RATIO_Y = "image_aspect_ratio_y"                   -- 选择高宽比Y
AttName.IMAGE_FILE_FORMAT = "image_file_format"                         -- 图片格式 jpg/png
AttName.IMAGE_FILE_NAME = "image_file_name"                             -- 文件名
AttName.IMAGE_FILE_PATH = "image_file_path"                             -- 返回结果路径

-- 位置相关字段
AttName.CITY_NAME = "city_name"
AttName.LATITUDE = "latitude"
AttName.LONGITUDE = "longitude"


-- 通用事件附带参数
AttName.EVENT_ARG_ONE = "event_arg_1"
AttName.EVENT_ARG_TWO = "event_arg_2"
AttName.EVENT_ARG_THREE = "event_arg_3"

AttName.OTHER_MSG_TYPE = "other_msg_type"								--通用notify传的类型
AttName.LOGIN_AUTH = "login_auth"                                       -- 三方登陆
AttName.WEB_TITLE = "web_title"
AttName.WEB_URL = "web_url"
AttName.WEB_CALLBACK = "web_callback"                                   -- 打开网页是否需要关闭网页回调
AttName.WEB_ORIENTATION = "web_orientation"
AttName.CNN_SCENE = "cnn_scene"                                         -- 公告场景，必传 (游戏公告部分）

-- 语言相关
LanguageAtt.CHS = "chs"
LanguageAtt.EN = "en"


-- 支付类型
PayType.ABPAY = "abpay"
PayType.WNPAY = "wnpay"

-- 上传角色信息时机
RoleInfoType.ENTER_GAME = "enterGame"        --进入游戏，此时应能获取到角色所有相关信息
RoleInfoType.CREATE_ROLE = "createRole"      --角色创建完成后
RoleInfoType.CREATE_NAME = "createName"      --角色创建名字后
RoleInfoType.LEVEL_UP = "levelUp"            --角色升级时
RoleInfoType.EXIT_GAME = "exitGame"          --角色退出游戏
RoleInfoType.PAY = "pay"                     --支付完成
RoleInfoType.FIRST_PAY = "first_pay"         --首充
RoleInfoType.SDK_FIRST_LOGIN = "sdk_first_login"
RoleInfoType.SDK_LOGIN_FAIL = "sdk_login_fail"

RoleInfoType.GUIDE_1_1 = "guide1_1"
RoleInfoType.GUIDE_1_12 = "guide1_12"
RoleInfoType.STAGE_1_4 = "endguide"         -- 通关1-4
RoleInfoType.STAGE_1_12 = "stage1_12"
RoleInfoType.STAGE_3_24 = "stage3_24"
RoleInfoType.STAGE_4_1 = "stage4_1"
RoleInfoType.STAGE_4_15 = "stage4_15"
RoleInfoType.STAGE_11_1 = "stage11_1"

RoleInfoType.MONTH_CARD_6 = "monthcard_6"       -- 月卡6块
RoleInfoType.MONTH_CARD_98 = "monthcard_98"     -- 月卡98
RoleInfoType.PAY_6 = "pay_6"                    -- 物品花钱6
RoleInfoType.PAY_12 = "pay_12"                  -- 物品花钱12
RoleInfoType.PAY_30 = "pay_30"                  -- 物品花钱30
RoleInfoType.PAY_98 = "pay_98"                  -- 物品花钱98

-- TypeSDK的事件类型,和C#层保持一致
-- TypeSDK的事件类型,和C#和java层保持一致
EventType.EVENT_ERROR = 0
EventType.EVENT_INIT_FINISH = 1
EventType.EVENT_LOGIN_SUCCESS = 2
EventType.EVENT_LOGIN_CANCEL = 3
EventType.EVENT_LOGIN_FAIL = 4
EventType.EVENT_RELOGIN = 5
EventType.EVENT_LOGIN_GET_TOKEN = 6
EventType.EVENT_LOGOUT = 7
EventType.EVENT_EXIT_GAME = 8
EventType.EVENT_CANCEL_EXIT_GAME = 9
EventType.EVENT_PAY_RESULT = 10
EventType.EVENT_PAY_CANCEL = 11
EventType.EVENT_SWITCHACCOUNT = 12
EventType.EVENT_REQTOKEN_CUSTOMERSERVICE = 13
EventType.EVENT_WEBVIEW_NATIVECALL = 14
EventType.EVENT_CHECK_ORDER_RESULT = 15
EventType.EVENT_PROTOCOL_FINISH = 16
EventType.EVENT_PRODUCT_LIST = 17
EventType.EVENT_CLOSE_WEBVIEW = 18
EventType.EVENT_TO_APP = 19
EventType.EVENT_PHAROS = 20--灯塔相关

EventType.EVENT_UPDATE_FINISH = 20
EventType.EVENT_RECEIVE_PUSH = 21
EventType.EVENT_SHARE_RESULT = 22
EventType.EVENT_GET_FRIEND_RESULT = 23
EventType.EVENT_EXTRA_FUNCTION = 24
EventType.EVENT_BIND_PHONE_NUMBER = 25
EventType.EVENT_EXIT_ATTEMPT = 26
EventType.EVENT_UPGRADE_GUEST = 27
EventType.EVENT_PRODUCTS_INFO = 28
EventType.EVENT_PUSH_TOKEN = 29

EventType.GAME_EVENT_SEND_ROLE_INFO = 101

EventType.EVENT_PICK_IMAGE = 201
EventType.EVENT_GET_LOCATION = 202

EventType.EVENT_GET_OTHER_MSG = 301

ResponseCode.SUCC = 0
ResponseCode.FAIL = 1
ResponseCode.TIME_OUT = 2
ResponseCode.ABORT = 3
ResponseCode.UNKNOWN= 4

Tip.BIND_ACCOUNT = "当您完成绑定后，此帐号再也无法绑定其他服务器的角色.确定进行绑定吗？"
Tip.GUEST_FORBID_RECHARGE = "游客账号无法进行充值，是否现在绑定账号？"

PharosConst.Project = "ma155naxx2gb"                              --项目代号，需与SRE确认，注意与 JF_GAMEID 区分
PharosConst.GameId = "ma155na"                                    --QOS项目代码，需要跟服务端申请 （必填）

PharosConst.Method_PharosHarhor = "pharosharbor"
PharosConst.Method_OnPharosServer = "pharosOnPharosServer"        --获取加速IP列表成功
PharosConst.Method_PharosNetLags = "pharosnetlags"                --触发网络延迟探测
PharosConst.Method_PharosNetLagsCancel = "pharosnetlagscancel"    --取消网络延迟探测
PharosConst.Method_PharosStartQOS = "pharosstartqos"              --开启QOS服务
PharosConst.Method_PharosStopQOS = "pharosstopqos"                --停止QOS服务

return SDKConst