//
//  NtOrderInfo.h
//  NtUniSdk
//
//  Created by UniSDK on 14-5-23.
//  Copyright (c) 2014年 Game-NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

/// 订单支付状态
typedef NS_ENUM(NSInteger, NtOrderStatus)
{
    NT_OS_PREPARING = 0,                    ///< 订单准备中
    NT_OS_SDK_CHECKING = 1,                 ///< 订单sdk查询中
    NT_OS_SDK_CHECK_OK = 2,                 ///< sdk订单支付成功
    NT_OS_SDK_CHECK_ERR = 3,                ///< sdk订单支付失败
    NT_OS_GS_CHECKING = 4,                  ///< 订单游戏服查询中
    NT_OS_GS_CHECK_OK = 5,                  ///< 订单游戏服支付成功
    NT_OS_GS_CHECK_ERR = 6,                 ///< 订单游戏服支付失败
    NT_OS_WRONG_PRODUCT_ID = 7,             ///< 订单道具id错误
    NT_OS_SDK_INVALIDE_PRICE_LOCALE_ID = 8, ///< 订单支付货币有问题
    NT_OS_SDK_INVALID_CURRENCY = 9,         ///< 订单支付货币有问题(G4_LINE_兼容安卓)
    NT_OS_SDK_CHECK_RESTORE_OK = 10,        ///< sdk订单补单成功(兼容安卓)
    NT_OS_SDK_CHECK_CANCEL = 11,            ///< 支付取消(兼容安卓)
};

/// 商品类型 https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Products.html#//apple_ref/doc/uid/TP40008267-CH2-SW7
typedef NS_ENUM(NSInteger, NtProductType) {
    NtProductTypeConsumable = 0,
    NtProductTypeNonConsumable = 1,
    NtProductTypeAutoRenewable = 2,
    NtProductTypeNonRenewable = 3,
    NtProductTypePromoCode = 4, //兑换码
};

/// 订单支付阶段(GarenaSDK使用, 目前基本没渠道使用20201130)
enum NtOrderStage
{
    Nt_OnNetworkError = 0,                  ///< 网络异常
    Nt_OnIAPPayFail = 1,                    ///< 连接APPLE服务器失败
    Nt_OnIAPPayFinish = 2,                  ///< APPLE支付成功结束
    Nt_OnDistributeGoodsFinish = 3,         ///< 同步APPLE订单到平台服务器
    Nt_OnDistributeGoodsFailure = 4,        ///< 同步APPLE订单到平台服务器失败（需手动调用ntDistributeGoods同步）
    Nt_OnRestoreNonConsumableFinish = 5,    ///< 点卡消费结束（暂不适用）
    Nt_OnRestoreNonConsumableFail = 6,      ///< 点卡消费失败（暂不适用）
};

typedef NS_ENUM(NSInteger, NtOrderType) {
    NtOrderTypeNormal = 0,
    NtOrderTypeReCreateOrder = 1,
    NtOrderTypeQrCode = 4,
};

/// 订单支付失败的描述,对应的文本请不要更改，游戏可能会根据这些文本判断失败的原因
static NSString *const Nt_Another_order_is_checking = @"Another_order_is_checking";
static NSString *const Nt_order_is_remaining = @"Order_is_remaining"; // 同一product id还有其他订单在支付中
static NSString *const Nt_Can_not_make_IAP = @"Can_not_make_IAP";
static NSString *const Nt_Receipt_not_exist = @"Receipt_not_exist";
static NSString *const Nt_Illegal_currency = @"Illegal_currency";
static NSString *const Nt_Invalid_product_id = @"Invalid_product_id";
static NSString *const Nt_Empty_product = @"Empty_product"; // 废弃的字段
static NSString *const Nt_Product_id_nil = @"Product_id_nil";
static NSString *const Nt_OrderInfo_nil = @"OrderInfo_nil";
static NSString *const Nt_Product_id_not_match = @"Product_id_not_match";
static NSString *const Nt_SKPayment_transaction_failed = @"SKPayment_transaction_failed"; //这个是开头，后面带有苹果返回的失败原因描述
static NSString *const Nt_Query_product_from_jf_failed = @"Query_product_from_jf_failed";//从计费server获取商品信息失败
static NSString *const Nt_Invalid_uid = @"Invalid_uid"; //扫描二维码获取到的账号id不匹配
static NSString *const Nt_Invalid_platform = @"Invalid_platform"; //扫描二维码获取到的平台不匹配，不是ios
static NSString *const Nt_Invalid_data_id = @"Invalid_data_id"; //扫描二维码获取到的data_id为空
static NSString *const Nt_Get_orderinfo_from_jf_failed = @"Get_orderinfo_from_jf_failed";//根据索引从计费server获取订单信息失败
static NSString *const Nt_Get_orderinfo_from_ptb_failed = @"Get_orderinfo_from_ptb_failed";//根据索引从mpay获取订单信息失败(海外版扫码时索引的信息在mpay那边)
static NSString *const Nt_Create_order_id_failed = @"Create_order_id_failed";//从计费server创建订单号失败
static NSString *const Nt_One_time_goods_already_purchased = @"One_time_goods_already_purchased";//一次性礼包重复购买
static NSString *const Nt_Reject_order_privacy_agreement = @"Reject_order_privacy_agreement";//拒绝同意隐私协议

