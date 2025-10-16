local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local BattleConst = AbilityDataTable.BattleConst
local ResPassiveSkill = AbilityDataTable.ResPassiveSkill
local ResPassiveEffect = AbilityDataTable.ResPassiveEffect

local function raiseEffect(self, effectData, triggerUnit)
    local resEffectLevel = effectData.resEffectLevel
    local triggerEffectRate = resEffectLevel.triggerEffectRate
    if triggerEffectRate and triggerEffectRate > 0 then
        if not self:checkRandomControl(triggerEffectRate, resEffectLevel.level, nil, BattleConst.FAKE_PROB_TYPE_PASSIVE, resEffectLevel.id) then
            return
        end
    end
    local effect_cd = resEffectLevel.effect_cd
    if effect_cd and not self:checkCooldown(resEffectLevel.id, effect_cd) then
        return
    end
    for _, effect in ipairs(resEffectLevel.effectInfo) do
        local effectType = effect.effectType
        local effectArgs = effect.effectArgs
        if effectType == 1 then -- ◆类型1-触发攻击事件
            local skillId = tonumber(effectArgs[1]) -- 参数A-填写技能ID
            local effectId = tonumber(effectArgs[2]) -- 参数B-填写技能事件ID
            local attackerType = tonumber(effectArgs[3]) or 0 -- 参数C-释放者和目标类型
            local attacker, target
            local ownerUnit = self:getOwnerUnit()
            local sourceUnit = self:getSourceUnit()
            if attackerType == 0 then -- 类型0表示“释放者为被动载体，目标为被动触发者”
                attacker, target = ownerUnit, triggerUnit
            elseif attackerType == 1 then -- 类型1表示“释放者为被动施加者，目标为被动载体”
                attacker, target = sourceUnit, ownerUnit
            elseif attackerType == 2 then -- 类型2表示“释放者为被动施加者，目标为被动触发者”
                attacker, target = sourceUnit, triggerUnit
            elseif attackerType == 3 then -- 类型3表示“释放者为被动触发者，目标为被动载体”
                attacker, target = triggerUnit, ownerUnit
            elseif attackerType == 4 then -- 类型4表示“释放者为被动载体，目标为被动施加者”
                attacker, target = ownerUnit, sourceUnit
            elseif attackerType == 5 then -- 类型5表示“释放者为被动触发者，目标为被动施加者”
                attacker, target = triggerUnit, sourceUnit
            end
            self:triggerSkillEvent(attacker, target, skillId, effectId, resEffectLevel.effectLevel)
        elseif effectType == 2 then -- ◆类型2-添加状态
            local targetType = tonumber(effectArgs[1]) or 0 -- 参数A-类型0表示给自身添加状态，类型1表示给目标添加状态
            local stateId = tonumber(effectArgs[2]) -- 参数B-状态ID
            local stateLevel = tonumber(effectArgs[3]) -- 参数C-状态等级
            local stateDuration = tonumber(effectArgs[4]) -- 参数D-状态持续时间，填-999表示无限时长
            if stateDuration == -999 then
                stateDuration = nil
            end
            local ownerUnit = self:getOwnerUnit()
            local targetUnit = targetType == 0 and ownerUnit or triggerUnit
            if effectData.layer then
                self:setStateLayer(targetUnit, 'state', stateId, stateLevel, effectData.layer, stateDuration)
            else
                --TODO 触发攻击事件 PASSIVE_TRIGGER_TYPE_ATTACK_RESULT
                self:incStateLayer(targetUnit, stateId, stateLevel, 1, stateDuration)
                -- TODO 触发受击事件 PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT
            end

        elseif effectType == 3 then -- ◆类型3-触发卡牌技能，相比类型1，此类型存在动作表现
            local cardId = tonumber(effectArgs[1]) or 0 -- 参数A-填写技能卡ID，见技能分组表
            local cardLevel = tonumber(effectArgs[2]) -- 参数B-填写技能卡等级
            local triggerCd = tonumber(effectArgs[3]) or 0 -- 参数C-填写触发CD
            local cardUseCd = tonumber(effectArgs[4]) or 0 -- 参数D-填写释放CD
            self:triggerPassiveCard(cardId, cardLevel, triggerCd, cardUseCd, triggerUnit)
        end
    end
