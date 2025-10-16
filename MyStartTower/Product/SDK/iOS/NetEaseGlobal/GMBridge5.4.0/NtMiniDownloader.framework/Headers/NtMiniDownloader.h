//
//  NtMiniDownloader.h
//  NtMiniDownloader
//
//  Created by ZYN1176 on 16/7/12.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for NtMiniDownloader.
FOUNDATION_EXPORT double NtMiniDownloaderVersionNumber;

//! Project version string for NtMiniDownloader.
FOUNDATION_EXPORT const unsigned char NtMiniDownloaderVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <NtMiniDownloader/PublicHeader.h>
/*
===================error code==================
0 : 无错误
101 : 找不到文件
102 : 文件已存在
103 : [下载] url错误，创建url请求失败
104 : [下载] 连接错误
*/
#define NT_MINI_DOWNLOADER_ERR_CODE_NORMAL 0
#define NT_MINI_DOWNLOADER_ERR_CODE_NO_FILE 101
#define NT_MINI_DOWNLOADER_ERR_CODE_FILE_EXIST 102
#define NT_MINI_DOWNLOADER_ERR_CODE_INVALID_URL 103
#define NT_MINI_DOWNLOADER_ERR_CODE_CONNECTION 104

#import <Foundation/Foundation.h>

@protocol NtMiniDownloaderDelegate <NSObject>

@optional
- (void) downloadStart:(NSString*)path;
@optional
- (void) downloadProgress:(float)progress;
@optional
- (void) downloadFinish:(NSString *)path error:(NSInteger)errorCode;

@end


@interface NtMiniDownloader : NSObject
- (instancetype)initWithDelegate:(id<NtMiniDownloaderDelegate>)deleget;

- (void) ntStartDownload:(NSString *)path from:(NSString *)urlStr;

+ (NSString *) md5:(NSString *)path;
@end

