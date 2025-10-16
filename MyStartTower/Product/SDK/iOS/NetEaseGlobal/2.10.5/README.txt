#2024-08-05 version=2.10.5
user_log:
    1. 修复多插件启动时di数据构建异常的bug；
    
#2024-06-25 version=2.10.4
user_log:
    1. 支持冷启动5秒内的闪退事件归类为启动闪退；
    2. 新增event type=15表示上次运行过程中出现启动闪退；
dev_log:
    1. 冷启动后若检测到有启动闪退数据或者历史遗留的启动闪退数据，则立即上报。上报成功，则清空启动闪退数据对应的目录；
    

#2024-05-17 version=2.10.3
user_log:
    1. CrashHunter UnityPackage使用C接口转移至SDK内;
    2. 解决CrashHunter UnityPackage内存泄漏问题；
    
    
#2024-04-18 version=2.10.1
user_log:
    1. AppDumpWorker接口增加CaptureStackBacktrace；
    
    
#2024-04-12 version=2.10.0
user_log:
    1. AppDumpWorker crash回调新增崩溃线程ID；
    2. OOM方案大优化，提升命中率；
    3. 获取配置时增加first device id用于统计启动数；
    4. di文件增加first device id用于计算crash率；
    5. 异常退出插件支持uid&user name的实时更新；
    6. 修复异常时间戳可能出错的bug；


#2023-11-01 version=2.9.1
user_log:
    1. 修复SIGPIPE依然可能被捕获的Bug；
    
    
#2023-09-07 version=2.9.0
user_log:
    1. 异常退出插件迁移至CrashHunter内；
    2. MetricKit堆栈结构完善；
    3. 上报和配置域名增加项目ID前缀；
    4. C++统一接口增加AddEventFiles & CaptureStackBacktrace；
    
    
#2023-08-02 version=2.8.1
user_log:
    1. 支持文件拷贝结果回调；
    
    
#2023-07-20 version=2.8.0
user_log:
    1. 支持UE Plugin;
    2. 支持上报UE_FATAL类型数据时，自动带上module信息；


#2023-06-06 version=2.7.2
user_log:
    1. idfx先从母包获取，获取失败则自建；
    
    
#2023-05-10 version=2.7.1
user_log:
    1. 优化插件设计；


#2023-04-27 version=2.7.0
user_log:
    1. 支持ANR捕获；
    2. 数据设置与上报同步化处理；


#2023-04-03 version=2.6.5
user_log:
    1. 恢复metrickit相关支持；
    2. 文件压缩过程中，读取文件数据到内存不足时，可能会出现"NSConcreteFileHandle readDataOfLength:"异常的问题修复；


#2023-03-11 version=2.6.4 buildid=195630
user_log:
	1. 移除metrickit相关支持，解决机审问题；
dev_log:
	1. 移除i386架构；


#2023-03-07 version=2.6.3 buildid=111723
user_log:
	1. 完全删除__NSArrayM/__NSArray0/__NSArrayI/__NSCFBoolean/NSBlock等私有类簇的符号；


#2023-02-23 version=2.6.2 buildid=114335
user_log:
	1. 移除__NSArrayM/__NSArray0/__NSArrayI等私有类簇的符号；


#2023-02-13 version=2.6.1 buildid=153740
user_log:
	1. 隐藏__NSCFBoolean符号，规避审核风险；


#2023-02-08 version=2.6.0 buildid=140935
user_log:
	1. 支持MetricKit；
	2. 关联文件缓存IO优化；
	3. 确保配置落地完成后再执行启动流程；


#2022-12-02 version=2.5.0 buildid=021441
user_log:
	1. Mac & iOS版本的内核同步，包括日志、文件管理、网络层等；


#2022-12-01 version=2.4.2 buildid=011512
user_log:
	1. Unity bridge layer增加事件回调接口；
	2. 支持数据上传结果回调；


#2022-11-04 version=2.4.1 buildid=041513
user_log:
	1. 修复异常文件的路径缓存出错的逻辑；


#2022-10-18 version=2.4.0 buildid=181018
user_log:
	1. di文件支持上报包体签名；
	2. 周期上报历史缓存数据；
	3. 增加is_foreground字段区分前后台；
	4. 上报数据要求启动成功后才有效；
	5. 修复日志写入文件在磁盘不足时的异常情况；
	6. 修复数据容器在极端条件下可能的异常情况；
	7. 处理上报队列出现大量脏数据的线程阻塞问题；


