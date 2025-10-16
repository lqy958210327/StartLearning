

-- entity 基础信息

local tab = {}

function tab.GetIsHero(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._isHero
end

function tab.GetHeroConfigId(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._heroConfigId
end

function tab.GetHeroGid(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._heroGid
end

function tab.GetIsMonster(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._isMonster
end

function tab.GetMonsterConfigId(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._monsterConfigId
end

function tab.GetIsSummoned(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._isSummoned
end

function tab.GetIsRimuru(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._isRimuru
end

function tab.GetRimuruID(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._rimuruId
end

function tab.GetLevel(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._level
end

function tab.GetStar(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._star
end

function tab.GetCamp(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._camp
end

function tab.GetPos(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompInfo._pos
end



---@param propType EntPropType
function tab.GetProp(id, propType)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    return ent.CompProp:GetProp(propType)
end

EntityCmd.Base = tab