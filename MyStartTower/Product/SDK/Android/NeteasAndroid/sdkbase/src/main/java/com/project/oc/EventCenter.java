package com.project.oc;

import java.util.Dictionary;
import java.util.Hashtable;

public class EventCenter {

    // 事件定义
    public static final int EVENT_INIT_FINISH = 1;
    public static final int EVENT_LOGIN_SUCCESS = 2;
    public static final int EVENT_LOGIN_CANCEL = 3;
    public static final int EVENT_LOGIN_FAIL = 4;
    public static final int EVENT_RELOGIN = 5;
    public static final int EVENT_LOGIN_GET_TOKEN = 6;
    public static final int EVENT_LOGOUT = 7;
    public static final int EVENT_EXIT_GAME = 8;
    public static final int EVENT_CANCEL_EXIT_GAME = 9;
    public static final int EVENT_PAY_RESULT = 10;
    public static final int EVENT_PAY_CANCEL = 11;
    public static final int EVENT_SWITCHACCOUNT = 12;

    public static final int EVENT_REQTOKEN_CUSTOMERSERVICE = 13;

    public static final int EVENT_WEBVIEW_NATIVECALL = 14;

    public static final int EVENT_CHECK_ORDER_RESULT = 15;

    public static final int EVENT_PROTOCOL_FINISH = 16;

    public static final int EVENT_PRODUCT_LIST = 17;

    public static final int EVENT_CLOSE_WEBVIEW = 18;

    public static final int EVENT_TO_APP = 19;

    //灯塔相关
    public static final int EVENT_PHAROS = 20;

    // 未成年 退出事件
    public static final int EVENT_LOGOUT_NIMOR = 101;
}
