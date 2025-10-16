local UIUtils = Framework.UI.UIUtils
local Model = require "Core/Entity/Model"
--local ModelTool = require "Core/Entity/ModelTool"
local DragLogo = require("Core/UI/Control/Logo/DragLogo")
local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local BattleStateData = require "Core/Common/FrameBattle/BattleObject/BattleStateData"
local EntityFactory = Framework.Entity.EntityFactory
--local ResItemHeroBase = DataTable.ResItemHeroBase

local START_ENTITY_ID = BattleConst.DRAG_OBJECT_START

---@class DragObject
local DragObject = Class("DragObject")
DragObject._curID = START_ENTITY_ID

function DragObject:ctor(mgr, heroGid, heroConfigId, monsterConfigId, pos, camp, lv, star, isShowHp, hp, mp)
    local did = DragObject._curID
    DragObject._curID = did + 1

    -- 老代码要删除
    self.did = did
    self._isShowHp = isShowHp
    self.mgr = mgr
    self.pos = pos
    -- 老代码要删除



    local _isHero = heroConfigId ~= nil
    local _isMonster = monsterConfigId ~= nil
    self.DragEntData = DragEntityData()
    if _isHero or _isMonster then
        self.DragEntData:InitData(self.did, pos, camp, heroGid, heroConfigId, monsterConfigId, lv, star, hp, mp)
    else
        LuaCallCs.ThrowException("---   DragObject初始化失败，monster = nil 且 hero = nil")
    end


    --self.blockPos = {}
    self:put2Pos(pos)
    self:_initModel()
    self.mEventDragPut = nil
    self.mEventDragEnter = nil
    self.mEventDragLeave = nil
    self.mEventDragCatch = nil
    self.mEventDragClick = nil
    self.mEventDragShowSkillArea = nil
    self.ready = false
end

function DragObject:onReady()
    self.ready = true
    if self.logo and self.modelVisible then
        self.logo:setVisible(true)
    end
end

-- 后续改成播放动画
function DragObject:onBattleStart()
    if self.logo then
        self.logo:setVisible(false)
    end
end

function DragObject:checkStartCue(playerState)
    if not playerState then
        return
    end
    if not self.DragEntData:IsPlayer() then
        return
    end
    local stateData = BattleStateData.getStateData(playerState, 1)
    if not stateData then
        return
    end
    local formationCue = stateData.formationCue
    if stateData.conditionName == "race" and formationCue then
        if self.modelLoaded then
            --if (self.hero and self.hero.camp == stateData.conditionValue) or (self.monster and self.monster.camp == stateData.conditionValue) then
            --    CueManager.playCue(self, formationCue)
            --end
        else
            self.cachedPlayerState = playerState
        end
    end
end

function DragObject:destroy()
    if self.entityModel then
        self.entityModel:destroy()
        self.entityModel = nil
    end
    if self.logo then
        self.logo:destroy()
        self.logo = nil
    end
    EntityFactory.ReleaseEntity(self.did)
end


function DragObject:_initModel()
    local modelData = {}
    modelData.model_type = Const.MODEL_TYPE.Default -- Const.MODEL_TYPE.ShowDrag
    modelData.use_lod = Const.MODEL_LOD_LV1
    local heroCfgId = self.DragEntData:GetHeroConfigID()
    local monsterCfgId = self.DragEntData:GetMonsterConfigID()
    if monsterCfgId then
        modelData.model_id = MonsterHelper.GetMonsterModel(monsterCfgId)
        local isElite = MonsterHelper.IsElite(monsterCfgId)
        local isBoss = MonsterHelper.IsBoss(monsterCfgId)
        local isBigMonster = MonsterHelper.IsBigMonster(monsterCfgId)
        if isElite and isBoss and (not isBigMonster) then
            modelData.scale = 1.2
        end
    else
        modelData.model_id = HeroHelper.GetHeroModel(heroCfgId)
    end

    self.isMisteryMan = monsterCfgId == BattleConst.HIDE_FORMATION_MONSTER_ID
    self.entityModel = Model(Slot(self.onModelLoadedEnd, self))
    self.entityModel:setModelData(modelData)
    self.entityModel:loadGameObject()
end

function DragObject:onModelLoadedEnd()
    self.controller:InitModelAfterLoaded(self.entityModel:GetModel())
    self.modelLoaded = true
    local go = self.entityModel:GetModel()
    go.transform.parent = self._obj.transform
    go.transform.localPosition = Vector3.zero
    self.entityModel:setModelLayer(self._obj.layer)
    if not self.DragEntData:IsPlayer() then
        self.entityModel:mirrorModel(true)
    end
    --self.entityModel:setOutline(true)
    self.entityModel:setTonemapping(true)


    local collider = self.controller:AddBoxCollider()
    -- collider.center = Vector3(0, 1.5, 0)
    collider.size = Vector3(1.5, 1.5, 1.5)
    local rotStart = 0
    local state = GameFsm.getCurState()
    if state.sceneTrans then
        rotStart = -state.sceneTrans.gridAngle
    end
    if self.pos and self.pos < 0 then
        self.controller:SetRotation(0, rotStart + 90, 0)
    else
        self.controller:SetRotation(0, rotStart - 90, 0)
    end
    self:initLogo()
    if self.cachedPlayerState then
        self:checkStartCue(self.cachedPlayerState)
        self.cachedPlayerState = nil
    end
    if self.mgr.inObjectEntering and self.pos then
        self:setModelVisible(false)
        self.mgr.onCheckObjEnter()
    else
        self:setModelVisible(true)
    end
