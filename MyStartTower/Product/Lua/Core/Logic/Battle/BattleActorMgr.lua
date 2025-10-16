-- 战场内表现对象的管理类 当黑盒(Matrix)告知发生了一系列事件时  需要在Unity中进行相关的角色客户端表现

-- BattleActorMgr类的定义
-- @author zh
-- @date 2016-11-21


local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local BattleActor = require "Core/Logic/Battle/BattleActor"
local ResBattleWaveShow = DataTable.ResBattleWaveShow

local CameraManager = CameraManager
local EventCenter = EventCenter
local CueManager = CueManager
local Timer = Timer

local strClassName = "BattleActorMgr"
local BattleActorMgr = Class(strClassName)

-- 留意这里注册的函数，常驻第一参数为actorId，后面才是传来的参数
local listenerFuncConfig = {
    ['onBattleStart'] = BattleConst.MATRIX_EVENT_BATTLE_START,
    --['onPlayCue'] = BattleConst.MATRIX_EVENT_ENTITY_PLAYCUE,
    --['onEntityDead'] = BattleConst.MATRIX_EVENT_ENTITY_DEAD,
    ['onBattleOver'] = BattleConst.MATRIX_EVENT_BATTLE_OVER,
    ['onSummonMonster'] = BattleConst.MATRIX_EVENT_SUMMON_MONSTER,
--    ['onAddEntity'] = BattleConst.MATRIX_EVENT_ADD_ENTITY,
--    ['onDelEntity'] = BattleConst.MATRIX_EVENT_DEL_ENTITY,
--    ['onEntityEnter'] = BattleConst.MATRIX_EVENT_MONSTER_ENTER,
    ['onBattleWave'] = BattleConst.MATRIX_EVENT_MONSTER_WAVE,
    ['onAddTrap'] = BattleConst.MATRIX_EVENT_ADD_TRAP,
    ['onDelTrap'] = BattleConst.MATRIX_EVENT_DEL_TRAP,
    ['onAddWeather'] = BattleConst.MATRIX_EVENT_ADD_WEATHER,
    ['onDelWeather'] = BattleConst.MATRIX_EVENT_DEL_WEATHER,
    ['onActionEnd'] = BattleConst.MATRIX_EVENT_ACTION_END,
    ["onSpecialDamageRecord"] = BattleConst.MATRIX_EVENT_SPECIAL_DAMAGE_RECORD,
}
-- 构造函数。
function BattleActorMgr:ctor(battleState, matrixInstance)
    -- 黑盒实例
    self.matrixInstance = matrixInstance
    self:extendBattleInfo(battleState.sceneTrans)

    -- 战场管理状态
    self.battleState = battleState
    if battleState.isZombie then
        self.disablePrepareCamera = true
    end
    self.needExtraSpeed = PlayerHelper.CheckOpenBattleMaxSpeed()--battleState:needExtraSpeed()
    self.actors = {}
    self:initActors()

    self:initCueData()

    EventCenter.addEventListenerGroup(self, listenerFuncConfig)
    self.upRoutine = Timer.New(Slot(self.checkEveryActorLoaded, self), 0.5, -1, false)
    self.upRoutine:Start()
    self:initShowActors()
    --self.animMgr = AnimActorMgr(self, petEntity)
end

function BattleActorMgr:extendBattleInfo(sceneTrans)
    self.leftDir = sceneTrans.leftDir
    self.upDir = sceneTrans.upDir
    self.gridAngle = sceneTrans.gridAngle
    local GRID_SIZE = BattleConst.GRID_SIZE
    -- 最左下0 0格子的坐标计算
    -- local lrSub = GRID_SIZE * (self.LR_LEN - 1) / 2
    -- local udSub = GRID_SIZE * 0.866 * (self.UD_LEN - 1) / 2
    local lrSub, udSub = 0, 0
    self.gridUpDir = self.upDir * 0.866 * GRID_SIZE
    self.gridLeftDir = self.leftDir * GRID_SIZE
    self.centerPosition = sceneTrans:getCenterPointPos()
    self.oriPosition = self.centerPosition - self.leftDir * lrSub - self.upDir * udSub
end

function BattleActorMgr:getGridPosition(coordX, coordY)
    return self.gridLeftDir * coordX + self.oriPosition + self.gridUpDir * coordY
end

function BattleActorMgr:checkEveryActorLoaded()
    if self.actors then
        for id, actor in pairs(self.actors) do
            if not actor:isModelLoaded() then
                return false
            end
        end
    end
    self.upRoutine:Stop()

end

function BattleActorMgr:whenEveryActorLoaded()

end

