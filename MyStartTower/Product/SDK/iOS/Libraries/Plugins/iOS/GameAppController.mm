#import "UnityAppController.h"
#import "NetEaseGlobal/Framework/NtUniSdkNetEaseGlobal.framework/Headers/NtSdkMgr.h"
#import "NetEaseGlobal/Framework/NtUniSdkNetEaseGlobal.framework/Headers/NtNotification.h"
#import "NetEaseGlobal/Framework/NtUniSdkNetEaseGlobal.framework/Headers/NtConstProp.h"
#import "NetEaseGlobal/Framework/NtUniSdkNetEaseGlobal.framework/Headers/NtOrderInfo.h"
#import "EventCenter.h"
#import "GameUtils.h"
#import "GameAppController.h"
#import "NetEaseGlobal/2.10.5/NTCrashHunterKit.framework/Headers/NTCrashHunterKit.h"
#import "NetEaseGlobal/NtAdSdk/Framework/NtAdSdk.framework/Headers/NtadSdk.h"
#import "NetEaseGlobal/EnvSDK/EnvironmentSDK.h"

@interface GameAppController : UnityAppController

@end

IMPL_APP_CONTROLLER_SUBCLASS (GameAppController)


static BOOL isDiabaleLogin = false;
static BOOL _isLoginSuccess = false;
NSString* appInstanceId = @"";
static NSNumber* isRoot = @0;

@implementation GameAppController

