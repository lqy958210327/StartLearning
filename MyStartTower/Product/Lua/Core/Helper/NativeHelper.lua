local PermissionManager = Framework.Plugin.PermissionManager
local DeviceHelper = require("Core/Helper/DeviceHelper")

local NativeHelper = {}
local self = NativeHelper

local ANDROID_PERMISSION = {}
local IOS_PERMISSION = {}

local ANDROID_ENUM = {}
local IOS_ENUM = {}

local ANDROID_RATIONALE = {}
local ANDROID_SETTING_RATIONALE = {}
local IOS_RATIONALE = {}
local PERMISSION_REASON = {}

self.ANDROID_PERMISSION = ANDROID_PERMISSION
self.IOS_PERMISSION = IOS_PERMISSION
self.ANDROID_RATIONALE = ANDROID_RATIONALE
self.IOS_RATIONALE = IOS_RATIONALE
self.PERMISSION_REASON = PERMISSION_REASON

ANDROID_PERMISSION.READ_PHONE_STATE = "android.permission.READ_PHONE_STATE"
ANDROID_PERMISSION.RECORD_AUDIO = "android.permission.RECORD_AUDIO"
ANDROID_PERMISSION.CAMERA = "android.permission.CAMERA"
ANDROID_PERMISSION.ACCESS_FINE_LOCATION = "android.permission.ACCESS_FINE_LOCATION"
ANDROID_PERMISSION.READ_EXTERNAL_STORAGE = "android.permission.READ_EXTERNAL_STORAGE"
ANDROID_PERMISSION.WRITE_EXTERNAL_STORAGE = "android.permission.WRITE_EXTERNAL_STORAGE"

ANDROID_ENUM[ANDROID_PERMISSION.CAMERA] = 39
ANDROID_ENUM[ANDROID_PERMISSION.READ_EXTERNAL_STORAGE] = 59
ANDROID_ENUM[ANDROID_PERMISSION.WRITE_EXTERNAL_STORAGE] = 60

-- IOS_PERMISSION.CALENDARS = "NSCalendars"
-- IOS_PERMISSION.REMINDERS = "NSReminders"
IOS_PERMISSION.CAMERA = "NSCamera"
IOS_PERMISSION.MICROPHONE = "NSMicrophone"
IOS_PERMISSION.PHOTOLIBRARY = "NSPhotoLibrary"
IOS_PERMISSION.CONTACTS = "NSContacts"
IOS_PERMISSION.LOCATIONALWAYS = "NSLocationAlways"
IOS_PERMISSION.LOCATIONWHENINUSE = "NSLocationWhenInUse"

IOS_ENUM[IOS_PERMISSION.CAMERA] = 2
IOS_ENUM[IOS_PERMISSION.MICROPHONE] = 3
IOS_ENUM[IOS_PERMISSION.PHOTOLIBRARY] = 4
IOS_ENUM[IOS_PERMISSION.CONTACTS] = 5
IOS_ENUM[IOS_PERMISSION.LOCATIONALWAYS] = 6
IOS_ENUM[IOS_PERMISSION.LOCATIONWHENINUSE] = 7

PERMISSION_REASON.PHOTO = "PERMISSION_REASON_PHOTO"
PERMISSION_REASON.SDK = "PERMISSION_REASON_SDK"

local RATIONALE_CAMERA = "为了使用AR功能，需要您授予相机权限"
local RATIONALE_STORAGE_PHOTO = "为了使截图能保存到相册，需要您授予存储权限"
local RATIONALE_STORAGE_SDK = "为了能正常使用账号功能，需要您授予存储权限"
local SETTING_RATIONALE_CAMERA = "如果没有相机权限，将无法开启AR功能，是否前往设置开启权限？"
local SETTING_RATIONALE_STORAGE_PHOTO = "如果没有存储权限，将无法把截图保存到相册，是否前往设置开启权限？"
local SETTING_RATIONALE_STORAGE_SDK = "如果没有存储权限，将无法正常使用账号功能，是否前往设置开启权限？"


ANDROID_RATIONALE[ANDROID_PERMISSION.CAMERA] = RATIONALE_CAMERA
ANDROID_RATIONALE[ANDROID_PERMISSION.WRITE_EXTERNAL_STORAGE] = {
    [PERMISSION_REASON.PHOTO] = RATIONALE_STORAGE_PHOTO,
    [PERMISSION_REASON.SDK] = RATIONALE_STORAGE_SDK,
}

IOS_RATIONALE[IOS_PERMISSION.CAMERA] = RATIONALE_CAMERA
IOS_RATIONALE[IOS_PERMISSION.PHOTOLIBRARY] = RATIONALE_STORAGE_PHOTO

ANDROID_SETTING_RATIONALE[ANDROID_PERMISSION.CAMERA] = SETTING_RATIONALE_CAMERA
ANDROID_SETTING_RATIONALE[ANDROID_PERMISSION.WRITE_EXTERNAL_STORAGE] = {
    [PERMISSION_REASON.PHOTO] = SETTING_RATIONALE_STORAGE_PHOTO,
    [PERMISSION_REASON.SDK] = SETTING_RATIONALE_STORAGE_SDK,
}

NativeHelper._permissionReason = {}
---- Permission ------------------------------------------

