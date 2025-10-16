//
//  NtSdkMgr+Downloader.h
//  NtUniSdkNetEase2
//
//  Created by syosan on 2017/1/11.
//  Copyright © 2017年 HuangZizhu. All rights reserved.
//

#import "NtSdkMgr.h"
#import "NtSdkDownloader.h"

@interface NtSdkMgr (Downloader)

/// 获取下载器SDK的单例
+ (id<NtGamerInterface,NtSdkDownloaderDelegate>) getDLInst;

@end
