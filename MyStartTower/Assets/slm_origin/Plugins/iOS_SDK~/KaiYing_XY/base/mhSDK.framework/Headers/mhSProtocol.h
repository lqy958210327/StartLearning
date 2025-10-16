

#ifndef mhSProtocol_h
#define mhSProtocol_h

@protocol mhSDelegate <NSObject>

/**
 SDK隐私协议回调

 @param status 回调状态
 @param info 回调信息
 */
@required
- (void)mhSPrivacyAgreementStatus:(mhSPrivacyAgreementStatus)status info:(NSDictionary *)info;

/**
 SDK激活信息回调

 @param status 回调状态
 @param info 回调信息
 */
@required
- (void)mhSActiveStatus:(mhSActiveStatus)status info:(NSDictionary *)info;


/**
 登陆信息回调

 @param status 登陆状态
 @param info 回调信息
 */
@required
- (void)mhSLoginStatus:(mhSLoginStatus)status info:(NSDictionary *)info;


/**
 支付信息回调

 @param status 支付状态
 @param type 支付类型
 @param info 回调信息
 */
@required
- (void)mhSTotailStatus:(mhSTotalStatus)status type:(mhSTotalType)type info:(NSDictionary *)info;


/**
 日志上报回调

 @param status 上报状态
 @param type 日志类型
 @param info 回调信息
 */
@optional
- (void)mhSLogStatus:(mhSLogStatus)status type:(mhSLogType)type info:(NSDictionary *)info;

/**
 保存图片回调

 @param isSuccess 返回结果 1 成功 0 失败
 @param msg 返回信息
 */
@optional
- (void)mhSsaveImage:(BOOL)isSuccess msg:(NSString *)msg;

@end





#endif /* mhSProtocol_h */
