//
//  NtUniSDKWorker.h
//
//  Created by UniSDK
//  Copyright (c) 2023 年 Game-NetEase. All rights reserved.
//
//  返回的内存如无特殊说明均为栈内存，不需要主动释放
//  Unless otherwise specified, the returned memory is stack memory and does not need to be actively released.

#ifndef UniSDKWorker_h
#define UniSDKWorker_h

#include <stddef.h>

#ifdef __cplusplus
extern "C"
{
#endif

// MARK: - CallBack

static char const* UNISDK_CALLBACK_OnFinishInit               = "OnFinishInit";
static char const* UNISDK_CALLBACK_OnLoginDone                = "OnLoginDone";
static char const* UNISDK_CALLBACK_OnLogoutDone               = "onLogoutDone";
static char const* UNISDK_CALLBACK_OnLeaveSdk                 = "OnLeaveSdk";
static char const* UNISDK_CALLBACK_OnOrderCheck               = "OnOrderCheck";
static char const* UNISDK_CALLBACK_OnContinue                 = "OnContinue";
static char const* UNISDK_CALLBACK_OnExitView                 = "OnExitView";
static char const* UNISDK_CALLBACK_OnQueryFriendList          = "OnQueryFriendList";
static char const* UNISDK_CALLBACK_OnQueryFriendListInGame    = "OnQueryFriendListInGame";
static char const* UNISDK_CALLBACK_OnQueryAvailablesInvitees  = "OnQueryAvailablesInvitees";
static char const* UNISDK_CALLBACK_OnQueryMyAccount           = "OnQueryMyAccount";
static char const* UNISDK_CALLBACK_OnApplyFriend              = "OnApplyFriend";
static char const* UNISDK_CALLBACK_OnIsDarenUpdated           = "OnIsDarenUpdated";
static char const* UNISDK_CALLBACK_OnQueryRank                = "OnQueryRank";
static char const* UNISDK_CALLBACK_OnUpdateRank               = "OnUpdateRank";
static char const* UNISDK_CALLBACK_OnShare                    = "OnShare";
static char const* UNISDK_CALLBACK_OnReceivedNotification     = "OnReceivedNotification";
static char const* UNISDK_CALLBACK_OnExtendFuncCall           = "OnExtendFuncCall";
static char const* UNISDK_CALLBACK_OnProtocolFinish           = "OnProtocolFinish";
static char const* UNISDK_CALLBACK_OnCodeScannerFinish        = "OnCodeScannerFinish";
static char const* UNISDK_CALLBACK_OnCreateQRCodeDone         = "OnCreateQRCodeDone";
static char const* UNISDK_CALLBACK_OnWebViewNativeCall        = "OnWebViewNativeCall";
static char const* UNISDK_CALLBACK_DL_OnProgress              = "DL_OnProgress";
static char const* UNISDK_CALLBACK_DL_OnFinish                = "DL_OnFinish";

extern const int UNISDK_CODE_SUCCESS; // const int UNISDK_CODE_SUCCESS = 0;

/// handle unisdk callback.
///
/// - callbackType: Callback type, see UNISDK_CALLBACK_*, 栈内存
/// - code: 回调 code，默认为 0（成功）
/// - info: 额外信息，JSON 字符串格式，栈内存
/// - bytes: 额外内存信息，可用于 Orbit 内存回调，栈内存
/// - bytesLength: 额外内存信息长度
typedef void(* OnUnisdkFinish)(const char* callbackType, int code, const char* info, const char* bytes, unsigned long bytesLength);

/// set finish callback
void unisdkSetFinishCallback(OnUnisdkFinish onFinish);


// MARK: - Setup

/// setup NtUniSdk
void unisdkInit(void);

/// 程序退出时调用，清理资源
void unisdkExit(void);


// MARK: - Account

/// Login
void unisdkLogin(void);

/// Logout
void unisdkLogout(void);

/// Switch account
void unisdkSwitchAccount(void);

/// Open the account management interface of SDK
void unisdkOpenManager(void);

/// 打开Sdk的暂停页面，部分sdk无此功能，调用后将直接return
void unisdkOpenPauseView(void);

/// 检测玩家的登录状态
bool unisdkHasLogin(void);

/// 查询当前登录的账户类型名称，登录账户类型名称，见 NtConstProp.h 常量，栈内存
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetAuthTypeName(void);

/// 查询当前登录的账户是否已经绑定到某账户类型
bool unisdkIsBinded(const char* authTypeName);

/// 打开 sdk 的游客账户绑定界面
void unisdkGuestBind(void);

/// 账号登陆成功入后调用, 用于设定分服服务器ID NT_SERVER_ID
void unisdkGameLoginSuccess(void);

/// 设置计费 sauth 要用到的字段及内容
void unisdkSetJFSauthWithKey(const char* key, const char* value, bool urlencode);


// MARK: - Check Order

/// 用户支付订单
/// 支付完成或取消后，视Sdk具体情况，一般会发出 NT_NOTIFICATION_CLOSE_FFVIEW 通知
void unisdkCheckOrder(const char* order);

/// 购买成功，发道具之后，调用此接口（部分渠道不要求调用）
void unisdkConsume(const char* order);

/// 获取已支付的订单列表，仅用于 IAP。返回值为订单数量。需传入二维数组的引用，使用后需主动释放内存
///
/// 调用示例示例
///
/// ```c
/// char **result = (char **)malloc(sizeof(*result));
/// const int count = unisdkGetCheckedOrders(result);
/// for (int i = 0; i < count; i++) {
///     char *order = result[i];
///     printf("order info: %s", order);
///     free(order);
/// }
/// free(result);
/// ```
/// 获取已支付的订单列表，用于取得订单的TransactionReceipt，并传递给服务器。由于IAP需要将TransactionReceipt传给服务端验证，SDK将已支付订单列表存于KeyChain中，以防漏单。
/// 返回已支付但未处理的订单列表，键为OrderID，值为对应的NtOrderInfo对象
int unisdkGetCheckedOrders(char** orders);

/// 从已支付订单列表中删除指定订单。由于IAP需要将TransactionReceipt传给服务端验证，SDK将已支付订单列表存于KeyChain中。
/// 当完成整个订单处理流程时，需要将订单从KeyChain中删除，防止重复兑付。
void unisdkRemoveCheckedOrder(const char* orderId);

/// 获取这此商品最终会用使用哪个渠道来支付（接运营商SDK时才需要关心此接口）
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetFFChannelByPid(const char* pid);


// MARK: - Channel

/// 获取渠道名字
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetChannel(void);

/// 获取渠道类型
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetPlatform(void);

/// 获取APP_CHANNEL
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetAppChannel(void);

/// 获取 SDK 版本号
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetSDKVersion(const char* channel);

/// 获取 UniSDK 一级渠道的版本号
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetUniSDKVersion(void);

/// 获取 UniSDK base 母包的版本号
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetSDKBaseVersion(void);

/// 设置要使用的渠道SDK
void unisdkSetSdk(const char* sdk);

/// 展示用户协议
/// - Parameter isRead: TRUE 表示打开只有【确定】按钮的协议视图；FALSE表示打开【拒绝】【接受】的视图
void unisdkShowCompactView(bool isRead);

/// 上传玩家角色信息给渠道，上传的内容和时机参考各渠道“接入注意事项”
void unisdkUpLoadUserInfo(void);

/// netease 达人消息是否有更新
bool unisdkHasNotification(void);

/// GOOGLE PLAY GAME SERVICES 渠道更新 event
/// - Parameters:
///   - eventId: event ID, 例如Google Play Games Service是在Google Play Developer Console配置event, 获取eventId
///   - incrementAmount: For events which are used to determine quest completion,
///   you can use the incrementAmount input to specify the player's quantitative progress towards completing the quest.
///   For example, if the event your game wants to track is 'Defeat 500 bug-eyed monsters',
///   the incrementAmount can be the number of monsters that the player killed in a single battle.
void unisdkUpdateEvent(const char* eventId, int incrementAmount);

/// 过滤想要在UI上显示的quests，如果想显示全部，questSelectors设为nil
/// - Parameters:
///   - questSelectors: 过滤想要在UI上显示的quests，如果想显示全部，questSelectors设为nil
///   - count: quests 的数量
void unisdkDisplayQuests(int* questSelectors, int count);


// MARK: - Social

/// 添加好友
/// - Parameter accountId: 好友的账户ID
void unisdkApplyFriend(const char* accountId);

/// 获取好友列表
void unisdkQueryFriendList(void);

/// 获取账户信息
void unisdkQueryMyAccount(void);

/// 获取游戏中的好友列表
void unisdkQueryFriendListInGame(void);

/// 获取可以添加的好友列表
void unisdkQueryAvailablesInvitees(void);

/// 获取可以向我发送邀请的好友列表
void unisdkQueryInviterList(void);

/// 发送邀请
void unisdkInviteFriendList(const char* message, const char* title);

/// 删除邀请者
void unisdkDeleteInviters(const char** inviterPlayerIDList, int count);

/// 获取排行榜信息（调用前请设置好过滤条件，详见"接入注意事项"）
void unisdkQueryRank(void);

/// 上传本玩家的分数到排行榜
/// - Parameters:
///   - rankType: 榜单类别
///   - score: 分数
void unisdkUpdateRank(const char* rankType, double score);

/// 分享消息（调用前请设置好分享相关参数，详见"接入注意事项"）
void unisdkShare(const char* shareInfo);

/// MARK: - Utils

/// Sdk 是否具备某种功能
bool unisdkHasFeature(const char* feature);

/// 用户手机是否有安装对应App 微信微博易信QQ, platform字符如下: Weibo, Weixin, Yixin, QQ
bool unisdkHasPlatform(const char* platform);

/// 获取设备唯一号
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetUdid(void);

/// 收集产品的一些行为，sdc 和 sa 联合打造 drpf 平台接受产品端发送的http请求。成功返回 0
/// - Parameter jsondata: 游戏提供的参数的json字符串，必需包含project， source， type三个字段, 游戏还可以自定义字段
int unisdkDRPF(const char* jsondata);

/// 内嵌WKWebView视图打开网页，用于问卷调查，更加推荐使用拓展接口调用
/// - Parameter url: 网页地址
void unisdkOpenSurvey(const char* url);

/// 关闭调查问卷页面，更加推荐使用拓展接口调用
void unisdkCloseSurvey(void);

/// 绑定/验证手机号
void unisdkVerifyMobile(int resultCode);

/// 用于新版CC录屏录入游戏声音
void unisdkPushGameVoice(const char* pcmData, int size, int sampleRate, int bitsPerSample, int channels);

/// 广告sdk监控事件
/// - Parameters:
///   - eventName: 事件名称
///   - jsondata: json字符串
void unisdkTrackCustomEvent(const char* eventName, const char* jsondata);

/// 关闭闪屏
void unisdkCloseFlash(void);

// MARK: QRCode

/// 使用一级渠道的二维码扫描
/// - Parameters:
///   - extra: 二维码参数，可以传空
///   - requestCode: 请求码，默认为 0
void unisdkPresentQRCodeScanner(const char* extra, int requestCode);

/// 生成二维码
/// - Parameters:
///   - content: 二维码内容，代码跟据输入的字符串content，把content转成二维码
///   - width: 二维码的宽度（单位：像素）
///   - height: 二维码的高度（单位：像素）
///   - fileName: 二维码图片文件的文件名
///   - logo: 添加的logo 路径，不需要时可传空
void unisdkCreateQRCode(const char* content, int width, int height, const char* fileName, const char* logo);

/// 使用 NtQRCode 显示扫描二维码的界面
/// - Parameter extra:  附加参数，空字符串为摄像头扫描，unisdk:recognize为打开相册扫描，unisdk:图片路径为识别指定图片
void unisdkScannerQRCode(const char* extra);

// MARK: - Prop

/// get SDK properties of string type
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkGetPropStr(const char* prop);
/// set SDK properties of string type
void unisdkSetPropStr(const char* prop, const char* value);

/// get SDK properties of int type
int unisdkGetPropInt(const char* prop, int defaultValue);
/// set SDK properties of int type
void unisdkSetPropInt(const char* prop, int value);

/// get SDK properties of void* type
void* unisdkGetProp(const char* prop);
/// set SDK properties of void* type
void unisdkSetProp(const char* prop, void* value);

// MARK: - Orbit
   
/// orbit init
void unisdkInitOrbit(void);

/// start call orbit
void unisdkOrbitExtendFunc(const char* jsondata);

/// get orbit version
///
/// - Note: Please copy the return value in time for use. Do not call free on the return value.
const char* unisdkOrbitVersion(void);

// MARK: - Extend Func

/// start call extend function
void unisdkExtendFunc(const char* jsondata);

#ifdef __cplusplus
}
#endif

// MARK: - iOS

#if defined(__APPLE__)
#include "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UniSDKAppController: NSObject

/// Tells the delegate that the launch process is almost done and the app is almost ready to run.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/// Asks the delegate to open a resource identified by a URL.
/// - Version: iOS 4.2 - 9.0
- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/// Asks the delegate to open a resource specified by a URL, and provides a dictionary of launch options.
/// - Version: iOS 9.0+
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

/// Tells the delegate that the data for continuing an activity is available. Universal Link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler;

@end

NS_ASSUME_NONNULL_END

#endif /* TARGET_OS_IPHONE */
#endif /* __APPLE__ */


#endif /* UniSDKWorker_h */