end


--执行被动技能表逻辑
local AbilityConfigPassive = {}
function AbilityConfigPassive:onCheckDettachDead()
    return true
end

local function initEventMap(self)
    self.effectList = {}
    local resPassive = self.resPassive
    local skillLevel = self:getSkillLevel()
    local resLevel = resPassive and resPassive[skillLevel]
    local resEffects = resLevel and resLevel.effects or {}
    local eventMap = {}
    local function addEvent(name)
        eventMap[name] = AbilityConfigPassive[name]
    end
    for _, einfo in ipairs(resEffects) do
        local effectId, effectLevel = einfo.effectId, einfo.effectlevel
        local resEffectId = ResPassiveEffect[effectId]
        local resEffectLevel = resEffectId and resEffectId[effectLevel]
        if resEffectLevel then
            local effectData = {resEffectLevel = resEffectLevel}
            table.insert(self.effectList, effectData)
            local triggerType = resEffectLevel.triggerType
            local triggerSubType = resEffectLevel.triggerSubType
            if triggerType == 1 then -- 触发类型1：监控载体生命
                addEvent('onOwnerHpChange')
            elseif triggerType == 2 then -- 触发类型2：监控载体使用技能
                addEvent('onOwnerUseSkill')
            elseif triggerType == 3 then -- 触发类型3：监控载体攻击结果
                if triggerSubType <= 3 then
                    addEvent('onOwnerAttackDamage')
                elseif triggerSubType <= 5 then
                    --addEvent('onAttackState')
                elseif triggerSubType == 6 then
                    addEvent('onOwnerAttackKill')
                elseif triggerSubType == 7 then
                    --addEvent('onAttackMana')
                elseif triggerSubType > 8 then
                    addEvent('onOwnerAttackControl')
                end
            elseif triggerType == 4 then -- 触发类型4：被动添加时立即触发
                addEvent('onSelfAttach')
            elseif triggerType == 5 then -- 触发类型5：监控载体受击结果
                if triggerSubType == 1 then -- ◆子类型1-监控受击次数或值
                    addEvent('onOwnerBeHitDamage')
                elseif triggerSubType == 2 then -- ◆子类型2-监控受击闪避
                    addEvent('onOwnerBeHitMiss')
                elseif triggerSubType == 3 then -- ◆子类型3-监控自身死亡
                    addEvent('onOwnerBeHitDie')
                elseif triggerSubType == 4 then -- ◆子类型4-监控受控制情况
                    if resEffectLevel.triggerArgs[2] == 1 then
                        addEvent('onOwnerBeHitControl')
                    else
                        addEvent('onOwnerBeHitControlEnd')
                    end
                elseif triggerSubType == 5 then -- ◆子类型5-监控免疫伤害
                    addEvent('onOwnerBeHitImmune')
                elseif triggerSubType == 6 then -- ◆子类型6-监控被添加状态
                    --addEvent('onBeHitState')
                end
            elseif triggerType == 6 then -- 触发类型6：监控护盾
                    --◆子类型1-根据护盾存在与否在维持状态
                    --参数A-类型1表示存在护盾，类型2表示没有护盾
            elseif triggerType == 7 then -- 触发类型7：监控战场死亡
                addEvent('onGlobalKill')
            elseif triggerType == 8 then -- 触发类型8：监控战斗胜利
                addEvent('onGlobalAced')
            elseif triggerType == 9 then -- 触发类型9：监控特殊事件
            elseif triggerType == 10 then -- 触发类型10：监控载体使用技能，技能释放完成后触发{触发类型2为技能释放开始时触发}
                addEvent('onOwnerSkillEnd')
            end
        end
    end
    self:registerTriggerTable(eventMap)
