

-- 针对 老数据结构BattleActor 封装的接口
local _getBattleActor = function(id)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    local actor = ent.CompBattleActor._actor
    assert(actor, "---   数据异常：老数据 BattleActor = nil")
    return actor
end

local table = {}

function table.SetBattleActor(id, actor)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    ent.CompBattleActor:SetBattleActor(actor)
end

function table.ShowModel(id)
    -- 应该是废弃的接口
    local actor = _getBattleActor(id)
    if actor.entityModel then
        actor.entityModel:showModel(true)
    end
end

function table.ShowHUD(id, value)
    local actor = _getBattleActor(id)
    actor:setLogoVisible(value)
end

function table.ShowHUDEntID(id)
    local actor = _getBattleActor(id)
    actor:ShowLogoEntID()
end

function table.ShowMesh(id, value)
    local actor = _getBattleActor(id)
    actor:setModelVisible(value)
end

function table.GetPositionXYZ(id)
    local actor = _getBattleActor(id)
    return actor:getPositionXYZ()
end

function table.GetRotationXYZ(id)
    local actor = _getBattleActor(id)
    return actor:getRotationXYZ()
end

function table.OnDamage(id, dmg, damageType, isCrit, attackerId, extraHitedInfo, cardId, skillOrigin, skillType)
    local actor = _getBattleActor(id)
    actor:onDamage(dmg, damageType, isCrit, attackerId, extraHitedInfo, cardId, skillOrigin, skillType)
end

-- 获取挂点的坐标
function table.GetMountPosition(id, mountType)
    local actor = _getBattleActor(id)
    return actor:GetMountPosition(mountType)
end

-- 获取挂点的旋转
function table.GetMountRotation(id, mountType)
    local actor = _getBattleActor(id)
    return actor:GetMountRotation(mountType)
end

-- 设置头顶mana值
function table.SetHUDMana(id)
    local actor = _getBattleActor(id)
    actor:SetHUDMana()
end

-- 设置头顶shield值
function table.SetHUDShield(id)
    local actor = _getBattleActor(id)
    actor:SetHUDShield()
end

-- BattleActor里的老代码，加buff
function table.OldCodeAddBuff(id, attackId, buffId, lv, layer)
    local actor = _getBattleActor(id)
    actor:onAddState(attackId, buffId, lv, layer)
end

-- BattleActor里的老代码，移除buff
function table.OldCodeRemoveBuff(id, attackId, buffId)
    local actor = _getBattleActor(id)
    actor:onDelState(attackId, buffId)
end

EntityCmd.BattleActor = table