//------------------------------------------------生命周期-------------------------------------------------------

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    NSLog(@"App 启动完成");
    _isLoginSuccess = false;
    startTime = getTimeStamp();
    //App启动
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    [[NtSdkMgr getInst] setPropInt:UNISDK_JF_GAS3 as:1];
    [[NtSdkMgr getInst] setPropStr:NT_JF_GAMEID as:@"ma155naxx2gb"];
    [[NtSdkMgr getInst] setPropStr:NT_JF_LOG_KEY as:@"4ZYOAFT87p31kQurnVJsfe7lgzx2sHL4"];
    [[NtSdkMgr getInst] setPropStr:UNISDK_JF_GAS3_URL as:@"https://mgbsdknaeast.matrix.easebar.com/ma155naxx2gb/sdk/"];
    [[NtSdkMgr getInst] setPropStr:NT_ENGINE_VERSION as:getAppVer()];
    [[NtSdkMgr getInst] setPropStr:NT_RESOURCE_VERSION as:@"1"];//TODO
    
    //初始化FireBase
    [[NtAdMgr getInst] ntInit];

    //OS海外包体必须先调用[NtSdkMgr ntInit]，再调didFinishLaunchingWithOptions
    [NtSdkMgr ntInit];
    [[NtSdkMgr getInst] application:application didFinishLaunchingWithOptions:launchOptions];
    //初始化通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishInitNotification:) name:NT_NOTIFICATION_FINISH_INIT object:nil];
    //监听登录通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotification:) name:NT_NOTIFICATION_LOGIN object:nil];
    //监听登出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification:) name:NT_NOTIFICATION_LOGOUT object:nil];
    //监听登出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onExtendFunctionCallback:) name:NT_NOTIFICATION_EXTEND object:nil];
    //用户协议
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFinishProtocol:) name:NT_NOTIFICATION_INFO_PROTOCOL object:nil];
    //监听注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerNotification:) name:NT_NOTIFICATION_REGISTER object:nil];
    //管理视图关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeManagerViewNotification:) name:NT_NOTIFICATION_CLOSE_MANAGERVIEW object:nil];
    //支付结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeFFViewNotification:) name:NT_NOTIFICATION_CLOSE_FFVIEW object:nil];
    //成功获取商品信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProductInfoNotification:) name:NT_NOTIFICATION_FINISH_GET_PRODUCT_INFO object:nil];
    //用户界面有新的消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userManagerViewHasNewMessage:) name:NT_NOTIFICATION_NEW_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSurveyCallback:) name:@"OpenWebViewCallback" object:nil];
    
    //初始化环境SDK
    [EnvironmentSDK initSDK:@"ma155na" rkey:@"ng7phvwu7vto3ae5 " host:@"optsdk.gameyw.easebar.com"];

    //开始SDK登录成功日志
     NSDictionary* appDict = @{
         @"ta_app_start":@"",
         @"app_start_time":getCurTime2()
     };
     onDrpfSDK2(@"ta_app_start",appDict);
    
    BOOL isFirstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"];
    NSLog(@"是否首次安装 %d",isFirstTime);
    if(isFirstTime)
    {}
    else
    {
        //app安装
        NSDictionary* appDict1 = @{
            @"ta_app_install":@"",
            @"app_install_time":getCurTime2()
        };
        onDrpfSDK2(@"ta_app_install",appDict1);
        //设备激活
        NSDictionary* appDict2 = @{
            @"device_activate":@"",
            @"device_activate_time":getCurTime2()
        };
        onDrpfSDK2(@"device_activate",appDict2);
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    return YES;

}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    // openURL回调，处理第三方登录/分享，如实现了本回调，iOS 9以上的系统只会回调此方法
    [super application:app openURL:url options:options];
    [[NtSdkMgr getInst] application:app openURL:url options:options];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray *restorableObjects))restorationHandler
{
    // 处理Universal Link（微信/QQ等第三方登录使用）
    [super application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
    [[NtSdkMgr getInst] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // 即将进入后台
    [super applicationWillResignActive:application];
    [[NtSdkMgr getInst] applicationWillResignActive: application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 已经进入后台
    [super applicationDidEnterBackground:application];
    [[NtSdkMgr getInst] applicationDidEnterBackground: application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 即将进入前台
    [super applicationWillEnterForeground:application];
    [[NtSdkMgr getInst] applicationWillEnterForeground: application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // 已经进入前台
    [super applicationDidBecomeActive:application];
    [[NtSdkMgr getInst] applicationDidBecomeActive: application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // App退出
    NSTimeInterval onlineTime = getTimeStamp() - startTime;
    NSDictionary* loginDict = @{
        @"#ta_app_end":@"",
        @"#duration":[NSNumber numberWithDouble:onlineTime]
    };
    onDrpfSDK2(@"ta_app_end",loginDict);
    // App退出
    [super applicationWillTerminate:application];
    [[NtSdkMgr getInst] applicationWillTerminate:application];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 收到APNS推送deviceToken
    [super application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    [[NtSdkMgr getInst] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    //Appsflyer的回调
    [[NtAdMgr getInst] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    // 处理推送通知
//    [[NtSdkMgr getInst] application:application didReceiveRemoteNotification:userInfo];
//}

- (void)onFinishProtocol:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    
    if(dic[@"protocol_state"])
    {
        NSString *code = dic[@"protocol_state"];
        NSLog(@"用户协议====%@,%@",dic,code);
        NSString *aimInfo = [[NtSdkMgr getInst] getPropStr:JF_AIM_INFO];
        NSData *aimData = [aimInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *aimDic = [NSJSONSerialization JSONObjectWithData:aimData options:0 error:nil];
        NSDictionary *dict = @{
            @"eventType":EVENT_PROTOCOL_FINISH,
            @"code":code,
            @"udid":[[NtSdkMgr getInst] getUdid],
            @"sdk_version":[[NtSdkMgr getInst] getSDKVersion:[[NtSdkMgr getInst] getAppChannel]],
            @"aim_info":aimDic
        };
        SendMsgToUnity(dict);
    }
}

//- (UIInterfaceOrientationMask)application:(UIApplication*)application supportedInterfaceOrientationsForWindow:(UIWindow*)window
//{
//    //客服SDK里用到的UniImagePicker必须支持竖屏
//    //4.9.4版本后isOpening接口已支持通过extendFunc扩展接口调用
//    //使用扩展接口好处是：Appdelegate和UniSDKGMFeedBack解耦
//    NSString *jsonString = @"{\"methodId\":\"isGmOpening\"}";
//    [[NtSdkMgr getInst] ntExtendFunc:jsonString];
//    int isOpening = [[NtSdkMgr getInst] getPropInt:@"GMBRIDGE_IS_OPENING" default:0];
//
//    //if ([UniSdkGMFeedBack sharedInstance].isOpening) {
//    if (isOpening) {
//        return UIInterfaceOrientationMaskAll;
//    }
//    //退出GM页面，返回游戏APP的方向
//    //竖屏
//    //return UIInterfaceOrientationMaskPortrait;
//
//    //横屏
//    return UIInterfaceOrientationMaskLandscape;
//}
//------------------------------------------------通知处理，相当于回调-------------------------------------------------------

- (void)registerNotification:(NSNotification *)notification
{
    NSLog(@"registerNotification");
    
}

- (void)closeManagerViewNotification:(NSNotification *)notification
{
    NSLog(@"closeManagerViewNotification");
    
}

//支付回调结果
- (void)closeFFViewNotification:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    NSLog(@"支付回调结果 %@",dic);
    NtOrderInfo *orderInfo = [dic objectForKey:@"order"];
    NSDictionary *dict = @{
        @"eventType":EVENT_CHECK_ORDER_RESULT,
        @"orderStatus":[NSString stringWithFormat:@"%ld",(long)[orderInfo orderStatus]],
        @"jfCode":[NSString stringWithFormat:@"%ld",(long)[orderInfo getJfCode]],
        @"jfSubCode":[NSString stringWithFormat:@"%ld",(long)[orderInfo getJfSubCode]],
        @"jfMessage":[orderInfo jfMessage],
        @"payChannel":[orderInfo getFFChannel],
        @"currency":[orderInfo getUserPriceLocaleId],
        @"price":[NSString stringWithFormat:@"%ld",(long)[orderInfo getProductPrice]]
    };
    SendMsgToUnity(dict);
}

//成功获取商品信息
- (void)getProductInfoNotification:(NSNotification *)notification
{
    NSLog(@"成功获取商品信息");
    
}

- (void)userManagerViewHasNewMessage:(NSNotification *)notification
{
    NSLog(@"registerNotification");
    
}

//初始化通知处理
- (void)finishInitNotification:(NSNotification *)notification
{
    NSLog(@"finishInitNotification  初始化成功了");
     //激活日志
     NSDictionary* appDict = @{
         @"app_ver":getAppVer()
     };
     onDrpfSDK2(@"Activation",appDict);
}

//登录通知处理
- (void)loginNotification:(NSNotification *)notification
{
    _isLoginSuccess = false;
    NSDictionary *dict = notification.userInfo;
    NSString *loginState = dict[NT_NOTIFICATION_INFO_LOGIN_STATE];
    NSLog(@"niu--------------loginState %@",loginState);
    if ([dict[NT_NOTIFICATION_INFO_LOGIN_STATE] isEqual: NT_NOTIFICATION_INFO_LOGIN_OK]) {
        isDiabaleLogin = false;
        NSLog(@"niu--------------login success");
        // 登录成功
        NSString *minorStatus = [[NtSdkMgr getInst] getPropStr:NT_MINOR_STATUS];
        if([minorStatus isEqualToString:@"101"])
        {
            //拒绝服务，弹出退出游戏确认框
            isDiabaleLogin = true;
            NSDictionary *dict = @{
                @"login_out_code":EVENT_LOGOUT_MINOR,
                @"eventType":EVENT_LOGOUT
            };
            SendMsgToUnity(dict);
            return;
        }
        _isLoginSuccess = true;
        NSString* sdkUid = [[NtSdkMgr getInst] getPropStr:NT_UID];
        NSString* sauthJson = [[NtSdkMgr getInst] getPropStr:NT_SAUTH_JSON];
        
        NSLog(@"niu-----------------sauthJson---- %@",sauthJson);
        
        NSString* authType = [[NtSdkMgr getInst] getAuthTypeName];
        misGuest = false;
        if([authType isEqualToString:@"guest"])
        {
            misGuest = true;
        }
        //开始SDK登录成功日志
         NSDictionary* loginDict = @{
             @"account_id":getAccountId(),
             @"app_ver":getAppVer(),
             @"auth_type_name":authType,
             @"sdk_login_status":@"1",
             @"error_code":loginState
         };
         onDrpfSDK2(@"SDKLogin",loginDict);
        
         //登录成功广告埋点
         NSDictionary* trackDic = @{};
         trackCumtomEventSDK2(@"login",trackDic);
        
         //新增ne_login埋点
         NSDictionary* trackDic2 = @{
             @"app_instance_id":appInstanceId
         };
         trackCumtomEventSDK2(@"ne_login",trackDic2);
        
        //发送账号认证日志
         NSDictionary* identiDict = @{
             @"account_id":getAccountId(),
             @"app_ver":getAppVer(),
             @"reach_login_time":getCurTime2()
         };
        onDrpfSDK2(@"Identification",identiDict);
        
        NSNumber* evtType = 0;
        if(![lastUid isEqualToString:@""] && ![lastUid isEqualToString:sdkUid])
        {
            //切换账号
            evtType = EVENT_SWITCHACCOUNT;
        }
        else
        {
            //账号不变
            evtType = EVENT_LOGIN_SUCCESS;
        }
        
        NSData *sauthData = [sauthJson dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:sauthData options:0 error:nil];
        NSDictionary *dictionary = (NSDictionary *)jsonObject;
        NSMutableDictionary *mutableDict = [dictionary mutableCopy];
        mutableDict[@"eventType"] = evtType;
        mutableDict[@"sdkJson"] = getDrpfBaseJson();
        NSLog(@"Converted dictionary: %@", mutableDict);
        NSLog(@"niu--------------666");
        SendMsgToUnity(mutableDict);
        lastUid = sdkUid;
    }
    else if([dict[NT_NOTIFICATION_INFO_LOGIN_STATE] isEqual: NT_NOTIFICATION_INFO_LOGIN_CANCEL])
    {
        //取消登录
        NSLog(@"niu--------------login cancel");
    }
    else if([dict[NT_NOTIFICATION_INFO_LOGIN_STATE] isEqual: NT_NOTIFICATION_INFO_LOGIN_FAILED])
    {
        NSLog(@"niu--------------login failed");
        NSString* authType = [[NtSdkMgr getInst] getAuthTypeName];
                NSDictionary* loginDict = @{
                    @"account_id":getAccountId(),
                    @"app_ver":getAppVer(),
                    @"auth_type_name":authType,
                    @"sdk_login_status":@"-1",
                    @"error_code":dict[NT_NOTIFICATION_INFO_LOGIN_STATE]
                };
        onDrpfSDK2(@"SDKLogin", loginDict);
        
        NSDictionary* sdkDict = @{
            @"eventType":EVENT_LOGOUT,
            @"login_out_code":loginState
        };
        SendMsgToUnity(sdkDict);
    }
}

void onCrashHunter()
{
    //必填参数
    [NTCrashHunterKit sharedKit].project = @"ma155na";
    [NTCrashHunterKit sharedKit].appKey = @"36a58cce3741291df8ff27166a905164";
    [NTCrashHunterKit sharedKit].userName = [[NtSdkMgr getInst] getPropStr:NT_USERINFO_NAME]?[[NtSdkMgr getInst] getPropStr:NT_USERINFO_NAME]:@"null";
    [NTCrashHunterKit sharedKit].uid = [[NtSdkMgr getInst] getPropStr:NT_FULL_UID];
    [NTCrashHunterKit sharedKit].engineVersion = getAppVer();
	
    //可选参数，设置与否不影响启动结果
    [NTCrashHunterKit sharedKit].openLog = YES;
    [NTCrashHunterKit sharedKit].serverName = [[NtSdkMgr getInst] getPropStr:NT_USERINFO_HOSTNAME];
    [NTCrashHunterKit sharedKit].resVersion = @"1";
//    [NTCrashHunterKit sharedKit].branch = @"china_2324";
//    [NTCrashHunterKit sharedKit].extraInfo = @{@"avatar_count":@"3"};

    //启动CrashHunter SDK
    BOOL result = [[NTCrashHunterKit sharedKit] startHuntingCrash];
    onLoginDrpf(@"crash_hunter_init");
    NSLog(@"CrashHunter start result:%@", result?@"success":@"failed");
    
    //登录相关的处理逻辑
    [[NTCrashHunterKit sharedKit] captureStackBackTrace];
    
    [NTCrashHunterKit sharedKit].eventOccurCallback = ^(NTCrashHunterSDKEventType eventType,
                                                        NSString * _Nullable infoJsonString) {
        NSData *infoData = [infoJsonString dataUsingEncoding:NSUTF8StringEncoding];
        if (!infoData.length)
        {
            return;
        }
        
        
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:infoData
                                                             options:0
                                                               error:nil];
        
        if (10 == eventType) //上次运行发生了native层异常
        {
            NSString *lastCrashPath = info[@"file_path"];
            if (lastCrashPath.length)
            {
                NSString *testContent = @"test user crash";
                NSMutableArray *files = @[].mutableCopy;
                NTAssociatedFile *file = [[NTAssociatedFile alloc] initWithFile:@"test_crash.txt" content:testContent filePath:nil];
                [files addObject:file];
                [[NTCrashHunterKit sharedKit] addEventFiles:files toDirPath:lastCrashPath];
            }
            NSLog(@"event type:%ld, lastCrashPath:%@", (long)eventType, lastCrashPath);
        }
        else if (5 == eventType) //上次启动过程中出现用户强杀进程
        {
            NSString *userTerminationPath = info[@"file_path"];
            if (userTerminationPath.length)
            {
                NSString *userTerminationRecord = @"Recording application important information about last time";
                NSMutableArray *files = @[].mutableCopy;
                NTAssociatedFile *file = [[NTAssociatedFile alloc] initWithFile:@"userkill.txt"
                                                                        content:userTerminationRecord
                                                                       filePath:nil];
                [files addObject:file];
                [[NTCrashHunterKit sharedKit] addEventFiles:files toDirPath:userTerminationPath];
            }
            NSLog(@"event type:%ld, user_termination_path:%@", (long)eventType, userTerminationPath);
        }
        else if (7 == eventType) //任何数据上报完成的回调
        {
            NSLog(@"文件上报结果: 状态码:%@, transid:%@, 上报的错误类型:%@, 上报错误提示:%@", info[@"code"], info[@"transid"], info[@"errorType"], info[@"errorMsg"]);
        }
    };
    
    //闪退后立刻上报
    [NTCrashHunterKit sharedKit].crashOccurCallback = ^{
        NTAssociatedFile *file = [[NTAssociatedFile alloc] initWithFile:@"game_stack"
                                                                content:@"UniSDK TEST Demo"
                                                               filePath:nil];
        NTAssociatedFile *file2 = [[NTAssociatedFile alloc] initWithFile:@"game_stack2"
                                                                content:@"UniSDK TEST Demo"
                                                               filePath:nil];
        [[NTCrashHunterKit sharedKit] addFiles:@[file, file2]];
        
        onLoginDrpf(@"SetIosCrash");
    };
    //自定义数据上报，可能不需要
    NTAssociatedFile *primaryFile = [[NTAssociatedFile alloc] initWithFile:@"script.py"
                                                                        content:@"test for script warning"
                                                                       filePath:nil];
    NTAssociatedFile *associatedFirstFile = [[NTAssociatedFile alloc] initWithFile:@"appdump_log.txt"
                                                                           content:@"first file content"
                                                                          filePath:nil];
    NTAssociatedFile *associatedSecondFile = [[NTAssociatedFile alloc] initWithFile:@"python_stack.log"
                                                                            content:@"second file content"
                                                                           filePath:nil];
    [[NTCrashHunterKit sharedKit] postPrimaryFile:primaryFile
                                  associatedFiles:@[associatedFirstFile, associatedSecondFile]
                                  eventTypeString:NTCrashHunterTypeScriptWarnString];
}

//登出处理
- (void)logoutNotification:(NSNotification *)notification
{
    NSLog(@"登出成功");
    _isLoginSuccess = false;
    [[NtSdkMgr getInst] setPropInt:LOGIN_TYPE as:0];
    NSDictionary* sdkDict = @{
        @"eventType":EVENT_LOGOUT,
        @"logout_out_code":@0
    };
    SendMsgToUnity(sdkDict);
}

//extendCallback
- (void)onExtendFunctionCallback:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"extend callback %@",jsonString);
    
    NSString *methodId = dict[@"methodId"];
    if ([methodId isEqualToString:@"shouldAutoLogin"]) {
        BOOL result = [dict[@"result"] boolValue];
        if(result)
        {
            //可以自动登录
            [[NtSdkMgr getInst] setPropInt:LOGIN_TYPE as:1];
        }
        else
        {
            //游客登录
            [[NtSdkMgr getInst] setPropInt:LOGIN_TYPE as:2];
            [[NtSdkMgr getInst] setPropStr:@"AUTH_CHANNEL" as:@"guest"];
        }
        onLoginDrpf(@"auto_login_result");

        
        onLoginDrpf(@"auto_login_result");
        
        NSDictionary *dict = @{
            @"eventType":EVENT_INIT_FINISH
        };
        SendMsgToUnity(dict);
    }
    else if([methodId isEqualToString:@"getAppInstanceId"])
    {
        BOOL suc = [dict[@"suc"] boolValue];
        appInstanceId = @"";
        if(suc)
        {
            NSString* result = [dict[@"result"] stringValue];
            appInstanceId = result;
        }
         NSLog(@"appInstanceId = %@",appInstanceId);
    }
    else if([methodId isEqualToString:@"isJailBreak"])
    {
        //是否root
        isRoot = dict[@"jailBreak"];
        NSLog(@"设备是否越狱：%@",isRoot);
    }
    else if([methodId isEqualToString:@"genToken"])
    {
        NSLog(@"请求去sdk服务端拿数据");
        NSDictionary *dict2 = @{
            @"eventType":EVENT_REQTOKEN_CUSTOMERSERVICE,
            @"game_ip":getIpAddr(),
            @"os":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_OS_NAME],
            @"udid":[[NtSdkMgr getInst] getUdid],
            @"uid":[[NtSdkMgr getInst] getPropStr:NT_FULL_UID]
        };
        SendMsgToUnity(dict2);
    }
    else if([methodId isEqualToString:@"querySkuDetails"])
    {
        NSLog(@"获取商品列表信息成功");
        NSString* result = dict[@"result"];
        NSMutableString *formatString = [NSMutableString string];
        NSArray *skus = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        for(NSDictionary *sku in skus)
        {
            NSString *productId = sku[@"productId"];
            NSString *price = sku[@"price"];
            NSString *priceCurrencyCode = sku[@"priceCurrencyCode"];
            [formatString appendFormat:@"%@;%@;%@#",productId,price,priceCurrencyCode];
        }
        
        if(formatString.length > 0)
        {
            formatString = (NSMutableString *)[formatString substringToIndex:formatString.length - 1];
        }
        
        NSDictionary *dict2 = @{
            @"eventType":EVENT_PRODUCT_LIST,
            @"product_info":formatString,
            @"pay_channel":[[NtSdkMgr getInst] getFFChannelByPid:@"com.xgjoy.oc.6"]
        };
        SendMsgToUnity(dict2);
    }
    else if([methodId isEqualToString:@"NtCloseWebView"])
    {
        NSString* result = dict[@"result"];
        NSDictionary *dict2 = @{
            @"eventType":EVENT_CLOSE_WEBVIEW,
            @"result":result
        };
        SendMsgToUnity(dict2);
    }
    else if([methodId isEqualToString:@"hasPackageInstalled"])
    {
        BOOL result = [dict[@"result"] boolValue];
        NSString* appId = dict[@"urlScheme"];
        NSLog(@"app是否安装 %@--------%@",appId,result ? @"1" : @"0");
        NSDictionary *dict2 = @{
            @"eventType":EVENT_TO_APP,
            @"result":result ? @"1" : @"0",
            @"appId":appId
        };
        SendMsgToUnity(dict2);
    }
    else if ([methodId isEqualToString:@"fetchIDFAPermission"])
    {
        int status = [dict[@"status"] intValue];
        BOOL result = (status == 3);
        NSString *json = [NSString stringWithFormat:@"{\"facebook\":{\"enable\":%d}}", result];
        [[NtAdMgr getInst] trackEvent:@"FACEBOOK_SET_ATT_ENABLE" withValueString:json];
    }
    else if ([methodId isEqualToString:@"NGWebViewClose"])
    {
        NSString* action = dict[@"action"];
        NSString* data = dict[@"data"];
        if(action != nil && data != nil)
        {
            NSDictionary *dict2 = @{
            @"eventType":EVENT_WEBVIEW_NATIVECALL,
            @"action":action,
            @"webViewData":data,
            };
            NSLog(@"调查问卷数据： %@--------%@",action, data);
            SendMsgToUnity(dict2);
        }
    }
    else if([methodId isEqualToString:@"initCmp"])
    {
        NSString *notInEEA = [[NtSdkMgr getInst] getPropStr:@"NT_CMP_NOT_IN_EEA"];
        NSString *purposeList = [[NtSdkMgr getInst] getPropStr:@"NT_CMP_CONSENT_PURPOSE_LIST"];
        NSLog(@"init cmp 获取用户同意状态 notInEEA=%@，purposeList=%@",notInEEA,purposeList);
        if([notInEEA isEqualToString:@"1"] || [purposeList containsString:@"p1"])
        {
            //调起弹窗权限
            NSLog(@"询问IDFA权限");
            NSString *jsonString = @"{\"methodId\":\"fetchIDFAPermission\"}";
            [[NtSdkMgr getInst] ntExtendFunc:jsonString];
        }
    }
    else if([methodId isEqualToString:@"cmpNotInEEA"])
    {
        BOOL result = [dict[@"result"] boolValue];
        if(!result)
        {
            NSString *jsonString = @"{\"methodId\":\"openCmpConsentToolView\",\"channel\":\"ngconsentmanager\"}";
            [[NtSdkMgr getInst] ntExtendFunc:jsonString];
        }
    }
    else if([methodId isEqualToString:@"cmpOnButtonClicked"])
    {
        NSString *notInEEA = [[NtSdkMgr getInst] getPropStr:@"NT_CMP_NOT_IN_EEA"];
        NSString *purposeList = [[NtSdkMgr getInst] getPropStr:@"NT_CMP_CONSENT_PURPOSE_LIST"];
        NSString *vendorLis = [[NtSdkMgr getInst] getPropStr:@"NT_CMP_CONSENT_VENDOR_LIST"];
        NSString *allPurposeList = [[NtSdkMgr getInst] getPropStr:@"NT_CMP_ALL_PURPOSE_LIST"];
        NSString *allVendorList = [[NtSdkMgr getInst] getPropStr:@"NT_CMP_ALL_VENDOR_LIST"];
        NSLog(@"cmpOnButtonClicked cmp 获取用户同意状态化 notInEEA=%@，purposeList=%@,vendorLis=%@,allPurposeList=%@,allVendorList=%@",notInEEA,purposeList,vendorLis,allPurposeList,allVendorList);
        if([notInEEA isEqualToString:@"1"] || [purposeList containsString:@"p1"])
        {
            //调起弹窗权限
            NSLog(@"询问IDFA权限");
            NSString *jsonString = @"{\"methodId\":\"fetchIDFAPermission\"}";
            [[NtSdkMgr getInst] ntExtendFunc:jsonString];
        }
    }
    else if([methodId isEqualToString:@"openCmpConsentToolView"])
    {
        
    }
    else
    {
        NSLog(@"未处理的回调参数： %@",methodId);
    }
}

//webview回调
- (void)onSurveyCallback:(NSNotification *)notification
{
   NSDictionary *dict = notification.userInfo;
   NSLog(@"[UniSDK 扩展接口回调] %@",dict);
   //将回调内容由字典类型转成字符串后，传至脚本处理
    
    NSString* action = dict[@"action"];
    NSString* webViewData = dict[@"data"];
    NSDictionary *dict2 = @{
        @"eventType":EVENT_WEBVIEW_NATIVECALL,
        @"action":action,
        @"webViewData":webViewData,
    };
    NSLog(@"调查问卷数据： %@--------%@",action, webViewData);
    SendMsgToUnity(dict2);
}


//----------------------------------OC内部接口-------------------------------------

-(NSString*)getCurTime
{
    NSDate *currentDate = [NSDate date];	
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    return currentDateString;
}

//------------------------------Unity调OC----------------------------------
void initSDK()
{
    _isLoginSuccess = false;
    //处理自动登录
    NSString *jsonString = @"{\"methodId\":\"shouldAutoLogin\"}";
    [[NtSdkMgr getInst] ntExtendFunc:jsonString];

    //获取appInstanceId
    NSString *jsonString2 = @"{\"methodId\":\"getAppInstanceId\",\"channel\":\"firebase\"}";
    [[NtSdkMgr getInst] ntExtendFunc:jsonString2];
    
    //是否root
    NSString *jsonString3 = @"{\"methodId\":\"isJailBreak\"}";
    [[NtSdkMgr getInst] ntExtendFunc:jsonString3];
}

void loginSDK()
{
    NSDictionary* loginDict = @{
        @"account_id":@"",
        @"app_ver":getAppVer(),
        @"auth_type_name":@"",
        @"sdk_login_status":@"0",
        @"error_code":@"0"
    };
    onDrpfSDK2(@"SDKLogin",loginDict);
    NSLog(@"调用了onLogin");
    [[NtSdkMgr getInst] ntLogin];
}

void logoutSDK()
{
    [[NtSdkMgr getInst] ntLogout];
}

void openUserCenterSDK()
{
    [[NtSdkMgr getInst] ntOpenManager];
}

void openAgreementSDK()
{
    [[NtSdkMgr getInst] ntShowCompactView:YES];
}

//打开客服中心
void openCustomerServiceSDK(const char *roleid)
{
    @autoreleasepool {
        NSString *sRoleId = [NSString stringWithUTF8String:roleid];
        
        NSString *jsonString = [NSString stringWithFormat:@"{\"methodId\":\"ntSetRoleId\",\"roleId\":\"%@\"}",sRoleId];
        NSLog(@"打开客服中心1 %@",jsonString);
        [[NtSdkMgr getInst] ntExtendFunc:jsonString];
        NSString *jsonString2 = [NSString stringWithFormat:@"{\"methodId\":\"ntOpenGMPage\",\"refer\":\"%@\"}",@""];
        NSLog(@"打开客服中心3 %@",jsonString2);
        [[NtSdkMgr getInst] ntExtendFunc:jsonString2];
    }
}

//设置客服中心token
void setCustomerServiceTokenInfoSDK(const char *content)
{
    @autoreleasepool {
        NSString *tokenInfo = [NSString stringWithUTF8String:content];
        NSLog(@"设置客服中心token %@",tokenInfo);
        NSData *data = [tokenInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(dic)
        {
            NSString *message = dic[@"message"];
            if([message isEqualToString:@"success"])
            {
                NSString *jsonResult = [tokenInfo stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
                NSLog(@"Replaced string: %@", jsonResult);
                NSString *jsonString = [NSString stringWithFormat:@"{\"methodId\":\"ntSetGenTokenResponse\",\"response\":\"%@\"}",jsonResult];
                NSLog(@"打开客服中心3 %@",jsonString);
                [[NtSdkMgr getInst] ntExtendFunc:jsonString];
            }
        }
    }
}

void setCompactUrlSDK(const char *url)
{
     [[NtSdkMgr getInst] setPropStr:NT_COMPACT_URL as:[NSString stringWithUTF8String:url]];
}

void setUnisdkJfGas3UrlSDK(const char *url)
{
    NSLog(@"设置充值地址:%s",url);
    [[NtSdkMgr getInst] setPropStr:UNISDK_JF_GAS3_URL as:[NSString stringWithUTF8String:url]];
}

void sendUnisdkLoginJsonSDK(const char *content)
{
    @autoreleasepool {
        NSString *loginJson = [NSString stringWithUTF8String:content];
        NSLog(@"账号登录成功111 %@",loginJson);
        NSData *data = [loginJson dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(dic)
        {
            NSString *username = dic[@"username"];
            NSArray *nameArr = [username componentsSeparatedByString:@"@"];
            NSString *uid = nameArr[0];
            NSNumber *aid = dic[@"aid"];
            NSNumber *hostid = dic[@"hostid"];
            NSString *uni_login_sdk = dic[@"unisdk_login_json"];
            NSString *roleid = dic[@"roleid"];
            NSLog(@"账号登录成功222 %@",uni_login_sdk);
            [[NtSdkMgr getInst] setPropStr:NT_UID as:uid];
            [[NtSdkMgr getInst] setPropInt:NT_USERINFO_AID as:[aid intValue]];
            [[NtSdkMgr getInst] setPropStr:NT_USERINFO_UID as:roleid];
            [[NtSdkMgr getInst] setPropInt:NT_USERINFO_HOSTID as:[hostid intValue]];
            [[NtSdkMgr getInst] setPropStr:@"UNISDK_LOGIN_JSON" as:uni_login_sdk];
            [[NtSdkMgr getInst] ntGameLoginSuccess];
            NSLog(@"账号登录成功333 ntGameLoginSuccess");
        }
    }
}

void onUploadUserInfoSDK(const char *content)
{
    if(lastUploadTime != 0 && getTimeStamp() - lastUploadTime < 5)
   {
       NSLog(@"5秒内上传了两次，拦截一下");
       return;
   }
    @autoreleasepool {
        NSString *userInfoJson = [NSString stringWithUTF8String:content];
        NSLog(@"上传用户信息 %@",userInfoJson);
        NSData *data = [userInfoJson dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(dic)
        {
            if(dic[@"serverId"])
            {
                [[NtSdkMgr getInst] setPropStr:NT_USERINFO_STAGE as:NT_USERINFO_STAGE_ENTER_SERVER];
                NSNumber *serverId = dic[@"serverId"];
                [[NtSdkMgr getInst] setPropInt:NT_USERINFO_HOSTID as:[serverId intValue]];
            }
            
            if(dic[@"serverName"])
            {
                [[NtSdkMgr getInst] setPropStr:NT_USERINFO_HOSTNAME as:dic[@"serverName"]];
            }
            
            if(dic[@"roleId"])
            {
                [[NtSdkMgr getInst] setPropStr:NT_USERINFO_STAGE as:NT_USERINFO_STAGE_CREATE_ROLE];
                [[NtSdkMgr getInst] setPropStr:NT_USERINFO_UID as:dic[@"roleId"]];
                NSLog(@"上传用户信息  roleId=%@",dic[@"roleId"]);
            }
            
            if(dic[@"roleName"])
            {
                [[NtSdkMgr getInst] setPropStr:NT_USERINFO_NAME as:dic[@"roleName"]];
                [[NtSdkMgr getInst] setPropStr:NT_USR_NAME as:dic[@"roleName"]];
                if([NTCrashHunterKit sharedKit])
                {
                    [NTCrashHunterKit sharedKit].userName = dic[@"roleName"];
                    NSLog(@"CrashHunter UserName:%@", [NTCrashHunterKit sharedKit].userName);
                }
            }
            
            if(dic[@"roleGrade"])
            {
                [[NtSdkMgr getInst] setPropStr:NT_USERINFO_STAGE as:NT_USERINFO_STAGE_LEVEL_UP];
                NSNumber *roleGrade = dic[@"roleGrade"];
                [[NtSdkMgr getInst] setPropInt:NT_USERINFO_GRADE as:[roleGrade intValue]];
            }
        }
        [[NtSdkMgr getInst] ntUpLoadUserInfo];
        lastUploadTime = getTimeStamp();
    }
    //崩溃日志接入
    NSLog(@"Liu--------------CrashHunter");
    onCrashHunter();
}


NSString* getDrpfBaseJson()
{
    NSDictionary *dict = @{
        @"ip":getIpAddr(),
        @"device_model":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_DEVICE_MODEL],
        @"os_name":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_OS_NAME],
        @"os_ver":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_OS_VER],
        @"udid":[[NtSdkMgr getInst] getUdid],
        @"app_channel":[[NtSdkMgr getInst] getAppChannel],
        @"unisdk_deviceid":[[NtSdkMgr getInst] getPropStr:UNISDK_DEVICE_ID],
        @"oaid":[[NtSdkMgr getInst] getOaid],
        @"network":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_APP_NETWORK],
        @"app_ver":getAppVer(),
        @"country_code":getCountryCode(),
        @"first_udid":[[NtSdkMgr getInst] getUdid],
        @"engine_ver":[[NtSdkMgr getInst] getPropStr:NT_ENGINE_VERSION],
        @"account_type":[[NtSdkMgr getInst] getAuthTypeName],
        @"device_height":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_DEVICE_HEIGHT],
        @"device_width":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_DEVICE_WIDTH],
        @"isp":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_APP_ISP],
    };
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}

//该接口是仅供unity调用
void onDrpfSDK(const char *type,const char *content)
{
    @autoreleasepool {
        NSString *drpfType = [NSString stringWithUTF8String:type];
        NSString *contentJson = [NSString stringWithUTF8String:content];
        NSData *data = [contentJson dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(dic)
        {
             onDrpfSDK2(drpfType,dic);
        }
    }
}

//该接口是Objective-C内部代码调用
void onDrpfSDK2(NSString *type,NSDictionary *dictAdd)
{
    NSDictionary *dictOld = @{
        @"project":@"ma155na",
        @"type":type,
        @"source":@"adlog",
        @"active_time":getCurTime2(),
        @"ip":getIpAddr(),
        @"mac_addr":@"",
        @"device_model":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_DEVICE_MODEL],
        @"os_name":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_OS_NAME],
        @"os_ver":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_OS_VER],
        @"udid":[[NtSdkMgr getInst] getUdid],
        @"app_channel":[[NtSdkMgr getInst] getAppChannel],
        @"transid":[[NtSdkMgr getInst] getPropStr:NT_TRANS_ID],
        @"unisdk_deviceid":[[NtSdkMgr getInst] getPropStr:UNISDK_DEVICE_ID],
        @"is_root":isRoot,
        @"oaid":[[NtSdkMgr getInst] getOaid],
        @"network":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_APP_NETWORK],
        @"isp":[[NtSdkMgr getInst] getPropStr:NT_SDC_LOG_APP_ISP],
        @"app_ver":getAppVer(),
        @"jf_gameid":[[NtSdkMgr getInst] getPropStr:NT_JF_GAMEID],
        @"country_code":getCountryCode(),
        @"first_udid":[[NtSdkMgr getInst] getUdid],
        @"engine_ver":@"2021.3.26f1"
    };
    
    NSMutableDictionary *dictNew = [NSMutableDictionary dictionaryWithDictionary:dictOld];
    [dictNew addEntriesFromDictionary:dictAdd];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictNew options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [[NtSdkMgr getInst] DRPF:jsonString];
}

