local getImpl = require "Core/Common/FrameBattle/Ability/getImpl"
local Group = require("Core/Common/FrameBattle/Ability/Group")
local AbilityTrigger = require("Core/Common/FrameBattle/Ability/AbilityTrigger")
local CombatFSM = require("Core/Common/FrameBattle/Behavior/CombatFSM")
local AbilityUnitAttr = require("Core/Common/FrameBattle/Ability/AbilityUnitAttr")
local AbilityUnitStat = require("Core/Common/FrameBattle/Ability/AbilityUnitStat")
local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local BattleConst = AbilityDataTable.BattleConst
local BattleMiscConfig = AbilityDataTable.BattleMiscConfig
local ResHeroData = AbilityDataTable.ResHeroData
local ResMonsterTypeData = AbilityDataTable.ResMonsterTypeData
local ResMonsterAttrData = AbilityDataTable.ResMonsterAttrData

local MAX_MANA = BattleConst.MAX_MANA

local MatrixEvent = {}
for k, v in pairs(BattleConst) do
    if string.sub(k, 1, 13) == 'MATRIX_EVENT_' then -- 检查前缀
        MatrixEvent[v] = string.sub(k, 14) -- 截取前缀之后的部分
    end
end

local AbilityUnitImpl = {}

function AbilityUnitImpl:toString()
    return self.name
end
function AbilityUnitImpl:log(...)
    return self.logger:debug(...)
end

function AbilityUnitImpl:addOutput(outputType, args)
    self.logger:trace('addOutput', MatrixEvent[outputType] or outputType, args)
    self.matrixAbility:addMatrixOutput(outputType, args, self.id)
end

function AbilityUnitImpl:getEnemyCamp()
    return #self.matrixAbility.initCamp - self.camp + 1
end

function AbilityUnitImpl:getForward()
    return self.camp == 1 and 1 or -1
end

function AbilityUnitImpl:getAttr(attrName)
    return self.attr:getAttr(attrName)
end
function AbilityUnitImpl:addAttr(attrName, addValue)
    self.attr:addAttr(attrName, addValue)
end
function AbilityUnitImpl:setAttr(attrName, value)
    self.attr:setAttr(attrName, value)
end

local UpdateAttr = {}
function UpdateAttr.final_mhp(self, oldValue, value)
    local oldHp = self:getAttr('hp')
    if oldHp > 0 then --alive
        local addHp = math.max(value - oldValue, 0)
        local newHp = math.min(oldHp + addHp, value)
        if newHp == oldHp then
            local hppct = math.floor(newHp * 10000 / value)
            self:setAttr('hppct', hppct)
            self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE, { oldHp, newHp, value })
        else
            self:setAttr('hp', newHp)
        end
    end
end
function UpdateAttr.hp(self, oldValue, value)
    local mhp = self:getAttr('final_mhp')
    local hppct = math.floor(value * 10000 / mhp)
    self:setAttr('hppct', hppct)
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE, { oldValue, value, mhp })
    AbilityTrigger.unit(self.abilityUnit, 'onOwnerHpChange', value, hppct)
    local hp = self:getAttr('hp') -- 重新获取HP值。被动技能可能阻止了本次死亡。
    if hp <= 0 then
        self:die()
    end
end

function UpdateAttr.final_mana_gen(self, oldValue, value)
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SETMANA, { self:getAttr('mana'), MAX_MANA, value })
end

function UpdateAttr.max_shield(self, oldValue, value)
    local oldShield = self:getAttr('shield')
    local addShield = math.max(value - oldValue, 0)
    local newShield = math.min(oldShield + addShield, value)
    if newShield ~= oldShield then
        self:setAttr('shield', newShield)
    else
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE, { newShield, value })
        AbilityTrigger.unit(self.abilityUnit, 'onOwnerShieldChange', newShield, value)
    end
end

function UpdateAttr.shield(self, oldValue, value)
    local maxShield = self:getAttr('max_shield')
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE, { value, maxShield })
        AbilityTrigger.unit(self.abilityUnit, 'onOwnerShieldChange', value, maxShield)
end
function AbilityUnitImpl:updateAttr(attrName, oldValue, value)
    local updateFunc = UpdateAttr[attrName]
    if updateFunc then
        updateFunc(self, oldValue, value)
    end
end
function AbilityUnitImpl:isImmune(immuneName)
    return self:getAttr(immuneName) > 0
end

function AbilityUnitImpl:getFrameNumber()
    return self.matrixAbility.frameNumber
end
function AbilityUnitImpl:getRealFrameNumber()
    return self.matrixAbility.realFrameNumber
