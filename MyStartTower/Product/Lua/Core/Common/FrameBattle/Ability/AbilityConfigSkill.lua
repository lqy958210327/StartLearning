local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local ResAttackEffect = AbilityDataTable.ResAttackEffect
local BattleConst = AbilityDataTable.BattleConst
local SkillData = AbilityDataTable.SkillData
local ResProbConfig = AbilityDataTable.ResProbConfig

local AbilityConfigSkill = {}

local ChooseFuncTable = {}
 
ChooseFuncTable[0] = function (baseUnit) -- 0：基点
    return baseUnit:filterSelf()
end


-- 1：基点+基点背后一格
-- 2：基点+自身左右扇形
-- 22：基点+基点同一行背后一格


ChooseFuncTable[3] = function (baseUnit) -- 3：基点+基点周围一格
    return baseUnit:filterDistance(1)
end


ChooseFuncTable[21] = function (baseUnit) -- 21：基点+基点周围两格
    return baseUnit:filterDistance(2)
end


ChooseFuncTable[4] = function (baseUnit) -- 4：基点当前行
    return baseUnit:filterDistanceY(0)
end


ChooseFuncTable[5] = function (baseUnit) -- 5：基点当前及相邻行
    return baseUnit:filterDistanceY(1)
end


ChooseFuncTable[9] = function (baseUnit) -- 9：基点当前行最后排
    return baseUnit:filterAnd(baseUnit:filterDistanceY(0), baseUnit:filterForward()), -1
end


ChooseFuncTable[18] = function (baseUnit) -- 18：基点当前行前排
    return baseUnit:filterAnd(baseUnit:filterDistanceY(0), baseUnit:filterForward()), 1
end


ChooseFuncTable[19] = function (baseUnit) -- 19：阵营前排
    return baseUnit:filterFront()
end

ChooseFuncTable[20] = function (baseUnit) -- 20：阵营后排
    return baseUnit:filterBack()
end

ChooseFuncTable[25] = function (baseUnit) -- 25：阵营最后排
    return baseUnit:filterBack()
end


ChooseFuncTable[7] = function (baseUnit) -- 7：阵营全体
    return baseUnit:filterTrue()
end

ChooseFuncTable[10] = function (baseUnit) -- 10：阵营全体（不包含召唤物）
    return baseUnit.filterMajor()
end


ChooseFuncTable[26] = function (baseUnit) -- 26：同路中排
end


ChooseFuncTable[27] = function (baseUnit) -- 27：全场中排
end


ChooseFuncTable[28] = function (baseUnit) -- 28：镜像目标
end

ChooseFuncTable[8] = function (baseUnit) -- 8：阵营血量最低
    return baseUnit:filterAttr('hp'), -1
end


ChooseFuncTable[13] = function (baseUnit) -- 13：阵营血量百分比最低
    return baseUnit:filterAttr('hppct'), -1
end


ChooseFuncTable[11] = function (baseUnit) -- 11：阵营血量最低（不包含召唤物）
    return baseUnit:filterAnd(baseUnit.isMajor, baseUnit:filterAttr('hp')), -1
end

ChooseFuncTable[14] = function (baseUnit) -- 14：阵营血量百分比最低（不包含召唤物）
    return baseUnit:filterAnd(baseUnit.isMajor, baseUnit:filterAttr('hppct')), -1
end


ChooseFuncTable[24] = function (baseUnit) -- 24：阵营已退场英雄
end


ChooseFuncTable[17] = function (baseUnit) -- 17：基点自己的所有召唤物
    return baseUnit:filterMyMinor()
end

ChooseFuncTable[16] = function (baseUnit) -- 16：基点友方的所有召唤物
    return baseUnit:filterMinor()
end

ChooseFuncTable[12] = function (baseUnit) -- 12：使用记录的技能目标
end

ChooseFuncTable[23] = function (baseUnit) -- 23：自身的普攻目标
end

