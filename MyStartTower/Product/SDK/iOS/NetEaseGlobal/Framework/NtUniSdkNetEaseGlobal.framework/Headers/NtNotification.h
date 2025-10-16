//
//  NtNotification.h
//  NtUniSdk
//
//  Created by UniSDK on 14-6-27.
//  Copyright (c) 2014年 Game-NetEase. All rights reserved.
//

#ifndef NtNotification_h
#define NtNotification_h

//--------------------------- BASIC NOTIFICATION ---------------------------//

/**
 * @brief 用户注册的通知
 */
#define NT_NOTIFICATION_REGISTER                @"NT_NOTIFICATION_REGISTER"

/**
 * @brief 用户登录的通知
 */
#define NT_NOTIFICATION_LOGIN                   @"NT_NOTIFICATION_LOGIN"

/**
 * @brief 用户注销的通知
 */
#define NT_NOTIFICATION_LOGOUT                  @"NT_NOTIFICATION_LOGOUT"

/**
 * @brief 管理界面关闭的通知
 */
#define NT_NOTIFICATION_CLOSE_MANAGERVIEW       @"NT_NOTIFICATION_CLOSE_MANAGERVIEW"

/**
 * @brief 充值界面关闭的通知
 */
#define NT_NOTIFICATION_CLOSE_FFVIEW           @"NT_NOTIFICATION_CLOSE_FFVIEW"

/**
 *  @brief 网易支付结束
 */
#define NT_NOTIFICATION_ORDER_DID_FF           @"NT_NOTIFICATION_ORDER_DID_FF"

/**
 *  @brief 实名认证回调
 */
#define NT_NOTIFICATION_REALNAME_VERIFY           @"NT_NOTIFICATION_REALNAME_VERIFY"

/**
 * @brief 暂停页关闭的通知
 */
#define NT_NOTIFICATION_CLOSE_PAUSEVIEW         @"NT_NOTIFICATION_CLOSE_PAUSEVIEW"

/**
 * @brief 初始化完成的通知
 */
#define NT_NOTIFICATION_FINISH_INIT             @"NT_NOTIFICATION_FINISH_INIT"

/**
 * @brief 设定分服服务器的通知
 */
#define NT_NOTIFICATION_SET_SERVERID            @"NT_NOTIFICATION_SET_SERVERID"

/**
 * @brief 显示页面的通知（成功、失败、关闭等）
 */
#define NT_NOTIFICATION_SHOW_WEB                @"NT_NOTIFICATION_SHOW_WEB"

/**
 * @brief 获取到支付完成但未验证发货的订单
 */
#define NT_NOTIFICATION_REMAIN_ORDER            @"NT_NOTIFICATION_REMAIN_ORDER"

/**
 *  验证手机号
 */
#define NT_NOTIFICATION_VERIFY_MOBILE           @"NT_NOTIFICATION_VERIFY_MOBILE"


/**
 * @brief 切换账户的通知
 */
#define NT_NOTIFICATION_SWITCH_ACCOUNT          @"NT_NOTIFICATION_SWITCH_ACCOUNT"

/**
 * @brief 请求用户币种信息的通知（这个已经没有用了，废弃）
 */
#define NT_NOTIFICATION_FINISH_QUERY_CURRENCY  @"NT_NOTIFICATION_FINISH_QUERY_CURRENCY"
#define NT_NOTIFICATION_FAILED_QUERY_CURRENCY @"NT_NOTIFICATION_FAILED_QUERY_CURRENCY"
#define NT_NOTIFICATION_INFO_CURRENCY @"NT_NOTIFICATION_INFO_CURRENCY"

/**
 *  @brief 获取商品信息
 */
#define NT_NOTIFICATION_FINISH_GET_PRODUCT_INFO @"NT_NOTIFICATION_FINISH_GET_PRODUCT_INFO"

/**
 *  @brief 用户界面有新消息
 */
#define NT_NOTIFICATION_NEW_MESSAGE @"NT_NOTIFICATION_NEW_MESSAGE"