end
function AbilityUnitImpl:updateFrame(frameNumber, realFrameNumber)
    local function tick(ability)
        ability:tick(frameNumber, realFrameNumber)
    end
    self.abilityGroup:forEach(tick)
    if self.abilityUnit:isDead() then
        self.logger:tick('updateframe', 'dead')
        return
    end
    if self.moveHalfFrame then
        if frameNumber >= self.moveHalfFrame then
            self.logger:trace('updateframe', 'realMove')
            self.moveHalfFrame = nil
            self:setRealCoord()
        else
            self.logger:tick('updateframe', 'half')
            return
        end
    end
    if self.moveEndFrame then
        if frameNumber >= self.moveEndFrame then
            self.logger:trace('updateframe', 'stopMove')
            self:stopMove()
        else
            self.logger:tick('updateframe', 'move')
            return
        end
    end
    if self.flashEndFrame then
        if frameNumber >= self.flashEndFrame then
            self.logger:trace('updateframe', 'stopFlash')
            self:stopFlash()
        else
            self.logger:tick('updateframe', 'flash')
            return
        end
    end
    if self.resumePauseFrame then
        if frameNumber >= self.resumePauseFrame then
            self.logger:trace('updateframe', 'unpause')
            self.resumePauseFrame = nil
            if not self.skillSelf then
                if self.behaviorFSM then
                    self.behaviorFSM:cancelPauseBH()
                end
            end
            self.skillSelf = nil
        else
            self.logger:tick('updateframe', 'pause')
            return
        end
    end
    if not self.skillSelf then
        self:genMana() --大招表演期间暂停回蓝
        if self.skillInput and self.usingSkill and self:getAttr('mana') == MAX_MANA then -- 手动放大招，打断普攻、战技
            self:onSkillInterupt()
        end
    end
    if not self.behaviorFSM or not self.behaviorFSM:canUseSkill() then -- 无法释放技能/主动移动
        self.logger:tick('updateframe', 'busy')
        return
    end
    if self.matrixAbility.holdPos then
        self:startMove()
        if self.moveEndFrame then
            self.logger:trace('updateframe', 'startMove')
            return
        end
        self:useSkill()
        if self.usingSkill then
            self.logger:trace('updateframe', 'skill')
            return
        end
    else
        self:useSkill()
        if self.usingSkill then
            self.logger:trace('updateframe', 'skill')
            return
        end
        self:startMove()
        if self.moveEndFrame then
            self.logger:trace('updateframe', 'startMove')
            return
        end
    end
    self.logger:tick('updateframe', 'idle')
    --if self.behaviorFSM then
    --    self.behaviorFSM:onToWait()
    --end
end

function AbilityUnitImpl:changeMana(changeValue, isKill, notShow)
    local oldMana = self:getAttr('mana')
    if changeValue < 0 and self:isImmune('immuneReduceMana') then
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, { BattleConst.STATE_IMMUNE_REDUCE_MANA })
        return
    end
    local change = changeValue <= 0 and changeValue or changeValue * (10000 + self:getAttr('final_mana_genrate')) / 10000
    local mana = math.max(0, math.min(oldMana + change, MAX_MANA))
    if mana ~= oldMana then
        self:setAttr('mana', mana)
        local gen = self:getAttr('final_mana_gen')
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SETMANA, { mana, MAX_MANA, gen })
    end
    if not notShow then
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MANA_CHANGED, {change, isKill})
    end
end

function AbilityUnitImpl:genMana()
    local gen = self:getAttr('final_mana_gen')
    local oldMana = self:getAttr('mana')
    local changeValue = gen * self.frameLength / 1000
    local mana = math.max(0, math.min(oldMana + changeValue, MAX_MANA))
    if mana ~= oldMana then
        self:setAttr('mana', mana)
        if mana == MAX_MANA or mana == 0 then
            self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SETMANA, { mana, MAX_MANA, gen })
        end
    end
end

function AbilityUnitImpl:applyHit(attackerUnit, damageType, damage, isCrit, skillType, disablePassive)
    local attacker = getImpl(attackerUnit)
    local target = self
    local targetUnit = self.abilityUnit
    if target.inSpecialControlled and target.behaviorFSM then
        target.behaviorFSM:onToIdle()
    end
    local attackerId = attackerUnit:getId()
    local skillDamage = attacker:skillDamage(damage, damageType)
    targetUnit:addOutput(BattleConst.MATRIX_EVENT_ENTITY_DAMAGE, { damage, damageType, isCrit, attackerId, skillType, skillDamage })
    local statAttacker = attackerUnit:getMasterUnit() or attackerUnit
    getImpl(statAttacker).stat:recordOneAttack(damageType, damage, isCrit)
    target.stat:recordOneHited(damageType, damage)
    if not disablePassive then
        AbilityTrigger.unit(attackerUnit, 'onOwnerAttackDamage', targetUnit, damage, damageType, isCrit, skillType)
        AbilityTrigger.unit(targetUnit, 'onOwnerBeHitDamage', attackerUnit, damage, damageType, isCrit, skillType)
    end
end

function AbilityUnitImpl:applyShield(attackerUnit, amount, skillType, shieldTime, disablePassive)
    self:addAttr('max_shield', amount)
    self:applyHit(attackerUnit, 'healShield', amount, false, skillType, disablePassive)
end
function AbilityUnitImpl:applyHurtShield(attackerUnit, damage, isCrit, skillType, disablePassive)
    self:addAttr('shield', -damage)
    self:applyHit(attackerUnit, 'hurtShield', damage, isCrit, skillType, disablePassive)
end
function AbilityUnitImpl:applyHeal(attackerUnit, amount, skillType, disablePassive)
    local preHp = self:getAttr('hp')
    --if preHp <= 0 then
    --    return
    --end
    local mhp = self:getAttr('final_mhp')
    local hp = math.min(mhp, preHp + amount)
    local heal = hp - preHp
    if heal <= 0 then
        return
    end
    self:setAttr('hp', hp)
    self:applyHit(attackerUnit, 'healHp', amount, false, skillType, disablePassive)
