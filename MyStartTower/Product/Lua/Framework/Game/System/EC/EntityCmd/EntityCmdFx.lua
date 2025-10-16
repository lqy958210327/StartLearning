



local tab = {}

---@param comp EntityCompFx
function tab._addFxToSkill(comp, skillId, fx)
    local dict = comp._skillDict[skillId]
    if dict == nil then
        dict = {}
        comp._skillDict[skillId] = dict
    end
    table.insert(dict, fx)
end

function tab.AddSkillFx(id, skillId, resName)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    local lockTarget = ent.CompSkillCache._lockTargetId
    local usingSkill = ent.CompSkillCache._usingSkillId
    if usingSkill == skillId and lockTarget then
        local posX, posY, posZ = EntityCmd.BattleActor.GetPositionXYZ(lockTarget)
        local rotX, rotY, rotZ = EntityCmd.BattleActor.GetRotationXYZ(id)

        local fx = ent.CompFx:CreateFxData(resName, posX, posY, posZ, rotX, rotY, rotZ)
        EntityCmd.Fx._addFxToSkill(ent.CompFx, skillId, fx)
    end
end

function tab.FreeSkillFx(id, skillId)
    ---@type BattleEntity
    local ent = EntityCmd._entity(id)
    ent.CompFx:ClearFxBySkillId(skillId)
end

function tab.EffectPoolRootSetActive(value)
    LuaCallCs.EffectPoolRootSetActive(value)
end

EntityCmd.Fx = tab
