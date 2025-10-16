

-- entity 模型相关接口

local table = {}

function table.ShowMesh(id, value)
    -- 设置模型隐藏显示
    EntityCmd.BattleActor.ShowMesh(id, value)
end

function table.ShowAttacker(id, value)
    EntityCmd.Mesh.ShowMesh(id, value)
end

function table.ShowTarget(id, value)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    local targets = ent.CompSkillCache._targetIdList
    for i, targetId in ipairs(targets) do
        EntityCmd.Mesh.ShowMesh(targetId, value)
    end
end

function table.ShowOther(id, value)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    local targets = ent.CompSkillCache._targetIdList
    local list = EntityDict:Get():GetEntityByType(EntityType.Battle)
    for _, entId in ipairs(list) do
        if entId ~= id then
            local isTarget = false
            for i, targetId in ipairs(targets) do
                if targetId == entId then
                    isTarget = true
                    break
                end
            end
            if not isTarget then
                EntityCmd.Mesh.ShowMesh(entId, value)
            end
        end
    end
end

function table.ShowAll(id, value)
    local list = EntityDict:Get():GetEntityByType(EntityType.Battle)
    for i, ent in ipairs(list) do
        EntityCmd.Mesh.ShowMesh(ent, value)
    end
end

EntityCmd.Mesh = table