/**
 *  @brief 扫描二维码登录成功(网易SDK的回调)
 */
#define NT_NOTIFICATION_LOGIN_BY_QRCODE @"NT_NOTIFICATION_LOGIN_BY_QRCODE"

/**
 *  @brief 扫码二维码成功(网易SDK的回调)
 */
#define NT_NOTIFICATION_SCAN_QRCODE_SUCCESS @"NT_NOTIFICATION_SCAN_QRCODE_SUCCESS"

/**
 *  @brief 创建二维码回调(UniSDK的回调)
 */
#define NT_NOTIFICATION_CREATE_QRCODE @"NT_NOTIFICATION_CREATE_QRCODE"
/**
 *  @brief 创建二维码回调(UniSDK的回调)
 */
#define NT_NOTIFICATION_SCAN_QRCODE @"NT_NOTIFICATION_SCAN_QRCODE"

/**
 *  @brief 二维码扫描相册图片完成
 */
#define NT_NOTIFICATION_SCAN_QRCODE_Library_Album_Finish @"NT_NOTIFICATION_SCAN_QRCODE_Library_Album_Finish"



/**
 *  @brief 创建订单号成功(去计费服务器创建订单号的回调)
 */
#define NT_NOTIFICATION_FINISH_CREATE_SN @"NT_NOTIFICATION_FINISH_CREATE_SN"

/**
 *  闪屏结束
 */
#define NT_NOTIFICATION_SPLASH_VIEW_FINISHED @"NT_NOTIFICATION_SPLASH_VIEW_FINISHED"
/**
 *  闪屏被点击
 */
#define NT_NOTIFICATION_SPLASH_VIEW_TOUCHED @"NT_NOTIFICATION_SPLASH_VIEW_TOUCHED"

//--------------------------- SOCIAL NOTIFICATION ---------------------------//

/**
 *  @brief 请求好友列表完成的通知
 */
#define NT_NOTIFICATION_FINSIH_QUERY_FRIEND_LIST            @"NOTIFICATION_FINSIH_QUERY_FRIEND_LIST"


/**
 *  @brief 请求好友列表完成的通知
 */
#define NT_NOTIFICATION_FINSIH_QUERY_FRIEND_LIST_IN_GAME    @"NOTIFICATION_FINSIH_QUERY_FRIEND_LIST_IN_GAME"

/**
 *  @brief 请求可添加列表完成的通知
 */
#define NT_NOTIFICATION_FINSIH_QUERY_AVAILABLES_INVITEES    @"NOTIFICATION_FINSIH_QUERY_AVAILABLES_INVITEES"

/**
 *  @brief 请求添加好友完成的通知
 */
#define NT_NOTIFICATION_FINSIH_APPLEY_FRIEND                @"NOTIFICATION_FINSIH_APPLEY_FRIEND"

/**
 *  @brief 请求当前账号信息完成的通知
 */
#define NT_NOTIFICATION_FINSIH_QUERY_MY_ACCOUNT             @"NOTIFICATION_FINSIH_QUERY_MY_ACCOUNT"

/**
 *  @brief 获取排行榜信息完成的通知
 */
#define NT_NOTIFICATION_FINSIH_QUERY_RANK                   @"NOTIFICATION_FINSIH_QUERY_RANK"

/**
 *  @brief 更新排行榜信息完成
 */
#define NT_NOTIFICATION_FINSIH_UPDATE_RANK                  @"NOTIFICATION_FINSIH_UPDATE_RANK"

/**
 *  @brief 分享完成的通知
 */
#define NT_NOTIFICATION_FINSIH_SHARE                        @"NOTIFICATION_FINSIH_SHARE"

/**
 *  @brief 删除可发送邀请的好友
 */
#define NT_NOTIFICATION_FINISH_DELETE_INVITERS                        @"NOTIFICATION_FINSIH_DELETE_INVITERS"

/**
 *  @brief 发送推送消息
 */
