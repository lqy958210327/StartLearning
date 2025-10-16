package com.project.global.firebase;

import com.netease.ntunisdk.base.SdkMgr;
import com.project.oc.Utils;

import org.json.JSONObject;

public class Firebase {

    public static void TrackCustomEvent(String event, String jsonStr)
    {
        try
        {
            JSONObject parObj = new JSONObject();
            JSONObject subObj = new JSONObject(jsonStr);
            parObj.put("firebase", subObj.toString());

            Utils.log("firebase json =" + parObj.toString());
            SdkMgr.getInst().ntTrackCustomEvent(event, parObj.toString());
        }
        catch (Exception e)
        {
            Utils.log("firebase Exception e =" + e.toString());
        }

    }
}
