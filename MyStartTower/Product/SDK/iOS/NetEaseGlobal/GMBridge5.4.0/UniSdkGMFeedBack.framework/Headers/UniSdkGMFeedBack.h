//
//  UniSdkGMFeedBack.h
//  UniSdkGMFeedBack
//
//  Created by HuangZizhu on 12/8/14.
//  Copyright (c) 2014 HuangZizhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//! Project version number for UniSdkGMFeedBack.
FOUNDATION_EXPORT double UniSdkGMFeedBackVersionNumber;

//! Project version string for UniSdkGMFeedBack.
FOUNDATION_EXPORT const unsigned char UniSdkGMFeedBackVersionString[];

static NSString * _Nonnull const UNISDK_SDK_VERSION_GMBRIDGE = @"unisdk_sdk_version_gmbridge_5.4.0";

#define theGMInst [UniSdkGMFeedBack sharedInstance]

//主窗口关闭的通知
#define NT_NOTIFICATION_GM_CLOSE @"NT_NOTIFICATION_GM_CLOSE"
//语音文件下载完成的通知
#define NT_NOTIFICATION_GM_VOICE_DOWNLOADED @"NT_NOTIFICATION_GM_VOICE_DOWNLOADED"
//悬浮窗按钮图标下载完成通知
#define NT_NOTIFICATION_GM_ICON_DOWNLOADED @"NT_NOTIFICATION_GM_ICON_DOWNLOADED"
//改变主窗口frame的通知
#define NT_NOTIFICATION_GM_RESIZE_WINDOW @"NT_NOTIFICATION_GM_RESIZE_WINDOW"
//Token过期或为空需要重新生成的通知
#define NT_NOTIFICATION_GM_INVALID_TOKEN @"NT_NOTIFICATION_GM_INVALID_TOKEN"

//=====================================================================================
//          Delegate, SDK的回调，
//=====================================================================================
@protocol UniSdkGMFeedBackDelegate <NSObject>
//客服页面关闭
- (void)onGMWebviewWillClose;

//客服页面回退
- (void)onGMWebviewBack;

//token过期（或者没有token）需要请求新, 在更新token之前必须先设置角色的roleID
- (void)onInvalidToken;
@end




//=====================================================================================
//          Interface, 客服SDK的Public接口，
//=====================================================================================
@interface UniSdkGMFeedBack : NSObject
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, weak) id<UniSdkGMFeedBackDelegate> delegate;//接收客服SDK回调的对象
@property (nonatomic, strong) NSString *appCode;//游戏公司内ID， 向客服后台咨询。
@property (nonatomic, strong) NSString *language;//SDK提示的语言（页面上的语言需要联系客服后台）
@property (nonatomic, strong) NSString *roleID; //角色名，游戏内角色ID改变了这个值要重新设置。
@property (nonatomic, strong) NSString *token;  //token[geter只能拿到token串(若过期了是nil)，setter设置进去的应该是一个包含过期时间、menu等其他信息的json]；
@property (nonatomic, assign) BOOL floatButtonVisible; //释放悬浮框(release掉）

/// 优先使用unisdk新版开日志方法（unisdk_log_open），不支持运行时动态关闭已开启的Debug日志
@property (nonatomic, assign) BOOL debugMode;   //是否打印日志

@property (nonatomic, strong, readonly) NSString *refer;    //主页地址
@property (nonatomic, strong, readonly) NSString *version;  //客服SDK版本
@property (nonatomic, assign, readonly) BOOL isOpening;//客服页面是否打开
@property (nonatomic, assign) BOOL respondLowerView;//半屏时下层的试图是否可响应（默认不响应）
@property (nonatomic, assign) UIInterfaceOrientationMask orientation;//支持的方向（默认横屏）
@property (nonatomic, assign) BOOL shouldAutorotate;

@property (nonatomic, strong, readonly) NSString *host;    // url host与refer拼接
@property (nonatomic, assign) BOOL gmShowLoading;   //是否启用loading
@property (nonatomic, assign) BOOL gmUseFonts; //是否拦截替换字体集
@property (nonatomic, assign) BOOL isUnrealEngine; //是否为虚幻引擎
@property (nonatomic, copy)NSString *webview_background_color;
@property (nonatomic, copy) NSString *useragent_extend; //产品自定义的useragen信息，为了和安卓统一而加上的

