-- 属性计算  目前有根据武器获得武器属性
-- todo：根据等级获得角色属性  根据怪物ID获取怪物属性

-- @author ZH
-- @date 2017-03-31
local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local ResHero = DataTable.ResHero
local ResHeroLevelProp = DataTable.ResHeroLevelProp
local ResStar = DataTable.ResStar
local ResHeroStepProp = DataTable.ResHeroStepProp
local ResEquipSuit = DataTable.ResEquipSuit
local ResPassiveSkill = DataTable.ResPassiveSkill
local ResPassiveEffect = DataTable.ResPassiveEffect
local BattleStateData = require "Core/Common/FrameBattle/BattleObject/BattleStateData"
local ResItemHeroBase = DataTable.ResItemHeroBase



local ResEmblem = DataTable.ResEmblem ---纹章配置
local ResStatsBankStatsRand = DataTable.ResStatsBankStatsRand ---纹章附加属性随机表
local ResEmblemEnhance = DataTable.ResEmblemEnhance ---纹章强化
local ResEmblemSuit = DataTable.ResEmblemSuit ---纹章套装

local LEVEL_INCREASE_PREFIX = "inc_" -- 成长型前缀
local ROLE_INC_ATTRNAME = {}
for attrName, _ in pairs(BattleConst.PropConfigMap) do
    ROLE_INC_ATTRNAME[attrName] = LEVEL_INCREASE_PREFIX .. attrName
end

---@class PropHelper_Old
local PropHelper = {}

-- 根据属性名称及配置往PropDict里累加合适的属性名(propDict是config配置表里的fixedProp)
function PropHelper._addProps(attrName, attrValue, propDict)
    propDict[attrName] = (propDict[attrName] or 0) + attrValue
end

-- 根据属性名称及配置往PropDict里累加合适的属性名(propDict是config配置表里的fixedProp)
function PropHelper._addStateProps(attrName, attrValue, propDict)
    propDict[attrName] = (propDict[attrName] or 0) + attrValue
end




function PropHelper.getPassiveProps(passiveId, passiveLevel)
    local props = {}
    local passiveData = ResPassiveSkill[passiveId]
    if passiveData then
        passiveData = passiveData[passiveLevel]
    end
    if passiveData and passiveData.effects then
        for index, einfo in pairs(passiveData.effects) do
            local eid = einfo['effectId']
            local elevel = einfo['effectlevel']
            local effData = ResPassiveEffect[eid]
            if effData then
                effData = effData[elevel]
            end

            if effData and effData.triggerType == BattleConst.PASSIVE_TRIGGER_TYPE_IMMEDIATELY then -- 立即触发才需要解析属性规则
                local triggerStates = effData.effectInfo
                if triggerStates then
                    for _, effInfo in ipairs(triggerStates) do
                        if effInfo.effectType == 2 and effInfo.effectArgs then -- 是不是状态
                            local stateId = tonumber(effInfo.effectArgs[2])
                            local stateLevel = tonumber(effInfo.effectArgs[3])
                            for propName, propValue in pairs(PropHelper.getStateProps(stateId, stateLevel)) do
                                props[propName] = (props[propName] or 0) + propValue
                            end
                        end
                    end
                end

            end
        end
    end
    return props
end

function PropHelper.getStateProps(stateId, stateLevel)
    local props = {}
    local stateData = BattleStateData.getStateData(stateId, stateLevel)
    for propName, value in pairs(stateData) do
        if BattleConst.PropConfigMap[propName] then
            local realValue = 0
            if type(value) == "number" then
                realValue = value
            elseif type(value) == "string" then
                realValue = tonumber(value)
            else
                local prop = value[1]
                if type(prop) == "number" then
                    realValue = prop
                end
            end
            props[propName] = (props[propName] or 0) + realValue
        end
    end
    return props
end

