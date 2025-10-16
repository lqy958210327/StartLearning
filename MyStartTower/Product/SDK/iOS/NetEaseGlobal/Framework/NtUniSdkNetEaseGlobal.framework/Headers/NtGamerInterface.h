//
//  GamerInterface.h
//  NtUniSdk
//
//  Created by UniSDK on 14-5-23.
//  Copyright (c) 2014年 Game-NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NtConstProp.h"

@class NtOrderInfo;
@class NtShareInfo;
@class UNUserNotificationCenter;
@class UNNotificationResponse;
@class UNNotification;
//@protocol NtControllerDelegate;
@protocol PadEvent;

//sdk的一些不能用notification回调的，可以用delegate回调
@protocol NtSdkCallback <NSObject>
- (void)onStateEvent:(id<PadEvent> _Nonnull)event;
@end

/**
 * @brief 给游戏开发人员用的NtUniSdk对象接口
 *      对于游戏开发人员，只需要使用好此接口文件中定义的函数，即可完成NtUniSdk中绝大部分功能
 */
@protocol NtGamerInterface <NSObject>

NS_ASSUME_NONNULL_BEGIN

@required
/**
 *  @brief 初始化NtUniSdk
 *
 *  初始化函数，建议在以下函数中调用以初始化NtUniSdk对象
 *  AppDelegate
 *      - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 *
 */
- (void) ntInit;

/**
 * @brief 设置日志的callback
 */
- (void)setLogCallback:(void (^)(NSString *log))callback;

/**
 *  @brief 设置为调试模式
 *
 *  将Sdk设置为调试模式，部分Sdk支持，可用于测试环境使用测试货币充值或打开测试Log
 *
 *  @param v 是否设置为调试模式，默认为NO。
 */
- (void) setDebugMode:(BOOL) v;

/**
 *  @brief 是否打开unisdk的调试信息log
 */
- (void) setLogOpen:(BOOL)yesOrNo;

/**
 *  @brief 登陆。
 *  
 *  登陆成功后，视Sdk具体情况，一般会发出 NT_NOTIFICATION_LOGIN 通知
 */
- (void) ntLogin;

/**
 *  @brief 登出
 *      
 *  登出成功后，视Sdk具体情况，一般会发出 NT_NOTIFICATION_LOGOUT 通知。部分Sdk可能无此功能及相应类型通知
 */
- (void) ntLogout;

/**
 *  @打开sdk的账户管理界面
 *
 *  打开Sdk的账号管理界面，部分sdk无此功能，调用后将直接return
 */
- (void) ntOpenManager;

/**
 *  @brief 打开和隐藏sdk的float button（悬浮图标）
 *  
 *  打开或隐藏Sdk的悬浮按钮，部分sdk无此功能，调用后将直接return
 */
- (void) ntSetFloatBtnVisible:(BOOL) v DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");

/**
 *  @brief 打开Sdk暂停页面
 *
 *  打开Sdk的暂停页面，部分sdk无此功能，调用后将直接return
 */
- (void) ntOpenPauseView;

- (void)ntSwitchAccount;

/*
 *  @brief 用户支付订单的函数。
 *
 *  支付完成或取消后，视Sdk具体情况，一般会发出 NT_NOTIFICATION_CLOSE_FFVIEW 通知
 *
 *  @param order 将要支付的订单对象。
 */
- (void) ntCheckOrder:(NtOrderInfo*) order;

/**
 * @brief 购买成功，发道具之后，调用此接口（netmarbel必须调用，其他渠道暂不要求）
 */
- (void) ntConsume:(NtOrderInfo *)order;

/**
 *  @brief 获取已支付的订单列表，仅用于IAP
 *
 *  获取已支付的订单列表，用于取得订单的TransactionReceipt，并传递给服务器。由于IAP需要将TransactionReceipt传给服务端验证，SDK将已支付订单列表存于KeyChain中，以防漏单。
 *
 *  @return 返回已支付但未处理的订单列表，键为OrderID，值为对应的NtOrderInfo对象
 */
