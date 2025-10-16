//
//  mhSSDKMager.h
//  xyxSdk
//
//  Created by liuchunhao on 2019/8/26.
//  Copyright © 2019 Platform. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mhSEnum.h"
#import "mhSProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface mhSSDKMager : NSObject

/**
 代理回调  --> 见 mhSProtocol.h 头文件
 */
@property (nonatomic,weak) id<mhSDelegate> delegate;


/**
 获取sdk 单例
 
sdk 支持对象函数，使用单例进行调用
 @return sdk 单例
 */
+ (mhSSDKMager *)shareSdk;

/**
 初始化sdk
 
 @param appid appid
 @param gameId gameid
 @param delegate delegate
 */
- (void)setAppId:(nonnull NSString *)appid gameId:(nonnull NSString *)gameId delegate:(id <mhSDelegate>)delegate;


/**
 调起结算
 
 @param sid 区服 id
 @param roleId 角色id
 @param roleName 角色名
 @param productId 产品id（推荐使用【包名+金额】动态拼接）
 @param money 支付金额
 @param orderid 订单号
 @param parameters 透传参数（可选，键值（extra1、extra2）不可更改，键值对可删减，未使用直接传nil）
 */
- (void)totalSId:(nonnull NSString *)sid roleId:(nonnull NSString *)roleId roleName:(nonnull NSString *)roleName productId:(nonnull NSString *)productId money:(nonnull NSString *)money orderId:(nonnull NSString *)orderid parameters:(nullable NSDictionary *)parameters;


/**
 日志上报
 
 @param type 日志类型（登陆游戏、创建角色、开始游戏、角色升级，4种类型必须对接）
 @param customType 自定义type（只在 type 类型为 mhSLogTypeCustom 时使用，未使用传@""）
 @param sid 区服id
 @param roleName 角色名
 @param roleId 角色id
 @param level 角色等级
 @param otherParams 其他参数
 */
- (void)addLogType:(mhSLogType)type customType:(nonnull NSString *)customType sid:(nonnull NSString *)sid roleName:(nonnull NSString *)roleName roleId:(nonnull NSString *)roleId level:(NSInteger)level otherParams:(NSDictionary *)otherParams;

/*
 获取包名
 */
- (NSString *)getBundleId;

/**
 通过登录回调,拉取本地账号数据
 */
- (void)getUserInfo;

/**
 退出登录状态
 */
- (void)logout;

#pragma mark 状态查询

/**
 是否登陆
 */
- (BOOL)isLogin;

/**
 是否激活
 */
- (BOOL)isActive;


/**
 展示SDK
*/
- (void)showSDKView;
/**
 展示SDK用户中心
*/
- (void)showSDKUserCenter;
/*
 展示用户协议及隐私协议
 */
- (void)showSDKUserAgreementView;

/**联系客服*/
- (void)showCustomerService;

/**保存图片到相册*/
- (void)savePhotoToLocalAlbum:(UIImage *)image;

/*
 是否展示状态栏 默认隐藏
 */
- (void)hideStatusBar:(BOOL)status;

/*
 系统延迟手势方向 默认全方向
 */
- (void)screenEdgesDeferringSystemGestures:(UIRectEdge)screenEdges;

/*
 是否隐藏HomeIndicator 默认显示
 */
- (void)prefersHomeIndicatorAutoHidden:(BOOL)status;

/**
 初始化【激活SDK】

 @param launchOptions 冷启动参数
 @param enable 是否允许采集idfa
 */

-(void)uploadOptions:(NSDictionary *)launchOptions enableIdfa:(BOOL)enable;

/**
 Deeplink clickid采集

 @param openUrl url
 */

-(void)uploadClickidUrl:(NSURL *)openUrl;

@end

NS_ASSUME_NONNULL_END