end

function AbilityConfigPassive:onSelfAttach()
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel
        if resEffectLevel.triggerType == 4 and self:checkCondition(self, resEffectLevel, nil) then -- 触发类型4：被动添加时立即触发
            raiseEffect(self, effectData, nil)
        end
    end
end
function AbilityConfigPassive:onOwnerHpChange(hp, hpPercent)
    local ownerUnit = self:getOwnerUnit()
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel
        if resEffectLevel.triggerType == 1 and self:checkCondition(self, resEffectLevel, nil) then -- 触发类型1：监控载体生命
            local triggerSubType = resEffectLevel.triggerSubType
            if triggerSubType == 1 then -- ◆子类型1-根据已损失生命维持状态层数
                local arg1 = tonumber(resEffectLevel.triggerArgs[1]) -- 参数A-损失生命的百分比
                local layer = math.floor((10000 - hpPercent) / arg1)
                if layer ~= (effectData.layer or 0) then
                    effectData.layer = layer
                    raiseEffect(self, effectData, ownerUnit)
                end
            elseif triggerSubType == 2 then -- ◆子类型2-根据生命值条件维持状态
                local arg1 = tonumber(resEffectLevel.triggerArgs[1]) -- 参数A-类型1表示大于，类型2表示小于
                local arg2 = tonumber(resEffectLevel.triggerArgs[2]) -- 参数B-比较的值
                local arg3 = tonumber(resEffectLevel.triggerArgs[3]) -- 参数C-类型1表示绝对值，类型2表示万分比
                local value = arg3 == 1 and hp or hpPercent
                local ok = (arg1 == 1 and value >= arg2) or (arg1 == 2 and value <= arg2)
                local layer = ok and 1 or 0
                if layer ~= (effectData.layer or 0) then
                    effectData.layer = layer
                    raiseEffect(self, effectData, ownerUnit)
                end
            elseif triggerSubType == 3 then -- ◆子类型3-表示生命改变时触发，条件满足时仅触发1次
                if effectData.once then
                    return
                end
                local arg1 = tonumber(resEffectLevel.triggerArgs[1]) -- 参数A-类型1表示大于，类型2表示小于
                local arg2 = tonumber(resEffectLevel.triggerArgs[2]) -- 参数B-比较的值
                local arg3 = tonumber(resEffectLevel.triggerArgs[3]) -- 参数C-类型1表示绝对值，类型2表示万分比
                local value = arg3 == 1 and hp or hpPercent
                local ok = (arg1 == 1 and value >= arg2) or (arg1 == 2 and value <= arg2)
                if ok then
                    effectData.once = true
                    raiseEffect(self, effectData, ownerUnit)
                end
            end
        end
    end
end

local function translateCardType(SkillType, skillType)
    if skillType == SkillType.PuGong then --普攻
        return 1
    elseif skillType == SkillType.DaZhao then --大招
        return -1
    else
        return 0
    end
end

function AbilityConfigPassive:onOwnerUseSkill(useAbility, useCardId, useCardType, targetUnit)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel
        if resEffectLevel.triggerType == 2 and self:checkCondition(self, resEffectLevel, targetUnit) then -- 触发类型2：监控载体使用技能
            local triggerSubType = resEffectLevel.triggerSubType
            if triggerSubType == 1 then -- ◆子类型1-监控指定ID的技能使用次数
                local argUseCardId = tonumber(resEffectLevel.triggerArgs[1]) -- 参数A-填写技能卡ID，或指定类型{-1代表大招、0代表所有、1代表普攻}
                local argNeedCount = tonumber(resEffectLevel.triggerArgs[2]) -- 参数B-次数
                if argUseCardId == 0 or argUseCardId == translateCardType(self.Enum.SkillType, useCardType) or argUseCardId == useCardId then
                    if self:addCountUntil(1, 1, argNeedCount) then
                        raiseEffect(self, effectData, targetUnit)
                    end
                end
            end
        end
    end
