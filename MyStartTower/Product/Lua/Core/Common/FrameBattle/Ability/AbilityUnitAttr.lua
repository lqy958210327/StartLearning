local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local ResAttrConfig = AbilityDataTable.ResAttrConfig
local ResAttrAttrMap = AbilityDataTable.ResAttrAttrMap


local function calc_final(resAttr, total)
    local upperLimit = resAttr and resAttr.upperLimit
    local lowerLimit = resAttr and resAttr.lowerLimit
    local upper = upperLimit and math.min(upperLimit, total) or total
    local final = lowerLimit and math.max(lowerLimit, upper) or upper
    return final
end

local function calc_add(self, name)
    local resAttr = ResAttrConfig[name]
    local default = resAttr and resAttr.default or 0
    local total = (self.base[name] or 0) + (self.buff[name] or 0) + default
    local final = calc_final(resAttr, total)
    return total, final
end
local function make_calc_atk_mhp(name)
    local heroPoint = name
    local levelPercent = name..'_percent'
    local starPercent = 'star_'..name..'_percent'
    local heroPercent = 'hero_'..name..'_percent'
    local equipPoint = 'e_'..name
    local equipPercent = 'e_'..name..'_percent'
    local statePoint = 'combat_'..name
    local totalPercent = 'combat_'..name..'_percent'
    local function calc(self, attrName)
        local heroPoint = self:getAttr(heroPoint)
        local levelPercent = self:getAttr(levelPercent)
        local level = math.floor(heroPoint * (10000 + levelPercent) / 10000)
        local starPercent = self:getAttr(starPercent)
        local star = math.floor(level * (10000 + starPercent) / 10000)
        local heroPercent = self:getAttr(heroPercent)
        local hero = math.floor(star * (10000 + heroPercent) / 10000)
        local equipPoint = self:getAttr(equipPoint)
        local equipPercent = self:getAttr(equipPercent)
        local equip = math.floor(equipPoint * (10000 + equipPercent) / 10000)
        local statePoint = self:getAttr(statePoint)
        local totalPoint = hero + equip + statePoint
        local totalPercent = self:getAttr(totalPercent)
        local total = math.floor(totalPoint * (10000 + totalPercent) / 10000)
        local resAttr = ResAttrConfig[attrName]
        local final = calc_final(resAttr, total)
        self.obj.logger:debug('calc', name)
        self.obj.logger:debug('calc hero', name, heroPoint, levelPercent, level, starPercent, star, heroPercent, hero)
        self.obj.logger:debug('calc equip', name, equipPoint, equipPercent, equip)
        self.obj.logger:debug('calc state', name, statePoint)
        self.obj.logger:debug('calc total', name, totalPoint, totalPercent, total, final)
        return total, final
    end
    return calc
end

local function make_calc_def(name)
    local heroPoint = name
    local levelPercent = name..'_percent'
    local starPercent ='star_'..name..'_percent'
    local heroPercent = 'hero_'..name..'_percent'
    local equipPoint = 'e_'..name
    local equipPercent = 'e_'..name..'_percent'
    local statePoint = 'combat_'..name
    local totalPercent = 'combat_'..name..'_percent'
    local function calc(self, attrName)
        local heroPoint = self:getAttr(heroPoint)
        local levelPercent = self:getAttr(levelPercent)
        local level = math.floor(heroPoint * (10000 + levelPercent) / 10000)
        local starPercent = self:getAttr(starPercent)
        local star = math.floor(level * (10000 + starPercent) / 10000)
        local heroPercent = self:getAttr(heroPercent)
        local hero = math.floor(star * (10000 + heroPercent) / 10000)
        local equipPoint = self:getAttr(equipPoint) + self:getAttr('e_def')
        local equipPercent = self:getAttr(equipPercent) + self:getAttr('e_def_percent')
        local equip = math.floor(equipPoint * (10000 + equipPercent) / 10000)
        local statePoint = self:getAttr(statePoint)
        local totalPoint = hero + equip + statePoint
        local totalPercent = self:getAttr(totalPercent)
        local total = math.floor(totalPoint * (10000 + totalPercent) / 10000)
        local resAttr = ResAttrConfig[attrName]
        local final = calc_final(resAttr, total)
        self.obj.logger:debug('calc', name)
        self.obj.logger:debug('calc hero', name, heroPoint, levelPercent, level, starPercent, star, heroPercent, hero)
        self.obj.logger:debug('calc equip', name, equipPoint, equipPercent, equip)
        self.obj.logger:debug('calc state', name, statePoint)
        self.obj.logger:debug('calc total', name, totalPoint, totalPercent, total, final)
        return total, final
    end
    return calc
