//
//  regexSDK.h
//  regexSDK
//
//  Created by GW-He on 15/10/12.
//  Copyright © 2015年 Netease. All rights reserved.
//  SDK version 4.2.6
/*
 SDK会获取设备的IDFV作为唯一标识。
 SDK初始化时会上报IDFV、SDK运行log等信息。
 正则字库文件会根据初始化接口返回的信息决定是否进行下载。
 兼容iOS7.0以上系统。
 */


#import <Foundation/Foundation.h>

/**
 拦截:仅玩家可见，其他玩家不可见
 屏蔽:引导玩家修改内容
 */
typedef enum kRRetValue {
    kRRetError          = 100,//未知错误
    kRRetRegexInitError = 101,//正则初始化错误
    kRRetNotMatch       = 200,//审核通过
    kRRetMatchIntercept = 201,//审核不通过, 拦截
    kRRetMatchShield    = 202,//审核不通过, 屏蔽
    kRRetMatch          = 203,//审核不通过,内部用
    kRRetInit           = 204,//保留
    kRRetParamError     = 205,//参数错误，nil或空
    kRRetMatchReplace   = 206,//审核内容需要替换
    kRRetMatchRemind    = 207,//防骗提醒
    kRRetTimeout        = 504,//超时
} kRRetValue;

@interface EnvironmentSDK : NSObject

/**
 *  SDK初始化接口
 *  @param gameid 游戏id代码，如g1，需小写
 *  @param rkey 用于对字库文件进行解码的key，需小写
 *  @param host SDK初始化的Host，需小写
 *  参数gameid、rkey、host会在申请接入环境SDK的时候提供
 */
+ (void)initSDK:(NSString *)gameid
           rkey:(NSString *)rkey
           host:(NSString *)host;

/**
 *  SDK初始化接口, 可设置是否启用测试模式。
 *  测试模式下会拉取对应的测试正则库。
 *  @param isTestEnable YES 改用测试的正则, NO 用正式的正则
 *  @param gameid 游戏id代码，如g1，需小写
 *  @param rkey 用于对字库文件进行解码的key，需小写
 *  @param host SDK初始化的Host，需小写
 *  参数gameid、rkey、host会在申请接入环境SDK的时候提供
 */
+ (void)initSDK:(NSString *)gameid
           rkey:(NSString *)rkey
           host:(NSString *)host
     testEnable:(BOOL)isTestEnable;

/**
 *  log打印控制接口
 *
 *  @param enable YES 开启, NO 关闭
 */
+ (void)setLogEnable:(BOOL)enable;

/**
 *  获取环境SDK版本号
 */
+ (NSString *)getSDKVersion;

/**
 *  获取当前使用字库版本号
 */
+ (NSString *)getRegularVersion;

#pragma mark - V2版本接口

/**
 *  昵称审核接口
 *
 *  @param nickname 需要审查的昵称
 *
 *  @return 返回值为NSDictionary类型，具体包含以下几个对象：
 1、code 处理结果的状态码，具体有四种情况：
 --100：表示处理过程中发生错误（这种情况可认为通过）；
 --200：表示审核内容通过；
 --202：表示需要屏蔽内容；
 2、message 处理结果的文字提示；
 3、regularId 匹配到的正则id, 没有匹配到是为 -1
 */
+ (NSDictionary *)reviewNicknameV2:(NSString *)nickname;

/**
 *  发言审核接口
 *
 *  @param content 发言的内容
 *  @param level   用户的等级
 *  @param channel 发言的频道
 *  content、level、channel 要求非空,且是字符串类型
 *
 *  @return 返回值为NSDictionary类型，具体包含以下几个对象：
 1、code(整型):
 处理结果的状态码，具体有以下情况：
 --100：表示处理过程中发生错误（这种情况可认为通过）；
 --101：表示正则初始化错误（这种情况可认为通过）
 --200：表示审核内容通过；
 --201：表示需要拦截内容；
 --202：表示需要屏蔽内容；
 --205：表示参数错误，nil或空
 --206：表示需要替换内容；
 --504：超时（这种情况可认为通过）
 2、message(字符串) 处理结果的文字提示；若需要替换内容，则为替换后的内容
 3、regularId(字符串) 匹配到的正则id, 没有匹配到是为 -1；
 *  @注意：发言审核接口为同步接口，请根据实际情况，考虑放到异步线程中调用。另外，根据最低限制原则，接入时可把非 201， 202 的都当通过。
 */
+ (NSDictionary *)reviewWordsV2:(NSString *)content level:(NSString *)level channel:(NSString *)channel;

/**
 *  @param extraInfo json格式字符串 
 *  推荐赋值如下:
 *  UNISDK文档 : https://unisdk.nie.netease.com/doc/page/socialmatrix/zh/07_server/02_uslog#us
 *  1. account_id: 注册的用户id
 *  2. host_id:服务器id
 *  3. uid:用户登录id
 *
 *  )
 */
+ (NSString *)setExtraInfo:(NSString *)extraInfo;

@end