end

function AbilityUnitImpl:applyHurtHp(attackerUnit, amount, isCrit, skillType, disablePassive)
    local preHp = self:getAttr('hp')
    if preHp <= 0 then
        return
    end
    local minHp = self:getAttr('unDead') > 0 and 1 or 0
    local hp = math.max(minHp, preHp - amount)
    local damage = preHp - hp
    if damage <= 0 then
        return
    end
    self:setAttr('hp', hp)
    self:applyHit(attackerUnit, 'hurtHp', amount, isCrit, skillType, disablePassive)
    local kill = preHp > 0 and self:getAttr('hp') <= 0
    if kill then
        attackerUnit:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, { BattleConst.ENTITY_SOMETHING_KILL_SOMEONE, self.id })
        if not self.resData.kill_no_mana then
            getImpl(attackerUnit):changeMana(BattleConst.KILL_MANA, true)
        end
        local targetUnit = self.abilityUnit
        self.matrixAbility:battleUnitDie(targetUnit)
        AbilityTrigger.unit(targetUnit, 'onOwnerBeHitDie', attackerUnit, skillType)
        AbilityTrigger.unit(attackerUnit, 'onOwnerAttackKill', targetUnit, skillType)
        AbilityTrigger.global(attackerUnit, 'onGlobalKill', attackerUnit, targetUnit)
    end
end
--- 计算伤害后果，如链接、护盾、吸血、反弹
function AbilityUnitImpl:applyDamage(attackerUnit, damageAmount, isCrit, skillType, disablePassive)
    local targetUnit = self.abilityUnit
    local targetList = {}
    local soulLink = self:getAttr('soulLink')
    if damageAmount > 0 and soulLink > 0 then
        local linkDamage = damageAmount * math.min(10000, soulLink) / 10000
        local filter = targetUnit:filterAnd(targetUnit:filterNotSelf(), targetUnit:filterFriend(), targetUnit:filterAlive(), targetUnit:filterHasAttr('soulLink'))
        local unitList = targetUnit:searchUnit(filter)
        local oneDamage = linkDamage / (1 + #unitList)
        table.insert(targetList, {unit = targetUnit, damage = damageAmount - linkDamage + oneDamage})
        for _, linkUnit in ipairs(unitList) do
            table.insert(targetList, {unit = linkUnit, damage = oneDamage})
        end
    else
        table.insert(targetList,{unit = targetUnit, damage = damageAmount})
    end
    for _, hurtInfo in ipairs(targetList) do
        local oneTarget = hurtInfo.unit
        local oneDmg = getImpl(oneTarget):applyHurt(attackerUnit, hurtInfo.damage, isCrit, skillType, disablePassive)
        local vampirePercent = attackerUnit:getAttr('life_steal')
        local vampire = math.floor(oneDmg * vampirePercent / 10000)
        if vampire > 0 then
            getImpl(attackerUnit):applyHeal(attackerUnit, vampire, skillType, disablePassive)
        end
        local rebound = oneTarget:getAttr('damage_reflection')
        if rebound > 0 then
            if not attackerUnit:isImmune('damageImmune') then
                local reboundDamage = math.floor(damageAmount * rebound / 10000)
                getImpl(attackerUnit):applyHurt(oneTarget, reboundDamage, isCrit, skillType, disablePassive)
            end
        end
    end
end

function AbilityUnitImpl:applyHurt(attackerUnit, damage, isCrit, skillType, disablePassive)
    local protection = self:getAttr('damage_protection')
    local hp = self:getAttr('hp')
    local damageMax = hp * (10000 - protection) / 10000
    local oneDmg = math.floor(math.min(damage, damageMax))
    local shield = math.floor(math.min(oneDmg, self:getAttr('shield')))
    oneDmg = oneDmg - shield
    if shield > 0 then
        self:applyHurtShield(attackerUnit, shield, isCrit, skillType, disablePassive)
    end
    if oneDmg > 0 then
        self:applyHurtHp(attackerUnit, oneDmg, isCrit, skillType, disablePassive)
    end
    return oneDmg
end

function AbilityUnitImpl:applyCurse(attackerUnit, attrName, damage, skillType)
    local targetUnit = self.abilityUnit
    local old = self:getAttr(attrName)
    local hp = attrName == 'hp' or attrName == 'mhp'
    local max = hp and (old - 1) or old
    local sub = math.min(max, damage)
    self:addAttr(attrName, -sub)
    self:addOutput( BattleConst.MATRIX_EVENT_ENTITY_STATESHOW, {attrName, true} )
    AbilityTrigger.unit(attackerUnit, 'onOwnerAttackCurse', targetUnit, attrName, damage, skillType)
    AbilityTrigger.unit(targetUnit, 'onOwnerBeHitCurse', attackerUnit, attrName, damage, skillType)
    return sub
end

function AbilityUnitImpl:setCoord(grid)
    self.coordX, self.coordY = grid.coordX, grid.coordY
    if not self.hide then
        self.gridGraph:updateUnit(self)
    end
end
function AbilityUnitImpl:setCoordXY(coordX, coordY)
    self.coordX, self.coordY = coordX, coordY
    if not self.hide then
        self.gridGraph:updateUnit(self)
    end
end
function AbilityUnitImpl:setRealCoord()
    local fromGrid = self.triggerGrid
    local toGrid = self.grid
    self.triggerGrid = toGrid
    local unit = self.abilityUnit
    self.matrixAbility.gridTrigger:unitMove(unit, fromGrid, toGrid)
end

-- 返回nil  代表失败  返回 true 代表开始寻路  返回false  代表目标就在跟前 不用寻路
function AbilityUnitImpl:startMove()
    if self:isImmune("forbidMove") then
        self.logger:trace('startMove forbid')
        return nil
    end
    local targetUnit = self.abilityUnit:minUnit(self.abilityUnit:filterEnemyInRange(1000000))
    if not targetUnit then
        self.logger:trace('startMove no target')
        return nil
    end
    local target = getImpl(targetUnit)
    local distance = self.gridGraph:getDistance(self, target)
    local range = self.matrixAbility.holdPos and 1 or self:getAttr('attack_range')/10000
    if distance <= range then
        self.logger:trace('startMove in range', target)
        return false
    end
    local moveInfo = self.gridGraph:getMoveInfo(self, target)
    if not moveInfo then
        self.logger:trace('startMove no route', target)
        return false
    end
    local frameNumber = self:getFrameNumber()
    local speed = self:getAttr('speed')
    local moveFrame = speed <= 0 and 100 or math.floor((10000 / speed) * self.framePerSec)
    local halfMoveFrame = math.floor(moveFrame / 2)
    local moveTime = moveFrame * self.frameLength / 1000
    self.moveEndFrame = frameNumber + moveFrame
    self.moveHalfFrame = frameNumber + halfMoveFrame
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE, { true, self.coordX, self.coordY, moveInfo.coordX, moveInfo.coordY, moveTime })
    self:setCoord(moveInfo)
    return true
