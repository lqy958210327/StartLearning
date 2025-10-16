//
//  SDKControllerBase.m
//  UnityFramework
//
//  Created by 刘旻 on 2024/1/31.
//

#import <Foundation/Foundation.h>
#import "./SDKControllerBase.h"

@implementation SDKControllerBase : NSObject

- (id)init
{
    
    if ((self = [super init]))
    {
        //当数据结构为非数组时
        self.pList = [NSBundle mainBundle].infoDictionary;
    }
    
    return self;
}

- (void)InitSDK:(NSString *)objName {
}

- (void)Logout {
}

- (void)Login {
}

- (void)ShowUserAgrement {
}

- (void)ShowSDKUserCenter {
}

- (void)UpLoadLog:(NSString *)log {
}

- (void)ShowCustomerService:(NSString*) par {
}

- ( void ) imageSaved: ( UIImage *) image didFinishSavingWithError:( NSError *)error
          contextInfo: ( void *) contextInfo
{
    if (error != nil) {
        NSLog(@"有错误");
    }
}
- (void)Pay:(NSString *)payInfo {
}

@end