#2022-05-23 version=2.3.2
user_log:
	1. memory warning事件增加5秒冷却期；
	2. 移除上报body内的identify字段；
	3. 支持安全组获取游戏内的环境信息；


#2022-04-27 version=2.3.1
user_log:
	1. 增加启动时，user termination事件回调数据沙盒路径，延缓启动数据上报时机；
	2. 增加启动结果的标志位，用于UniAPM1.3.0版本分析异常退出；
dev_log:
	1. 删除卡顿插件和OOM插件的遗留代码；
	2. 优化CrashHunter启动流程，确保启动成功再初始化DeviceInfo；


#2022-01-19 version=2.3.0
user_log:
	1. 优化头文件版本字符串定义；
	2. 修复二次异常闪退日志可能为空的场景；


#2021-12-10 version=2.2.9
user_log:
	1. 优化二次异常死锁的极端场景;
	2. 日志文件独立到Documents/Unisdk_log/crashhunter_log.txt;
	3. 支持openLog字段将日志直接写入文件;
	4. 移除历史插件化的调用接口，转移至RUM平台；
	5. 支持eventOccurCallback回调上次crash事件的目录；


#2021-12-09
version=2.2.8(1)
user_log:
	1. 修复Unity safebind接口日志输出格式出错的bug；


#2021-12-01
version=2.2.8 
user_log:
	1. 遵循法务隐私协议，处理idfa&idfv要求；
	2. 修复cfg文件读取失败可能导致异常的bug；
	3. 关闭后台传输任务标志位不允许动态修改，防止网络请求前后状态不一致导致被系统后台强杀的可能。
dev_log:
	1. device_id从transid获取；
	2. swizzle_InstanceMethod调整为静态函数避免符号冲突；


#2021-11-05
version=2.2.7 稳定版本(Crash Plugin only) 
	1. transid规则统一；


#2021-10-08
version=2.2.6 稳定版本(Crash Plugin only) 
	1. 支持获取当前堆栈信息；


#2021-08-10
version=2.2.5 稳定版本(Crash Plugin only) 
	1. 目录、代码符号删除“netease”字符；
	2. 支持设置noah target，上报/配置接口支持appdump.noahsdk.com；


#2021-07-28
version=2.2.4 稳定版本(Crash Plugin only) 
	1. 支持所有APM插件和母包的transid打通；
	2. 历史Crash日志上报根据最近时间排序串行阻塞上报优化；


#2021-04-15
version=2.2.2 稳定版本(Crash Plugin only) 
	1. 支持修改crash hunter内的所有host；


#2021-01-27
version=2.2.1 稳定版本(Crash Plugin only)
	1. 新增上次生命周期是否发生crash的判断接口；


#2021-01-27
version=2.2.0 稳定版本(Crash Plugin only)
user_log:
	1. 提供postPrimaryFile:associatedFiles:eventTypeString API；
	2. 提供eventTypeString的默认值选择；
dev_log:
	1. 拆解CrashPlugin/OOM Plugin/Lag Plugin；
	2. 废弃卡顿使用的engineType字段；
	3. SDK架构设计兼容MacOS & iOS;


#2021-01-13
version=2.2.0 apm_beta版本
user_log:
	1. 修复卡顿堆栈信息缺乏Binary Images的Bug；


#2020-12-17
version=2.1.6 版本
user_log:
	1. 细节调优，接口线程安全处理。


#2020-11-17
version=2.1.5 版本
user_log:
	1. 后台上传增加开关控制；
	2. 处理高并发上传数据时，主线程阻塞问题；


#2020-10-23
version=2.1.4(1) 版本
user_log:
	1. 支持卡顿特性，正式版本；
	2. 修复屏幕分辨率参数错误问题；
	3. KSCrash堆栈写入支持中文内容。


#2020-10-23
version=2.1.4 版本
user_log:
	1. 支持卡顿特性，正式版本。
	2. 支持通用的事件回调接口和通用的文件数据添加接口；
	3. 支持帧渲染回调；


#2020-09-11
version=2.1.3
dev_log:
	1. 修复无渠道包的情况下，本地cfg解析历史日志可能存在空指针crash问题。


