//
//  NtSharePlatform.h
//  NtShareSdk
//
//  Created by Huang Quanyong on 14-6-26.
//  Copyright (c) 2014年 Stupid Dumb Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define __UNIMPLEMENTED_METHOD          NTLog(@"Unimplemented %s Method %d",__FUNCTION__, __LINE__)

/**
 *  @brief 广告平台基类
 */
@interface NtAdPlatform : NSObject

/**
 *  @brief 激活app
 *
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
//使用NSString参数，只是通过json各式的NSDictionary
- (void) trackEvent:(NSString *)event withValueString:(NSString *)value;

/**
 *  @brief 事件监控统计(目前AF使用)
 
 *  @param event AF定义事件，[object trackEvent:@"af_add_to_cart" withValue:@{AD_PLATFORM_APPSFLYER:@{@"af_level":@"1"}}];
 */
- (void) trackEvent:(NSString *)event withValues:(NSDictionary *)value;
//使用NSString参数，只是通过json格式的NSDictionary
- (void) trackEvent:(NSString *)event withValuesString:(NSString *)value;

/**
 *  @brief 事件监控统计（加多一个参数）
 *  @param event 如：充值$9.99，[object trackEvent:AD_SDK_PURCHASE withValue:@{AD_PLATFORM_ADJUST:@"7eqlvu"}];
 */
- (void) trackEvent:(NSString *)event withValue:(NSDictionary *)value withParameters:(NSDictionary *)parameters;
//使用NSString参数，只是通过json各式的NSDictionary
- (void) trackEvent:(NSString *)event withValueString:(NSString *)value withParametersString:(NSString *)parameters;

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
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
@end
