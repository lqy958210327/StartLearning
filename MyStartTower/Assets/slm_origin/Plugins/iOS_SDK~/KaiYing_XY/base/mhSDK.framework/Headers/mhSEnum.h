

#ifndef mhSEnum_h
#define mhSEnum_h
#import <Foundation/Foundation.h>

#pragma mark status

/** 游戏上下线上报渠道 */
typedef NS_ENUM(NSUInteger, mhSReportedChannel) {
    mhSReportedChannelApplicationDidEnterBackground,	//应用程序进入后台
    mhSReportedChannelApplicationDidBecomeActive,		//应用程序已变为活跃状态
    mhSReportedChannelApplicationWillTerminate,			//应用程序将终止
    mhSReportedChannelLoginSuccess,						//登录成功
    mhSReportedChannelLoginLogout,						//退出登录
    
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;

/** 游戏上下线上报状态：0下线，1上线 */
typedef NS_ENUM(NSUInteger, mhSReportedStatus) {
    mhSReportedStatusOffline = 0,		//下线
    mhSReportedStatusOnline = 1,		//上线
    
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;


/** 网络请求状态 */
typedef NS_ENUM(NSUInteger, mhSNetworkStatus) {
    mhSNetworkStatusSuccess,			//请求成功,数据成功
    mhSNetworkStatusError,				//请求失败
    mhSNetworkStatusShowMsg,			//请求成功,展示后端返回信息
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;

/** SDK 隐私协议状态 */
typedef NS_ENUM(NSUInteger, mhSPrivacyAgreementStatus) {
	mhSPrivacyAgreementStatusAgree,		//同意协议
	mhSPrivacyAgreementStatusReject,	//拒绝协议
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;

/** SDK 激活状态 */
typedef NS_ENUM(NSUInteger, mhSActiveStatus) {
    mhSActiveStatusSuccess,				 //激活成功
    mhSActiveStatusError,			     //激活失败
    mhSActiveStatusParameterLogicError,  //参数传入错误、或者调用逻辑不对（请在激活成功后，调用其他功能）
    mhSActiveStatusNoNetwork,            //没网
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;

/** SDK 激活失败详细状态 */
typedef NS_ENUM(NSUInteger, mhSActiveErrorInfoStatus) {
    mhSActiveErrorInfoStatusInitFail = 3005,		//初始化失败
    mhSActiveErrorInfoStatusConfigFail = 3006,		//获取配置失败
    mhSActiveErrorInfoStatusProcessError = 3007,	//流程错误（未激活时，调用showView,支付,日志,用户信息等接口1）
    mhSActiveErrorInfoStatusLackParameter = 3008,	//缺少初始化参数，APPID和gameID
	mhSActiveErrorInfoStatusRefusedPortocol = 3009,	//拒绝协议
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;

/** SDK 登陆状态 */
typedef NS_ENUM(NSUInteger, mhSLoginStatus) {
    mhSLoginStatusSuccess,				//登陆成功
    mhSLoginStatusError,				//登陆失败
    mhSLoginStatusNone,					//未登陆
    mhSLoginStatusIsLoggedIn,           //已登陆
    mhSLoginStatusLogout,				//退出登录
    mhSLoginStatusAgreementError,		//拒绝了用户协议
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;

/** SDK 支付状态*/
typedef NS_ENUM(NSUInteger, mhSTotalStatus) {
    mhSTotalStatusSuccess,				//支付成功
    mhSTotalStatusError,				//支付失败
    mhSTotalStatusCancel,				//支付取消
    mhSTotalStatusRealNameFaild			//实名认证失败
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;


/**SDK 日志上报状态*/
typedef NS_ENUM(NSUInteger, mhSLogStatus) {
    mhSLogStatusSuccess,	//上报成功
    mhSLogStatusError,		//上报失败
}NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;


#pragma mark type


/**结算类型*/
typedef NS_ENUM(NSUInteger, mhSTotalType) {
    mhSTotalTypeThird,		//网页三方结算
    mhSTotalTypeInapp,		//内购结算
	mhSTotalTypeGZH,		//gzh提示，结束支付
	mhSTotalTypeGZHAndInapp,//gzh提示，继续支付
    mhSTotalTypeNone,		//不支持支付
};

/**日志类型*/
typedef NS_ENUM(NSUInteger, mhSLogType) {
    mhSLogTypeLoginGame = 0,			//登陆游戏
    mhSLogTypeCreateRole = 1,			//创建角色
    mhSLogTypePlayGame = 2,				//开始游戏
    mhSLogTypeUpdateLevel = 3,			//角色升级
    mhSLogTypeCustom = 4,				//自定类型
};

/**window类型*/
typedef NS_ENUM(NSInteger, mhSWindowType) {
    mhSWindowType_show,         		//显示悬浮球
    mhSWindowType_showList,     		//显示列表
    mhSWindowType_dissmiss,     		//吸附屏幕边缘
    mhSWindowType_pan,          		//拖拽
    mhSWindowType_fullScreen,   		//全屏
};

/** 保存相册状态 */
typedef NS_ENUM(NSUInteger, mhSScreenshotStatus) {
    mhSScreenShotStatusNone = 0,		//没有权限
    mhSScreenShotStatusSucceed,			//保存成功
    mhSScreenShotStatusFailed,			//保存失败
};

/**用户分类*/
typedef NS_ENUM(NSUInteger, mhSAccountUserType) {
    mhSAccountUserTypeUnknown = 0,		//未知
    mhSAccountUserTypeTourist,    		//游客账号
    mhSAccountUserTypeVerifiedA,  		//已实名A类账号 满18岁以上
    mhSAccountUserTypeVerifiedB,  		//已实名B类   16-18岁 有时长及金额限制
    mhSAccountUserTypeVerifiedC,  		//已实名C类   8-16    有时长及金额限制
    mhSAccountUserTypeVerifiedD,  		//已实名D类   <8      有时长及金额限制
};

/**悬浮球下侧在线时长和额度 展示类型*/
typedef NS_ENUM(NSUInteger, mhSLimitInfoType) {
    mhSLimitInfoTypeNone = 0,  			//未知
    mhSLimitInfoTypeLevelTwo,  			//左在线,右额度
    mhSLimitInfoTypeLevelOnLineTime,	//居中展示在线时长
    mhSLimitInfoTypeLevelAmount,  		//居中展示额度
};

#endif /* mhSEnum_h */
