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

}

- (void)Login {
    
}

- (void)Logout {
    
}

- (void)ShowUserAgrement {
    
}

- (void)ShowCustomerService:(NSString*) par {
    
}

- (void)ShowSDKUserCenter {
    
}

- (void)Pay:(NSString *)payInfo {
}

@end