- (NSDictionary*) getCheckedOrders;
/**
 *  @brief 从SDK保存的已支付的订单列表删除指定订单
 *
 *  从已支付订单列表中删除指定订单。由于IAP需要将TransactionReceipt传给服务端验证，SDK将已支付订单列表存于KeyChain中。当完成整个订单处理流程时，需要将订单从KeyChain中删除，防止重复兑付。
 *
 *  @param OrderID 指定删除订单的ID
 */
- (void) removeCheckedOrders:(NSString*) OrderID;

/**
 *  @brief 打开帮助页面 line渠道的功能
 *
 *  @param catId 帮助页面种类
 *  @param docId 文档id
 *  @param title 页面标题
 */
- (void) ntOpenHelpViewWithCategory:(NSString *)catId
                         documentId:(NSString *)docId
                          viewTitle:(NSString *)title DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");

/**
 *  获取通知的消息 line渠道的功能
 */
- (void)ntGetNotice:(BOOL)isForce DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");


/**
 *  @brief 获取SDK属性
 *
 *  @param prop 属性名，通用属性已于NtConstProp.h中定义
 *
 *  @return 与传入名称对应的属性值，若不存在，返回nil
 */
- (id) getProp:(NSString*) prop;
/**
 *  @brief 设置SDK属性
 *
 *  @param prop 属性名，通用属性已于NtConstProp.h中定义
 *
 *  @return 与传入名称对应的属性值，若传入nil，则删除相应的属性值
 */
- (void) setProp:(NSString*) prop as:(id _Nullable) val;

/**
 *  @brief 获取字符串类型的SDK属性
 *
 *  @param prop 属性名，通用属性已于NtConstProp.h中定义。
 *
 *  @return 与传入名称对应的属性值，若不存在，返回nil。
 */
- (NSString*) getPropStr:(NSString*) prop;
/**
 *  @brief 设置字符串类型的SDK属性
 *
 *  @param prop 属性名，通用属性已于NtConstProp.h中定义
 *
 *  与传入名称对应的属性值，若传入nil，则删除相应的属性值
 */
- (void) setPropStr:(NSString*) prop as:(NSString* _Nullable) val;

/**
 *  @brief 获取整数类型的SDK属性
 *
 *  @param prop       属性名，通用属性已于NtConstProp.h中定义
 *  @param defaultVal prop不存在时返回的默认值
 *
 *  @return 与传入名称对应的属性值，若不存在，则返回传入默认值
 */
- (int) getPropInt:(NSString*) prop default:(int) defaultVal;
/**
 *  @brief 设置整数类型的SDK属性
 *
 *  @param prop 属性名，通用属性已于NtConstProp.h中定义
 *
 *  @return 与传入名称对应的属性值
 */
- (void) setPropInt:(NSString*) prop as:(int) val;

/**
 *  @brief Sdk是否具备某种功能
 *
 *  @param feature 功能属性名，通用属性已于NtConstProp.h中定义
 *
 *  @return 是否具备某种功能
 */
- (BOOL) hasFeature:(NSString*) feature;

/**
 *  @brief 检测玩家的登录状态
 *
 *  @return 玩家是否已经登录
 */
- (BOOL) hasLogin;

/**
 * @brief 查询当前登录的账户类型，登录账户类型，见NtConstProp.h常量
 *  返回的整形跟Android可能不同，建议使用 getAuthTypeName 来获取登录账户类型
 */
- (NSInteger) getAuthType;

/**
 * @brief 查询当前登录的账户类型名称，登录账户类型名称，见NtConstProp.h常量
 */
-(NSString *)getAuthTypeName;

/**
 * @brief 查询当前登录的账户是否已经绑定到某账户类型
 */

- (BOOL) isBinded:(NSString *)authTypeName;

/**
 *  @brief 打开sdk的游客账户绑定界面
 *
 */
- (void) ntGuestBind;

/**
 *  @brief 获取渠道名字
 *
 *  @return 渠道名字
 */
- (NSString*) getChannel;

/**
 *  @brief 获取渠道类型
 *
 *  @return 越狱类型返回 @"pb"，非越狱返回@"ios"
 */
- (NSString*) getPlatform;

/**
 *  @brief 获取APP_CHANNEL
 *
 *  @return 返回xxx.data里APP_CHANNEL字段，默认返回 @"please_input_appchannel"
 */
- (NSString*) getAppChannel;

