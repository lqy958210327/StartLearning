local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local BattleConst = AbilityDataTable.BattleConst

local function isDamage(damageType)
    return damageType == 'hurtHp' or damageType == 'hurtShield'
end

local function isHeal(damageType)
    return damageType == 'healHp' --治疗量是否计算吸血和护盾 9.10孙兵说只计算吸血不计算护盾
end

local AbilityUnitStat = {}


function AbilityUnitStat:recordOneAttack(damageType, damageValue, isCrit)
    self.attackCount = self.attackCount + 1
    if isDamage(damageType) then
        self.totalDamage = self.totalDamage + damageValue
    elseif isHeal(damageType) then
        self.totalHeal = self.totalHeal + damageValue
    end
    if isCrit then
        self.critCount = self.critCount + 1
    end

end

function AbilityUnitStat:recordOneHited( damageType, damageValue)
    if isDamage(damageType) then
        self.receiveDamage = self.receiveDamage + damageValue
    elseif isHeal(damageType) then
        self.receiveHeal = self.receiveHeal + damageValue
    end
end

local AbilityUnitStatMt = {__index = AbilityUnitStat}

local function newAbilityUnitStat()
    local obj = {
        attackCount = 0,
        totalDamage = 0,
        totalHeal   = 0,
        critCount   = 0,
        missCount   = 0,
        missAttackCount = 0,
        receiveDamage = 0,
        receiveHeal = 0,
    }
    return setmetatable(obj, AbilityUnitStatMt)
end

return newAbilityUnitStat
