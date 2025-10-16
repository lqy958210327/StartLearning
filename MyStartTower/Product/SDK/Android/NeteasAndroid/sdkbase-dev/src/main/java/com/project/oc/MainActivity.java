package com.project.oc;

import android.os.Bundle;

public class MainActivity extends UnityPlayerActivity {

    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        System.out.println("Dev SDK Create");
        CrashHandler.getInstance().init(this);
    }

}
