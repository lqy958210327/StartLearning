package com.project.oc;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;

import com.netease.ntunisdk.base.ConstProp;
import com.netease.ntunisdk.base.SdkMgr;
import com.netease.ntunisdk.base.UniSdkUtils;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;

public class UnisdkLogInfo {

    static String mResVersion = "";
    public static void SetResVersion(String version)
    {
        mResVersion = version;
    }

    // 资源版本号
    public static String GetResVersion()
    {
        return mResVersion;
    }

    static String mAppVersion = "";
    public static void SetAppVersion(String version)
    {
        mAppVersion = version;
    }

    // 客户端版本号
    public static String GetAppVersion()
    {
        return mAppVersion;
    }

    // 获取当前系统时间，带时区
    public static String GetZoneDateTime()
    {
        Utils.log("GetZoneDateTime");
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            DateTimeFormatter formatter = DateTimeFormatter.BASIC_ISO_DATE;
            String data = formatter.format(ZonedDateTime.now());
            Utils.log("BASIC_ISO_DATE zonedata = " + data);
            String zone = data.substring(8);

            formatter = DateTimeFormatter.ISO_LOCAL_DATE;
            data = formatter.format(ZonedDateTime.now());
            Utils.log("ISO_LOCAL_DATE zonedata = " + data);
            String yyyy = data;

            formatter = DateTimeFormatter.ISO_LOCAL_TIME;
            data = formatter.format(ZonedDateTime.now());
            Utils.log("ISO_LOCAL_TIME zonedata = " + data);
            String hhmmss = data.substring(0, 8);

            data = "" + yyyy + " " + hhmmss + " " + zone + "";
            Utils.log("zonedata = " + data);
            return data;
        }


