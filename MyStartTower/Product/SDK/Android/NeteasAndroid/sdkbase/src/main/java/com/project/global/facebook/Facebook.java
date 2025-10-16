package com.project.global.facebook;

import com.netease.ntunisdk.base.ConstProp;
import com.netease.ntunisdk.base.SdkMgr;
import com.netease.ntunisdk.base.ShareInfo;
import com.project.oc.Utils;

import org.json.JSONObject;

import java.io.File;

public class Facebook {

    public static void TrackCustomEvent(String event, String jsonStr)
    {
        try
        {
            JSONObject parObj = new JSONObject();
            JSONObject subObj = new JSONObject(jsonStr);
            parObj.put("facebook", subObj.toString());

            Utils.log("facebook json =" + parObj.toString());
            SdkMgr.getInst().ntTrackCustomEvent(event, parObj.toString());
        }
        catch (Exception e)
        {
            Utils.log("facebook Exception e =" + e.toString());
        }

    }

    public static void ShareFunction(String jsonStr)
    {
        Utils.log("Util ShareFunction jsonStr=" + jsonStr);
        try {

            JSONObject jsonData = new JSONObject(jsonStr);
            int type = jsonData.getInt("type");
            int chanel = jsonData.getInt("chanel");
            ShareInfo shareInfo = new ShareInfo();
            //设置fb分享渠道
            if (chanel == 1)
            {
                shareInfo.setShareChannel(ConstProp.NT_SHARE_TYPE_FACEBOOK);
            }
            else if(chanel == 2)
            {
                shareInfo.setShareChannel(ConstProp.NT_SHARE_TYPE_FACEBOOK_MESSENGER);
            }

            switch(type)
            {
                case 1:
                    String url = jsonData.getString("url");
                    String title = jsonData.getString("title");
                    shareInfo.setType(ShareInfo.TYPE_LINK);
                    shareInfo.setLink(url);//待分享的链接
                    shareInfo.setTitle(title);//该字段已失效
                    // shareInfo.setText("副标题");//该字段已失效
                    // 分享链接类型时不再支持设置图片
                    break;
                case 2:
                    //设置分享类型——图片
                    shareInfo.setType(ShareInfo.TYPE_IMAGE);
                    //设置图片可以有两种形式：bitmap或path，二选一即可（如果两个都设置了，优先选取bitmap对象）
                    //bitmap方式：
                    //shareInfo.setShareBitmap(bitmap);//bitmap即为图片的bitmap实例,不超过12M
                    //path方式，仅接受本地图片,不超过12M
                    String path = jsonData.getString("path");
                    Utils.log("shareInfo.setImage jsonpath =" + path);
                    if (path.isEmpty())
                    {
                        path = Utils.GetSharePath();
                    }
                    else
                    {
                        File file = new File(path);
                        if (file.exists())
                        {
                            Utils.log("fileexists 文件存在");
                        }
                        else
                        {
                            Utils.log("fileexists 文件不存在");
                        }
                    }
                    Utils.log("shareInfo.setImage path =" + path);
                    shareInfo.setImage(path);
                    break;
                case 3:
                    shareInfo.setType(ShareInfo.TYPE_GIF);
                    path = jsonData.getString("path");
                    shareInfo.setImage(path);
                    break;
                case 4:
                    //设置分享类型——视频--注意：facebook app不支持预设文案了，分享视频是不显示文本的
                    shareInfo.setType(ShareInfo.TYPE_VIDEO);
                    //仅接受本地视频路径,视频不超过12M
                    path = jsonData.getString("path");
                    shareInfo.setVideoUrl(path);
                    break;
            }

            //最后调用下面方法调起分享功能
            SdkMgr.getInst().ntShare(shareInfo);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }
}
