package com.project.global.facebook;

import com.netease.ntunisdk.base.AccountInfo;
import com.netease.ntunisdk.base.ConstProp;
import com.netease.ntunisdk.base.OnShareListener;
import com.netease.ntunisdk.base.QueryFriendListener;
import com.netease.ntunisdk.base.SdkMgr;
import com.netease.ntunisdk.base.ShareInfo;

import java.util.List;

public class FacbookSDK implements OnShareListener , QueryFriendListener {

    public void ShareFunction()
    {
        //分享代码样例：
        ShareInfo shareInfo = new ShareInfo();
        //设置fb分享渠道
        shareInfo.setShareChannel(ConstProp.NT_SHARE_TYPE_FACEBOOK);

        //设置分享类型——链接
        shareInfo.setType(ShareInfo.TYPE_LINK);
        shareInfo.setLink("https://gamer.163.com");//待分享的链接
        shareInfo.setTitle("标题");//该字段已失效
        shareInfo.setText("副标题");//该字段已失效
        //分享链接类型时不再支持设置图片

        //设置分享类型——图片
        shareInfo.setType(ShareInfo.TYPE_IMAGE);
        //设置图片可以有两种形式：bitmap或path，二选一即可（如果两个都设置了，优先选取bitmap对象）
        //bitmap方式：
        //shareInfo.setShareBitmap(bitmap);//bitmap即为图片的bitmap实例,不超过12M
        //path方式，仅接受本地图片,不超过12M
        shareInfo.setImage("/mnt/sdcard/Android/com.netease.xxx/files/zzz.jpg");

        //设置分享类型——视频
        shareInfo.setType(ShareInfo.TYPE_VIDEO);
        //仅接受本地视频路径,视频不超过12M
        shareInfo.setVideoUrl("/mnt/sdcard/Android/com.netease.xxx/files/yyy.mp4");

        //最后调用下面方法调起分享功能
        SdkMgr.getInst().ntShare(shareInfo);
    }

    @Override
    public void onShareFinished(boolean b) {

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
}
