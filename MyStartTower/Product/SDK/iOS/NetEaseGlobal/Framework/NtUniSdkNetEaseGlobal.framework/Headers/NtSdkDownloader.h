//
//  NtSdkDownloader.h
//  NtUniSdkNetEase2
//
//  Created by syosan on 2017/1/11.
//  Copyright © 2017年 HuangZizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NtGamerInterface.h"

@class DownloadResultData;

@protocol NtSdkDownloaderDelegate <NSObject>

@optional
/// 设置下载器回调
///
/// - Note: 建议使用专用类统一管理回调，建议仅设置一次
///
/// - Parameters:
///   - process: 进度回调
///   - finish: 完成回调
- (void)setDownloadCallback:(void (^ _Nullable)(DownloadResultData* _Nullable result))process
                   finished:(void (^ _Nullable)(DownloadResultData* _Nullable result, BOOL successed, BOOL complete))finish;

@optional
/// 下载器版本号
///
/// - Note: 新增方法，未接入时返回 nil
- (NSString * _Nullable)orbitVersion;

@end

@interface NtSdkDownloader : NSObject <NtGamerInterface, NtSdkDownloaderDelegate>

+ (NtSdkDownloader *_Nonnull)getInst;

@end