//登陆流程埋点
void onLoginDrpf(NSString *eventName)
{
    NSDictionary *dic = @{
        eventName:@""
    };
    if(dic)
    {
         onDrpfSDK2(eventName, dic);
    }
}

void setLanguageSDK(const char *language)
{
    const char *cnLang = "ZH_CN";
    BOOL isEqual = (strcmp(language,cnLang) == 0);
    if(isEqual)
    {
        [[NtSdkMgr getInst] setPropStr:NT_LANGUAGE_CODE as:NT_LANGUAGE_CODE_ZH_CN];
    }
    else
    {
        [[NtSdkMgr getInst] setPropStr:NT_LANGUAGE_CODE as:NT_LANGUAGE_CODE_EN];
    }
    NSString *jsonString = @"{\"methodId\":\"setLanguage\"}";
    [[NtSdkMgr getInst] ntExtendFunc:jsonString];
}

void onShareFacebook()
{
    
}

NSString* getCurTime2()
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    return currentDateString;
}

NSTimeInterval getTimeStamp()
{
    NSDate* now = [NSDate date];
    return [now timeIntervalSince1970];
}

NSString* getAccountId()
{
    //return [[NtSdkMgr getInst] getPropStr:NT_UID];
    return [[NtSdkMgr getInst] getPropStr:NT_FULL_UID];
}

