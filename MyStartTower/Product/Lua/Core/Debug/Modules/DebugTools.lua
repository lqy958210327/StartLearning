local DebugConst = require("Core/Debug/DebugConst")
local mri = require("Core/Debug/MemoryReferenceInfo")
local ChatService = require("Core/Network/ChatService")
--local PluginManager = require("Core/SDK/Plugin/PluginManager")
local NetService = require("Core/Network/NetService")
local DebugHelper = DebugHelper
local CounterHelper = CS.Externals.Helper.CounterHelper

local DebugModule = {}
--入口中文描述
DebugModule.ENTRY_NAME = "程序工具"

-- Lua内存记录功能
local preLuaSnapshot = nil
local preFuncSnapShot = nil
local preUserdataSnapShot = nil
function DebugModule.snapshotLuaMemory(sender, menu, value)
    -- 首先统计Lua内存占用的情况
    print("GC前, Lua内存为:", collectgarbage("count"))
    DebugHelper.GCCShap()
    collectgarbage("collect")
    print("GC后, Lua内存为:", collectgarbage("count"))
    local curLuaSnapshot, curFuncSnapShot, curUserdataSnapShot = mri.m_cMethods.DumpMemorySnapshot("./", "AllMemoryRef", -1, nil, nil, preLuaSnapshot, preFuncSnapShot, preUserdataSnapShot)
    for typeName, info in pairs(curLuaSnapshot) do
        local nowCount = info[1]
        print("对象:"..typeName.."数量:"..nowCount)
    end
    preLuaSnapshot = curLuaSnapshot
    preFuncSnapShot = curFuncSnapShot
    preUserdataSnapShot = curUserdataSnapShot
    DebugHelper.GCCShap()
    collectgarbage("collect")
    print("分析后, Lua内存为:", collectgarbage("count"))
end

function DebugModule.testRecharge(sender, menu, value)
end

--打开画彩虹logui
function DebugModule.openDebugLogUI(sender, menu, value)
    DebugHelper.OpenDebugLogUI()
end

function DebugModule.LogDiamondCount(sender, menu, value)
end

-- 模拟登陆
function DebugModule.testLogin(sender, menu, value)
    SDKAgent.testSDKLogin(value)
end

-- 隐藏UI
function DebugModule.hideUI(sender, menu)
    --local root = UnityEngine.GameObject.Find("UIRoot")
    --if root then
    --    root:SetActive(false)
    --end
    local UIUtils = CS.Framework.UI.UIUtils
    coroutine.start(function()
        UIUtils.SetUIEnabled(false)
        coroutine.wait(10)
        UIUtils.SetUIEnabled(true)
    end)
end

local _hideScene = false
function DebugModule.hideScene(sender, menu)
    _hideScene = not _hideScene
    if CS.UnityEngine.GameObject.Find("SceneRoot") then
        DebugHelper.SetSceneRoot(CS.UnityEngine.GameObject.Find("SceneRoot"));
    end
    if DebugHelper.SceneRoot then DebugHelper.SceneRoot:SetActive(not _hideScene) end
    CS.Framework.SceneSystem.SceneSettingsManager.ActiveRoot(not _hideScene)

    return _hideScene and "显示场景" or "隐藏场景"
end

local _hideEntity = false
function DebugModule.hideEntity(sender, menu)
    _hideEntity = not _hideEntity
    if CS.UnityEngine.GameObject.Find("ModelRoot") then
        DebugHelper.SetModelRoot(CS.UnityEngine.GameObject.Find("ModelRoot"));
    end
    if DebugHelper.ModelRoot then DebugHelper.ModelRoot:SetActive(not _hideEntity) end

    return _hideEntity and "显示角色" or "隐藏角色"
end

local _hideNewEffect = false
function DebugModule.hideNewEffect(sender, menu)
    _hideNewEffect = not _hideNewEffect
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppFast = cam:GetComponent("PostProcessingBehaviour") -- 获取 PostProcessFast 组件
    if ppFast ~= nil then
        ppFast.enabled = _hideNewEffect; -- 激活 PostProcessFast
    end
    return _hideNewEffect and "隐藏V1新后效" or "开启V1新后效"
