//
//  KSCrashManualReport.h
//  KSCrash
//
//  Created by Darren on 2021/9/10.
//  Copyright © 2021 Karl Stenerud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach/mach.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSCrashManualReport : NSObject

+ (thread_t)mainThread;

+ (BOOL)generateAppleFormatReportToFilePath:(NSString *)filePath
                                     reason:(NSString * _Nullable)reason
                               userDumpType:(NSString * _Nullable)userDumpType;

@end

NS_ASSUME_NONNULL_END
