//
//  NtConstProp.h
//  NtUniSdk
//
//  Created by UniSDK on 14-5-23.
//  Copyright (c) 2014年 Game-NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief PAY_UID用于支付用uid，jinliuSDK支付不使用LINE mid，使用和jinliu交换后的uid
 */
extern NSString* const NT_FF_UID; //NT_FF_UID = @"FF_UID";

/**
 *  @brief 用于管理是否打开SDK充值，默认为打开充值(PP)
 */
extern NSString* const NT_CLOSE_RECHARGER; //NT_CLOSE_RECHARGER = @"CLOSE_RECHARGER";

/**
 *  @brief 支付时传入的ROLE_ID(LINE)
 */
extern NSString* const NT_ROLE_ID; //NT_ROLE_ID = @"ROLE_ID";

/**
 *  @brief 支付时传入的ROLE_LEVEL(LINE)
 */
extern NSString* const NT_ROLE_LEVEL; //NT_ROLE_LEVEL = @"ROLE_LEVEL";

/**
 * @brief 跟平台申请的CHANNEL_ID(LINE)
 */
extern NSString* const NT_CHANNEL_ID; //NT_CHANNEL_ID = @"CHANNEL_ID";

/**
 * @brief 跟平台申请的MERUHANT_ID(DownJoy)
 */
extern NSString* const NT_MERUHANT_ID; //NT_MERUHANT_ID = @"MERUHANT_ID";
/**
 * @brief APP Scheme URL
 */
extern NSString* const NT_APP_URL_SCHEME; //NT_APP_URL_SCHEME = @"APP_URL_SCHEME";

/**
 * @brief 游戏代号
 */
extern NSString* const NT_GAMEID; //NT_GAMEID = @"GAMEID";

/**
 * @brief APP的名字
 */
extern NSString* const NT_APP_NAME; //NT_APP_NAME = @"APP_NAME";
/**
 * @brief 跟平台申请的id
 */
extern NSString* const NT_APPID; //NT_APPID = @"APPID";
/**
 * @brief 跟平台申请的key
 */
extern NSString* const NT_APP_KEY; //NT_APP_KEY = @"APP_KEY";
/**
 * @brief 跟平台申请的secret
 */
extern NSString* const NT_APP_SECRET; //NT_APP_SECRET = @"APP_SECRET";

/**
 *  @brief  app群组，方便各个app之间共享Keychain
 */
extern NSString *const NT_APP_GROUP; //NT_APP_GROUP = @"APP_GROUP";

/**
 * @brief 跟微信申请的APP KEY, 登录授权用的
 */
extern NSString* const NT_WECHAT_APP_KEY;   //NT_WECHAT_APP_KEY = @"WECHAT_APP_KEY";
extern NSString* const NT_WECHAT_APP_DESC;//描述信息,3.0.4deprecated //NT_WECHAT_APP_DESC = @"WECHAT_APP_DESC";//描述信息
extern NSString* const NT_WECHAT_UNIVERSAL_LINK;//NT_WECHAT_UNIVERSAL_LINK = @"WECHAT_UNIVERSAL_LINK";


/**
 * @brief 跟QQ申请的APP ID, 登录授权用的
 */
extern NSString* const NT_QQ_APP_ID; //NT_QQ_APP_ID = @"QQ_APP_ID";

/**
 * @brief 跟WEIBO申请的APP KEY, 微博登录授权用的
 */
extern NSString* const NT_WEIBO_APP_KEY; //NT_WEIBO_APP_KEY = @"WEIBO_APP_KEY";
extern NSString* const NT_WEIBO_REDIRECT_URI; //调转的地址 //NT_WEIBO_REDIRECT_URI = @"WEIBO_REDIRECT_URI";
extern NSString* const NT_WEIBO_UNIVERSAL_LINK;
/**
 * @brief 跟GOOGLE申请的Client ID
 */
extern NSString* const NT_GOOGLE_CLIENT_ID; //NT_GOOGLE_CLIENT_ID = @"GOOGLE_CLIENT_ID";
/**
 * @brief 跟FACEBOOK申请的Client ID
 */
extern NSString* const NT_FACEBOOK_CLIENT_ID; //NT_FACEBOOK_CLIENT_ID = @"FACEBOOK_CLIENT_ID";
/**
 * @brief 跟TikTok(抖音海外版)申请的Client Key
 */
extern NSString* const NT_TIKTOK_CLIENT_KEY;//NT_TIKTOK_CLIENT_KEY = @"TIKTOK_CLIENT_KEY";
/**
 * @brief 跟TWITTER申请的consumer key and consumer secrect
 */
extern NSString* const NT_TWITTER_CONSUMER_KEY; //NT_TWITTER_CONSUMER_KEY = @"TWITTER_CONSUMER_KEY";
extern NSString* const NT_TWITTER_CONSUMER_SECRET; //NT_TWITTER_CONSUMER_SECRET = @"TWITTER_CONSUMER_SECRET";
/**
 * @brief 跟DMM申请的参数
 */
extern NSString* const NT_DMM_CLIENT_ID; //NT_DMM_CLIENT_ID = @"DMM_CLIENT_ID";
extern NSString* const NT_DMM_CLIENT_SECRET; //NT_DMM_CLIENT_SECRET = @"DMM_CLIENT_SECRET";
extern NSString* const NT_DMM_REDIRECT_URL; //NT_DMM_REDIRECT_URL = @"DMM_REDIRECT_URL";
extern NSString* const NT_DMM_APPID; //NT_DMM_APPID = @"DMM_APPID";
extern NSString* const NT_DMM_CONSUMER_KEY; //NT_DMM_CONSUMER_KEY = @"DMM_CONSUMER_KEY";
extern NSString* const NT_DMM_CONSUMER_SECRET; //NT_DMM_CONSUMER_SECRET = @"DMM_CONSUMER_SECRET";
extern NSString* const NT_DMM_SECRET_KEY; //NT_DMM_SECRET_KEY = @"DMM_SECRET_KEY";

/**
 * @brief 抖音开放平台申请的应用Client ID
 */
extern NSString* const NT_DOUYIN_CLIENT_KEY; // NT_DOUYIN_CLIENT_KEY = @"DOUYIN_CLIENT_KEY";


/**
* @brief VK开放平台申请的APP_ID
*/
extern NSString* const NT_VK_APP_ID; // NT_VK_APP_ID = @"VK_APP_ID";

/**
* @brief mowang平台申请的APP_ID
*/
extern NSString* const NT_MOWANG_APP_ID; // NT_MOWANG_APP_ID = @"MOWANG_APP_ID";

/**
 * @brief 跟Naver申请的参数
 */
extern NSString* const NT_NAVER_CLIENT_ID; //NT_NAVER_CLIENT_ID = @"NAVER_CLIENT_ID";
extern NSString* const NT_NAVER_CLIENT_SECRET; //NT_NAVER_CLIENT_SECRET = @"NAVER_CLIENT_SECRET";
extern NSString* const NT_NAVER_URL_SCHEME; //NT_NAVER_URL_SCHEME = @"NAVER_URL_SCHEME";
extern NSString* const NT_NAVER_CLIENT_NAME; //NT_NAVER_CLIENT_NAME = @"NAVER_CLIENT_NAME";

/**
 * @brief 跟平台申请的服务器大区ID
 */
extern NSString* const NT_SERVER_ID; //NT_SERVER_ID = @"SERVER_ID";
/**
 * @brief 屏幕方向属性名
 */
extern NSString* const NT_SCR_ORIENTATION; //NT_SCR_ORIENTATION = @"SCR_ORIENTATION";
/**
 * @defgroup ScreenOrietation 屏幕方向
 * @brief 屏幕方向
 * @{
 */

/* iOS */

extern const int NT_E_SO_PORTRAIT;      //竖向        //NT_E_SO_PORTRAIT = 1;        //竖向
extern const int NT_E_SO_PORTRAIT_UD;   //竖向反转      //NT_E_SO_PORTRAIT_UD = 2;     //竖向反转
extern const int NT_E_SO_LANDSCAPE_L;   //横向        NT_E_SO_LANDSCAPE_L = 4;     //横向
extern const int NT_E_SO_LANDSCAPE_R;   //横向反转      NT_E_SO_LANDSCAPE_R = 8;     //横向反转
extern const int NT_E_SO_LANDSCAPE;     //双向横屏      NT_E_SO_LANDSCAPE = 5;     //双向横屏

/** @} */

/**
 * @brief sdk检查更新失败就禁止游戏开启，默认不禁止，设置为1可开启
 * 必须在ntInit调用之前就设置好，可放在xxxx.data中设置
 * 目前为 91\同步助手 设置，用于单机或者弱联网游戏
 */
extern NSString* const NT_SDK_UPDATE_CHECK_STRICT; //NT_SDK_UPDATE_CHECK_STRICT = @"SDK_UPDATE_CHECK_STRICT";

/**
 * @brief Kuaiyong Downjoy 要求游戏自带闪屏，UniSDK已经实现闪屏功能，默认不开启
 * 必须在ntInit调用之前就设置好，可放在xxxx_data中设置
 * 目前为 Kuaiyong Downjoy 设置
 */
extern NSString* const NT_SDK_LOAD_SPLASH_VIEW;  //NT_SDK_LOAD_SPLASH_VIEW = @"SDK_LOAD_SPLASH_VIEW";

/**
 * @brief 是否打开网易游戏logo的闪屏，为了与安卓统一，使用了“SPLASH_SECOND”
 * 必须在ntInit调用之前就设置好，可放在xxxx_data中设置
 */
extern NSString* const NT_SPLASH_SECOND;        //NT_SPLASH_SECOND = @"SPLASH_SECOND";
extern NSString* const NT_SPLASH_SECOND_MAXTIME; //NT_SPLASH_SECOND_MAXTIME = @"SPLASH_SECOND_MAXTIME";

/**
 * @brief 本当前登录状态
 */
extern NSString* const NT_LOGIN_STAT;       //NT_LOGIN_STAT = @"LOGIN_STAT";
/**
 * @defgroup LoginStatus 登录状态
 * @brief 登录状态
 * @{
 */
extern const int NT_E_LS_NOT_LOGIN;         ///< 未登录        //NT_E_LS_NOT_LOGIN = 0;        ///< 未登录
extern const int NT_E_LS_LOGIN_OK;          ///< 已经登录       NT_E_LS_LOGIN_OK = 1;         ///< 已经登录
/** @} */

/**
 * @getAuthType 登录账户类型 （对应的整形跟Android可能不同，建议使用 getAuthTypeName 来获取登录账户类型）
 * @brief 登录账户类型
 * @{
 */
extern const int NT_AUTH_UNLOGIN;  //未登录                    = 0;
extern const int NT_AUTH_NATIVE;   //本SDK默认的账户              = 1;
extern const int NT_AUTH_GUEST;    //游客                     = 2;
extern const int NT_AUTH_WEIBO;    //微博                     = 3;
extern const int NT_AUTH_FACEBOOK; //Facebook              = 4;
extern const int NT_AUTH_GameCenter; //Apple GameCenters   = 5;
extern const int NT_AUTH_WECHAT;    //微信               = 6;
extern const int NT_AUTH_GARENA;    // Garena           = 7;
extern const int NT_AUTH_BEETALK;   // BeeTalk          = 8;
extern const int NT_AUTH_QQ;        //QQ                = 9;
extern const int NT_AUTH_GOOGLE;    //GOOGLE+           = 10;
extern const int NT_AUTH_JOYBOMB;   //JOYBOMB           = 11;
extern const int NT_AUTH_MOBILE;    //mobile            = 12;
extern const int NT_AUTH_KAKAO;     //Kakao talk        = 13;
extern const int NT_AUTH_TWITTER;     //Twitter         = 14;
extern const int NT_AUTH_DMM;     //DMM                 = 15;
extern const int NT_AUTH_STEAM;     //Steam             = 16;
extern const int NT_AUTH_LINE;     //Line               = 17; 没有18，18在android其他渠道用了
extern const int NT_AUTH_LINE_GAME;     //Linegame      = 19;
extern const int NT_AUTH_BATTLE;      ///<battle        = 20;
extern const int NT_AUTH_YIXIN;       ///<yixin         = 21;
extern const int NT_AUTH_PSN;      //psn                = 22;
extern const int NT_AUTH_XIANLIAO; //xianliao           = 23;
extern const int NT_AUTH_Nintendo; //Nintendo           = 24;
extern const int NT_AUTH_DOUYIN;    //douyin            = 25;
extern const int NT_AUTH_MOBILE_NOT_NETEASE; //非网易手机帐号  =26
extern const int NT_AUTH_APPLE; //Apple                 = 27;
extern const int NT_AUTH_VK; //VK                       = 28;
extern const int NT_AUTH_MOWANG; //mowang               = 29;
extern const int NT_AUTH_URS_OAUTH; // Oauth            = 30;
extern const int NT_AUTH_NAVER; //NAVER                 = 31;
extern const int NT_AUTH_HYDRA_EMAIL; //HYDRA EMAIL     = 32;
extern const int NT_AUTH_NOAHGAME; // NOAHGAME          = 33;
extern const int NT_AUTH_TIKTOK;     //TikTok           = 34;
extern const int NT_AUTH_EMAIL; //EMAIL     = 35;
extern const int NT_AUTH_DOUYIN_CLOUD_GAME; //DOUYIN_CLOUD_GAME     = 36; 安卓使用，iOS 占位
extern const int NT_AUTH_DISCORD; //DISCORD     = 37;
extern const int NT_AUTH_PASSPORT; // PASSPORT = 38;
extern const int NT_AUTH_ENYI_PASSPORT; // ENYI_PASSPORT = 40;
extern const int NT_AUTH_LY_PASSPORT; // LY_PASSPORT = 41;
extern const int NT_AUTH_PN; // PN = 42;
extern const int NT_AUTH_KK; // KK = 43;

