package com.project.oc;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;

import java.util.ArrayList;

public class PluginManager {
    static PluginManager mInstance = null;
    ArrayList <PluginBase> mPlugins = new ArrayList<PluginBase>();

    SDKBase mSDK = null;
    boolean mIsCreated = false;

    protected PluginManager()
    {
        try {
            Class sdkClass = Class.forName("com.project.oc.SDK");
            Object sdkObject = sdkClass.newInstance();
            mSDK = (SDKBase)sdkObject;
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 最后注册SDK, 防止SDK在其他plugin前初始化导致调用plugin接口失败
        RegisterPlugin(mSDK);
    }

    public static PluginManager getInstance()
    {
        if (mInstance == null)
        {
            mInstance = new PluginManager();
        }
        return mInstance;
    }

    public SDKBase getSDK()
    {
        return mSDK;
    }

    public void RegisterPlugin(PluginBase plugin)
    {
        mPlugins.add(plugin);
    }

    public void onApplicationAttachBaseContext(Application application, Context base) {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onApplicationAttachBaseContext(application, base);
        }
    }

    public void onApplicationCreate(Application application)
    {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onApplicationCreate(application);
        }
    }

    public void onApplicationConfigurationChanged(Application application, Configuration newConfig) {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onApplicationConfigurationChanged(application, newConfig);
        }
    }

    public void onApplicationTerminate(Application application) {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onApplicationTerminate(application);
        }
    }

    public void onApplicationTrimMemory(Application application, int level) {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onApplicationTrimMemory(application, level);
        }
    }

    public void onApplicationLowMemory(Application application) {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onApplicationLowMemory(application);
        }
    }

    public void attachBaseContext(Context newBase) {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).attachBaseContext(newBase);
        }
    }

    public void onCreate(Activity activity, Bundle savedInstanceState)
    {
        mIsCreated = true;

        // 设置activity, 防止在onCreate中调用其他plugin接口时, activity还未赋值
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).setActivity(activity);
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onCreate(activity, savedInstanceState);
        }
    }

    public void onNewIntent(Intent intent)
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onNewIntent(intent);
        }
    }

    public void onDestroy()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onDestroy();
        }
    }

    public void onPause()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onPause();
        }
    }

    public void onResume()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onResume();
        }
    }

    public void onStop()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onStop();
        }
    }

    public void onStart()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onStart();
        }
    }

    public void onRestart()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onRestart();
        }
    }

    public void onBackPressed()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onBackPressed();
        }
    }

    public void onConfigurationChanged(Configuration newConfig)
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onConfigurationChanged(newConfig);
        }
    }

    public void onRestoreInstanceState(Bundle savedInstanceState)
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onRestoreInstanceState(savedInstanceState);
        }
    }

    public void onWindowFocusChanged(boolean hasFocus)
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onWindowFocusChanged(hasFocus);
        }
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onActivityResult(requestCode, resultCode, data);
        }
    }

    public void onSaveInstanceState(Bundle state)
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onSaveInstanceState(state);
        }
    }

    public void onAttachedToWindow()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onAttachedToWindow();
        }
    }

    public void finish()
    {
        if (!mIsCreated)
        {
            return;
        }

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).finish();
        }
    }

    @TargetApi(23)
    public void onRequestPermissionsResult(int requestCode,String[] permissions, int[] grantResults)
    {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onRequestPermissionsResult(requestCode, permissions, grantResults);
        }
    }

    public boolean onGameExitPressed()
    {
        Utils.log("onGameExitPressed");

        for (int i = 0; i < mPlugins.size(); ++i)
        {
            if (mPlugins.get(i).onGameExitPressed())
            {
                Utils.log("onGameExitPressed Swallow by " + mPlugins.get(i).toString());
                return true;
            }
        }

        return false;
    }

    public void onLoginSuccess()
    {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onLoginSuccess();
        }
    }

    public void onGameExited()
    {
        for (int i = 0; i < mPlugins.size(); ++i)
        {
            mPlugins.get(i).onGameExited();
        }
    }

    public void onFirebaseNewToken(Context context, String token)
    {
        if(mPlugins == null) {
            return;
        }

        for(int i = 0; i < mPlugins.size(); i++) {
            PluginBase plugin = mPlugins.get(i);
            if(plugin != null) {
                plugin.onFirebaseNewToken(context, token);
            }
        }
    }
}