local function getBaseUnitAndTargetCamp(self, resEvent, aimUnit)
    local ownerUnit = self:getOwnerUnit()
    local friendCamp = ownerUnit:getCamp()
    local enemyCamp = ownerUnit:getEnemyCamp()
    local baseUnit = aimUnit
    local camp = enemyCamp
    local targetArea = resEvent.targetArea or 0
    if targetArea == 0 then -- 0：敌方。同时以目标为基点
        baseUnit, camp = aimUnit, enemyCamp
    elseif targetArea == 1 then -- 1：友方。同时以目标为基点
        baseUnit, camp = aimUnit, friendCamp
    elseif targetArea == 2 then -- 2：敌方。同时以自身为基点
        baseUnit, camp = ownerUnit, enemyCamp
    elseif targetArea == 3 then -- 3：友方。同时以自身为基点
        baseUnit, camp = ownerUnit, friendCamp
    elseif targetArea == 4 then -- 4：目标的友方。同时以目标为基点
        baseUnit, camp = aimUnit, aimUnit:getCamp()
    elseif targetArea == 5 then -- 5：目标的敌方。同时以目标为基点
        baseUnit, camp = aimUnit, aimUnit:getEnemyCamp()
    end
    return baseUnit, camp
end

-- 这里的目标选择用作"攻击事件生效时候的目标选择"，与"释放技能前判定所选目标是否合法"区分
local function getSkillEventTargets(self, resEvent, aimUnit)
    if resEvent.priorUsePreTarget == 1 then -- 使用上一次的目标
        if self.eventBaseUnit:isAlive() then
            return self.eventTargetList, self.eventBaseUnit
        end
    end
    local targetChoose = resEvent.targetChoose
    if targetChoose == 12 then -- 使用记录的技能目标
        return self.eventTargetList, self.eventBaseUnit
    end
    local ownerUnit = self:getOwnerUnit()
    local baseUnit, camp = getBaseUnitAndTargetCamp(self, resEvent, aimUnit)
    local targetFunc = ChooseFuncTable[resEvent.targetChoose or 0]
    if targetFunc == nil then
        return nil, baseUnit
    end
    local filterChoose, max = targetFunc(baseUnit)
    local filterCamp = baseUnit:filterCamp(camp)
    local excludeTarget = resEvent.excludeTarget and resEvent.excludeTarget > 0
    local filterExclude = excludeTarget and baseUnit:filterNotSelf() or baseUnit:filterTrue()
    local filterPreCondition = ownerUnit:filterCondition(resEvent.eventPreCondition)
    local filter = ownerUnit:filterAnd(filterCamp, filterExclude, filterPreCondition, filterChoose)
    local targets
    if max == nil then
        targets = ownerUnit:searchUnit(filter)
    elseif max > 0 then
        targets = { ownerUnit:maxUnit(filter) }
    else
        targets = { ownerUnit:minUnit(filter) }
    end
    local filterCondition = ownerUnit:filterCondition(resEvent.eventCondition)
    local resProb = resEvent.eventProbId and ResProbConfig[resEvent.eventProbId]
    local skillLevel = self:getSkillLevel()
    local prob = resProb and resProb.prob_values[skillLevel]
    local filterProb = prob and ownerUnit:filterProb(prob) or baseUnit:filterTrue()
    local postFilter = ownerUnit:filterAnd(filterCondition, filterProb)
    local randomRule = resEvent.randomRule or 0
    if randomRule == 0 then -- 纯随机
        self:randomShuffle(targets)
    elseif randomRule == 7 then -- 7：血量百分比从低到高的N个目标
        table.sort(targets, function (a, b)
            return a:getAttr('hppct') > b:getAttr('hppct')
        end)
    elseif randomRule == 8 then -- 8：血量百分比从高到低的N个目标
        table.sort(targets, function (a, b)
            return a:getAttr('hppct') < b:getAttr('hppct')
        end)
    elseif randomRule == 9 then -- 9：攻击从低到高的N个目标
        table.sort(targets, function (a, b)
            return a:getAttr('final_atk') > b:getAttr('final_atk')
        end)
    elseif randomRule == 10 then -- 10：攻击从高到低的N个目标
        table.sort(targets, function (a, b)
            return a:getAttr('final_atk') < b:getAttr('final_atk')
        end)
    end
    local targetList = {}
    local randomTargetNumber = resEvent.randomTargetNumber or #targets
    if randomTargetNumber > #targets then
        randomTargetNumber = #targets
    end
    for i = 1, randomTargetNumber do
        local unit = targets[i]
        if postFilter(unit) then
            table.insert(targetList, unit)
        end
    end
    if resEvent.recordSkillTargets and resEvent.recordSkillTargets > 0 then
        self.eventTargetList, self.eventBaseUnit = targetList, baseUnit
    end
    return targetList, baseUnit