/**
 * @getAuthTypeName 登录账户类型的名称
 * @brief 登录账户类型
 * @{
 */
extern NSString* const NT_AUTH_NAME_UNLOGIN;// = @"unlogin";  //未登录
extern NSString* const NT_AUTH_NAME_NATIVE;// = @"native";   //本SDK默认的账户
extern NSString* const NT_AUTH_NAME_GUEST;// = @"guest";    //游客
extern NSString* const NT_AUTH_NAME_WEIBO;// = @"weibo";    //微博
extern NSString* const NT_AUTH_NAME_FACEBOOK;// = @"facebook"; //facebook
extern NSString* const NT_AUTH_NAME_TWITTER;// = @"twitter"; //twitter
extern NSString* const NT_AUTH_NAME_GAMECENTER;// = @"gamecenter";   //Apple GameCenters
extern NSString* const NT_AUTH_NAME_WECHAT;// = @"wechat"; //微信
extern NSString* const NT_AUTH_NAME_GARENA;// = @"garena"; // Garena
extern NSString* const NT_AUTH_NAME_BEETALK;// = @"beetalk"; // BeeTalk
extern NSString* const NT_AUTH_NAME_QQ;// = @"qq";
extern NSString* const NT_AUTH_NAME_GOOGLE;// = @"google"; //Google
extern NSString* const NT_AUTH_NAME_JOYBOMB;// = KAKA@"joybomb";
extern NSString* const NT_AUTH_NAME_MOBILE;// = @"mobile"; ///< 手机号
extern NSString* const NT_AUTH_NAME_DUOKU;// = @"duoku";///< 多酷登陆
extern NSString* const NT_AUTH_NAME_91;// = @"91";///< 91登陆
extern NSString* const NT_AUTH_NAME_KAKAO;// = @"kakao";///< kakao talk
extern NSString* const NT_AUTH_NAME_DMM;// = @"dmm";///< dmm
extern NSString* const NT_AUTH_NAME_STEAM;// = @"steam";///< steam
extern NSString* const NT_AUTH_NAME_LINE;// = @"line";
extern NSString* const NT_AUTH_NAME_LINE_GMAE;// = @"linegame";
extern NSString* const NT_AUTH_NAME_BATTLE; // = @"battle";///<battle
extern NSString* const NT_AUTH_NAME_YIXIN; // = @"yixin";///<yixin
extern NSString* const NT_AUTH_NAME_PSN; // = @"psn";///<psn
extern NSString* const NT_AUTH_NAME_XIANLIAO; // = @"xianliao";///<xianliao
extern NSString* const NT_AUTH_NAME_NINTENDO; // = @"nintendo";///<任天堂
extern NSString* const NT_AUTH_NAME_DOUYIN; // = "douyin";///<抖音
extern NSString* const NT_AUTH_NAME_MOBILE_NOT_NETEASE; // = "mobileNotNetease";///非网易手机帐号
extern NSString* const NT_AUTH_NAME_APPLE; // = "apple";///<苹果登录
extern NSString* const NT_AUTH_NAME_VK; // = "vk";///<VK
extern NSString* const NT_AUTH_NAME_MOWANG; // = @"mowang";///<mowang
extern NSString* const NT_AUTH_NAME_URS_OAUTH; // = @"ursOAuth"; ///<urs oauth
extern NSString* const NT_AUTH_NAME_NAVER; // = "naver";///<NAVER
extern NSString* const NT_AUTH_NAME_HYDRA_EMAIL; // = "hydra_email";///<HYDRA EMAIL
extern NSString* const NT_AUTH_NAME_NOAHGAME; // = "noahgame";///noahgame 平台账号
extern NSString* const NT_AUTH_NAME_TIKTOK;// = @"tiktok";///< TikTok
extern NSString* const NT_AUTH_NAME_EMAIL; // = "email";///<EMAIL
extern NSString* const NT_AUTH_NAME_DOUYIN_CLOUD_GAME; // = "douyinCloudGame"; /// 抖音云游戏
extern NSString* const NT_AUTH_NAME_DISCORD; // = "discord";///<DISCORD
extern NSString* const NT_AUTH_NAME_PASSPORT; // = "passport";///<PASSPORT
extern NSString* const NT_AUTH_NAME_ENYI_PASSPORT; // = "enyi_passport";///<Enyi PASSPORT
extern NSString* const NT_AUTH_NAME_LY_PASSPORT; // = "ly_passport";///<Ly PASSPORT
extern NSString* const NT_AUTH_NAME_PN; // = "pn";///<Player Network
extern NSString* const NT_AUTH_NAME_KK; // = "kk";///<KK


extern NSString* const LOGIN_TYPE; //登录的渠道（NetMarble允许G+\FB\GameCenter登录） LOGIN_TYPE = @"LOGIN_TYPE";

extern NSString* const NT_SAUTH_LOGIN_TYPE; //渠道定义的登录渠道 NT_SAUTH_LOGIN_TYPE = @"SAUTH_LOGIN_TYPE";

extern NSString* const NT_SECURITY_EMAIL_SET; //是否绑定了安全邮箱 NT_SECURITY_EMAIL_SET = @"SECURITY_EMAIL_SET";

extern NSString* const NT_LINE_GAME_TOKEN_VALID; //Line Game token否有效 NT_LINE_GAME_TOKEN_VALID = @"LINE_GAME_TOKEN_VALID";

extern NSString* const EXTEND_FUNC_RETURN; //扩展函数返回值 EXTEND_FUNC_RETURN = @"EXTEND_FUNC_RETURN";
/**
 *  使用的渠道SDK
 */
extern NSString* const NT_SDK_NOAH;  //网易SDK NT_SDK_NETEASE = @"NtSdkNoahCH";
extern NSString* const NT_SDK_YIXIN;  //易信SDK NT_SDK_YIXIN = @"NtSdkYiXin";

/**
 * @brief 未登录时如果调用获取session会得到的值
 */
extern NSString* const NT_S_NOT_LOGIN_SESSION; //NT_S_NOT_LOGIN_SESSION = @"not_login";

/**
 * @brief 本未登录时如果调用获取TIMESTAMP会得到的值
 */
extern NSString* const NT_S_NOT_TIMESTAMP;  //NT_S_NOT_TIMESTAMP = @"not_timestamp";

/**
 * @brief 本未登录时如果调用获取APP_CHANNEL会得到的值
 */
extern NSString* const NT_S_NOT_APP_CHANNEL; //NT_S_NOT_APP_CHANNEL = @"please_input_appchannel";

/**
 * @brief 无效device id
 */
extern NSString* const NT_INVALID_DEVICE_ID; //NT_INVALID_DEVICE_ID = @"unknown_device";

/**
 * @brief 道具付费单价上限
 */
extern const float NT_C_MAX_PRICE; //NT_C_MAX_PRICE = (float) 10000.0;

/**
 * @brief 无效uid标志
 */
extern NSString* const NT_INVALID_UID; //NT_INVALID_UID = @"";

/**
 * @brief 用户的ID字段 注意，本字段需在用户登录成功后，在UI线程中设置上
 */
extern NSString* const NT_UID;  //NT_UID = @"UIN";
/**
 * @brief 用户的完整ID字段 格式是 xxx@ad.yyyy.win.163.com
 * xxx是平台返回的UID，yyyy是渠道字符串
 */
extern NSString* const NT_FULL_UID; //NT_FULL_UID = @"FULL_UIN";

/**
 * @brief 用户的设备ID字段 注意，本字段需在用户登录成功后，在UI线程中设置上
 */
extern NSString* const NT_DEVICE_ID; //NT_DEVICE_ID = @"DEVICE_ID";

/**
 * @brief 用户的设备ID字段: 计费设备ID，从计费服务器下发获取
 */
extern NSString* const NT_GB_DEVICE_ID; //NT_GB_DEVICE_ID = @"GB_DEVICE_ID";

/**
 * @brief udid 在ios6及以上版本为IDFA，在ios5及以下为mac地址
 */
extern NSString* const NT_UDID; //NT_UDID = @"UDID";

/**
* @brief android移动安全联盟设备id
*/
extern NSString* const NT_OAID; //NT_OAID = @"OAID";

/** 设备 IDFV */
extern NSString* const NT_IDFV; // = @"IDFV";

/**
 * @brief 中广协 CAID
 */
extern NSString* const NT_TDID; // = @"TDID";

/**
 * @brief cpid 
 */
extern NSString* const NT_CPID; //Line IAP支付的cpid NT_CPID = @"CPID";

/**
 * @brief username
 */
extern NSString* const NT_USR_NAME; //NT_USR_NAME = @"USR_NAME";

/**
 *  @brief  user key
 */
extern NSString* const NT_USER_KEY; //NT_USER_KEY = @"USER_KEY";
/**
 * @brief 用户的SESSION字段 注意，本字段需在用户登录成功后，在UI线程中设置上
 *        部分SDK的SESSION字段可能有有效期，所以要注意更新本字段内容
 */
extern NSString* const NT_SESSION;  //NT_SESSION = @"SESSION";
/**
 * @brief 用户登陆的timestamp字段 注意，本字段需在用户登录成功后，在UI线程中设置上
 *        部分SDK的TIMESTAMP字段可能有有效期，所以要注意更新本字段内容
 */
extern NSString* const NT_TIMESTAMP; //NT_TIMESTAMP = @"TIMESTAMP";

/**
 * @brief NT_APP_CHANNEL  通过.data文件读取，默认please_input_appchannel
 */
extern NSString* const NT_APP_CHANNEL; //NT_APP_CHANNEL = @"APP_CHANNEL";

/**
 * @brief NT_LOGIN_CHANNEL  通过.data文件读取，默认为nil
 */
extern NSString* const NT_LOGIN_CHANNEL; //NT_LOGIN_CHANNEL = @"LOGIN_CHANNEL";

/**
 * @brief 手机号绑定状态
 */
extern NSString* const NT_VERIFY_TYPE; //NT_VERIFY_TYPE = @"VERIFY_TYPE"; //手机号验证

/**
 * @brief 实名认证
 */
extern NSString* const NT_REAL_NAME_VERIFIED; //实名认证 NT_REAL_NAME_VERIFIED = @"REAL_NAME_VERIFIED";
extern const int NT_REAL_NAME_VERIFIED_NO; //NT_REAL_NAME_VERIFIED_NO = 0
extern const int NT_REAL_NAME_VERIFIED_UNDER_18; //NT_REAL_NAME_VERIFIED_UNDER_18 = 1
extern const int NT_REAL_NAME_VERIFIED_18_AND_ABOVE; //NT_REAL_NAME_VERIFIED_18_AND_ABOVE = 2
extern const int NT_REAL_NAME_VERIFIED_AND_STATUS_UNKNOWN; //NT_REAL_NAME_VERIFIED_AND_STATUS_UNKNOWN=3

/**
 * @defgroup SdkFeature Sdk功能点
 * @brief 每个sdk具备的功能点不一样，在调用之前请先用hasFeature查询一下
 * @{
 */