end

function AbilityUnitImpl:stopMove(noBack)
    self.moveEndFrame = nil
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE, { false, self.coordX, self.coordY, self.coordX, self.coordY, 0, noBack })
    if self.keepMoving then
        self.keepMoving()
        self.keepMoving = self.moveEndFrame and self.keepMoving
    end
end

function AbilityUnitImpl:startFlash(targetUnit, flashFrame, near)
    if self:isImmune("forbidMove") then
        self.logger:trace('startFlash forbid')
        return
    end
    local target = getImpl(targetUnit)
    local flashInfo = self.gridGraph:getFlashInfo(self, target, near)
    if not flashInfo then
        return
    end
    self.flashEndFrame = self:getFrameNumber() + flashFrame
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_FLASH,{ true, self.coordX, self.coordY, flashInfo.coordX, flashInfo.coordY, flashFrame })
    self:setCoord(flashInfo)
    self.flashTarget = target
end

function AbilityUnitImpl:stopFlash()
    self.flashEndFrame = nil
    local dstX = self.flashTarget and self.flashTarget.coordX or self.coordX
    local dstY = self.flashTarget and self.flashTarget.coordY or self.coordY
    self.flashTarget = nil
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_FLASH, { false, self.coordX, self.coordY, dstX, dstY })
    self:setRealCoord()
end

function AbilityUnitImpl:inputSkill()
    local auto = self.matrixAbility.matrixOptions.auto or self.camp ~= 1
    self.skillInput = not auto --自动模式下点技能没效果，而不是立即放一次技能
end

function AbilityUnitImpl:checkShootInput()
    local auto = self.matrixAbility.matrixOptions.auto or self.camp ~= 1
    return self.skillInput or auto
end

function AbilityUnitImpl:clearShootInput()
    self.skillInput = false
end

function AbilityUnitImpl:checkUseSkill()
    local maxPriority = 0
    local usingCard = nil
    local usingSkill = nil
    local usingAim = nil
    local function useCard(ability)
        local use = AbilityTrigger.call(ability, 'onCheckCardUse')
        if use then
            local skill, priority = AbilityTrigger.call(ability, 'onCheckCardUseSkill')
            if skill and priority and priority > maxPriority then
                local aimUnit = AbilityTrigger.call(skill, 'onCheckSkillAim')
                if aimUnit then
                    maxPriority = priority
                    usingCard, usingSkill, usingAim = ability, skill, aimUnit
                end
            end
        end
    end
    local abilityGroup = self.abilityGroup
    abilityGroup:forEach(useCard)
    return usingCard, usingSkill, usingAim
end

function AbilityUnitImpl:isLongSkill()
    return self.onceLong or self.forceLongSkill or self.matrixAbility.matrixOptions.long
end

