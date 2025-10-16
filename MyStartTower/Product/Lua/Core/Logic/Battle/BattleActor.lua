-- 玩家表现层类，管理模型加载、表现播放等

-- BattleActor类的定义
-- @author ZH
-- @date 2016-11-21
local Entity = require("Core/Entity/Entity")
local Model = require "Core/Entity/Model"
local BattleLogo = require("Core/UI/Control/Logo/BattleLogo")
local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local BattleStateData = require "Core/Common/FrameBattle/BattleObject/BattleStateData"
local ResMonster = DataTable.ResMonster
local ResHero = DataTable.ResHero
local ModelTool = require "Core/Entity/ModelTool"
local ResSkillConfig = DataTable.ResSkillConfig
local BattleActorReceiver = require("Core/Logic/Battle/BattleActorReceiver")
local Vector3 = Vector3
local CueManager = CueManager
local CameraManager = CameraManager
local Const = Const
local EventCenter = EventCenter

local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION

local strClassName = "BattleActor"
local BattleActor = Class(strClassName, Entity)
MixinClass(BattleActor, BattleActorReceiver)

function BattleActor:ctor(entityId, actorMgr, actorInfo, activeOnLoaded)
    local unitInfo = actorInfo.unitInfo
    local combatInfo = actorInfo.combatInfo
    self.loaded = false
    self.actorMgr = actorMgr
    self.entityId = entityId
    self.camp = actorInfo.camp
    self.element = 0
    if unitInfo.type == 'Monster' then
        self.monsterID = unitInfo.resId
        self.battleCommonData = ResMonster[self.monsterID]
        self.weaponType = self.battleCommonData.weapon
        self.name = self.battleCommonData.name
        if self.weaponType == nil then LuaCallCs.LogError("---   怪没配动画状态机，id = "..self.monsterID) end
        self.controllerPath = ModelTool.getControllerPath(self.battleCommonData.path, self.weaponType, true)
        self.bigMonster = self.battleCommonData.big_monster and self.battleCommonData.big_monster > 0
        self.commonModelId = self.battleCommonData.model
        self.fashionTag = nil
        self.element = self.battleCommonData.elem
    elseif unitInfo.type == 'Hero' then
        self.heroID = unitInfo.resId
        self.battleCommonData = ResHero[self.heroID] or {}
        self.name = self.battleCommonData.hero_name
        self.weaponType = self.battleCommonData.ani_con_name

        if self.weaponType == nil then LuaCallCs.LogError("---   英雄没配动画状态机，id = "..self.heroID) end

        self.controllerPath = ModelTool.getControllerPath(self.battleCommonData.ani_con_path, self.weaponType, true)

        self.commonModelId = self.battleCommonData.model
        self.fashionTag = nil
        self.element = self.battleCommonData.elem
    elseif unitInfo.type == 'Rimuru' then

    end

    -- 左右网格位置
    --self.coordX = actorInfo.coordX
    --self.coordY = actorInfo.coordY
    --self.coordR = actorInfo.coordR

    --构建响应点击操作的碰撞盒
    -- self:addBoxCollider()


    self.activeOnLoaded = activeOnLoaded

    self.hideModelDict = {}         -- 模型隐藏控制的dict
    self.pauseDict = {}             -- 暂停控制的dict
    self.pauseEffDict = {}
    self.stateCues = {}

    self.showDamageNum = true   -- 显示伤害跳字



    -- 添加add标记，隐藏波次怪物，还有召唤物
    if activeOnLoaded == false then
        self.hideModelDict['add'] = true
    end
    --

    self:attachListener()

    -- model 相关
    self:addMovementAux()
    -- self:addNavmeshAgent()

    self:initProp(combatInfo)
    self:createModel()
end

function BattleActor:destroy( )
    if self.coDead then
        coroutine.stop(self.coDead)
    end
    if self.coShowLogo then
        coroutine.stop(self.coShowLogo)
    end
    if self.logo then
        self.logo:destroy()
        self.logo = nil
    end
    if self.coHideModelInSkill then
        coroutine.stop(self.coHideModelInSkill)
        self.coHideModelInSkill = nil
    end
    if self.numCacheTimer then
        self.numCacheTimer:Stop()
    end
    self.coDead = nil
    self.coShowLogo = nil
    self.actorMgr = nil
    self:detachListener()
    CueManager.clearCue(self.id, self)
    BattleActor.super.destroy(self)
    self.modelObject = nil
end

function BattleActor:initProp(combatInfo)
    self.hp = combatInfo.hp
    self.mhp = combatInfo.mhp
    self.mana = combatInfo.mana
    self.maxMana = combatInfo.max_mana
    self.level = combatInfo.level
    self.star = combatInfo.star
    self.coordX = combatInfo.coordX
    self.coordY = combatInfo.coordY
    self:_setPosition()
    --if self.logo then
        self:initLogo()
    --end
end


