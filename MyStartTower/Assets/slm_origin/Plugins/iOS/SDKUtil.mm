//
//  SDKUtil.m
//  Unity-iPhone
//
//  Created by 刘旻 on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import "./SDK/SDKController.h"
#import "./SDKUtil.h"
#if defined(__cplusplus)
extern "C" {
#endif
char* cStringCopy(const char* string)
{
    if (string == NULL) return NULL;

    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    return res;
}

// 这个方法进一步包装了之前的方法，通常你在OC中用NSString完成一系列操作，
// 要返回给Unity时，需要转成char* (char* 传到Unity那边就是string)
char* convertNSStringToCString(const NSString* nsString)
{
    if (nsString == NULL)  return NULL;

    const char* nsStringUtf8 = [nsString UTF8String];
    //create a null terminated C string on the heap so that our string's memory isn't wiped out right after method's return
    char* cString = (char*)malloc(strlen(nsStringUtf8) + 1);
    strcpy(cString, nsStringUtf8);

    return cString;
}

    extern void SDK_Login()
    {
        NSLog(@"IOS  开始登陆");
        [SDKUitl Login];
    }
    
    extern void SDK_InitSDK(const char* str)
    {
        NSString *s = [NSString stringWithUTF8String: str];
        [SDKUitl InitSDK : s];
    }
    
    extern void SDK_Logout()
    {
        [SDKUitl Logout];
    }

    extern void SDK_ShowUserAgrement()
    {
        [SDKUitl ShowUserAgrement];
    }
    
    extern void SDK_ShowCustomerService(const char* jsonData)
    {
        NSString *josn = [NSString stringWithUTF8String: jsonData];
        [SDKUitl ShowCustomerService : josn];
    }

    extern void SDK_ShowSDKUserCenter()
    {
        [SDKUitl ShowSDKUserCenter];
    }

    extern void SDK_UpLoadLog (const char* log)
    {
        NSString *s = [NSString stringWithUTF8String: log];
        [SDKUitl UpLoadLog: s];
    }

    extern void SDK_SaveImage (const char* path)
    {
        NSString *s = [NSString stringWithUTF8String: path];
        [SDKUitl SaveImage: s];
    }
    
    extern void SDK_Pay (const char* payInfo)
    {
        NSString *s = [NSString stringWithUTF8String: payInfo];
        [SDKUitl Pay: s];
    }
    
    extern char* GetChannelID()
    {
        NSString *s = [SDKUitl GetChannelID];
        return convertNSStringToCString(s);
    }
    
#if defined(__cplusplus)
}
#endif






@implementation SDKUitl

+ (void)Login {
    [[SDKController shareSdkController] Login];
}

+ (void)InitSDK : (NSString*) str{
    [[SDKController shareSdkController] InitSDK : str];
}


+ (void)Logout {
    [[SDKController shareSdkController] Logout];
}

+ (void)ShowUserAgrement {
    [[SDKController shareSdkController] ShowUserAgrement];
}

+ (void)ShowCustomerService:(NSString*) json {
    [[SDKController shareSdkController] ShowCustomerService:json];
}

+ (void)ShowSDKUserCenter {
    [[SDKController shareSdkController] ShowSDKUserCenter];
}

+ (void)UpLoadLog:(NSString *)log {
    [[SDKController shareSdkController] UpLoadLog: log];
}

+ (void)SaveImage:(NSString *)imagePath {
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    SDKController *instance = [SDKController shareSdkController];
    UIImageWriteToSavedPhotosAlbum(img, instance,
                                   @selector(imageSaved:didFinishSavingWithError:contextInfo:), nil);
}

+ (void)Pay:(NSString *)payInfo {
    [[SDKController shareSdkController] Pay: payInfo];
}

+ (NSString*)GetInfoPlis:(NSString *)key{
    // 获取 info.plist 文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    // 读取文件内容
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    // 将 XML 数据转换为字典对象
    NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:nil error:nil];
    NSString *str = [plist objectForKey:key];
    return str;
}

+ (NSString*)GetChannelID{
    return [SDKUitl GetInfoPlis: @"channel"];
}

@end
