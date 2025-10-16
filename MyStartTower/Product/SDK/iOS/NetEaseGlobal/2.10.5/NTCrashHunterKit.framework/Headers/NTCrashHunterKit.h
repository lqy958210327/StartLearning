    //
//  NTCrashHunterKit.h
//  NTCrashHunterKit
//
//  Created by Darren Huang on 2018/5/9.
//  Copyright © 2018 Darren Huang. All rights reserved.
//  Love


#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/// Error Type String
typedef NSString *NTCrashHunterTypeString NS_STRING_ENUM;
FOUNDATION_EXPORT NTCrashHunterTypeString const NTCrashHunterTypeScriptErrorString;
FOUNDATION_EXPORT NTCrashHunterTypeString const NTCrashHunterTypeMemoryWarningString;
FOUNDATION_EXPORT NTCrashHunterTypeString const NTCrashHunterTypeJavaScriptErrorString;
FOUNDATION_EXPORT NTCrashHunterTypeString const NTCrashHunterTypeOtherString;
FOUNDATION_EXPORT NTCrashHunterTypeString const NTCrashHunterTypeUnity3DErrorString;
FOUNDATION_EXPORT NTCrashHunterTypeString const NTCrashHunterTypeUEFatalString;
FOUNDATION_EXPORT NTCrashHunterTypeString const NTCrashHunterTypeScriptWarnString;


//游戏层告知SDK的事件类型
typedef NS_ENUM(NSInteger, NTCrashHunterType)
{
    NTCrashHunterTypeScriptError      = 1 << 1,  //脚本错误事件
    NTCrashHunterTypeMemoryWarning    = 1 << 2,  //内存警告事件
    NTCrashHunterTypeJavaScriptError  = 1 << 3,  //javaScript错误
    NTCrashHunterTypeOther            = 1 << 4,  //其他类型的错误
    NTCrashHunterTypeUnity3DError     = 1 << 6,  //Unity3D引擎相关错误
    NTCrashHunterTypeUEFatal          = 1 << 7,  //Unreal Engine引擎相关错误
    NTCrashHunterTypeScriptWarn       = 1 << 8,  //脚本警告事件
};

//SDK告知游戏层的时间类型
typedef NS_ENUM(NSInteger, NTCrashHunterSDKEventType)
{
    NTCrashHunterSDKEventTypeNone = 0,
    NTCrashHunterSDKEventTypeFileCacheResult = 3,        //数据缓存结果
    NTCrashHunterSDKEventTypeCrashLastTime = 4,     //上次启动发生常规异常
    NTCrashHunterSDKEventTypeUserTermination = 5,   //上次运行过程中，用户手动强退进程
    NTCrashHunterSDKEventTypeFileUpload = 7,        //所有数据上报的回调结果
    NTCrashHunterSDKEventTypeCrashCurrentTime = 8,     //当前启动发生常规异常
    NTCrashHunterSDKEventTypeCrashLastTime2 = 10,     //上次启动发生常规异常[为了与android统一]
    NTCrashHunterSDKEventTypeUncaughtException = 12,        //上次运行发生了UncaughtException事件
    NTCrashHunterSDKEventTypeStartUpCrash = 15,        //上次运行发生了启动闪退事件
};

//运行模式
typedef NS_OPTIONS(NSInteger, NTCrashHunterTarget)
{
    NTCrashHunterTargetDEFAULT = 0,           //默认
    NTCrashHunterTargetNOAH    = 1,           //Noah
    NTCrashHunterTargetOTHER   = 1 << 1,      //其他
};

#ifdef __cplusplus
extern "C" {
#endif
NSString *NTCrashHunterVersionString(void);
#ifdef __cplusplus
}
#endif

typedef void (^NTCrashOccurCallBack) (void);
typedef void (^NTEventOccurCallBack) (NTCrashHunterSDKEventType eventType,
                                      NSString *_Nullable infoJsonString);

@interface NTAssociatedFile : NSObject

/**
 @param fileName    文件名，必填
 @param content     文件内容，与文件路径二选一
 @param filePath    文件路径，与文件内容二选一，文件路径的内容不会被变动（删除，修改）
 @param fileFeature 文件特征，目前只支持obfu字段，用于标记该文件经过混淆处理。
 @return 上传文件模型
 */
- (instancetype)initWithFile:(NSString * _Nonnull)fileName
                     content:(NSString * _Nullable)content
                    filePath:(NSString * _Nullable)filePath
                 fileFeature:(NSString * _Nullable)fileFeature;


- (instancetype)initWithFile:(NSString * _Nonnull)fileName
                     content:(NSString * _Nullable)content
                    filePath:(NSString * _Nullable)filePath;

- (BOOL)handleContentToDestination:(NSString *)destinationPath;

@property (nonatomic, copy, readonly) NSString *fileName;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *filePath;
@property (nonatomic, copy, readonly) NSString *fileFeature;
@end


__attribute__((objc_subclassing_restricted))
@interface NTCrashHunterKit : NSObject