NSString* getAppVer()
{
    return [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
}

NSString* getCountryCode()
{
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    NSLog(@"国家代码: %@",countryCode);
    return countryCode;
}

//TODO
NSString* getIpAddr()
{
    return [[NtSdkMgr getInst] getPropStr:NT_LOCAL_IP];
}


const char* getAppInstanceIdSDK()
{
    @autoreleasepool {
        NSData *data = [appInstanceId dataUsingEncoding:NSUTF8StringEncoding];
        const char *cStr = (const char *)[data bytes];
        NSLog(@"获取AppInstanceId:%s",cStr);
        char *result = (char *)malloc(strlen(cStr) + 1);
        strcpy(result, cStr);
        return result;
    }
}

const char* getDeviceIdSDK()
{
    @autoreleasepool {
        NSString *devideId = [[NtSdkMgr getInst] getPropStr:UNISDK_DEVICE_ID];
        NSData *data = [devideId dataUsingEncoding:NSUTF8StringEncoding];
        const char *cStr = (const char *)[data bytes];
        NSLog(@"获取设备id:%s",cStr);
        char *result = (char *)malloc(strlen(cStr) + 1);
        strcpy(result, cStr);
        return result;
    }
}

const char* getAccountTypeSDK() 
{
    @autoreleasepool {
        NSString* authType = [[NtSdkMgr getInst] getAuthTypeName];
        NSData *data = [authType dataUsingEncoding:NSUTF8StringEncoding];
        const char *cStr = (const char *)[data bytes];
        NSLog(@"获取登录账号类型:%s",cStr);
        char *result = (char *)malloc(strlen(cStr) + 1);
        strcpy(result, cStr);
        return result;
    }
}

BOOL isGuestSDK()
{
    return misGuest;
}

BOOL isDisableLoginSDK()
{
    return isDiabaleLogin;
}

BOOL isLoginSuccessSDK()
{
    return _isLoginSuccess;
}

void trackCumtomEventSDK2(NSString *type,NSDictionary *content)
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:content options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [[NtSdkMgr getInst] ntTrackCustomEvent:type withJson:jsonString];
    
    NSDictionary *facebookJson = @{@"facebook":jsonString};
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:facebookJson options:0 error:nil];
    NSString *jsonString1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    [[NtSdkMgr getInst] ntTrackCustomEvent:type withJson:jsonString1];
    
    NSDictionary *appsflyerJson = @{@"appsflyer":jsonString};
    NSData *data2 = [NSJSONSerialization dataWithJSONObject:appsflyerJson options:0 error:nil];
    NSString *jsonString2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    [[NtSdkMgr getInst] ntTrackCustomEvent:type withJson:jsonString2];
    
    NSDictionary *firebaseJson = @{@"firebase":jsonString};
    NSData *data3 = [NSJSONSerialization dataWithJSONObject:firebaseJson options:0 error:nil];
    NSString *jsonString3 = [[NSString alloc] initWithData:data3 encoding:NSUTF8StringEncoding];
    [[NtSdkMgr getInst] ntTrackCustomEvent:type withJson:jsonString3];
}