function AbilityUnitImpl:useSkill()
    local usingCard, usingSkill, aimUnit = self:checkUseSkill()
    if usingSkill == nil then
        return
    end
    local skillId, cardId, cardType = AbilityTrigger.call(usingSkill, 'onPrepareSkillParams')
    if not skillId then
        self.usingSkill = nil
        return
    end
    self.usingSkill, self.aimUnit = usingSkill, aimUnit
    self.usingSkillInfo = {skillId = skillId, cardId = cardId, cardType = cardType}
    local bhEvent, attackTime = AbilityTrigger.call(usingSkill, 'onPrepareSkillBehavior')
    local pauseTime, showTime, showType, videoCue = AbilityTrigger.call(usingSkill, 'onPrepareSkillDisplay')
    local pause = pauseTime and pauseTime > 0
    local predictList = pause and AbilityTrigger.call(usingSkill, 'onPrepareSkillPredict', aimUnit)
    local target = aimUnit:getId()
    local targets = {}
    if predictList then
        for _, target in ipairs(predictList) do
            table.insert(targets, target:getId())
        end
    end
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN, { skillId, cardType, cardId, target, targets, showType, showTime, videoCue })
    local useSkillArgs = attackTime and { attackRealTime=attackTime, attackCd=attackTime }
    if pause then
        self.skillSelf = true
        self.matrixAbility:battlePause(pauseTime, targets)
        if showType > 1 then
            self.onceLong = nil
            if self.behaviorFSM then
                self.behaviorFSM:pauseBH()
                local function endVideo()
                    self.behaviorFSM:cancelPauseBH()
                end
                usingSkill:createSkillTimer('video', showTime, endVideo)
            end
        end
    end
    usingCard._useOnce = nil
    AbilityTrigger.call(usingCard, 'onSelfCardUse')
    AbilityTrigger.unit(self.abilityUnit, 'onOwnerUseSkill', usingSkill, cardId, cardType, aimUnit)
    self.behaviorFSM:useSkillData(bhEvent, useSkillArgs)
end

function AbilityUnitImpl:skillPauseFrame(pauseFrame)
    local function pause(ability)
        ability:skillPauseFrame(pauseFrame)
    end
    self.abilityGroup:forEach(pause)
    --self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE, {self.skillSelf})
    self.resumePauseFrame = self:getFrameNumber() + pauseFrame + 1 --FIXME 到底要不要加1？
    if not self.skillSelf then
        if self.moveHalfFrame then
            self.moveHalfFrame = self.moveHalfFrame + pauseFrame
        end
        if self.moveEndFrame then
            self.moveEndFrame = self.moveEndFrame + pauseFrame
        end
        if self.flashEndFrame then
            self.flashEndFrame = self.flashEndFrame + pauseFrame
        end
        if self.behaviorFSM then
            self.behaviorFSM:pauseBH()
        end
    end
end
function AbilityUnitImpl:onCameraEvent(skillEventInfo)
    if skillEventInfo[2] and skillEventInfo[3] then
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAY_CAMERA, { skillEventInfo[2], skillEventInfo[3] })
    end
end

function AbilityUnitImpl:onOffsetEvent(skillEventInfo)
    if skillEventInfo[2] == "start" then
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP, { skillEventInfo[3], skillEventInfo[4] })
        self.offsetStart = true
    elseif skillEventInfo[2] == "start.target" then
        local targetUnit = self.aimUnit
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP, { skillEventInfo[3], skillEventInfo[4], targetUnit:getId() })
        self.offsetStart = true
    elseif skillEventInfo[2] == "stop" then
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK, { skillEventInfo[4] })
        self.offsetStart = false
    end
end

function AbilityUnitImpl:onFlashEvent(skillEventInfo)
    local flashFrame = skillEventInfo[4] or 1
    local targetUnit = self.aimUnit
    self:startFlash(targetUnit, flashFrame)
end

function AbilityUnitImpl:onToIdleAnim()
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_IDLE_ANIM, {})
end

function AbilityUnitImpl:onPlaySpecialAnim(animInfo)
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAY_ANIM, { animInfo[2] })
end


function AbilityUnitImpl:processSkillAtkEvent(eventInfo)
    local eventId = eventInfo[4] or 0
    local usingSkill, aimUnit = self.usingSkill, self.aimUnit
    self.logger:trace('processSkillAtkEvent', usingSkill, eventId, aimUnit)
    if not usingSkill then
        return
    end
    local targetList = AbilityTrigger.callGroup(usingSkill,'AtkEvent', 'onPrepareSkillAtk', eventId, aimUnit)
    if not targetList then
        return
    end
    for _, targetUnit in ipairs(targetList) do
        local flyTime = AbilityTrigger.callGroup(usingSkill, 'AtkEvent', 'onPrepareSkillHit', eventId, aimUnit, targetUnit) or 0
        local attackInfo = {eventId = eventId, targetUnit = targetUnit}
        usingSkill:createSkillTimer(attackInfo, flyTime, AbilityTrigger.callGroup, usingSkill, 'AtkEvent', 'onSelfSkillHit', eventId, aimUnit, targetUnit)
    end
    AbilityTrigger.callGroup(usingSkill, 'AtkEvent', 'onSelfSkillAtk', eventId, aimUnit)
end

function AbilityUnitImpl:checkCondition(conditions, targetUnit)
    return true
    --TODO return ConditionCheck.onCheckCondition(owner, conditionArgs, target)
end

function AbilityUnitImpl:skillDamage(damage, damageType)
    local usingSkillInfo = self.skillSelf and self.usingSkillInfo
    if usingSkillInfo then
        local total = (usingSkillInfo[damageType] or 0) + damage
        usingSkillInfo[damageType] = total
        return total
    end
    return nil