---- 说明 ------------------------------
-- Android的权限申请分为三种情况
-- 1. 第一次申请，直接弹出系统的权限弹框
-- 2. 曾经拒绝但没有勾选never ask again，申请时会弹出一个自定义弹框，说明申请原因，玩家确认后再弹出系统的权限弹框
-- 3. 曾经拒绝且勾选never ask again，申请时弹出一个自定义弹框，说明前往设置界面，玩家确认后打开该应用的权限设置界面

function NativeHelper.initPermissionRationale()
    for permission, _ in pairs(ANDROID_RATIONALE) do
        self._prepareAndroidRationale(permission, nil)
    end
    for permission, _ in pairs(IOS_RATIONALE) do
        self._prepareIOSRationale(permission, nil)
    end
end

function NativeHelper.checkCameraPermission()
    local granted = true
    if DeviceHelper.isAndroid() then
        if not PermissionManager.IsAndroidPermissionGrantedUnity(ANDROID_PERMISSION.CAMERA) then
            if VersionUtils.hasAbilityPermissionV2() then
                PermissionManager.RequestAndroidPermission(ANDROID_PERMISSION.CAMERA, nil, nil)
            else
                PermissionManager.RequestPermissionUnity(ANDROID_PERMISSION.CAMERA)
            end
            granted = false
        end
    elseif DeviceHelper.isIOS() then
        if not PermissionManager.IsIOSPermissionGranted(IOS_ENUM[IOS_PERMISSION.CAMERA]) then
            PermissionManager.RequestIOSPermission(IOS_PERMISSION.CAMERA)
            granted = false
        end
    end
    print("checkCameraPermission", granted)
    return granted
end

function NativeHelper.checkExternalWritePermission(reason)
    if reason == nil then
        reason = PERMISSION_REASON.PHOTO
    end
    local permission = ANDROID_PERMISSION.WRITE_EXTERNAL_STORAGE

    local granted = true
    if DeviceHelper.isAndroid() then
        if not PermissionManager.IsAndroidPermissionGrantedUnity(permission) then
            self._setPermissionReason(permission, reason)
            self._prepareAndroidRationale(permission, reason)
            PermissionManager.RequestAndroidPermission(permission)
            granted = false
        end
    end
    print("checkExternalWritePermission", granted)
    return granted
end

function NativeHelper.onAndroidPermissionResult(permissionList, grantedList)
    print("onAndroidPermissionResult", permissionList, grantedList)
    if permissionList then
        for i, permission in ipairs(permissionList) do
            local granted = (grantedList and grantedList[i]) == "0"
            self._onAndroidPermissionResult(permission, granted)
        end
    end
end

function NativeHelper._onAndroidPermissionResult(permission, granted)
    print("_onAndroidPermissionResult", permission, granted)
    if not IS_PUBLISH_VERSION then
        MsgManager.notice(permission .. tostring(granted))
    end
    if not granted then
        local shouldShowRationale = PermissionManager.ShouldShowRationaleAndroid(permission)
        if not shouldShowRationale then
            -- 拒绝且不用解释，也就是never ask again的情况，这个时候跳转到Setting界面
            local reason = self._getPermissionReason(permission)
            local rationale = self._getRationale(ANDROID_SETTING_RATIONALE, permission, reason)
            print(rationale)
            if rationale then
                PermissionManager.ShowAppSetting("提示", rationale, nil, nil)
            end
        end
    end
end

function NativeHelper._prepareAndroidRationale(permission, reason)
    if not VersionUtils.hasAbilityPermissionV2() then
        return
    end
    local enum = ANDROID_ENUM[permission]
    local rationale = self._getRationale(ANDROID_RATIONALE, permission, reason)
    if enum and rationale then
        PermissionManager.SetAndroidRationale(enum, rationale)
    end
end

function NativeHelper._prepareIOSRationale(permission, reason)
    if not VersionUtils.hasAbilityPermissionV2() then
        return
    end
    local enum = IOS_ENUM[permission]
    local rationale = self._getRationale(IOS_RATIONALE, permission, reason)
    if enum and rationale then
        PermissionManager.SetIOSRationale(enum, rationale)
    end
end

function NativeHelper._setPermissionReason(permission, reason)
    self._permissionReason[permission] = reason
end

function NativeHelper._getPermissionReason(permission)
    return self._permissionReason[permission]
end

function NativeHelper._getRationale(rationaleDict, permission, reason)
    local entry = rationaleDict[permission]
    local entryType = type(entry)
    if entryType == "string" then
        return entry
    elseif entryType == "table" then
        if reason then
            return entry[reason]
        end
    end
    return nil
end
---- Permission end ------------------------------------------

---- Emulator begin ------------------------------------------

self._isEmulator = false
self._isEmulatorChecked = false

function NativeHelper.preCheckEmulator( afterCheckCallback )
    if VersionUtils.hasAbilityEmulatorCheck(  ) then
        if not self._isEmulatorChecked then
            self.checkedCallback = afterCheckCallback
        end
        return self._isEmulatorChecked
    else
        return true
    end
end

function NativeHelper.checkEmulator()
    if VersionUtils.hasAbilityEmulatorCheck() then
        Framework.Device.EmulatorUtils.CheckEmulator(self._onEmulatorResult)
    end
end

function NativeHelper.isEmulator()
    return self._isEmulator
end

function NativeHelper._onEmulatorResult(retNum)
    self._isEmulator = retNum == 1
    self._isEmulatorChecked = true
    if self.checkedCallback then
        self.checkedCallback()
        self.checkedCallback = nil
    end
end

---- Emulator end ------------------------------------------


return NativeHelper