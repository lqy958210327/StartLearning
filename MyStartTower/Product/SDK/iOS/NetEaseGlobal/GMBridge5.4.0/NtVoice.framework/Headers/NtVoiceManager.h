//
//  NgVoiceTranslate.h
//  NgVoice
//
//  Created by ZYN1176 on 16/2/19.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NtVoiceAmrRecorder.h"
#import "NtVoiceAmrTranslator.h"

/*
 ###一、 接入注意事项。
 1. 同一时刻，最多只有一个文件在录音。
 2. 同一时刻，最多只有一个文件在播放。
 3. 回调全部在主线程里执行。
 4. 开始、停止录音，开始、停止播放操作如果不在主线程里调用，操作会被放进主线程的队列，有可能不会马上执行。
 5. 下载录音、获取翻译等操作会针对每个操作重新开一个线程，不必再开多线程。
 6. 录音完成后会有一个转码的过程（不在主线程），当调用停止录音之后不能立即看到录制完成的回调被调用。请处理好UI的等待界面。
 7. 取消录音后也会有onRecordFinish的回调，标志是error = nil, duration = 0; 在收到回调之前，调用开始录音都会不成功。
 8. 初始化接口 setup 是可以放到主线程里执行的耗时并不多。 重复执行并不会覆盖之前的配置，新加进来的delegate 和 之前的 delegate 都会收到回调。
 9. 播放音频的接口，可以传绝对路径，文件名（只会在音频路径下找）。
 10. 关于下载，如果需要下载的文件已经存在的目标路径，就直接当做已经下载完成。
 
 ###二、配置注意事项
 1. 录音文件保存路径 ：如需动态修改，请在initWithDelegate之后立即修改，请不要在调用其它接口期间修改这个配置
 2. USER_ID : 多个模块共同使用时，请使用相同的USER_ID, 修改的原则同录音的路径一样。
 
 ####tips :
 1. 游戏中可能有不同的模块在使用NgVoice（客服SDK里也用到了本模块）。
 2. 录音文件都保存在 /Documents/{配置的路径}/USER_ID/ 目录下。[NtVideoInst getPropStr:@""]来取得这个绝对路径，建议传给 ntStartRecord 的文件名都带上时间戳。
 */

#define NtVoiceDelegate_Status_Err_Param -1 //参数错误

@protocol NtVoiceDelegate <NSObject>

/**
 * 录音完成时的回调。
 * duration : 录音时长
 * errorCode : 错误码，成功时code == 0
 *              101 : 用户没有授权使用麦克风
 *              102 : 正在录音
 *              103 : 初始话音频错误。
 *              105 : 取消录音(手动)
 *              106 : 取消录音（时间太短）
 *              107 : 转码出错
 *              108 : 其他错误
 *              109 : 录音被打断（录音取消）
 * filePath : 目标路径
 */
@optional
- (void)onRecordFinish:(NSTimeInterval)duration errorCode:(NSInteger)code filePath:(NSString *)filePath;

/**
 * 播放完成的回调
 * errorCode : 错误码，成功时code == 0
 204 : 文件不存在
 205 : 解释音频文件出错
 206 : 未知错误
 207 : 播放被打断。录音什么的。
 */
@optional
- (void)onPlaybackFinish:(NSInteger)errorCode;

/**
 * 上传完成的回调
 * file : 上传成功的文件路径（绝对路径）
 * key : 上传成功后生成的key
 * errorCode : 错误码，成功时code == 0
 304 : 文件不存在
 305 : 网络异常， key 里放的是error, description
 306 : 服务端错误, key 里放的是服务端返回的消息
 */
@optional
- (void)onUploadFinish:(NSString *)file key:(NSString *)key errorCode:(NSInteger)code;


/**
 * 下载完成的回调
 * fileName : 下载完成的文件路径（绝对路径）
 * key : 上传成功后生成的key
 * errorCode : 错误码，成功时code == 0
 401: 参数错误
 402: 下载的数据是空数据。
 403: 文件已经存在
 404: 文件不存在
 405: 下载中断
 406: 未知错误
 
 */
@optional
- (void)onDownloadFinish:(NSString*)file key:(NSString *)key errorCode:(NSInteger)code;


/**
 * 翻译完成后的回调
 * key : 上传成功后生成的key
 * msg : 译文
 * errorCode : 错误码，成功时code == 0
 501:参数错误(nil)
 502:连接错误
 506:服务端错误
 */
@optional
- (void)onTranslateFinish:(NSString *)key msg:(NSString*)msg errorCode:(NSInteger)code;
@end


@interface NtVoiceManager : NSObject

- (instancetype) initWithDelegate:(id<NtVoiceDelegate>)delegate;

+ (instancetype) shareInst;

- (id)getPropStr:(NSString*)key;

- (void)setPropStr:(NSString*)key as:(NSString*)value;

- (void)ntStartRecord:(NSString*)fileName;

- (void)ntCancelRecord;

- (void)ntStopRecord;

- (void)ntStartPlayback:(NSString *)fileName;

- (void)ntStopPlayback;

- (void)ntUploadVoiceFile:(NSString*)fileName;

- (void)ntDownloadVoiceFile:(NSString *)fileName withKey:(NSString *)key;

- (void)ntGetTranslation:(NSString *)key;

- (void)ntClearVoiceCache:(NSInteger) maxRemainSeconds;

@property (nonatomic, weak) id<NtVoiceDelegate> delegate;

@property (nonatomic, strong) NtVoiceAmrRecorder *theAmrOperator;

@property (nonatomic, strong) NtVoiceAmrTranslator *theTranslator;

@end