--得到英雄属性的 fprop部分
function PropHelper.getHeroAttr(heroID, level, step, star, equips, artifact, fashionSkins, fashionBases, relic, relic_pet,
                                paintData, relationPointData, extraData, soulStones, emblems)
    local props = {}
    local propData = ResHero[heroID] or {}
    local levelData = ResHeroLevelProp[level] or {}
    local stepData = ResHeroStepProp[propData.step_prop_id or 1][step] or {}
    local starData = ResStar[propData.star_prop_id or 1][star] or {}
    --local elemData = propData.elem_id and ResElemData[propData.elem_id] or {}
    local extraProps = extraData or {}
    levelData = levelData.props or {}
    local propsEquip = PropHelper.getEquipAttr(equips)
    local propsArtifact = PropHelper.getArtifactAttr(artifact)
    local propsRelic = PropHelper.getRelicAttr(relic)
    local propsRelicPet = PropHelper.getRelicPetAttr(relic_pet)
    local propsSkins = PropHelper.getSkinsAttr(heroID, fashionSkins)
    local propsBases = PropHelper.getBasesAttr(heroID, fashionBases)

    local propsRelation = PropHelper.getRelationAttr(relationPointData, heroID)
    local propsSoulStone = PropHelper.getSoulStonesAttr(soulStones)
    local propsEmblem = PropHelper.CalcEmblemAttr(emblems)
    local propsEmblemSuit = PropHelper.CalcEmblemSuitAttr(emblems)
    if propData then
        for attrName, _ in pairs(BattleConst.PropConfigMap) do
            local propValue = propData[attrName] or 0
            local incId = propData[ROLE_INC_ATTRNAME[attrName]]
            if levelData[incId] then
                local rate = levelData[incId].rate or 100
                propValue = propValue * rate / 10000
            end
            local value = propValue +
                (stepData[attrName] or 0) +
                (starData[attrName] or 0) +
                --(elemData[attrName] or 0) +
                (propsEquip[attrName] or 0) +
                (propsArtifact[attrName] or 0) +
                (propsSkins[attrName] or 0) +
                (propsBases[attrName] or 0) +
                (propsRelic[attrName] or 0) +
                (propsRelicPet[attrName] or 0) +

                (propsRelation[attrName] or 0) +
                (extraProps[attrName] or 0) +
                (propsSoulStone[attrName] or 0) + 
                (propsEmblem[attrName] or 0) +
                (propsEmblemSuit[attrName] or 0)
            PropHelper._addProps(attrName, value, props)
        end
    end
    return props
end

---@param soulStoneList list<HeroSoulStone>
function PropHelper.getSoulStonesAttr(soulStoneList)
    local props = {}

    if soulStoneList then
        for i, v in ipairs(soulStoneList) do
            local attrData = v:getAttr()
            for m, n in ipairs(attrData) do
                props[n.type] = (props[n.type] or 0) + n.value
            end
        end
    end

    return props
end

-- 得到时装属性
function PropHelper.getSkinsAttr(heroID, fashionSkins)
    local props = {}

    return props
end

-- 得到底座属性
function PropHelper.getBasesAttr(heroID, fashionBases)
    local props = {}
    if fashionBases then
        local heroBaseData = ResItemHeroBase[heroID] or {}
        for baseId, _ in pairs(fashionBases) do
            local baseData = heroBaseData[baseId]
            if baseData then
                if baseData.prop then
                    for _, attrInfo in pairs(baseData.prop) do
                        local attrName = BattleConst.PROP_TYPE_CONFIG[attrInfo.type]
                        props[attrName] = (props[attrName] or 0) + attrInfo.value
                    end
                end

            end
        end
    end
    return props
end



function PropHelper.getRelationAttr(relationPointData, hero_id)
    local props = {}

    return props
end

