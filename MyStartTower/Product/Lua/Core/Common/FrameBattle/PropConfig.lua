local ResAttrConfig = DataTable.ResAttrConfig
local math = math

local function _calc_0(owner, propName) -- 附加效果另算，加一块没意义
    return owner.fixedProp:getProp(propName, 0)
end

local function _calc_1(owner, propName)
    return owner.fixedProp:getProp(propName, 0) + owner.stateGroup:getProp(propName, 0)
end

local function _calc_2(owner, propName)
    return _calc_1(owner, propName) / 10000
end

local function _calc_3(owner, propName)
    return (ResAttrConfig[propName].default or 0) / 10000 + _calc_2(owner, propName)
end

local function _calc_5(owner, propName)
    return math.min(1, _calc_2(owner, propName))
end

-- atk,mhp
local function _calc_atk_mhp(owner, propName)
    local heroPointProp = owner.fixedProp:getProp(propName, 0) --初始属性
    local levelPercentProp = 1 + owner.fixedProp:getProp(propName .. '_percent', 0) / 10000 --等级提升百分比
    local starPercentProp = 1 + owner.fixedProp:getProp('star_' .. propName .. '_percent', 0) / 10000 -- (1 + 星级百分比加成)
    local heroPercentProp = 1 + owner.fixedProp:getProp('hero_' .. propName .. '_percent', 0) / 10000 -- (1 + 角色属性百分比加成)#1
    local heroProp = heroPointProp * levelPercentProp * starPercentProp * heroPercentProp
    local equipPointProp = owner.fixedProp:getProp('e_' .. propName, 0)
    local equipPercentProp = (1 + owner.fixedProp:getProp('e_' .. propName .. '_percent', 0) / 10000)
    local equipProp = equipPointProp * equipPercentProp
    local statePointProp = owner.stateGroup:getProp(propName, 0)
    local totalPercentProp = 1 + owner.stateGroup:getProp(propName .. '_percent', 0) / 10000 --（1 + 总属性百分比加成）
    local result = (heroProp + equipProp + statePointProp) * totalPercentProp
    return result
end

-- m_def,p_def
local function _calc_mp_def(owner, propName)
    local heroPointProp = owner.fixedProp:getProp(propName, 0)
    local levelPercentProp = 1 + owner.fixedProp:getProp(propName .. '_percent', 0) / 10000
    local starPercentProp = 1 + owner.fixedProp:getProp('star_' .. propName .. '_percent', 0) / 10000
    local heroPercentProp = 1 + owner.fixedProp:getProp('hero_' .. propName .. '_percent', 0) / 10000
    local heroProp = heroPointProp * levelPercentProp * starPercentProp * heroPercentProp
    local equipPointProp = (owner.fixedProp:getProp('e_' .. propName, 0)
            + owner.fixedProp:getProp('e_def', 0))
    local equipPercentProp = 1 + (owner.fixedProp:getProp('e_' .. propName .. '_percent', 0)
            + owner.fixedProp:getProp('e_def_percent', 0)) / 10000
    local equipProp = equipPointProp * equipPercentProp
    local statePointProp = owner.stateGroup:getProp(propName, 0)
    local totalPercentProp = 1 + owner.stateGroup:getProp(propName .. '_percent', 0) / 10000
    local result = (heroProp + equipProp + statePointProp) * totalPercentProp
    return result
end

local function _calc_gen(owner, propName)
    local gen = _calc_1(owner, propName)
    local genrate = _calc_1(owner, 'mana_genrate')
    return (gen or 0) * (10000 + genrate) / 10000
end

