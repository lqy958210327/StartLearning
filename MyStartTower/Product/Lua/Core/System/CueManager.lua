-----------------------------------
-- 若要正常使用还需要明确的具体事项
-- 1. 逻辑分组的规则，即一个逻辑实体持有的特效该赋予的分组信息，方便按组回收
-- 2. PostProcess的播放和回收  TODO:PostProcess的播放和恢复，要梳理，应充分应用PostProcessProfile
-- 3. Audio的播放和回收
-- 4. 模型特效的播放和回收
-- 5. 生命周期类型为2的情况是否需要保留
-------------------
local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local CueDataBank = EditorTable.CueDataBank
local EffectManager = require("Core/System/EffectManager")
local AudioManager = require "Core/System/AudioManager"
local ModelEffectManager = require "Core/System/ModelEffectManager"

local ImageEffectManager = Framework.EffectSystem.ImageEffectManager
local CameraManager = CameraManager

local Const = Const
local logerror = logerror
local UnityEngine = UnityEngine
local EffectLifeMode = Const.EFFECT_LIFE_MODE
--require("Optimize/Module/Battle/BattleRes/Manager/BattleEffectManager")

local CueManager = {}
local self = CueManager 

function CueManager.initCueManager()
    assert(CueManager._instance == nil, "[ERROR] The CueManager instance is created already!")
    -- 字典key为actorID,value为字典,key是insid,value是特效的归属,一般只用来区分是否为场景特效
    -- actorID为0时代表场景特效
    self.logicGroups = {[0] = true}   -- 生命周期类型为1，0代表场景分组 
    self.logicControlEffects= {}      -- 生命周期类型为2
    -- post process没有写manager,所以都在Cuemanager中了, 后面勤快的可以挪出去,清爽点
    -- 常驻屏幕特效缓存 key为屏幕效果type, value为cueid
    self.postProcessStay = {}
    -- 定时回收屏幕特效缓存,key为type, value为timer
    self.postProcessTimer = {}

    self.audioMgr = AudioManager()
    self.effectMgr = EffectManager()
    self.modelEffectMgr = ModelEffectManager()
    self._initPostProcess()
end

function CueManager.destroy(  )
    self.audioMgr:destroy()
    self.effectMgr:destroy()
    self.modelEffectMgr:destroy()
end

---------------------Cue的播放-----------------------------------------------
function CueManager.shouldPlayCue(cueId, actorIsPlayer, atkerIsPlayer)
    local cueData = CueDataBank.getCueData(cueId)
    -- 如果读不到cue事件信息,则返回false
    if not cueData then
        logerror("Oh shit can't get cue data!Check it ",cueId)
        return false
    end

    -- 如果有可见性检测的东西,则执行检测
    if not cueData["OnlyPlayer"] and not cueData["OnlyAttacker"] then
        return true
    end
    if cueData["OnlyPlayer"] and not cueData["OnlyAttacker"] then
        -- 只勾选了载体客户端可见
        return actorIsPlayer
    elseif not cueData["OnlyPlayer"] and cueData["OnlyAttacker"] then
        -- 只勾选了攻击者客户端可见
        return atkerIsPlayer
    elseif cueData["OnlyPlayer"] and cueData["OnlyAttacker"] then
        -- 同时勾选了两个选项
        local result = atkerIsPlayer or actorIsPlayer
        return result
    end

    return true
end

function CueManager.cueIsAudio( cueId )
    local cueData = CueDataBank.getCueData(cueId)
    if not cueData then
        logerror("Error to find cue Data:",cueId)
        return false
    end
    local cueType = cueData["TypeString"]
    return cueType == "Audio"
end

