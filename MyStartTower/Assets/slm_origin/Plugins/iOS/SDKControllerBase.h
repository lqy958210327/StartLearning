//
//  SDKControllerBase.h
//  UnityFramework
//
//  Created by 刘旻 on 2024/1/30.
//

#ifndef SDKControllerBase_h
#define SDKControllerBase_h

@interface SDKControllerBase : NSObject
@property (nonatomic) NSString* objName;
@property (nonatomic) NSDictionary *pList;

- (void) InitSDK : (NSString *) objName;
- (void) Login;
- (void) Logout;
- (void) ShowUserAgrement;
//显示用户中心
- (void) ShowSDKUserCenter;
//显示客服
- (void) ShowCustomerService : (NSString *) par;
//上传日志
- (void) UpLoadLog : (NSString *) log;
- (void) imageSaved: ( UIImage *) image didFinishSavingWithError:( NSError *)error
          contextInfo: ( void *) contextInfo;
- (void) Pay : (NSString *) payInfo;
@end

#endif /* SDKControllerBase_h */
