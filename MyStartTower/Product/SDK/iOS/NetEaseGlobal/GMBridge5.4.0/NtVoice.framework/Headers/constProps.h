//
//  constProps.h
//  NgVoice
//
//  Created by ZYN1176 on 16/2/19.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#ifndef NT_VOICE_constProps_h
#define NT_VOICE_constProps_h

//#define NT_DEBUG_MODE       @"DEBUG_MODE"
//#define NT_FILE_PATH        @"LOCAL_PATH"
//#define NT_SERVER_HOST      @"SERVER_HOST"
//#define NT_SERVER_PATH      @"SERVER_PATH"
//#define NT_SERVER_TOUSER    @"SERVER_TOUSER"
//#define NT_MAX_DURATION     @"MAX_DURATION"
//#define NT_MIN_DURATION     @"MIN_DURATION"
//
////-----------------------------NOTIFICATIONS-----------------------
////录音完成（中途取消没有通知）
////失败userInfo字段 : _ERROR
////成功userInfo字段 : _DURATION
//#define NG_VOICE_NOTIFICATION_RECORD_FINISH @"NG_VOICE_NOTIFICATION_RECORD_COMPLETE"
//
//
////播放完成（中途停止没有通知）
////失败userInfo字段 : _REEOR
////成功userInfo字段 : 空
//#define NG_VOICE_NOTIFICATION_PLAYBACK_FINISH @"NG_VOICE_NOTIFICATION_PLAYBACK_FINISH"
//
////上传完成
////失败userInfo字段 : _ERROR、_FILENAME
////成功userInfo字段 : _FILENAME、_KEY
//#define NG_VOICE_NOTIFICATION_UPLOAD_FINISH @"NG_VOICE_NOTIFICATION_UPLOAD_FINISH"
//
////获取翻译完成
////失败userInfo字段 : _ERROR、_KEY
////成功userInfo字段 : _KEY、_TRANSLATE_TEXT
//#define NG_VOICE_NOTIFICATION_TRANSLATE_FINISH @"NG_VOICE_NOTIFICATION_TRANSLATE_FINISH"
//
////下载完成
////失败userInfo字段 : _ERROR、 _KEY、 _FILENAME
////成功userInfo字段 : _KEY、 _FILENAME
//#define NG_VOICE_NOTIFICATION_DOWNLOAD_FINISH @"NG_VOICE_NOTIFICATION_DOWNLOAD_FINISH"
//
////----------------------------USER_INFO----------------------------
////出错，错误信息，值是字符串
//#define NG_VOICE_NOTIFICATION_INFO_ERROR @"error"
//
////语音key值，对应值是字符串
//#define NG_VOICE_NOTIFICATION_INFO_KEY @"key"
//
////语音文件名
//#define NG_VOICE_NOTIFICATION_INFO_FILENAME @"file_name"
//
////翻译结果
//#define NG_VOICE_NOTIFICATION_INFO_TRANSLATE_TEXT @"translate_text"
//
////录音时长，对应值是 NSNumber（double）
//#define NG_VOICE_NOTIFICATION_INFO_DURATION @"duration"

extern NSString* const NT_VOICE_NUM_DEBUG; //"DEBUG";
extern NSString* const NT_VOICE_NUM_MIN_RECORD_DURATION; //"MIN_DURATION";
extern NSString* const NT_VOICE_NUM_MAX_RECORD_DURATION; //"MAX_DURATION";

extern NSString* const NT_VOICE_STR_LOCAL_PATH; //"LOCAL_PATH";
extern NSString* const NT_VOICE_STR_SERVER_PATH; //"SERVER_PATH";
extern NSString* const NT_VOICE_STR_SERVER_TOUSER; //"SERVER_TOUSER";
extern NSString* const NT_VOICE_STR_SERVER_HOST; //"SERVER_HOST";
extern NSString* const NT_VOICE_STR_SERVER_USER_AGENT; //"USER_AGENT";

extern NSString* const NT_VOICE_STR_ABSOLUTE_PATH; //"ABSOLUTE_PATH"

#endif /* constProps_h */