        Date now1 = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return format.format(now1);
    }

     // 激活时间
     public static long GetActiveTime()
     {
         Utils.log("active_time = " + Calendar.getInstance().getTimeInMillis() / 1000);
         return Calendar.getInstance().getTimeInMillis() / 1000;
     }

     // IP地址
     public static String GetIp(Context context)
     {
         NetworkInfo info = ((ConnectivityManager) context
                 .getSystemService(Context.CONNECTIVITY_SERVICE)).getActiveNetworkInfo();
         if (info != null && info.isConnected()) {
             if (info.getType() == ConnectivityManager.TYPE_MOBILE) {//当前使用2G/3G/4G网络
                 try {
                     //Enumeration<NetworkInterface> en=NetworkInterface.getNetworkInterfaces();
                     for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements(); ) {
                         NetworkInterface intf = en.nextElement();
                         for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements(); ) {
                             InetAddress inetAddress = enumIpAddr.nextElement();
                             if (!inetAddress.isLoopbackAddress() && inetAddress instanceof Inet4Address) {
                                 return inetAddress.getHostAddress();
                             }
                         }
                     }
                 } catch (SocketException e) {
                     e.printStackTrace();
                 }
             } else if (info.getType() == ConnectivityManager.TYPE_WIFI) {//当前使用无线网络
                 WifiManager wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
                 WifiInfo wifiInfo = wifiManager.getConnectionInfo();
                 //调用方法将int转换为地址字符串
                 String ipAddress = intIP2StringIP(wifiInfo.getIpAddress());//得到IPV4地址
                 return ipAddress;
             }
         } else {
             //当前无网络连接,请在设置中打开网络
             Utils.log("当前无网络连接,请在设置中打开网络");
         }

         return "127.0.0.1";
     }

    public static String intIP2StringIP(int ip) {
        return (ip & 0xFF) + "." +
                ((ip >> 8) & 0xFF) + "." +
                ((ip >> 16) & 0xFF) + "." +
                (ip >> 24 & 0xFF);
    }

     // 设备型号
    public static String GetDeviceMode()
    {
        String deviceMode = SdkMgr.getInst().getPropStr(ConstProp.SDC_LOG_DEVICE_MODEL);
        Utils.log("GetDeviceMode deviceMode = " + deviceMode);
        return deviceMode;
    }

    public static String GetNetwork()
    {
        String network = SdkMgr.getInst().getPropStr(ConstProp.SDC_LOG_APP_NETWORK);
        Utils.log("GetNetwork network = " + network);
        return network;
    }

    // 操作系统
    public static String GetOsName()
    {
        String osName = SdkMgr.getInst().getPropStr(ConstProp.SDC_LOG_OS_NAME);
        Utils.log("GetOsName osName = " + osName);
        return osName;
    }

    // 操作系统版本
    public static String GetOsVersion()
    {
        String osVersion = SdkMgr.getInst().getPropStr(ConstProp.SDC_LOG_OS_VER);
        Utils.log("GetOsVersion osVersion = " + osVersion);
        return osVersion;
    }

    // 设备唯一标识
    public static String GetUdid()
    {
        String udid = SdkMgr.getInst().getPropStr(ConstProp.UDID);
        Utils.log("GetUdid udid = " + udid);
        return udid;
    }

    // 运营渠道
    public static String GetAppChannel()
    {
        String appChanel = SdkMgr.getInst().getPropStr(ConstProp.SDC_LOG_APP_CHANNEL);
        Utils.log("GetAppChannel appChanel = " + appChanel);
        return appChanel;
    }

    // 移动设备国际识别码
    public static String GetIMEI(Context myCtx)
    {
        String imei = UniSdkUtils.getMobileIMEI(myCtx);
        Utils.log("GetIMEI imei = " + imei);
        return imei;
    }

    // 游戏生命周期唯一标识
    public static String GetTransid()
    {
        String transid = SdkMgr.getInst().getPropStr(ConstProp.TRANS_ID);
        Utils.log("GetTransid transid = " + transid);
        return transid;
    }

    // unisdk_deviceid
    public static String GetUnisdkDeviceid()
    {
        String unisdk_deviceid = SdkMgr.getInst().getPropStr(ConstProp.UNISDK_DEVICE_ID);
        Utils.log("GetUnisdkDeviceid unisdk_deviceid = " + unisdk_deviceid);
        return unisdk_deviceid;
    }

    // 是否模拟器
    public static int IsEnulator(Context myCtx)
    {
        boolean result = UniSdkUtils.isEmulator(myCtx);
        Utils.log("IsEnulator result = " + result);
        return result ? 1 : 0;
    }

    // 是否是root
    public static int IsDeviceRooted()
    {
        boolean result = UniSdkUtils.isDeviceRooted();
        Utils.log("IsDeviceRooted result = " + result);
        return result ? 1 : 0;
    }

    // 设备OAID
    public static String GetOAID()
    {
        String oaid = SdkMgr.getInst().getPropStr(ConstProp.OAID);
        Utils.log("GetOAID oaid = " + oaid);
        return oaid;
    }

    // 引擎版本
    public static String GetEngineVersion()
    {
        String engineVersion = SdkMgr.getInst().getPropStr(ConstProp.ENGINE_VERSION);
        Utils.log("GetEngineVersion engineVersion = " + engineVersion);
        return engineVersion;
    }

    public static String GetCountryCode()
    {
        try
        {
            String aimInfo = SdkMgr.getInst().getPropStr(ConstProp.JF_AIM_INFO);
            JSONObject jsonData = new JSONObject(aimInfo);
            return jsonData.getString("country");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return "";
    }

    public static int GetDeviceHeight()
    {
        int deviceHeight = Integer.parseInt(SdkMgr.getInst().getPropStr(ConstProp.SDC_LOG_DEVICE_HEIGHT));
        Utils.log("GetDeviceHeight deviceHeight = " + deviceHeight);
        return deviceHeight;
    }

    public static int GetDeviceWidth()
    {
        int deviceWidth = Integer.parseInt(SdkMgr.getInst().getPropStr(ConstProp.SDC_LOG_DEVICE_WIDTH));
        Utils.log("GetDeviceWidth deviceWidth = " + deviceWidth);
        return deviceWidth;
    }

    public static String GetISP()
    {
        String isp = SdkMgr.getInst().getPropStr(ConstProp.SDC_LOG_APP_ISP);
        Utils.log("GetISP isp = " + isp);
        return isp;
    }

    public static String GetOldAccount()
    {
        String old_accountid = SdkMgr.getInst().getPropStr(ConstProp.ORIGIN_GUEST_UID);
        if (old_accountid != null && !"".equals(old_accountid))
        {
            return old_accountid + "@netease_global.win.163.com";
        }

        return "";
    }

    // 设备初始标识符
    public static String GetFirstUDID()
    {
        return GetUdid();
    }

    public static String GetDrpfJson(Context myCtx, String operation,JSONObject dataJson)
    {
        JSONObject obj = new JSONObject();
        try
        {
            obj.put("project", Defines.JF_LOGPROJECT_ID);
            obj.put("type", operation);
            obj.put("source", "netease_p1");
            obj.put("active_time", GetActiveTime());
            obj.put("ip", GetIp(myCtx));
            obj.put("device_model", GetDeviceMode());
            obj.put("os_name", GetOsName());
            obj.put("os_ver", GetOsVersion());
            obj.put("udid", GetUdid());
            obj.put("app_channel", GetAppChannel());
            obj.put("imei", GetIMEI(myCtx));
            obj.put("transid", GetTransid());
            obj.put("unisdk_deviceid", GetUnisdkDeviceid());
            obj.put("is_emulator", IsEnulator(myCtx));
            obj.put("is_root", IsDeviceRooted());
            obj.put("oaid", GetOAID());
            obj.put("engine_ver", GetEngineVersion());
            obj.put("first_udid", GetFirstUDID());
            obj.put("network", GetNetwork());
            if (!GetCountryCode().equals(""))
            {
                obj.put("country_code", GetCountryCode());
            }

            if (dataJson != null)
            {
                if (dataJson.has("app_ver"))
                {
                    dataJson.remove("app_ver");
                    dataJson.put("app_ver", GetAppVersion());
                }

                return  combineJson(obj, dataJson).toString();
            }

            return obj.toString();

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return obj.toString();
    }

    public static JSONObject combineJson(JSONObject srcObj, JSONObject addObj) throws JSONException
    {
        Iterator<String> itKeys1 = addObj.keys();
        String key = "";
        Object value = null;
        while(itKeys1.hasNext()){
            key = itKeys1.next();
            value = addObj.opt(key);
            srcObj.put(key, value);
        }
        Utils.log("srcObj json = " + srcObj.toString());
        return srcObj;
    }

    public static String GetAccountType()
    {
        return SdkMgr.getInst().getAuthTypeName();
    }

    public static String GetDrpfBaseJson()
    {
        JSONObject obj = new JSONObject();
        try
        {
            obj.put("ip", GetIp(Utils.GetContext()));
            obj.put("device_model", GetDeviceMode());
            obj.put("os_name", GetOsName());
            obj.put("os_ver", GetOsVersion());
            obj.put("udid", GetUdid());
            obj.put("app_channel", GetAppChannel());
            obj.put("imei", GetIMEI(Utils.GetContext()));
            obj.put("transid", GetTransid());
            obj.put("unisdk_deviceid", GetUnisdkDeviceid());
            obj.put("is_emulator", IsEnulator(Utils.GetContext()));
            obj.put("is_root", IsDeviceRooted());
            obj.put("oaid", GetOAID());
            obj.put("engine_ver", GetEngineVersion());
            obj.put("first_udid", GetFirstUDID());
            obj.put("network", GetNetwork());
            obj.put("app_ver", GetAppVersion());
            obj.put("country_code", GetCountryCode());
            obj.put("account_type",GetAccountType());
            obj.put("device_height", GetDeviceHeight());
            obj.put("device_width", GetDeviceWidth());
            obj.put("isp", GetISP());
            obj.put("old_accountid", GetOldAccount());

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        Utils.log("GetDrpfBaseJson =" + obj.toString());
        return obj.toString();
    }


    public static String GetFpsDrpfJson(Context myCtx, String operation,JSONObject dataJson)
    {
        JSONObject obj = new JSONObject();
        try
        {
            obj.put("project", Defines.JF_LOGPROJECT_ID);
            obj.put("type", operation);
            obj.put("source", "netease_p1");
            obj.put("ip", GetIp(myCtx));
            obj.put("device_model", GetDeviceMode());
            obj.put("os_name", GetOsName());
            obj.put("os_ver", GetOsVersion());
            obj.put("udid", GetUdid());
            obj.put("app_channel", GetAppChannel());
            obj.put("network", GetNetwork());
            obj.put("server", SdkMgr.getInst().getPropStr(ConstProp.USERINFO_HOSTID));
            obj.put("account_id",Utils.GetAccountId());
            obj.put("old_accountid", GetOldAccount());
            obj.put("role_id",SdkMgr.getInst().getPropStr(ConstProp.USERINFO_UID));
            obj.put("role_name",SdkMgr.getInst().getPropStr(ConstProp.USERINFO_NAME));
            if (!GetCountryCode().equals(""))
            {
                obj.put("country_code", GetCountryCode());
            }
            obj.put("oaid", GetOAID());
            obj.put("engine_ver", GetEngineVersion());
            obj.put("is_emulator", IsEnulator(myCtx));
            obj.put("isp", GetISP());
            obj.put("transport_type", "tcp");


            if (dataJson != null)
            {
                if (dataJson.has("app_ver"))
                {
                    dataJson.remove("app_ver");
                    dataJson.put("app_ver", GetAppVersion());
                }

                return  combineJson(obj, dataJson).toString();
            }

            return obj.toString();

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return obj.toString();
    }

    public static String GetPlayerDrpfJson(Context myCtx)
    {
        JSONObject obj = new JSONObject();
        try
        {
            obj.put("server", SdkMgr.getInst().getPropStr(ConstProp.USERINFO_HOSTID));
            obj.put("role_id",SdkMgr.getInst().getPropStr(ConstProp.USERINFO_UID));
            return obj.toString();

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return obj.toString();
    }


}