extern NSString* const NT_MODE_HAS_LOGOUT;          ///< 登出功能 NT_MODE_HAS_LOGOUT = @"FEATURE_HAS_LOGOUT";
extern NSString* const NT_MODE_HAS_MANAGER;         ///< 账户管理功能 NT_MODE_HAS_MANAGER = @"FEATURE_HAS_MANAGER";
extern NSString* const NT_MODE_HAS_PAUSE_VIEW;      ///< 暂停页，目前91有这个功能 NT_MODE_HAS_PAUSE_VIEW = @"FEATURE_HAS_PAUSE_VIEW";
extern NSString* const NT_MODE_NEED_UNITED_LOGIN;   ///< 登录了SDK就自动直接进入游戏，目前是UC有此功能 @"FEATURE_NEED_UNITED_LOGIN";
extern NSString* const NT_MODE_EXIT_VIEW;           ///< 退出页面功能，目前只有91有这个功能 NT_MODE_EXIT_VIEW = @"FEATURE_EXIT_VIEW";
extern NSString* const NT_MODE_HAS_GUEST;           ///< 游客功能，目前只有网易有此功能 NT_MODE_HAS_GUEST = @"MODE_HAS_GUEST";
extern NSString* const NT_MODE_HAS_GUEST_BIND;      ///< 游客绑定功能, NT_MODE_HAS_GUEST_BIND = @"FEATURE_HAS_GUEST_BIND"
extern NSString* const NT_MODE_USE_IAP;             ///< 使用IAP内付 NT_MODE_USE_IAP = @"MODE_USE_IAP";
extern NSString* const NT_MODE_MULTI_SDK;           ///< 多SDK NT_MODE_MULTI_SDK = @"MODE_MULTI_SDK";
extern NSString* const NT_MODE_HAS_CONVERSATION;    ///< 会话界面 NT_MODE_HAS_CONVERSATION = @"MODE_HAS_CONVERSATION";
extern NSString* const NT_MODE_HAS_FAQS;            ///< FAQ界面 NT_MODE_HAS_FAQS = @"MODE_HAS_FAQS";
extern NSString* const NT_MODE_HAS_REALNAME_DIALOG; ///< 实名认证界面 NT_MODE_HAS_REALNAME_DIALOG= @"FEATURE_HAS_REALNAME_DIALOG";
extern NSString* const NT_MODE_HAS_NGUPHOTO;        ///< NGUPhoto 图片选择器 NT_MODE_HAS_NGUPHOTO = @"FEATURE_HAS_NGUPHOTO";
extern NSString* const NT_CLOUD_GAME;               ///< 云游戏 NT_CLOUD_GAME = @"CLOUD_GAME";
extern NSString* const NT_CLOUD_GAME_CLIENT_AAS;    ///< 云游戏微端防沉迷 NT_CLOUD_GAME_CLIENT_AAS = @"CLOUD_GAME_CLIENT_AAS";

/** @} */

/**
 * @defgroup AttachGameEngine 游戏引擎类型
 * @brief 使用本sdk的引擎类型
 * @{
 */
extern NSString* const NT_GAME_ENGINE;      //NT_GAME_ENGINE = @"GAME_ENGINE";
extern const int NT_ENGINE_COCOS;                   ///< cocos2d-x引擎 = 0;
extern const int NT_ENGINE_UNITY3D;                 ///< Unity3D引擎 = 1;
extern const int NT_ENGINE_NEOX;                    ///< NeoX引擎 = 2;
/** @} */

/*
 * @brief 是否海外发行
 */
extern NSString* const NT_RELEASEAREA; // NT_RELEASEAREA = @"RELEASEAREA";

/**
 * @brief 是否Debug Mode
 */
extern NSString* const NT_ENABLE_DEBUG_MODE;    //NT_ENABLE_DEBUG_MODE = @"DEBUG_MODE";

/**
 * @brief 打印Debug Log
 */
extern NSString* const NT_ENABLE_DEBUG_LOG;     //NT_ENABLE_DEBUG_LOG = @"DEBUG_LOG";

/**
 * @brief 是否开放游客登录，目前支持的渠道：网易 网易海外版
 */
extern NSString* const NT_ENABLE_EXLOGIN_GUEST; //NT_ENABLE_EXLOGIN_GUEST = @"ENABLE_EXLOGIN_GUEST";

/**
 * @brief 是否开放新浪微博第三方登录，目前支持的渠道：网易
 */
extern NSString* const NT_ENABLE_EXLOGIN_WEIBO; //NT_ENABLE_EXLOGIN_WEIBO = @"ENABLE_EXLOGIN_WEIBO";

/**
 * @brief 是否开放新浪微博SSO第三方登录，目前支持的渠道：网易
 */
extern NSString* const NT_ENABLE_EXLOGIN_WEIBO_SSO;     //NT_ENABLE_EXLOGIN_WEIBO_SSO = @"ENABLE_EXLOGIN_WEIBO_SSO";

/**
 * @brief 是否开放易信第三方登录，目前支持的渠道：网易
 */
extern NSString* const NT_ENABLE_EXLOGIN_YIXIN;     //NT_ENABLE_EXLOGIN_YIXIN = @"ENABLE_EXLOGIN_YIXIN";
//
/**
 * @brief 是否开放微信第三方登录，目前支持的渠道：网易
 */
extern NSString* const NT_ENABLE_EXLOGIN_WECHAT;    //NT_ENABLE_EXLOGIN_WECHAT = @"ENABLE_EXLOGIN_WECHAT";

/**
 * @brief 是否开放QQ第三方登录，目前支持的渠道：网易
 */
extern NSString* const NT_ENABLE_EXLOGIN_QQ;        //NT_ENABLE_EXLOGIN_QQ = @"ENABLE_EXLOGIN_QQ";

/**
 * @brief 是否开放FACEBOOK第三方登录，目前支持的渠道：网易海外版
 */
extern NSString* const NT_ENABLE_EXLOGIN_FACEBOOK;      //NT_ENABLE_EXLOGIN_FACEBOOK = @"ENABLE_EXLOGIN_FACEBOOK";

/**
 * @brief 是否开放GOOGLE第三方登录，目前支持的渠道：网易海外版
 */
extern NSString* const NT_ENABLE_EXLOGIN_GOOGLE;        //NT_ENABLE_EXLOGIN_GOOGLE = @"ENABLE_EXLOGIN_GOOGLE";

/**
 * @brief 是否开放Sign In With Apple，目前支持的渠道：网易
 */
extern NSString* const NT_ENABLE_EXLOGIN_APPLE;         //NT_ENABLE_EXLOGIN_APPLE = @"ENABLE_EXLOGIN_APPLE";

/**
 * @brief 是否开放Line，目前支持的渠道：网易海外版
 */
extern NSString* const NT_ENABLE_EXLOGIN_LINE;         //NT_ENABLE_EXLOGIN_LINE = @"ENABLE_EXLOGIN_LINE";

/**
 * @brief 是否开放Kakao，目前支持的渠道：网易海外版
 */
extern NSString* const NT_ENABLE_EXLOGIN_KAKAO;         //NT_ENABLE_EXLOGIN_KAKAO = @"ENABLE_EXLOGIN_KAKAO";

/**
 * @brief 是否开放TikTok，目前支持的渠道：网易海外版
 */
extern NSString* const NT_ENABLE_EXLOGIN_TIKTOK;         //NT_ENABLE_EXLOGIN_TIKTOK = @"ENABLE_EXLOGIN_TIKTOK";

/**
 * @brief 是否启用苹果广告追因，默认是
 */
extern NSString* const NT_ENABLE_APPLE_ADS_ATTRIBUTION; //  @"APPLE_ADS_ATTRIBUTION";

/**
 * @brief 配置导航栏是否显示，默认不显示，1为显示
 */
extern NSString* const NT_ENABLE_NAVIGATION_BAR;  //NT_ENABLE_NAVIGATION_BAR = @"ENABLE_NAVIGATION_BAR";


extern NSString* const NT_ENABLE_IP_V6;                 //NT_ENABLE_IP_V6 = "ENABLE_IP_V6";

/// 是否使用单机版计费sauth验证登录
extern NSString* const NT_ENABLE_CLIENT_SAUTH; // NT_ENABLE_CLIENT_SAUTH = @"ENABLE_CLIENT_SAUTH";

/**
 * @brief 游戏发行的区域 0:亚洲地区，主要是香港, 1:北美地区，目前支持的渠道：网易海外版
 */
extern NSString* const NT_GAME_REGION;      //NT_GAME_REGION = @"GAME_REGION";

/**
 * @brief 游戏语言 目前支持的渠道：网易海外版
 
 Default = 0,             // System Language
 English = 1,             // English
 ChineseSimplified = 2,   // Chinese Simplified
 ChineseTraditional = 3,  // Chinese Traditional
 Spanish = 4,             // Spanish
 Portuguese = 5,          // Portuguese
 
 */
extern NSString* const NT_GAME_LANGUAGE;    //NT_GAME_LANGUAGE = @"GAME_LANGUAGE";

/**
 * @brief 用于绑定游客，用于：网易
 */
extern NSString* const NT_ORIGIN_GUEST_UID;     //NT_ORIGIN_GUEST_UID = @"ORIGIN_GUEST_UID";

/**
 * @brief 玩家角色ID
 */
extern NSString* const NT_USERINFO_UID;     //NT_USERINFO_UID = @"USERINFO_UID";

/**
 * @brief 计费玩家ID
 */
extern NSString* const NT_USERINFO_AID;     //NT_USERINFO_AID = @"USERINFO_AID";

/**
 * @brief 玩家角色昵称
 */
extern NSString* const NT_USERINFO_NAME;    //NT_USERINFO_NAME = @"USERINFO_NAME";

/**
 * @brief 玩家角色等级
 */
extern NSString* const NT_USERINFO_GRADE;   //NT_USERINFO_GRADE = @"USERINFO_GRADE";

/**
 * @brief 玩家角色所属服务器ID
 */
extern NSString* const NT_USERINFO_HOSTID; //NT_USERINFO_HOSTID = @"USERINFO_HOSTID";

/**
 * @brief 玩家角色所属服务器名称
 */
extern NSString* const NT_USERINFO_HOSTNAME;    //NT_USERINFO_HOSTNAME = @"USERINFO_HOSTNAME";

/**
 * @brief 玩家VIP等级
 */
extern NSString* const NT_USERINFO_VIP; //NT_USERINFO_VIP = @"USERINFO_VIP";

/**
 * @brief 玩家帮派
 */
extern NSString* const NT_USERINFO_ORG; //NT_USERINFO_ORG = @"USERINFO_ORG";

/**
 * @brief 玩家帮派名称
 */
extern NSString* const NT_USERINFO_ORGNAME; //NT_USERINFO_ORGNAME = @"USERINFO_ORGNAME";


/**
 * @brief 玩家职业（门派）名称
 */
extern NSString* const NT_USERINFO_CAREERNAME; //NT_USERINFO_CAREERNAME = @"USERINFO_CAREERNAME";

/**
 * @brief 玩家经验值
 */
extern NSString* const NT_USERINFO_EXP; //NT_USERINFO_EXP = @"USERINFO_EXP";

/**
 * @brief 玩家钻石数量
 */
extern NSString* const NT_USERINFO_DIAMOND; //NT_USERINFO_DIAMOND = @"USERINFO_DIAMOND";

/**
 * @brief 玩家自定信息
 */
extern NSString* const NT_USERINFO_CUSTOMDATA; //NT_USERINFO_CUSTOMDATA = @"USERINFO_CUSTOMDATA";

/**
 * @brief 上传信息类型
 */
extern NSString* const NT_USERINFO_STAGE; //NT_USERINFO_STAGE = @"USERINFO_STAGE";

/**
 * @brief 创建角色。必接
 */
extern NSString* const NT_USERINFO_STAGE_CREATE_ROLE; //NT_USERINFO_STAGE_CREATE_ROLE = @"USERINFO_STAGE_CREATE_ROLE";

/**
 * @brief 进入服务器，用户获取角色等级，角色名称等。必接
 */
extern NSString* const NT_USERINFO_STAGE_ENTER_SERVER; //NT_USERINFO_STAGE_ENTER_SERVER = @"USERINFO_STAGE_ENTER_SERVER";

/**
 * @brief 角色升级。必接
 */
extern NSString* const NT_USERINFO_STAGE_LEVEL_UP; //NT_USERINFO_STAGE_LEVEL_UP = @"USERINFO_STAGE_LEVEL_UP";

/**
 * @brief 离开服务器。网易、麟游 选接
 */
extern NSString* const NT_USERINFO_STAGE_LEAVE_SERVER; //NT_USERINFO_STAGE_LEAVE_SERVER = @"USERINFO_STAGE_LEAVE_SERVER";