-- 用于攻击事件里触发的cue，actor为cue的真正播放者，player一般是指施加方，就是攻击者
-- 对于常驻的cue,会返回instance id, 上层如果需要控制则拿这个id进行回收
-- 如果不处理,则会在其所在的分组回收的时候清理
function CueManager.playCue( actor, cueId, player, delayTime )
    local cueData = CueDataBank.getCueData(cueId)
    if not cueData then
        logerror("Error to find cue Data:",cueId)
        return
    end
    local cueType = cueData["TypeString"]
    if cueType == "Effect" then
        return self._playCueEffect(actor, cueData, player, delayTime)
    elseif cueType == "Audio" then
        local audioSource = cueData["AudioCue"]["sourcePath"]
        local volume = cueData["AudioCue"]["volume"]
        local pitch = cueData["AudioCue"]["pitch"]
        local type = cueData["AudioCue"]["type"]
        type = type == nil and Const.AudioType.SFX or type
        if audioSource and audioSource ~= "" then
            if type == Const.AudioType.SFX then
                LuaCallCs.Audio.AudioPlaySFX(audioSource, volume)
            elseif type == Const.AudioType.VOCAL then
                LuaCallCs.Audio.AudioPlayVoice(audioSource, 0, volume)
            end
        end

    elseif cueType == "GroupCue" then
        local cueList = cueData["GroupCue"]["CueList"]
        if cueList and next(cueList)~=nil then
            local insIdList = {}
            for i, elemId in ipairs(cueList) do
                -- 这里改成了直接播放而不进行二次判断
                if elemId ~= cueId then
                    local insId = self.playCue(actor, elemId, player, delayTime)
                    if insId then
                        if type(insId)=="number" then
                            -- 如果这个cue是个普通cue
                            table.insert(insIdList, insId)
                        elseif type(insId)=="table" then
                            -- 如果这个cue是个groupCue
                            for i,tempId in ipairs(insId) do
                                table.insert(insIdList, tempId)
                            end
                        end
                    end
                end
            end
            return insIdList
        end
    elseif cueType == "CueShake" then
        --local shakeSource = cueData["CueShake"]["Source"]
        --if shakeSource and shakeSource~="" then
        --    CameraManager.ScreenShake(shakeSource)
        --end
        local shake = cueData["CueShake"]
        if shake == nil then
            return
        end

        local noise = shake["noise"]
        if noise and noise ~= "" then
            local amplitude = shake["amplitude"]
            local frequency = shake["frequency"]
            local attackTime = shake["attackTime"]
            local sustainTime = shake["sustainTime"]
            local decayTime = shake["decayTime"]
            CameraManager.ScreenShake(noise, amplitude, frequency, attackTime, sustainTime, decayTime)
        end
    elseif cueType == "CueCamera" then
        local cameraSource = cueData["Camera"]["SourcePath"]
        if cameraSource and cameraSource~="" then
            actor:playCamera(cameraSource)
        end
    elseif cueType == "PostProcess" then
        self.playPostProcess(cueId, nil, actor)
    elseif cueType == "ModelEffect" then
        local effectID = cueData["CueID"]
        local effectInfo = cueData["ModelEffect"]
        self.modelEffectMgr:playModelEffect(actor, effectID, effectInfo)
    elseif cueType == "BattleDialog" then
        local dialogId = cueData["BattleDialog"]["DialogId"]
        self.playBattleDialog(actor, dialogId)
    elseif cueType == "SequenceFrame" then
        local sequenceInfo = cueData["SequenceFrame"]
        self.playUIAnimation(sequenceInfo, actor)
        local audios = sequenceInfo["Audios"]
        if audios then
            for _, audio in pairs(audios) do
                if audio then
                    local audioSource = audio["AudioCue"]["sourcePath"]
                    local type = audio["AudioCue"]["type"]
                    type = type == nil and Const.AudioType.SFX or type
                    local volume = audio["AudioCue"]["volume"]
                    local pitch = audio["AudioCue"]["pitch"]
                    local delayTime = audio["AudioCue"]["delayTime"] or 0
                    if audioSource and audioSource ~= "" then
                        local audioAction = nil
                        if type == Const.AudioType.SFX then
                            audioAction = function() LuaCallCs.Audio.AudioPlaySFX(audioSource, volume) end
                        elseif type == Const.AudioType.VOCAL then
                            audioAction = function() LuaCallCs.Audio.AudioPlayVoice(audioSource, 0, volume) end
                        end

                        if audioAction then
                            if delayTime > 0 then
                                LuaCallCs.UniTask.Delay(delayTime * 1000, audioAction, false)
                            else
                                audioAction()
                            end
                        end
                    end
                end
            end
        end
        --local audio = sequenceInfo["Audio"]

    elseif cueType == "TargetCamera" then
        --local targetCameraInfo = cueData["TargetCamera"]
        --self.playTargetCamera(actor, targetCameraInfo)
    end
end

