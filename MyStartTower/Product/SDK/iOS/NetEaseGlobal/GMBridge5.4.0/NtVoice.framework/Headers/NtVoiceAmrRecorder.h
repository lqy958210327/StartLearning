//
//  NtVoiceAmrRecorder.h
//  NtVoice
//
//  Created by bijunyan on 2019/7/30.
//  Copyright © 2019 NetEase. All rights reserved.
//

//1. 此模块的主要功能是实时录制AMR, 并在录制过程中调整、美化声音
//2. 主要对象是人声，且要对采样进行较复杂的计算，故使用了较低的采样率8KHz、单声道、每个采样16bit。
//3. 同时只能录制或者播放一个音频，录音时会停掉播放。
//4. 当正在录音时，再调录音接口，不会有录音完成的回调，录音接口返回NO
//5. 传进来的filePath必须是绝对路径。
//6. 录音产生的文件格式是AMR-NB（RFC-3267）所以仅适用于人声, 对AMR-WB(RFC-4867)只能解码
//7. Amr帧时长固定0.02s，是时长的最小单位，而PCM_Filter（增大音量，噪声消除）以0.01s为一个单元
//8. Amr的帧大小不是定值，也没有标签记录总时长，计算amr文件的时长需要遍历整个文件，所以取时长的接口并不推荐使用，最好是在录制完成后就缓存时长
//enjoy :)

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

//录音可以打开的选项
typedef NS_OPTIONS(NSUInteger, NtVoiceAmrRecorderOption) {
    NtVoiceAmrRecorderOptionUseNS = (1 << 1),        //噪声抑制
    NtVoiceAmrRecorderOptionUseAGC = (1 << 2),       //增大音量
    
    NtVoiceAmrRecorderOptionUseNone = 0x0,
    NtVoiceAmrRecorderOptionUseAll = (1 << 2) | (1 << 1),
};

//委托状态码
#define NtVoiceAmrRecorder_Status_OK                 0   //OK
#define NtVoiceAmrRecorder_Status_Err_Recording      1   //当前正在录音(录音时再调录音： 第二次调用不会有录音完成的回调，录音接口返回NO)
#define NtVoiceAmrRecorder_Status_Err_Short          2   //录制时间太短
#define NtVoiceAmrRecorder_Status_Err_File           3   //文件不存在，或者文件已存在
#define NtVoiceAmrRecorder_Status_Err_ABQ            4   //Audio Buffer Queue错误，错误信息会用log打出来。
#define NtVoiceAmrRecorder_Status_Err_Authorization  5   //没有获得麦克风授权
#define NtVoiceAmrRecorder_Status_Err_Cancel         6   //用户取消录音
#define NtVoiceAmrRecorder_Status_Err_Not_Amr        7   //播放的文件不是一个有效的amr

@protocol NtVoiceAmrRecorderDelegate <NSObject>

@optional
- (void) onRecordFinished:(NSTimeInterval)duration status:(NSUInteger)status;

@optional
- (void) onPlayFinished:(NSUInteger)status;

@end


@interface NtVoiceAmrRecorder : NSObject
@property (nonatomic, weak) id<NtVoiceAmrRecorderDelegate> delegate;

@property (nonatomic, strong, readonly) NSString *recordingFilePath;
@property (nonatomic, assign, readonly) BOOL isRecording;
@property (nonatomic, assign) NtVoiceAmrRecorderOption recordOption;
@property (nonatomic, assign) NSTimeInterval minDuration;
@property (nonatomic, assign) NSTimeInterval maxDuration;

@property (nonatomic, strong, readonly) NSString *playingFilePath;
@property (nonatomic, assign, readonly) BOOL isPlaying;
@property (nonatomic, assign) BOOL isLooping;

- (BOOL) startRecord:(NSString *)filePath;
- (void) cancelRecord;
- (void) stopRecord;

- (BOOL) startPlay:(NSString *)filePath;
- (void) stopPlay;

//peakPower永远都比averagePower值要大
- (void) getRecordPower:(float*)peakPower average:(float*)averagePower;
- (void) getPlayPower:(float *)peakPower average:(float *)averagePower;

- (NSTimeInterval) durationOfAmrFile:(NSString *)filePath isWB:(BOOL *)isWB;
@end
