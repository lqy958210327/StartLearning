//
//  NtAdConstProp.h
//  NtShareSdk
//
//  Created by Huang Quanyong on 14-7-7.
//  Copyright (c) 2014年 Stupid Dumb Kids. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief 跟平台申请的id
 */
extern NSString* const AD_SDK_APPID;  // "APPID"
extern NSString* const AD_SDK_APPKEY; // "APPKEY"
extern NSString* const AD_SDK_TOKEN;  // "TOKEN"
extern NSString* const AD_SDK_FBID;   // "FBID" 目前仅nanigans用
extern NSString* const APPSFLYER_CURRENCY_CODE; // "APPSFLYER_CURRENCY_CODE" 仅appsflyer使用
/**
 * @brief 跟平台申请的key
 */
extern NSString* const AD_SDK_CONVERSION_TYPE; // "CONVERSION_TYPE"
/**
 * @brief 运行环境:@"sandbox" @"production";
 */
extern NSString* const AD_SDK_ENVIRONMENT; // "ENVIRONMENT"

/// 是否打印广告Debug日志 0：不打印；1：打印控制台；2：打印文件和控制台
extern NSString* const AD_SDK_DEBUG_LOG;
/**
 * @brief 运行平台KEY
 */

extern NSString* const AD_PLATFORM_ADJUST;          // "adjust";
extern NSString* const AD_PLATFORM_APPSFLYER;       // "appsflyer";
extern NSString* const AD_PLATFORM_FACEBOOK;        // "facebook";
extern NSString* const AD_PLATFORM_CHARTBOOST;      // "chartboost";
extern NSString* const AD_PLATFORM_ADMOB;           // "admob";
extern NSString* const AD_PLATFORM_ADMOB2;          // "admob2";
extern NSString* const AD_PLATFORM_INMOBI;          // "inmobi";
extern NSString* const AD_PLATFORM_PINYOU;          // "pinyou";
extern NSString* const AD_PLATFORM_ZYZ;             // "zyz";
extern NSString* const AD_PLATFORM_PARTYTRACK;      // "partytrack";
extern NSString* const AD_PLATFORM_MAT;             // "mat";
extern NSString* const AD_PLATFORM_ADBRIXl;         // "adbrix";
extern NSString* const AD_PLATFORM_VPON;            // "vpon";
extern NSString* const AD_PLATFORM_ADBERT;          // "adbert";
extern NSString* const AD_PLATFORM_NANIGANS;        // "nanigans";
extern NSString* const AD_PLATFORM_GANALYTICS;      // "google_analytics";
extern NSString* const AD_PLATFORM_FACEBOOK4X;      // "facebook";
extern NSString* const AD_PLATFORM_113;             // "113";
extern NSString* const AD_PLATFORM_EFUNFUN;         // "efunfun";
extern NSString* const AD_PLATFORM_FIREBASE;        // "firebase";
extern NSString* const AD_PLATFORM_METAPS;          // "metaps";
extern NSString* const AD_PLATFORM_LINEKONG;        // "linekong";
extern NSString* const AD_PLATFORM_SINGULAR;        // "singular";
extern NSString* const AD_PLATFORM_SEGMENT;         // "segment"
/**
 * @brief 事件
 */
extern NSString* const AD_SDK_INSTALL;          // "INSTALL"
extern NSString* const AD_SDK_REGISTRATION;     // "REGISTRATION" 注册
extern NSString* const AD_SDK_LAUNCH;           // "LAUNCH" 每次启动
extern NSString* const AD_SDK_LEVEL;            // "LEVEL" 升到N级
extern NSString* const AD_SDK_PURCHASE;         // "PURCHASE" 购买
extern NSString* const AD_SDK_OPEN_SESSION;     // "OPEN_SESSION"
extern NSString* const AD_SDK_CREATEROLE;       // "CREATEROLE"
extern NSString* const AD_SDK_LOGIN;            // "LOGIN"
/**
 * @brief 自定义属性
 *  进行 SDK 的任何调用之前,在 SDK 初始化中必须调用自定义用户 ID
 *  建议在[[NtAdMgr getInst] ntInit];之后马上设置
 */
extern NSString* const AD_SDK_CUSTOM_USERID;    // "AD_SDK_CUSTOM_USERID"
extern NSString* const APPSFLYER_WAIT_ATT_TIMEOUTINTERVAL;  // 延迟数据上报时间在ATT授权框之后，仅appsflyer使用
extern NSString* const FACEBOOK_SET_ATT_ENABLE; // // 是否启用广告主追踪功能 仅Facebook使用

/**
 * @brief 事件参数
 */
extern NSString* const AD_SDK_EVENTPARAMETER_CURRENCY;// "Currency" 货币

/**
 ***************************************************************************
 * @brief 针对渠道 参数表字典的 KEY
 ***************************************************************************
 */

/*
 * @brief Google analytics 渠道
 */
extern NSString* const GA_CATEGORY;         // "category" 事件类型
extern NSString* const GA_ACTION;           // "action" 动作
extern NSString* const GA_LABEL;            // "label"
extern NSString* const GA_VALUE;            // "value"
extern NSString* const GA_CURRENCY;         // "currency"
extern NSString* const GA_USERID;           // "userID"

/*
 * @brief Facebook analytics v4.x渠道
 */
extern NSString* const FB_VALUE2SUM;        // "FB_VALUE2SUM"

/**
 * MAT参数
 */
extern NSString* const UserEmail;// = @"UserEmail";
extern NSString* const UserName;// = @"UserName";
extern NSString* const Age;// = @"Age";
extern NSString* const Gender;// = @"Gender";
extern NSString* const UserId;// = @"UserId";
extern NSString* const FacebookUserId;// = @"FacebookUserId";
extern NSString* const GoogleUserId;// = @"GoogleUserId";
extern NSString* const TwitterUserId;// = @"TwitterUserId";
extern NSString* const Latitude;// = @"Latitude";
extern NSString* const Longitude;// = @"Longitude";
extern NSString* const Altitude;// = @"Altitude";
extern NSString* const RefId;// = @"RefId";
extern NSString* const Revenue;// = @"Revenue";
extern NSString* const CurrencyCode;// = @"CurrencyCode";
extern NSString* const EventItems;// = @"EventItems";
extern NSString* const EventItemWithName;// = @"EventItemWithName";
extern NSString* const UnitPrice;// = @"UnitPrice";
extern NSString* const Quantity;// = @"Quantity";
extern NSString* const Attribute1;// = @"Attribute1";
extern NSString* const Attribute2;// = @"Attribute2";
extern NSString* const Attribute3;// = @"Attribute3";
extern NSString* const Attribute4;// = @"Attribute4";
extern NSString* const Attribute5;// = @"Attribute5";


