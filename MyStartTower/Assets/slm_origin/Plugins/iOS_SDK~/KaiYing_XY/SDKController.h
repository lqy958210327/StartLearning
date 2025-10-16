//
//  KaiYingSDK.h
//  UnityFramework
//
//  Created by 刘旻 on 2024/1/30.
//

#ifndef KaiYingSDK_h
#define KaiYingSDK_h
#import <mhSDK/mhSSDKMager.h>
#import "../SDKControllerBase.h"

@interface SDKController : SDKControllerBase<mhSDelegate>
@property NSString* const appid;
@property NSString* const gameid;
@property Boolean isLogin;

//单例
+ (SDKController *)shareSdkController;

- (void) InitSDK : (NSString*) objName;
- (void) Login;
- (void) Logout;
- (void) ShowUserAgrement;
- (void) ShowSDKUserCenter;
- (void) ShowCustomerService:(NSString*) par;
- (void) UpLoadLog : (NSString *) log;
- (void) Pay : (NSString *) payInfo;
@end


#endif /* KaiYingSDK_h */