/**
 * @brief 进入游戏主界面（funcell）
 */
extern NSString* const NT_USERINFO_STAGE_ENTER_MAIN; //NT_USERINFO_STAGE_ENTER_MAIN = @"USERINFO_STAGE_ENTER_MAIN";

/**
 * @brief 选服
 */
extern NSString* const NT_USERINFO_STAGE_CHOOSE_SERVER; //NT_USERINFO_STAGE_CHOOSE_SERVER = @"USERINFO_STAGE_CHOOSE_SERVER";


/**
 * @brief Oauth Access Token
 */
extern NSString* const NT_OAUTH_ACCESS_TOKEN; //NT_OAUTH_ACCESS_TOKEN = @"OAUTH_ACCESS_TOKEN";

/**
 * @brief Oauth Refresh Token
 */
extern NSString* const NT_OAUTH_REFRESH_TOKEN; //没有这个定义

/**
 * @brief Oauth Access Token 有效时间
 */
extern NSString* const NT_OAUTH_ACCESS_EXPIRES; //没有这个定义
/**
 * @brief Facebook Access Token 
 */
extern NSString* const NT_FACEBOOK_TOKEN;  //NT_FACEBOOK_TOKEN = @"FACEBOOK_TOKEN";

/**
 * @brief cdn server 服务器 line渠道
 */
extern NSString* const NT_CDN_SERVER;       //NT_CDN_SERVER = @"CDN_SERVER";

/**
 * @brief cdn server 支付的服务器IP
 */
extern NSString* const NT_PURCHASE_REG_SERVER; //预约register NT_PURCHASE_REG_SERVER = @"PURCHASE_REG_SERVER";
extern NSString* const NT_PURCHASE_VRF_SERVER; //验证verify NT_PURCHASE_VRF_SERVER = @"PURCHASE_VRF_SERVER";

/**
 * @brief 所有错误状态返回字典的KEY 状态码及内容
 */
extern NSString * const NT_ERROR_CODE; //NT_ERROR_CODE = @"NT_ERROR_CODE";
extern NSString * const NT_ERROR_MSG; //NT_ERROR_MSG = @"NT_ERROR_MSG";
extern NSString * const NT_UNISAUTH_ERROR_SUB_CODE; //NT_UNISAUTH_ERROR_SUB_CODE = @"NT_ERROR_SUB_CODE";
extern NSString * const NT_UNISAUTH_LOGIN_ERR_MSG; //NT_UNISAUTH_LOGIN_ERR_MSG = @"UNISDK_LOGIN_ERR_MSG";

/**
 * @brief 是否打开币种限制的功能(乱斗Line渠道特有)
 * 赋值“0”则不走限制流程，“1”则打开币种限制（如果NtOrderInfo币种字段赋值就会起效）
 */
extern NSString * const NT_IS_CURRENCY_RESTRICT_OPEN; //NT_IS_CURRENCY_RESTRICT_OPEN = @"IS_CURRENCY_RESTRICT_OPEN";
extern NSString * const NT_PRODUCT_LIST;//获取币种要用到的商品Id列表 NT_PRODUCT_LIST = @"PRODUCT_LIST";
extern NSString * const NT_CURRENCY;//AppleID对应的币种 NT_CURRENCY = @"CURRENCY";
//extern NSString * const NT_PRODUCT_INFO;//对应的价格

/**
 *  @brief 获取好友列表的参数：开始的序号，每次获取的最大人数。
 */
extern NSString* const NT_QUERY_FRIENDS_START_INDEX; //NT_QUERY_FRIENDS_START_INDEX = @"NT_QUERY_FRIENDS_START_INDEX";
extern NSString* const NT_QUERY_FRIENDS_COUNT; //NT_QUERY_FRIENDS_COUNT = @"NT_QUERY_FRIENDS_COUNT";
extern NSString* const NT_QUERY_FRIENDS_IN_GAME_START_INDEX; //NT_QUERY_FRIENDS_IN_GAME_START_INDEX = @"NT_QUERY_FRIENDS_IN_GAME_START_INDEX";
extern NSString* const NT_QUERY_FRIENDS_IN_GAME_COUNT; //NT_QUERY_FRIENDS_IN_GAME_COUNT = @"NT_QUERY_FRIENDS_IN_GAME_COUNT";
extern NSString* const NT_QUERY_FRIENDS_TOTAL; //存储line返回的好友数 NT_QUERY_FRIENDS_TOTAL = @"NT_QUERY_FRIENDS_TOTAL";
extern NSString* const NT_QUERY_FRIENDS_IN_GAME_TOTAL; //存储line返回的游戏好友数 NT_QUERY_FRIENDS_IN_GAME_TOTAL = @"NT_QUERY_FRIENDS_IN_GAME_TOTAL";
/**
 *  @brief NetMarble 弹出页面
 */
extern NSString* const NT_WEB_NOTICE_INTRO; //公示-游戏开始页面自动进行时显示 NT_WEB_NOTICE_INTRO = @"NT_WEB_NOTICE_INTRO";
extern NSString* const NT_WEB_NOTICE_INGAME; //公示-点击游戏内公告事项按钮时显示 NT_WEB_NOTICE_INGAME = @"NT_WEB_NOTICE_INGAME";
extern NSString* const NT_WEB_PROMOTION_MAIN; //活动推广-在游戏开始页面显示 NT_WEB_PROMOTION_MAIN = @"NT_WEB_PROMOTION_MAIN";
extern NSString* const NT_WEB_PROMOTION_EVENT; //活动推广-指定活动菜单显示 NT_WEB_PROMOTION_EVENT = @"NT_WEB_PROMOTION_EVENT";
extern NSString* const NT_WEB_PROMOTION_ETC; //活动推广-其他菜单显示 NT_WEB_PROMOTION_ETC = @"NT_WEB_PROMOTION_ETC";
extern NSString* const NT_WEB_COUPON; //商品券 NT_WEB_COUPON = @"NT_WEB_COUPON";
extern NSString* const NT_WEB_CUSTOMER_SUPPORT_HOME;//客服-中心主页 NT_WEB_CUSTOMER_SUPPORT_HOME = @"NT_WEB_CUSTOMER_SUPPORT_HOME";
extern NSString* const NT_WEB_CUSTOMER_SUPPORT_FAQ;//客服-经常咨询的内容 NT_WEB_CUSTOMER_SUPPORT_FAQ = @"NT_WEB_CUSTOMER_SUPPORT_FAQ";
extern NSString* const NT_WEB_CUSTOMER_SUPPORT_INQUIRY;//客服-咨询 NT_WEB_CUSTOMER_SUPPORT_INQUIRY = @"NT_WEB_CUSTOMER_SUPPORT_INQUIRY";
extern NSString* const NT_WEB_CUSTOMER_SUPPORT_GUIDE;//客服-帮助指南 NT_WEB_CUSTOMER_SUPPORT_GUIDE = @"NT_WEB_CUSTOMER_SUPPORT_GUIDE";
extern NSString* const NT_WEB_CUSTOMER_SUPPORT_HISTORY;//客服-咨询历史 NT_WEB_CUSTOMER_SUPPORT_HISTORY = @"NT_WEB_CUSTOMER_SUPPORT_HISTORY";
extern NSString* const NT_WEB_GAME_REVIEW;//游戏评价 NT_WEB_GAME_REVIEW = @"NT_WEB_GAME_REVIEW";
extern NSString* const NT_WEB_FREE_CHARGEVIEW;//交叉推荐页 NT_WEB_FREE_CHARGEVIEW = @"NT_WEB_FREE_CHARGEVIEW";

extern NSString* const NT_WEB_INFO_STATE; //状态回调 NT_WEB_INFO_STATE = @"NT_WEB_INFO_STATE";
extern NSString* const NT_WEB_OPENED; //NT_WEB_OPENED = @"NT_WEB_OPENED";
extern NSString* const NT_WEB_CLOSED; //NT_WEB_CLOSED = @"NT_WEB_CLOSED";
extern NSString* const NT_WEB_FAILED;   //NT_WEB_FAILED = @"NT_WEB_FAILED";
extern NSString* const NT_WEB_REWARDED; //NT_WEB_REWARDED = @"NT_WEB_REWARDED";

/**
 *  @brief Entermate 弹出页面
 */
extern NSString* const NT_WEB_SERVICE_RULE; //服务条款 NT_WEB_SERVICE_RULE = @"NT_SERVICE_RULE";
extern NSString* const NT_WEB_PRIVACY_RULE; //隐私条款 NT_WEB_PRIVACY_RULE = @"NT_WEB_PRIVACY_RULE";

/**
 *  @brief NetMarble 关联渠道ID结果 
 *  0:OK        // 关联成功
 *  1:FAILED    // 关联失败
 *  2:NEWID     // 新关联，可供三种关联类型更新：Cancel, Update or Create
 *  3:USEDID    // 频道已经关联过，可供三种关联类型更新：Cancel, Update or Load
 *  4:MODIFIED  // 关联变更，可供两种关联类型更新：Cancel or Update
 */
extern NSString* const NT_CONNECT_RESULT; //关联或者取消关联的结果 NT_CONNECT_RESULT = @"CONNECT_RESULT";
extern NSString* const NT_DISCONNECT_RESULT; //取消关联的结果 NT_DISCONNECT_RESULT = @"DISCONNECT_RESULT";
/**
 *  @brief  NetMarble 关联的选择
 *  0:Cancel    // 取消绑定
 *  1:Update    // 更新绑定关系
 *  2:Load      // 加载旧的绑定关系
 *  3:Create    // 建立一个新的PID跟渠道ID绑定
 */
extern NSString* const NT_CONNECT_OPTION; //关联的选择 NT_CONNECT_OPTION = @"CONNECT_OPTION";


typedef NS_ENUM(int, DRPFCode) {
    DRPF_SUCCESS                = 0,
    DRPF_ERR_NO_PROJECT         = 1,
    DRPF_ERR_NO_SOURCE          = 2,
    DRPF_ERR_NO_TYPE            = 3,
    DRPF_ERR_JSON               = 4,
    DRPF_ERR_INVALID_INPUT_JSON = 5,
};

/**
 * @brief 游客服务端URL
 */
extern NSString* const UNISDK_GUEST_SERVER_URL; //UNISDK_GUEST_SERVER_URL = @"UNISDK_GUEST_SERVER_URL";
/**
 * @brief 游客是否开启解绑功能
 */
extern NSString* const ENABLE_UNISDK_GUEST_DISCONNECT; //ENABLE_UNISDK_GUEST_DISCONNECT = @"ENABLE_UNISDK_GUEST_DISCONNECT";

/**
 * @brief 游客是否开启UI功能
 */
extern NSString* const ENABLE_UNISDK_GUEST_UI; //ENABLE_UNISDK_GUEST_UI = @"ENABLE_UNISDK_GUEST_UI";

/**
 * @brief 创建订单失败（未成年充值限制）是否使用SDK提供的UI，默认使用，0为不使用
 */
extern NSString* const ENABLE_UNISDK_CREATEORDER_UI; // = "ENABLE_UNISDK_CREATEORDER_UI";

/**
* @brief 是否限制指定币种支付(计费配置黑名单)
*/
extern NSString* const ENABLE_CHECK_CURRENCY; // = "ENABLE_CHECK_CURRENCY";

/**
 * @brief 是否请求unisdk 服务端(申请订单号，访问mpay_result接口)
 */
extern NSString* const REQUEST_UNISDK_SERVER; //REQUEST_UNISDK_SERVER = @"REQUEST_UNISDK_SERVER";

/**
 * @brief unisdk请求订单url
 */
extern NSString* const UNISDK_QUERYPRODUCT_URL;  //UNISDK_QUERYPRODUCT_URL = @"UNISDK_QUERYPRODUCT_URL";

/**
 * @brief unisdk根据索引请求订单详情
 */
extern NSString* const UNISDK_GETORDERINFO_URL; //UNISDK_GETORDERINFO_URL = @"UNISDK_GETORDERINFO_URL";
/**
 * @brief unisdk请求订单url
 */
extern NSString* const UNISDK_CREATEORDER_URL; //UNISDK_CREATEORDER_URL = @"UNISDK_CREATEORDER_URL";

/**
 * @brief unisdk mpay_resutl 通知url
 */
extern NSString* const UNISDK_QUERYORDER_URL; //UNISDK_QUERYORDER_URL = @"UNISDK_QUERYORDER_URL";

/**
 * @brief unisdk consume_resutl 通知url
 */
