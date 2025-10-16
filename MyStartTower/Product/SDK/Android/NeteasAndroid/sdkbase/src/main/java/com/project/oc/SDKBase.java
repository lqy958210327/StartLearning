package com.project.oc;

import org.json.JSONException;

public class SDKBase extends PluginBase
{
    private boolean mIsInitFinish = false;
    private boolean mIsInitSuccess = false;
    private boolean mIsLoginFinish = false;
    private boolean mIsLoginSuccess = false;
    private boolean mIsLogoutFinish = false;
    private boolean mIsLogoutSuccess = false;

    protected String mUserId = "";
    protected String mUserName = "";
    protected String mUserToken = "";

    /**************初始化*********************/
    public void init() throws JSONException {}
    public boolean isInitFinish(){return mIsInitFinish;}
    public boolean isInitSuccess() { return mIsInitSuccess; }

    /**************登录********************/
    public void checkAutoLogin(){}

    public void login(){}
    public boolean isLoginFinish() { return mIsLoginFinish; }
    public boolean isLoginSuccess() { return mIsLoginSuccess; }
    public String getUserId() { return mUserId; }
    public String getUserName() { return mUserName; }
    public String getUserToken() { return mUserToken; }
    public void logout() {}
    public boolean isLogoutFinish() { return mIsLogoutFinish; }
    public boolean isLogoutSuccess() { return mIsLogoutSuccess; }

    /**************支付********************/
    public void pay(String data) {}

    /**************其他********************/
    public void questionnaire(String url){}

    public void openWebView(String url){}

    public void hasPackageInstalled(String packageName){}
    public void toApp(String pageInfo,String packageName){}

    public boolean hasUserCenter(){ return false; }
    public void openUserCenter(){}
    public String onEvent(String eventKey, String data) { return "";}

    public String getDeviceId()
    {
        return "";
    }


    protected void startInit()
    {
        log("startInit");
        mIsInitFinish = false;
        mIsInitSuccess = false;
    }

    protected void initSuccess()
    {
        log("initSuccess");
        mIsInitFinish = true;
        mIsInitSuccess = true;
    }

    protected void initFailed()
    {
        log("initFailed");
        mIsInitFinish = true;
        mIsInitSuccess = false;
    }

    protected void startLogin()
    {
        log("startLogin");
        mIsLoginFinish = false;
        mIsLoginSuccess = false;
    }

    protected void loginSuccess()
    {
        log("loginSuccess");
        mIsLoginFinish = true;
        mIsLoginSuccess = true;

        mIsLogoutFinish = true;
        mIsLogoutSuccess = false;
    }

    protected void loginFailed()
    {
        log("loginFailed");
        mIsLoginFinish = true;
        mIsLoginSuccess = false;
    }

    protected void startLogout()
    {
        log("startLogout");
        mIsLogoutFinish = false;
        mIsLogoutSuccess = false;
    }

    protected void logoutSuccess()
    {
        log("logoutSuccess");
        mIsLogoutFinish = true;
        mIsLogoutSuccess = true;

        mIsLoginFinish = true;
        mIsLoginSuccess = false;
    }

    protected void logoutFailed()
    {
        log("logoutFailed");
        mIsLogoutFinish = true;
        mIsLogoutSuccess = false;

        mIsLoginFinish = true;
        mIsLoginSuccess = false;
    }

    /****************************工具************************/
    protected void log(String data)
    {
        Utils.log(data);
    }

    protected void unitySendMessage(String arg1, String arg2)
    {
        Utils.unitySendMessage(arg1, arg2);
    }
}