function BattleActor:createModel()
    --todo 切模型
    if not self.modelLoadedCallback then
        self.modelLoadedCallback = Slot(self.OnModelLoadedEnd, self)
    end

    if self.entityModel ~= nil then
        logerror("BattleActor:createModel() called again with model already created!!")
        self.entityModel:destroy()
        self.entityModel = nil
    end

    if self.entityModel == nil then
        local modelData = self:_getActorModelInfo()
        if modelData then
            modelData.use_lod = Const.MODEL_LOD_LV1
            self.entityModel = Model(self.modelLoadedCallback, self.id)
            self.entityModel:setModelData( modelData )
            self.entityModel:loadGameObject(nil, false)
        end
    end
    return self.entityModel
end

function BattleActor:_getActorModelInfo(  )
    local modelData = {}
    if self.commonModelId then
        modelData["model_type"] = Const.MODEL_TYPE.Default
        modelData["model_id"] = self.commonModelId
        modelData["animator"] = self.controllerPath
        if self.battleCommonData.eliteType and self.battleCommonData.eliteType > 0 and not self.bigMonster then
            modelData["scale"] = 1.2
        end
        return modelData
    end 
end

function BattleActor:OnModelLoadedEnd()
    BattleActor.super.OnModelLoadedEnd(self)
    self.loaded = true
    self.modelObject = self.entityModel:GetModel()
    self:initLogo()
    -- self.entityModel:setEnableShadowReceive(false)
    self.entityModel:setModelAlwaysAnim()
    --self.entityModel:setOutline(true)
    self.entityModel:setTonemapping(true)
    --if SceneManager.isCurSceneRainy( ) then
    --    -- 设置雨夜材质，回收依赖模型回收
    --    self.entityModel:setRainyMat(true)
    --end
    -- self.entityModel:animatorToOverride()
    -- mirror adjust
    self:refreshModelFace()
    self.animator = self.entityModel:getAnimator()

    self.entityModel:showModel(false)
    self:_setPosition()
    if self.activeOnLoaded then
        self:onEntityStart()
    end
end

-- override
function BattleActor:getLayer()
    return Const.LAYER_PLAYER
end

function BattleActor:initLogo()
    local modelData = self:_getActorModelInfo()
    if modelData then
        if self.logo == nil then
            self.logo = BattleLogo(self.controller, "Prefab/SLM_BattleBloodPanel", 0, 0, self)
            --self.logo:setCamp(self.camp==BattleConst.CAMP_PLAYER)
            --self.logo:setElite(self.battleCommonData.eliteType)
            --self.logo:InitData(self.heroID, self.monsterID, self.camp, self.hp, self.mhp, self.mana, self.maxMana, self.logo_mana_gen, self.shield)
            self.logo:InitData(self.entityId, self.heroID, self.monsterID, self.camp, self.hp, self.mhp, self.mana, self.maxMana, 0)
            self:setLogoVisible(false)
        end
    end
end

function BattleActor:setLogoVisible( isVisible )
    if self.coShowLogo then
        self.initLogoVisible = isVisible
    end


    if self.logo then
        self.logo:setHide(not isVisible)
    end
end

function BattleActor:ShowLogoEntID()
    if self.logo then
        self.logo:ShowEntityID()
    end
end

function BattleActor:refreshLogoVisible(  )
    local visible = true
    for reason, value in pairs(self.hideModelDict) do
        visible = false
        break
    end

    self:setLogoVisible( visible )
end

-- TODO:使用格子信息设置位置
--function BattleActor:showNum(num, numType, state, isCache)
--    if self.showDamageNum  then
--        if isCache then
--            self:addShowNumCache({num, numType, state})
--        else
--            BattleActor.super.showNum(self, num, numType, state or "")--NUM_ADD,NUM_CRIT,NUM_LOSE
--        end
--    end
--end

function BattleActor:ShowWords(data, isCache)
    if isCache then
        self:addShowNumCache({ data })
    else
        BattleActor.super.ShowWords(self, data)--NUM_ADD,NUM_CRIT,NUM_LOSE
    end
end


---------------------END:  播放行为--------------------------

-------------------- TODO:分发并播放cue  --------------------
function BattleActor:PlayCue( cueId, attacker, fashionTag, delayTime)
    return CueManager.playCue(self, cueId, attacker, delayTime)
end
------------------END: 分发并播放cue-------------------------

function BattleActor:OnEntitySelected(  )
end

-- entity被长按
function BattleActor:OnEntityLongTap(  )
end

function BattleActor:addBoxCollider(  )
    if not self.gameObject then
        return
    end
    self.boxCollider = self.controller:AddBoxCollider()
    self.boxCollider.center = Vector3(0, 1, 0)
    self.boxCollider.size = Vector3(2, 2, 1)
    self.boxCollider.isTrigger = true
end

function BattleActor:refreshModelVisible( )
    local visible = true
    for reason, value in pairs(self.hideModelDict) do
        visible = false
        break
    end
    if self.modelObject then
        -- 选择了不同的实现方式，每个entity上都有自己的选择特效，所以不需要归还
        -- if not visible then
        --     self:revertChilds()
        -- end
        if self.modelLoaded and self.entityModel then
            if visible then
                -- show
                if self.visibleLayer then
                    self.entityModel:setModelLayer(self.visibleLayer)
                    self.visibleLayer = nil
                end
            else
                -- hide
                if not self.visibleLayer then
                    self.visibleLayer = self.entityModel:getModelLayer()
                end
                self.entityModel:setModelLayer(Const.LAYER_PLAYER_HIDE)
            end    
        end
        -- self.modelObject:SetActive(visible)
    end
    if visible then
        EffectCueMediator.reshowEffectGroup(self.entityId)
    else
        EffectCueMediator.hideEffectGroup( self.entityId )
    end
    self:setLogoVisible( visible )
