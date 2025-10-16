package com.project.oc;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.util.Log;

import com.netease.androidcrashhandler.Const;
import com.netease.androidcrashhandler.NTCrashHunterKit;
import com.netease.androidcrashhandler.javacrash.JavaCrashCallBack;
import com.netease.environment.EnvManager;
import com.netease.ntunisdk.base.ConstProp;
import com.netease.ntunisdk.base.SdkMgr;
import com.netease.ntunisdk.base.OrderInfo;


import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;
import java.util.Random;

public class SDK extends SDKBase{

    @Override
    public void onCreate(Activity activity, Bundle savedInstanceState) {
        super.onCreate(activity, savedInstanceState);
        Log.d(Defines.SDK_LOG_TAG, "unisdk onCreate");
    }

    @Override
    public void onPause() {
        super.onPause();
    }

    @Override
    public void onStart() {
        super.onStart();
    }

    @Override
    public void onStop() {
        super.onStop();
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    @Override
    public void onRestart() {
        super.onRestart();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
    }

    @Override
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
    }

    @Override
    public void onSaveInstanceState(Bundle state) {
        super.onSaveInstanceState(state);
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        SdkMgr.getInst().handleOnBackPressed();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }

    @Override
    public void init() {
        Utils.LoginDrpf("init_sdk_handler");
        System.out.println("sdk初始化==========SDK init");
        checkAutoLogin();
    }