extern NSString* const UNISDK_CONSUMEORDER_URL; //UNISDK_CONSUMEORDER_URL = @"UNISDK_CONSUMEORDER_URL";

/**
 * @brief unisdk 公钥
 */
extern NSString* const UNISDK_PUBLIC_KEY;   //UNISDK_PUBLIC_KEY = @"UNISDK_PUBLIC_KEY";

/**
 * @brief unisdk Log 服务器地址
 */
extern NSString* const UNISDK_LOG_SERVER; //UNISDK_LOG_SERVER = @"UNISDK_LOG_SERVER";

/**
 * @brief unisdk Log 开关状态
 */
extern NSString* const UNISDK_LOG_STATUS; //UNISDK_LOG_STATUS = @"UNISDK_LOG_STATUS";

/**
 * @brief 控制query product后是否自动请求苹果商品的开关，1:自动请求，0:不请求，默认自动请求
 */
extern NSString* const UNISDK_PRE_CACHE_SKPRODUCT; //UNISDK_PRE_CACHE_SKPRODUCT = @"UNISDK_PRE_CACHE_SKPRODUCT";

/**
 * Inner WebView ，默认1支持分页，0不支持分页
 */
extern NSString* const WEBVIEW_PAGE_ENABLE; 


/**
 * @brief 普通支付是否使用Gas3计费系统
 */
extern NSString* const UNISDK_JF_GAS3; //UNISDK_JF_GAS3 = @"UNISDK_JF_GAS3";

/**
 * @brief 扫码支付是否使用Gas3计费系统
 */
extern NSString* const UNISDK_JF_GAS3_WEB; //UNISDK_JF_GAS3_WEB = @"UNISDK_JF_GAS3_WEB";

/**
 * @brief 计费Gas3系统的域名URL
 */

extern NSString* const UNISDK_JF_GAS3_URL; //UNISDK_JF_GAS3_URL = @"UNISDK_JF_GAS3_URL";

/**
 * @brief 计费UniServer系统的域名URL
 */
extern NSString* const UNISDK_JF_UNISERVER_URL; //UNISDK_JF_UNISERVER_URL = @"UNISDK_JF_UNISERVER_URL";

extern NSString* const UNISDK_DEVICE_ID; //UNISDK_DEVICE_ID = @"UNISDK_DEVICE_ID";
extern NSString* const UNISDK_FIRST_DEVICE_ID; //UNISDK_FIRST_DEVICE_ID = @"UNISDK_FIRST_DEVICE_ID";

/**
 * @brief 计费防沉迷 aim_info
 */
extern NSString* const JF_AIM_INFO;

/**
 * @brief 计费OAuth2.0授权安全功能访问令牌。如果等于字符串sdk_token，请从sdk_token字段中取令牌
 */
extern NSString* const UNISDK_JF_ACCESS_TOKEN;

/**
 * @brief 计费OAuth2.0授权安全功能刷新令牌
 */
extern NSString* const UNISDK_JF_REFRESH_TOKEN;


/**
 * @brief Server time 与 本地时间的差值。本地时间 + diff 可以获得真实时间
 */
extern NSString* const UNISDK_TIME_DIFF;

/**
 * @brief DRPF的域名URL
 */
extern NSString* const UNISDK_DRPF_URL; //UNISDK_DRPF_URL = @"UNISDK_DRPF_URL";

/**
 * @brief 苹果广告归因 DRPF的域名URL
 */
extern NSString* const UNISDK_ASA_DRPF_URL; //UNISDK_ASA_DRPF_URL = @"UNISDK_ASA_DRPF_URL";

/**
 * @brief DRPF的project
 */
extern NSString* const UNISDK_DRPF_PROJECT; //UNISDK_DRPF_PROJECT = @"UNISDK_DRPF_PROJECT";


//位置服务的服务器URL地址
extern NSString* const UNISDK_LBS_URL; //UNISDK_LBS_URL = @"UNISDK_LBS_URL";

/**
 * UNISDK_QRCODE_FILE参数为空（null或者""），表示直接打开摄像头，有值的话:打开系统相册UNISDK_QRCODE_FILE=unisdk:recognize；直接识别图片UNISDK_QRCODE_FILE=unisdk:xxx.png(xxx.png是正确的图片路径)
 */
extern NSString* const UNISDK_QRCODE_FILE; //UNISDK_QRCODE_FILE = @"UNISDK_QRCODE_FILE";

/**
 * @brief 海外域名开关，国外1，国内其它
 */
extern NSString* const EB; //EB = @"EB";

/**
 * @brief 设置一些额外的信息
 */
extern NSString* const UNISDK_EXT_INFO; //UNISDK_EXT_INFO = @"UNISDK_EXT_INFO";

/**
 * @brief unipatch dex地址(安卓的变量，为了保持统一，使用这个变量)
 * 字符串传递
 */
extern NSString* const UNISDK_UNIPATCH_CHECK_URL; //UNISDK_UNIPATCH_CHECK_URL = @"UNISDK_UNIPATCH_CHECK_URL";

/**
 * @brief unipatch log地址(安卓的变量，为了保持统一，使用这个变量)
 * 字符串传递
 */
extern NSString* const UNISDK_UNIPATCH_LOG_URL; //UNISDK_UNIPATCH_LOG_URL = @"UNISDK_UNIPATCH_LOG_URL";

/**
 * @brief unisdk 跟计费交互的https请求的超时时间
 * 字符串传递
 */
extern NSString* const UNISDK_JF_TIMEOUT; //UNISDK_JF_TIMEOUT = @"UNISDK_JF_TIMEOUT";

/**
 * @brief client log 海外发送地址(安卓的变量，为了保持统一，使用这个变量)
 * 字符串传递
 */
extern NSString* const JF_OVERSEA_CLIENT_LOG_URL; //JF_OVERSEA_CLIENT_LOG_URL = @"JF_OVERSEA_CLIENT_LOG_URL";
extern NSString* const JF_OVERSEA_OPEN_LOG_URL; //JF_OVERSEA_OPEN_LOG_URL = @"JF_OVERSEA_OPEN_LOG_URL";
extern NSString* const JF_OVERSEA_FF_LOG_URL; //JF_OVERSEA_FF_LOG_URL = @"JF_OVERSEA_FF_LOG_URL";

/**
 * @brief 是否启用WEB支付方式 (Mobithink使用)
 */
extern NSString* const NT_WEBFF_MODE; //NT_WEBFF_MODE = @"WEBFF_MODE";

/**
 * @brief WEB支付URL (Mobithink使用)
 */
extern NSString* const NT_WEBFF_URL;    //NT_WEBFF_URL = @"WEBFF_URL";

/**
 *  @brief  收费凭证（@"0"表示用旧的Receipt接口,@"1"表示用新的Receipt接口）
 */
extern NSString* const NT_RECEIPT_TYPE; //NT_RECEIPT_TYPE = @"RECEIPT_TYPE";

/**
 *  @brief  publicKeyUrl （GameCenter功能）
 */
extern NSString* const NT_PUBLICKEY_URL; //NT_PUBLICKEY_URL = @"PUBLICKEY_URL";

/**
 *  @brief  salt （GameCenter功能）
 */
extern NSString* const NT_SALT; //NT_SALT = @"SALT";

/**
 *  @brief  玩家角色类型ID (网易SDK)
 */
extern NSString* const NT_USERINFO_TYPEID; //NT_USERINFO_TYPEID = @"USERINFO_TYPEID";
extern NSString* const NT_USERINFO_ROLE_TYPE_ID; //兼容安卓 NT_USERINFO_ROLE_TYPE_ID = @"USERINFO_ROLE_TYPE_ID";

/**
 *  @brief  玩家角色类型名称（以梦幻西游为例，剑侠客、骨精灵等等，用于区分不同的角色形象） (网易SDK)
 */
extern NSString* const NT_USERINFO_TYPENAME; //NT_USERINFO_TYPENAME = @"USERINFO_TYPENAME";
extern NSString* const NT_USERINFO_ROLE_TYPE_NAME; //兼容安卓 NT_USERINFO_ROLE_TYPE_NAME = @"USERINFO_ROLE_TYPE_NAME";

/**
 *  @brief  玩家角色门派ID (网易SDK)
 */
extern NSString* const NT_USERINFO_MENPAIID; //NT_USERINFO_MENPAIID = @"USERINFO_MENPAIID";
extern NSString* const NT_USERINFO_MENPAI_ID; //兼容安卓 NT_USERINFO_MENPAI_ID = @"USERINFO_MENPAI_ID";

/**
 *  @brief  玩家角色门派名称（以梦幻西游为例，大唐官府、龙宫等等，用于区分不同的门派） (网易SDK)
 */
extern NSString* const NT_USERINFO_MENPAINAME; //NT_USERINFO_MENPAINAME = @"USERINFO_MENPAINAME";
extern NSString* const NT_USERINFO_MENPAI_NAME; //兼容安卓 NT_USERINFO_MENPAI_NAME = @"USERINFO_MENPAI_NAME";

/**
 *  @brief  玩家角色战力 (网易SDK)
 */
extern NSString* const NT_USERINFO_CAPABILITY; //NT_USERINFO_CAPABILITY = @"USERINFO_CAPABILITY";

/**
 *  @brief  玩家角色帮派ID (网易SDK)
 */
extern NSString* const NT_USERINFO_GANDID;      //NT_USERINFO_GANDID = @"USERINFO_GANDID";
extern NSString* const NT_USERINFO_GANG_ID;  //兼容安卓 NT_USERINFO_GANG_ID = @"USERINFO_GANG_ID";

/**
 *  @brief  玩家角色帮派名称 (网易SDK)
 */
extern NSString* const NT_USERINFO_GAND; //NT_USERINFO_GAND = @"USERINFO_GAND";

/**
 *  @brief  玩家角色服务器区域ID (网易SDK)
 */
extern NSString* const NT_USERINFO_REGION_ID; //NT_USERINFO_REGION_ID = @"USERINFO_REGION_ID";

/**
 *  @brief  玩家角色服务器区域名字 (网易SDK)
 */
extern NSString* const NT_USERINFO_REGION;  //NT_USERINFO_REGION = @"USERINFO_REGION";
extern NSString* const NT_USERINFO_REGION_NAME; //NT_USERINFO_REGION_NAME = @"USERINFO_REGION_NAME";

/**
 *  @brief  玩家角色信息，自定义部分 (网易SDK)
 */
extern NSString* const NT_USERINFO_OTHERS; //NT_USERINFO_OTHERS = @"USERINFO_OTHERS";


/**
 *  @brief  IAP支付的ReceiptData的Key值 ! 请不要修改值的内容!
 *  key是跟计费协商定好的。
 */
extern NSString* const NT_KEY_RECEIPTDATA; //NT_KEY_RECEIPTDATA = @"NtReceiptData";
extern NSString* const NT_KEY_ORIG_TRANSACTIONID; //NT_KEY_ORIG_TRANSACTIONID = @"NtOrigTransactionId";
extern NSString* const NT_KEY_TRANSACTIONID;    //NT_KEY_TRANSACTIONID = @"NtTransactionId";
extern NSString* const NT_KEY_PRODUCTID;        //NT_KEY_PRODUCTID = @"NtProductId";
extern NSString* const NT_KEY_VERSION;          //NT_KEY_VERSION = @"NtVersion";

/**
 *  @brief  域名 (Helpshift SDK与netease_global v2.4.0版本开始使用)
 */
extern NSString* const NT_DOMAIN;   //NT_DOMAIN = @"DOMAIN";

/**
 * @brief 用户邮箱(Helpshift SDK)
 */
extern NSString* const NT_EMAIL;    //NT_EMAIL = @"EMAIL";

/**
 * @brief 用户邮箱(Facebook SDK)
 */
extern NSString* const NT_UEMAIL;   //NT_UEMAIL = @"UEMAIL";

/**
 * @brief 用户性别(Facebook SDK)
 */
extern NSString* const NT_UGENDER;  //NT_UGENDER = @"UGENDER";

/**
 * @brief 用户生日(Facebook SDK)
 */
extern NSString* const NT_UBIRTHDAY;    //NT_UBIRTHDAY = @"UBIRTHDAY";

/**
 * @brief 用户地区(Facebook SDK)
 */
extern NSString* const NT_UHOMETOWN;    //NT_UHOMETOWN = @"UHOMETOWN";

/**
 * @brief 用户age(Facebook SDK)
 */
extern NSString* const NT_UAGE;     //NT_UAGE = @"UAGE";