end

local _hideNewEffect0 = false
function DebugModule.hideNewEffect0(sender, menu)
    _hideNewEffect0 = not _hideNewEffect0
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppFast = cam:GetComponent("PostProcessFast") -- 获取 PostProcessFast 组件
    if ppFast ~= nil then
        ppFast.enabled = _hideNewEffect0; -- 激活 PostProcessFast
    end
    return _hideNewEffect0 and "隐藏新后效" or "开启新后效"
end

local _toggleBoxCollider = true
function DebugModule.toggleBoxCollider(sender, menu)
    _toggleBoxCollider = not _toggleBoxCollider
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local boxCollider = cam:GetComponent(typeof(CS.UnityEngine.BoxCollider)) -- 获取 BoxCollider 组件
    if boxCollider ~= nil then
        boxCollider.enabled = _toggleBoxCollider; -- 切换 BoxCollider 的状态
    end
    return _toggleBoxCollider and "禁用 BoxCollider" or "启用 BoxCollider"
end

local _hidePostProcessLayer = false
function DebugModule.hidePostProcessLayer(sender, menu)
    _hidePostProcessLayer = not _hidePostProcessLayer
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppLayer = cam:GetComponent(typeof(CS.UnityEngine.Rendering.PostProcessing.PostProcessLayer))
    if ppLayer ~= nil then
        ppLayer.enabled = not _hidePostProcessLayer
    end
    return _hidePostProcessLayer and "显示PostProcessLayer" or "隐藏PostProcessLayer"
end

local _hideCameraPP = false
function DebugModule.hideCameraPP(sender, menu)
    _hideCameraPP = not _hideCameraPP
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppVolume = cam:GetComponent(typeof(CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume))
    if ppVolume ~= nil then
        ppVolume.enabled = not _hideCameraPP;
    end
    return _hideCameraPP and "显示后效" or "隐藏后效"
end

local _hideCameraBloom = false
function DebugModule.hideCameraBloom(sender, menu)
    _hideCameraBloom = not _hideCameraBloom
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppVolume = cam:GetComponent(typeof(CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume))
    if ppVolume ~= nil then
        local bloom = DebugHelper.GetBloom(ppVolume.profile)
        if bloom ~= nil then
            bloom.active = not _hideCameraBloom
        end
    end
    return _hideCameraBloom and "显示Bloom" or "隐藏Bloom"
end

local _hideV1Bloom = false
function DebugModule.hideNewEffectBloom(sender, menu)
    _hideV1Bloom = not _hideV1Bloom
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppBehaviour = cam:GetComponent(typeof(CS.UnityEngine.PostProcessing.PostProcessingBehaviour))
    if ppBehaviour ~= nil then
        local bloomModel = ppBehaviour.profile.bloom
        if bloomModel ~= nil then
            bloomModel.enabled = not _hideV1Bloom
        end
    end
    return _hideV1Bloom and "开启新后效Bloom" or "关闭新后效Bloom"
end

local _hideV1AO = false
function DebugModule.hideNewEffectAO(sender, menu)
    _hideV1AO = not _hideV1AO
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppBehaviour = cam:GetComponent(typeof(CS.UnityEngine.PostProcessing.PostProcessingBehaviour))
    if ppBehaviour ~= nil then
        local aoModel = ppBehaviour.profile.ambientOcclusion
        if aoModel ~= nil then
            aoModel.enabled = not _hideV1AO
        end
    end
    return _hideV1AO and "开启V1版AO" or "关闭V1版AO"
end


local _hideV1LUT = false
function DebugModule.hideNewEffectLUT(sender, menu)
    _hideV1LUT = not _hideV1LUT
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppBehaviour = cam:GetComponent(typeof(CS.UnityEngine.PostProcessing.PostProcessingBehaviour))
    if ppBehaviour ~= nil then
        local userLut = ppBehaviour.profile.depthOfField
        if userLut ~= nil then
            userLut.enabled = not _hideV1LUT
        end
    end
    return _hideV1LUT and "开启V1版LUT" or "关闭V1版LUT"