end

function AbilityConfigPassive:onOwnerSkillEnd(useAbility, useCardId, useCardType, targetUnit)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel
        if resEffectLevel.triggerType == 10 and self:checkCondition(self, resEffectLevel, targetUnit) then -- 触发类型10：监控载体使用技能，技能释放完成后触发{触发类型2为技能释放开始时触发}
            local triggerSubType = resEffectLevel.triggerSubType
            if triggerSubType == 1 then -- ◆子类型1-监控指定ID的技能使用次数
                local argUseCardId = tonumber(resEffectLevel.triggerArgs[1]) -- 参数A-填写技能卡ID，或指定类型{-1代表大招、0代表所有、1代表普攻}
                local argNeedCount = tonumber(resEffectLevel.triggerArgs[2]) -- 参数B-次数
                if argUseCardId == 0 or argUseCardId == translateCardType(useCardType) or argUseCardId == useCardId then
                    if self:addCountUntil(1, 1, argNeedCount) then
                        raiseEffect(self, effectData, targetUnit)
                    end
                end
            end
        end
    end
end

function AbilityConfigPassive:onOwnerAttackDamage(targetUnit, damage, damageType, isCrit, skillType)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型3：监控载体攻击结果
        if resEffectLevel.triggerType == 3 and resEffectLevel.triggerSubType <= 3 and self:checkCondition(self, resEffectLevel, targetUnit) then
            local triggerSubType = resEffectLevel.triggerSubType
            local triggerArgs = resEffectLevel.triggerArgs
            local argRecordType = tonumber(triggerArgs[1]) -- 参数A-类型1表示监控攻击次数，类型2表示监控攻击值
            local argNeedCount = tonumber(triggerArgs[2]) -- 参数B-次数或值
            local critOnly = tonumber(triggerArgs[3]) -- 参数C-监控暴击类型，类型0表示所有伤害，类型1表示暴击伤害，类型2表示爆头伤害(默认0)
            local typeFilter = tonumber(triggerArgs[4]) -- 参数D-监控攻击类型，类型0表示伤害，类型1表示治疗，类型2表示掉血，类型3表示普攻伤害，类型4表示大招伤害，类型5表示护盾(默认0)
            local wantType = (typeFilter == 0 and 'hurtHp') or (typeFilter == 1 and 'healHp')
            local wantSkill = (typeFilter == 4 and 1) or (typeFilter == 3 and 0)
            if (not wantType or wantType == damageType) and (not wantSkill or wantSkill == skillType) and (critOnly == 0 or isCrit) then
                -- ◆子类型1-监控攻击次数或值，对所有目标的攻击结果累加
                local countId = triggerSubType == 2 and targetUnit or 1 -- ◆子类型2-监控攻击次数或值，对所有目标的攻击结果分别计算和触发
                local addValue = argRecordType == 1 and 1 or damage
                if triggerSubType == 3 then -- ◆子类型3-监控攻击次数或值，切换目标时次数或值重新累积，特殊用途
                    if effectData.targetUnit ~= targetUnit then
                        effectData.targetUnit = targetUnit
                        self:clearCount(1)
                    end
                end
                if self:addCountUntil(countId, addValue, argNeedCount) then
                    raiseEffect(self, effectData, targetUnit)
                end
            end
        end
    end
end

function AbilityConfigPassive:onOwnerAttackKill(targetUnit)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型3：监控载体攻击结果 ◆子类型6-监控造成击杀
        if resEffectLevel.triggerType == 3 and resEffectLevel.triggerSubType == 6 and self:checkCondition(self, resEffectLevel, targetUnit) then
            local argNeedCount = tonumber(resEffectLevel.triggerArgs[1]) or 1 -- 参数A-次数
            if self:addCountUntil(1, 1, argNeedCount) then
                raiseEffect(self, effectData, targetUnit)
            end
        end
    end
end