/**
 * @brief 获取渠道原生UID(Joybomb SDK)
 */
extern NSString* const CHANNEL_UID;//建议使用带NT开头的变量名 CHANNEL_UID = @"CHANNEL_UID";
extern NSString* const NT_CHANNEL_UID;  //NT_CHANNEL_UID = @"CHANNEL_UID";
extern NSString* const NT_FB_UID; // Facebook UID NT_FB_UID = @"FB_UID";
extern NSString* const NT_FB_SESSION; // Facebook access token NT_FB_SESSION = @"FB_SESSION";
extern NSString* const NT_USER_ID;// G+ UID NT_USER_ID = @"USER_ID";

/**
 * @brief 为支持未接入计费系统的游戏的支付对账, 上传首次打开游戏日志到计费指定的地址
 */
extern NSString* const NT_JF_OPEN_LOG_URL; //NT_JF_OPEN_LOG_URL = @"JF_OPEN_LOG_URL";

/**
 * @brief 为支持未接入计费系统的游戏的支付对账, 上传单机版充值日志到计费指定的地址
 */
extern NSString* const NT_JF_FF_LOG_URL; //NT_JF_FF_LOG_URL = @"JF_FF_LOG_URL";
/**
 * @brief client log 地址（用于海外版设置）
 */
extern NSString* const NT_JF_CLIENT_LOG_URL; //NT_JF_CLIENT_LOG_URL = @"JF_CLIENT_LOG_URL";

/**
 * @brief 为支持未接入计费系统的游戏的支付对账, 上传单机版充值日志和首次打开游戏日志到计费时需要的AES key
 */
extern NSString* const NT_JF_LOG_KEY; //NT_JF_LOG_KEY = @"JF_LOG_KEY";
extern NSString* const NT_JF_CLIENT_KEY; //NT_JF_CLIENT_KEY = @"JF_CLIENT_KEY";

/**
 * @brief 计费为手游分配的ID
 */
extern NSString* const NT_JF_GAMEID; //NT_JF_GAMEID = @"JF_GAMEID";
/**
 * @brief 项目GameID
 */
extern NSString* const NT_XM_GAMEID; //NT_XM_GAMEID = @"XM_GAMEID";

extern NSString* const NT_DETECT_GAMEID;  //NT_DETECT_GAMEID = @"DETECT_GAMEID"

extern NSString* const NT_ENGINE_VERSION;

extern NSString* const NT_RESOURCE_VERSION;

/**
 * @brief 运营GameID
 */
extern NSString* const NT_YY_GAMEID; //NT_YY_GAMEID = @"YY_GAMEID";
/**
 * @brief 游戏是否在计费配置有支付回调
 */
extern NSString* const NT_HAS_FF_CB; //NT_HAS_FF_CB = @"HAS_FF_CB";

/**
 * @brief 游戏配置支付回调
 */
extern NSString* const NT_FF_CB_URL; //NT_FF_CB_URL = @"FF_CB_URL";

/**
 * @defgroup Swrve相关
 * @brief Swrve相关
 * @{
 */
extern NSString* const NT_SWRVE_FUNC; //NT_SWRVE_FUNC = @"SWRVE_FUNC";

extern NSString* const NT_SWRVE_FUNC_EVENT; //NT_SWRVE_FUNC_EVENT = @"SWRVE_FUNC_EVENT";
extern NSString* const NT_SWRVE_EVENT_NAME; //NT_SWRVE_EVENT_NAME = @"SWRVE_EVENT_NAME";
extern NSString* const NT_SWRVE_EVENT_PAYLOAD; //NT_SWRVE_EVENT_PAYLOAD = @"SWRVE_EVENT_PAYLOAD";

extern NSString* const NT_SWRVE_FUNC_PURCHASE; //NT_SWRVE_FUNC_PURCHASE = @"SWRVE_FUNC_PURCHASE";
extern NSString* const NT_SWRVE_PURCHASE_ITEM; //NT_SWRVE_PURCHASE_ITEM = @"SWRVE_PURCHASE_ITEM";
extern NSString* const NT_SWRVE_PURCHASE_CURRENCY; //NT_SWRVE_PURCHASE_CURRENCY = @"SWRVE_PURCHASE_CURRENCY";
extern NSString* const NT_SWRVE_PURCHASE_COST; //NT_SWRVE_PURCHASE_COST = @"SWRVE_PURCHASE_COST";
extern NSString* const NT_SWRVE_PURCHASE_QUANTITY; //NT_SWRVE_PURCHASE_QUANTITY = @"SWRVE_PURCHASE_QUANTITY";

extern NSString* const NT_SWRVE_FUNC_CURRENCYGIVEN; //NT_SWRVE_FUNC_CURRENCYGIVEN = @"SWRVE_FUNC_CURRENCYGIVEN";
extern NSString* const NT_SWRVE_CURRENCYGIVEN_CURRENCY; //NT_SWRVE_CURRENCYGIVEN_CURRENCY = @"SWRVE_CURRENCYGIVEN_CURRENCY";
extern NSString* const NT_SWRVE_CURRENCYGIVEN_AMOUNT; //NT_SWRVE_CURRENCYGIVEN_AMOUNT = @"SWRVE_CURRENCYGIVEN_AMOUNT";

extern NSString* const NT_SWRVE_FUNC_IAP; //NT_SWRVE_FUNC_IAP = @"SWRVE_FUNC_IAP";
extern NSString* const NT_SWRVE_IAP_REWARDS; //NT_SWRVE_IAP_REWARDS = @"SWRVE_IAP_REWARDS";

extern NSString* const NT_SWRVE_FUNC_USERUPDATE; //NT_SWRVE_FUNC_USERUPDATE = @"SWRVE_FUNC_USERUPDATE";
extern NSString* const NT_SWRVE_USERUPDATE_ATTRIBUTES; //NT_SWRVE_USERUPDATE_ATTRIBUTES = @"SWRVE_USERUPDATE_ATTRIBUTES";

extern NSString* const NT_SWRVE_RESOURCE; //NT_SWRVE_RESOURCE = @"SWRVE_RESOURCE";
/** @} */

/**
 * @defgroup 回调是传递，与Android统一
 * @{
 */

extern NSString* const NT_CALLBACK_MESSAGE; //NT_CALLBACK_MESSAGE = @"NT_CALLBACK_MESSAGE";

/**
 * @defgroup 用户协议配置的URL，与Android统一
 * @brief
 * @{
 */
extern NSString* const NT_COMPACT_URL;// = @"COMPACT_URL";
extern NSString* const NT_COMPACT_LAN;// = @"COMPACT_LAN";
extern NSString* const NT_COMPACT_SHOW_AGREE_LINE;// = @"COMPACT_SHOW_AGREE_LINE";
extern NSString* const NT_COMPACT_AGREE_LINE_TEXT;// = @"COMPACT_AGREE_LINE_TEXT";
extern NSString* const NT_COMPACT_LOCALE;// = @"NT_COMPACT_LOCALE";
extern NSString* const NT_COMPACT_HIDE_LOGO;// = @"COMPACT_HIDE_LOGO";
extern NSString* const NT_COMPACT_CLASSLIST_HOST;// = @"COMPACT_CLASSLIST_HOST";
extern NSString* const NT_COMPACT_CLASSUPLOAD_HOST;// = @"COMPACT_CLASSUPLOAD_HOST";
extern NSString* const NT_COMPACT_LAUNCH_NATIVE;// = @"COMPACT_LAUNCH_NATIVE";

/**
 *  计费登录的字符串参数
 */
extern NSString* const NT_SAUTH_STR; //NT_SAUTH_STR = @"SAUTH_STR";
extern NSString* const NT_SAUTH_JSON; //NT_SAUTH_JSON = @"SAUTH_JSON";

/**
 * @brief 免流SDK
 */
extern NSString* const NT_FLOW_CODE; //NT_FLOW_CODE = @"FLOW_CODE";
extern NSString* const NT_FLOW_KEY; //NT_FLOW_KEY = @"FLOW_KEY";
extern NSString* const NT_USERINFO_NUMBER; //NT_USERINFO_NUMBER = @"USERINFO_NUMBER";


/**
 * @brief SDK服务端URL
 */
extern NSString* const NT_SDK_SERVER_URL; //NT_SDK_SERVER_URL = @"SDK_SERVER_URL";


/**
 * @brief SDK渠道的CHANNEL ID （7rd渠道用到）
 */
extern NSString* const NT_SDK_CHANNEL_ID; //NT_SDK_CHANNEL_ID = @"SDK_CHANNEL_ID";

/**
 * @brief NT_SDK_NEW_ROLE标识此角色是否为新创建 0不是 1是 （7rd渠道用到）
 */
extern NSString* const NT_SDK_NEW_ROLE; //NT_SDK_NEW_ROLE = @"SDK_NEW_ROLE";


/**
 * @defgroup SDC_LOG_XXX
 * @brief 返回通过UNISDK可以获取的SDC所需要的参数
 * @{
 */
extern NSString* const NT_SDC_LOG_DEVICE_HEIGHT ;//= @"SDC_LOG_DEVICE_HEIGHT";
extern NSString* const NT_SDC_LOG_DEVICE_WIDTH ;//= @"SDC_LOG_DEVICE_WIDTH";
/**
 * @brief 操作系统，直接通过系统提供API返回的字符串，如ios, android, windows, ubuntu, symbian等
 * */
extern NSString* const NT_SDC_LOG_OS_NAME ;//= @"SDC_LOG_OS_NAME";
/**
 * @brief 操作系统版本，设备操作系统版本号 如：6.1, 2.3等
 * */
extern NSString* const NT_SDC_LOG_OS_VER ;//= @"SDC_LOG_OS_VER";
/**
 * @brief 设备mac地址   如08:00:20:0A:8C:6D
 * */
extern NSString* const NT_SDC_LOG_MAC_ADDR ;//= @"SDC_LOG_MAC_ADDR";
/**
 * 直接获取通过系统提供API返回的设备制造商, 设备型号, CPU名称, CPU核心数, CPU频率,
 * GPU名称字符串，并使用分割符号#进行拼接。
 */
extern NSString* const NT_SDC_LOG_DEVICE_MODEL ;//= @"SDC_LOG_DEVICE_MODEL";
/**
 * @brief 设备UDID号, 具体参见关于UDID说明章节，用于统计设备数
 * */
extern NSString* const NT_SDC_LOG_UDID ;//= @"SDC_LOG_UDID";
/**
 * @brief 运营渠道，如app_store/ 91_assistant/netease等，目前直接取已有的APP_CHANNEL字段
 * */
extern NSString* const NT_SDC_LOG_APP_CHANNEL ;//= @"SDC_LOG_APP_CHANNEL";
/**
 * @brief 客户端版本号，安卓目前从manifest里面读取, iOS则是读info.plist中的设置
 * */
extern NSString* const NT_SDC_LOG_APP_VER ;//= @"SDC_LOG_APP_VER";
/**
 * @brief 网络连接，例如有  3g, 2.5g, 4g, wifi几种
 * */
extern NSString* const NT_SDC_LOG_APP_NETWORK ;//= @"SDC_LOG_APP_NETWORK";
/**
 * @brief 网络运营商，如果可以获取IMSI（安卓或越狱IOS）则记录IMSI编码即可。
 *	非越狱IOS记录mobile country code (MCC)+ mobile network code (MNC)
 *	（IOS见CTCarrier Class）MCC是固定3位 MNC是2位或者3位，如果MCC=480 MNC=20，则记录为48020
 */
extern NSString* const NT_SDC_LOG_APP_ISP ;//= @"SDC_LOG_APP_ISP";
/**
 * @brief 系统语言 例如 zh_CN
 */
extern NSString* const NT_SDC_LOG_SYSTEMLANGUAGE ;//= @"SDC_LOG_SYSTEMLANGUAGE";
/**
 * @brief 通过SIM卡获取国家码 例如 CN
 */
extern NSString* const NT_SDC_LOG_SIM_COUNTRY ;//= @"SDC_LOG_SIM_COUNTRY";

/**
 * @brief 用户协议用到
 */
extern NSString* const NT_SDK_COMPACT_MODE; //NT_SDK_COMPACT_MODE = @"SDK_COMPACT_MODE";

/**
 * @brief 网易SDK主题资源文件名
 */
extern NSString* const NT_SKIN_TYPE; //NT_SKIN_TYPE = @"SKIN_TYPE";


extern NSString* const NT_MIGRATE_CODE_LOGIN; //网易SDK海外版引继码登录 NT_MIGRATE_CODE_LOGIN = @"MIGRATE_CODE_LOGIN";

