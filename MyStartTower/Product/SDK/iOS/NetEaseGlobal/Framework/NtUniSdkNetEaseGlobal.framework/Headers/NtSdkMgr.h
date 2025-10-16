//
//  NtSdkMgr.h
//  NtUniSdk
//
//  Created by UniSDK on 14-5-28.
//  Copyright (c) 2014年 Game-NetEase. All rights reserved.
//

#import "NtGamerInterface.h"

@interface NtSdkMgr: NSObject

/**
 *  初始化，读取data配置文件
 */
+ (void) ntInit;
//+ (void) initialize;

/**
 *  设置要使用的渠道SDK
 *  @param sdkName 参考 NtConstProp.h
 */
+ (void) setSdk:(NSString *)sdkName;

/**
 *  添加渠道SDK
 */
+ (void) addSdk:(NSString *)sdkName;

/**
 *  获取当前渠道SDK的单例
 */
+ (id<NtGamerInterface>) getInst;

/**
 *  获取指定渠道SDK的单例
 */
+ (id<NtGamerInterface>) getInst:(NSString *)sdkName;
@end

///**
// *  @brief 4 + (void) setSdk: (NSString*) Sdk;
// */
//extern NSString* const NT_SDK_NETEASE;
//extern NSString* const NT_SDK_YIXIN;
//
//extern NSString* const NT_SDK_LINE;
//extern NSString* const NT_SDK_MOBVISTA_ANONYMOUS;