+ (UniSdkGMFeedBack *)sharedInstance;

/**
 *  AppDelegate 调用
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/**
 *  Deprecated
 */
- (void)createFloatWindowAndShowImmediately:(BOOL)show;

/**
 *  @brief  显示GM页面，客户或者精灵页面，需要指定url，如: http://gm.163.com/xxxx url拼接规则参见使用文档, 为nil打开主页
 *  强烈建议此参数填nil, sdk会校验token是否过期，token过期游戏会收到一个token无效的通知，你在此设置有效的token时，会自己打开主页。
 *  @param stringUrl
 */
- (void)showWebViewWithUrl:(nullable NSString *)stringUrl;

/**
 *收到游戏服推过来的message
 * 1. json格式。
 * 2. 在设置之前请确保设置过token。
 * 3. 请向客服后台确定，他们发过来的token串里包括，浮标的信息，和主页地址
 *
 * -1. Warning：切换手机之后，用户卸载重装之后，越狱用户手动删除文件之后，之前的未读消息就看不到红点了。
 * -2. 当前的是逐条推消息的格式如下（目前只是用来显示红点，还没消息预览的需求）{"code":200, "gmsdk_type":"red_menu", "menu_id":"xxxx", "show_msg":"xxxx"}
 * -3. 往下【*】是写给维护客服SDK的同学看的，虽然策划说这个以后不会再改，但是以防万一。
 * -*. 一次刷多条（服务端不支持）{"msgs":[{"gmsdk_type":"red_menu", "menu_id":"xxxx", "show_msg":"xxxx"}, {...}], "code":200} 防止-2
 */
- (void)reciveMessage:(NSString *)message;

/**
 获取app的主window，由于sdk内存在自己的window，直接通过”[UIApplication
 sharedApplication].keyWindow”获取的window得到的结果可能不是预期的，所以提供这个方法来获取app的主
 window，需要注意的是，必须在 “- (BOOL)application:(UIApplication *)application
 didFinishLaunchingWithOptions:(NSDictionary *)launchOptions” 方法之后获取，不然返回的是空值
 
 @return app主window
 */
- (UIWindow  *)applicationMainWindow;

/**
 关闭webview接口
 */
- (void)ntDestroy;

/**
 调用javascript接口

 @param jsonStr json字符串
 */
- (void)callJavascriptWithJsonString:(NSString *)jsonStr;

/// unisdk获取user ticket后通知给前端的方法
/// @param userTicket
- (void)callbackWithUserTicket:(NSString *)userTicket;

//=====================================================================================
//          分隔线, 4.1 以后以下接口均为空函数，
//=====================================================================================

/**
 *  使用token登录,方块西游专用接口
 *  @param token
 */
- (void)loginWithToken:(NSString *)token andAppCode:(NSString *)appCode DEPRECATED_MSG_ATTRIBUTE("此方法在4.1后已弃用");
/**
 *  使用token登录,请不要调用这个接口
 *  @param token
 */
- (void)loginWithToken:(NSString *)token andAppCode:(NSString *)appCode fromeOuterNet:(BOOL)outer DEPRECATED_MSG_ATTRIBUTE("此方法在4.1后已弃用");

/**
 *  显示上传图片的页面（测试用，产品不需要调用这个接口）
 */
- (void)showUploadPicView:(NSString *)appCode DEPRECATED_MSG_ATTRIBUTE("此方法在4.1后已弃用");

/**
 *  是否是指定的uri
 *  @param uri 字符串
 *  @return YES\NO
 */
- (BOOL)isCustomUri:(NSString *)uri DEPRECATED_MSG_ATTRIBUTE("此方法在4.1后已弃用");

//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator;

- (void)applicationWillResignActive:(UIApplication *)application DEPRECATED_MSG_ATTRIBUTE("此方法在4.1后已弃用");

NS_ASSUME_NONNULL_END
@end
