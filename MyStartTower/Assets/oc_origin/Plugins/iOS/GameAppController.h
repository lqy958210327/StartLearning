#import <Foundation/Foundation.h>

#if defined(__cplusplus)
extern "C"
{
#endif

    char* __makeCString(NSString* string)
    {
        if (string == nil) {
            return NULL;
        }
        
        const char* cstring = [string cStringUsingEncoding:NSUTF8StringEncoding];
        
        if (NULL == cstring) {
            return NULL;
        }
        char* res = (char*)malloc(strlen(cstring)+1);
        strcpy(res, cstring);
        return res;
    }
    
    NSString* __makeNSString(const char* cstring)
    {
        if (cstring == NULL) {
            return nil;
        }
        
        NSString* nsstring = [[NSString alloc] initWithCString:cstring encoding:NSUTF8StringEncoding];
        
        return nsstring;
    }
    
    NSString* __makeJsonString(id obj)
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
        
        if ([jsonData length] > 0 )
        {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                         encoding:NSUTF8StringEncoding];
            return jsonString;
        }
        
        NSLog(@"[NtUniSdk] __makeJsonString JsonError");
        return nil;
    }

    //用于Unity的调用（Unity只能调用C的方法，调不到OC的方法）
    extern void initSDK();
    extern void loginSDK();
    extern void logoutSDK();
    extern void openUserCenterSDK();
    extern void openAgreementSDK();
    extern void openCustomerServiceSDK(const char *roleid);
    extern void setCompactUrlSDK(const char *url);
    extern void setLanguageSDK(const char *language);
    extern void onDrpfSDK(const char *type,const char *content);
    extern void trackCumtomEventSDK(const char *type,const char *content);
    extern BOOL isDisableLoginSDK();
    extern BOOL isGuestSDK();
    extern BOOL isLoginSuccessSDK();
    extern const char* getAppInstanceIdSDK();
    extern const char* getAccountTypeSDK();
    extern const char* getDeviceIdSDK();
    extern void sendUnisdkLoginJsonSDK(const char *content);
    extern void setCustomerServiceTokenInfoSDK(const char *content);
    extern void onUploadUserInfoSDK(const char *content);
    extern void setUnisdkJfGas3UrlSDK(const char *url);
    extern void zhifuSDK(const char *content);
    extern void getProductListSDK(const char *content);
    extern void copyTextToClipboardSDK(const char *content);
    extern void openWebviewUrlSDK(const char *content);
    extern void hasPackageInstalledSDK(const char *content);
    extern void toAppSDK(const char *type,const char *content);
    extern const char* reviewNicknameV2SDK(const char *content);
    extern const char* reviewWordsV2SDK(const char *level,const char *channel,const char *content);
    extern void questionnaireSDK(const char *content);

#if defined(__cplusplus)
}
#endif