function CueManager.releaseCue( actor, cueId, insId)
    local cueData = CueDataBank.getCueData(cueId)
    local cueType = cueData["TypeString"]
    if cueType == "Effect" then
        self.releaseEffect(insId)
    elseif cueType == "PostProcess" then
        self.stopPostProcess(cueId, nil, actor)
    elseif cueType == "GroupCue" then
        local cueList = cueData["GroupCue"]["CueList"]
        if cueList and #cueList>0 then
            for i, cueid in ipairs(cueList) do
                local cuedata = CueDataBank.getCueData(cueid)
                local cuetype = cuedata["TypeString"]
                if cuetype == "GroupCue" then
                    self.releaseCue(actor, cueid, insId)
                elseif cuetype == "Effect" then
                    if insId and insId[1] then
                        local theInsId = insId[1]
                        self.releaseCue(actor, cueid,theInsId)
                        table.remove(insId,1)
                    end
                else
                    self.releaseCue(actor, cueid)
                end
            end
        end
    elseif cueType == "ModelEffect" then
        local effectID = cueData["CueID"]
        self.modelEffectMgr:recoverModelEffect(actor, effectID)
    elseif cueType == "TargetCamera" then
        self.stopTargetCamera()
    end
end

-------------------Audio-----------------------------------------
function CueManager.setSfxSpeed( speed )
    self.audioMgr:setSfxSpeed(speed)
end

-------------------Effect-----------------------------------------
-- 在逻辑中需要播放飞行或者链接特效，则args要附带target和length信息
--function CueManager.playCueEffect( actor, cueId, target, delayTime, fashionTag )
--    local cueData = CueDataBank.getCueData(cueId)
--    if not cueData then
--        logerror("Can not find cue data:",cueId)
--        return
--    end
--    return self._playCueEffect(actor, cueData, target, delayTime, fashionTag)
--end

-- 根据effect的运动模式调用不同的播放方法
function CueManager._playCueEffect( actor, cueData, target, delayTime )
    if not cueData then
        logerror("Error to find cue data")
        return
    end
    local cueType = cueData["TypeString"]
    if cueType~="Effect" then
        logerror("Effect type Wrong:", cueType)
        return
    end
    local effectCueCfg = cueData["EffectCue"]
    if not effectCueCfg or not effectCueCfg["SourcePath"] then
        LuaCallCs.LogError("---   播放CueEffect异常：EffectCue = nil  or  EffectCue.SourcePath = nil, cueId = "..cueData.CueID)
        return
    end
    local mode = effectCueCfg["motionMode"]
    local insId = nil
    local actorTransform,actorIsGO = self._getActorTransform(actor)
    local logicTag = effectCueCfg["logicTag"] or (not actorIsGO and actor.entityId) or 0
    self.logicGroups[logicTag] = true
    local logicMirror = (not actorIsGO and actor.modelIsMirror) or false
    local guid = ""
    if mode == BattleConst.EFFECT_MODE.Normal then
        --insId = self.effectMgr:playNormalEffectAsync(actorTransform, effectData, EffectLifeMode["LogicControl"], logicTag, logicMirror)
        local effectData = EffectData():WithAssetPath(effectCueCfg["SourcePath"])
        guid = BattleEffectManager.GetFromCache(effectData)
        BattleEffectManager.playNormalEffectAsync(guid, actorTransform, effectCueCfg, EffectLifeMode["LogicControl"], logicTag, logicMirror)

    elseif mode == BattleConst.EFFECT_MODE.Parabola then
        local targetTransform = self._getActorTransform(target)
        if actorTransform and targetTransform and delayTime then
            --insId = self.effectMgr:playThrowEffectAsync(actorTransform, targetTransform, effectCueCfg, delayTime, EffectLifeMode["LogicControl"],logicTag)

            local effectData = EffectData():WithAssetPath(effectCueCfg["SourcePath"])
            guid = BattleEffectManager.GetFromCache(effectData)
            BattleEffectManager.playThrowEffectAsync(guid, actorTransform, targetTransform, effectCueCfg, delayTime, EffectLifeMode["LogicControl"],logicTag)
        end

    elseif mode == BattleConst.EFFECT_MODE.Link then
        local targetTransform = self._getActorTransform(target)
        if actorTransform and targetTransform then

            local effectData = EffectData():WithAssetPath(effectCueCfg["SourcePath"])
            guid = BattleEffectManager.GetFromCache(effectData)
            BattleEffectManager.playLinkEffectAsync(guid, targetTransform, actorTransform, effectCueCfg, EffectLifeMode["LogicControl"], logicTag )
        end
    elseif mode == BattleConst.EFFECT_MODE.Screen then
        -- ui特效
        if Const.SKIP_SCREEN_EFX then 
            return 
        end
        --local effectMirrored = false
        --if actor and not actorIsGO and actor.modelIsMirror then
        --    --effectMirrored = true
        --end

        --local effectPath = effectData["SourcePath"]
        --local playMode = effectData["howToPlay"]

        --local length = 0
        --if playMode == BattleConst.CUE_PLAY_MODE.PlayLength then
        --    length = effectData["playLength"]
        --end

        --insId = CueUIMediator.playUIEffect(effectPath, length, effectMirrored)
    end
    --return insId
    return guid