/**
 * @brief 获取设备唯一号
 */
- (NSString*) getUdid;

/**
 * @brief 获取SDK版本号
 */
- (NSString*) getSDKVersion:(NSString*) channelId;

/// 获取 UniSDK 一级渠道的版本号
- (NSString *)getUniSDKVersion;

/// 获取 UniSDK base 母包的版本号
- (NSString *)getSDKBaseVersion;

/**
 * @brief 获取这此商品最终会用使用哪个渠道来支付（接运营商SDK时才需要关心此接口）
 *
 * @param pid
 *            通过regProduct注册的商品pid
 *
 * @return 此商品最终会用哪个渠道支付
 */
- (NSString*) getFFChannelByPid: (NSString*)pid;

/**
 *  cc录像功能
 */
- (void)ntCCStartService DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc"); // 打开窗口
- (void)ntCCStopService DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc"); // 关闭窗口
- (UIImage *)ntCCTakeScreenShot DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");//截屏
- (NSInteger)getCCWindowState DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");//获取窗口显示的状态
- (BOOL)ntCCisSupportRecord DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");//设备是否支持录像
- (void)ntCCSetOrientationMask DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");//根据NT_SCR_ORIENTATION设置横竖屏
// G18 CC专用
- (void)ntCCEnableShare:(BOOL)enable
           ccShareBegin:(void (^)(NSDictionary*))ccShareBegin
          ccUploadBegin:(void (^)(NSDictionary*))ccUploadBegin
ccUploadProgressChanged:(void (^)(NSDictionary*))ccUploadProgressChanged
      ccUploadCompleted:(void (^)(NSDictionary*))ccUploadCompleted
         ccUploadFailed:(void (^)(NSDictionary*))ccUploadFailed
          ccStartRecord:(void (^)(NSDictionary*))ccStartRecord
           ccStopRecord:(void (^)(NSDictionary*))ccStopRecord DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");
- (void)ntCCUploadVideoWithFileName:(NSString*)file_Name title:(NSString*)title desc:(NSString*)desc DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");
- (void)ntCCCancelUploadVideoWithFileName:(NSString*)file_Name DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");
- (void)ntCCUpdateVideoSharedStatus:(BOOL)hasShare byFileName:(NSString*)file_Name DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");
- (void)ntCCHideVideoListView DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");
- (BOOL)ntCCIsRecording DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");
- (void)ntCCStopRecord DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");

///**
// *  @brief 角色成功进入后调用,用于统计数据(统一用ntGameLoginSuccess)
// */
//- (void)ntLoginGameServerSuccess;
/**
 *  @brief 账号登陆成功入后调用,用于设定分服服务器ID NT_SERVER_ID
 */
- (void)ntGameLoginSuccess;

/**
 *  @brief [预留接口]程序退出时调用，清理资源
 */
- (void) exit;


/**
 *  @brief 在APP运行的时机点调用下面函数
 *
 *  在implementation AppDelegate中添加以下代码，以响应某些渠道要求。
 *  - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 *  {
 *       return [[NtSdkMgr getInst] application:application didFinishLaunchingWithOptions:launchOptions];
 *  }
 *
 */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;


/**
 *  @新添加的生命周期接口
 */
//--------------------------- NOTICE ---------------------------//
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void)application:(UIApplication*)application didReceiveLocalNotification:(UILocalNotification *)notification;
//--------------------------- NOTICE ---------------------------//

- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;

//新旧版本的handle open url
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;
/**
 * @brief  生命周期时间 (Efun)
 */
- (BOOL)handleOpenURL:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler;
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window;

/**
 *@brief Efunfun
*/
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

/**
 *@brief funcell_kr
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application;

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler;

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0));

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSUInteger options))completionHandler API_AVAILABLE(ios(10.0));

/**
 *@brief Swrve渠道
 */