end

local listenerFuncConfig = {

            ['onHitedAnim'] = BattleConst.MATRIX_EVENT_ENTITY_HITED_AIM, 
            ['onHitedOffset'] = BattleConst.MATRIX_EVENT_ENTITY_HITED_OFFSET, 
            ['onHpChangeCB'] = BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE,
            ['PauseOn'] = BattleConst.MATRIX_EVENT_ENTITY_PAUSEBH,
            ['HandleSkillHide'] = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE,
            ['HandleSkillHideCancel'] = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL,

            ['PauseOff'] = BattleConst.MATRIX_EVENT_ENTITY_CANCELPAUSEBH,
            ['onUseSkill'] = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN,
            --['onUseSkillEnd'] = BattleConst.MATRIX_EVENT_ENTITY_SKILL_END,
            ['onSkillJump'] = BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP,
            ['onSkillBack'] = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK,
            ['onSkillFlash'] = BattleConst.MATRIX_EVENT_ENTITY_SKILL_FLASH,
            --['playEffect'] = BattleConst.MATRIX_EVENT_ENTITY_PLAY_EFFECT,
            ['onPlayCue'] = BattleConst.MATRIX_EVENT_ENTITY_PLAYCUE,
            ['onSelfDead'] = BattleConst.MATRIX_EVENT_ENTITY_DEAD,
            --['onEntityReborn'] = BattleConst.MATRIX_EVENT_REBORN_ENTITY,
            ['onEntityRebornStart'] = BattleConst.MATRIX_EVENT_REBORN_ENTITY_START,
            ['onSetMove'] = BattleConst.MATRIX_EVENT_ENTITY_MOVE,
            ['onBehaviorAnim'] = BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM,
            ['onQuickMove'] = BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO,
            ['onStateEnter'] = BattleConst.MATRIX_EVENT_ENTITY_STATE_ENTER,
            ['onStateLeave'] = BattleConst.MATRIX_EVENT_ENTITY_STATE_EXIT,
            ['onStateShow'] = BattleConst.MATRIX_EVENT_ENTITY_STATESHOW,
            ['onRaiseSomething'] = BattleConst.MATRIX_EVENT_ENTITY_SOMETHING,
            ['onManaChanged'] = BattleConst.MATRIX_EVENT_ENTITY_MANA_CHANGED,
            ['onIdleAnim'] = BattleConst.MATRIX_EVENT_ENTITY_IDLE_ANIM,
            ['onPlaySpecialAnim'] = BattleConst.MATRIX_EVENT_ENTITY_PLAY_ANIM,
            --['onSkillMovie'] = BattleConst.MATRIX_EVENT_ENTITY_SKILL_MOVIE,
            ['onMoveOutOfPos'] = BattleConst.MATRIX_EVENT_ENTITY_MOVE_OUT_POS,
        }

function BattleActor:attachListener( )
    EventCenter.addEventListenerGroup(self, listenerFuncConfig, self.entityId)
end

function BattleActor:detachListener( ... )
    EventCenter.removeEventListenerGroup(self, listenerFuncConfig, self.entityId)
end

function BattleActor:coOnDead( )
    coroutine.wait(2)
    self:_onDead()
end
function BattleActor:_onDead()
    if self.numCacheTimer then
        self.numCacheTimer:Stop()
    end
    CueManager.clearCue(self.id)
    self.entityModel:showModel(false)
    self.hideModelDict['dead'] = true
    self:refreshModelVisible()
    if self.logo then
        self.logo:setVisible(false)
    end
    self.gameObject:SetActive(false)
end

function BattleActor:onAddState( userId, stateId, level ,layer)
     if self.logo then
         self.logo:onAddState(userId, stateId, level,layer)
     end
    local stateData = BattleStateData.getStateData( stateId, level )
    if stateData then
        if stateData["numShowId"] then
            local isDebuff = stateData.stateTypeMap[BattleConst.STATE_TYPE_DEBUFF]
            self:showStateNum(isDebuff, stateData["numShowId"], stateData["numShowNow"] ~= 1)
        end
        if stateData["testNumShowId"] and not IS_PUBLISH_VERSION then
            local isDebuff = stateData.stateTypeMap[BattleConst.STATE_TYPE_DEBUFF]
            self:showStateNum(isDebuff, stateData["testNumShowId"], stateData["numShowNow"] ~= 1)
        end
    end

    local cueId = nil
    if stateData then
        cueId = stateData['state_effect']
    end
    if cueId and self.actorMgr:shouldPlayCue(cueId) then
        if not self.stateCues[userId] then
            self.stateCues[userId] = {}
        end
        local userCues = self.stateCues[userId]
        if userCues[stateId] then
            if userCues[stateId][1] == cueId then
                return
            else
                CueManager.releaseCue( self, userCues[stateId][1], userCues[stateId][2])
            end
        end
        if stateData and stateData[BattleConst.STATE_LINK] then
            -- 灵魂连接额外处理
            if userId ~= self.id then
                local startActor = self.actorMgr.actors[userId]
                if startActor then
                    local index = CueManager.playLinkEffect(cueId, startActor, self, startActor.fashionTag)
                    userCues[stateId] = {cueId, index}
                end
            end
        else
            local startActor = self.actorMgr.actors[userId]
            if startActor and startActor.fashionTag then
                local index = self:PlayCue(cueId, nil)
                userCues[stateId] = {cueId, index}
            else
                local index = self:PlayCue(cueId)
                userCues[stateId] = {cueId, index}
            end
        end
    end