end

function CueManager.isNormalEffect( cueId )
    local cueData = CueDataBank.getCueData(cueId)
    if cueData and cueData["TypeString"]=="Effect" and 
       cueData["EffectCue"] and cueData["EffectCue"]["motionMode"]==BattleConst.EFFECT_MODE.Normal then
        return true
    end
    return false
end

------------------- 连接特效 -------------------------
-- 暂时只支持两点连接.其实LineRender支持多点连接,但是c#接口没做
function CueManager.playLinkEffect( cueId, startActor, endActor )
    local cueData = CueDataBank.getCueData(cueId)
    local startTransform = self._getActorTransform(startActor)
    local endTransform = self._getActorTransform(endActor)
    if CueManager.isLinkEffect(cueId) and startTransform and endTransform then
        local guid = self._playCueEffect(startActor, cueData, endActor)
        return guid
    else
        return nil
    end
end

function CueManager.isLinkEffect( cueId )
    local cueData = CueDataBank.getCueData(cueId)
    if cueData and cueData["TypeString"]=="Effect" and cueData["EffectCue"] and cueData["EffectCue"]["motionMode"]==BattleConst.EFFECT_MODE.Link then
        return true
    end
    return false
end

-- TODO
function CueManager._getActorTransform( actor )
    if not actor then
        return
    end
    local actorTransform
    local isEntity = false
    local isGO = false
    if type(actor)=="userdata" then
        isGO = true
    elseif actor.entityType then
        isEntity = true
    end

    if isGO then

    else
        if isEntity then
            if actor:isModelLoaded() then
                actorTransform = actor.entityModel:GetModel().transform
            end
        elseif actor.entityModel then
            actorTransform = actor.entityModel:GetModel().transform
        end
    end
    
    if not actorTransform and actor.gameObject then
        -- 如果模型没有加载好,则用actor的GameObject来播放特效
        actorTransform = actor.gameObject.transform
    end
    return actorTransform,isGO
end

function CueManager.releaseEffect( insId )
    --self.effectMgr:releaseEffect(insId)
    BattleEffectManager.ReturnToCache(insId)
end

-- todo
function CueManager.releaseEffectByGroup( logicGroup )
    self.effectMgr:batchReleaseEffects(logicGroup)
end





--------------------------------- Post Process播放函数 ------------------------------
-- enum POSTPROCESSTYPE { Lut, Bloom, RadialBlur, TiltShift, TintColor, BlackOcclusion }
local ImageEffectType = {
    Lut = 0,
    Bloom = 1,
    RadialBlur = 2,
    TiltShift = 3,
    TintColor = 4,
    BlackOcclusion = 5,
    DepthOfField = 6,
    MotionBlur = 7,
    Tonemapping = 8,
}
function CueManager._initPostProcess( ... )
    if not self.postProcessInited then
        self.postProcessInited = true
    end 