#define NT_NOTIFICATION_FINISH_SEND_PUSH @"NT_NOTIFICATION_FINISH_SEND_PUSH"
/**
 *  @brief 发送推送消息
 */
#define NT_NOTIFICATION_FINISH_SEND_LOCALE_PUSH @"NT_NOTIFICATION_FINISH_SEND_LOCALE_PUSH"
/**
 *  @brief 取消本地推送消息
 */
#define NT_NOTIFICATION_CANCEL_SEND_LOCALE_PUSH @"NT_NOTIFICATION_CANCEL_SEND_LOCALE_PUSH"

/**
 *  @brief 设置推送开关
 */
#define NT_NOTIFICATION_FINISH_SET_PUSH @"NT_NOTIFICATION_FINISH_SET_PUSH"
/**
 *  @brief 获取推送开关状态
 */
#define NT_NOTIFICATION_FINISH_GET_PUSH @"NT_NOTIFICATION_FINISH_GET_PUSH"

/**
 *  @brief  关联渠道回调
 */
#define NT_NOTIFICATION_FINISH_CONNECT_CHANNEL @"NT_NOTIFICATION_FINISH_CONNECT_CHANNEL"
/**
 *  @brief  取消渠道关联的回调
 */
#define NT_NOTIFICATION_FINISH_DISCONNECT_CHANNEL @"NT_NOTIFICATION_FINISH_DISCONNECT_CHANNEL"
/**
 *  @brief  选择关联类型的回调
 */
#define NT_NOTIFICATION_FINISH_SELECT_CHANNEL_OPTION @"NT_NOTIFICATION_FINISH_SELECT_CHANNEL_OPTION"

/**
 *  @brief Gamecenter相关通知
 */
#define NT_NOTIFICATION_FINISH_GAMECENTER @"NT_NOTIFICATION_FINISH_GAMECENTER"


#define NT_NOTIFICATION_GET_NOTICE @"NT_NOTIFICATION_GET_NOTICE"

/**
 *  @brief 渠道中某些非常用的通知
 */
#define NT_NOTIFICATION_EXTEND @"NT_NOTIFICATION_EXTEND"

/**
 *  @brief 渠道中内部使用的拓展接口回调
 */
#define NT_NOTIFICATION_EXTEND_INNER @"NT_NOTIFICATION_EXTEND_INNER"

/**
 *  @brief 绑定游客后客户端的通知
 */
#define NT_NOTIFICATION_GUEST_BIND @"NT_NOTIFICATION_GUEST_BIND"

/**
 * @brief 下载回调的通知
 */
#define NT_NOTIFICATION_DOWNLOAD                   @"NT_NOTIFICATION_DOWNLOAD"

/**
 * @brief Appstore调起支付的通知
 */
#define NT_NOTIFICATION_PROMOTE_IAP                 @"NT_NOTIFICATION_PROMOTE_IAP"

//--------------------------- USERINFO KEY ---------------------------//
/**
 *  @brief NT_NOTIFICATION_FINISH_INIT 中 userInfo 字段
 */
#define NT_NOTIFICATION_POST_CHANNEL        @"post_channel"

/**
 *  @brief NT_NOTIFICATION_FINISH_INIT 中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_INIT_STATE        @"init_state"

/**
 *  @brief 初始化通知中的初始化状态
 */
#define NT_NOTIFICATION_INFO_INIT_OK           @0
#define NT_NOTIFICATION_INFO_INIT_FAILED       @1

/**
 *  @brief Notification 中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_ERROR              @"error"

/**
 *  @brief Notification 中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_CODE              @"code"

/**
 *  @brief NT_NOTIFICATION_LOGIN 中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_LOGIN_STATE        @"login_state"
/**
 *  @brief 登陆通知中的登陆状态
 */