end

function BattleActor:onDelState( userId, stateId )
    local stateData = BattleStateData.getStateData( stateId, 1 )
    if self.stateCues[userId] and self.stateCues[userId][stateId] then
        CueManager.releaseCue( self, self.stateCues[userId][stateId][1], self.stateCues[userId][stateId][2])
        self.stateCues[userId][stateId] = nil
    end
    if self.logo and stateData and stateData["show_state"] then
        self.logo:onDelState(userId, stateId)
    end
end

function BattleActor:_refreshStateCue(  )
    if self.stateCues then
        for userId, userCues in pairs(self.stateCues) do
            for stateId, stateInfo in pairs(userCues) do
                local cueId = stateInfo[1]
                local efxInsId = stateInfo[2]

                if CueManager.isLinkEffect( cueId ) then
                    CueManager.releaseCue( self, cueId, efxInsId)
                    local startActor = (self.actorMgr and self.actorMgr.actors) and self.actorMgr.actors[userId]
                    if startActor then
                        local index = CueManager.playLinkEffect(cueId, startActor, self, startActor.fashionTag)
                        userCues[stateId] = {cueId, index}
                    end
                elseif CueManager.isNormalEffect( cueId ) then
                    CueManager.releaseCue( self, cueId, efxInsId)
                    local index = self:PlayCue(cueId)
                    userCues[stateId] = {cueId, index} 
                end
            end
        end
    end
end



function BattleActor:addShowNumCache(cache)
    if not self.numCacheTimer then
        self.numCacheTimer = Timer.New(Slot(self.onShowNumCache, self), 1, -1, true)
    end
    if not self.showNumCache then
        self.showNumCache = {}
    end
    if self.numCacheTimer:IsRunning() then
        table.insert(self.showNumCache, cache)
    else
        table.insert(self.showNumCache, cache)
        self:onShowNumCache()
        self.numCacheTimer:Start()
    end
end