end
function CueManager.playPostProcess( cueId, cam, actor )
    CueManager.forceStopDof()
    local cueData = CueDataBank.getCueData(cueId)
    if not cueData["PostProcess"] then
        return
    end
    local effectInfo = cueData["PostProcess"]
    local effectType = effectInfo["type"]
    local fadeIn = effectInfo["fadeIn"]
    local cullingPlayer = effectInfo["cullingPlayer"] or 0
    if cullingPlayer == 2 and actor and actor.entityModel then
        actor.entityModel:setModelLayer(Const.LAYER_MAINPLAYER)
    end
    if effectType==ImageEffectType.Lut then
        -- LUT效果
        local texture = effectInfo["lutParam"]["texturePath"]
        if fadeIn == nil or fadeIn == 0 then
            ImageEffectManager.StartLUT(cam, texture, cullingPlayer)
        else
            local blendParam = { ["LutTexture"] = texture}
            ImageEffectManager.FadeInLUT(cam, blendParam, fadeIn, cullingPlayer)
        end

    elseif effectType == ImageEffectType.Bloom then
        local bloomSettings = effectInfo["bloomParam"]
        local config = {}
        local useColorBloom = bloomSettings["useColorBloom"]
        config["useColorBloom"] = useColorBloom
        if useColorBloom then
            config["colorBloomIntensity"] = bloomSettings["colorBloomIntensity"]
            config["colorBloomR"] = bloomSettings["colorBloomR"]
            config["colorBloomG"] = bloomSettings["colorBloomG"]
            config["colorBloomB"] = bloomSettings["colorBloomB"]
            config["colorBloomBlurTheta"] = bloomSettings["colorBloomBlurTheta"]
        else
            config["intensity"] = bloomSettings["intensity"]
            config["threshold"] = bloomSettings["threshold"]
            config["softKnee"] = bloomSettings["softKnee"]
            config["radius"] = bloomSettings["radius"]
            config["prefilterScale"] = 4
            config["clamp"]= 2
        end
        ImageEffectManager.StartBloom(cam, config)

    elseif effectType ==ImageEffectType.RadialBlur then
        -- RadialBlur效果
        local blurStrength = effectInfo["radialBlurParam"]["blurStrength"] or 4.0
        local sampleDist = effectInfo["radialBlurParam"]["sampleDist"] or 0.5
        local centerU = effectInfo["radialBlurParam"]["centerU"] or 0.5
        local centerV = effectInfo["radialBlurParam"]["centerV"] or 0.5
        if fadeIn == nil or fadeIn == 0 then
            ImageEffectManager.StartRadialBlur(cam, blurStrength, sampleDist, centerU, centerV, cullingPlayer)
        else
            local blendParam = { ["BlurCenterU"] = centerU, ["BlurCenterV"] = centerV, ["SampleDist"] = sampleDist, ["BlurStrength"] = blurStrength}
            ImageEffectManager.FadeInRadialBlur(cam, blendParam, fadeIn, cullingPlayer)
        end
       
    elseif effectType == ImageEffectType.MotionBlur then
        -- MotionBlur效果
        local blurSize = effectInfo["motionBlurParam"]["blurSize"]
        ImageEffectManager.StartMotionBlur(cam, blurSize, cullingPlayer)

    elseif effectType ==  ImageEffectType.TiltShift then
        -- TiltShift效果
        local blurArea = effectInfo["tiltShiftParam"]["blurArea"] or 1
        local maxBlurSize = effectInfo["tiltShiftParam"]["maxBlurSize"] or 5
        if fadeIn == nil or fadeIn == 0 then
            ImageEffectManager.StartTiltShift(cam, blurArea, maxBlurSize, cullingPlayer)
        else
            local blendParam = { ["BlurArea"] = blurArea, ["MaxBlurSize"] = maxBlurSize }
            ImageEffectManager.FadeInTiltShift(cam, blendParam, fadeIn, cullingPlayer)
        end
        

    elseif effectType == ImageEffectType.TintColor then
        -- TintColor效果
        local color = effectInfo["tintColorParam"]["color"]
        local uColor = UnityEngine.Color(color.r, color.g, color.b, color.a)
        local blendMode = effectInfo["tintColorParam"]["blendMode"] or false
        if fadeIn == nil or fadeIn == 0 then
            ImageEffectManager.StartTintColor(cam, uColor, blendMode, cullingPlayer)
        else
            ImageEffectManager.FadeInTintColor(cam, uColor, blendMode, fadeIn, cullingPlayer)
        end

    elseif effectType == ImageEffectType.BlackOcclusion then
        ImageEffectManager.StartSceneOcclusion(cam, UnityEngine.Color(0.0, 0.0, 0.0, 1.0))

    elseif effectType == ImageEffectType.DepthOfField then
        local focusDistance = effectInfo["depthParam"]["focusDistance"]  
        local aperture = effectInfo["depthParam"]["aperture"]
        local focalLength = effectInfo["depthParam"]["focalLength"]
        local kernelSize = effectInfo["depthParam"]["blurSize"]
        if fadeIn == nil or fadeIn == 0 then
            ImageEffectManager.StartDof(cam, focusDistance, aperture, focalLength, kernelSize)
        else
            ImageEffectManager.FadeInDoF(cam, focusDistance, aperture, focalLength, fadeIn, kernelSize)
        end
    elseif effectType == ImageEffectType.Tonemapping then
        local postExposure = effectInfo["tonemappingParam"]["PostExposure"] or -0.7
        ImageEffectManager.StartTonemapping(cam, postExposure)
    end

    local length = effectInfo["length"]
    local fadeOut = effectInfo["fadeOut"] 
    -- 处理同时发生同种屏幕特效的情况
    if length > 0 then
        -- 新特效为定时特效
        if self.postProcessTimer[effectType] then
            self.postProcessTimer[effectType]:Stop()
            self.postProcessTimer[effectType] = nil
        end
        self.postProcessTimer[effectType] = Timer.New(Functor(self.stopPostProcessByTimer, effectType, cam, fadeOut, actor, cullingPlayer), length, 1, true)
        self.postProcessTimer[effectType]:Start()
    else
        -- 新来特效为常驻特效
        self.postProcessStay[effectType] = cueId
    end
