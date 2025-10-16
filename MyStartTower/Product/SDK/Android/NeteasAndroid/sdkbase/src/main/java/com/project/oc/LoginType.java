package com.project.oc;

public enum LoginType {
    login,                 // 自动登录/渠道登录(默认UI)
    autoLogin,             // 渠道登录(自定义UI)
    channelLogin,          // 渠道登录(自定义UI)
    migrateCodeLogin,      // 所有模式
    newGuestLogin,         // 所有模式
}
