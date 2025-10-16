//
//  NtVoiceAmrTranslator.h
//  ExpandAudioRecordDemo
//
//  Created by ZYN1176 on 16/9/30.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NtVoiceAmrTranslator_Status_OK             0   //OK
#define NtVoiceAmrTranslator_Status_Err_File       1   //文件不存在或者文件已存在
#define NtVoiceAmrTranslator_Status_Err_Server     2   //服务端返回失败
#define NtVoiceAmrTranslator_Status_Err_Network    3   //网络连接错误
#define NtVoiceAmrTranslator_Status_Err_UnKnown    4   //未知错误

@protocol NtVoiceAmrTranslatorDelegate <NSObject>

@optional
- (void)onDownloadFinished:(NSString*)file key:(NSString *)key status:(NSInteger)status;

- (void)onUploadFinished:(NSString *)file key:(NSString *)key status:(NSInteger)status;

- (void)onTranslateFinished:(NSString*)msg key:(NSString *)key status:(NSInteger)status;
@end


@interface NtVoiceAmrTranslator : NSObject
@property (nonatomic, weak) id<NtVoiceAmrTranslatorDelegate> delegate;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *userAgent;
@property (nonatomic, strong) NSString *toUser;
@property (nonatomic, strong) NSString *user;

- (BOOL) upload:(NSString *)filePath;
- (BOOL) download:(NSString *)key to:(NSString *)filePath;
- (BOOL) translate:(NSString *)key;
@end