/**
 *  订单信息
 */
@interface NtOrderInfo : NSObject
/** 订单ID */
@property (nonatomic, copy)NSString *orderId;
/** sdk内部订单ID */
@property (nonatomic, copy)NSString *sdkOrderId;
/** 商品ID */
@property (nonatomic, copy)NSString *productId;
/** 商品名称 */
@property (nonatomic, copy)NSString *productName;
/** 商品当前价格 */
@property (nonatomic, assign)float productCurrentPrice;
/** 数量 */
@property (nonatomic, assign)int productCount;
/** 订单描述信息 */
@property (nonatomic, copy)NSString *orderDesc;
/** 订单状态 */
@property (nonatomic, assign)int orderStatus;
/** 订单错误信息 */
@property (nonatomic, copy)NSString *orderErrReason;
/** 收据凭证(小票) */
@property (nonatomic, copy)NSData *transactionReceipt;
/** 支付角色data信息 */
@property (nonatomic, strong)id<NSCoding> userData;
/** 角色id，用于applicationUserName */
@property (nonatomic, copy)NSString *userName;
/** 币种地区信息 */
@property (nonatomic, copy)NSString *userPriceLocaleId;
/** 计费扩展信息(跟Android统一增加这个变量) */
@property (nonatomic, copy)NSString *jfExtInfo;
/** 计费返回的订单状态码 */
@property (nonatomic, assign)int jfCode;
/** 计费返回的订单状态子码 */
@property (nonatomic, assign)int jfSubCode;
/** 扩展内容 */
@property (nonatomic, copy)NSString *extendJson;
/** 计费返回的提示信息 */
@property (nonatomic, copy)NSString *jfMessage;
/** 占位的，实际底层没用到 */
@property (nonatomic, copy)NSString *unisdkJfExtCid;
/** 防沉迷的说明 */
@property (nonatomic, copy)NSString *jfAasFfRule;
/** 防沉迷区间错误码aas_ff_code */
@property (nonatomic, assign)int jfAasFfCode;
/** 货币黑/白名单, 如：[@"CNY", @"USD"] */
@property (nonatomic, strong)NSArray<NSString *> *arrPriceLocaleId;
/** 订单失败的错误码 */
@property (nonatomic, copy)NSString *errCode;
/** 账号ID，表示订单是哪个用户账号充值 */
@property (nonatomic, copy)NSString *uid;
/** 服务器ID(扫码支付在创建订单的时候用到) */
@property (nonatomic, copy)NSString *serverId;
/** 计费用户ID(在扫码支付创建订单的时候用到) */
@property (nonatomic, copy)NSString *aid;
/** 订单购买的数据(netmarble渠道) */
@property (nonatomic, strong)NSDictionary *dictPurchase;
/** 验证订单返回的数据 */
@property (nonatomic, copy)NSString *response;
/** 交易ID(TransactionID) */
@property (nonatomic, copy)NSString *transactionIdentifier;
/** 订单所处的阶段CODE(GarenaSDK渠道) */
@property (nonatomic, assign)int orderStage;
/** 登录渠道ID */
@property (nonatomic, copy)NSString *loginChannelIdentifier;
/** 扩展信息(netmarble渠道) */
@property (nonatomic, copy)NSString *etc;
/** 商品币种(从苹果服务端获取) */
@property (nonatomic, copy)NSString *currencyForLog;
/** 商品价格(从苹果服务端获取) */
@property (nonatomic, copy)NSString *priceForLog;
/** 订单加密用的key(单机版即将废弃20201130) */
@property (nonatomic, copy)NSString *cipherKey;
/** 是否扫码支付订单 */
@property (nonatomic, )BOOL isQRCodeOrder;
/** 二维码中的dataID(扫码支付的订单特有) */
@property(nonatomic, strong)NSString *qrCodeDataId;
/** 商品类型 */
@property (nonatomic, assign)NtProductType productType;
/** 时间戳(调用checkorder的时间) */
@property (nonatomic, strong)NSNumber *timeStamp;
/** 计费Gas3的URL */
@property (nonatomic, strong)NSString *jfGas3Url;
/** linegame用户支付时的mid(line的用户id)，用于对账 */
@property (nonatomic, strong)NSString *lineGameMid;
/** 订单对应的bundleId */
@property (nonatomic, strong)NSString *bundleId;
/** 订单创建来源 */
@property (nonatomic, assign)NtOrderType orderType;
/** 计费创建订单extra字段 */
@property (nonatomic, copy) NSString *jfExtraJson;
/** 根据fullUserName生成的hash字段,传进applicationUserName中 */
@property (nonatomic, copy, nullable) NSString *fullUserNameHash;

