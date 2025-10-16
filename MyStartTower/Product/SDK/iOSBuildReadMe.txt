pb120@163.com
OC123451wan

苹果开发者账号

App ID Prefix
3A84R48QH6 (Team ID)

Bundle ID
com.xglmtest.oc


远程  todesk
153 139 730
mac12345

添加sdk库  NetEaseGlobal
添加客服中心的sdk库  NgGMBridge  GMBridge5.4.0


两个TARGET设置 Build Settings other linker 添加 -ObjC

TARGET Unity-iPhone Build Phases  Copy Bundle Resources 添加sdk的bundle文件





fb和google需要的系统库
Accelerate.framework
AdSupport.framework
libc++.1.tbd
StoreKit.framework
AddressBook.framework
SafariServices.framework
SystemConfiguration.framework
WebKit.framework

删除定位库
CoreLocation.framework



覆盖info.plist



netease_global.data

{
"APPID":"384",
"APP_CHANNEL":"app_store",
"JF_GAMEID":"ma155naxx2gb",
"DEBUG_LOG":"1",
"DEBUG_MODE":"1",
"UNISDK_LOG_STATUS":"1",
"JF_LOG_KEY":"4ZYOAFT87p31kQurnVJsfe7lgzx2sHL4",
"UNISDK_JF_GAS3":1,
"UNISDK_JF_GAS3_WEB":1,
"UNISDK_JF_GAS3_URL":"https://mgbsdknaeast.matrix.easebar.com/ma155naxx2gb/sdk/",
"ENABLE_EXLOGIN_APPLE":"1",
"ENABLE_EXLOGIN_GOOGLE":"1",
"GOOGLE_CLIENT_ID":"602746732308-8atjk8jc0no685e111p0moh7rd2qr9av.apps.googleusercontent.com"
}