end
local function make_calc_cdr(skillType)
    local skillPoint = 'skill_cdr_'..skillType
    local skillHaste = 'skill_haste_'..skillType
    local function calc(self, attrName)
        local hasteProp = self:getAttr('haste')
        local skillPointProp = self:getAttr(skillPoint)
        local skillHasteProp = self:getAttr(skillHaste)
        local total = math.floor(skillPointProp + skillHasteProp * hasteProp / 10000)
        local resAttr = ResAttrConfig[attrName]
        local final = calc_final(resAttr, total)
        return total, final
    end
    return calc
end
local function make_calc_haste(name)
    local function calc(self, attrName)
        local hasteProp = self:getAttr('haste')
        local pointProp = self:getAttr(name)
        local total = math.floor(pointProp + hasteProp / 100)
        local resAttr = ResAttrConfig[attrName]
        local final = calc_final(resAttr, total)
        return total, final
    end
    return calc
end
local function make_calc_rate(name)
    local rate = 'final_'..name..'rate'
    local function calc(self, attrName)
        local rateProp = self:getAttr(rate)
        local pointProp = self:getAttr(name)
        local total = math.floor(pointProp * (10000 + rateProp) / 10000)
        local resAttr = ResAttrConfig[attrName]
        local final = calc_final(resAttr, total)
        return total, final
    end
    return calc
end

local CalcAttr = {
    final_atk = make_calc_atk_mhp('atk'),
    final_mhp = make_calc_atk_mhp('mhp'),
    final_p_def = make_calc_def('p_def'),
    final_m_def = make_calc_def('m_def'),
    final_skill_cdr_1 = make_calc_cdr(1),
    final_skill_cdr_2 = make_calc_cdr(2),
    final_skill_cdr_3 = make_calc_cdr(3),
    final_skill_cdr_4 = make_calc_cdr(4),
    final_attack_speed_up = make_calc_haste('attack_speed_up'),
    final_mana_genrate = make_calc_haste('mana_genrate'),
    final_mana_gen = make_calc_rate('mana_gen'),
}

local CalcList = {}
for attrName, _ in pairs(CalcAttr) do
    table.insert(CalcList, attrName)
end
table.sort(CalcList)


