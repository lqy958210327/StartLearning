//
//  KaiYingSDK.m
//  UnityFramework
//
//  Created by 刘旻 on 2024/1/30.
//

#import "./SDKController.h"

@implementation SDKController
- (id)init
{
    if ((self = [super init]))
    {
        self.appid = @"306";
        self.gameid = @"975";
        self.isLogin = false;
    }
    
    return self;
}

+ (SDKController *)shareSdkController
{
    static SDKController *instance = nil;
    if(!instance)
    {
        instance = [[self alloc] init];
    }
    
    return instance;
}

- (void)InitSDK :(NSString*) objName{
    self.objName = objName;
    [[mhSSDKMager shareSdk] setAppId:self.appid gameId:self.gameid delegate:self];
    
    
}


- (void)mhSActiveStatus:(mhSActiveStatus)status info:(NSDictionary *)info {
    if (status == mhSActiveStatusSuccess) {
        NSLog(@"SDK激活成功");
        UnitySendMessage([self.objName UTF8String], "SDK_InitCallBack", "true");
        //[self Login];
        } else if (status == mhSActiveStatusError) {
            //激活失败、获取配置失败
            NSLog(@"sdk激活：msg：%@---status：%@",[info objectForKey:@"msg"],[info objectForKey:@"status"]);
            UnitySendMessage([self.objName UTF8String], "SDK_InitCallBack", "false");
        } else if (status == mhSActiveStatusParameterLogicError) {
            //参数传入错误、或者调用逻辑不对（请在激活成功后，调用其他功能）
            NSLog(@"sdk激活：msg：%@---status：%@",[info objectForKey:@"msg"],[info objectForKey:@"status"]);
            UnitySendMessage([self.objName UTF8String], "SDK_InitCallBack", "false");
        } else if (status == mhSActiveStatusNoNetwork) {
            //没有网络，连接网络后，重新发起激活
            NSLog(@"没有网络，连接网络后，重新发起激活");
            //UnitySendMessage([self.objName UTF8String], "SDK_InitCallBack", "false");
            dispatch_async(dispatch_get_main_queue(),^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络异常，请重试!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [[mhSSDKMager shareSdk] setAppId:self.appid gameId:self.gameid delegate:self];
                }];

                [alertController addAction:determineAction];
                [UnityGetGLViewController() presentViewController:alertController animated:YES completion:nil];
            });
        }
}

- (void)mhSLoginStatus:(mhSLoginStatus)status info:(NSDictionary *)info {
    if (status == mhSLoginStatusSuccess) { //登陆成功
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        NSString* token = [info objectForKey:@"token"];
        NSString* uid = [info objectForKey:@"uid"];
        NSString* loginTime = [info objectForKey:@"loginTime"];
        
        [data setObject:uid forKey:@"userid"];
        [data setObject:token forKey:@"token"];
        [data setObject:loginTime forKey:@"time"];
        [data setObject:[self.pList objectForKey:@"gid"] forKey:@"gid"];
        [data setObject:[self.pList objectForKey:@"channel"] forKey:@"channel"];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
        NSString* json = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"登录成功: %@", json);
        self.isLogin = true;
        UnitySendMessage([self.objName UTF8String], "SDK_LoginSuccess", [json UTF8String]);
        
        
        [[mhSSDKMager shareSdk] addLogType:mhSLogTypeLoginGame
                                 customType:@""
                                        sid:@""
                                   roleName:@""
                                     roleId:@""
                                      level:0
                               otherParams:@{}];
    } else if (status == mhSLoginStatusError) { //登陆失败
        
    } else if (status == mhSLoginStatusNone) { //未登陆
        
    } else if (status == mhSLoginStatusLogout) { //退出登录
        NSLog(@"退出登录");
        if(self.isLogin){
            UnitySendMessage([self.objName UTF8String], "SDK_LogOut", "");
        }
    } else if (status == mhSLoginStatusAgreementError) {
        //拒绝了用户协议
        NSLog(@"拒绝了用户协议（继续展示SDK或者退出游戏）");
        //示例继续展示SDK
        [[mhSSDKMager shareSdk] showSDKView];
    }
}

- (void)mhSPrivacyAgreementStatus:(mhSPrivacyAgreementStatus)status info:(NSDictionary *)info {
    
}

- (void)mhSTotailStatus:(mhSTotalStatus)status type:(mhSTotalType)type info:(NSDictionary *)info {
    NSLog(@"支付信息：%@", info);
    if (status == mhSTotalStatusSuccess) {
        //支付成功
    } else if (status == mhSTotalStatusError) {
        //支付失败
    } else if (status == mhSTotalStatusCancel) {
        //支付取消
    } else if (status == mhSTotalStatusRealNameFaild) {
        //支付失败，未完成实名认证
    }
}

- (void)Login {
    NSLog(@"游戏登录");
    [[mhSSDKMager shareSdk] showSDKView];
}

- (void)Logout {
    NSLog(@"游戏登出");
    [[mhSSDKMager shareSdk] logout];
}

- (void)ShowUserAgrement {
    [[mhSSDKMager shareSdk] showSDKUserAgreementView];
}

- (void)ShowCustomerService:(NSString*) par {
    [[mhSSDKMager shareSdk] showCustomerService];
}

- (void)ShowSDKUserCenter {
    [[mhSSDKMager shareSdk] showSDKUserCenter];
}

- (void)UpLoadLog:(NSString *)log {
    NSData* data = [log dataUsingEncoding:  NSUTF8StringEncoding];
    NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if(array == NULL)
    {
        NSLog(@"Json格式不正确");
        return;
    }
    
    NSString* logType = array[0];
    int logTypeI = [logType intValue];
    NSString* sid = array[2];
    NSString* roleName = array[4];
    NSString* roleId = array[3];
    int roleLevel = [array[6] intValue];
    
    [[mhSSDKMager shareSdk] addLogType:logTypeI
                             customType:@""
                                    sid:sid
                               roleName:roleName
                                 roleId:roleId
                                  level:roleLevel
                           otherParams:@{}];
}

- (void)Pay:(NSString *)payInfo {
    NSData* data = [payInfo dataUsingEncoding:  NSUTF8StringEncoding];
    NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if(array == NULL)
    {
        NSLog(@"Json格式不正确");
        return;
    }
    
    
    NSString* rmb = array[0];
    NSString* uid = array[1];
    NSString* gameUserName = array[2];
    NSString* productId = [NSString stringWithFormat:@"%@.%@", [[mhSSDKMager shareSdk] getBundleId], rmb];
    NSString* productName = array[4];
    NSString* roleId = array[5];
    NSString* serverId = array[6];
    NSString* gameOrderId = array[7];
    NSString* callbackUrl = array[8];

    NSDictionary *parameters = @{@"extra1": array[9], @"extra2": array[10]};
    NSString* serverName = array[11];
    NSString* roleLevel = array[12];
    [[mhSSDKMager shareSdk] totalSId:serverId
                               roleId:roleId
                             roleName:gameUserName
                            productId:productId
                                money:rmb
                              orderId:gameOrderId
                           parameters:parameters];
}

@end