extern NSString* const NT_SDK_SWITCHER_URL; //NT_SDK_SWITCHER_URL = @"SDK_SWITCHER_URL";
extern NSString* const NT_SDK_SWITCHER_URL_PROJECT; //NT_SDK_SWITCHER_URL_PROJECT = @"SDK_SWITCHER_URL_PROJECT";
extern NSString* const NT_SDK_SWITCHER_DATA; //NT_SDK_SWITCHER_DATA = @"SDK_SWITCHER_DATA";

static NSString *const NT_LANGUAGE_CODE = @"LANGUAGE_CODE"; //语言的key
static NSString *const NT_LANGUAGE_CODE_ZH_CN = @"ZH_CN";   //中文
static NSString *const NT_LANGUAGE_CODE_ZH_HK = @"ZH_HK";   //香港繁体
static NSString *const NT_LANGUAGE_CODE_ZH_TW = @"ZH_TW";   //台湾繁体
static NSString *const NT_LANGUAGE_CODE_EN = @"EN";         //英文
static NSString *const NT_LANGUAGE_CODE_ES_EUR = @"ES_EUR";
static NSString *const NT_LANGUAGE_CODE_ES = @"ES";             // 西班牙文 (西班牙)
static NSString *const NT_LANGUAGE_CODE_PT_EUR = @"PT_EUR";
static NSString *const NT_LANGUAGE_CODE_PT = @"PT";         // 葡萄牙文 (葡萄牙)
static NSString *const NT_LANGUAGE_CODE_AR = @"AR";         // 阿拉伯文 (阿拉伯联合酋长国)
static NSString *const NT_LANGUAGE_CODE_DE = @"DE";         // 德文 (德国)
static NSString *const NT_LANGUAGE_CODE_FR = @"FR";         // 法文 (法国)
static NSString *const NT_LANGUAGE_CODE_IN = @"IN";         // 印度尼西亚（印度尼西亚）
static NSString *const NT_LANGUAGE_CODE_IT = @"IT";         // 意大利（意大利)
static NSString *const NT_LANGUAGE_CODE_JA = @"JA";         // 日文
static NSString *const NT_LANGUAGE_CODE_KO = @"KO";         // 韩文
static NSString *const NT_LANGUAGE_CODE_MS = @"MS";         // 马来西亚(马来西亚)
static NSString *const NT_LANGUAGE_CODE_NL = @"NL";         // 荷兰文 (荷兰)
static NSString *const NT_LANGUAGE_CODE_RU = @"RU";         // 俄文 (俄罗斯)
static NSString *const NT_LANGUAGE_CODE_TH = @"TH";         // 泰文 (泰国)
static NSString *const NT_LANGUAGE_CODE_VI = @"VI";         // 越南
static NSString *const NT_LANGUAGE_CODE_TR = @"TR";         // 土耳其
static NSString *const NT_LANGUAGE_CODE_HI = @"HI";         // 印地语（印度）
static NSString *const NT_LANGUAGE_CODE_AUTO = @"AUTO";     // 默认

static NSString *const NT_AAS_HOSTID_REGION = @"AAS_HOSTID_REGION"; // 地区，https://en.wikipedia.org/wiki/ISO_3166-1
static NSString *const NT_AAS_LANGUAGE = @"AAS_LANGUAGE"; // 语言，https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes


/**
 * @brief 用户游戏全生命周期定义为用户从打开游戏到退出游戏 SDK增加用户游戏全生命周期的transid
 */
extern NSString* const NT_TRANS_ID; //NT_TRANS_ID = @"TRANS_ID";
extern NSString* const NT_ECHOES_DUMPID; //NT_ECHOES_DUMPID = @"ECHOES_DUMPID";
extern NSString* const NT_IS_BRIDGE_GUEST_LOGIN; //NT_IS_BRIDGE_GUEST_LOGIN = @"is_guest_login";

/**
 * @brief 用于在问卷推送时, 能协助判断玩家语言，提高填答率和用户体验
 */
extern NSString* const NT_GAME_SELECT_LANGUAGE; // 游戏当前选择的语言
extern NSString* const NT_GAME_SUPPORT_LANGUAGE; // 游戏支持的语言

extern NSString* const SOURCE_APP_CHANNEL; //=@"SOURCE_APP_CHANNEL"
extern NSString* const SOURCE_PLATFORM; //=@"SOURCE_PLATFORM"

/**
 * @brief 是否只使用快速分享
 */
extern NSString* const NT_SHARE_WITH_COMPAT;

/**
 * @brief 型号
 */
extern NSString* const NT_DEVICE_INFO_MODEL;

/**
 * @brief 系统版本
 */
extern NSString* const NT_DEVICE_INFO_RELEASE;

/**
 * @brief 总内存空间(单位bytes)
 */
extern NSString* const NT_DEVICE_INFO_TOTAL_MEMORY;

/**
 * @brief 剩余内存空间(单位bytes)
 */
extern NSString* const NT_DEVICE_INFO_FREE_MEMORY;

/**
 * @brief 总存储空间(单位bytes)
 */
extern NSString* const NT_DEVICE_INFO_TOTAL_INTERNAL_MEMORY;

/**
 * @brief 剩余存储空间(单位bytes)
 */
extern NSString* const NT_DEVICE_INFO_AVAILABLE_INTERNAL_MEMORY;

/**
 * @brief 设备标识
 */
extern NSString* const NT_DEVICE_INFO_FINGERPRINT;

/**
 * @brief CPU位数
 */
extern NSString* const NT_DEVICE_INFO_ARCH_TYPE;

/**
 * @brief CPU类型
 */
extern NSString* const NT_DEVICE_INFO_CPU_TYPE;

/**
 * @brief CPU核数
 */
extern NSString* const NT_DEVICE_INFO_CPU_CORES_COUNT;

/**
 * @brief CPU最小频率
 * iOS禁止获取到最小频率，默认使用主频
 */
extern NSString* const NT_DEVICE_INFO_CPU_MIN_FREQ_KHZ;

/**
 * @brief CPU最大频率
 * iOS禁止获取到最大频率，默认使用主频
 */
extern NSString* const NT_DEVICE_INFO_CPU_MAX_FREQ_KHZ;

/**
 * @brief GPU 型号
 */
extern NSString* const NT_DEVICE_INFO_GL_RENDERER;

/**
 * @brief GPU制作商
 */
extern NSString* const NT_DEVICE_INFO_GL_VENDOR;

/**
 * @brief GPU 版本
 */
extern NSString* const NT_DEVICE_INFO_GL_VERSION;

/**
 * @brief 屏幕分辨率
 */
extern NSString* const NT_DEVICE_INFO_SCREEN_RESOLUTION;

/**
 * @brief 屏幕尺寸(单位英寸)
 */
extern NSString* const NT_DEVICE_INFO_SCREEN_INCH;

/**
 * @brief 屏幕像素密度 ppi
 */
extern NSString* const NT_DEVICE_INFO_SCREEN_PIXEL;

/**
 * @brief 是否具备 加速度传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_ACCELEROMETER;

/**
 * @brief 是否具备 磁力传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_MAGNETIC_FIELD;

/**
 * @brief 是否具备 方向传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_ORIENTATION;

/**
 * @brief 是否具备 陀螺仪传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_GYROSCOPE;

/**
 * @brief 是否具备 光线感应传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_LIGHT;

/**
 * @brief 是否具备 压力传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_PRESSURE;

/**
 * @brief 是否具备 距离传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_PROXIMITY;

/**
 * @brief 是否具备 重力传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_GRAVITY;

/**
 * @brief 是否具备 线性加速度传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_LINEAR_ACCELERATION;

/**
 * @brief 是否具备 旋转矢量传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_ROTATION_VECTOR;

/**
 * @brief 步行检测传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_STEP_DETECTOR;

/**
 * @brief 计步传感器
 */
extern NSString* const NT_DEVICE_INFO_IS_SUPPORT_STEP_COUNTER;

/**
 * @brief 本机cpu性能分数
 */
extern NSString* const NT_DEVICE_INFO_PERFORMANCE_SCORE;

/**
 * @brief cpu性能分数总表范围
 */
extern NSString* const NT_DEVICE_INFO_PERFORMANCE_SCORE_RANGE;

/**
 * @brief 曾用名列表，通过getProp获取
 */
extern NSString* const NT_US_USED_NAMES; // NT_US_USED_NAMES = @"US_USED_NAMES";

/**
 * @brief 获取曾用名的必选参数，产品向US申请appId，然后通过setProp设置
 */
extern NSString* const NT_US_APP_ID; // NT_US_APP_ID = @"US_APP_ID";

/**
 * @brief 获取曾用名的必选参数，产品向US申请appSecret，然后通过setProp设置
 */
extern NSString* const NT_US_APP_SECRET; // NT_US_APP_SECRET = @"US_APP_SECRET";

/**
 * @brief 获取曾用名的可选参数，产品可以通过此参数设置访问US的测试环境
 */
extern NSString* const NT_US_URL; // NT_US_URL = @"US_URL";

/**
 * @brief 获取曾用名的可选参数，只获取随机名，通过setProp设置
 */
extern NSString* const NT_US_ONLY_RANDOM_NAMES; // NT_US_ONLY_RANDOM_NAMES = @"US_ONLY_RANDOM_NAMES";

/**
 * @brief 获取曾用名的可选参数，随机名地区，通过setProp设置
 */
extern NSString* const NT_US_REGION; // NT_US_REGION = @"US_REGION";

/**
 * @brief 获取曾用名的可选参数，通过setProp设置
 */
extern NSString* const NT_US_MAX_NAME_SIZE; // NT_US_MAX_NAME_SIZE = @"US_MAX_NAME_SIZE";

/**
 * @brief 获取防沉迷版本号，通过getPropStr获取
 */
extern NSString* const NT_AAS_VERSION; // NT_AAS_VERSION = @"AAS_VERSION";

/**
 * @brief 是否禁止SDK自动弹出防沉迷超时弹窗, 0:不禁止   1:禁止
 */
extern NSString* const NT_DISABLE_AUTO_TIMEOUT_ALERT; // NT_DISABLE_AUTO_TIMEOUT_ALERT = @"DISABLE_AUTO_TIMEOUT_ALERT";

/**
 * @brief 计费 jelly 防沉迷系统规则域名rulesHost, 字符串传递
 */
extern NSString* const NT_UNISDK_JF_RULES_HOST; // NT_UNISDK_JF_RULES_HOST = @"UNISDK_JF_RULES_HOST";

/**
 * @brief 产品透传给计费的cid内容，用于防沉迷功能，sdk透传
*/
extern NSString* const NT_UNISDK_JF_EXT_CID; // NT_UNISDK_JF_EXT_CID = @"UNISDK_JF_EXT_CID";

/**
 * @brief 标识每次登录，暂无用处
 */
extern NSString* const NT_CLIENT_LOGIN_SN; // NT_CLIENT_LOGIN_SN = @"CLIENT_LOGIN_SN";

/**
 * @brief 是否需要防沉迷  1，表示当前需要防沉迷； 0，表示当前不需要防沉迷
*/
extern NSString* const NT_NEED_AAS; // NT_NEED_AAS = @"NEED_AAS";

/**
 * @brief 标识是否是暴雪包,开启NgBlizzard辅助库功能  1，标识为暴雪包
*/
extern NSString* const NT_ENABLE_BLIZZARD; // NT_ENABLE_BLIZZARD = @"ENABLE_BLIZZARD";

/**
 * @brief 暴雪AppId
*/
extern NSString* const NT_BLIZZARD_APPID; // NT_BLIZZARD_APPID = @"BLIZZARD_APPID";

/**
 * @brief 暴雪region id
*/
extern NSString* const NT_BLIZZARD_REGION_ID; // NT_BLIZZARD_REGION_ID = @"BLIZZARD_REGION_ID";

/*
 * @brief 暴雪 account id
 */
extern NSString* const NT_BLIZZARD_ACCOUNT_ID; // NT_BLIZZARD_ACCOUNT_ID = @"BLIZZARD_ACCOUNT_ID";

/**
 * @brief 手机号一键登录 Bussiness ID
*/
extern NSString* const NT_ONE_PASSID; // NT_ONE_PASSID = @"ONE_PASSID";

/**
 * @brief 互联登录使用的  Access Group
 */

extern NSString *const KEYCHAIN_ACCESS_GROUP; // KEYCHAIN_ACCESS_GROUP = @"KEYCHAIN_ACCESS_GROUP";

