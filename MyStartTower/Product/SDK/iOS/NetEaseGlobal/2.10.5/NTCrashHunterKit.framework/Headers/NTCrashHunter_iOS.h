//
//  NTCrashHunter_iOS.h
//  NTCrashHunterKit
//
//  Created by Boat on 2021/5/17.
//  Copyright © 2021 Darren. All rights reserved.
//

#ifndef NTCrashHunter_iOS_h
#define NTCrashHunter_iOS_h

#include <stdbool.h>


#ifdef __cplusplus
extern "C" {
#endif

typedef struct NTCAssociatedFile
{
    const char *file_name;
    const char *file_path;
    const char *content;
}NTCAssociatedFile;

typedef void (*NTCrashCallback)(void);
typedef void (*NTEventCallback)(int eventType, const char *json_string);

void startCrashHunter(void);

void setDebugMode(bool debug_mode);

bool getDebugMode(void);

void setParam(const char *key, const char *value);

const char* getParam(const char *key);

bool safelyBindCondition(const char *key, const char *value);

bool safelyUnbindCondition(const char *key, const char *value);

bool isLastTimeCrash(void);

void setCrashCallback(NTCrashCallback callback);

void setEventCallback(NTEventCallback callback);

void addFiles(NTCAssociatedFile** files, int fileCount);

void postFiles(NTCAssociatedFile* mainFile,
               NTCAssociatedFile** files,
               int fileCount,
               const char *eventType);

void testMakeCrash(void);

#ifdef __cplusplus
}
#endif

#endif /* NTCrashHunter_iOS_h */