local AttrCalc = {
    atk = {'final_atk'},
    mhp = {'final_mhp'},
    p_def = {'final_p_def'},
    m_def = {'final_m_def'},
    atk_percent = {'final_atk'},
    mhp_percent = {'final_mhp'},
    p_def_percent = {'final_p_def'},
    m_def_percent = {'final_m_def'},
    e_atk = {'final_atk'},
    e_atk_percent = {'final_atk'},
    e_mhp = {'final_mhp'},
    e_mhp_percent = {'final_mhp'},
    e_p_def = {'final_p_def'},
    e_p_def_percent = {'final_p_def'},
    e_m_def = {'final_m_def'},
    e_m_def_percent = {'final_m_def'},
    star_atk_percent = {'final_atk'},
    star_mhp_percent = {'final_mhp'},
    e_def = {'final_p_def','m_def'},
    e_def_percent = {'final_p_def','m_def'},
    star_p_def_percent = {'final_p_def'},
    star_m_def_percent = {'final_m_def'},
    hero_atk_percent = {'final_atk'},
    hero_mhp_percent = {'final_mhp'},
    hero_p_def_percent = {'final_p_def'},
    hero_m_def_percent = {'final_m_def'},
    combat_atk = {'final_atk'},
    combat_mhp = {'final_mhp'},
    combat_p_def = {'final_p_def'},
    combat_m_def = {'final_m_def'},
    combat_atk_percent = {'final_atk'},
    combat_mhp_percent = {'final_mhp'},
    combat_p_def_percent = {'final_p_def'},
    combat_m_def_percent = {'final_m_def'},
    haste = {'final_attack_speed_up', 'final_mana_genrate', 'final_skill_cdr_1', 'final_skill_cdr_2', 'final_skill_cdr_3', 'final_skill_cdr_4'},
    attack_speed_up = {'final_attack_speed_up'},
    mana_genrate = {'final_mana_genrate'},
    final_mana_genrate = {'final_mana_gen'},
    mana_gen = {'final_mana_gen'},
    skill_cdr_1 = {'final_skill_cdr_1'},
    skill_cdr_2 = {'final_skill_cdr_2'},
    skill_cdr_3 = {'final_skill_cdr_3'},
    skill_cdr_4 = {'final_skill_cdr_4'},
    skill_haste_1 = {'final_skill_cdr_1'},
    skill_haste_2 = {'final_skill_cdr_2'},
    skill_haste_3 = {'final_skill_cdr_3'},
    skill_haste_4 = {'final_skill_cdr_4'},
}

local AbilityUnitAttr = {}

function AbilityUnitAttr.attrIdToName(attrMap)
    local base = {}
    for _, attr in ipairs(attrMap) do
        local id, value = attr.resId, attr.value
        local resMap = ResAttrAttrMap[id]
        local name = resMap and resMap.attrName or id
        base[name] = value
    end
    return base
end

function AbilityUnitAttr.pickMonsterAttr(resMonster, resAttr)
    local base = {}
    for name, _ in pairs(ResAttrConfig) do
        local attr = resMonster[name]
        if attr then
            base[name] = math.floor(attr)
        end
    end
    if resAttr then
        for name, _ in pairs(ResAttrConfig) do
            local attr = resAttr[name]
            if attr then
                local modifier = resMonster[name..'_modifier'] or 10000
                base[name] = (base[name] or 0) + math.floor(attr * modifier / 10000)
            end
        end
    end
    return base
end

function AbilityUnitAttr:init(base, update, obj)
    self.base = base
    self.buff = {}
    self.total = {}
    self.final = {}
    self.update = update
    self.obj = obj
    for _, name in ipairs(CalcList) do
        self:refreshAttr(name)
    end
end

function AbilityUnitAttr:getAttr(name)
    local value = self.final[name]
    if value then
        return value
    end
    self:refreshAttr(name)
    return self.final[name]
end
function AbilityUnitAttr:totalAttr(name)
    local value = self.total[name]
    if value then
        return value
    end
    self:refreshAttr(name)
    return self.total[name]
end


function AbilityUnitAttr:addAttr(name, value)
    self.buff[name] = (self.buff[name] or 0) + value
    self:refreshAttr(name)
end

function AbilityUnitAttr:setAttr(name, value)
    self:addAttr(name, value - self:totalAttr(name))
end


function AbilityUnitAttr:refreshAttr(name)
    if self.total[name] == false then
        return
    end
    self.total[name] = false
    local calc = CalcAttr[name] or calc_add
    local total, final = calc(self, name)
    total = math.floor(total)
    final = math.floor(final)
    local old = self.final[name] or 0
    self.total[name] = total
    self.final[name] = final
    if old == final then return end
    if self.update then
        self.update(self.obj, name, old, final)
    end
    local names = AttrCalc[name]
    if names then
        for _, xname in ipairs(names) do
            self:refreshAttr(xname)
        end
    end
end

local AbilityUnitAttrMt = {__index = AbilityUnitAttr}

local function newAbilityUnitAttr()
    return setmetatable({}, AbilityUnitAttrMt)
end

return newAbilityUnitAttr