end

local _useNewShader = false
function DebugModule.changeShader(sender, menu)
    _useNewShader = not _useNewShader
    local newShader = CS.UnityEngine.Shader.Find("OCgame/TestChar")
    local oldShader = CS.UnityEngine.Shader.Find("OCgame/CharacterPBR")
    if newShader == nil or oldShader == nil then
        print("Shader not found: ")
        return
    end

    local allRenderers = CS.UnityEngine.Resources.FindObjectsOfTypeAll(typeof(CS.UnityEngine.Renderer))
    for i = 0, allRenderers.Length - 1 do
        local renderer = allRenderers[i]
        if renderer.sharedMaterial  ~= nil and renderer.sharedMaterial.shader == newShader and not _useNewShader then
            renderer.sharedMaterial.shader = oldShader
        elseif renderer.sharedMaterial  ~= nil and renderer.sharedMaterial.shader == oldShader and _useNewShader then
            renderer.sharedMaterial.shader = newShader
        end
    end
    return _useNewShader and "使用原shader" or "使用新shader"
end

local _hideCameraCG = false
function DebugModule.hideCameraCG(sender, menu)
    _hideCameraCG = not _hideCameraCG
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppVolume = cam:GetComponent(typeof(CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume))
    if ppVolume ~= nil then
        local colorGrading = DebugHelper.GetColorGrading(ppVolume.profile)
        if colorGrading ~= nil then
            colorGrading.active = not _hideCameraCG
        end
    end
    return _hideCameraCG and "显示Color Grading" or "隐藏Color Grading"
end