function BattleActorMgr:destroy()
    EventCenter.removeEventListenerGroup(self, listenerFuncConfig)
    if self.upRoutine then
        self.upRoutine:Stop()
    end
    if self.actors then
        for id, actor in pairs(self.actors) do
            -- CueManager.clearCue(id)
            actor:destroy()
        end
        self.actors = {}
    end
    if self.showActor then
        self.showActor:destroy()
        self.showActor = nil
    end
    self:clearAllTrap()
    self:clearWeatherEff()
    self:clearRelicCue()
    CueManager.clearCue(0)
    --self.animMgr:destroy()
end

function BattleActorMgr:prepareChaseFrame()
    EventCenter.removeEventListenerGroup(self, listenerFuncConfig)
    if self.actors then
        for id, actor in pairs(self.actors) do
            -- CueManager.clearCue(id)
            actor:destroy()
        end
        self.actors = {}
    end
end





function BattleActorMgr:initActors()
    self.actors = {}
end

local SHOW_ACTOR_ID_START = BattleConst.SHOW_ACTOR_ID_START
function BattleActorMgr:initShowActors()
    local showData = ResBattleWaveShow[self.battleState.battleNo]
    if showData and showData.boss_id then
--        local player = {}
--        player.entityID = SHOW_ACTOR_ID_START
--        player.monsterID = showData.boss_id
--        self.showActor = BattleActor(SHOW_ACTOR_ID_START, "", self, player, true)
--        self.showActor:onSetShowArgs(showData)
    end

    self:checkWeatherEff()
    self:checkRelicCue()
end

function BattleActorMgr:playShowActorAnim(animName)
    if self.showActor then
        self.showActor:playAnimator(animName)
    end
end

-- activeOnLoaded = false 战斗中间增加怪物需要一个个加载好跳进来
function BattleActorMgr:onAddEntity(eid, actorInfo)
    self.actors[eid] = BattleActor(eid, "", self, actorInfo, false)
end

function BattleActorMgr:onDelEntity(objectId)
    if self.actors[objectId] then
        self.actors[objectId]:destroy()
        self.actors[objectId] = nil
    end
end

function BattleActorMgr:onEntityEnter(objectId)
    if self.actors[objectId] then
        self.actors[objectId]:onEntityStart(true)
        self.actors[objectId]:onBattleStart()
    end
end

function BattleActorMgr:onSummonMonster(masterid, eid, monsterInfo)
    self.actors[eid] = BattleActor(eid, self, monsterInfo, true)
    self.actors[eid]:onBattleStart()
    WarManager:Get():AddEntity(eid, self.actors[eid], monsterInfo)
end

-- target是否在攻击者的左边 跳字需要使用
function BattleActorMgr:inLeft(attackId, targetId)
    local attacker = self.actors[attackId]
    local target = self.actors[targetId]
    if attacker and target then
        local attackerX = attacker:getPositionXYZ()
        local targetX = target:getPositionXYZ()
        return attackerX > targetX
    end
end

-- 这个看起来是预加载的好时机
function BattleActorMgr:initCueData()
end

function BattleActorMgr:getActor(actorId)
    if self.actors then
        return self.actors[actorId]
    end
end

function BattleActorMgr:onBattleStart()
    for k, actor in pairs(self.actors) do
        actor:onBattleStart()
    end
    --BattleUIMediator.mainUI(self.battleState.mainDlgName)
end

function BattleActorMgr:onBattleOver()
    for k, actor in pairs(self.actors) do
        actor:onBattleOver()
    end
end

function BattleActorMgr:onPlayCue(fashionTag, targetId, hitCue, attackerId, delayTime)
    local attacker = self.actors[attackerId]
    local target = self.actors[targetId]
    if delayTime then
        self:_playCueList(attacker, hitCue, target, fashionTag, delayTime)
    else
        self:_playCueList(target, hitCue, attacker, fashionTag)
    end
end

function BattleActorMgr:_playCueList(target, cues, attacker, fashionTag, delayTime)
    if not target then
        return
    end
    if type(cues) ~= 'table' then
        self:tryPlayCue(target, cues, attacker, fashionTag, delayTime)
        return
    end
    for i, cueId in ipairs(cues) do
        self:tryPlayCue(target, cueId, attacker, fashionTag, delayTime)
    end
end

function BattleActorMgr:shouldPlayCue(cueId)
    return CueManager.shouldPlayCue(cueId, false, true)
end
-- 这里面的参数target，是指cue挂接的target.
-- 而attackerId是指真正的进攻者, 两者可能为一个人.
function BattleActorMgr:tryPlayCue(target, cueId, attacker, fashionTag, delayTime)
    if self:shouldPlayCue(cueId) then
        target:PlayCue(cueId, attacker, fashionTag, delayTime)
    end
end

function BattleActorMgr:onPause()
    for _, actor in pairs(self.actors) do
        actor.pauseDict['battle'] = true
        actor.pauseEffDict['battle'] = true
        actor:refreshPause()
    end
    --self.animMgr:onPause()
    CueManager.pauseTimerCue()
    CameraManager.PauseCameraAnimator(1)