function PropHelper.getEquipAttr(equips)
    local props = {}
    if equips then
        local suits = {}
        for _, equip in pairs(equips) do
            if equip.haveSuit == 1 and ResEquipSuit[equip.suitId] then
                suits[equip.suitId] = (suits[equip.suitId] or 0) + 1
            end

        end
        for suitId, suitNum in pairs(suits) do
            local suitData = ResEquipSuit[suitId]
            if suitData.props then
                local needNum = suitData.need_num
                local layer = math.floor(suitNum / needNum)
                for _, info in ipairs(suitData.props) do
                    local attrName = BattleConst.PROP_TYPE_CONFIG[info.type]
                    if attrName and info.value then
                        props[attrName] = (props[attrName] or 0) + info.value * layer
                    end
                end
            end
        end
    end

    return props
end



function PropHelper.getArtifactAttr(artifact)
    local props = {}
    if artifact then
        props = artifact:getArtifactAttrs()
    end
    return props
end

function PropHelper.getRelicAttr(relic)
    local props = {}
    if relic then
        props = relic:getRelicAttrs()
    end
    return props
end

function PropHelper.getRelicPetAttr(relic_pet)
    local props = {}
    if relic_pet then
        props = relic_pet:getRelicPetAttrs()
    end
    return props
end










---@private 计算纹章属性
function PropHelper.CalcEmblemAttr(emblems)
    local propDic = {}
    if emblems == nil then
        return propDic
    end

    for i = 1, #emblems do
        local emblem = emblems[i]
        local emblemCfg = ResEmblem[emblem.resId]
        if emblem ~= nil and emblemCfg ~= nil then
            ---主属性部分
            local main_prop = emblem.main_prop[1]
            local randomTag = main_prop ~= nil and main_prop.k or 0
            local randCfg = ResStatsBankStatsRand[randomTag]
            if randCfg ~= nil then
                local groupTag = emblemCfg.enhance_groupid or 0                
                local groupCfg = ResEmblemEnhance[groupTag]                 
                local enhanceLevelConfig = groupCfg[emblem.level]
                local propValue = math.ceil(main_prop.v * enhanceLevelConfig.mainprop_1_rate / 10000) 
                local propType = BattleConst.PROP_TYPE_CONFIG[randCfg.prop_id]
                propDic[propType] = (propDic[propType] or 0) + propValue
            end

            ---副属性部分
            local sub_props = emblem.sub_prop
            if sub_props == nil then
                return propDic
            end

            for i = 1, 4 do
                local sub_prop = sub_props[i]
                local subRandomTag = sub_prop ~= nil and sub_prop.k or 0
                 --local subRandCfg = EmblemHelper.GetEmblemRandPropConfig(subRandomTag)
                local subRandCfg = ResStatsBankStatsRand[subRandomTag]
                if subRandCfg ~= nil then
                    local propValue = sub_prop ~= nil and sub_props[i].v or 0
                    -- local propType = PropConfigHelper.GetPropTypeByPropId(subRandCfg.prop_id)
                    local propType = BattleConst.PROP_TYPE_CONFIG[subRandCfg.prop_id]
                    propDic[propType] = (propDic[propType] or 0) + propValue
                end
            end
        end
    end
    return propDic
end


---@private 计算纹章套装属性
function PropHelper.CalcEmblemSuitAttr(emblems)
    local propDic = {}
    if emblems == nil or #emblems < 4 then
        return propDic
    end

    local suitTag = emblems[1].suitid
    for i = 2, #emblems  do
        local tempTag = emblems[i].suitid
        -- cfg = EmblemHelper.GetEmblemConfigByGid(emblems[i])
        if tempTag ~= suitTag then                
            return propDic
        end
    end

    -- local cfg = EmblemHelper.GetEmblemSuitConfig(suitTag)
    local cfg = ResEmblemSuit[suitTag]
    if cfg == nil or cfg.props == nil then
        return propDic
    end
    for _, info in ipairs(cfg.props) do
        local attrName = BattleConst.PROP_TYPE_CONFIG[info.type]
        if attrName and info.value then
            propDic[attrName] = (propDic[attrName] or 0) + info.value
        end
    end
    return propDic
end


return PropHelper