end

local BOX_TYPE_PHYSICS = 0      --0物理
local BOX_TYPE_HEAL = 3         --3治疗
local BOX_TYPE_SHIELD = 4       --4护盾
local BOX_TYPE_HP_REMOVE = 5    --5生命移除

-- 初始攻击结果计算
local function calcAttackDamage(ownerUnit, targetUnit, resAttackEffect)
    local attack = ownerUnit:getAttr('atk')
    if resAttackEffect.use_hero_atk and ownerUnit:hasAttr('heroAtk') then
        attack = ownerUnit:getAttr('heroAtk') --宠物用的，取英雄平均攻击力
    end
    local damageAmount = (resAttackEffect.dmg_percent or 0) * attack * 0.0001 + (resAttackEffect.dmg_value or 0)
    local cap = resAttackEffect.percent_limit and attack * resAttackEffect.percent_limit / 10000 or nil
    local function addDamage(paramName, attrValue)
        local percent = resAttackEffect[paramName]
        if percent then
            local value = attrValue * percent / 10000
            if cap and value > cap then
                value = cap
            end
            damageAmount = damageAmount + value
        end
    end
    local selfHp, selfMhp = ownerUnit:getAttr('hp'), ownerUnit:getAttr('final_mhp')
    local targetHp, targetMhp = targetUnit:getAttr('hp'), targetUnit:getAttr('final_mhp')
    addDamage( 'self_hp_percent', selfHp)
    addDamage( 'self_mhp_percent', selfMhp)
    addDamage('extra_hp_lost', selfMhp - selfHp)
    addDamage('taret_hp_lost', targetMhp - targetHp)
    addDamage('hp_percent', targetHp)
    addDamage('mhp_percent', targetMhp)
    addDamage( 'self_shield_percent', ownerUnit:getAttr('shield')) --FIXME 护盾属性
    addDamage( 'target_shield_percent', targetUnit:getAttr('shield')) --FIXME 护盾属性
    local selfLayer = resAttackEffect.filter_attack_state and ownerUnit:getStateLayer(resAttackEffect.filter_attack_state, ownerUnit) or 0
    local targetLayer = resAttackEffect.filter_target_state and targetUnit:getStateLayer(resAttackEffect.filter_target_state, ownerUnit) or 0
    if resAttackEffect.filter_attacker_state and resAttackEffect.filter_target_dmg then
        damageAmount = damageAmount + resAttackEffect.filter_target_dmg * attack * selfLayer / 10000
    end
    if resAttackEffect.filter_target_state and resAttackEffect.filter_target_dmg then
        damageAmount = damageAmount + resAttackEffect.filter_target_dmg * attack * targetLayer / 10000
    end
    if resAttackEffect.target_debuff_dmg then
        local count = targetUnit:countAbilityWithTag('debuff')
        damageAmount = damageAmount + resAttackEffect.target_debuff_dmg * attack * count / 10000
    end
    if resAttackEffect.state_extra_rate then
        if selfLayer > 0 or targetLayer > 0 then
           damageAmount = damageAmount * (10000 + resAttackEffect.state_extra_rate) / 10000
        end
    end
    if resAttackEffect.dis_percent then
        local distance = ownerUnit:getDistance(targetUnit)
        damageAmount = damageAmount * (10000 + distance * resAttackEffect.dis_percent) / 10000
    end
    return damageAmount
end

