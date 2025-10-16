package com.project.global.appsflyer;

import com.netease.ntunisdk.base.SdkMgr;
import com.project.oc.Utils;

import org.json.JSONObject;

public class Appsflyer {

    public static void TrackCustomEvent(String event, String jsonStr)
    {
        try
        {
            JSONObject parObj = new JSONObject();
            JSONObject subObj = new JSONObject(jsonStr);
            parObj.put("appsflyer", subObj.toString());

            Utils.log("appsflyer json =" + parObj.toString());
            SdkMgr.getInst().ntTrackCustomEvent(event, parObj.toString());
        }
        catch (Exception e)
        {
            Utils.log("appsflyer Exception e =" + e.toString());
        }

    }
}
