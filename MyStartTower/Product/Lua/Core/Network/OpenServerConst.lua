--用于和OpenServer通信时所用的字段。
local OpenServerConst = {}
local ErrorCode = {}
local ErrorText = {}
local AccountType = {}
local AccountTypeId = {}

OpenServerConst.ErrorCode = ErrorCode
OpenServerConst.ErrorText = ErrorText
OpenServerConst.AccountType = AccountType
OpenServerConst.AccountTypeId = AccountTypeId

OpenServerConst.ACCOUNT_TYPE = "acctype"
OpenServerConst.ACCOUNT_SESSION = "session"
OpenServerConst.SUBTYPE = "subtype"
OpenServerConst.SPMARK = "spmark"
OpenServerConst.OPEN_ID = "openid"                      --  登录时的OpenID
OpenServerConst.OPEN_TOKEN = "token"                    --  登录时对应openID的token
OpenServerConst.ACCOUNT_ID = "accid"                    --  登录时的渠道账号
OpenServerConst.SERVER_ID = "server_id"                 --  登录时
OpenServerConst.MOBILE = "mobile"                       --  手机号
OpenServerConst.SMS_CODE = "smscode"                    --  短信验证码
OpenServerConst.SMS_CODE_PURPOSE = "purpose"            --  短信验证码作用
OpenServerConst.SMS_CODE_PURPOSE_BIND_I = "bindi"       --  绑定用的短信验证码
OpenServerConst.SMS_CODE_PURPOSE_BIND_A = "binda"       --  绑定用的短信验证码
OpenServerConst.SMS_CODE_PURPOSE_VERIFY = "verify"      --  登录用的验证码作用
OpenServerConst.OS_TYPE = "os"                          --  请求openID时候附带的系统类型, android:0,ios:1
OpenServerConst.CHANNEL_ID = "channel_id"               --  登录时模拟token里解出来的channelID，用于在debug模式下模拟登录渠道
OpenServerConst.IS_FIRST = "is_first"                   --  登录时返回是否是新创建的账号


OpenServerConst.CHANNEL_ACCOUNT_ID = "channel_account"  -- 订单在OpenServer端的渠道号
OpenServerConst.SERVER_NODE = "svr_nodeid"              -- 服务器编号
OpenServerConst.ROLE_UID = "role_uid"                   -- 角色UID
OpenServerConst.ROLE_LEVEL = "level"                    -- 角色等级

OpenServerConst.OPEN_ORDER_ID = "orderid"               -- 支付的透传数据
OpenServerConst.PRODUCT_ID = "product_id"               -- 订单在OpenServer端的商品号
OpenServerConst.RECHARGE_ID = "recharge_id"             -- 商品的RechargeID
OpenServerConst.PAY_EXTEND_INFO = "extend"              -- 支付的透传数据
OpenServerConst.PAY_ATTACH = "attach"                   -- 支付的透传数据
OpenServerConst.RECEIPT = "receipt"                     -- 支付完成后的回执
OpenServerConst.RECEIPT_FORCE_APPLY = "force"           -- 强制把回执应用于当前账号
OpenServerConst.PAY_STATUS = "pay_status"               -- 支付状态
OpenServerConst.CHANNEL_ORDER_ID = "channel_orderid"    -- 渠道订单号
OpenServerConst.PAY_TYPE = "pay_type"                   -- 支付手段，用于官网确定是wx/ali
OpenServerConst.PAY_AMOUNT = "amount"                   -- 订单金额
OpenServerConst.PAY_TOKEN = "token"                     -- 回执token
OpenServerConst.PAY_SIGN = "sign"                       -- 回执sign
OpenServerConst.PAY_SIGN_TYPE = "sign_type"             -- 回执sign类型

OpenServerConst.NOTIFY_URL = "notify_url"               -- 订单回调地址
OpenServerConst.MONEY = "money"                         -- 订单金额1
OpenServerConst.COST_MONEY = "cost_money"               -- 订单金额2
OpenServerConst.PRODUCT_NAME = "product_name"           -- 商品名称
OpenServerConst.PRODUCT_DESC = "product_desc"           -- 商品描述

OpenServerConst.APP_ID = "app_id"                       -- 应用宝用的appid字段
OpenServerConst.PF = "pf"                               -- 应用宝字段
OpenServerConst.PF_KEY = "pfkey"                        -- 应用宝字段
OpenServerConst.SESSION_ID = "session_id"               -- 应用宝字段
OpenServerConst.SESSION_TYPE = "session_type"           -- 应用宝字段
OpenServerConst.OPEN_KEY = "openkey"                    -- 应用宝字段
OpenServerConst.ZONE_ID = "zone_id"                     -- 应用宝字段
OpenServerConst.BILL_NO = "billno"                      -- 应用宝字段
OpenServerConst.AMT = "amt"                             -- 应用宝字段


OpenServerConst.FIRST_BONUS = "first_bonus"             -- 首充赠送赤玉
OpenServerConst.NORMAL_BONUS = "normal_bonus"           -- 平常赠送赤玉
OpenServerConst.GEM_AMOUNT = "amount"                   -- 充值获得的赤玉

OpenServerConst.UID = "uid"                             -- 查询信息时的uid
OpenServerConst.TARGET_UID = "tuid"                     -- 查询信息时的目标uid

OpenServerConst.PUSH_TYPE_GGP = "ggp"
OpenServerConst.PUSH_TYPE_APNS = "ios"


