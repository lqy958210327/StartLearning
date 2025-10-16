
#ifndef AppDumpWorker_hpp
#define AppDumpWorker_hpp

#include <stddef.h>
#if __has_include(<HAL/Platform.h>)
#include <HAL/Platform.h>
#endif

#if __has_include(<TargetConditionals.h>)
#include <TargetConditionals.h>
#endif


#if PLATFORM_WINDOWS
#define APPDUMP_WORKER_EXPORTS __declspec(dllimport)
#else
#define APPDUMP_WORKER_EXPORTS
#endif


typedef struct AppDumpAssociatedFile
{
    const char* content;
    const char* filePath;
    const char* fileName;
    const char* fileFeature;
} AppDumpAssociatedFile;


typedef void (*AppDumpEventCallback)(int, const char*);

class AppDumpWorker
{
public:
    virtual ~AppDumpWorker() {}
    APPDUMP_WORKER_EXPORTS static AppDumpWorker *GetInstance();
    virtual void SetDebugMode(bool debugMode) = 0;
    virtual void SetEventCallback(AppDumpEventCallback eventCallback) = 0;
    virtual void AddFiles(const AppDumpAssociatedFile **files, size_t count) = 0;
    virtual void PostFiles(const AppDumpAssociatedFile *mainFile,
                           const AppDumpAssociatedFile **minorFiles,
                           size_t minorFilesCount,
                           const char *errorType) = 0;
    virtual void StartHuntingCrash() = 0;
    virtual void Unseal() = 0;
    virtual bool IsLastTimeAnr() = 0;
    virtual bool IsLastTimeCrash() = 0;
    virtual const char *GetUploadFileDir() = 0;
    virtual void SetParam(const char *key, const char* value) = 0;
    virtual bool SafelyBindCondition(const char *key, const char *value) = 0;
    virtual bool SafelyUnbindCondition(const char *key, const char *value) = 0;
    virtual void SetUrl(const char* url) = 0;
    virtual void SetHost(const char* host) = 0;
    virtual void SetBranch(const char* branch) = 0;
    virtual void ExtendFunc(const char* jsonString) = 0;
#if TARGET_OS_IOS || TARGET_OS_OSX
    virtual void CaptureStackBacktrace() = 0;
#endif
};



#endif /* AppDumpWorker_hpp */