void trackCumtomEventSDK(const char *type,const char *content)
{
    @autoreleasepool {
        NSString *type1 = [NSString stringWithUTF8String:type];
        
        NSString *loginJson = [NSString stringWithUTF8String:content];
        NSLog(@"埋点%s，%s",type,content);
        NSData *data = [loginJson dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *content1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        trackCumtomEventSDK2(type1, content1);
    }
}

//设置粘贴板内容
void copyTextToClipboardSDK(const char *content)
{
    @autoreleasepool {
        NSString *contentString = [NSString stringWithUTF8String:content];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = contentString;
    }
}

void zhifuSDK(const char *content)
{
    @autoreleasepool {
        NSString *contentString = [NSString stringWithUTF8String:content];
        NSArray *contentArr = [contentString componentsSeparatedByString:@"#"];
        if(contentArr.count != 4)
        {
            NSLog(@"支付参数有误，拆分后的长度必须为4 %@",contentString);
            return;
        }
        NSString *goodsId = contentArr[0];
        //NSString *desc = contentArr[1];
        NSString *privatePramra = contentArr[2];
        NSString *hostId = contentArr[3];
        
        NSString *userinfo_uid = [[NtSdkMgr getInst] getPropStr:NT_USERINFO_UID];
        NSString *sdkUid = [[NtSdkMgr getInst] getPropStr:NT_UID];
        NSString *aid = [[NtSdkMgr getInst] getPropStr:NT_USERINFO_AID];
        NtOrderInfo *orderInfo = [[NtOrderInfo alloc] initWithProductId:goodsId];
        [orderInfo setServerId:hostId];
        [orderInfo setUserData:userinfo_uid];
        [orderInfo setUserName:userinfo_uid];
        [orderInfo setJfExtInfo:privatePramra];
        [orderInfo setUid:sdkUid];
        [orderInfo setAid:aid];
        [[NtSdkMgr getInst] ntCheckOrder:orderInfo];
    }
}

//获取商品列表
void getProductListSDK(const char *content)
{
    @autoreleasepool {
        NSString *idString = [NSString stringWithUTF8String:content];
        NSArray *contentArr = [idString componentsSeparatedByString:@";"];
        
        NSMutableString *resultString = [NSMutableString string];
        for(NSString *pId in contentArr)
        {
            if([pId isEqualToString:@"com.xgjoy.oc.0"])
            {
                
            }
            else
            {
                [resultString appendFormat:@"%@;",pId];
            }
        }
        
        if(resultString.length > 0)
        {
            resultString = (NSMutableString *)[resultString substringToIndex:resultString.length - 1];
        }
        
        NSString *jsonString = [NSString stringWithFormat:@"{\"methodId\":\"querySkuDetails\",\"itemType\":\"inapp\",\"skus\":\"%@\"}",resultString];
        NSLog(@"获取商品列表 %@",jsonString);
        [[NtSdkMgr getInst] ntExtendFunc:jsonString];
    }
}

void openWebviewUrlSDK(const char *content)
{
    @autoreleasepool {
        NSString *contentString = [NSString stringWithUTF8String:content];
        NSArray *contentArr = [contentString componentsSeparatedByString:@"#"];
        if(contentArr.count != 4)
        {
            NSLog(@"拆分后的长度必须为4 %@",contentString);
            return;
        }
        NSString *targetUrl = contentArr[0];
        NSString *floatView = contentArr[1];
        NSString *fullView = contentArr[2];
        NSString *navigationBar = contentArr[3];
        
        NSString *jsonString = [NSString stringWithFormat:@"{\"methodId\":\"NGWebViewOpenURL\",\"orientation\":\"2\",\"URLString\":\"%@\",\"navigationBarVisible\":\"%@\",\"isFullScreen\":\"%@\"}",targetUrl,navigationBar,fullView];
        NSLog(@"打开webview %@",jsonString);
        [[NtSdkMgr getInst] ntExtendFunc:jsonString];
    }
}

void questionnaireSDK(const char *content)
{
    @autoreleasepool {
        NSString *contentString = [NSString stringWithUTF8String:content];
        NSArray *contentArr = [contentString componentsSeparatedByString:@"#"];
        if(contentArr.count != 4)
        {
            NSLog(@"拆分后的长度必须为4 %@",contentString);
            return;
        }
        NSString *survey_url = contentArr[0];
        NSString *floatView = contentArr[1];
        NSString *fullView = contentArr[2];
        NSString *navigationBar = contentArr[3];
        
        // 调用ntOpenWebView之前，先调用
        [[NtSdkMgr getInst] setPropStr:@"WEBVIEW_MODE" as:@"1"];
        [[NtSdkMgr getInst] setPropStr:@"WEBVIEW_FULLFIT" as:@"0"];
        [[NtSdkMgr getInst] setPropStr:@"WEBVIEW_CONTENT_TYPE" as:@"survey"];
        [[NtSdkMgr getInst] setPropStr:@"WEBVIEW_H5_PADDING" as:@"{10,50,80,20}"];
        
        //(可选)调用ntOpenWebView之前，先调用,小窗模式，不会影响游戏生命周期 （3.3版本或以上，每次打开都要设置一次，不然下次会失效）
        [[NtSdkMgr getInst] setPropStr:@"WEBVIEW_IS_FLOAT_VIEW" as:floatView];
        
        
        NSString *sdkUid = [[NtSdkMgr getInst] getPropStr:UNISDK_DEVICE_ID];
        NSString *role_id =  [[NtSdkMgr getInst] getPropStr:NT_USERINFO_UID];
        NSString *server = [[NtSdkMgr getInst] getPropStr:NT_USERINFO_HOSTID];
        
        NSString *survey_url2 = [NSString stringWithFormat:@"%@?uid=%@&role_id=%@&server=%@", survey_url, sdkUid, role_id, server];
        NSLog(@"问卷原地址: %@", survey_url);
        NSLog(@"问卷 sdkUid: %@", sdkUid);
        NSLog(@"问卷 role_id: %@", role_id);
        NSLog(@"问卷 server: %@", server);
        NSLog(@"问卷拼接地址: %@", survey_url2);

        [[NtSdkMgr getInst] ntOpenWebView:survey_url2];
    }
}

void hasPackageInstalledSDK(const char *content)
{
    @autoreleasepool {
        NSString *contentString = [NSString stringWithUTF8String:content];
        NSString *jsonString = [NSString stringWithFormat:@"{\"methodId\":\"hasPackageInstalled\",\"urlScheme\":\"%@\"}",contentString];
        NSLog(@"是否安装app %@",contentString);
        [[NtSdkMgr getInst] ntExtendFunc:jsonString];
    }
}

void toAppSDK(const char *type,const char *content)
{
    @autoreleasepool {
        NSString *typeString = [NSString stringWithUTF8String:type];
        NSString *jsonString = [NSString stringWithFormat:@"{\"methodId\":\"toApp\",\"ios\":\"%@\"}",typeString];
        NSLog(@"跳转app %@",typeString);
        [[NtSdkMgr getInst] ntExtendFunc:jsonString];
    }
}

const char* reviewNicknameV2SDK(const char *nickname)
{
    @autoreleasepool {
        NSString *nicknameStr = [NSString stringWithUTF8String:nickname];
        NSDictionary *result = [EnvironmentSDK reviewNicknameV2:nicknameStr];
        
        // 将 NSDictionary 转换为 NSString (JSON 格式)
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:0 error:&error];
        if (!jsonData)
        {
            NSLog(@"Got an error: %@", error);
        }
        else
        {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            // 将 NSString 转换为 char 数组
            const char *charArray = [jsonString UTF8String];
            
            char *result = (char *)malloc(strlen(charArray) + 1); // +1 为了 null 终止符
            strcpy(result, charArray);
            
            // 释放 jsonString，因为我们已经复制了它的内容
//            [jsonString release];
            
            // 返回新的 char 数组
            return result;
        }
        return "";
    }
}