#2020-09-23
version=2.1.2(lagbeta)版本
user_log:
	1. 支持卡顿特性，测试阶段版本，针对部分游戏开放该能力；
	2. 支持通用的事件回调接口和通用的文件数据添加接口；


#2020-09-02
version=2.1.1(2)
dev_log:
	1. KSCrash堆栈写入支持中文内容。


#2020-06-19
version=2.1.1(1)
dev_log:
	1. 修复优化CrashHunter启动流程导致产品无法准确写入数据的BUG。


#2020-05-12
version=2.1.1
user_log:
	1. 优化CrashHunter启动流程；
	2. 卡顿模块转移至独立分支；
dev_log:
	1. 优化关联文件内存使用
	2. 确保闪退日志有Crash堆栈文件


#2020-04-03
version=2.1.0
user_log:
	1. 卡顿相关配置参数接口；
	2. 启动参数类型安全校验；
dev_log:
	1. 卡顿二期需求开发，主要包括配置落地、文件数量控制；
	2. 上层与底层数据透传、配置透传、日志开关透传等。


#2020-03-05
version=2.0.9(1)
user_log:
	1. 修复setRootPath unfound 问题
	2. 处理xcode10兼容性问题


#2020-02-25
version=2.0.9
user_log:
	1. 处理数据序列化的线程安全问题；
	2. 增加后台数据上传特性；
dev_log:
	1. 支持启动数上报


#2019-11-12
version=2.0.8
user_log:
	1. 增加unity3d错误类型：U3D_ERROR
	2. 处理部分Unity3D引擎环境下对open()系统调用执行hook后可能导致的错误


#2019-11-07
version=2.0.7(1)
user_log:
	1. 支持Xcode10链接该二进制framework


#2019-11-05
version=2.0.7
user_log:
	1. 不再限制engineVersion与resVersion字段的填写规则；
	2. 不再支持未知的错误类型
	3. 修复engineVersion和resVersion无法重设的bug
dev_log:
	I: fetch config interface substitute cpu& gpu for cpu_type&gpu_type fields.


#2019-10-15
version=2.0.6
user_log:
	1. 增加branch接口和设置过滤条件的接口;
	2. Di文件内新增bundle_version和bundle_identifier，unisdk_version和channel;
	3. 修复获取GPU参数导致framework在iOS Simulator错误的问题;
dev_log:
	I:config接口与数据上报请求都带上channel/bundle_version/model/cpu_type/gpu_type;
	II:原本的bundle_version拆分为bundle_version+bundle_identifier;
	III:原本的unisdk_version拆分为unisdk_version+channel;
	IIII:目前启动数依然取自Detect数据源，因为向EasyDetect内新增了engine_version、res_version 、	     bundle_version来计算不同引擎、脚本代码、包版本的崩溃率；
	

#2019-09-24
version=2.0.5
1. 忽视SigPipe与SigSys信号的处理。


#2019-09-24
version=2.0.4(1)
1. 电池信息获取后，关闭设备电池监控的开关的逻辑不再保留。


#2019-09-12
version=2.0.4
1. 全面支持iOS13


#2019-08-12
version=2.0.3(1)
1. url接口开放给游戏设置


#2019-06-18
version=2.0.3
1.支持postUserInfo接口上报uid/urs，统计激活用户数量和受影响数量；
2.修复KSCrash 生成report时Date/Time=null的bug；


#2019-06-01
version=2.0.2
1.支持全封闭接口
2.url只使用于Debug状态
3. Crash hunter启动结果返回；
4. 增加addExtensionInfo接口透传至di文件。


#2019-05-05
version=2.0.1
1. KSCrash与NTCrashHunterKit统一为.framework;
2. 支持过滤条件设置;
3. 支持文件特性设置;
4. 内部Log开关控制;
5. 增加file feature用于区分混淆文件。


#2019-04-01
version=2.0.0(1)
1.配置参数使用上一次接口获取的缓存结果。


#2019-03-20
版本 2.0.0
1. 全新版本CrashHunter上线！
2. 支持线程安全的高并发调用；
3. 支持启动配置落地控制逻辑；
4. 支持过期文件处理、文件大小裁剪、单一接口；
5. 完全兼容旧版本功能；
