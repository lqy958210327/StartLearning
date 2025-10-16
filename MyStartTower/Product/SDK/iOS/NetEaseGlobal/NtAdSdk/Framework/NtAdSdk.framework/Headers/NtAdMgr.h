//
//  NtShareMgr.h
//  NtShareSdk
//
//  Created by Huang Quanyong on 14-7-2.
//  Copyright (c) 2014年 Stupid Dumb Kids. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NtAdPlatform.h"

static NSString * const UNISDK_SDK_VERSION_NTADSDK = @"unisdk_sdk_version_ntadsdk_1.3.0";
/**
 *  @brief 广告Sdk管理类
 */
@interface NtAdMgr : NSObject
{
@private
    NSMutableDictionary* platforms;
}
@property (nonatomic, strong) NSDictionary *propDict;

/**
 *  @brief 获取单例
 *  @return 单例对象
 */
+ (NtAdMgr*) getInst;

/**
 *  @brief 在注册的广告平台激活
 *  Simply add the following to your UIApplicationDelegate applicationDidBecomeActive selector: 
 *  [[NtAdMgr getInst] activateApp];
 */
- (void) activateApp;

/**
 *  @brief 完成注册
 *
 */
- (void) completedRegistration;

/**
 *  @brief 事件监控统计
 
 *  @param event 如：充值$9.99，[object trackEvent:AD_SDK_PURCHASE withValue:@{AD_PLATFORM_ADJUST:@"7eqlvu"}];
 */
- (void) trackEvent:(NSString *)event withValue:(NSDictionary *)value;
//使用NSString参数，只是通过json格式的NSDictionary
- (void) trackEvent:(NSString *)event withValueString:(NSString *)value;

/**
 *  @brief 事件监控统计(目前AF/FB使用)
 
 *  @param event AF定义事件，[object trackEvent:@"af_add_to_cart" withValue:@{AD_PLATFORM_APPSFLYER:@{@"af_level":@"1"}}];
 */
- (void) trackEvent:(NSString *)event withValues:(NSDictionary *)value;
//使用NSString参数，只是通过json格式的NSDictionary
- (void) trackEvent:(NSString *)event withValuesString:(NSString *)value;

/**
 *  @brief 事件监控统计
 *  @param event 如：充值$9.99，[object trackEvent:AD_SDK_PURCHASE withValue:@{AD_PLATFORM_ADJUST:@"7eqlvu"} withParameters:nil];
 */
- (void) trackEvent:(NSString *)event withValue:(NSDictionary *)value withParameters:(NSDictionary *)parameters;
//使用NSString参数，只是通过json格式的NSDictionary
- (void) trackEvent:(NSString *)event withValueString:(NSString *)value withParametersString:(NSString *)parameters;

/**
 *  @brief 通知UniSDK
 *
 */
- (void) noticeUniSDK;

/**
 *  @brief 在APP运行的时机点调用下面函数
 *
 *  在implementation AppDelegate中添加以下代码，以响应某些渠道要求。
 *  - (void)applicationWillTerminate:(UIApplication *)application
 *  {
 *       return [[NtSdkMgr getInst] applicationWillTerminate:application];
 *  }
 *
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(void)applicationDidBecomeActive:(UIApplication *)application;
-(void)applicationWillResignActive:(UIApplication *)application;
-(void)applicationWillTerminate:(UIApplication *)application;
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;     // adjust使用
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

/**
 *  @brief 注册广告平台，由子渠道在register接口调用，1.3.0 开始支持通过registAdPlatformClassName注册后由广告母包调用
 *
 *  @param newPlatform  广告平台
 *  @param key                    平台对应的key
 */
- (void)registerPlatform: (NtAdPlatform *) newPlatform forKey: (NSString*) key;

/**
 *  @brief 注册新的广告平台类名，新增广告平台在load接口调用注册自己继承NtAdPlatform的类名，在ntInit接口调用时会统一注册实例，一般只有不在defaultAdPlatforms或者配置文件的渠道才需要调用
 *
 *  @param className 继承NtAdPlatform的类名
 *  @param key              平台对应的key
 */
- (void)registAdPlatformClassName:(NSString *)className key:(NSString *)key;

/**
 *  @brief 自动注册广告平台
 *
 */
- (void) ntInit;

@end