end

function AbilityUnitImpl:onSkillEnd()
    self:stopSkill(true)
end
function AbilityUnitImpl:onSkillInterupt()
    self:stopSkill(false)
end

function AbilityUnitImpl:stopSkill(finish)
    if not self.usingSkill then
        return
    end
    self.logger:trace('stopSkill', finish, self.usingSkill)
    if self.behaviorFSM then
        self.behaviorFSM:onToIdle()
    end
    local preSkill, preInfo = self.usingSkill, self.usingSkillInfo
    -- FIXME 普攻需要保持目标的连贯性  一般不会清空目标
    self.usingSkill, self.usingSkillInfo, self.skillSelf, self.onceLong = nil, nil, nil, nil
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_END, {finish, preInfo.skillId})
    AbilityTrigger.call(preSkill, 'onSelfSkillEnd', finish)
    AbilityTrigger.unit(self.abilityUnit, 'onOwnerSkillEnd', preSkill, preInfo.cardId, preInfo.cardType, self.aimUnit)
end
function AbilityUnitImpl:beHitedControlledDel(hitedFlag)
    if self.inControlled and (self.hitedFlag == hitedFlag or hitedFlag == nil) then
        if self.behaviorFSM then
            self.behaviorFSM:toIdle()
        end
    end
end
function AbilityUnitImpl:beHitedControlledExtend(hitedFlag, duration)
    if self.inControlled and (self.hitedFlag == hitedFlag or hitedFlag == nil) then
        if self.behaviorFSM then
            self.behaviorFSM:extendHitedTime(self.hitedFlag, duration)
        end
    end
end
function AbilityUnitImpl:beHitedControlled(hitedFlag, duration, attackerUnit)
    if self.usingSkill then -- 加沉默状态时如果在释放大招 则打断
        self:onSkillInterupt()
    end
    if self.moveEndFrame then
        if hitedFlag == "stun" then
            self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO, { 0.1 }) -- 眩晕时需要位移到相关位置 其他保持原地不动
        end
        self:interruptMoving()
    end
    local hitedAnim = (hitedFlag == "freeze" or hitedFlag == "timelock") and "" or hitedFlag or ""
    if self.behaviorFSM then
        self.behaviorFSM:beHited(duration, hitedAnim, hitedFlag)
    end
    if self.offsetStart then
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK, { 0.1 })
        self.offsetStart = false
    end
end
function AbilityUnitImpl:enterEntityHited(hitedFlag)
    self.inControlled = 1
    self.hitedFlag = hitedFlag
    if self.hitedFlag == "timelock" or self.hitedFlag == "sleep" then
        self.inSpecialControlled = true
    else
        self.inSpecialControlled = false
    end
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_STATE_ENTER, { BattleConst.ENTITY_STATE_HITED, hitedFlag })
end

function AbilityUnitImpl:exitEntityHited(hitedFlag)
    self.inControlled = nil
    if self.hitedFlag == "timelock" or self.hitedFlag == "sleep" then
        self.inSpecialControlled = false
    end
    self.hitedFlag = nil
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_STATE_EXIT, { BattleConst.ENTITY_STATE_HITED, hitedFlag })
    AbilityTrigger.unit(self.abilityUnit, 'onOwnerBeHitControlEnd', hitedFlag)
end
-- 打断当前的移动操作 back 代表当前是否回退到移动前位置
function AbilityUnitImpl:interruptMoving()
    if self.moveEndFrame then
        --TODO 原位置没人的话退回去？
        self.moveEndFrame, self.moveHalfFrame = nil, nil
        self:stopMove(true)
    end
end
local function movingTargetBack(self)
    return {
        coordX = self.coordX - self:getForward(),
        coordY = self.coordY
    }
end
local function keepMovingFunction(self, hitedFlag, distance, speed, targetFunc)
    return function ()
        if distance <= 0 then
            return false
        end
        distance = distance - 1
        local target = targetFunc(self)
        local moveInfo = self.gridGraph:getMoveInfo(self, target)
        if not moveInfo then
            return false
        end
        local moveFrame = math.floor((1 / speed) * self.framePerSec)
        if moveFrame < 2 then moveFrame = 2 end
        local halfMoveFrame = math.floor(moveFrame / 2)
        local moveTime = moveFrame * self.frameLength / 1000
        if self.usingSkill then
            self:onSkillInterupt()
        end
        if self.offsetStart then
            self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK, { 0.1 })
            self.offsetStart = false
        end
        if self.behaviorFSM then
            self.behaviorFSM:beHited(moveTime, hitedFlag, hitedFlag)
        end
        local frameNumber = self:getFrameNumber()
        self.moveEndFrame = frameNumber + moveFrame
        self.moveHalfFrame = frameNumber + halfMoveFrame
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE, { true, self.coordX, self.coordY, moveInfo.coordX, moveInfo.coordY, moveTime, false, true, true })
        self:setCoord(moveInfo)
        return true
    end
end
function AbilityUnitImpl:beHitedMovingBack(movingBackDistance, movingBackSpeed)
    if self.keepMoving then
        return
    end
    movingBackSpeed = movingBackSpeed and movingBackSpeed > 0 and movingBackSpeed or 1
    local hitedFlag = "stun"
    self:interruptMoving()
    self.keepMoving = keepMovingFunction(self, hitedFlag, movingBackDistance, movingBackSpeed, movingTargetBack)
    self.keepMoving()
    self.keepMoving = self.moveEndFrame and self.keepMoving
