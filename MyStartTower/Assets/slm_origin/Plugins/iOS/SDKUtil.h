//
//  SDKUtil.h
//  UnityFramework
//
//  Created by 刘旻 on 2024/1/30.
//

#ifndef SDKUtil_h
#define SDKUtil_h

@interface SDKUitl : NSObject

+ (void) InitSDK : (NSString*) str;
+ (void) Login;
+ (void) Logout;
+ (void) ShowUserAgrement;
//显示用户中心
+ (void) ShowSDKUserCenter;
//显示客服
+ (void) ShowCustomerService : (NSString *)josn;
//上传日志
+ (void) UpLoadLog : (NSString *) log;
+ (void) SaveImage : (NSString*) imagePath;
+ (void) Pay : (NSString *) payInfo;

+ (NSString*)GetInfoPlis:(NSString *)key;
+ (NSString*)GetChannelID;
@end

#endif /* SDKUtil_h */