end

local stopFuncMap = {
    [ImageEffectType.Lut] = ImageEffectManager.StopLUT,
    [ImageEffectType.Bloom] = ImageEffectManager.StopBloom,
    [ImageEffectType.RadialBlur] = ImageEffectManager.StopRadialBlur,
    [ImageEffectType.TiltShift] = ImageEffectManager.StopTiltShift,
    [ImageEffectType.TintColor] = ImageEffectManager.StopTintColor,
    [ImageEffectType.BlackOcclusion] = ImageEffectManager.StopSceneOcclusion,
    [ImageEffectType.DepthOfField] = ImageEffectManager.StopDoF,
    [ImageEffectType.MotionBlur] = ImageEffectManager.StopMotionBlur,
    [ImageEffectType.Tonemapping] = ImageEffectManager.StopTonemapping,
}
local fadeoutFuncMap = {
    [ImageEffectType.Lut] = ImageEffectManager.FadeOutLUT,
    [ImageEffectType.RadialBlur] = ImageEffectManager.FadeOutRadialBlur,
    [ImageEffectType.TiltShift] = ImageEffectManager.FadeOutTiltShift,
    [ImageEffectType.TintColor] = ImageEffectManager.FadeOutTintColor,
}
-- 常驻屏幕特效的清理
function CueManager.stopPostProcess( cueId, cam, actor )
    local cueData = CueDataBank.getCueData(cueId)
    if not cueData["PostProcess"] then
        return
    end
    local effectInfo = cueData["PostProcess"]
    local effectType = effectInfo["type"]
    local fadeOut = effectInfo["fadeOut"]
    local cullingPlayer = effectInfo["cullingPlayer"] or 0
    self.stopPostProcessByType(effectType, cam, nil, actor, cullingPlayer)
end
function CueManager.stopPostProcessByType( effectType, cam, fadeOut, actor, cullingPlayer )
    if cullingPlayer == 2 and actor and actor.entityModel then
        actor.entityModel:setModelLayer(actor:getLayer())
    end 

    if fadeOut == nil or fadeOut == 0 or fadeoutFuncMap[effectType] == nil then
        if stopFuncMap[effectType] then
            stopFuncMap[effectType](cam)
        end
    else
        fadeoutFuncMap[effectType](cam, fadeOut, cullingPlayer)
    end
    if self.postProcessTimer[effectType] then
        self.postProcessTimer[effectType]:Stop()
        self.postProcessTimer[effectType] = nil
    end
    if self.postProcessStay[effectType] then
        self.postProcessStay[effectType] = nil
    end
end
-- 定时屏幕特效的关闭
function CueManager.stopPostProcessByTimer( effectType, cam, fadeOut, actor, cullingPlayer )
    if self.postProcessStay[effectType] then
        local cueId = self.postProcessStay[effectType]
        self.playPostProcess(cueId, cam, actor)
    else
        -- stopFuncMap[effectType]()
        self.stopPostProcessByType(effectType, cam, fadeOut, actor, cullingPlayer)
    end
end
-- 定时屏幕特效的暂停和恢复
function CueManager.pausePostProcess(  )
    for effectType, timer in pairs(self.postProcessTimer) do
        timer:Pause()
    end
end
function CueManager.resumePostProcess(  )
    for effectType, timer in pairs(self.postProcessTimer) do
        timer:Resume()
    end