function AbilityConfigPassive:onOwnerAttackControl(targetUnit, controlType)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型3：监控载体攻击结果 ◆子类型8-监控造成控制
        if resEffectLevel.triggerType == 3 and resEffectLevel.triggerSubType == 8 and self:checkCondition(self, resEffectLevel, targetUnit) then
            local argControlType = tonumber(resEffectLevel.triggerArgs[2]) or 1 -- 参数A-类型stun表示眩晕，类型freeze表示冰冻，类型Float表示击飞，类型timelock表示锁定，其它表示任意控制
            local argNeedCount = tonumber(resEffectLevel.triggerArgs[2]) or 1 -- 参数B-填写次数
            if argControlType == nil or controlType == argControlType then
                if self:addCountUntil(1, 1, argNeedCount) then
                    raiseEffect(self, effectData, targetUnit)
                end
            end
        end
    end
end

function AbilityConfigPassive:onOwnerBeHitDamage(attackerUnit, damage, damageType, crit)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型5：监控载体受击结果 ◆子类型1-监控受击次数或值
        if resEffectLevel.triggerType == 5 and resEffectLevel.triggerSubType == 1 and self:checkCondition(self, resEffectLevel, attackerUnit) then
            local triggerSubType = resEffectLevel.triggerSubType
            local triggerArgs = resEffectLevel.triggerArgs
            local argRecordType = tonumber(triggerArgs[1]) -- 参数A-类型1表示监控攻击次数，类型2表示监控攻击值
            local argNeedCount = tonumber(triggerArgs[2]) -- 参数B-次数或值
            local critOnly = tonumber(triggerArgs[3]) -- 参数C-监控暴击类型，类型0表示所有伤害，类型1表示暴击伤害，类型2表示爆头伤害(默认0)
            local typeFilter = tonumber(triggerArgs[4]) -- 参数D-监控攻击类型，类型0表示伤害，类型1表示治疗，类型2表示掉血，类型3表示普攻伤害，类型4表示大招伤害，类型5表示护盾(默认0)
            local selfFilter = tonumber(triggerArgs[5]) -- 参数E-监控伤害来源，类型0表示全部，类型1表示自身，类型2表示别人
            local ownerUnit = self:getOwnerUnit()
            if typeFilter == damageType and (critOnly == 0 or crit) and (selfFilter == 0 or (selfFilter == 1) == (attackerUnit == ownerUnit)) then
                local addValue = argRecordType == 1 and 1 or damage
                if self:addCountUntil(1, addValue, argNeedCount) then
                    raiseEffect(self, effectData, attackerUnit)
                end
            end
        end
    end
end

function AbilityConfigPassive:onOwnerBeHitMiss(attackerUnit)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型5：监控载体受击结果 ◆子类型2-监控受击闪避
        if resEffectLevel.triggerType == 5 and resEffectLevel.triggerSubType == 2 and self:checkCondition(self, resEffectLevel, attackerUnit) then
            local argNeedCount = tonumber(resEffectLevel.triggerArgs[1]) or 1 -- 参数A-填写次数
            if self:addCountUntil(1, 1, argNeedCount) then
                raiseEffect(self, effectData, attackerUnit)
            end
        end
    end
end

function AbilityConfigPassive:onOwnerBeHitDie(attackerUnit)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型5：监控载体受击结果 ◆子类型3-监控自身死亡
        if resEffectLevel.triggerType == 5 and resEffectLevel.triggerSubType == 3 and self:checkCondition(self, resEffectLevel, attackerUnit) then
            local argNeedCount = tonumber(resEffectLevel.triggerArgs[1]) or 1 -- 参数A-填写次数
            if self:addCountUntil(1, 1, argNeedCount) then
                raiseEffect(self, effectData, attackerUnit)
            end
        end
    end
end