// ****** Required *********
@property (nonatomic, copy)   NSString *uid;
@property (nonatomic, copy)   NSString *appKey;
@property (nonatomic, copy)   NSString *project;
@property (nonatomic, copy)   NSString *userName;
@property (nonatomic, copy)   NSString *engineVersion;  
// ****** Optional *********
@property (nonatomic, assign) NTCrashHunterTarget target;
@property (nonatomic, assign) BOOL openLog; //日志开关
@property (nonatomic, copy)   NSString *url;            //产品接入不建议设置上报url
@property (nonatomic, copy)   NSString *host;           //所有URL统一配置的Host
@property (nonatomic, copy)   NSString *branch;         //当前分支
@property (nonatomic, copy)   NSString *easebar;
@property (nonatomic, copy)   NSString *serverName;
@property (nonatomic, copy)   NSString *resVersion;
@property (nonatomic, strong) NSDictionary *extraInfo;  //透传info字段，作用与bind conditions几乎一致。

/*
 * 闪退回调
 */
@property (nonatomic, copy)   NTCrashOccurCallBack crashOccurCallback;

/**
 *  通用的事件回调
 *  从回调数据的JSON String解析成Dictionary
 */
@property (nonatomic, copy) NTEventOccurCallBack eventOccurCallback;

/**
 * 是否关闭后台网络任务
 */
@property (nonatomic, assign) BOOL shouldCloseBackgroundTask;   //注意！需要在启动之前设置，仅允许设置一次！！
// ****** Deprecated *******
//是否关闭监听内存警告
@property (nonatomic, assign) BOOL shouldCloseMonitorMemory          DEPRECATED_MSG_ATTRIBUTE("No longer supported after version 2.0.1");
//是否关闭监听用户强退
@property (nonatomic, assign) BOOL shouldCloseMonitorUserTermination __attribute__((unavailable("No longer supported after version 2.0.1")));


/**
 Singleton method for creating hunter kit.
 @return crash hunter global object
 */
+ (instancetype)sharedKit;


/**
 启动接口，仅需调用一次
 @return 启动crash hunter是否成功
 */
- (BOOL)startHuntingCrash __attribute__((warn_unused_result)); 


/**
 * 崩溃发生之后添加需要一起上报的数据
 * @param files 关联此次crash的数据
 */
- (void)addFiles:(NSArray <NTAssociatedFile *> *)files;

/**
 增加额外的信息，方便DUMP设置过滤规则、自排查、扩展
 @param extension 扩展信息，将会在di文件内的filter_pipe字段展现
 */
- (void)addExtensionInfo:(NSDictionary *)extension;

/**
 文件上报接口
 @param primaryFile 主数据(仅有一个文件时默认设置主文件)
 @param associatedFiles 辅助数据
 @param type 上报事件类型
 */
- (void)postPrimaryFile:(NTAssociatedFile *)primaryFile
        associatedFiles:(NSArray <NTAssociatedFile *> *)associatedFiles
              eventType:(NTCrashHunterType)type;

/**
 文件上报接口
 @param primaryFile 主数据(仅有一个文件时默认设置主文件)
 @param associatedFiles 辅助数据
 @param typeString 上报事件字符串类型
 */
- (void)postPrimaryFile:(NTAssociatedFile *)primaryFile
        associatedFiles:(NSArray <NTAssociatedFile *> *)associatedFiles
        eventTypeString:(NSString *)typeString;


/*
 上报用户信息，用于统计AFFECTED_RATE/ACTIVE_USERS
 */
- (void)postUserInfo:(NSString *)uid
                 URS:(NSString *)urs
            userName:(NSString *)userName
          serverName:(NSString *)serverName;

/**
 绑定键值对，用于增加过滤条件
 @return 绑定结果
 @brief condition和key的字符串长度不允许超过30个字符
 */
- (BOOL)safelyBindCondition:(NSString *)condition withKey:(NSString *)key;
/**
 解绑键值对，用于删除过滤条件
 @return 解绑结果
 @brief condition和key的字符串长度不允许超过30个字符
 */
- (BOOL)safelyUnbindCondition:(NSString *)condition withKey:(NSString *)key;

/**
 * 事件回调时，添加文件到指定目录
 * @param dirPath 回调的目录
 */
- (void)addEventFiles:(NSArray <NTAssociatedFile *> *)files toDirPath:(NSString *)dirPath;

- (BOOL)isLastTimeCrash;

- (void)captureStackBackTrace;


#if TARGET_OS_IOS
/**
 * 启动插件的扩展方法，可用于开启卡顿、OOM监控插件
 */
- (void)startPlugin:(NSDictionary *)pluginContext DEPRECATED_MSG_ATTRIBUTE("No longer supported after version 2.2.0");

/**
 * 关闭插件的扩展方法
 */
- (void)stopPlugin:(NSDictionary *)pluginContext DEPRECATED_MSG_ATTRIBUTE("No longer supported after version 2.2.0");

#endif
@end

NS_ASSUME_NONNULL_END