/**
 * @brief Universal link 调起App的 url
*/
extern NSString* const NT_DEEP_LINK_WHOLE_URI; // NT_DEEP_LINK_WHOLE_URI = @"DEEP_LINK_WHOLE_URI";

/**
 * @brief App是否由Universal link 唤起
*/
extern NSString* const NT_DEEP_LINK_FROM_LAUNCH; // NT_DEEP_LINK_FROM_LAUNCH = @"DEEP_LINK_FROM_LAUNCH";

/**
 * @brief 是否禁用扫一扫闪光灯
*/
extern NSString* const NT_HIDE_QRCODE_FLASH_BTN; // NT_HIDE_QRCODE_FLASH_BTN = @"HIDE_QRCODE_FLASH_BTN";

/**
 * @brief 是否禁用扫一扫相册
*/
extern NSString* const NT_HIDE_QRCODE_ALBUM_BTN; // NT_HIDE_QRCODE_ALBUM_BTN = @"HIDE_QRCODE_ALBUM_BTN";

/**
 * @brief 是否使用快捷浮窗扫码功能（读取相册最新照片进行扫描二维码）
*/
extern NSString* const NT_ENABLE_POPUP_QR_PIC; // NT_ENABLE_POPUP_QR_PIC = @"ENABLE_POPUP_QR_PIC";

/**
 * @brief 隐私协议是否在启动时候弹出
*/
extern NSString* const NT_PROTOCOL_LAUNCHER; // NT_PROTOCOL_LAUNCHER = @"PROTOCOL_LAUNCHER";


/**
 * @brief 隐私协议的发行商
*/
extern NSString* const NT_PUBLISHER; // NT_PUBLISHER = @"PUBLISHER";


#pragma mark- 问卷调查和快捷反馈
/**
 * @brief WebView使用模式
 * "1"表示走NgWebViewSDK，null或是"0"表示走母包InnerWebView
 * 值类型:String
 */
extern NSString* const NT_WEBVIEW_MODE;


/********** 历史字段  **********/
/**
 * @brief 调查问卷用到，打开的webview的背景颜色
 * "0" 白色 (默认)， "1" 透明
 * 值类型:String
 */
extern NSString* const NT_WEBVIEW_BKCOLOR;

/**
 *  是否显示关闭按钮, "0"隐藏，默认隐藏 "1"显示
 *  值类型:String
 */
extern NSString* const NT_WEBVIEW_CLBTN;

/**
 *  是否全屏, "0"不全屏，默认问卷尺寸 "1"全屏
 *  值类型:String
 */
extern NSString* const NT_WEBVIEW_FULLFIT;

/**
 *  是否”强制“显示问卷调查, "0"不强制，默认问卷尺寸 "1"强制显示
 *  值类型:String
 */
extern NSString* const NT_WEBVIEW_FORCE_OPEN;


/**
 * @brief 是否自动申请IDFA权限(iOS 14+)
 */
extern NSString *const NT_IDFA_PERMISSION; // NT_IDFA_PERMISSION = @"IDFA_PERMISSION";

/**
 * @brief 海外版儿童保护状态
 */
extern NSString *const NT_MINOR_STATUS; // NT_MINOR_STATUS = @"MINOR_STATUS";

/**
 * @brief 海外版账号地区
 */
extern NSString *const NT_MINOR_ISO_CODE; // NT_MINOR_ISO_CODE = @"MINOR_ISO_CODE";


extern NSString *const NT_AI_TEST_MODE; // NT_AI_TEST_MODE = @"AI_TEST_MODE";

/**
 * @brief 用于设置whoami的url
 */
extern NSString *const NT_SDK_WHO_REQ_URL; // NT_SDK_WHO_REQ_URL = @"SDK_WHO_REQ_URL";

/**
 * @brief 用于设置detect的url
 */
extern NSString *const NT_SDK_DETECT_URL; // NT_SDK_DETECT_URL = @"SDK_DETECT_URL";

/**
 * @brief 用于设置unisdk的base url
 */
extern NSString *const NT_SDK_UNI_UPDATE_URL; // NT_SDK_UNI_UPDATE_URL = @"SDK_UNI_UPDATE_URL";

/**
 * @brief 用于设置调查问卷的url
 */
extern NSString *const NT_SDK_ECHOES_URL; // NT_SDK_ECHOES_URL = @"SDK_ECHOES_URL";

/**
 * @brief 用于dump的url
 */
extern NSString *const NT_SDK_DUMP_URL; // NT_SDK_DUMP_URL = @"SDK_DUMP_URL";

/**
 * @brief 用于设置广告SDK打点url
 */
extern NSString *const NT_SDC_DEVICE_INFO_URL; // NT_SDC_DEVICE_INFO_URL = @"SDC_DEVICE_INFO_URL";

/**
 * @brief 回退至旧版的登录sauth流程
 */
extern NSString *const NT_UNI_SAUTH_FALLBACK; // NT_UNI_SAUTH_FALLBACK = @"UNI_SAUTH_FALLBACK";

/**
 * @brief 激活码接口cdKey url
 */
extern NSString *const NT_CD_KEY_URL; // NT_CD_KEY_URL = @"CD_KEY_URL";

/**
 * @brief 激活码接口cdKey 签名密钥
 */
extern NSString *const NT_CD_KEY_SIGN_KEY; // NT_CD_KEY_SIGN_KEY = @"CD_KEY_SIGN_KEY";

/**
 * @brief 激活码接口cdKey auth接口中的subtype
 */
extern NSString *const NT_PACKET_ID; // NT_PACKET_ID = @"PACKET_ID";

/**
 * @brief 自建游客登录状态
 */
extern NSString *const UNISDK_GUEST_LOGIN_STATE; // UNISDK_GUEST_LOGIN_STATE = @"UNISDK_GUEST_LOGIN_STATE";

/**
 * @brief 虚拟支付
*/
extern NSString* const NT_VIRTUAL_ORDER; // NT_VIRTUAL_ORDER = @"VIRTUAL_ORDER";

/**
 * @brief 传1支付时显示Loading界面
*/
extern NSString* const NT_SHOW_ORDER_LOADING; // NT_SHOW_ORDER_LOADING = @"SHOW_ORDER_LOADING";

/**
 * @brief 传1后优先使用缓存中的Product进行支付
*/
extern NSString* const NT_USE_SKPRODUCT_CACHE; // NT_USE_SKPRODUCT_CACHED = @"USE_SKPRODUCT_CACHE";

/**
 * @brief base中的网络请求是否使用HTTPDNS，1为使用，默认不使用
*/
extern NSString* const NT_ENABLE_HTTP_DNS; // NT_ENABLE_HTTP_DNS = @"ENABLE_HTTP_DNS";

extern NSString *const NT_YIDUN_ALIVE_DETECT_APPID; // NT_YIDUN_ALIVE_DETECT_APPID = @"YIDUN_ALIVE_DETECT_APPID"

/**
 * @brief 支持海外版设置打开unisauth，目前仅支持netease_global，1为打开， 0为关闭，默认不打开
*/
extern NSString* const NT_ENABLE_UNI_SAUTH; // NT_ENABLE_UNI_SAUTH = @"ENABLE_UNI_SAUTH";

/**
 * @brief 是否为海外项目，影响uniSauth逻辑，netease_glboal会自动设置，产品一般不需要再设置
*/
extern NSString* const NT_OVERSEA_PROJECT; // NT_OVERSEA_PROJECT = @"OVERSEA_PROJECT";

/**
 * @brief Wi-Fi信息列表，返回json array格式的字符串
*/
extern NSString *const NT_WIFI_INFO_LIST; // NT_WIFI_INFO_LIST = @"WIFI_INFO_LIST"

/**
 * @brief 正在显示竖屏界面（针对锁死横屏的游戏，需要用该字段来显示竖屏UI）
 */
extern NSString *const NT_IS_OPENING_PORTRAIT_VIEW; // NT_IS_OPENING_PORTRAIT_VIEW = @"NT_IS_OPENING_PORTRAIT_VIEW"

/**
 * @brief 支持切换地区的开关，设置为1则打开，默认关闭
 */
extern NSString *const NT_ENABLE_CHANGE_LOCATION; // NT_ENABLE_CHANGE_LOCATION = @"ENABLE_CHANGE_LOCATION"

/**
 * @brief 玩家地区
 */
extern NSString *const NT_PLAYER_REGION; // NT_PLAYER_REGION = @"PLAYER_REGION"

/**
 * @brief 玩家国家区域码
 */
extern NSString *const NT_PLAYER_COUNTRYCODE; // NT_PLAYER_COUNTRYCODE = @"PLAYER_COUNTRYCODE"

/**
 * @brief 玩家所属省份/州
 */
extern NSString *const NT_PLAYER_PROVINCECODE; // NT_PLAYER_PROVINCECODE = @"PLAYER_PROVINCECODE"

/**
 * @brief 启用海外儿童保护
 */
extern NSString *const NT_ENABLE_OVERSEA_CHILD_PROTECT; // NT_ENABLE_OVERSEA_CHILD_PROTECT = @"ENABLE_OVERSEA_CHILD_PROTECT"

/**
 * @brief 自定义海外儿童保护域名
 */
extern NSString *const NT_OVERSEA_CHILD_PROTECT_SERVER_URL; // NT_OVERSEA_CHILD_PROTECT_SERVER_URL = @"OVERSEA_CHILD_PROTECT_SERVER_URL"


/**
 * @brief 是否切换账号场景（netease_global使用）
 */
extern NSString *const NT_GLOBAL_SWITCH_ACCOUNT; // NT_GLOBAL_SWITCH_ACCOUNT = @"GLOBAL_SWITCH_ACCOUNT"

/**
 * @brief 是否启用上报 UniSDK 版本信息
 */
extern NSString *const NT_SEND_UNISDK_VERSION; // NT_SEND_UNISDK_VERSION = @"SEND_UNISDK_VERSION"

/**
 * @brief 支持计费查询商品的时候设置语言(ISO 639-1标准)
 */
extern NSString *const NT_PRODUCT_LANGUAGE; // NT_PRODUCT_LANGUAGE = @"PRODUCT_LANGUAGE"

/**
 * @brief 是否抖音测试应用，在抖音应用没发布的状态下设置
 */
extern NSString *const NT_DOUYIN_TEST_APP; // NT_DOUYIN_TEST_APP = @"DOUYIN_TEST_APP"

/**
 * @brief 当前账号绑定的第三方账号id （netease_global使用）
 */
extern NSString *const NT_GLOBAL_BOUND_IDS; // NT_GLOBAL_BOUND_IDS = @"GLOBAL_BOUND_IDS";

/**
 * @brief 从who接口中返回的IP地址
 */
extern NSString *const NT_LOCAL_IP; // NT_LOCAL_IP = @"LOCAL_IP";
 
 /**
 * @brief 禁用客户端接口防护
 */
extern NSString *const NT_DISABLE_INTERFACE_PROTECTION; // NT_DISABLE_INTERFACE_PROTECTION = @"DISABLE_INTERFACE_PROTECTION"

/**
 * @brief 使用中东发行的域名(netease_global使用)
 */
extern NSString* const NT_MIDDLE_EAST_PUBLISH; // NT_MIDDLE_EAST_PUBLISH = @"MIDDLE_EAST_PUBLISH";


/**
 * @brief 登录界面自带用户协议，首次登录后不需要另外弹出协议，只有在协议更新才会弹出
 */
extern NSString* const NT_PROTOCOL_SILENT_MODE; // NT_PROTOCOL_SILENT_MODE = @"PROTOCOL_SILENT_MODE";

/**
 * @brief 是否禁用UniSDK提供的账号封停弹窗，默认使用弹窗，设置为1则禁用
 */
extern NSString* const NT_DISABLE_ACCOUNT_BLOCKED_DIALOG; // NT_DISABLE_ACCOUNT_BLOCKED_DIALOG = @"DISABLE_ACCOUNT_BLOCKED_DIALOG";

/**
 * @brief ENABLE_NEW_HASLOGIN 是否使用haslogin新的逻辑，默认为0，1表示启用
 */
extern NSString* const NT_ENABLE_NEW_HASLOGIN; // NT_ENABLE_NEW_HASLOGIN = @"ENABLE_NEW_HASLOGIN";

/**
 * @brief 处理合规问题，开启后uni_sauth和client_sauth不传递ip
 */
extern NSString *const NT_DISABLE_UPLOAD_LOCAL_IP; // NT_DISABLE_UPLOAD_LOCAL_IP = @"DISABLE_UPLOAD_LOCAL_IP";
