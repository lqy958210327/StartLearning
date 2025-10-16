local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local ResSkillConfig = AbilityDataTable.ResSkillConfig

local AbilityConfigCard = {}

function AbilityConfigCard:onSelfAttach()
    local resSkillConfig = self.resSkillConfig
    local skillLevel = self:getSkillLevel()
    local resCard = resSkillConfig[skillLevel]
    self.resCard = resCard
    self.cardInfo = { skillList = {}, cardId = resCard.id, cardType = resCard.skill_type,
        skillCd = resCard.skill_cd, nextCd = resCard.init_cd, useSpeedUp = resCard.use_speedup==1 }
    local ownerUnit = self:getOwnerUnit()
    for _, skillId in ipairs(resCard.skill_ids) do
        local skill = self:addAbility(ownerUnit, 'skill', skillId, skillLevel)
        skill.cardInfo = self.cardInfo
        table.insert(self.cardInfo.skillList, skill)
    end
    if resCard.skill_passive then
        self:addAbility(ownerUnit, 'passive', resCard.skill_passive, skillLevel)
    end
    self:setCooldown(self.cardInfo) -- 初始CD
end

function AbilityConfigCard:onCheckCardUse()
    local ownerUnit = self:getOwnerUnit()
    local cardInfo = self.cardInfo
    local resCard = self.resCard
    local cardType = cardInfo.cardType
    if cardType == self.Enum.SkillType.PuGong then
        if ownerUnit:hasAttr('disarm') then
            return nil
        end
    elseif cardType == self.Enum.SkillType.DaZhao then
        if ownerUnit:hasAttr('silence') then
            return nil
        end
    end
    if resCard.mana_cost and ownerUnit:getAttr('mana') < resCard.mana_cost then
        return nil
    end
    local shoot = resCard.timer_shoot == 1
        or (resCard.input_shoot == 1 and self:checkShootInput())
        or (resCard.trigger_shoot == 1 and self:checkShootOnce())
    if not shoot then
        return nil
    end
    local cd = cardInfo.nextCd
    if cd and not self:getCooldown(cardInfo, cd) then
        return nil
    end
    return true
end

function AbilityConfigCard:onCheckCardUseSkill()
    local cardInfo = self.cardInfo
    local useSkill = self:getRandomChoice(cardInfo.skillList)
    local priority = self.resCard.skill_priority or 1 --cardInfo.cardType and (cardInfo.cardType + 1) * 1000 or 10000
    return useSkill, priority
end

function AbilityConfigCard:onSelfCardUse()
    local ownerUnit = self:getOwnerUnit()
    local cardInfo = self.cardInfo
    self.skillInput = nil
    self:setCooldown(cardInfo)
    local resCard = self.resCard
    if resCard.mana_cost then
        self:addAttr('mana', -resCard.mana_cost)
    end
    if resCard.mana_gen then
        local addMana = ownerUnit:getAttr('attack_mana_gen')
        self:changeMana(resCard.mana_gen + addMana, true)
    end
    if resCard.input_shoot == 1 then
        self:clearShootInput()
    end
end
local function newAbilityConfigCard(cardId)
    local resSkillConfig = ResSkillConfig[cardId]
    return function (ability)
        ability.cardId = cardId
        ability.resSkillConfig = resSkillConfig
        ability:registerTriggerTable(AbilityConfigCard)
    end
end

return newAbilityConfigCard