function AbilityConfigSkill:onCheckSkillAim()
    local ownerUnit = self:getOwnerUnit()
    local skillTarget = self.resSkill.skillTarget or 0
    if skillTarget == 0 then -- 0：普攻目标（面前的目标）
        return ownerUnit:findNormalTarget()
    elseif skillTarget == 1 then -- 1：自身
        return ownerUnit
    elseif skillTarget == 2 then -- 2：普攻目标的当前行的最后排敌方
    elseif skillTarget == 3 then -- 3：血量最少的友方
        local filter = ownerUnit:filterAnd(ownerUnit:filterFriend(), ownerUnit:filterAttr('hp'))
        return ownerUnit:minUnit(filter)
    elseif skillTarget == 4 then -- 4：血量最少的敌方
        local filter = ownerUnit:filterAnd(ownerUnit:filterEnemy(), ownerUnit:filterAttr('hp'))
        return ownerUnit:maxUnit(filter)
    elseif skillTarget == 5 then -- 5：穿过大体型的普攻目标
    elseif skillTarget == 6 then -- 6：被集火目标
        return ownerUnit:findAimedTarget()
    else -- 0：普攻目标（面前的目标）
        return ownerUnit:findNormalTarget()
    end
end

function AbilityConfigSkill:onPrepareSkillParams()
    local ownerUnit = self:getOwnerUnit()
    local cardInfo = self.cardInfo
    local cardType = cardInfo.cardType
    if cardType then
        local skillCd = cardInfo.skillCd --计算下次冷却时间
        local cdr = ownerUnit:getAttr('final_skill_cdr_'..cardType)
        local cd = skillCd * (10000 - cdr) / 10000
        if cardInfo.useSpeedUp then
            local speedUp = 10000 + ownerUnit:getAttr('final_attack_speed_up')
            if speedUp > 0 then
                cd = cd * 10000 / speedUp
            end
        end
        cardInfo.nextCd = cd
    end
    return self.skillId, cardInfo.cardId, cardType
end

function AbilityConfigSkill:onPrepareSkillBehavior()
    local cardInfo = self.cardInfo
    local resSkill = self.resSkill
    local attackTime = cardInfo.useSpeedUp and cardInfo.nextCd
    return resSkill.bhEvent, attackTime
end

function AbilityConfigSkill:onPrepareSkillDisplay()
    local ownerUnit = self:getOwnerUnit()
    local resSkill = self.resSkill
    local hero = ownerUnit:isHero()
    local player = ownerUnit:getCamp() == 1
    --己方英雄：Timeline/视频/CutIn+动作
    --敌方英雄：TimeLine+动作
    --敌方怪物：Timeline
    --优先：Timeline>视频>CutIn
    local actTime = hero and resSkill.actTime or 0
    local timelineTime = resSkill.timelineTime or 0
    local videoTime = player and hero and timelineTime <= 0 and ownerUnit:isLongSkill() and resSkill.videoActTime or 0
    local cutinTime = player and hero and timelineTime <= 0 and videoTime <= 0 and resSkill.shortVideoActTime or 0
    local showType = (timelineTime > 0 and 1) or (videoTime > 0 and 2) or (cutinTime > 0 and 3) or 0
    local videoCue = showType == 2 and resSkill.videoActCue or nil
    local showTime = timelineTime + videoTime + cutinTime
    local pauseTime = showTime + actTime
    return pauseTime / 30, showTime / 30, showType, videoCue
end

function AbilityConfigSkill:onPrepareSkillPredict(aimUnit)
    local resSkill = self.resSkill
    local resEvent = resSkill.atkEvents[resSkill.hideEvent]
    return resEvent and getSkillEventTargets(self, resEvent, aimUnit)
end

function AbilityConfigSkill:onPrepareSkillAtk(eventId, aimUnit)
    local resEvent = self.resSkill.atkEvents[eventId]
    if not resEvent then
        return
    end
    local targetList = getSkillEventTargets(self, resEvent, aimUnit)
    if resEvent.atkCue then
        local ownerUnit = self:getOwnerUnit()
        self:playCue(ownerUnit, resEvent.atkCue.cueList)
    end
    if resEvent.baseCue then
        local baseUnit, camp = getBaseUnitAndTargetCamp(self, resEvent, aimUnit)
        self:playCue(baseUnit, resEvent.baseCue.cueList)
    end
    return targetList
end

function AbilityConfigSkill:onSelfSkillAtk(eventId, aimUnit)
    local resEvent = self.resSkill.atkEvents[eventId]
    local subEventSkill = resEvent and resEvent.subEventSkill or 0
    if subEventSkill > 0 then
        local subEventId = resEvent.subEventId or 0
        if subEventId > 0 then
            local ownerUnit = self:getOwnerUnit()
            local cardInfo = self.cardInfo
            self:triggerSkillEvent(ownerUnit, aimUnit, subEventSkill, subEventId, self:getSkillLevel())
        end
    end