end
-- 去除所有ImageEffect，恢复场景之前的PostProcess
function CueManager.revertImageEffects( cam )
    ImageEffectManager.ClearAllImageEffect(cam)
end

function CueManager.applySceneImageEffects( ppbType )
    ImageEffectManager.ApplyScenePostFxProfile(nil, ppbType, false)
end

function CueManager.startPostOutline( cam )
    if not GameFsm.InterfaceIsInState(Const.STATE_BATTLE) then
        return
    end
    ImageEffectManager.StartPostOutline(cam)
end

function CueManager.stopPostOutline( cam )
    ImageEffectManager.StopPostOutline(cam)
end

function CueManager.forceStopDof( cam )
    ImageEffectManager.ForceStopDof(cam)
end

function CueManager.revertForceStopDof( cam )
    ImageEffectManager.RevertForceStopDof(cam)
end

function CueManager.updatePostDepth( cam )
    ImageEffectManager.CaptureDepth(cam)
end
-----------------------Dialog-------------------
function CueManager.playBattleDialog( actor, dialogId )
    if actor and actor.showDialog then
        actor:showDialog(dialogId)
    end
end




function CueManager._coRecoverTargetCamera(duration, fadeOut  )
    coroutine.wait(duration)
    CameraManager.SwitchToNode(fadeOut, 0)
    self.coTargetCamera = nil
end

function CueManager.stopTargetCamera(  )
    if self.coTargetCamera then
        coroutine.stop(self.coTargetCamera)
        self.coTargetCamera = nil
    end

    CameraManager.SwitchToNode(0.3, 0)
end

-------------------- Sequence Frame and 2DAnimation and video-----------------
function CueManager.playUIAnimation( uiAnimateInfo, actor )
    if not uiAnimateInfo or not uiAnimateInfo["SequenceType"] or not uiAnimateInfo["SequenceName"]then
        return
    end
    local animateType = uiAnimateInfo["SequenceType"]
    local animationPath = uiAnimateInfo["SequenceName"]
    local frameCount = uiAnimateInfo["FrameCount"] or 30
    if animateType == 0 then
        CueUIMediator.playSequenceFrame(animationPath, frameCount)
    elseif animateType == 1 then
        CueUIMediator.play2DAnimation(animationPath)
    elseif animateType == 2 then

        local speed = Util.Battle.GetSpeed()
        UIJump.ToUIAvgVideoPlayer(animationPath, 0, nil, speed,false, false)

    elseif animateType == 3 then
        local stageMirrored = false
        local actorModelAux
        if actor then
            if actor.modelIsMirror then
                stageMirrored = true
            end
            if actor.entityModel.modelAux then
                actorModelAux = actor.entityModel.modelAux
            end
        end
        CueUIMediator.playRealtimeStage(animationPath, actorModelAux, stageMirrored)
    end
end

-------------Pause and Resume
function CueManager.pauseTimerCue( ... )
    self.pausePostProcess()
    CueUIMediator.pauseUIVideo()
end

function CueManager.resumeTimerCue( ... )
    self.resumePostProcess()
    CueUIMediator.resumeUIVideo()
end

function CueManager.stopUIVideo()
    CueUIMediator.stopUIVideo()
end

-------------Release Cue------
-- 人物身上cue统一管理,切换场景等情况下删除
function CueManager.clearCue( logicGroup, actor )
    self.releaseEffectByGroup( logicGroup )

    if actor then
        self.modelEffectMgr:clearEntityModelEffect(actor)
    end

    self.logicGroups[logicGroup] = nil
    -- ...
end

function CueManager.clearAllCue(  )
    for group, _ in pairs(self.logicGroups) do
        self.releaseEffectByGroup( group )
    end
    self.logicGroups = { [0]={} }
    self.effectMgr:despawnUnuseEffect()
    CueUIMediator.stopUIEffect()
    self.audioMgr:cleanAllLoadedSFX()
    self.modelEffectMgr:stopAllTimer()
    CameraManager.ReleaseScreenShake()
    CueUIMediator.stopSequenceFrame()

    self.postProcessStay = {}
    for effectType, timer in pairs(self.postProcessTimer) do
        timer:Stop()
        -- self:stopPostProcessByType(effectType)
    end
    self.postProcessTimer = {}
    self.revertImageEffects()
end

return CueManager
