

-- entity HUD相关接口

local table = {}

function table.ShowHUD(id, value)
    EntityCmd.BattleActor.ShowHUD(id, value)
end

function table.ShowAttacker(id, value)
    EntityCmd.HUD.ShowHUD(id, value)
end

function table.ShowTargets(id, value)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    local targets = ent.CompSkillCache._targetIdList
    for i, targetId in ipairs(targets) do
        EntityCmd.HUD.ShowHUD(targetId, value)
    end
end

function table.ShowOthers(id, value)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    local lockTarget = ent.CompSkillCache._lockTargetId
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
                EntityCmd.HUD.ShowHUD(entId, value)
            end
        end
    end
end

function table.ShowAll(value)
    local list = EntityDict:Get():GetEntityByType(EntityType.Battle)
    for i, ent in ipairs(list) do
        EntityCmd.HUD.ShowHUD(ent, value)
    end
end

function table.ShowEntityID(id) -- 在HUD里显示EntID(调试模式使用)
    EntityCmd.BattleActor.ShowHUDEntID(id)
end


EntityCmd.HUD = table