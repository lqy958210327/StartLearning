//
//  KSSystemCapabilities.h
//
//  Copyright (c) 2012 Karl Stenerud. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#ifndef HDR_KSSystemCapabilities_h
#define HDR_KSSystemCapabilities_h

#ifdef __APPLE__
/*
 #ifdef _WIN64
 //define something for Windows (64-bit)
 #elif _WIN32
 //define something for Windows (32-bit)
 #elif __APPLE__
 #include "TargetConditionals.h"
 #if TARGET_OS_IPHONE && TARGET_IPHONE_SIMULATOR
 // define something for simulator
 #elif TARGET_OS_IPHONE
 // define something for iphone
 #else
 #define TARGET_OS_OSX 1
 // define something for OSX
 #endif
 #elif __linux
 // linux
 #elif __unix // all unices not caught above
 // Unix
 #elif __posix
 // POSIX
 #endif
 */
//https://sourceforge.net/p/predef/wiki/OperatingSystems/ 指出__apple__是OS X 编译器的预定义宏
//__OBJC__  使用这个predefined_macro应该也可以的。
//参考https://gcc.gnu.org/onlinedocs/cpp/Standard-Predefined-Macros.html#Standard-Predefined-Macros
//This macro is defined, with value 1, when the Objective-C compiler is in use. You can use __OBJC__ to test whether a header is compiled by a C compiler or an Objective-C compiler.
#include <TargetConditionals.h>
//至于为什么需要include targetConditionals，可以查看苹果的源码
//参考：https://opensource.apple.com/source/CarbonHeaders/CarbonHeaders-18.1/TargetConditionals.h
//目的就是为了拿到TARGET_OS_XXX的宏定义，判断当前的target.
#define KSCRASH_HOST_APPLE 1
#endif

#ifdef __ANDROID__
#define KSCRASH_HOST_ANDROID 1
#endif

#define KSCRASH_HOST_IOS (KSCRASH_HOST_APPLE && TARGET_OS_IOS)
#define KSCRASH_HOST_TV (KSCRASH_HOST_APPLE && TARGET_OS_TV)
#define KSCRASH_HOST_WATCH (KSCRASH_HOST_APPLE && TARGET_OS_WATCH)
#define KSCRASH_HOST_MAC (KSCRASH_HOST_APPLE && TARGET_OS_MAC && !(TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH))

#if KSCRASH_HOST_APPLE
#define KSCRASH_CAN_GET_MAC_ADDRESS 1
#else
#define KSCRASH_CAN_GET_MAC_ADDRESS 0
#endif

#if KSCRASH_HOST_APPLE
#define KSCRASH_HAS_OBJC 1
#define KSCRASH_HAS_SWIFT 1
#else
#define KSCRASH_HAS_OBJC 0
#define KSCRASH_HAS_SWIFT 0
#endif

#if KSCRASH_HOST_APPLE
#define KSCRASH_HAS_KINFO_PROC 1
#else
#define KSCRASH_HAS_KINFO_PROC 0
#endif

#if KSCRASH_HOST_APPLE
#define KSCRASH_HAS_STRNSTR 1
#else
#define KSCRASH_HAS_STRNSTR 0
#endif

#if KSCRASH_HOST_IOS || KSCRASH_HOST_TV || KSCRASH_HOST_WATCH
#define KSCRASH_HAS_UIKIT 1
#else
#define KSCRASH_HAS_UIKIT 0
#endif

#if KSCRASH_HOST_IOS || KSCRASH_HOST_TV
#define KSCRASH_HAS_UIAPPLICATION 1
#else
#define KSCRASH_HAS_UIAPPLICATION 0
#endif

#if KSCRASH_HOST_WATCH
#define KSCRASH_HAS_NSEXTENSION 1
#else
#define KSCRASH_HAS_NSEXTENSION 0
#endif

#if KSCRASH_HOST_IOS
#define KSCRASH_HAS_MESSAGEUI 1
#else
#define KSCRASH_HAS_MESSAGEUI 0
#endif

#if KSCRASH_HOST_IOS || KSCRASH_HOST_TV
#define KSCRASH_HAS_UIDEVICE 1
#else
#define KSCRASH_HAS_UIDEVICE 0
#endif

#if KSCRASH_HOST_IOS || KSCRASH_HOST_MAC || KSCRASH_HOST_TV
#define KSCRASH_HAS_ALERTVIEW 1
#else
#define KSCRASH_HAS_ALERTVIEW 0
#endif

#if KSCRASH_HOST_IOS
#define KSCRASH_HAS_UIALERTVIEW 1
#else
#define KSCRASH_HAS_UIALERTVIEW 0
#endif

#if KSCRASH_HOST_TV
#define KSCRASH_HAS_UIALERTCONTROLLER 1
#else
#define KSCRASH_HAS_UIALERTCONTROLLER 0
#endif

#if KSCRASH_HOST_MAC
#define KSCRASH_HAS_NSALERT 1
#else
#define KSCRASH_HAS_NSALERT 0
#endif

#if KSCRASH_HOST_IOS || KSCRASH_HOST_MAC
#define KSCRASH_HAS_MACH 1
#else
#define KSCRASH_HAS_MACH 0
#endif

// WatchOS signal is broken as of 3.1
#if KSCRASH_HOST_ANDROID || KSCRASH_HOST_IOS || KSCRASH_HOST_MAC || KSCRASH_HOST_TV
#define KSCRASH_HAS_SIGNAL 1
#else
#define KSCRASH_HAS_SIGNAL 0
#endif

#if KSCRASH_HOST_ANDROID || KSCRASH_HOST_MAC || KSCRASH_HOST_IOS
#define KSCRASH_HAS_SIGNAL_STACK 1
#else
#define KSCRASH_HAS_SIGNAL_STACK 0
#endif

#if KSCRASH_HOST_MAC || KSCRASH_HOST_IOS || KSCRASH_HOST_TV
#define KSCRASH_HAS_THREADS_API 1
#else
#define KSCRASH_HAS_THREADS_API 0
#endif

#if KSCRASH_HOST_MAC || KSCRASH_HOST_IOS || KSCRASH_HOST_TV
#define KSCRASH_HAS_REACHABILITY 1
#else
#define KSCRASH_HAS_REACHABILITY 0
#endif

#endif // HDR_KSSystemCapabilities_h