#define NT_NOTIFICATION_INFO_LOGIN_OK           @0 // 用户登录成功
#define NT_NOTIFICATION_INFO_LOGIN_FAILED       @1 // 用户登录失败
#define NT_NOTIFICATION_INFO_LOGIN_CANCEL       @2 // 用户取消登录
#define NT_NOTIFICATION_INFO_NET_UNAVAILABLE    @3 // 网络不可用
#define NT_NOTIFICATION_INFO_SDK_SERV_ERR       @4 // sdk服务器错误导致无法登录
#define NT_NOTIFICATION_INFO_NET_TIME_OUT       @5 // 网络超时
#define NT_NOTIFICATION_INFO_SDK_NOT_INIT       @6 // sdk还未初始化
#define NT_NOTIFICATION_INFO_UNKNOWN_ERR        @10 // 未知错误
#define NT_NOTIFICATION_INFO_NEED_GS_CONFIRM    @11 // 需要游戏服二次确认
#define NT_NOTIFICATION_INFO_NEED_RELOGIN       @12 // 需要重新登录
#define NT_NOTIFICATION_INFO_BIND_OK            @13 // 网易SDK海外版(netease_global)绑定成功的状态,目前给G37单独使用，如果其他渠道要用到该变量，请联系hzzn0765@corp.netease.com,否则先不要使用，现在不确定g37是否会使用该方案，不使用的话后续有会删除这个变量。
#define NT_NOTIFICATION_INFO_LOGIN_GREEN        @14 // 网易SDK海外版(netease_global)登录绿色版
#define NT_NOTIFICATION_INFO_ACCOUNT_REGION_ERROR   @15 // 登录地区匹配错误
#define NT_NOTIFICATION_INFO_CHILD_PROTECT_ERR  @16 // 儿保登录失败
#define NT_NOTIFICATION_INFO_UNISDK_BIND_OK     @(130)  // 自建游客绑定成功
#define NT_NOTIFICATION_INFO_UNISDK_BIND_FAIL   @(-130) // 自建游客绑定失败

/**
 *  增加的登录错误码，在对应的登录失败状态下设置到NT_ERROR_CODE的prop中
 */
#define NT_LOGIN_ERROR_CODE_LOGIN_CANCEL       @1 // 用户取消登录
#define NT_LOGIN_ERROR_CODE_WRONG_PASSWD       @2 // 用户名或者密码错误
#define NT_LOGIN_ERROR_CODE_SDK_NOT_AGREE_PROTOCOL @20 // 未同意联运隐私协议
#define NT_LOGIN_ERROR_CODE_NOT_REAL_NAME      @21 // 未实名账号
#define NT_LOGIN_ERROR_CODE_SDK_AAS_LIMIT      @22 // 防沉迷限制
#define NT_LOGIN_ERROR_CODE_SDK_QUICK_REPEAT_LOGIN @23 // 重复登录（上次登录未处理完成及回调）

/**
 *  @brief NT_NOTIFICATION_CLOSE_PAUSEVIEW  中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_ORDER              @"order"

/**
 *  @brief NT_NOTIFICATION_FINSIH_QUERY_FRIEND_LIST 中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_FRIEND_LIST        @"friend_list"
/**
 *  @brief NT_NOTIFICATION_FINSIH_QUERY_MY_ACCOUNT 中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_MY_ACCOUNT         @"my_account"


//////////////GAMECENTER//////////////////////>>>>>>>>>>
/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （排行榜）
 */
#define NT_NOTIFICATION_INFO_GC_RANK       @"gc_rank"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （默认排行榜）
 */
#define NT_NOTIFICATION_INFO_GC_DEFRANK       @"gc_defrank"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （设置默认排行榜）
 */
#define NT_NOTIFICATION_INFO_GC_SETDEFRANK       @"gc_setdefrank"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （上传比分）
 */
#define NT_NOTIFICATION_INFO_GC_UPDATERANK       @"gc_updaterank"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （获取比分排行）
 */
#define NT_NOTIFICATION_INFO_GC_SCORE      @"gc_score"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （报告成就）
 */
#define NT_NOTIFICATION_INFO_GC_REPORTACHIEVEMENT      @"gc_report_achievement"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （成就元数据）
 */