end
function AbilityUnitImpl:beHitedMovingFlash(targetUnit, movingFlash, near)
    self:interruptMoving()
    self:startFlash(targetUnit, movingFlash, near)
end
function AbilityUnitImpl:beHitedMovingSwap(targetUnit)
    local target = getImpl(targetUnit)
    self:interruptMoving()
    target:interruptMoving()
    if self:isImmune("forbidMove") then
        self.logger:trace('beHitedMovingSwap forbid')
        return
    end
    if self.coordX and target.coordX then
        local coordX, coordY = self.coordX, self.coordY
        self.gridGraph:removeUnit(self)
        self:setCoord(target)
        target:setCoordXY(coordX, coordY)
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO, { 0.0 })
        target:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO, { 0.0 })
        target:setRealCoord()
        self.setRealCoord()
    end
end


-- 大招中被击中 仅仅是表现受击的动作  并没有逻辑意义 因为策划会保证这个表现始终在卡帧中
function AbilityUnitImpl:beHitedAnim(hitedAnim)
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HITED_AIM, { hitedAnim })
end

function AbilityUnitImpl:beHitedOffset(offsetPath)
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HITED_OFFSET, { offsetPath })
end

function AbilityUnitImpl:die()
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_DEAD, {})
    if self.behaviorFSM then
        self.behaviorFSM:onToDead()
    end
    --FIXME 在触发事件中复活了咋办
    local function checkDettach(ability)
        local dettach = AbilityTrigger.call(ability, 'onCheckDettachDead')
        if dettach then
            ability:detach()
        end
    end
    self.abilityGroup:forEach(checkDettach)
end

function AbilityUnitImpl:reborn(hppct, mana, fromUnit)
    --TODO gridTrans
    local combatUnit = self.combatUnit
    local rebornCoordX, rebornCoordY = self.gridTrans:getRebornCoord(combatUnit)
    if rebornCoordX then
        --TODO 加入遍历列表
        combatUnit:onReborn(rebornCoordX, rebornCoordY, hppct, getImpl(fromUnit).combatUnit, mana)
    end
end

function AbilityUnitImpl:enterBattle()
    self:setRealCoord() -- 开始触发陷阱
    AbilityTrigger.unit(self.abilityUnit, 'onOwnerEnterBattle')
end

function AbilityUnitImpl:initSkillEventHandler()
    local obj = self
    local behaviorFSM = obj.behaviorFSM
    if not behaviorFSM then
        return
    end
    behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_ATTACK, Slot(obj.processSkillAtkEvent, obj))
    behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_SKILL_END, Slot(obj.onSkillEnd, obj))
    -- behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_VIDEO, Slot(obj.onPlaySkillVideo, obj))
    behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_CAMERA, Slot(obj.onCameraEvent, obj))
    behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_OFFSET, Slot(obj.onOffsetEvent, obj))
    behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_FLASH, Slot(obj.onFlashEvent, obj))
    behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_TO_IDLE_ANIM, Slot(obj.onToIdleAnim, obj))
    behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_PLAY_ANIM, Slot(obj.onPlaySpecialAnim, obj))
