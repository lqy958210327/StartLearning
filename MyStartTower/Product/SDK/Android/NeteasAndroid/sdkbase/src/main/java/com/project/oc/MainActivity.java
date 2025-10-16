package com.project.oc;

import static com.project.oc.Utils.GetContext;
import static com.project.oc.Utils.log;
import static com.project.oc.Utils.unitySendMessage;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.ClipData;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.os.Vibrator;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.KeyEvent;

import com.netease.androidcrashhandler.javacrash.JavaCrashCallBack;
import com.netease.download.listener.DownloadListener;
import com.netease.environment.EnvManager;
import com.netease.ntunisdk.base.AccountInfo;
import com.netease.ntunisdk.base.ConstProp;
import com.netease.ntunisdk.base.OnContinueListener;
import com.netease.ntunisdk.base.OnExitListener;
import com.netease.ntunisdk.base.OnExtendFuncListener;
import com.netease.ntunisdk.base.OnFinishInitListener;
import com.netease.ntunisdk.base.OnLoginDoneListener;
import com.netease.ntunisdk.base.OnLogoutDoneListener;
import com.netease.ntunisdk.base.OnOrderCheckListener;
import com.netease.ntunisdk.base.OnProtocolFinishListener;
import com.netease.ntunisdk.base.OnQuerySkuDetailsListener;
import com.netease.ntunisdk.base.OnShareListener;
import com.netease.ntunisdk.base.OnWebViewListener;
import com.netease.ntunisdk.base.OrderInfo;
import com.netease.ntunisdk.base.QueryFriendListener;
import com.netease.ntunisdk.base.QueryRankListener;
import com.netease.ntunisdk.base.SdkMgr;
import com.netease.androidcrashhandler.*;
import com.netease.ntunisdk.base.SkuDetailsInfo;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class MainActivity extends UnityPlayerActivity implements OnLoginDoneListener, OnLogoutDoneListener, OnOrderCheckListener
        , OnContinueListener, OnExitListener, QueryFriendListener, QueryRankListener, OnShareListener, OnExtendFuncListener
        , OnProtocolFinishListener, OnWebViewListener, OnQuerySkuDetailsListener{

    private static boolean mIsInitUnityPlayer = false;
    static boolean mIsGuest = false;

    public static boolean IsGuest(){ return mIsGuest; }
    public static boolean IsInitUnityPlayer(){ return mIsInitUnityPlayer; }
    SDKBase sdkBase;

    long startTime = 0;

    public SDKBase getSDK()
    {
        Log.d(Defines.SDK_LOG_TAG, "MainActivity : getSDK");
        sdkBase = PluginManager.getInstance().getSDK();
        return sdkBase;
    }

    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mIsInitUnityPlayer = true;
        UniSDKInit(savedInstanceState);


        Log.d(Defines.SDK_LOG_TAG, "MainActivity : onCreate");
        PluginManager.getInstance().onCreate(this, savedInstanceState);
    }

    @Override
    protected void onStart() {
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onStart");
        super.onStart();
        PluginManager.getInstance().onStart();
        SdkMgr.getInst().handleOnStart();

        try {
            // app启动
            JSONObject jsonData = new JSONObject();
            jsonData.put("ta_app_start", "");
            jsonData.put("app_start_time", UnisdkLogInfo.GetZoneDateTime());
            Utils.Drpf("ta_app_start", jsonData.toString());

            startTime = Calendar.getInstance().getTimeInMillis();
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void onPause() {
        super.onPause();
        //调用Activity生命周期处理方法
        SdkMgr.getInst().handleOnPause();
    }

    @Override
    public void onStop() {
        super.onStop();
        //调用Activity生命周期处理方法
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onStop");
        PluginManager.getInstance().onStop();
        SdkMgr.getInst().handleOnStop();
    }

    @Override
    public void onResume() {
        super.onResume();
        //调用Activity生命周期处理方法
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onResume");
        PluginManager.getInstance().onResume();
        SdkMgr.getInst().handleOnResume();
    }

    @Override
    public void onRestart() {
        super.onRestart();
        //调用Activity生命周期处理方法
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onRestart");
        PluginManager.getInstance().onRestart();
        SdkMgr.getInst().handleOnRestart();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        //调用Activity生命周期处理方法
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onActivityResult");
        SdkMgr.getInst().handleOnActivityResult(requestCode, resultCode, data);
        PluginManager.getInstance().onActivityResult(requestCode, resultCode, data);
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        //调用Activity生命周期处理方法
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onWindowFocusChanged");
        SdkMgr.getInst().handleOnWindowFocusChanged(hasFocus);
        PluginManager.getInstance().onWindowFocusChanged(hasFocus);
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        //调用Activity生命周期处理方法
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onConfigurationChanged");
        SdkMgr.getInst().handleOnConfigurationChanged(newConfig);
        PluginManager.getInstance().onConfigurationChanged(newConfig);
    }

    @Override
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        //调用Activity生命周期处理方法
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onNewIntent");
        SdkMgr.getInst().handleOnNewIntent(intent);
        PluginManager.getInstance().onNewIntent(intent);
    }

    @Override
    public void onSaveInstanceState(Bundle state) {
        super.onSaveInstanceState(state);
        //调用Activity生命周期处理方法
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onSaveInstanceState");
        SdkMgr.getInst().handleOnSaveInstanceState(state);
        PluginManager.getInstance().onSaveInstanceState(state);
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onBackPressed");
        SdkMgr.getInst().handleOnBackPressed();
        PluginManager.getInstance().onBackPressed();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onRequestPermissionsResult");
        SdkMgr.getInst().handleOnRequestPermissionsResult(requestCode, permissions, grantResults);
        PluginManager.getInstance().onRequestPermissionsResult(requestCode, permissions, grantResults);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        //清理操作
        Log.d(Defines.SDK_LOG_TAG, "MainActivity onDestroy");
        SdkMgr.destroyInst();
        PluginManager.getInstance().onDestroy();
        //进程退出
        System.exit(0);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event)
    {
        if (keyCode == KeyEvent.KEYCODE_BACK)
        {
            Utils.log("onKeyDown keyCode= " + keyCode);
            Utils.log("MODE_EXIT_VIEW = " + SdkMgr.getInst().hasFeature(ConstProp.MODE_EXIT_VIEW));
            if(SdkMgr.getInst().hasFeature(ConstProp.MODE_EXIT_VIEW)) {
                //sdk有退出页
                //弹出sdk的退出页。玩家确认退出后，会自动回调到OnExitListener.exitApp()
                SdkMgr.getInst().ntOpenExitView();
            } else {
                Utils.log("onKeyDown AlertDialog");

                // 创建构建器
                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                AlertDialog dialog = null;
                // 设置参数
                builder.setTitle("System Prompt").setMessage("Are you sure you want to quit the game?").setPositiveButton("Sure", new DialogInterface.OnClickListener() {// 积极

                    @Override
                    public void onClick(DialogInterface dialog,int which) {
                        exitApp();
                    }
                }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {// 消极

                    @Override
                    public void onClick(DialogInterface dialog,int which) {
                        dialog.dismiss();
                    }
                });

                dialog = builder.create();
                dialog.show();
            }
        }

        return false;
    }

    // ----------------------------------------implements method start -------------------
    @Override
    public void loginDone(int code) {
        if(code == OnLoginDoneListener.OK)
        {

            //渠道账号登录成功后的游戏逻辑
            sdkBase.loginSuccess();
            log("login loginDone success");
            //注意，除了“登录成功”之外，如下两种情况也会回调到这里：
            //1. 玩家成功切换账号
            //2. 游客成功绑定账号，且uid有变化

            Utils.isDisableLogin = false;

            String minorStatus = SdkMgr.getInst().getPropStr("MINOR_STATUS");
            if (minorStatus.equals("101"))
            {
                // 拒绝服务 弹出退出游戏确认框
                try
                {
                    JSONObject json = new JSONObject();
                    json.put("login_out_code", EventCenter.EVENT_LOGOUT_NIMOR);
                    json.put("eventType", EventCenter.EVENT_LOGOUT);
                    Utils.unitySendMessage(json.toString());

                    Utils.isDisableLogin = true;
                }
                catch (JSONException e)
                {
                    e.printStackTrace();
                }
                return;
            }

            String sdkUid = SdkMgr.getInst().getPropStr(ConstProp.UID);
            String session = SdkMgr.getInst().getPropStr(ConstProp.SESSION);
            //获取计费sauth的json参数
            String sauthJson = SdkMgr.getInst().getPropStr(ConstProp.SAUTH_JSON);
            log("sauthJson= " + sauthJson);

            //重置一下，切换账号的时候还是原先的状态
            mIsGuest = false;
            //可以获取当前是否游客登录（仅网易官网渠道有效）
            log("getAuthTypeName ="+ SdkMgr.getInst().getAuthTypeName());
            if(SdkMgr.getInst().getAuthTypeName().equals("guest")) {
                //当前是游客登录
                mIsGuest = true;
            }

            if(mIsGuest)
            {
                System.out.println("是游客");
            }
            else
            {
                System.out.println("不是是游客=" + SdkMgr.getInst().getAuthTypeName());
            }

            if(sdkUid != null && !"".equals(sdkUid))
            {
                Utils.SetStrAccountId(sdkUid);
            }

            // 开始SDK登录成功日志
            try
            {
                System.out.println("SDK登录成功日志");
                JSONObject jsonData = new JSONObject();
                jsonData.put("account_id",Utils.GetAccountId());
                jsonData.put("app_ver", GetAppVersion());
                jsonData.put("auth_type_name",SdkMgr.getInst().getAuthTypeName());
                jsonData.put("sdk_login_status",1);
                jsonData.put("error_code",code);
                Utils.Drpf("SDKLogin", jsonData.toString());


                // 登录成功广告埋点
                JSONObject adJson = new JSONObject();
                //adJson.put("login", "");
                Utils.TrackCustomEvent("login", adJson.toString());//sdk_login改名为login

                //新增ne_login埋点
                JSONObject adJson2 = new JSONObject();
                //adJson2.put("ne_login", "");
                adJson2.put("app_instance_id", Utils.appInstanceId);
                Utils.TrackCustomEvent("ne_login", adJson2.toString());

            }
            catch (Exception e)
            {
                e.printStackTrace();
            }

            String uid = Utils.GetUid();
            Utils.log("loginDone sdkUid = " + sdkUid);
            Utils.log("loginDone accountId = " + uid);
            if(uid != null && (!"".equals(uid)) && (!uid.equals(sdkUid)))
            {
                Utils.SetUid(sdkUid);
                // 如果已登录角色的uid与OnLoginDoneListener.OK时取出的uid不同，则需要将原角色踢下线，然后继续新uid的登录流程。
                try
                {
                    SendIdentification();
                    JSONObject json = new JSONObject(sauthJson);
                    json.put("eventType", EventCenter.EVENT_SWITCHACCOUNT);
                    json.put("sdkJson",UnisdkLogInfo.GetDrpfBaseJson());  // 给服务端传的基本日志信息
                    Utils.unitySendMessage(json.toString());
                }
                catch (JSONException e)
                {
                    e.printStackTrace();
                }

                return;
            }

            //渠道账号登录成功后的游戏逻辑
            try
            {
                SendIdentification();
                JSONObject json = new JSONObject(sauthJson);
                json.put("eventType", EventCenter.EVENT_LOGIN_SUCCESS);
                json.put("sdkJson",UnisdkLogInfo.GetDrpfBaseJson());  // 给服务端传的基本日志信息
                Utils.unitySendMessage(json.toString());
            }
            catch (JSONException e)
            {
                e.printStackTrace();
            }
        }
        else
        {
            sdkBase.loginFailed();
            log("login loginDone failed && code ="+code);

            // 开始SDK登录失败日志
            try
            {
                JSONObject jsonData = new JSONObject();
                jsonData.put("account_id",Utils.GetAccountId());
                jsonData.put("auth_type_name",SdkMgr.getInst().getAuthTypeName());
                jsonData.put("app_ver", GetAppVersion());
                jsonData.put("sdk_login_status",-1);
                jsonData.put("error_code",code);

                Utils.Drpf("SDKLogin", jsonData.toString());
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }

            if(code == OnLoginDoneListener.NEED_RELOGIN) {
                //需要重新登录

                //请特别注意这种情况，NEED_RELOGIN代表渠道SDK认为玩家已经意外登出，此时需要把玩家踢下线，并重新登录
            } else if(code == OnLoginDoneListener.CANCEL) {

            } else if(code == OnLoginDoneListener.WRONG_PASSWD) {
                //用户名或者密码错误"
            } else if(code == OnLoginDoneListener.NET_UNAVAILABLE) {
                //网络不可用
            } else if(code == OnLoginDoneListener.SDK_SERV_ERR) {
                //sdk服务器错误导致无法登录
            } else if(code == OnLoginDoneListener.NET_TIME_OUT) {
                //网络超时
            } else if(code == OnLoginDoneListener.SDK_NOT_INIT) {
                //sdk还未初始化
            }else{
                // 其他登录失败的情况
            }

            try
            {
                JSONObject json = new JSONObject();
                json.put("login_out_code", code);
                json.put("eventType", EventCenter.EVENT_LOGOUT);
                Utils.unitySendMessage(json.toString());
            }
            catch (JSONException e)
            {
                e.printStackTrace();
            }
        }
    }

    //发送账号认证日志
    private void SendIdentification()
    {
        try
        {
            String uid = Utils.GetUid();
            NTCrashHunterKit.sharedKit().setParam(Const.ParamKey.UID, uid);
            System.out.println("设置NTCrashHunterKit的uid");

            System.out.println("账号认证日志");
            JSONObject jsonData = new JSONObject();
            jsonData.put("app_ver", GetAppVersion());
            jsonData.put("account_id",Utils.GetAccountId());
            jsonData.put("reach_login_time", UnisdkLogInfo.GetActiveTime());
            Utils.Drpf("Identification", jsonData.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    @Override
    public void logoutDone(int code) {
        if(code == OnLogoutDoneListener.OK) {
            //登出成功
            sdkBase.logoutSuccess();
            log("logout logoutDone success");
            //清理账号相关数据
            //让游戏回到登陆界面
            System.out.println("登出游戏成功,设置LOGIN_TYPE为0,调起渠道选择界面");
            SdkMgr.getInst().setPropInt(ConstProp.LOGIN_TYPE, 0);
        }
        else
        {
            sdkBase.logoutFailed();
            log("logout logoutDone failed && code =" + code);
            if(code == OnLogoutDoneListener.NEED_RELOGIN) {
                //由于token过期导致登录失效,需要游戏重新登录
                //请特别注意这种情况，NEED_RELOGIN代表渠道SDK认为玩家是意外登出，此时需要确保把玩家踢下线，并重新登录

            } else if (code == OnLogoutDoneListener.FAILED) {
                //登出失败
            } else if (code == OnLogoutDoneListener.NOLOGIN) {
                //玩家尚未登录
            } else {
                //登出失败
            }
        }

        try
        {
            JSONObject json = new JSONObject();
            json.put("logout_out_code", code);
            json.put("eventType", EventCenter.EVENT_LOGOUT);
            Utils.unitySendMessage(json.toString());
        }
        catch (JSONException e)
        {
            e.printStackTrace();
        }
    }

    public static String getPayChannel()
    {
        String payChannel = SdkMgr.getInst().getPayChannelByPid("com.xgjoy.oc.6");
        Utils.log("GetPayChannel payChannel = " + payChannel);
        return payChannel;
    }

    //获取产品列表
    public static void getProductList(String idContent)
    {
        System.out.println("getProductList=============" + idContent);
        String[] idArr = idContent.split(";");
        //渠道是否包含该功能
        if (SdkMgr.getInst().hasFeature(ConstProp.MODE_HAS_QUERYSKUDETAILS)) {
            System.out.println("getProductList=============渠道包含该功能");
            //获取计费点详细信息，itemType随意，skuList是google play后台配置的商品id集合
            List<String> skuList = new ArrayList<String>();
            for (int i = 0; i < idArr.length; i++) {
                skuList.add(idArr[i]);
            }
            SdkMgr.getInst().ntQuerySkuDetails("inapp", skuList);
        }
        else
        {
            System.out.println("getProductList=============渠道不包含该功能");
        }
    }

    @Override
    public void querySkuDetailsFinished(List<SkuDetailsInfo> list)
    {
        try
        {
            JSONObject json = new JSONObject();
            String productInfo = "";
            if (list != null && list.size() > 0) {
                for(int i = 0; i < list.size(); ++i) {
                    SkuDetailsInfo info = (SkuDetailsInfo)list.get(i);
                    if (info != null) {
                        productInfo += info.getProductId() + ";" + info.getPrice() + ";" + info.getPriceCurrencyCode();
                    }
                    if(i != list.size() - 1)
                    {
                        productInfo += "#";
                    }
                }
            }
            json.put("product_info", productInfo);
            json.put("pay_channel",getPayChannel());
            json.put("eventType", EventCenter.EVENT_PRODUCT_LIST);
            Utils.unitySendMessage(json.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    @Override
    public void orderCheckDone(OrderInfo orderInfo) {
//        0 订单准备中
//        1 订单sdk查询中
//        2 sdk订单支付成功
//        3 sdk订单支付失败
//        4 订单游戏服查询中,没有用到，可以忽略
//        5 订单游戏服支付成功,没有用到，可以忽略
//        6 订单游戏服支付失败,没有用到，可以忽略
//        7 订单道具id错误
//        8 订单号错误
//        9 订单支付货币有问题
//        10 sdk订单补单成功
//        11 支付取消
        try {
            JSONObject json = new JSONObject();
            json.put("eventType", EventCenter.EVENT_CHECK_ORDER_RESULT);
            json.put("orderStatus", orderInfo.getOrderStatus());
            json.put("jfCode", orderInfo.getJfCode());
            json.put("jfSubCode", orderInfo.getJfSubCode());
            json.put("jfMessage", orderInfo.getJfMessage());
            json.put("payChannel", orderInfo.getPayChannel());
            json.put("currency", orderInfo.getOrderCurrency());
            json.put("price", orderInfo.getProductPrice());

            Utils.unitySendMessage(json.toString());
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void orderConsumeDone(OrderInfo orderInfo) {

    }

    @Override
    public void continueGame() {

    }

    @Override
    public void exitApp() {
        try {
            // app关闭
            long onlineTime = Calendar.getInstance().getTimeInMillis() - startTime;
            JSONObject jsonData = new JSONObject();
            jsonData.put("ta_app_end", "");
            jsonData.put("#duration", onlineTime);
            Utils.Drpf("ta_app_end", jsonData.toString());
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }

        Utils.log("MainActivity exitApp");

        //清理操作
        SdkMgr.getInst().exit();
        //销毁Activity
        finish();
    }

    @Override
    public void onOpenExitViewFailed() {
        Utils.log("MainActivity onOpenExitViewFailed");
        //1. 直接调用exitApp()接口，退出游戏
        exitApp();

        //2. 如果游戏策划需要自己的退出确认框，也可以弹出游戏自己的退出页，玩家点确定后再调用exitApp()
    }

    @Override
    public void onQueryFriendListFinished(List<AccountInfo> list) {

    }

    @Override
    public void onQueryAvailablesInviteesFinished(List<AccountInfo> list) {

    }

    @Override
    public void onQueryMyAccountFinished(AccountInfo accountInfo) {

    }

    @Override
    public void onApplyFriendFinished(boolean b) {

    }

    @Override
    public void onIsDarenUpdated(boolean b) {

    }

    @Override
    public void onQueryFriendListInGameFinished(List<AccountInfo> list) {

    }

    @Override
    public void onInviteFriendListFinished(List<String> list) {

    }

    @Override
    public void onInviterListFinished(List<AccountInfo> list) {

    }

    @Override
    public void onQueryRankFinished(List<AccountInfo> list) {

    }

    @Override
    public void onUpdateRankFinished(boolean b) {

    }

    @Override
    public void onUpdateAchievement(boolean b) {

    }

    @Override
    public void onShareFinished(boolean b) {

    }

    @Override
    public void onExtendFuncCall(String s) {
        Utils.log("onExtendFuncCall =" + s);
        System.out.println("onExtendFuncCall ==========" + s);
        try {
            JSONObject jsonData = new JSONObject(s);
            String methodId = jsonData.getString("methodId");
            if ("genToken".equals(methodId))
            {
                // // 请求 服务端去sdk服务端拿数据，，后续重新设置给sdk
                JSONObject json = new JSONObject();
                json.put("eventType", EventCenter.EVENT_REQTOKEN_CUSTOMERSERVICE);
                json.put("game_ip", UnisdkLogInfo.GetIp(Utils.GetContext()));
                json.put("os", UnisdkLogInfo.GetOsName());
                json.put("udid", UnisdkLogInfo.GetUdid());
                json.put("uid", Utils.GetAccountId());
                Utils.unitySendMessage(json.toString());
            }
            else if("shouldAutoLogin".equals(methodId))
            {
                boolean result = jsonData.getBoolean("result");
                if(result)
                {
                    System.out.println("结果为true可以自动登录==========");
                    SdkMgr.getInst().setPropInt(ConstProp.LOGIN_TYPE, 1);
                }
                else
                {
                    System.out.println("结果为false需要游客登录==========");
                    SdkMgr.getInst().setPropStr("AUTH_CHANNEL","guest");
                    SdkMgr.getInst().setPropInt(ConstProp.LOGIN_TYPE, 2);
                }
                Utils.LoginDrpf("auto_login_result");
                //这里会到c#调用login--->ntLogin
                JSONObject json = new JSONObject();
                json.put("eventType", EventCenter.EVENT_INIT_FINISH);
                Utils.unitySendMessage(json.toString());
            }
            else if("NtCloseWebView".equals(methodId))
            {
                String result = jsonData.getString("result");
                //关闭webview
                JSONObject json = new JSONObject();
                json.put("eventType", EventCenter.EVENT_CLOSE_WEBVIEW);
                json.put("result", result);
                Utils.unitySendMessage(json.toString());
            }
            else if("getAppInstanceId".equals(methodId))
            {
                Boolean suc = jsonData.getBoolean("suc");
                String result = jsonData.getString("result");
                Utils.appInstanceId = "";
                if(suc)
                {
                    Utils.appInstanceId = result;
                    System.out.println("getAppInstanceId成功==========" + Utils.appInstanceId);
                }
                else
                {
                    System.out.println("getAppInstanceId失败==========");
                }
            }
            else if("hasPackageInstalled".equals(methodId))
            {
                Boolean result = jsonData.getBoolean("result");
                String appId = jsonData.getString("appId");
                System.out.println("hasPackageInstalled-----------------" + result+"-----------------"+appId);
                //通知游戏打开app还是去下载
                JSONObject json = new JSONObject();
                json.put("eventType", EventCenter.EVENT_TO_APP);
                json.put("result", result ? "1" : "0");
                json.put("appId", appId);
                Utils.unitySendMessage(json.toString());
            }
            //begin灯塔相关，eventType为一个，有特殊参数单独处理
            else if("pharosOnPharosServer".equals(methodId))
            {
                jsonData.put("eventType",EventCenter.EVENT_PHAROS);
                Utils.unitySendMessage(jsonData.toString());
            }
            else if("pharosnetlags".equals(methodId))
            {
                jsonData.put("eventType",EventCenter.EVENT_PHAROS);
                Utils.unitySendMessage(jsonData.toString());
            }
            else if("pharosnetlagscancel".equals(methodId))
            {
                jsonData.put("eventType",EventCenter.EVENT_PHAROS);
                Utils.unitySendMessage(jsonData.toString());
            }
            else if("pharosstartqos".equals(methodId))
            {
                jsonData.put("eventType",EventCenter.EVENT_PHAROS);
                Utils.unitySendMessage(jsonData.toString());
            }
            else if("pharosstopqos".equals(methodId))
            {
                jsonData.put("eventType",EventCenter.EVENT_PHAROS);
                Utils.unitySendMessage(jsonData.toString());
            }
            //end灯塔相关

        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    // 调查问卷
    @Override
    public void OnWebViewNativeCall(String action, String data) {
        log("OnWebViewNativeCall, action:" + action + ", data: " + data);
        log("action为字符串，例如：close(关闭问卷), finish(答完问卷)等，");
        try
        {
            JSONObject json = new JSONObject();
            json.put("eventType", EventCenter.EVENT_WEBVIEW_NATIVECALL);
            json.put("action", action);
            json.put("webViewData", data);
            Utils.unitySendMessage(json.toString());
        }
        catch(JSONException e)
        {
            e.printStackTrace();
        }

    }

    @Override
    public void onProtocolFinish(int code) {
        /*
         用户协议通知中的状态
        public static final int CONFIRM = 0; // 确定
        public static final int ACCEPT = 1; // 接受
        public static final int REJECT = 2; // 拒绝
        public static final int NOT_NEED_SHOW = 3; // 无需显示

         */

        Utils.log("onProtocolFinish = " + code);
        switch (code)
        {
            case 0:
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
        }

        try
        {
            JSONObject json = new JSONObject();
            json.put("eventType", EventCenter.EVENT_PROTOCOL_FINISH);
            json.put("code",code);
            json.put("udid",UnisdkLogInfo.GetUdid());

            String appChannel = SdkMgr.getInst().getAppChannel();
            String var13 = SdkMgr.getInst().getSDKVersion(appChannel);

            json.put("sdk_version",var13);

            String aimInfo = SdkMgr.getInst().getPropStr(ConstProp.JF_AIM_INFO);
            JSONObject aimJson = new JSONObject(aimInfo);
            json.put("aim_info",aimJson);
            Utils.unitySendMessage(json.toString());
        }
        catch (JSONException e)
        {
            e.printStackTrace();
        }
    }

    // ----------------------------------------implements method end -------------------

    /**
     * 统一一个静态接口，逻辑放到lua层
     * 有些参数在lua层拿不到需要判断特殊处理
     * @param json
     */
    public static void NtExtendFunc(String json)
    {
        try
        {
            Utils.log("NtExtendFunc json = " + json);
            JSONObject data = new JSONObject(json);
            SdkMgr.getInst().ntExtendFunc(data.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

   //手机震动
    public static void setVibrator(long time)
    {
        Vibrator vibrator = (Vibrator)GetContext().getSystemService(VIBRATOR_SERVICE);
        if(time > 0){
            vibrator.vibrate(time);
        }
        else {
            vibrator.cancel();
        }
    }

    //是否禁止登录
    public static boolean getIsDisableLogin()
    {
        return Utils.isDisableLogin;
    }

    public static String getAppInstanceId()
    {
        return Utils.appInstanceId;
    }

    public static void copyTextToClipboard(String text)
    {
        Utils.log("copyTextToClipboard = " + text);
        ClipboardManager clipboard = (ClipboardManager) GetContext().getSystemService(Context.CLIPBOARD_SERVICE);
        ClipData clip = ClipData.newPlainText("label", text);
        clipboard.setPrimaryClip(clip);
    }

    public static String getAccountType()
    {
        return SdkMgr.getInst().getAuthTypeName();
    }

    public static String GetPlayerDrpfJson()
    {
        return UnisdkLogInfo.GetPlayerDrpfJson(Utils.GetContext());
    }

    public static void setUnisdkJfGas3Url(String url)
    {
        Utils.log("setUnisdkJfGas3Url = " + url);
        SdkMgr.getInst().setPropStr(ConstProp.UNISDK_JF_GAS3_URL, url);
    }

    public static void Drpf(String operation, String json)
    {
        try
        {
            Utils.Drpf(operation, json);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }

    void UniSDKInit(Bundle savedInstanceState)
    {
        Utils.SetLoginContext(this);
        //初始化SdkMgr
        SdkMgr.init(this);

        // Orbit下载器
        SdkMgr.getDLInst().setContext(this);
        SdkMgr.getDLInst().setDownloadCallback(orbitDownLoad);

        //注册游戏引擎类型（非Cocos/U3D/NeoX的游戏，暂时设置为Cocos即可）
        SdkMgr.getInst().setPropInt(ConstProp.GAME_ENGINE, ConstProp.ENGINE_UNITY3D);

        //注册回调，详见“Android渠道SDK接入指引-调用线程说明”
        //****************************
        // 回调到安卓UI主线程
        SdkMgr.getInst().setLoginListener(MainActivity.this, ConstProp.LISTENER_CB_UI);
        SdkMgr.getInst().setLogoutListener(MainActivity.this, ConstProp.LISTENER_CB_UI); //注册登出回调监听
        SdkMgr.getInst().setOrderListener(MainActivity.this, ConstProp.LISTENER_CB_UI); //注册支付回调监听
        SdkMgr.getInst().setContinueListener(MainActivity.this, ConstProp.LISTENER_CB_UI); //注册从暂停页返回时的监听回调
        SdkMgr.getInst().setExitListener(MainActivity.this, ConstProp.LISTENER_CB_UI); //注册从退出页确认退出后的监听回调
        SdkMgr.getInst().setQueryFriendListener(MainActivity.this, ConstProp.LISTENER_CB_UI); //注册好友相关回调监听
        SdkMgr.getInst().setQueryRankListener(MainActivity.this, ConstProp.LISTENER_CB_UI); //注册排行榜相关回调监听
        SdkMgr.getInst().setShareListener(MainActivity.this, ConstProp.LISTENER_CB_UI);// 注册分享相关回调监听
        SdkMgr.getInst().setExtendFuncListener(MainActivity.this, ConstProp.LISTENER_CB_UI);
        SdkMgr.getInst().setOnProtocolFinishListener(MainActivity.this, ConstProp.LISTENER_CB_UI); // 用户协议
        SdkMgr.getInst().setQuerySkuDetailsListener(MainActivity.this, ConstProp.LISTENER_CB_UI); // 产品列表

        //注册WebView的回调处理，LISTENER_CB_UI 表示使用UI线程调用回调函数，LISTENER_CB_GL表示使用GL线程调用回调函数    调查问卷
        SdkMgr.getInst().setWebViewListener(MainActivity.this, ConstProp.LISTENER_CB_UI);

        //将游戏的GLSurfaceView注册到UniSDK
        //****************************
        SdkMgr.getInst().setGlView(new GLSurfaceView(this));

        //设置启用Gas3
        SdkMgr.getInst().setPropInt(ConstProp.UNISDK_JF_GAS3, 1);

        //这些参数需要在计费Jelly系统中获取
        SdkMgr.getInst().setPropStr(ConstProp.JF_GAMEID, Defines.JF_GAME_ID);
        SdkMgr.getInst().setPropStr(ConstProp.JF_LOG_KEY, Defines.JF_LOG_KEY);
        System.out.println("请确保在调用初始化ntInit之前将UNISDK_JF_GAS3_URL设置为GAS3【正式】支付地址" + Defines.UNISDK_JF_GAS3_URL);
        SdkMgr.getInst().setPropStr(ConstProp.UNISDK_JF_GAS3_URL, Defines.UNISDK_JF_GAS3_URL);
        //注意：请确保在调用初始化ntInit之前将UNISDK_JF_GAS3_URL设置为GAS3【正式】支付地址
        //如需切到GAS3测试地址，可以在ntInit之后，ntLogin之前，通过脚本修改UNISDK_JF_GAS3_URL。正式放出的包只能使用GAS3正式地址
        //ps：如果是使用第三方渠道网易实现的防沉迷，目前必须要在ntInit之前配置UNISDK_JF_GAS3_URL，下个版本（channel_aas_5）会支持在ntLogin之前设置UNISDK_JF_GAS3_URL。

        //****************************
        SdkMgr.getInst().setPropStr(ConstProp.ENGINE_VERSION, UnisdkLogInfo.GetAppVersion());
        SdkMgr.getInst().setPropStr(ConstProp.RESOURCE_VERSION, UnisdkLogInfo.GetResVersion());

        //必须ntInit之前调用，否则无效 闪屏操作
        SdkMgr.getInst().setPropInt(ConstProp.SPLASH_PNG_SCALE_TYPE, ConstProp.SPLASH_PNG_CENTER_CROP);


        //初始化SDK对象
        SdkMgr.getInst().ntInit(new OnFinishInitListener() {
            @Override
            public void finishInit(int code) {
                if (code == OnFinishInitListener.OK || code == OnFinishInitListener.MISSED) {
                    //初始化成功，可以执行登录操作
                    log("unisdk init success");

                    try
                    {
                        // 初始化成功后， 激活日志
                        JSONObject jsonData = new JSONObject();
                        jsonData.put("app_ver", GetAppVersion());
                        Utils.Drpf("Activation", jsonData.toString());

                        // 初始化环境sdk
                        InitEnvSDK();

                        // 激活广告埋点
                        FirstOpen();

                        // 初始化回调
//                        JSONObject json = new JSONObject();
//                        json.put("eventType", EventCenter.EVENT_INIT_FINISH);
//                        Utils.unitySendMessage(json.toString());

                    }
                    catch (JSONException e)
                    {
                        e.printStackTrace();
                    }

                } else {
                    //初始化失败，不能执行登录操作，需要检查配置信息
                    log("unisdk init failed");
                }
            }
        });
    }

    void InitEnvSDK()
    {
        EnvManager.enableLog(true);
        EnvManager.initSDK(this, Defines.JF_LOGPROJECT_ID, Defines.ENVSDK_KEY, Defines.ENVSDK_HOST);
    }

    void FirstOpen()
    {
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(this);
        boolean flag = sp.getBoolean("firstTime", false);
        Utils.log("FirstOpen =" + flag);
        if (!flag)
        {
            //移除埋点first_open
//            try
//            {
//                // 激活广告埋点
//                JSONObject adJson = new JSONObject();
//                adJson.put("first_open", "");
//                Utils.TrackCustomEvent("first_open", adJson.toString());
//            }
//            catch (Exception e)
//            {
//                e.printStackTrace();
//            }

            try
            {
                // app安装
                JSONObject jsonData = new JSONObject();
                jsonData.put("ta_app_install", "");
                jsonData.put("app_install_time", UnisdkLogInfo.GetZoneDateTime());
                Utils.Drpf("ta_app_install", jsonData.toString());
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }

            try
            {
                // 设备激活时间
                JSONObject jsonData = new JSONObject();
                jsonData.put("device_activate", "");
                jsonData.put("device_activate_time", UnisdkLogInfo.GetZoneDateTime());
                Utils.Drpf("device_activate", jsonData.toString());
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }

            SharedPreferences.Editor editor = sp.edit();
            editor.putBoolean("firstTime", true);
            editor.commit();
        }
    }

    String GetAppVersion()
    {
        try
        {
            PackageManager manager = GetContext().getPackageManager();
            PackageInfo packInfo = manager.getPackageInfo(getPackageName(), 0);
            String versionName = packInfo.versionName;
            int versionCode = packInfo.versionCode;
            Utils.log("versionName　＝　" +versionName);
            Utils.log("versionCode　＝　" +versionCode);

            UnisdkLogInfo.SetAppVersion(versionName);
            UnisdkLogInfo.SetResVersion(versionCode+"");
            return versionName;
        }
        catch (Exception e)
        {
            Utils.log("Exception =" + e.toString());
            e.printStackTrace();
        }

        return "";
    }

    DownloadListener orbitDownLoad = new DownloadListener() {

        @Override
        public void onProgress(JSONObject data) {
            //data is a json object
            Utils.log("orbitDownLoad onProgress jsondata =" + data.toString());
            try {
                double progress = data.optDouble("progress");
                long size = data.optLong("size");
                long bytes = data.optLong("bytes");

                //do what you need to show progress within your UI


            } catch (Exception e) {
                e.printStackTrace();
                //...
            }
        }

        @Override
        public void onFinish(JSONObject data) {
            //data is a json object
            Utils.log("orbitDownLoad onFinish jsondata =" + data.toString());
            try {
                int code = data.optInt("code");
                String type = data.optString("type");

                //do what you need to deal with the download status

            } catch (Exception e) {
                e.printStackTrace();
                //...
            }
        }
    };
}