function BattleActor:onShowNumCache()
    if not (self.showNumCache and #self.showNumCache > 0) then
        self.numCacheTimer:Stop()
        return
    end
    local cache = table.remove(self.showNumCache, 1)
    self:ShowWords(cache[1])
end

function BattleActor:showStateNum(isDebuff, showId, isCache)
    --local showStr = UIConst.getBattleShowStateInfo(showId)
    --if showStr and showStr ~= "" then
    --    if self.camp == BattleConst.CAMP_PLAYER then
    --        if isDebuff then
    --            self:showNum(0, Const.NUM_TYPE.STATE_R, showStr, isCache)
    --        else
    --            self:showNum(0, Const.NUM_TYPE.STATE_B, showStr, isCache)
    --        end
    --    else
    --        if isDebuff then
    --            self:showNum(0, Const.NUM_TYPE.STATE_B, showStr, isCache)
    --        else
    --            self:showNum(0, Const.NUM_TYPE.STATE_R, showStr, isCache)
    --        end
    --    end
    --end
    local data = FloatingWordsHelper.GetBuffData(showId)
    self:ShowWords(data, isCache)
end

function BattleActor:cancelSkillHide()
    if self.coHideModelInSkill then
        coroutine.stop(self.coHideModelInSkill)
        self.coHideModelInSkill = nil
    end
    if self.hideModelDict['skill'] then
        self.hideModelDict['skill'] = nil
        self:refreshModelVisible()
    end
end

function BattleActor:coSkillHide(hideDelayTime)
    coroutine.wait(hideDelayTime)
    self.hideModelDict['skill'] = true
    self:refreshModelVisible()
end

function BattleActor:HandleSkillHide(skillSelf, targets, hideDelayTime, cardId, hideEffect)
    if self.over then
        return
    end
    self.inSkillPause = true
    --self:refreshMana()
    if not skillSelf then       -- 不是自己的大招
        local selfIsTarget = false
        if targets then
            for _, tid in ipairs(targets) do
                if tid == self.id then
                    selfIsTarget = true
                    break
                end
            end
        else
            selfIsTarget = true
        end
        if not selfIsTarget then
            if hideDelayTime and hideDelayTime > 0 then
                if self.coHideModelInSkill then
                    coroutine.stop(self.coHideModelInSkill)
                    self.coHideModelInSkill = nil
                end
                self.coHideModelInSkill = coroutine.start(self.coSkillHide, self, hideDelayTime/30)
            else
                self.hideModelDict['skill'] = true
                self:refreshModelVisible()
            end
        else
            self:cancelSkillHide()
        end
        if hideEffect then   -- skillData里存在这个标志，代表无论如何其他所有的非释放者特效都隐藏
            EffectCueMediator.hideEffectGroup(self.entityId)
        end
    else
        -- 玩家自身释放 判断是否需要黑屏配合
        local cardCueId = CueLogicMediator.getSkillCardCueId(cardId)
        if cardCueId then
            self:PlayCue(cardCueId)
        end
        if hideEffect then
            self.actorMgr:onActorSkillHide()
        end
        self.actorMgr:onSkillPause()
    end
end

function BattleActor:HandleSkillHideCancel()
    self.inSkillPause = false
    self:cancelSkillHide()
    --self:refreshMana()
    EffectCueMediator.reshowEffectGroup(self.entityId)
    self.actorMgr:onActorSkillHideCancel()
    CueManager.stopUIVideo()
    self.actorMgr:cancelSkillPause()
end

function BattleActor:onEntityStart(showNow)
    -- if not enterAction then
    --     enterAction = "EnterScene"
    -- end
    -- self:playAnimator(enterAction)

    -- 移除add标记，显示波次怪物，还有召唤物
    self.hideModelDict['add'] = nil
    --

    if self.loaded then
        if self.coShowLogo then
            coroutine.stop(self.coShowLogo)
            self.coShowLogo = nil
        end
        if showNow then
            self.coShowLogo = coroutine.start(self.coStartShowLogo, self, true)
        else
            self.coShowLogo = coroutine.start(self.coStartShowLogo, self)
        end
    else
        self.activeOnLoaded = true
    end
end

function BattleActor:coStartShowLogo(showNow)
    if not showNow then
       -- coroutine.wait(0.6)
    end
    --if not (self.combatUnit and not self.combatUnit:isAlive()) then     -- 除非已死亡 否则显示模型
    if true then
        self.entityModel:showModel(true)
        if self.initLogoVisible == nil then
            self:setLogoVisible(true)
        end
        coroutine.wait(0.01)
        if self.started then
            --self:refreshMana()
        end
        if self.preAnim then
            self:playAnimator(self.preAnim)
        end
    else
        self:_onDead()
    end
    self.coShowLogo = nil
end

function BattleActor:refreshModelFace( needMirror )
    if nil == needMirror then
        needMirror = self.coordR
    end
    self.modelIsMirror = needMirror
    if self.entityModel then
        self.entityModel:mirrorModel(needMirror)
    end 
end

function BattleActor:onSkillPrepareAnimatorOver()
end

function BattleActor:onSkillPrepareCameraTimeout(duration)
    coroutine.wait(duration)
    CameraManager.SwitchToNode(0.3, 0)
    self.coPrepareCamera = nil
end

function BattleActor:onUseSkill(skillID, skillType, cardId, baseTarget, targets)
    if self.coPrepareCamera then
        coroutine.stop(self.coPrepareCamera)
        self.coPrepareCamera = nil
    end
    self.baseTarget = baseTarget
    if baseTarget then
        self:lookatTarget(baseTarget)
    end
    local needVocal = false
    if skillType == BattleEnum.SkillType.DaZhao then
        if self:_isShortMode() then
            if false then
                -- oc里，英雄释放技能播放一个小UI
                --BattleUIMediator.skillShortUI(self.skillShortShowId, self.camp == BattleConst.CAMP_PLAYER)
            end


            -- 如果是简短大招，一定播放简短语音
            needVocal = true
        else
            -- 如果是全大招，则在没配置全大招语音的时候播放简短语音
            local speed = self:_speedUp()
            if speed==Util.Battle.SPEED_UP2() then
                needVocal = not self:_hasUltimaVocal(cardId, Const.HERO_VOCAL_ULTIMATEX4)
            elseif speed==Util.Battle.SPEED_UP1() then
                needVocal = not self:_hasUltimaVocal(cardId, Const.HERO_VOCAL_ULTIMATEX2)
            else
                needVocal = not self:_hasUltimaVocal(cardId, Const.HERO_VOCAL_ULTIMATEX1)
            end
        end
    end
    
    if needVocal then
        --local speed = self:_speedUp()
        --if speed==BattleConst.SPEED_UP2 then
        --    self:_playUltimatVocal( cardId, Const.HERO_VOCAL_ULTIMATESHORTX4 )
        --elseif speed==BattleConst.SPEED_UP1 then
        --    self:_playUltimatVocal( cardId, Const.HERO_VOCAL_ULTIMATESHORTX2 )
        --else
        --    self:_playUltimatVocal( cardId, Const.HERO_VOCAL_ULTIMATESHORTX1 )
        --end
    end
end

function BattleActor:onSkillMovie(movieCue)
    --self.actorMgr:onPlayAtkCue(self.id, self.id, movieCue)

    --if not self:_isShortMode() then
    --    --local speed = self:_speedUp()
    --    --if speed==BattleConst.SPEED_UP2 then --TODO
    --    --    --self:_playUltimatVocal( self.combatUnit.nowCardId, Const.HERO_VOCAL_ULTIMATEX4 )
    --    --elseif speed==BattleConst.SPEED_UP1 then
    --    --    --self:_playUltimatVocal( self.combatUnit.nowCardId, Const.HERO_VOCAL_ULTIMATEX2 )
    --    --else
    --    --    --self:_playUltimatVocal( self.combatUnit.nowCardId, Const.HERO_VOCAL_ULTIMATEX1 )
    --    --end
    --end

    if movieCue and movieCue.cueList and #movieCue.cueList > 0 then
        print("---   播放大招视频...   "..movieCue.cueList[1])
        self:PlayCue(movieCue.cueList[1])
    else
        print("---   播放大招视频结束   ")
    end

end

function BattleActor:_speedUp( ... )
    --if BattleConst.DebugUseOldFightingUI then
    --    --local speed = UserData.loadCommonData(BattleConst.SPEED_KEY) or BattleConst.SPEED_NORMAL
    --    --if self.actorMgr and self.actorMgr.needExtraSpeed then
    --    --    local extraSpeed = UserData.loadCommonData(BattleConst.EXTRA_SPEED_KEY) or BattleConst.SPEED_NORMAL
    --    --    if extraSpeed == BattleConst.SPEED_UP2 then
    --    --        return extraSpeed
    --    --    else
    --    --        return speed
    --    --    end
    --    --else
    --    --    return speed
    --    --end
    --else
    --    local speed = UserData.loadCommonData(BattleConst.SPEED_KEY) or BattleConst.SPEED_NORMAL
    --    return speed
    --end
    local speed = LuaCallCs.PlayerPrefs.GetString(Util.Battle.SPEED_KEY(), Util.Battle.SPEED_NORMAL())
    return speed
end

function BattleActor:_isShortMode( ... )
    --return self.combatUnit and self.combatUnit.skillInShortMode
    return false
end

--function BattleActor:_playUltimatVocal( cardId, vocalType )
--    if not cardId then
--        return
--    end
--    if ResSkillConfig[cardId] and ResSkillConfig[cardId][1] then
--        local vocalIndex = ResSkillConfig[cardId][1].skill_vocal
--        if vocalIndex then
--            AudioCueMediator.playHeroVocal( vocalIndex, vocalType, self.fashionTag )
--        end
--    end
--end
function BattleActor:_hasUltimaVocal( cardId, vocalType )
    if not cardId then
        return false
    end
    if ResSkillConfig[cardId] and ResSkillConfig[cardId][1] then
        local vocalIndex = ResSkillConfig[cardId][1].skill_vocal
        if vocalIndex then
            return AudioCueMediator.heroHasVocal( vocalIndex, vocalType )
        end
    end
    return false
end

--function BattleActor:onUseSkillEnd()
--end

function BattleActor:_setPosition()
    if self.outOfPos then
        self:onMoveOutOfPos()
    else
        local pos = self.actorMgr:getGridPosition(self.coordX, self.coordY)
        self.position = {x = pos.x, y = pos.y, z = pos.z}
        self:teleport(pos.x, pos.y, pos.z)
        self:lookatGrid()
    end
end

--写死的BuffID
local BURNING_NUM = 7
local ICE_NUM = 210
function BattleActor:onDamage( dmg, damageType, isCrit, attackerId, skillType)
    local isSkill = skillType == BattleEnum.SkillType.DaZhao
    local numType = nil

    local wordType = FloatingWordsType.None --飘字类型
    local data = nil ---@type FloatingWordsData 飘字信息

    if damageType == 'hurtHp' then
        local inLeft = self.actorMgr:inLeft(attackerId, self.id)
        if isSkill then
            if isCrit then
                if inLeft then
                    numType = Const.NUM_TYPE.SKILLCRIT_L
                else
                    numType = Const.NUM_TYPE.SKILLCRIT_R
                end
            else
                if inLeft then
                    numType = Const.NUM_TYPE.SKILLLOSE_L
                else
                    numType = Const.NUM_TYPE.SKILLLOSE_R
                end
            end
        else
            if isCrit then
                if inLeft then
                    numType = Const.NUM_TYPE.CRIT_L
                else
                    numType = Const.NUM_TYPE.CRIT_R
                end
            else
                if inLeft then
                    numType = Const.NUM_TYPE.LOSE_L
                else
                    numType = Const.NUM_TYPE.LOSE_R
                end
            end
        end
        local attacker = EntityCmd._entity(attackerId).CompBattleActor._actor
        wordType = FloatingWordsHelper.GetWordType(skillType)
        data = FloatingWordsHelper.GeneralData(wordType, dmg, isCrit, self.camp, attacker.element)
    elseif damageType == 'healHp' then
        local attacker = EntityCmd._entity(attackerId).CompBattleActor._actor
        data = FloatingWordsHelper.GeneralData(FloatingWordsType.AddHp, dmg, isCrit, self.camp, attacker.element)
    elseif damageType == 'healShield' then
        local attacker = EntityCmd._entity(attackerId).CompBattleActor._actor
        data = FloatingWordsHelper.GeneralData(FloatingWordsType.AddDef, dmg, isCrit, self.camp, attacker.element)
    elseif damageType == BattleConst.DAMAGE_TYPE_MISS then
        self:showStateNum(false, BattleConst.STATE_SHOW_MISS)
    elseif damageType == 'hurtShield' then
        local attacker = EntityCmd._entity(attackerId).CompBattleActor._actor
        data = FloatingWordsHelper.GeneralData(FloatingWordsType.Attack, dmg, isCrit, self.camp, attacker.element)
    end

    if wordType ~= FloatingWordsType.None and data ~= "" then
        self:ShowWords(data)
    end
end

function BattleActor:onHpChange( hp, mhp, isDamage )
    local preHp = self.hp
    self.hp = hp
    self.mhp = mhp
    if not (preHp and preHp <= 0 and self.hp <= 0) then
        if self.logo then
            self.logo:UpdateHp(self.hp, self.mhp, isDamage)
        end
    end
end

function BattleActor:onHpChangeCB(oldHp, hp, mhp, isDamage )
    self:onHpChange(hp, mhp, isDamage)
end

function BattleActor:SetHUDShield()
    if self.logo then
        local shield = EntityCmd.Base.GetProp(self.entityId, EntPropType.Shield)
        local maxShield = EntityCmd.Base.GetProp(self.entityId, EntPropType.MaxShield)
        self.logo:setShield(shield, maxShield)
    end
end

--function BattleActor:onEntityReborn()
--end

function BattleActor:onEntityRebornStart()
    if self.coDead then
        coroutine.stop(self.coDead)
    end
    self.coDead = nil
    CueManager.clearCue(self.id, self)
    self.entityModel:showModel(true)
    self.gameObject:SetActive(true)
    self.hideModelDict['dead'] = nil
    if self.logo then
        self.logo:setVisible(true)
    end
    self:refreshModelVisible()
    self:_setPosition()
--    self.hp = self.combatUnit.hp
--    self:onHpChange(self.hp, self.mhp)
--    self:refreshMana()
--    self.logo:setMana(self.combatUnit.mana, 100, 0)
end

function BattleActor:onSelfDead()
    if self.numCacheTimer then
        self.numCacheTimer:Stop()
    end
    if self.inPause then
        self.pauseDict = {}
        self.pauseEffDict = {}
        self:refreshPause()
    end
    if self.movementAux then
        self.movementAux:PauseOn()
    end
    self.preAnim = "Die"
    self:playAnimator("Die")
    if self.coDead then
        coroutine.stop(self.coDead)
    end
    self.coDead = coroutine.start(self.coOnDead, self)
end

function BattleActor:onBattleStart()
    self.started = true
    --self:refreshMana()
end

--function BattleActor:refreshMana()
--
--end

function BattleActor:SetHUDMana()
    local mp = EntityCmd.Base.GetProp(self.entityId, EntPropType.Mp)
    local maxMp = EntityCmd.Base.GetProp(self.entityId, EntPropType.MaxMp)
    local speed = EntityCmd.Base.GetProp(self.entityId, EntPropType.MpSpeed)

    if self.logo then
        if false then
            -- 技能暂停中 或者 战场在刷某波怪中 要暂停mana变化，先暂时关闭
            self.logo:setMana(mp, maxMp, 0)
        else
            self.logo:setMana(mp, maxMp, speed or 0)
        end
    end
end

function BattleActor:onManaChanged(value, isKill, notShow)
    if notShow then return end
    --if isKill then
    --    local showStr = UIConst.getBattleShowStateInfo(BattleConst.STATE_SHOW_KILL)
    --    if self.camp == BattleConst.CAMP_PLAYER then
    --        self:showNum(value, Const.NUM_TYPE.KILL_B, showStr)
    --    else
    --        self:showNum(value, Const.NUM_TYPE.KILL_R, showStr)
    --    end
    --else
    --    local showStr = UIConst.getBattleShowStateInfo(BattleConst.STATE_SHOW_KILL)
    --    if self.camp == BattleConst.CAMP_PLAYER then
    --        if value > 0 then
    --            self:showNum(value, Const.NUM_TYPE.KILL_B, showStr)
    --        else
    --            self:showNum(value, Const.NUM_TYPE.KILL_R, showStr)
    --        end
    --    else
    --        if value > 0 then
    --            self:showNum(value, Const.NUM_TYPE.KILL_R, showStr)
    --        else
    --            self:showNum(value, Const.NUM_TYPE.KILL_B, showStr)
    --        end
    --    end
    --end
    --local attacker = EntityCmd._entity(attackerId).CompBattleActor._actor
    local data = FloatingWordsHelper.GeneralData(FloatingWordsType.AddMp, value, false, self.camp, 0)
    self:ShowWords(data)
end





function BattleActor:onCameraAnimatorOver()
    CameraManager.CameraGrp:SetFov(25, 0)
    CameraManager.SwitchToNode(0.1, 0)
    CameraManager.SetClipPlane(BattleConst.NEAR_CLIP_PLANE, BattleConst.FAR_CLIP_PLANE)
end

-- 战斗结束
function BattleActor:onBattleOver( )
    if self.combatUnit then
        self:PauseOff()
        if self.coPrepareCamera then
            coroutine.stop(self.coPrepareCamera)
            self.coPrepareCamera = nil
        end
        if self.logo then
            self.logo:setVisible(false)
        end
        if self.combatUnit:isAlive() and self.movementAux then
            if self.inRunningAnim then
                self:playAnimator("idle")
                local pos = self:getPosition()
                self.movementAux:stopMoving(pos.x, pos.y, pos.z, 1)
            end
        end
    end
    self.over = true
end

function BattleActor:onRaiseSomething( immuneType )
    local showType = nil
    if immuneType == BattleConst.STATE_IMMUNE_REDUCE_MANA then
        showType = BattleConst.STATE_SHOW_IMMUNE_REDUCE_MANA
    elseif immuneType == BattleConst.STATE_IMMUNE_DEBUFF or immuneType == BattleConst.STATE_IMMUNE_TAUNT then
        showType = BattleConst.STATE_SHOW_IMMUNE
    elseif immuneType == BattleConst.STATE_IMMUNE_SILENCE then
        showType = BattleConst.STATE_SHOW_IMMUNE_SILENCE
    elseif immuneType == BattleConst.ENTITY_SOMETHING_IMMUE_PHYSICS then
        showType = BattleConst.STATE_SHOW_IMMUE_PHYSICS
    elseif immuneType == BattleConst.ENTITY_SOMETHING_IMMUE_MAGIC then
        showType = BattleConst.STATE_SHOW_IMMUE_MAGIC
    elseif immuneType == BattleConst.STATE_IMMUNE_DISARM then
        showType = BattleConst.STATE_SHOW_IMMUNE_DISARM
    elseif immuneType == BattleConst.STATE_IMMUNE_CONTROLLED then
        showType = BattleConst.STATE_SHOW_IMMUNE_CONTROL
    elseif immuneType == BattleConst.STATE_BLOCK_RATE then
        showType = BattleConst.STATE_SHOW_BLOCK
    end

    logerror("BattleActor.onRaiseSomething()"..immuneType.." => "..tostring(showType))

    if showType then
        self:showStateNum(false, showType)
    end
end

function BattleActor:onStateShow(propName, isDebuff)
    local showId = nil
    if BattleConst.STATE_PROP_SHOW[propName] then
        if isDebuff then
            showId = BattleConst.STATE_PROP_SHOW[propName][2]
        else
            showId = BattleConst.STATE_PROP_SHOW[propName][1]
        end
    end
    logerror("BattleActor.onStateShow() propName:"..propName.."; isDebuff:"..isDebuff.."; showId:"..tostring(showId))
    if showId then
        self:showStateNum(isDebuff, showId, true)
    end
end

-------- override -------
function BattleActor:modelTransform( commonModelId, animator, defaultAnim )
    self.oldCommonModelId = self.commonModelId   -- 保存旧的模型id
    self.commonModelId = commonModelId
    self.oldControllerPath = self.controllerPath
    self.controllerPath = animator
    if self.modelLoaded and self.entityModel then
        local modelData = self:_getActorModelInfo()
        if self.fashionTag then
            modelData["fashion_tag"] = self.fashionTag
        end
        local oldLayer = self.entityModel:getModelLayer()
        self.entityModel:changeModelAll(modelData, Functor(self._afterModelTransform, self, oldLayer, defaultAnim))
    end
end

function BattleActor:recoverModelTransform(  )
    self.commonModelId = self.oldCommonModelId
    self.controllerPath = self.oldControllerPath
    if self.modelLoaded and self.entityModel then
        local modelData = self:_getActorModelInfo()
        local oldLayer = self.entityModel:getModelLayer()
        self.entityModel:changeModelAll(modelData, Functor(self._afterModelTransform, self, oldLayer))
    end
end

function BattleActor:_afterModelTransform( oldLayer ,defaultAnim)
    if oldLayer then
        self.entityModel:setModelLayer(oldLayer)
        -- self.entityModel:setEnableShadowReceive(false)
        self.entityModel:setModelAlwaysAnim()
        --self.entityModel:setOutline(true)
    end 
    if defaultAnim then
        self:playAnimator(defaultAnim)
    end 

    -- 如果之前有状态特效，这里重新连接起来
    self:_refreshStateCue()
end


------------------------------ 特殊的战斗内表演型Actor --------------------------------------
--function BattleActor:onSetShowArgs(showData)
--    self.coordX = showData.boss_pos[1]
--    self.coordY = showData.boss_pos[2]
--    local pos = self.actorMgr.gridTrans:getPosition(self.coordX, self.coordY)
--    self:teleport(pos.x, pos.y, pos.z)
--    self:lookAtGrid()
--    self.showActorSummonAnim = showData.summon_anim
--end

function BattleActor:onShowSummonAnim()
    if self.showActorSummonAnim then
        self:playAnimator(self.showActorSummonAnim)
    end
end
return BattleActor