end

function DragObject:onEnterGame()
    -- todo 表现动作
    if self.modelLoaded then
        self:setModelVisible(true)
        --self:playAnimator("OnDrag")
    end
end

function DragObject:isModelInShow()
    return self.modelLoaded and self:getModelVisible()
end

function DragObject:getModelVisible()
    return self.modelVisible
end

function DragObject:setModelVisible(visible)
    if self.modelLoaded then
        self.modelVisible = visible
        self.entityModel:setVisible(visible)
        if self.logo then
            self.logo:setVisible(visible)
        end
    end
end

function DragObject:playAnimator( animName )
    if self.entityModel then
        self.entityModel:playAnimation(animName, true)
    end
end

function DragObject:playDragVoice(  )
    --if self.hero then
    --    --AudioCueMediator.playHeroVocal( self.hero.id, Const.HERO_VOCAL_DRAG, self.fashionTag )
    --end
end

function DragObject:onSupportEffect()
    if self.logo then
        self.logo:playBattleSupport()
    end
end

function DragObject:onSupportedEffect()
    if self.logo then
        self.logo:playBattleSupport()
    end
end

function DragObject:playBattleOvercome(isLoop)
    if self.logo then
        self.logo:playBattleOvercome(isLoop)
    end
end

function DragObject:stopBattleOvercome()
    if self.logo then
        self.logo:stopBattleOvercome()
    end
end

function DragObject:initLogo()
    if self.isMisteryMan then
        return
    end
    self.logo = DragLogo(self.controller, "Prefab/SLM_TeamSetLogo")
    if self.logo then
        self.logo:setTarget(self.DragEntData:GetHeroConfigID(), self.DragEntData:GetMonsterConfigID(), self.DragEntData:GetLv())
        self.logo:showHP(self._isShowHp, self.DragEntData:GetHp() , self.DragEntData:GetMp())
    end
end

---@param dragObj DragObject
function DragObject:setTargetEff(dragObj)
    --print("---   首选目标的线:form = "..dragObj.DragEntData:GetPos().."   to = "..self.DragEntData:GetPos())
    --print("---   首选目标的线:form = ")
    local attack = dragObj.DragEntData:GetController()
    local target = self.DragEntData:GetController()

    --local resName = ""
    -- LuaCallCs.LoadPrefabSync(resName)
    LuaCallCs.SkillLineLockTargetSetLine(nil, attack, target)
    print("---   首选目标的线:from = "..dragObj.DragEntData:GetGid().."   to = "..self.DragEntData:GetGid())
end

function DragObject:closeTargetEff()
    print("---   清理首选目标的线")
    LuaCallCs.SkillLineLockTargetFree(self.DragEntData:GetController())
end

function DragObject:setSelect(isSelect,playAudio)
    if self.logo then
        self.logo:setSelect(isSelect,playAudio)
    end
end




function DragObject:put2Pos(pos)
    self.controller = UIUtils.SetDragTarget(self, self.did, pos or 99)
    self.DragEntData:SetEntityController(self.controller)
    self._obj = self.controller.gameObject
end


function DragObject:OnDragEnter(gridInfo)
    if self.mEventDragEnter then
        self:mEventDragEnter(gridInfo)
    end
    --拖拽时显示英雄技能释放范围
    if self.getGridInfo == nil or self.getGridInfo ~= gridInfo then
        if self.mEventDragShowSkillArea then
            self.getGridInfo = gridInfo
            self:mEventDragShowSkillArea(gridInfo)
        end
    end
end

function DragObject:OnDragLeave(gridInfo)
    if self.mEventDragLeave then
        self:mEventDragLeave(gridInfo)
    end
end

function DragObject:OnDragGet(gridInfo)
    if self.mEventDragCatch then
        self:mEventDragCatch(gridInfo)
        --开始时获得的格子
        self.getGridInfo = gridInfo
    end
end

function DragObject:OnDragClick(gridInfo)
    if self.mEventDragClick then
        self:mEventDragClick(gridInfo)
    end
end

function DragObject:OnDragPut(gridInfo)
    if self.mEventDragPut then
        self:mEventDragPut(gridInfo)
    end
end


function DragObject:GetPos() return self.DragEntData:GetPos() end
function DragObject:IsPlayer() return self.DragEntData:IsPlayer() end --是否是己方
function DragObject:IsHero() return self.DragEntData:IsHero() end -- 是否是英雄单位
function DragObject:GetHeroConfigID() return self.DragEntData:GetHeroConfigID() end
function DragObject:GetHeroGid() return self.DragEntData:GetHeroGid() end
function DragObject:IsMonster() return self.DragEntData:IsMonster() end -- 是否是怪单位
function DragObject:GetMonsterConfigID() return self.DragEntData:GetMonsterConfigID() end
function DragObject:GetCampIdx() return self.DragEntData:GetCampIdx() end
function DragObject:GetLv() return self.DragEntData:GetLv() end
function DragObject:GetStar() return self.DragEntData:GetStar() end
function DragObject:ChangePos(pos) return self.DragEntData:ChangePos(pos) end

return DragObject

