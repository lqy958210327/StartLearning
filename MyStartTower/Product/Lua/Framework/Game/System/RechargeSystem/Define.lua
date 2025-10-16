


---@class RechargeDefine
RechargeDefine = {}

local _serverOrderStatus = {
    SdkRequest = "SdkRequest",--请求SDK支付（订单信息客户端记录当前订单信息）
    SdkLocking = "SdkLocking",--等待SDK支付
    SdkTimeout = "SdkTimeout",--SDK支付超时
    SdkFailure = "SdkFailure",--SDK支付失败（订单信息客户端清空当前订单）
    SdkSuccess = "SdkSuccess",--SDK支付成功
    PaySuccess = "PaySuccess",--后端回调成功
    RewardItem = "RewardItem",--
    RewardMail = "RewardMail",
}

RechargeDefine.ServerOrderStatus = _serverOrderStatus