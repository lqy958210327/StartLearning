package com.project.oc;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;

public class PluginBase {
    protected Activity mActivity;
    protected Application mApplication;

    public void onApplicationAttachBaseContext(Application application, Context base) { mApplication = application;}
    public void onApplicationCreate(Application application) {}
    public void onApplicationConfigurationChanged(Application application, Configuration newConfig) {}
    public void onApplicationTerminate(Application application) {}
    public void onApplicationTrimMemory(Application application, int level) {}
    public void onApplicationLowMemory(Application application) {}
    public void attachBaseContext(Context newBase) {}
    public void onCreate(Activity activity, Bundle savedInstanceState) { mActivity = activity; }
    public void onNewIntent(Intent intent) {}
    public void onDestroy() {}
    public void onPause() {}
    public void onResume() {}
    public void onStop() {}
    public void onStart() {}
    public void onRestart() {}
    public void onBackPressed() {}
    public void onConfigurationChanged(Configuration newConfig) {}
    public void onRestoreInstanceState(Bundle savedInstanceState){}
    public void onWindowFocusChanged(boolean hasFocus) {}
    public void onActivityResult(int requestCode, int resultCode, Intent data) {}
    public void onSaveInstanceState(Bundle state) {}
    public void onAttachedToWindow() {}
    public void finish() {}

    public void onRequestPermissionsResult(int requestCode,String[] permissions, int[] grantResults) {}
    public boolean onGameExitPressed() { return false; }
    public void onGameExited() {}
    public void onLoginSuccess(){}
    public void setActivity(Activity activity) { mActivity = activity; }
    public void onFirebaseNewToken(Context context, String token) {}
}