const char* reviewWordsV2SDK(const char *level, const char *channel, const char *content)
{
    @autoreleasepool {
        
        	
        NSString *channelStr = [NSString stringWithUTF8String:channel];
        NSString *levelStr = [NSString stringWithUTF8String:level];
        NSString *contentStr = [NSString stringWithUTF8String:content];
        
        NSDictionary *result = [EnvironmentSDK reviewWordsV2:contentStr level:levelStr channel:channelStr];
        // 将 NSDictionary 转换为 NSString (JSON 格式)
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:0 error:&error];
        if (!jsonData)
        {
            NSLog(@"Got an error: %@", error);
        } 
        else
        {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            // 将 NSString 转换为 char 数组
            const char *charArray = [jsonString UTF8String];
            
            char *result = (char *)malloc(strlen(charArray) + 1); // +1 为了 null 终止符
            strcpy(result, charArray);
            
            // 释放 jsonString，因为我们已经复制了它的内容
//            [jsonString release];
            
            // 返回新的 char 数组
            return result;
        }
        return "";
    }
}

void SendMsgToUnity(NSDictionary *dict)
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    const char *charString = [jsonString UTF8String];
    //char *copyOfCString = strdup(charString);
    UnitySendMessage("SDKHandler", "JavaCallEventMsg", charString);
    //free(copyOfCString);
}

@end
