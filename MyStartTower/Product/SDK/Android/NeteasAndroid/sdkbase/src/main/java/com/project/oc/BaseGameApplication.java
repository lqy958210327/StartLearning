package com.project.oc;

import android.app.Application;
import android.content.Context;

import com.netease.ntunisdk.application.NtSdkApplication;
import com.netease.ntunisdk.base.ApplicationHandler;

public class BaseGameApplication extends NtSdkApplication
{
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        Utils.SetContext(base);
        Utils.log("BaseGameApplication attachBaseContext");
        ApplicationHandler.handleOnApplicationAttachBaseContext(base, this);
        PluginManager.getInstance().onApplicationAttachBaseContext(this, base);
    }

    @Override
    public void onCreate() {
        super.onCreate();
        Utils.log("BaseGameApplication onCreate");
        ApplicationHandler.handleOnApplicationOnCreate(getApplicationContext(), this);
        PluginManager.getInstance().onApplicationCreate(this);
    }
}