AccountType.SDO = "sdo"
AccountType.FACEBOOK = "facebook"           -- Playwith专用
AccountType.GOOGLE_I = "googlei"            -- Playwith专用 GoogleSignIn iOS
AccountType.GOOGLE_A = "googlea"            -- Playwith专用 GoogleSignIn Android
AccountType.GAMOTA = "gamota"               -- Playwith专用 GoogleSignIn Android

AccountType.UC = "uc"
AccountType.HUAWEI = "huawei"
AccountType.OPPO = "oppo"
AccountType.VIVO = "vivo"
AccountType.YYB = "yyb"
AccountType.XIAOMI = "xiaomi"
AccountType.QUICK = "quick"
AccountType.MINT = "mint"                   --盛和
AccountType.MIM = "mim"                     --迷秒
AccountType.PLAT = "plat"					--盛和发行sdk iOS/Android的acctype分开后，已废弃
AccountType.BYTED = "byted"                 --字节，日本渠道
AccountType.KOMOE = "komoe"                 --小萌，港台渠道
AccountType.BILIKOREA = "kr"         		--小萌，韩国渠道

AccountType.MULTI = "multi"					--盛和聚合sdk
AccountType.PLATA = "plata"                 -- 审核发行Android
AccountType.PLATI = "plati"

AccountType.NAME_PWD = "name_pwd"
AccountType.DEVICE_ID = "device_id"
AccountType.PHONE_NUMBER_I = "phone_numberi"
AccountType.PHONE_NUMBER_A = "phone_numbera"
AccountType.OPEN_TOKEN = "open_token"

AccountTypeId[AccountType.NAME_PWD] = 1
AccountTypeId[AccountType.DEVICE_ID] = 2
AccountTypeId[AccountType.OPEN_TOKEN] = 3

AccountTypeId[AccountType.PHONE_NUMBER_I] = 6
AccountTypeId[AccountType.PHONE_NUMBER_A] = 7
AccountTypeId[AccountType.FACEBOOK] = 251
AccountTypeId[AccountType.GOOGLE_I] = 252
AccountTypeId[AccountType.GOOGLE_A] = 253
AccountTypeId[AccountType.GAMOTA] = 102

AccountTypeId[AccountType.UC] = 151
AccountTypeId[AccountType.HUAWEI] = 152
AccountTypeId[AccountType.OPPO] = 153
AccountTypeId[AccountType.VIVO] = 154
AccountTypeId[AccountType.YYB] = 155
AccountTypeId[AccountType.XIAOMI] = 156
AccountTypeId[AccountType.QUICK] = 157
AccountTypeId[AccountType.MINT] = 158
AccountTypeId[AccountType.PLAT] = 159
AccountTypeId[AccountType.MIM] = 160
AccountTypeId[AccountType.BYTED] = 163
AccountTypeId[AccountType.KOMOE] = 164
AccountTypeId[AccountType.BILIKOREA] = 165

AccountTypeId[AccountType.MULTI] = 162
AccountTypeId[AccountType.PLATI] = 205
AccountTypeId[AccountType.PLATA] = 206


ErrorCode.PARAM_ERROR = 100
ErrorCode.INVALID_USER_ID = 110
ErrorCode.PERMISSION_ERROR = 200
ErrorCode.INVALID_TOKEN = 452
ErrorCode.TOKEN_OPENID_MISMATCH = 453
ErrorCode.TOKEN_EXPIRE = 454
ErrorCode.ACCOUNT_BINDED = 455
ErrorCode.ACCOUNT_BIND_NOT_FOUND = 456
ErrorCode.INVALID_CHANNEL_NAME = 460
ErrorCode.INVALID_CHANNEL_SESSION = 461
ErrorCode.NOT_IN_WHITE_LIST = 462

ErrorCode.INVALID_SMS_CODE = 1001
ErrorCode.SMS_CODE_EXCEEDS_LIMITS = 1002
ErrorCode.SMS_CODE_EXCEEDS_UP_LIMITS = 1003
ErrorCode.SMS_CODE_NOT_MATCH = 1004
ErrorCode.SMS_CODE_EXPIRE = 1005
ErrorCode.SMS_CODE_TRY_TOO_MANY_TIMES = 1006
ErrorCode.INVALID_ACCOUNT_PASSOWRD = 1011

ErrorCode.INVALID_RECEIPT = 2001
ErrorCode.NEED_RETRY_RECEIPT = 2002

ErrorText[ErrorCode.PARAM_ERROR] = "参数有误"
ErrorText[ErrorCode.INVALID_USER_ID] = "无效的用户"
ErrorText[ErrorCode.PERMISSION_ERROR] = "权限错误"
ErrorText[ErrorCode.INVALID_TOKEN] = "TOKEN无效，请重新登录"
ErrorText[ErrorCode.TOKEN_OPENID_MISMATCH] = "ID和TOKEN不匹配"
ErrorText[ErrorCode.TOKEN_EXPIRE] = "TOKEN已过期，请重新登录"

ErrorText[ErrorCode.ACCOUNT_BINDED] = "无法绑定，该账号已注册"
ErrorText[ErrorCode.ACCOUNT_BIND_NOT_FOUND] = "找不到当前账号信息"

ErrorText[ErrorCode.INVALID_CHANNEL_NAME] = "无效的渠道"
ErrorText[ErrorCode.INVALID_CHANNEL_SESSION] = "无效的SESSION"
-- ErrorText[ErrorCode.NOT_IN_WHITE_LIST] = "维护中，请稍候..."

ErrorText[ErrorCode.INVALID_RECEIPT] = "无效的订单回执"

ErrorText[ErrorCode.SMS_CODE_NOT_MATCH] = "验证码错误"
ErrorText[ErrorCode.SMS_CODE_EXPIRE] = "验证码已过期"

return OpenServerConst