- (void)processNotificationResponse:(UNNotificationResponse *)response DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 *  @brief 响应支付宝快捷支付等应用外支付回调
 *
 *  在implementation AppDelegate中添加以下代码，以响应支付宝快捷支付等应用外支付回调。
 *  - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 *  {
 *       return [[NtSdkMgr getInst] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
 *  }
 *  
 *  @param url               传递到openURL的参数
 *  @param sourceApplication 传递到sourceApplication的参数
 *  @param annotation        传递到annotation的参数
 *
 *  @return 处理结果
 */
- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:annotation;

/**
 * @brief 加好友
 */
- (void) ntApplyFriend:(NSString*) accountId;
/**
 * @brief 获取好友列表
 */
- (void) ntQueryFriendList;

/**
 * @brief 获取账户信息
 */
- (void)ntQueryMyAccount;
/**
 * @brief 获取游戏中的好友列表
 */
- (void) ntQueryFriendListInGame;
/**
 * @brief 获取可以添加的好友列表
 */
- (void) ntQueryAvailablesInvitees;

/**
 * @brief 获取可以向我发送邀请的好友列表
 */
- (void) ntQueryInviterList;
/**
 * @brief 发送邀请
 */
- (void) ntInviteFriendList:(NSString *)message title:(NSString *)title;
/**
 * @brief 删除邀请者
 */
- (void) ntDeleteInviters:(NSArray *)arrInviters;

/**
 * @brief 获取排行榜信息（调用前请设置好过滤条件，详见"接入注意事项"）
 */
- (void) ntQueryRank;
/**
 * @brief 上传本玩家的分数到排行榜
 * @param rankType 榜单类别
 * @param score 分数
 */
- (void) ntUpdateRank:(NSString*) rankType withScore: (double) score;
/**
 * @brief 分享消息（调用前请设置好分享相关参数，详见"接入注意事项"）
 */
- (void) ntShare: (NtShareInfo*) msg;

/**
 * @brief 发送推送消息
 */
- (void) ntSendPushNotification:(NSString *)message playerIDArray:(NSArray *)arr;
/**
 * @brief 获取推送开关设置
 */
- (void) ntGetUserPushNotification;
/**
 * @brief 设置推送开关
 */
- (void) ntSetUserPushNotification:(BOOL)isOn;
/**
 * @brief 发送本地推送
 * @param strJson
 * 				需提供的参数的json字符串，包含second， message， notifictionID， soundFileName， extra
 * @param second (NSString)
 * 				设置几秒后发送本地Push
 * @param message (NSString)
 * 				要发送的 Push 消息 要转达的消息最长 256Byte
 * @param soundFileName (NSString)
 * 				音效文件名称 res/raw 文件夹里有音频文件
 * @param extra (NSDictionary)
 * 				发送 Push 时要一并发送的数据
 * @返回 notifictionID (NSString)
 * 				收到推送时提示栏里显示的 notification View 的 ID 值 (※ 参考[Table 6] Push 发送 API 参数表)
 */
- (void) ntSendLocalNotification:(NSDictionary *)dict;
/**
 *  @brief  取消本地推送
 */
- (void) ntCancelLocalNotification:(int)pushID;
/**
 * @brief netease 达人接口
 */
- (void) ntShowDaren;

/**
 * @brief netease 达人消息是否有更新(这个接口即将废弃，建议不要用了。改用- (BOOL)ntHasNotification)
 */
- (BOOL)ntIsDarenUpdated DEPRECATED_MSG_ATTRIBUTE("Deprecate, use ntHasNotification");
- (BOOL)ntHasNotification;

/**
 *  @brief netease 获取推荐昵称
 */
- (NSString *)ntGetRecommendedNickname;

/**
 * @brief netease 启用网易SDK支付
 */
//- (void) ntEnableNeteasePay;

/**
 * @brief netease 联系客服
 */
- (void) ntOpenGmView DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");

/**
 * @brief 显示网页
 */
- (void)ntShowWeb:(NSString *)url DEPRECATED_MSG_ATTRIBUTE("Deprecated, please use extendfunc");

/**
 * @brief 显示奖励页面
 */
- (void)ntShowRewardView:(NSArray *)rewardData DEPRECATED_MSG_ATTRIBUTE("Deprecated");
/**
 * @brief appstore账号信息(家庭分享计划的账号)
 */
- (NSString *)ntHomeShareingAppleId DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 请求appleID币种信息（这个接口废弃，改为ntQueryProductInfo）
 * 需要传入一个商品id, 通过postnotification返回结果
 */
- (void)ntQueryCurrency:(NSString *)productID __attribute__((deprecated("后续请使用- (void)ntQueryProductInfo;接口")));
/**
 *  @brief  去苹果服务器获取商品信息
 *          调用这个接口之前需要调用 [[NtSdkMgr getInst] setPropStr:NT_PRODUCT_LIST as:@"商品id01 商品id02 商品id03"]
 *          设置好各个商品id，各个id直接通过空格间隔开
 *          调用之后unisdk会去获取商品信息，获取成功之后会发送NT_NOTIFICATION_FINISH_GET_PRODUCT_INFO的通知，如果获取失败，通知中的userinfo附带失败消息。
 *          通过[[NtSdkMgr getInst] getPropStr:NT_CURRENCY]获取到币种
 *          通过[[NtSdkMgr getInst] getPropStr:NT_GAME_REGION]获取到国家号码
 *          通过[[NtSdkMgr getInst] getPropStr:@"商品id"]获取到商品id对应的价格
 */
- (void)ntQueryProductInfo DEPRECATED_MSG_ATTRIBUTE("Deprecated");
- (void)ntQuerySkuDetails:(NSArray<NSString *> *)skuList DEPRECATED_MSG_ATTRIBUTE("Deprecated");

- (DRPFCode) DRPF: (NSString *)strJson;


/**
 *  @brief  去获取商品信息（line、FunPlus乱斗专用）
 */
//- (void)ntQueryLinePay;




/**
 * @brief  获取商品列表(Efun, Garena渠道使用)
 */
- (NSArray *)ntProductsList DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 *  @brief  设置是否检查非常规支付
 *  @param dectectOrNot YES or NO
 */
- (void)ntSetIAPDetectIrregularActivity:(BOOL)detectOrNot;

/**
 *  @brief  显示二维码扫描
 */
- (void)ntPresentQRCodeScanner;
- (void)ntPresentQRCodeScanner:(NSString *)extra requestCode:(int)code;

/**
 *  @brief  绑定到指定渠道，绑定玩家ID到FB或者G+ (NetmarbleS使用)
 *          调用前，需要调用setPropStr:NT_LOGIN_TYPE as:NT_AUTH_FACEBOOK
 *          设置当前绑定的是FB，还是G+
 */
- (void)ntConnectToChannel DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 *  @brief 注销频道连接 (NetmarbleS使用)
 * 			调用前，需要调用
 *  setPropInt(ConstProp.LOGIN_TYPE, ConstProp.AUTH_FACEBOOK)
 * 			设置当前注销的是FB，还是G+
 */
- (void)ntDisConnectFromChannel DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 *  @brief 获取当前玩家的FB或者G+是否已经绑定过PID (NetmarbleS使用)
 * 			需要在登录过相应的频道后才能使用
 *  @return true 绑定过 ; false 未绑定
 */
- (BOOL)ntHasChannelConnected DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 *  @brief 获取频道ID，需要在登陆之后使用 (NetmarbleS使用)
 * 			调用前，需要调用
 *  setPropInt(ConstProp.LOGIN_TYPE, ConstProp.AUTH_FACEBOOK)
 * 			设置当前绑定的是FB，还是G+
 * 			如果没有进行频道连接的，将返回null
 *  @return 返回频道的ID
 */
- (NSString *)ntGetChannelID DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 *  @brief 设置连接频道的关联类型 (NetmarbleS使用)
 * 			!IMPORTANT: 需在ntConnectToChannel()调用后的回调中调用才有意义，其他时机不要调用
 * 			option在OnConnectListener中定义，包括Cancel，Update，Load，Create四种类型
 *  @return 回调onSelectChannelOptionFinished：true 更新连接的关联类型成功 ; false 失败
 */
//public void ntSelectChannelOption(int option);
- (void)ntSelectChannelOption:(int)option DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 发送邀请（GameCenter功能）
 * @param identifiers 玩家ID列表
 */
- (void) ntInviteFriendList:(NSArray*) identifiers DEPRECATED_MSG_ATTRIBUTE("Deprecated");
/**
 * @brief 获取默认排行榜信息（GameCenter功能）
 */
- (void) ntQueryDefaultRank DEPRECATED_MSG_ATTRIBUTE("Deprecated");
/**
 * @brief 设置默认排行榜信息（GameCenter功能）
 * @param identifier 排行榜标识
 */
- (void) ntSetDefaultRank:(NSString *)identifier DEPRECATED_MSG_ATTRIBUTE("Deprecated");
/**
 * @brief 展示标准排行榜（GameCenter功能）
 * @param identifier 排行榜标识
 */
- (void) ntDisplayLeaderboard:(NSString *)identifier DEPRECATED_MSG_ATTRIBUTE("Deprecated");
/**
 * @brief 获取得分信息（GameCenter功能）
 * @param filter
 * 				需提供的参数，包含playerScope， timeScope， identifier， rangeStart， rangeEnd， match
 * @param playerScope (NSNumber)
 * 				设置玩家范围，0=GKLeaderboardPlayerScopeGlobal， 1=GKLeaderboardPlayerScopeFriendsOnly
 * @param timeScope (NSNumber)
 * 				设置时间范围，0=GKLeaderboardTimeScopeToday，1=GKLeaderboardTimeScopeWeek，2=GKLeaderboardTimeScopeAllTime
 * @param identifier (NSString)
 * 				设置排行榜标识
 * @param rangeStart (NSNumber)
 * 				排名开始索引，一般设置为1
 * @param rangeEnd (NSNumber)
 * 				排名结束索引，如果需要前10名的得分，这里可以设置为10
 * @param match (NSArray)
 * 				玩家ID列表，设置在特定的玩家中的得分排行，如果需要在全部玩家中进行排行，请忽略该参数
 */
- (void) ntQueryScores:(NSDictionary *)filter DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 报告成就，可为某个玩家设置（GameCenter功能）
 * @param identifier 排行榜标识
 * @param playerID 玩家ID
 * @param percent 进度，设置1-100
 */
- (void) ntUpdateAchievement:(NSString *)identifier forPlayer: (NSString *) playerID percentComplete: (float) percent DEPRECATED_MSG_ATTRIBUTE("Deprecated");
/**
 * @brief 报告成就，默认当前登录的玩家（GameCenter功能）
 * @param identifier 排行榜标识
 * @param percent 进度，设置1-100
 */
- (void) ntUpdateAchievement:(NSString *)identifier percentComplete: (float) percent DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 展示成就（GameCenter功能）
 * @param identifier 排行榜标识
 */
- (void) ntDisplayAchievement:(NSString *)identifier DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 获取成就元数据(用于自定义成就界面)（GameCenter功能）
 * @param identifier 排行榜标识
 */
- (void) ntQueryAchievement:(NSString *)identifier DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 重置成就（GameCenter功能）
 */
//- (void) ntResetAchievement;

/**
 * @brief 开始一个挑战（GameCenter功能）
 *          在收到初始化的回调后，游戏才切换到UI
 * @param identifier 成就/排行榜标识
 * @param isScore 是否是排行榜 YES：是排行榜 NO：成就
 * @param score 排行榜可选传入挑战者最高分(需要符合排行榜取值区间)； 成就时可以传入挑战者进度：100.
 */
- (void) ntPrepareChallenge:(NSString *)identifier onScore:(BOOL)isScore withValue:(NSInteger)score DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 正式发布挑战（GameCenter功能）
 *          在收到初始化的回调后，游戏才切换到UI
 * @param identifiers 挑战的玩家ID列表
 * @param message 消息
 */
- (void) ntIssueChallengeToPlayers:(NSArray*) identifiers message:(NSString *)message DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 报告挑战进度（GameCenter功能）
 *         挑战排行榜 value表示分数，不能超过预先设置的最高分；挑战成就 value表示百分比1-100
 */
- (void) ntUpdateChallenge:(NSInteger)value DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 获取挑战列表信息（GameCenter功能）
 */
- (void) ntQueryChallenge DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 上传玩家角色信息给渠道，上传的内容和时机参考各渠道“接入注意事项”
 */
- (void)ntUpLoadUserInfo;

/**
 * @brief 设置SDK的环境 (GarenaSDK使用)
 * @param code 沙盒(Environment_S​andbox)：1   发布(​Environment_P​roduction)：2
 */
- (void)ntSetSDKEnvironment:(int)code DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 重置SDK的游客（GarenaSDK功能）
 *        账号会发生变化，重置前，确保游客信息已经绑定到平台并且返回成功,
 *        否则玩家信息会丢失!!!!
 */
- (void)ntResetGuest;

/**
 * @brief 手动同步商品信息到GOP（GarenaSDK功能）
 *        对于自动同步失败的商品进行操作
 */
- (void)ntDistributeGoods;

/**
 * @brief 设置Zone (NetmarbleS使用)
 * @param zone (示例:alpha, dev, real)
 */
- (void)ntSetZone:(NSString *)zone DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 * @brief 展示会话面板(Helpshift SDK)
 */
- (void)ntShowConversation;

/**
 * @brief 展示FAQ面板(Helpshift SDK)
 */
- (void)ntShowFAQs;

/**
 * @brief 设置用户标识(Helpshift SDK)
 */
- (void) ntSetUserIdentifier:(NSString *)userIdentifier;

/**
 * @brief 展示FANS页面(Mobithink SDK)
 */
- (void)ntShowFansPage:(NSString*)appid;

/**
 * @brief 反馈(Mobithink SDK)
 */
- (void)ntFeedbackByMail:(NSString*)appId;

/**
 * @brief 计费充值日志上传接口
 */
- (void) ntSaveLogToJFOnFF:(NtOrderInfo*)order;
/**
 * @brief 计费首次打开应用日志上传接口
 */
- (void) ntSaveLogToJFOnEnterGame;

/**
 * @brief 展示广告(Applovin SDK)
 */
- (void)ntShowADs DEPRECATED_MSG_ATTRIBUTE("Deprecated");

/**
 *  line渠道统计事件
 *  @param jsonEvent json字符串
 *  @param name name
 */
- (void)ntTrackCustomEvent:(NSString *)jsonEvent withName:(NSString *)name;

/**
 广告sdk监控事件
 @param name 事件名称
 @param json json字符串
 */
- (void)ntTrackCustomEvent:(NSString *)name withJson:(NSString *)json;

/**
 *  line渠道发送统计数据
 */
- (void)ntFlushCustomEvents;

/**
 *  line渠道发送玩家信息
 */
- (void)ntSendProfile:(NSString *)jsonProfile
            isUpdate:(BOOL)isUpdate;

/**
 * GOOGLE PLAY GAME SERVICES渠道
 * @param eventId         event ID, 例如Google Play Games Service是在Google Play Developer Console配置event, 获取eventId
 * @param incrementAmount For events which are used to determine quest completion,
 *                        you can use the incrementAmount input to specify the player's quantitative progress towards completing the quest.
 *                        For example, if the event your game wants to track is 'Defeat 500 bug-eyed monsters',
 *                        the incrementAmount can be the number of monsters that the player killed in a single battle.
 * @brief 更新event
 */
- (void)ntUpdateEvent:(NSString *)identifier incrementAmount: (uint64_t)amout;

/**
 * GOOGLE PLAY GAME SERVICES渠道
 * @param questSelectors 过滤想要在UI上显示的quests，如果想显示全部，questSelectors设为nil
 * @brief 展示quests
 */
- (void)ntDisplayQuests:(NSArray *)questSelectors;

/**
 * @brief 展示用户协议
 * @param isRead: TRUE表示打开只有【确定】按钮的协议视图；FALSE表示打开【拒绝】【接受】的视图
 */
- (void)ntShowCompactView:(BOOL)isRead;

/**
 * @brief 将已经扣费完成的订单数据发送給unisdk的服务端
 *        unisdk的服务端收到收据后会去计费验证并将结果通知游戏服务端
 */
- (void)ntSendCheckedOrderToUnisdkServer;

/**
 * @brief 内嵌WKWebView视图打开网页，用于问卷调查等
 * @param URL: 网页地址
 */
- (void)ntOpenWebView:(NSString *)URL;

/**
 关闭调查问卷页面
 */
- (void)ntCloseWebView;

/**
* @breif 渠道一些非SDK非标准化的函数的扩展接口，依赖于渠道的具体实现，渠道具体实现应通过json中的某字段，比如methodId："someMethod"来区分具体调用的是渠道的哪个函数
*           如此函数马上返回, 请用[[NtSdkMgr getInst] getPropStr:EXTEND_FUNC_RETURN] 获取。
*           如此函数完成后通知, 请监听 NT_NOTIFICATION_EXTEND 消息
* @param json Json序列化的String
* @return json
*/
- (void)ntExtendFunc:(NSString *)json, ... ;

//- (void)ntExtendFunc:(NSString *)json andObject:...;

/**
 *  绑定/验证手机号
 *  @param resultCode 
 */
- (void)ntVerifyMobile:(int)resultCode;
/**
 *  获取设备模型 ex:iphone7,2 (iphone7,2表示iphone6，对照表如下：https://www.theiphonewiki.com/wiki/Models
 */
- (NSString *)getMobileModel;

/**
 *  设置计费sauth要用到的字段及内容
 */
- (void)setJFSauthWithKey:(NSString *)key andValue:(NSObject <NSCopying>*)value urlEncode:(BOOL)encode;

/**
 *  设置手柄控制器的回调
 *  @param listener 回调处理对象
 */
//- (void)setControllerListener:(id<NtControllerDelegate>)listener;

/**
 *  支付（非内购IAP支付的）（这个功能在网易SDK 2.4.0版本下线了）
 *  @param NtOrderInfo 设置好订单号 商品id 价格
 */
//- (void)payOrder:(NtOrderInfo *)orderInfo;

/**
 *  关闭闪屏
 */
- (void)ntCloseFlash;


/**
 获取用户地理位置信息

 @return iOS返回为空字符串，iOS通过回调获取地址位置信息
 */
//- (NSString *)ntGetLocation;


/**
 生成二维码
 @param content 二维码内容，代码跟据输入的字符串content，把content转成二维码
 @param width 二维码的宽度（单位：像素）
 @param height 二维码的高度（单位：像素）
 @param fileName 二维码图片文件的文件名。路径为：Documents/QRCodeImage/文件名.jpg
 */
- (void)ntCreateQRCode:(NSString *)content width:(NSInteger)width height:(NSInteger)height returnFileName:(NSString *)fileName;
- (void)ntCreateQRCode:(NSString *)content width:(NSInteger)width height:(NSInteger)height logoPath:(NSString *)logoPath returnFileName:(NSString *)fileName;

/**
 显示扫描二维码的界面
 @param extra 附加参数，空字符串为摄像头扫描，unisdk:recognize为打开相册扫描，unisdk:图片路径为识别指定图片
 */
- (void)ntScannerQRCode:(NSString *)extra;

/**
 快捷反馈接口
 */
- (void)ntOpenEchoes DEPRECATED_MSG_ATTRIBUTE("Deprecated");;

/**
 用户手机是否有安装对应App 微信微博易信QQ, platform字符如下: Weibo, Weixin, Yixin, QQ
 */
- (BOOL)ntHasPlatform:(NSString *)platform;

/**
 用于在问卷推送时, 根据游戏当前语言、游戏支持的语言以及用户系统当前语言做逻辑分析，返回最合适的玩家当前语言，提高填答率和用户体验

 @return 返回最适当的玩家当前语言
 */
- (NSString *)getSurveyPaperLanguage;

/**
 获取用户当前系统语言
 @return 用户当前系统语言
 */
- (NSString *)getSystemLanguage;


/// 获取oaid (android移动安全联盟MSA 设备标识)
- (NSString *)getOaid;

/**
 设置回调处理的委托对象
 @param delegate 回调处理对象
 */
- (void)setDelegate:(id<NtSdkCallback>)delegate;


/**
 用于新版CC录屏录入游戏声音
 */
- (void)ntPushGameVoiceWithData:(const char *)pcmData size:(uint32_t)size sampleRate:(uint32_t)sampleRate bitsPerSample:(uint32_t)bitsPerSample channels:(uint32_t)channels;

/**
 用于显示防沉迷的"消费限制"的弹窗
 */
- (void)showTipMessage:(NSString *)message aasFfRule:(NSString *)aasFfRule;
- (void)showTipMessage:(NSString *)message completion:(void(^)(void))completion;

NS_ASSUME_NONNULL_END
@end