end
function AbilityUnitImpl:init(matrixAbility, camp, unitInfo, summonAttr)
    self.matrixAbility = matrixAbility
    self.frameLength, self.framePerSec = matrixAbility.frameLength, matrixAbility.framePerSec
    self.unitGroup = matrixAbility.unitGroup
    self.gridGraph = matrixAbility.gridGraph
    self.attr = AbilityUnitAttr()
    self.stat = AbilityUnitStat()
    self.master = unitInfo.master
    local type, resId = unitInfo.type, unitInfo.resId
    local resData = type == 'Hero' and ResHeroData[resId] or type == 'Monster' and ResMonsterTypeData[resId] or {}
    self.type, self.resId, self.resData = type, resId, resData
    self.logger:trace('init', camp, unitInfo)
    self.weaponType = resData and (resData.ani_con_name or resData.weapon)
    if type == 'Rimuru' then
        self.weaponType = '100_Basic'
    end
    if self.weaponType then
        AbilityDataTable.loadEditorData(self.weaponType)
    end
    self.camp = camp
    self.bornCamp = camp
    self.race = resData.camp
    self.forceLongSkill = resData.full_skill_ani == 2
    self.onceLong = unitInfo.onceLong
    self.attackCd = resData.attack_cd or BattleConst.DEFAULT_ATTACK_CD or 0
    local level = unitInfo.level and unitInfo.level > 0 and unitInfo.level or resData.level or 1
    local attrBase = summonAttr
    if not summonAttr then
        if unitInfo.attr and next(unitInfo.attr) then -- 服务器传了属性
            attrBase = self.attr.attrIdToName(unitInfo.attr)
        else -- 需要自己算
            if type == 'Monster' then
                local attrLevel = matrixAbility.resBattle.attr_level or 1
                local attrType = resData.monster_stat_type
                local resAttr = attrType and ResMonsterAttrData[attrType][attrLevel]
                level = resAttr and resAttr.level or attrLevel --怪物等级
                attrBase = self.attr.pickMonsterAttr(resData, resAttr)
                local monsterRate = matrixAbility.initCamp[camp].modifier.monsterRate
                if monsterRate then
                    attrBase.mhp = math.floor((attrBase.mhp or 0) * (monsterRate.mhpRate or 10000) / 10000)
                    attrBase.atk = math.floor((attrBase.atk or 0) * (monsterRate.atkRate or 10000) / 10000)
                end
            else
                --特殊单位，没属性
                attrBase = {}
            end
        end
    end
    self.level = level
    self.bornPos = unitInfo.pos
    self.hide = unitInfo.hide
    local forward = self:getForward()
    local grid = unitInfo.grid or self.gridGraph:getPosInfo(unitInfo.pos * forward)
    self:setCoord(grid)
    if type == 'Hero' then
        self.defReduceLimit = 1
        for _, limitInfo in ipairs(BattleMiscConfig.BATTLE_LEVEL_DEF_LIMIT) do
            if level <= limitInfo[1] then
                self.defReduceLimit = limitInfo[2]
                break
            end
        end
    else
        self.defReduceLimit = 0
    end
    local mhp = math.max(attrBase.mhp or 1, 1)
    attrBase.mhp = mhp
    local hp = mhp
    if unitInfo.hp and unitInfo.hp >= 0 then
        hp = mhp * unitInfo.hp / 10000
    elseif camp == BattleConst.CAMP_RED and self.bornPos then
        hp = mhp * (matrixAbility.monsterHps[self.bornPos] or 10000) / 10000
    end
    hp = math.max(hp or 1, 1)
    local mana = attrBase.init_mana or 0
    if unitInfo.mana and unitInfo.mana >= 0 then
        mana = unitInfo.mana
    end
    local max_mana = MAX_MANA
    attrBase.max_mana = max_mana
    if self.hide then --隐藏单位，免控，免死，不可移动
        attrBase.ImmuneChangeCamp = 1
        attrBase.ImmuneControlled = 1
        attrBase.ImmuneDisarm = 1
        attrBase.ImmuneSilence = 1
        attrBase.ImmuneForbidPassive = 1
        attrBase.DamageImmune = 1
        attrBase.UnDead = 1
        attrBase.attack_range = 1000000
        attrBase.speed = 0
        attrBase.forbidMove = 1
    end
    local star = unitInfo.star and unitInfo.star > 0 and unitInfo.star or resData.star
    local combatInfo = {hp = hp, mhp = mhp, mana = mana, max_mana = max_mana, shield = 0,
        level = level, star = star, coordX = self.coordX, coordY = self.coordY}
    local entityInfo = {camp = camp, unitInfo = unitInfo, combatInfo = combatInfo}
    matrixAbility:addOutput(BattleConst.MATRIX_EVENT_SUMMON_MONSTER, { self.id, entityInfo })
    self.behaviorFSM = self.weaponType and CombatFSM(self, self.frameLength, matrixAbility.bhMgr)
    if self.behaviorFSM then
        self.behaviorFSM:toIdle()
    end
    self:initSkillEventHandler()
    self.attr:init(attrBase, AbilityUnitImpl.updateAttr, self)
    self:setAttr('hp', hp)
    self:setAttr('mana', mana)
    self:setAttr('max_mana', max_mana)
    if mana == 0 then -- 补一个output
        UpdateAttr.final_mana_gen(self, 0, self:getAttr('final_mana_gen'))
    end
    self:setAttr('level', level)
    if camp == 1 and matrixAbility.holdPos then
        self:setAttr('forbidMove', 1)
    end
    self.logger:trace('born attr', self.attr)
    local unit = self.abilityUnit
    local ability = unitInfo.ability
    if not ability or not next(ability) then -- 没有服务器数据，需要自己算
        if type == 'Monster' then
            local attrLevel = matrixAbility.resBattle.attr_level or 1
            local attrType = resData.monster_stat_type
            local resAttr = attrType and ResMonsterAttrData[attrType][attrLevel] or resData
            ability = {
                {type = 'card', resId = resData.attack_id, level = resAttr.attack_level},
                {type = 'card', resId = resData.skill_id, level = resAttr.skill_level},
                {type = 'card', resId = resData.ability_id, level = resAttr.ability_level},
                {type = 'passive', resId = resData.hero_passive, level = resAttr.hero_passive_level},
                {type = 'passive', resId = resData.enter_passive, level = resAttr.enter_passive_level},
                {type = 'state', resId = resData.enter_state, level = resData.state_level},
            }
        end
    end
    matrixAbility:addAbilityList(unit, ability)
end

local AbilityUnitImplMt = {__index = AbilityUnitImpl, __tostring = AbilityUnitImpl.toString}

local function newAbilityUnitImpl(abilityUnit, id, logger)
    local impl = {
        id = id,
        name = 'unit_'..id,
        abilityUnit = abilityUnit,
        abilityGroup = Group(),
        exclusiveMap = {},
    }
    setmetatable(impl, AbilityUnitImplMt)
    impl.logger = logger:newLogger('AbilityUnitImpl', impl)
    return impl
end

return newAbilityUnitImpl