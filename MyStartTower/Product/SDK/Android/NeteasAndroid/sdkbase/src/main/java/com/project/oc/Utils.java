package com.project.oc;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.util.Log;

import com.netease.ntunisdk.base.SdkMgr;
import com.project.global.appsflyer.Appsflyer;
import com.project.global.facebook.Facebook;
import com.project.global.firebase.Firebase;
import com.unity3d.player.UnityPlayer;

import org.json.JSONObject;

public class Utils {

    static Context mContext = null;
    static Context mLoginContext = null;
    static String mAcountId = "";
    static String mUid = "";
    static int mServerId = 0;
    static String mServerName = "";
    static Facebook mFacebook;
    static Appsflyer mAppsflyer;
    static Firebase mFirebase;
    static String mSharePath;

    static int mAid = 0;
    static String mMessage;

    public static boolean isDisableLogin = true;

    public static String appInstanceId = "";

    public static void log(String data)
    {
        Log.i(Defines.SDK_LOG_TAG, data);
    }

    public static void unitySendMessage(String arg1, String arg2)
    {
        if (!MainActivity.IsInitUnityPlayer())
            return;

        UnityPlayer.UnitySendMessage(Defines.SDK_Handler, arg1, arg2);

    }

    public static void unitySendMessage(String data)
    {
        if (!MainActivity.IsInitUnityPlayer())
            return;

        Utils.log("UnitySendMessage data =" + data);
        UnityPlayer.UnitySendMessage(Defines.SDK_Handler, Defines.METHOD_ACTION_JAVACALLEVENTMSG, data);

    }

    public static void SetContext(Context context)
    {
        mContext = context;
    }

    public static Context GetContext()
    {
        return mContext;
    }

    public static void SetAccountId(String accountId)
    {
        mAcountId = accountId;
    }

    public static String GetAccountId()
    {
        return mAcountId;
    }

    public static void SetUid(String uid)
    {
        mUid = uid;
    }

    public static String GetUid()
    {
        return mUid;
    }

    public static void SetAid(int uid)
    {
        mAid = uid;
    }

    public static int GetAid()
    {
        return mAid;
    }

    public static void SetMessage(String message)
    {
        mMessage = message;
    }

    public static String GetMessage()
    {
        return mMessage;
    }

    public static void SetStrAccountId(String uid)
    {
        uid = uid + "@netease_global.win.163.com";
        SetAccountId(uid);
    }

    public static void SetSharePath(String sharePath)
    {
        mSharePath = sharePath;
    }

    public static String GetSharePath()
    {
        return mSharePath;
    }

    public static void SetServerId(int id)
    {
        mServerId = id;
    }

    public static int GetServerId()
    {
        return mServerId;
    }

    public static void SerServerName(String name)
    {
        mServerName = name;
    }

    public static String GetServerName()
    {
        return mServerName;
    }


    public static void Drpf(String operation, String json)
    {
        try
        {
            Utils.log("DRPF json = " + json);
            JSONObject data = new JSONObject(json);
            String jsonStr = "";
            if(operation.equals("FPS") || operation.equals("acsdk_cheat_check"))
            {
                jsonStr = UnisdkLogInfo.GetFpsDrpfJson(Utils.GetContext(), operation, data);
            }
            else
            {
                jsonStr = UnisdkLogInfo.GetDrpfJson(Utils.GetContext(), operation, data);
            }
            Utils.log("DRPF jsonStr = " + jsonStr);

            SdkMgr.getInst().DRPF(jsonStr);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }


    public static void TrackCustomEvent(String event, String jsonData)
    {
        if(mFacebook == null)
        {
            mFacebook = new Facebook();
        }

        if (mAppsflyer == null)
        {
            mAppsflyer = new Appsflyer();
        }

        if (mFirebase == null)
        {
            mFirebase = new Firebase();
        }

        mFacebook.TrackCustomEvent(event, jsonData);
        mAppsflyer.TrackCustomEvent(event, jsonData);
        mFirebase.TrackCustomEvent(event, jsonData);
    }

    public static void FacebookShare(String jsonStr)
    {
        if(mFacebook == null)
        {
            mFacebook = new Facebook();
        }

        mFacebook.ShareFunction(jsonStr);
    }


    public static void SetLoginContext(Context cont)
    {
        mLoginContext = cont;
    }
    public static void LoginDrpf(String eventName)
    {
        try
        {
            // 登录流程埋点
            JSONObject jsonData = new JSONObject();
            jsonData.put(eventName, "");
            PackageManager manager = GetContext().getPackageManager();
            PackageInfo packInfo = manager.getPackageInfo(mLoginContext.getPackageName(), 0);
            String versionName = packInfo.versionName;
            jsonData.put("app_ver", versionName);
            Utils.Drpf(eventName, jsonData.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}