function AbilityConfigPassive:onOwnerBeHitControl(attackerUnit, controlType)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型5：监控载体受击结果 ◆子类型4-监控受控制情况 参数B-类型0表示控制效果移除时触发，类型1表示控制效果添加时触发
        if resEffectLevel.triggerType == 5 and resEffectLevel.triggerSubType == 4 and resEffectLevel.triggerArgs[2] == 1 and self:checkCondition(self, resEffectLevel, attackerUnit) then
            local argNeedCount = tonumber(resEffectLevel.triggerArgs[1]) or 1 -- 参数A-填写次数
            if self:addCountUntil(1, 1, argNeedCount) then
                raiseEffect(self, effectData, attackerUnit)
            end
        end
    end
end

function AbilityConfigPassive:onOwnerBeHitControlEnd(controlType)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型5：监控载体受击结果 ◆子类型4-监控受控制情况 参数B-类型0表示控制效果移除时触发，类型1表示控制效果添加时触发
        if resEffectLevel.triggerType == 5 and resEffectLevel.triggerSubType == 4 and resEffectLevel.triggerArgs[2] ~= 0 and self:checkCondition(self, resEffectLevel, nil) then
            local argNeedCount = tonumber(resEffectLevel.triggerArgs[1]) or 1 -- 参数A-填写次数
            if self:addCountUntil(1, 1, argNeedCount) then
                raiseEffect(self, effectData, nil)
            end
        end
    end
end

function AbilityConfigPassive:onOwnerBeHitImmune(attackerUnit)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型5：监控载体受击结果 ◆子类型5-监控免疫伤害
        if resEffectLevel.triggerType == 5 and resEffectLevel.triggerSubType == 5 and self:checkCondition(self, resEffectLevel, attackerUnit) then
            local argNeedCount = tonumber(resEffectLevel.triggerArgs[1]) or 1 -- 参数A-填写次数
            if self:addCountUntil(1, 1, argNeedCount) then
                raiseEffect(self, effectData, attackerUnit)
            end
        end
    end
end

function AbilityConfigPassive:onGlobalKill(attackerUnit, targetUnit)
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型7：监控战场死亡
        if resEffectLevel.triggerType == 7 and resEffectLevel.triggerSubType == 1 and self:checkCondition(self, resEffectLevel, targetUnit) then
            local argRecordType = tonumber(resEffectLevel.triggerArgs[1]) or 0 -- 参数A-类型1表示监控敌人，类型2表示监控己方
            local argNeedCount = tonumber(resEffectLevel.triggerArgs[2]) or 1 -- 参数B-数量
            local argObjFilter = tonumber(resEffectLevel.triggerArgs[2]) or 0 -- 参数C-类型0表示监控任意单位，类型1表示监控英雄死亡，类型2表示监控召唤物死亡
            local ownerUnit = self:getOwnerUnit()
            local campOk = (argRecordType == 1 and ownerUnit:isEnemy(targetUnit)) or (argRecordType == 2 and ownerUnit:isFriend(targetUnit)) or argRecordType == 3
            local typeOk = argObjFilter == 0 or (argObjFilter == 1 and targetUnit:isHero()) or (argObjFilter == 2 and targetUnit:isMinor())
            if campOk and typeOk and self:addCountUntil(1, 1, argNeedCount) then
                raiseEffect(self, effectData, targetUnit)
            end
        end
    end
end


function AbilityConfigPassive:onGlobalAced(deadUnit)
    local ownerUnit = self:getOwnerUnit()
    if deadUnit and deadUnit:isFriend(ownerUnit) then
        return
    end
    for _, effectData in ipairs(self.effectList) do
        local resEffectLevel = effectData.resEffectLevel -- 触发类型8：监控战斗胜利
        if resEffectLevel.triggerType == 8 and resEffectLevel.triggerSubType == 1 and self:checkCondition(self, resEffectLevel, nil) then
            raiseEffect(self, effectData, nil)
        end
    end
end

local function newAbilityConfigPassive(passiveId)
    return function (ability)
        ability.passiveId = passiveId
        ability.resPassive = ResPassiveSkill[passiveId]
        initEventMap(ability)
    end
end

return newAbilityConfigPassive