#define NT_NOTIFICATION_INFO_GC_ACHIEVEMENT      @"gc_achievement"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （开始挑战准备）
 */
#define NT_NOTIFICATION_INFO_GC_STARTCHALLENGE      @"gc_startchallenge"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （开始挑战准备）
 */
#define NT_NOTIFICATION_INFO_GC_CHALLENGES      @"gc_challenges"

/**
 *  @brief NT_NOTIFICATION_FINISH_GAMECENTER 中 userInfo 字段 （挑战完成）
 */
#define NT_NOTIFICATION_INFO_GC_ENDCHALLENGE      @"gc_endchallenge"
//////////////GAMECENTER//////////////////////<<<<<<<<<<<<<<


///////////////////////////////////////////////
/**
 *  @brief NT_NOTIFICATION_FINISH_GET_PRODUCT_INFO  中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_PRODUCT              @"product"

#define NT_NOTIFICATION_INFO_REBATE               @"rebate"
#define NT_NOTIFICATION_INFO_REDEEM               @"redeem"
//////////////////////////////////////////////


/**
 * @brief 用户取得授权的通知(如FB平台授权)
 */
#define NT_NOTIFICATION_SIGNTOPLATFORM                   @"NT_NOTIFICATION_SIGNTOPLATFORM"

///////////////////APPLOVIN///////////////////////////
/**
 * @brief 广告相关事件的通知
 */
#define NT_NOTIFICATION_FINISH_ADS         @"NT_NOTIFICATION_FINISH_ADS"

/**
 *  @brief NT_NOTIFICATION_FINISH_ADS 中 userInfo 字段 （广告加载情况）
 */
#define NT_NOTIFICATION_INFO_ADS_LOAD      @"ads_load"

/**
 *  @brief NT_NOTIFICATION_FINISH_ADS 中 userInfo 字段 （广告展示情况，包括是否单击等）
 */
#define NT_NOTIFICATION_INFO_ADS_DISPLAY      @"ads_display"

/**
 *  @brief NT_NOTIFICATION_FINISH_ADS 中 userInfo 字段 （广告视频情况）
 */
#define NT_NOTIFICATION_INFO_ADS_VIDEO_BEGIN      @"ads_video_begin"
#define NT_NOTIFICATION_INFO_ADS_VIDEO_END      @"ads_video_end"

#define NT_NOTIFICATION_GET_LOCATION_FINISHED   @"NT_NOTIFICATION_GET_LOCATION_FINISHED"
#define NT_NOTIFICATION_GET_NEARBY                @"NT_NOTIFICATION_GET_NEARBY"
#define NT_NOTIFICATION_GET_NEARBY_REQ_INFO       @"NT_NOTIFICATION_GET_NEARBY_REQ_INFO"


/**
 *  @brief NT_NOTIFICATION_PROTOCOL 用户协议的通知
 */
#define NT_NOTIFICATION_INFO_PROTOCOL              @"NT_NOTIFICATION_INFO_PROTOCOL"
/**
 *  @brief NT_NOTIFICATION_PROTOCOL 中 userInfo 字段
 */
#define NT_NOTIFICATION_INFO_PROTOCOL_STATE        @"protocol_state"
/**
 *  @brief 用户协议通知中的状态
 */
#define NT_NOTIFICATION_INFO_PROTOCOL_CONFIRM      @0   // 玩家点击”确定“
#define NT_NOTIFICATION_INFO_PROTOCOL_ACCEPT       @1   // 玩家点击“同意”
#define NT_NOTIFICATION_INFO_PROTOCOL_REJECT       @2   // 玩家点击“拒绝”，退出应用
#define NT_NOTIFICATION_INFO_PROTOCOL_READED       @3   // 已同意协议，不展示
#define NT_NOTIFICATION_INFO_PROTOCOL_NEED_QUERY   @4   // 用户同意的是多子协议样式，收到通知后需要调用agreedProtocols查询

#endif
