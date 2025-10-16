

-- entity buff相关接口

local table = {}

function table.AddBuff(entId, attackId, buffId, lv, layer)
    ---@type BattleEntity
    local ent = EntityCmd._entity(entId)
    ent.CompBuff:AddBuff(attackId, buffId, lv, layer)
    EntityCmd.BattleActor.OldCodeAddBuff(entId, attackId, buffId, lv, layer)
end

function table.RemoveBuff(entId, attackId, buffId)
    ---@type BattleEntity
    local ent = EntityCmd._entity(entId)
    ent.CompBuff:RemoveBuff(attackId, buffId)
    EntityCmd.BattleActor.OldCodeRemoveBuff(entId, attackId, buffId)
end

---@return EntityBuffData[]
function table.GetBuffList(entId)
    ---@type BattleEntity
    local ent = EntityCmd._entity(entId)
    if ent then
        return ent.CompBuff:GetBuffList()
    end
    return {}
end

EntityCmd.Buff = table