end

function AbilityConfigSkill:onPrepareSkillHit(eventId, aimUnit, targetUnit)
    local ownerUnit = self:getOwnerUnit()
    local resEvent = self.resSkill.atkEvents[eventId]
    local flyBaseUnit = resEvent.baseToTarget == 1 and aimUnit or ownerUnit
    local flyTime = (resEvent.delay or 0) + flyBaseUnit:getDistance(targetUnit) * (resEvent.unitDelay or 0)
    local flyCueId = resEvent.flyCueId or 0
    if flyCueId > 0 then
        self:playCue(targetUnit, flyCueId, flyBaseUnit, flyTime)
    end
    return flyTime
end

function AbilityConfigSkill:onSelfSkillHit(eventId, aimUnit, targetUnit)
    local resEvent = self.resSkill.atkEvents[eventId]
    if resEvent.rebornMhp then
        self:reborn(targetUnit, resEvent.rebornMhp, resEvent.rebornMana or 0)
    end
    local ownerUnit = self:getOwnerUnit()
    local hited = resEvent.cantBeDodged or ownerUnit:isFriend(targetUnit) or self:checkHitChance(targetUnit, self.cardInfo.cardType, resEvent.disablePassive)
    if not hited then
        return
    end
    if resEvent.hitCue then
        self:playCue(targetUnit, resEvent.hitCue.cueList)
    end
    if resEvent.hitedAnim then
        self:playHitAnim(targetUnit, resEvent.hitedAnim)
    end
    if resEvent.hitedOffset then
        self:playHitOffset(targetUnit, resEvent.hitedOffset)
    end
    local skillLevel = self:getSkillLevel()
    -- 位移
    local movingFlash = resEvent.movingFlash
    if movingFlash and movingFlash > 0 then
        self:attackMovingFlash(targetUnit, movingFlash)
    end
    local movingSwap = resEvent.movingSwap
    if movingSwap and movingSwap > 0 then
        self:attackMovingSwap(targetUnit)
    end
    local movingBackDistance = resEvent.movingBackDistance
    if movingBackDistance and movingBackDistance > 0 then
        local movingBackSpeed = resEvent.movingBackSpeed
        self:attackMovingBack(targetUnit, movingBackDistance, movingBackSpeed)
    end
    -- 控制
    local stunOperation = resEvent.stunOperation -- 0 添加 1 消除 2 取消
    if stunOperation == 0 or stunOperation == nil then
        local skipImmunityControl = resEvent.skipImmunityControl == 1
        local stunTime = resEvent.stunTime
        if stunTime and stunTime > 0 then
            self:attackControl(targetUnit, 'stun', stunTime, skipImmunityControl)
        end
        local controlTime = resEvent.controlTime
        if controlTime and controlTime > 0 then
            local controlAniName = resEvent.controlAniName
            self:attackControl(targetUnit, controlAniName, controlTime, skipImmunityControl)
        end
    elseif stunOperation == 1 then --取消
        local controlAniName = resEvent.controlAniName
        self:attackControlDel(targetUnit, controlAniName)
    elseif stunOperation == 1 then --延长
        local controlAniName = resEvent.controlAniName
        local controlTime = resEvent.controlTime or resEvent.stunTime
        if controlTime and controlTime > 0 then
            self:attackControlExtend(targetUnit, controlAniName, controlTime)
        end
    end
    -- 状态
    local state = resEvent.state
    if state then
        local stateOpt = state.stateOperation or 0  -- 状态操作 0 添加 1 消除 2 延长 3 转移基点状态
        local duration = state.duration
        duration = duration and (duration > 0 or duration == BattleConst.STATE_DURATION_UNLIMIT) and duration or 0
        if stateOpt == 0 then -- 0 添加
            local stateId = state.stateId or 0
            if stateId > 0 then
                self:incStateLayer(targetUnit, stateId, skillLevel, 1, duration)
            end
        elseif stateOpt == 1 then -- 1 消除
            local selectType = state.chooseStateType or 0
            local selectMode = state.chooseStateMode or 0
            local randomCount = state.chooseRandomNum
            local selectIds = state.chooseStateIds
            local function filterType(ability)
                return selectType == 0 or (selectType == 1 and ability:hasStateTag('buff')) or (selectType == 2 and ability:hasStateTag('debuff'))
            end
            local function filterId(ability)
                for _, id in ipairs(selectIds) do
                    if ability.stateId == id then
                        return true
                    end
                end
                return false
            end
            local stateList
            if selectMode == 0 then -- 0 随机
                stateList = targetUnit:randomListAbility(filterType, randomCount)
                targetUnit:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, { BattleConst.ENTITY_SOMETHING_DEL_STATE })
            elseif selectMode == 1 then -- 1 全部
                stateList = targetUnit:searchAbility(filterType)
                targetUnit:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, { BattleConst.ENTITY_SOMETHING_DEL_STATE })
            elseif selectMode == 2 then -- 2 指定ID
                stateList = targetUnit:searchAbility(filterId)
            end
            for _, ability in ipairs(stateList) do
                self:delAbility(targetUnit, ability)
            end
        end
    end
    -- 能量变化
    local addMana = resEvent.addManaNumber or 0
    local notShow = resEvent.manaNotShow == 1
    self:attackChangeMana(targetUnit, addMana, notShow)
    -- 召唤
    local summonMonsters = resEvent.summonMonsters
    if summonMonsters then
        local attrFromUnit = resEvent.summonAttr and targetUnit or nil
        for match in string.gmatch(summonMonsters, "[^,]+") do
            local monsterId = tonumber(match)
            local summonLineChoose = resEvent.summonLineChoose or 0
            local refUnit = summonLineChoose >= 10 and targetUnit or self:getOwnerUnit()
            local chooseLine = summonLineChoose % 10
            local diffY = 0
            if chooseLine == 1 then
                diffY = 1
            elseif chooseLine == 2 then
                diffY = 2
            elseif chooseLine == 3 then
                diffY = -1
            elseif chooseLine == 4 then
                diffY = -2
            end
            local grid = refUnit:findEmptyGridByLine(diffY)
            if grid then
                self:summonMonster(grid, monsterId, attrFromUnit)
            end
        end
    end
    -- 天气
    local weatherFlag = resEvent.weatherFlag
    if weatherFlag then
        self:changeWeather(weatherFlag, resEvent.weatherTime)
    end
    -- 伤害
    local boxId = resEvent.boxId
    if boxId then
        local skillType = self.cardInfo and self.cardInfo.cardType or self.Enum.SkillType.BeiDong
        local effectData = ResAttackEffect[boxId]
        local resAttackEffect = effectData and effectData[skillLevel]
        if not resAttackEffect then
            return
        end
        local boxType = resAttackEffect.dmg_type or BOX_TYPE_PHYSICS
        local elemType = resAttackEffect.elem_type
        local ownerUnit = self:getOwnerUnit()
        local damageBase = calcAttackDamage(ownerUnit, targetUnit, resAttackEffect) --第一步  根据攻击力等计算基础数值
        local critDmgAdd = resAttackEffect.cri_dmg_add or 0
        if boxType == BOX_TYPE_PHYSICS then      --0物理
            self:attackDamage(targetUnit, damageBase, skillType, elemType, resEvent.disablePassive, critDmgAdd)
        elseif boxType == BOX_TYPE_HP_REMOVE then    --5生命移除
            self:attackLoss(targetUnit, damageBase, skillType, resEvent.disablePassive)
        elseif boxType == BOX_TYPE_HEAL then    --3治疗
            self:attackHeal(targetUnit, damageBase, skillType, resEvent.disablePassive)
        elseif boxType == BOX_TYPE_SHIELD then    --4护盾
            self:attackShield(targetUnit, damageBase, skillType, resAttackEffect.shield_time, resEvent.disablePassive)
        end
    end
end


local function newAbilityConfigSkill(skillId)
    return function (ability)
        local resSkill = SkillData[skillId]
        ability:getLogger():trace('SkillData', skillId, resSkill)
        ability.skillId = skillId
        ability.resSkill = resSkill
        ability:registerTriggerTable(AbilityConfigSkill)
    end
end

return newAbilityConfigSkill