/// 注册商品(Gas2)
/// @param pId 商品ID，如使用AppStore IAP，商品ID需要与appstoreconnect填写的ProductID一致
/// @param pName 商品名称
/// @param pPrice 商品价格
/// @param eRatio 虚拟货币兑换比率
+ (void)regProduct:(NSString *)pId Name:(NSString *)pName Price:(float)pPrice Ratio:(int)eRatio;

/// 注册商品(Gas3)
/// @param pId 商品ID，如使用AppStore IAP，商品ID需要与appstoreconnect上填写的ProductID一致
/// @param pName 商品名称
/// @param pPrice 商品价格
/// @param eRatio 虚拟货币兑换比率
/// @param bid 计费商品ID
+ (void)regProduct:(NSString *)pId Name:(NSString *)pName Price:(float)pPrice Ratio:(int)eRatio Bid:(NSString *)bid;

/// 查询是否存在某种商品
/// @param pId 商品ID
+ (BOOL)hasProduct:(NSString*)pId;

/// 根据游戏内商品id（bid/goodsId）索引到苹果的商品id（productId）。私有接口，外部不要调用
/// @param bid 计费商品ID
+ (NSString *)getProductIdFromBid:(NSString *)bid;

/// 设置商品的类型，默认为0，即是消耗类
/// @param pid 商品id
/// @param type 商品类型
+ (void)setProduct:(NSString *)pid asType:(NtProductType)type;

/// 获取商品类型
/// @param pid 商品id
+ (NtProductType)getProductType:(NSString *)pid;

/// 删除自动订阅队列中非自动订阅的商品类型(自动订阅商品类型队列中有非自动订阅商品是因为在计费后台配错商品类型)
/// @param productId 商品productid
+ (void)removeProductIdFromSubscriptionList:(NSString *)productId;

/// 初始化
/// @param pId 商品ID
- (NtOrderInfo *)initWithProductId:(NSString*)pId;

/// 初始化
/// @param info 订单对象
- (NtOrderInfo *)initWithNtOrderInfo:(NtOrderInfo*)info;

/// 初始化
/// @param jsonString JSON 字符串
- (NtOrderInfo *)initWithJsonString:(NSString *)jsonString;

/// 将订单信息转为 JSON 字符串
- (NSString *)toJsonString;

/// 获取订单ID
- (NSString *)getOrderId;

/// 获取SDK订单ID
- (NSString *)getSdkOrderId;

/// 渠道商品ID
- (NSString *)getProductId;

/// 计费商品ID
- (NSString *)getBid;

/// 商品的名称
- (NSString *)getProductName;

/// 商品当前的单价
- (float)getProductCurrentPrice;

/// 商品的数量
- (int)getCount;

/// 设置订单中购买商品的数量
/// @param count 数量
- (void)setCount:(int)count;

/// 获取订单描述信息
- (NSString *)getOrderDesc;

/// 获取订单中购买商品的信息
- (id)getProductInfo;

/// 获取订单中购买商品的原价
- (float)getProductPrice;

/// 购买商品的兑换比率
- (int)getProductExchangeRatio;

/// 订单支付状态
- (int)getOrderStatus;

/// 获取订单错误描述
- (NSString *)getOrderErrReason;

/// 已注册的商品列表
// + (NSMutableDictionary*)getProductList; // 接口废弃，线程不安全

/// 打印商品列表
+ (void)printProductList;

/// 清空商品列表
+ (void)cleanProductList;

/// 获取订单的TransactionReceipt，仅用于App Store
- (NSData*)getTransactionReceipt;

/// 获取订单对应的userData
- (id)getUserData;

/// 玩家付款时的货币币种（玩家支付时会有玩家appstore账号使用的币种）
- (NSString *)getUserPriceLocaleId;

/// 用户帐号ID
- (NSString *)getUid;

/// 用户角色ID
- (NSString *)getUserName;

/// 错误码
- (NSString *)getErrCode;

/// 服务器ID
- (NSString *)getServerId;

/// 计费角色ID
- (NSString *)getAid;

/// 额外信息
- (NSString *)getEtc;

/// 计费扩展字段
- (NSString *)getJfExtInfo;

/// 价格
- (NSString *)getPriceForLog;

/// 币种
- (NSString *)getCurrencyForLog;

/// 二维码索引DataID
- (NSString *)getQRCodeDataId;

/// 时间戳
- (NSNumber *)getTimeStamp;

/// 计费Gas3 URL
- (NSString *)getJfGas3Url;

/// 计费返回码
- (int)getJfCode;

/// 计费返回子码
- (int)getJfSubCode;

/// 扩展json
- (NSString *)getExtendJson;

/// 占位字段
- (NSString *)getUnisdkJfExtCid;

/// 获取付费渠道,游戏开发人员不需要关注此接口。如需获取订单使用的支付渠道，请使用getOrderChannel()接口
- (NSString *)getFFChannel;

/// 获取订单使用的支付渠道
- (NSString *)getOrderChannel;

/// 获取订单所处的支付阶段(GarenaSDK使用)
- (int)getOrderStage;

/// 获取产品传进来的extra参数
- (NSString *)getJfExtraJson;

@end