end

function BattleActorMgr:onResume()
    for _, actor in pairs(self.actors) do
        actor.pauseDict['battle'] = nil
        actor.pauseEffDict['battle'] = nil
        actor:refreshPause()
        --actor:refreshMana()
    end
    --self.animMgr:onResume()
    CueManager.resumeTimerCue()
    CameraManager.PauseCameraAnimator(0)
    --if BattleConst.DebugUseOldFightingUI then
    --    --local battleDlg = UIManager.tryGetUI(self.battleState.mainDlgName)
    --    --if battleDlg and battleDlg.onResume then
    --    --    battleDlg:onResume()
    --    --end
    --end
end

function BattleActorMgr:onBattleWave(wave, maxWave)
    if self.showActor then
        self.showActor:onShowSummonAnim()
    end
end

function BattleActorMgr:onAddTrap(trapId, coordX, coordY)
    --local trapData = ResBattleTrap[trapId]
    --if trapData and trapData.effect then
    --    --if not self.trapDict then
    --    --    self.trapDict = {}
    --    --end
    --    --local newData = { trapId, coordX, coordY }
    --    --local pos = self:getGridPosition(coordX, coordY)
    --    --newData[4] = EffectCueMediator.getFreedomEffectAsync(trapData.effect, pos, nil, true, Const.EFFECT_LIFE_MODE.LogicControl, 0)
    --    --table.insert(self.trapDict, newData)
    --end
end

function BattleActorMgr:onDelTrap(trapId, coordX, coordY)
    --if self.trapDict then
    --    for index, info in ipairs(self.trapDict) do
    --        if info[1] == trapId and info[2] == coordX and info[3] == coordY then
    --            EffectCueMediator.releaseEffect(info[4])
    --            table.remove(self.trapDict, index)
    --            break
    --        end
    --    end
    --end
    --local trapData = ResBattleTrap[trapId]
    --if trapData and trapData.del_effect then
    --    local pos = self:getGridPosition(coordX, coordY)
    --    EffectCueMediator.getFreedomEffectAsync(trapData.del_effect, pos, nil, true)
    --end
end

function BattleActorMgr:onAddWeather(weather)

end

function BattleActorMgr:onDelWeather(weather)

    self:checkWeatherEff()
end

function BattleActorMgr:checkWeatherEff()

end

function BattleActorMgr:clearWeatherEff()
    -- 天气特效

end

function BattleActorMgr:checkRelicCue()
    -- 布景特效
    --if self.battleState.battleRelic and self.battleState.battleRelic.battleCue and self.battleState.sceneTrans.centerPointGo then
    --    self.heroCueInst = {}
    --    for index, cueId in ipairs(self.battleState.battleRelic.battleCue) do
    --        self.heroCueInst[cueId] = CueManager.playCue(self.battleState.sceneTrans.centerPointGo, cueId)
    --    end
    --end
end

function BattleActorMgr:clearRelicCue()
    -- 布景特效
    if self.heroCueInst then
        for cueId, insId in pairs(self.heroCueInst) do
            CueManager.releaseCue(nil, cueId, insId)
        end
        self.heroCueInst = nil
    end
end

function BattleActorMgr:onActionEnd(actionEnd)
    self.actionEnd = actionEnd
    for _, actor in pairs(self.actors) do
        --actor:refreshMana()
    end
end

function BattleActorMgr:onSpecialDamageRecord(actId, isInit, args)
    --if BattleConst.DebugUseOldFightingUI then
    --    --local battleDlg = UIManager.tryGetUI(self.battleState.mainDlgName)
    --    --if battleDlg and battleDlg.panelBossBlood then
    --    --    battleDlg.panelBossBlood:onSpecialDamageRecord(isInit, args)
    --    --elseif isInit then
    --    --    self.specialDamageArgs = args
    --    --end
    --end
end



function BattleActorMgr:clearAllTrap()
    --if self.trapDict then
    --    for _, info in ipairs(self.trapDict) do
    --        EffectCueMediator.releaseEffect(info[4])
    --    end
    --    self.trapDict = nil
    --end

end

function BattleActorMgr:onActorSkillHide()
    EffectCueMediator.hideEffectGroup(0)
    self.sceneEfxHide = true
end

function BattleActorMgr:onActorSkillHideCancel()
    if self.sceneEfxHide then
        EffectCueMediator.reshowEffectGroup(0)
        self.sceneEfxHide = nil
    end
end

function BattleActorMgr:onSkillPause()
    if not self.inSkillPause then
        self.inSkillPause = true
    end
end

function BattleActorMgr:cancelSkillPause()
    if self.inSkillPause then
        self.inSkillPause = false
    end
end

return BattleActorMgr