--name, relation,calc
local PropConfig = {
    { propName='atk', zhName='攻击', calc = _calc_atk_mhp } ,
    { propName='atk_percent', zhName='攻击百分比', relation = {'atk'}, calc = _calc_0 } ,
    { propName='cri_rate', zhName='暴击率', calc = _calc_2 } ,
    { propName='cri_dmg', zhName='暴伤', calc = _calc_3 } ,
    { propName='mhp', zhName='生命', calc = _calc_atk_mhp } ,
    { propName='mhp_percent', zhName='生命百分比', relation = {'mhp'}, calc = _calc_0 } ,
    { propName='p_def', zhName='物理防御', calc = _calc_mp_def } ,
    { propName='p_def_percent', zhName='物理防御百分比', relation = {'p_def'}, calc = _calc_0 } ,
    { propName='m_def', zhName='法术防御', calc = _calc_mp_def } ,
    { propName='m_def_percent', zhName='法术防御百分比', relation = {'m_def'}, calc = _calc_0 } ,
    { propName='e_atk', zhName='装备攻击', relation = {'atk'}, calc = _calc_1 } ,
    { propName='e_atk_percent', zhName='装备攻击百分比', relation = {'atk'}, calc = _calc_1 } ,
    { propName='e_mhp', zhName='装备生命', relation = {'mhp'}, calc = _calc_1 } ,
    { propName='e_mhp_percent', zhName='装备生命百分比', relation = {'mhp'}, calc = _calc_1 } ,
    { propName='e_p_def', zhName='装备物理防御', relation = {'p_def'}, calc = _calc_1 } ,
    { propName='e_p_def_percent', zhName='装备物理防御百分比', relation = {'p_def'}, calc = _calc_1 } ,
    { propName='e_m_def', zhName='装备法术防御', relation = {'m_def'}, calc = _calc_1 } ,
    { propName='e_m_def_percent', zhName='装备法术防御百分比', relation = {'m_def'}, calc = _calc_1 } ,
    { propName='star_atk_percent', zhName='星级攻击百分比', relation = {'atk'}, calc = _calc_1 } ,
    { propName='star_mhp_percent', zhName='星级生命百分比', relation = {'mhp'}, calc = _calc_1 } ,
    { propName='sp_percent', zhName='大招威力', calc = _calc_2 } ,
    { propName='ca_percent', zhName='普攻威力', calc = _calc_2 } ,
    { propName='assist_enhance', zhName='支援加强', calc = _calc_2 } ,
    { propName='e_def', zhName='装备防御', relation = {'p_def','m_def'}, calc = _calc_1 } ,
    { propName='e_def_percent', zhName='装备防御百分比', relation = {'p_def','m_def'}, calc = _calc_1 } ,
    { propName='effect_hit', zhName='效果命中', calc = _calc_5 } ,
    { propName='damage_percent', zhName='伤害加深', calc = _calc_2 } ,
    { propName='damage_reduce_percent', zhName='伤害减免', calc = _calc_2 } ,
    { propName='star_p_def_percent', zhName='星级物理防御百分比', relation = {'p_def'}, calc = _calc_1 } ,
    { propName='star_m_def_percent', zhName='星级法术防御百分比', relation = {'m_def'}, calc = _calc_1 } ,
    { propName='hero_atk_percent', zhName='英雄攻击百分比', relation = {'atk'}, calc = _calc_1 } ,
    { propName='hero_mhp_percent', zhName='英雄生命百分比', relation = {'mhp'}, calc = _calc_1 } ,
    { propName='hero_p_def_percent', zhName='英雄物理防御百分比', relation = {'p_def'}, calc = _calc_1 } ,
    { propName='hero_m_def_percent', zhName='英雄法术防御百分比', relation = {'m_def'}, calc = _calc_1 } ,
    { propName='cri_reduce', zhName='暴击抗性', calc = _calc_2 } ,
    { propName='cri_dmg_reduce', zhName='暴伤减免', calc = _calc_2 } ,
    { propName='attack_speed_up', zhName='攻速加成', calc = _calc_3 } ,
    { propName='blockRate', zhName='格挡率', calc = _calc_2 } ,
    { propName='block_dmg', zhName='格挡值', calc = _calc_3 } ,
    { propName='heal_effect', zhName='治疗效果', calc = _calc_3 } ,
    { propName='heal_enhance_percent', zhName='被治疗加成', calc = _calc_3 } ,
    { propName='effect_miss', zhName='效果抵抗', calc = _calc_2 } ,
    { propName='elem_enhance_1', zhName='火元素伤害百分比', calc = _calc_2 } ,
    { propName='elem_resist_1', zhName='火元素伤害减免', calc = _calc_2 } ,
    { propName='elem_enhance_2', zhName='冰元素伤害百分比', calc = _calc_2 } ,
    { propName='elem_resist_2', zhName='冰元素伤害减免', calc = _calc_2 } ,
    { propName='elem_enhance_3', zhName='地元素伤害百分比', calc = _calc_2 } ,
    { propName='elem_resist_3', zhName='地元素伤害减免', calc = _calc_2 } ,
    { propName='elem_enhance_4', zhName='风元素伤害百分比', calc = _calc_2 } ,
    { propName='elem_resist_4', zhName='风元素伤害减免', calc = _calc_2 } ,
    { propName='elem_enhance_5', zhName='光元素伤害百分比', calc = _calc_2 } ,
    { propName='elem_resist_5', zhName='光元素伤害减免', calc = _calc_2 } ,
    { propName='elem_enhance_6', zhName='暗元素伤害百分比', calc = _calc_2 } ,
    { propName='elem_resist_6', zhName='暗元素伤害减免', calc = _calc_2 } ,
    { propName='mana_gen', zhName='能量回复固定值', calc = _calc_gen } ,
    { propName='mana_genrate', zhName='能量回复百分比', relation = {'mana_gen','behited_mana_gen','attack_mana_gen','start_mana_gen'}, calc = _calc_1 } ,
    { propName='behited_mana_gen', zhName='受击能量回复', calc = _calc_gen } ,
    { propName='attack_mana_gen', zhName='攻击能量回复', calc = _calc_gen } ,
    { propName='start_mana_gen', zhName='初始能量', calc = _calc_gen } ,
    { propName='pvp_dmgup_per', zhName='穿透', calc = _calc_2 } ,
    { propName='pvp_dmgreduce_per', zhName='韧性', calc = _calc_2 } ,
    { propName='battlerate_dmgup_per', zhName='伤害压制', calc = _calc_2 } ,
    { propName='battlerate_dmgreduce_per', zhName='伤害压制减免', calc = _calc_2 } ,
    { propName='hit_rate', zhName='命中率', calc = _calc_3 } ,
    { propName='miss', zhName='闪避率', calc = _calc_2 } ,
    { propName='arp_percent', zhName='物理穿透', calc = _calc_2 } ,
    { propName='spp_percent', zhName='法术穿透', calc = _calc_2 } ,
    { propName='init_mana', zhName='初始能量', calc = _calc_1 } ,
}

return PropConfig