    @Override
    public void checkAutoLogin()
    {
        try
        {
            Utils.LoginDrpf("check_auto_login");
            System.out.println("sdk初始化成功后检查是否可以自动登录==========");
            //sdk初始化成功后检查是否可以自动登录
            JSONObject json2 = new JSONObject();
            json2.put("methodId","shouldAutoLogin");
            SdkMgr.getInst().ntExtendFunc(json2.toString());

            getAppinstanceId();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /***
     * getAppinstanceId
     */
    public void getAppinstanceId()
    {
        try
        {
            System.out.println("获取getAppinstanceId");
            //sdk初始化成功后检查是否可以自动登录
            JSONObject json2 = new JSONObject();
            json2.put("methodId","getAppInstanceId");
            json2.put("channel","firebase");
            SdkMgr.getInst().ntExtendFunc(json2.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    @Override
    public void login() {
        startLogin();
        Log.d(Defines.SDK_LOG_TAG, "unisdk login");
        SdkMgr.getInst().ntLogin();

        // 开始SDK登录日志
        try
        {
            JSONObject jsonData = new JSONObject();
            jsonData.put("account_id",Utils.GetAccountId());
            jsonData.put("sdk_login_status",0);
            jsonData.put("app_ver", UnisdkLogInfo.GetAppVersion());
            jsonData.put("error_code",0);
            Utils.Drpf("SDKLogin", jsonData.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    @Override
    public void logout() {
        Log.d(Defines.SDK_LOG_TAG, "unisdk logout");
        startLogout();

        boolean hasFeature = SdkMgr.getInst().hasFeature(ConstProp.MODE_HAS_LOGOUT);
        Log.d(Defines.SDK_LOG_TAG, "ntLogout hasFeature ="+hasFeature);
        if(hasFeature) {
            //显示登出按钮
            SdkMgr.getInst().ntLogout();
        }
    }

    @Override
    public void pay(String data) {
        String[] dataArr = data.split("#");
        if(dataArr.length != 4)
        {
            System.out.println("支付参数有误，数组长度必须为4");
            return;
        }
        Log.d(Defines.SDK_LOG_TAG, "unisdk pay data:" + data);
        String goodsId = dataArr[0];
        String desc = dataArr[1];
        String privatePram = dataArr[2];
        String hostId = dataArr[3];
        OrderInfo order = new OrderInfo(goodsId); //只能传入步骤2从计费拉取到的商品id，即在计费Jelly正式/测试环境成功配置过的商品id
        order.setCount(1); //可以不设置，默认为1
        order.setOrderDesc(desc); //玩家支付时在渠道SDK界面看到的一段描述文字

//母包版本>=1.3.2后需要针对订单对象OrderInfo额外设置以下值：
        String sdkUid = SdkMgr.getInst().getPropStr(ConstProp.UID);
        String role_id = SdkMgr.getInst().getPropStr(ConstProp.USERINFO_UID);
        //String server = SdkMgr.getInst().getPropStr(ConstProp.USERINFO_HOSTID);
        String aid = SdkMgr.getInst().getPropStr(ConstProp.USERINFO_AID);

        //支付参数有问题
        if(role_id.equals("-1")|| role_id.equals("")|| hostId.equals("-1")|| hostId.equals(""))
        {
            try {
                JSONObject json = new JSONObject();
                json.put("eventType", EventCenter.EVENT_CHECK_ORDER_RESULT);
                json.put("orderStatus", 3);
                json.put("jfCode", "");
                json.put("jfSubCode", "");
                json.put("jfMessage", "");
                json.put("payChannel", "");
                json.put("currency", "");
                json.put("price", "");

                Utils.unitySendMessage(json.toString());
            } catch (JSONException e) {
                throw new RuntimeException(e);
            }
            return;
        }

        order.setUserName(role_id);//roleid_游戏角色id
        order.setServerId(hostId);//hostid_int类型的服务器id
        order.setUid(sdkUid);//渠道用户id，sdkUid
        order.setAid(aid);//计费aid
        order.setJfExtInfo(privatePram);//透传字段，计费会在步骤12通过发货通知接口的privateparam将透传字段发给游戏服，游戏服可以用来做支付验证。

        SdkMgr.getInst().ntCheckOrder(order); //打开支付界面

    }

    @Override
    public String onEvent(String eventKey, String data) {
        Log.d(Defines.SDK_LOG_TAG, "unisdk onEvent" + eventKey + " xx " +data);
        return "";
    }

    @Override
    public boolean hasUserCenter() {
        boolean flag = SdkMgr.getInst().hasFeature(ConstProp.MODE_HAS_MANAGER);
        Utils.log("unisdk hasUserCenter =" + flag);
        return flag;
    }

    public boolean hasLogoutFunction() {
        boolean flag = SdkMgr.getInst().hasFeature(ConstProp.MODE_HAS_LOGOUT);
        Utils.log("unisdk hasLogoutFunction =" + flag);
        return flag;
    }

    @Override
    public void openUserCenter()
    {
        Utils.log("unisdk openUserCenter");
        SdkMgr.getInst().ntOpenManager();
    }

    @Override
    public String getDeviceId()
    {
        return UnisdkLogInfo.GetUnisdkDeviceid();
    }

    // 打开调查问卷
    public void questionnaire(String url)
    {
        String[] dataArr = url.split("#");
        if(dataArr.length != 4)
        {
            System.out.println("webview参数有误，数组长度必须为4");
            return;
        }
        String survey_url = dataArr[0];
        String floatView = dataArr[1];
        String fullView = dataArr[2];
        String showCloseBtn = dataArr[3];
        // 调用ntOpenWebView之前，先调用
        SdkMgr.getInst().setPropStr("WEBVIEW_MODE", "1");//切换为ngwebview的方式，与iOS统一；

        if("1".equals(showCloseBtn))
        {
            SdkMgr.getInst().setPropStr("WEBVIEW_CLOSEBUTTON_VISIBLE",showCloseBtn);   //显示原生关闭按钮
        }

        //(可选)调用ntOpenWebView之前，先调用
        SdkMgr.getInst().setPropInt("WEBVIEW_ORIENTATION", 2);//指定方向：竖屏填1，横屏填2，双向横屏填5（横屏游戏如果可以旋转，需要设置为5）
        //(可选，V1.7(2)开始支持)调用ntOpenWebView之前，先调用以下代码设置左上角坐标及长高：
        //SdkMgr.getInst().setPropInt("WEBVIEW_ORIGIN_X", xx);//问卷左上角X坐标
        // SdkMgr.getInst().setPropInt("WEBVIEW_ORIGIN_Y", xx);//问卷左上角Y坐标
        //SdkMgr.getInst().setPropInt("WEBVIEW_WIDTH", xx);//问卷长度
        // SdkMgr.getInst().setPropInt("WEBVIEW_HEIGHT", xx);//问卷高度
        //SdkMgr.getInst().setPropStr("WEBVIEW_H5_PADDING", "{top, left, bottom, right}");//设置问卷界面外边距 （2.4版本或以上）
        //SdkMgr.getInst().setPropStr("WEBVIEW_CONTENT_TYPE", "SURVEY");    //支持新的问卷域名 （2.7版本或以上）

        SdkMgr.getInst().setPropStr(ConstProp.WEBVIEW_FULLFIT, fullView); //非全屏显示
        //(可选)调用ntOpenWebView之前，先调用,小窗模式，不会影响游戏生命周期 （3.3版本或以上，每次打开都要设置一次，不然下次会失效）
        SdkMgr.getInst().setPropStr("WEBVIEW_IS_FLOAT_VIEW",floatView);

        String sdkUid = getDeviceId();
        String role_id = SdkMgr.getInst().getPropStr(ConstProp.USERINFO_UID);
        String server = SdkMgr.getInst().getPropStr(ConstProp.USERINFO_HOSTID);

        String survey_url2 = survey_url + String.format("?uid=%s&role_id=%s&server=%s",sdkUid,role_id,server);
        System.out.println("问卷原地址:" + survey_url);
        System.out.println("问卷sdkUid:" + sdkUid);
        System.out.println("问卷role_id:" + role_id);
        System.out.println("问卷server:" + server);
        System.out.println("问卷拼接地址:" + survey_url2);
        SdkMgr.getInst().ntOpenWebView(survey_url2);
    }

    /**
     * 打开webview
     * @param url
     */
    public void openWebView(String url)
    {
        String[] dataArr = url.split("#");
        String target_url = dataArr[0];
        String floatView = dataArr[1];
        String fullView = dataArr[2];
        String navigationBar = dataArr[3];

        try
        {
            JSONObject json = new JSONObject();
            json.put("methodId","NGWebViewOpenURL");
            json.put("scriptVersion","1.0.1");
            json.put("URLString",target_url);
            json.put("orientation","2");//横屏
            json.put("navigationBarVisible",navigationBar);//显示导航栏
            json.put("isFloatView",floatView);//小窗口模式，不影响游戏的生命周期
            json.put("isFullScreen",fullView);//全屏模式
            SdkMgr.getInst().ntExtendFunc(json.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 查询App是否安装
     */
    public void hasPackageInstalled(String packageName)
    {
        System.out.println("hasPackageInstalled---" + packageName);
        try
        {
            JSONObject json = new JSONObject();
            json.put("methodId","hasPackageInstalled");
            json.put("appId",packageName);
            SdkMgr.getInst().ntExtendFunc(json.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 跳转app
     */
    public void toApp(String pageInfo,String packageName)
    {
        System.out.println("toApp---" + pageInfo + "-------------" + packageName);
        try
        {
            JSONObject json = new JSONObject();
            json.put("methodId","toApp");
            json.put("android",pageInfo);
            json.put("package",packageName);
            SdkMgr.getInst().ntExtendFunc(json.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    // 打开用户协议
    public void openAgreement()
    {
        Utils.log("SDK openAgreement");
        SdkMgr.getInst().ntShowCompactView(true);
    }

    //设置用户协议地址
    public void setCompactUrl(String url, String langage)
    {
        Utils.log("SDK setCompactUrl: " + url);
        SdkMgr.getInst().setPropStr(ConstProp.NT_COMPACT_URL, url);
       // SdkMgr.getInst().setPropStr(ConstProp.NT_COMPACT_LOCALE,langage);//设置不同语言, 不需要代码设置了
    }

    public void setLanguage(String langage)
    {
        Utils.log("SDK setLanguage: " + langage);
        SdkMgr.getInst().setPropStr(ConstProp.LANGUAGE_CODE, langage);

        SetCustomerPermission(langage);
        try
        {
            JSONObject json = new JSONObject();
            json.put("methodId","setLanguage");
            SdkMgr.getInst().ntExtendFunc(json.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }

    void SetCustomerPermission(String langage)
    {
        // gmbridge_6(4.9.8)以上版本加入权限申请弹框前的提示
        SdkMgr.getInst().setPropInt("ENABLE_UNISDK_PERMISSION_TIPS", 1);

        String lPhoto = "Camera permissions are required for taking photos";
        String lRecord = "Recording permissions are required for recording";

        if (langage.equals(Defines.LANGUAGE_CHS))
        {
            lPhoto = "请求使用相机权限，用于拍照";
            lRecord = "需要录音权限用于录音";
        }

        SdkMgr.getInst().setPropStr("UNISDK_GM_PERMISSION_TIPS", lPhoto); //文案请自行制定,注意如果是海外游戏使用，请设置相应语言
        SdkMgr.getInst().setPropStr("UNISDK_GM_PERMISSION_RECORD_TIPS", lRecord); //文案请自行制定,注意如果是海外游戏使用，请设置相应语言，gmbridge_9(5.0.8)开始支持
        Utils.log("SetCustomerPermission = " + langage);
    }

    public void sendUnisdkLoginJson(String datajson)
    {
        Utils.log("SDK getUnisdkLoginJson: " + datajson);
        try
        {
            JSONObject json = new JSONObject(datajson);
            String unisdk_login_json = json.getString("unisdk_login_json");
            String username = json.getString("username");
            String uid = username.split("@")[0];
            int aid = json.getInt("aid");
            String message = "";
            String roleid = "-1";
            int hostid = -1;

            if (datajson.contains("roleid"))
            {
                roleid = json.getString("roleid");
            }

            if (datajson.contains("hostid"))
            {
                json.getInt("hostid");
            }

            if (datajson.contains("message"))
            {
                message = json.getString("message");
            }

//            Utils.SetAid(aid);
//            Utils.SetMessage(message);

            SdkMgr.getInst().setPropStr(ConstProp.UNISDK_LOGIN_JSON, unisdk_login_json);
            SdkMgr.getInst().setPropStr(ConstProp.UID, uid);
            SdkMgr.getInst().setPropInt(ConstProp.USERINFO_AID, aid);

            SdkMgr.getInst().setPropStr(ConstProp.USERINFO_UID, roleid);
            SdkMgr.getInst().setPropInt(ConstProp.USERINFO_HOSTID, hostid);

            Utils.SetAccountId(username);
            Utils.SetUid(uid);

            Utils.log("hasLogin =" + SdkMgr.getInst().hasLogin());
            if (SdkMgr.getInst().hasLogin())
            {
                SdkMgr.getInst().ntGameLoginSuccess();  //注：一定要调用！！！并且调用时机是创建角色后，以及角色登录进游戏服后，否则会出现补单失败
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public void uploadRoleInfo(String jsonData)
    {
        Utils.log("uploadRoleInfo jsonData = " + jsonData);
        try
        {
            JSONObject obj = new JSONObject(jsonData);
            if (jsonData.contains(Defines.ATTR_SERVERID))
            {
                SdkMgr.getInst().setPropStr(ConstProp.USERINFO_STAGE, ConstProp.USERINFO_STAGE_ENTER_SERVER);
                SdkMgr.getInst().setPropInt(ConstProp.USERINFO_HOSTID, obj.getInt(Defines.ATTR_SERVERID)); //服务器id
            }

            if (jsonData.contains(Defines.ATTR_SERVERNAME))
            {
                SdkMgr.getInst().setPropStr(ConstProp.USERINFO_HOSTNAME, obj.getString(Defines.ATTR_SERVERNAME)); //服务器名称
            }

            if (jsonData.contains(Defines.ATTR_ROLEID))
            {
                SdkMgr.getInst().setPropStr(ConstProp.USERINFO_STAGE, ConstProp.USERINFO_STAGE_CREATE_ROLE);
                SdkMgr.getInst().setPropStr(ConstProp.USERINFO_UID, obj.getString(Defines.ATTR_ROLEID)); //当前登录的玩家角色ID
            }

            if (jsonData.contains(Defines.ATTR_ROLENAME))
            {
                SdkMgr.getInst().setPropStr(ConstProp.USERINFO_NAME, obj.getString(Defines.ATTR_ROLENAME)); //当前登录的玩家角色名称
            }

            if (jsonData.contains(Defines.ATTR_ROLEGRADE))
            {
                SdkMgr.getInst().setPropStr(ConstProp.USERINFO_STAGE, ConstProp.USERINFO_STAGE_LEVEL_UP);
                SdkMgr.getInst().setPropInt(ConstProp.USERINFO_GRADE, obj.getInt(Defines.ATTR_ROLEGRADE)); //当前登录的玩家角色等级
            }

            if (jsonData.contains(Defines.ATTR_ROLECREATETIME))
            {
                SdkMgr.getInst().setPropInt(ConstProp.USERINFO_ROLE_CTIME, obj.getInt(Defines.ATTR_ROLECREATETIME));
            }

            if (jsonData.contains(Defines.ATTR_ROLELEVELTIME))
            {
                SdkMgr.getInst().setPropInt(ConstProp.USERINFO_ROLE_LEVELMTIME, obj.getInt(Defines.ATTR_ROLELEVELTIME));
            }

            Utils.log("uploadRoleInfo success");
            SdkMgr.getInst().ntUpLoadUserInfo();

            CrashHunterInit();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }

    void CrashHunterInit()
    {
        Utils.LoginDrpf("crash_hunter_init");
        NTCrashHunterKit.sharedKit().init(mActivity);

        NTCrashHunterKit.sharedKit().setParam(Const.ParamKey.PROJECT, Defines.JF_LOGPROJECT_ID);
        NTCrashHunterKit.sharedKit().setParam(Const.ParamKey.APPKEY, Defines.CRASH_DUMP_KEY);
        NTCrashHunterKit.sharedKit().setParam(Const.ParamKey.ENGINE_VERSION, UnisdkLogInfo.GetAppVersion());
        NTCrashHunterKit.sharedKit().setParam(Const.ParamKey.RES_VERSION,UnisdkLogInfo.GetResVersion());
        String uid = Utils.GetUid();
        String serverName = SdkMgr.getInst().getPropStr(ConstProp.USERINFO_HOSTNAME);
        String userName = SdkMgr.getInst().getPropStr(ConstProp.USERINFO_NAME);
        System.out.println("CrashHunterKit uid=" + uid);
        System.out.println("CrashHunterKit serverName=" + serverName);
        System.out.println("CrashHunterKit userName=" + userName);
        NTCrashHunterKit.sharedKit().setParam(Const.ParamKey.UID,uid);
        NTCrashHunterKit.sharedKit().setParam(Const.ParamKey.SERVER_NAME,serverName);
        NTCrashHunterKit.sharedKit().setParam(Const.ParamKey.USERNAME,userName);

        SetJavaCrash();
        NTCrashHunterKit.sharedKit().startHuntingCrash();

        String uploadFileDir = NTCrashHunterKit.sharedKit().getUploadFileDir();
        Utils.log("NTCrashHunterKit uploadFileDir =" + uploadFileDir);
    }

    void SetJavaCrash()
    {
        Utils.LoginDrpf("set_java_crash");
        NTCrashHunterKit.sharedKit().setJavaCrashCallBack(new JavaCrashCallBack() {
            @Override
            public void crashCallBack(Throwable throwable) {
                try {
                    // app崩溃
                    JSONObject jsonData = new JSONObject();
                    jsonData.put("ta_app_crash", "");
                    jsonData.put("app_crash_stack_trace", throwable.getStackTrace().toString());
                    Utils.Drpf("ta_app_crash", jsonData.toString());

                } catch (JSONException e) {
                    throw new RuntimeException(e);
                }
                Utils.log("SetJavaCrash");
            }
        });
    }

    public void TrackCustomEvent(String event, String jsonData)
    {
        Utils.TrackCustomEvent(event, jsonData);
    }

    public String ReviewNicknameV2(String nickName)
    {
        Utils.log("nickName = " + nickName);
        String envJson = EnvManager.reviewNicknameV2(nickName);
        Utils.log("envJson = " + envJson);
        return envJson;
    }

    public String ReviewWordsV2(String level, String channel, String content)
    {
        Utils.log("level = " + level + " channel =" + channel + " content ="+content);
        String envJson = EnvManager.reviewWordsV2(level, channel, content);
        Utils.log("envJson = " + envJson);
        return envJson;
    }

    public void OpenCustomerService(String roleid)
    {
        Utils.log("OpenCustomerService roleid =" + roleid);
        try
        {
            JSONObject jsonData = new JSONObject();
            jsonData.put("methodId","ntSetRoleId");
            jsonData.put("roleId", roleid);
            Utils.log("OpenCustomerService ntSetRoleId =" + jsonData.toString());
            SdkMgr.getInst().ntExtendFunc(jsonData.toString());

            jsonData = new JSONObject();
            jsonData.put("methodId","ntOpenGMPage");
            jsonData.put("refer", "");
            Utils.log("OpenCustomerService ntOpenGMPage =" + jsonData.toString());
            SdkMgr.getInst().ntExtendFunc(jsonData.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public void SetCustomerServiceTokenInfo(String tokenInfo)
    {
        Utils.log("SetCustomerServiceTokenInfo =" + tokenInfo);
        try
        {
            JSONObject dataJson = new JSONObject(tokenInfo);
            String message = dataJson.getString("message");
            if ("success".equals(message))
            {
                JSONObject jsonData = new JSONObject();
                jsonData.put("methodId","ntSetGenTokenResponse");
                jsonData.put("response", tokenInfo);
                SdkMgr.getInst().ntExtendFunc(jsonData.toString());
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public void FacebookShare(String jsonStr)
    {
        Utils.FacebookShare(jsonStr);
        try {
            // 分享埋点
            JSONObject adJson = new JSONObject();
            //adJson.put("share", "");
            Utils.TrackCustomEvent("share", adJson.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