local _hideCameraV = false
function DebugModule.hideCameraV(sender, menu)
    _hideCameraV = not _hideCameraV
    local cam = CS.Framework.CameraSystem.CameraManager.GetMainCamera();
    if (CS.UnityEngine.GameObject.Find("StageCamera") ~= nil) then
        cam = CS.UnityEngine.GameObject.Find("StageCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
    end

    local ppVolume = cam:GetComponent(typeof(CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume))
    if ppVolume ~= nil then
        local vignette = DebugHelper.GetVignette(ppVolume.profile)
        if vignette ~= nil then
            vignette.active = not _hideCameraV
        end
    end
    return _hideCameraV and "显示Vignette" or "隐藏Vignette"
end

local _hideObject = false
function DebugModule.hideObject(sender, menu, value)

    _hideObject = not _hideObject
    local hideObject = CS.UnityEngine.GameObject.Find(value)
    if (hideObject ~= nil) then DebugHelper.SetSceneObject(hideObject) end
    if DebugHelper.SceneObject then DebugHelper.SceneObject:SetActive(not _hideObject) end
end

local _hideShadowCamera = false
function DebugModule.hideShadowCamera(sender, menu)
    _hideShadowCamera = not _hideShadowCamera
    local shadowCamera = CS.UnityEngine.GameObject.Find("ShadowCamera")
    if shadowCamera ~= nil then DebugHelper.SetShadowCamera(shadowCamera) end
    if DebugHelper.ShadowCamera then DebugHelper.ShadowCamera:SetActive(not _hideShadowCamera) end
    return _hideShadowCamera and "显示ShadowCamera" or "隐藏ShadowCamera"
end






function DebugModule.openRelicUpgradeResult(sender, menu, value)
    --local relicUpgradeResultDlg = UIManager.getUI("relicUpgradeResultDlg",true)
    local upServerData = {}
    upServerData.id = 710003
    upServerData.level = 1
    --relicUpgradeResultDlg:setRelic(upRelic)
end

function DebugModule.openActivityBingoEfx(sender, menu, value)
    --local activityBingoEfxDlg = UIManager.getUI("activityBingoEfxDlg",nil,false)
    --if false then
    --    --activityBingoEfxDlg:setVisible(false)
    --else
    --    --local activityBingoEfxDlg = UIManager.getUI("activityBingoEfxDlg",true)
    --end
end

DebugModule._chatToken = nil


function DebugModule.disconnectWS(sender, menu, value)
    if nil == DebugModule._chatToken then
        DebugModule._chatToken = ChatService._token
    end
    ChatService.disconnect()
end



function DebugModule.setLoaderLinger(sender, menu, value)
    local time = tonumber(value) or 0
    Framework.Resource.LoaderFactory.LingerMaxTime = time
    MsgManager.notice("LingerMaxTime:" .. tostring(time))
end



function DebugModule.openUrl(sender, menu, value)
    local WebView = require("Core/SDK/Plugin/WebView")
    if not value then
        WebView.unityOpenUrl("http://www.163.com")
    else
        WebView.unityOpenUrl(value)
    end
end





function DebugModule.checkEmulator()
    local NativeHelper = require("Core/Helper/NativeHelper")
    NativeHelper.checkEmulator()
end




function DebugModule.capture(sender, menu, value)
    --local captureDlg = UIManager.getUI("captureDlg", true)
    --captureDlg:capture(nil, { ["frameType"] = 0 })
end

DebugModule._md5Async = false


function DebugModule.testSvrMark(sender, menu, value)
    NetService._testSvrMark = true
end

function DebugModule.testDisconnect(sender, menu, value)
    NetService.testDisconnect = true
end

function DebugModule.forceCrash(sender, menu, value)
    Framework.Tools.LuaToolkit.ForceCrash(tonumber(value))
end

local _hideFPS = IsNull(CounterHelper.Counter)
function DebugModule.hideFPS(sender, menu, value)
    _hideFPS = not _hideFPS
    CounterHelper.ActiveCounter(not _hideFPS)
    return _hideFPS and "显示FPS" or "隐藏FPS"
end

local debugEntry
function DebugModule.hideDebug(sender, menu, value)
    debugEntry = debugEntry or UnityEngine.GameObject.Find("DebugEntry")
    if debugEntry then
        debugEntry:SetActive(not debugEntry.activeSelf)
    end
end

function DebugModule.openPoco(sender, menu, value)
    local obj = UnityEngine.GameObject.Find("PocoManager")
    if obj then
        local poco = obj.transform:Find("PocoChild")
        if poco then
            local isActive = poco.gameObject.activeSelf
            poco.gameObject:SetActive(not isActive)
            if isActive then
                MsgManager.notice("关闭Poco")
            else
                MsgManager.notice("开启Poco")
            end
        end
    end
end

function DebugModule.openRank(sender, menu, value)
    --local ui = UIManager.createUI("rentTaskWriteLetterDlg", true)
    --ui:setData()
end

-- function DebugModule.openRank(sender, menu, value)
--     local ui = UIManager.createUI("rentTaskReceiveLetterDlg", true)
-- end



DebugModule._gcTimer = nil
function DebugModule.switchGC(sender, menu, value)
    if DebugModule._gcTimer then
        DebugModule._gcTimer:Stop()
        DebugModule._gcTimer = nil
    else
        DebugModule._gcTimer = Timer.New(Framework.Tools.LuaToolkit.UnityGC, 60, -1)
        DebugModule._gcTimer:Restart()
    end
    MsgManager.notice(DebugModule._gcTimer and "开启定时GC" or "关闭定时GC")
end

--function DebugModule.writeAVGNPCName()
--    local ResTalk = require "Core/ClientData/ResTalk"
--    local ResTalkNpc = DataTable.ResTalkNpc
--    local talkNameDic = {}
--    for _,talkInfo in pairs(ResTalk) do
--        if talkInfo.talk then
--            if talkInfo.npc_id then
--                talkNameDic[talkInfo.talk] = ResTalkNpc[talkInfo.npc_id].name
--            else
--                talkNameDic[talkInfo.talk] = "旁白"
--            end
--        end
--    end
--    local talkNameJson = ClientUtils.table2String(talkNameDic)
--    local file = io.open("TalkNameDic.json", "w")
--    file:write(talkNameJson)
--    file:close()
--end

DebugModule._speedUpTimer = nil
DebugModule._speedUpValue = nil
function DebugModule.speedUp(sender, menu, value)
    if DebugModule._speedUpTimer then
        DebugModule._speedUpTimer:Stop()
        DebugModule._speedUpTimer = nil
        UnityEngine.Time.timeScale = 1
        MsgManager.notice("关闭加速")
    else
        DebugModule._speedUpValue = tonumber(value) or 5
        DebugModule._speedUpTimer = Timer.New(DebugModule._onSpeedTick, 0.5, -1)
        DebugModule._speedUpTimer:Start()
        MsgManager.notice("开启加速")
    end

end

function DebugModule._onSpeedTick()
    UnityEngine.Time.timeScale = DebugModule._speedUpValue
end

function DebugModule.isEmulator()
    --调用
    local SDKImpByted = require("Core/SDK/SDKImp/SDKImpByted")
    SDKImpByted:isEmulator()
end

--功能列表
DebugModule.FUNC_MENU = {
    -- {name = "Lua内存快照", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.snapshotLuaMemory},
    -- {name = "测试支付", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.testRecharge},
    -- {name = "查看log界面", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.openDebugLogUI},
    -- {name = "模拟登陆", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.testLogin},
    { name = "隐藏UI(10s)", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.hideUI },
    { name = "隐藏场景", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideScene },
    { name = "隐藏角色", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideEntity },
    { name = "隐藏后效", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideCameraPP },
    { name = "隐藏Bloom", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideCameraBloom },
    { name = "隐藏Color Grading", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideCameraCG },
    { name = "隐藏Vignette", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideCameraV },
    { name = "隐藏PostProcessLayer", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hidePostProcessLayer },
    { name = "隐藏ShadowCamera", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideShadowCamera },
    { name = "开启新后效", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideNewEffect0 },
    { name = "隐藏对象", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.hideObject },
    { name = "开启V1新后效", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideNewEffect },
    { name = "开启V1新后效AO", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideNewEffectAO },
    { name = "开启V1新后效Bloom", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideNewEffectBloom },
    { name = "开启V1新后效LUT", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideNewEffectLUT },
    { name = "换角色shader", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.changeShader },
    
    -- {name = "切换svrMark", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.switchSvrMark},
    -- {name = "打印当前钻石数量", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.LogDiamondCount},
    -- {name = "全局加速", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.speedUp},
    -- {name = "定时GC", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.switchGC},

    -- {name = "打开获得英雄界面", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.openStarUpAnimation},
    -- -- {name = "打开圣物强化结果", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.openRelicUpgradeResult},
    -- {name = "打开宾果特效界面", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.openActivityBingoEfx},
    -- -- {name = "连接ws", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.connectWS},
    -- -- {name = "断开ws", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.disconnectWS},
    -- -- {name = "ws状态", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.showWSState},
    {name = "设置Loader缓存时间", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.setLoaderLinger},
    -- {name = "内置浏览器", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.testWebView},
    -- {name = "系统浏览器", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.openUrl},
    -- {name = "测试推送", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.testNotification},
    -- {name = "开启Debug登录", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.enableDebugLogin},
    -- {name = "是否是模拟器", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.checkEmulator},

    -- {name = "打开截屏", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.capture},
    -- -- {name = "切换下载检查同/异步", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.changeMD5Async},
    -- {name = "切换后台下载", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.switchBackgroundDownload},
    -- {name = "隐藏/显示Debug", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.hideDebug},
    -- -- {name = "测试悬赏", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.openRank},
    -- {name = "打开/关闭Poco", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.openPoco},
    -- {name = "输出AVG人名", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.writeAVGNPCName},

    -- -- {name = "测试svrMark", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.testSvrMark},

    { name = _hideFPS and "显示FPS" or "隐藏FPS", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.hideFPS },

    -- from DebugGM.lua
    { name = "测试断线", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.testDisconnect },
    { name = "强制崩溃", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.forceCrash },

}

return DebugModule
