local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local ResStateData = AbilityDataTable.ResStateData
local ResAttrConfig = AbilityDataTable.ResAttrConfig

local SORTED_ATTR_LIST = {}
for attrName, _ in pairs(ResAttrConfig) do
    table.insert(SORTED_ATTR_LIST, attrName)
end
table.sort(SORTED_ATTR_LIST)




local AbilityConfigState = {}
function AbilityConfigState:onCheckDettachDead()
    return true
end

---@param self Ability
---@return boolean
function AbilityConfigState.onCheckAttach(self)
    local level = self:getSkillLevel()
    local stateConfig = self.stateConfig
    local stateConfigLevel = stateConfig[level] or stateConfig[#stateConfig]
    if not stateConfigLevel then
        return true
    end
    local resStateLevel = stateConfigLevel.resStateLevel
    local ownerUnit = self:getOwnerUnit()
    if resStateLevel.conditionName then
        local attr = ownerUnit:getAttr(resStateLevel.conditionName)
        if attr ~= resStateLevel.conditionValue then
            return true
        end
        local hasEqual = false
        for _, value in ipairs(resStateLevel.multiConditionValue) do
            if attr == value then
                hasEqual = true
                break
            end
        end
        if not hasEqual then
            return true
        end
    end
    return ownerUnit:isImmuneAny(stateConfigLevel.checkImmune)
end

---@param self Ability
---@param layer number
---@return number
function AbilityConfigState.onCheckIncStackLayer(self, layer)
    local level = self:getSkillLevel()
    local stateConfig = self.stateConfig
    local stateConfigLevel = stateConfig[level] or stateConfig[#stateConfig]
    if not stateConfigLevel then
        return false
    end
    local ownerUnit = self:getOwnerUnit()
    if ownerUnit:isImmuneAny(stateConfigLevel.checkImmune) then
        return false
    end
    local maxLayer = stateConfigLevel.maxLayer
    local nowLayer = self:getStackLayer()
    if nowLayer + layer > maxLayer then
        return maxLayer - nowLayer
    end
    return layer
end

---@param self Ability
---@param layer integer
---@param oldLayer integer
function AbilityConfigState.onSelfStackLayerChange(self, layer, oldLayer)
    local level = self:getSkillLevel()
    local stateConfig = self.stateConfig
    local stateConfigLevel = stateConfig[level] or stateConfig[#stateConfig]
    if not stateConfigLevel then
        return
    end
    local resStateLevel = stateConfigLevel.resStateLevel
    local detach = layer <= 0
    local layerUp = layer > oldLayer
    --处理独占状态
    if resStateLevel.exclusiveTag then
        if resStateLevel.exclusiveTag == "1" then
            if detach then
                self:unsetExclusiveAbility('beTaunted')
            elseif self:setExclusiveAbility('beTaunted') then
                self:beTaunted()
            end
        elseif resStateLevel.exclusiveTag == "2" then
            if detach then
                self:unsetExclusiveAbility('beAimed')
            elseif self:setExclusiveAbility('beAimed') then
                self:beAimed()
            end
        end
    end
    self:setTagList(stateConfigLevel.tagList)
    if resStateLevel.state_group then
        self:addStateGroupList(resStateLevel.state_group)
    end
    --处理属性
    local ownerUnit = self:getOwnerUnit()
    local disableShowNum = resStateLevel.disableShowNum and resStateLevel.disableShowNum > 0 or not layerUp
    for _, attrName in ipairs(SORTED_ATTR_LIST) do
        if resStateLevel[attrName] then
            local propValues = resStateLevel[attrName]
            local attrValue
            if layer <= 0 then
                attrValue = nil
            elseif type(propValues) == "number" then
                attrValue = propValues
            elseif type(propValues) == "string" then
                attrValue = tonumber(propValues)
            else
                local prop = propValues[layer] or propValues[1]
                if type(prop) == "number" then
                    attrValue = prop
                else
                    if prop[1] == 1 then
                        local baseValue = tonumber(prop[2]) or 0
                        local rateValue = tonumber(prop[3]) or 0
                        local propName = prop[4]
                        local target = ownerUnit
                        if prop[5] == '1' then -- 为2时选取攻击者身上的属性
                            target = self:getSourceUnit()
                        end
                        local value = target:getAttr(propName) -- TODO level, camp, elem
                        attrValue = (baseValue + rateValue * value) * (layer or 0)
                    end
                end
            end
            self:setAttrBuff(attrName, attrValue, disableShowNum)
        end
    end
    if resStateLevel.passiveSkill then
        local nowPassiveId = self.nowPassiveId
        if nowPassiveId and nowPassiveId ~= resStateLevel.passiveSkill then
            local function matchPassiveId(ability)
                return ability.passiveId == nowPassiveId
            end
            self:findDelAbility(ownerUnit, matchPassiveId)
            self.nowPassiveId = resStateLevel.passiveSkill
            self:addAbility(ownerUnit, 'passive', resStateLevel.passiveSkill)
        end
    end
    if stateConfigLevel.dotList then
        for _, dot in ipairs(stateConfigLevel.dotList) do
            if layer <= 0 then
                self:removeTimer(dot)
            else
                local function timer()
                    self:triggerSkillEvent(self:getSourceUnit(), ownerUnit, dot.skillId, dot.eventId, self:getSkillLevel())
                    self:createTimer(dot, dot.time, timer)
                end
                self:createTimer(dot, dot.time, timer)
            end
        end
    end
end

local function makeStateConfig(resState)
    local stateConfig = {}
    for level, resStateLevel in ipairs(resState) do
        local stateConfigLevel = {}
        stateConfigLevel.resStateLevel = resStateLevel
        stateConfigLevel.maxLayer = resStateLevel.state_max_layer or 1
        local checkImmune = {}
        local tagList = {}
        table.insert(tagList, 'state'..resStateLevel.state_id)
        stateConfigLevel.checkImmune = checkImmune
        stateConfigLevel.tagList = tagList
        if resStateLevel.state_type == 1 then
            table.insert(checkImmune, 'immuneBuff')
            table.insert(tagList, 'buff')
        elseif resStateLevel.state_type == 2 then
            table.insert(checkImmune, 'immuneDebuff')
            table.insert(tagList, 'debuff')
        end
        if resStateLevel.replaceTag == "1" then
            table.insert(checkImmune, 'immuneTaunt')
            table.insert(tagList, 'taunt')
        elseif resStateLevel.replaceTag == "2" then
            table.insert(checkImmune, 'immuneAim')
            table.insert(tagList, 'aim')
        end
        if resStateLevel.silence then
            table.insert(checkImmune, 'immuneSilence')
            table.insert(tagList, 'silence')
        end
        if resStateLevel.changeCamp then
            table.insert(checkImmune, 'immuneChangeCamp')
            table.insert(tagList,'changeCamp')
        end
        if resStateLevel.disarm then
            table.insert(checkImmune, 'immuneDisarm')
            table.insert(tagList,'disarm')
        end
        if resStateLevel.forbidPassive then
            table.insert(checkImmune, 'immuneForbidPassive')
            table.insert(tagList,'forbidPassive')
        end
        table.insert(stateConfig, stateConfigLevel)
        if resStateLevel.dotDamageId or resStateLevel.hotDamageId then
            stateConfigLevel.dotList = {}
            if resStateLevel.dotDamageId then
                local skillId, eventId = string.match(resStateLevel.dotDamageId, '(%d+),(%d+)')
                table.insert(stateConfigLevel.dotList, {skillId = tonumber(skillId), eventId = tonumber(eventId), time = resStateLevel.dotDamageCircle})
            end
            if resStateLevel.hotDamageId then
                local skillId, eventId = string.match(resStateLevel.hotDamageId, '(%d+),(%d+)')
                table.insert(stateConfigLevel.dotList, {skillId = tonumber(skillId), eventId = tonumber(eventId), time = resStateLevel.hotDamageCircle})
            end
        end
    end
    return stateConfig
end

local function newAbilityConfigState(stateId)
    local resState = ResStateData[stateId]
    return function (ability)
        ability.stateId = stateId
        ability.resState = resState
        ability.stateConfig = makeStateConfig(resState)
        ability:registerTriggerTable(AbilityConfigState)
    end
end

return newAbilityConfigState