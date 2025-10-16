


-- 战斗单位大招技能缓存数据

---@class EntityCompSkillCache : BaseEntityComp
EntityCompSkillCache = Class("EntityCompSkillCache", BaseEntityComp)

function EntityCompSkillCache:OnInit()
    self._usingSkillId = nil
    self._lockTargetId = nil
    self._targetIdList = nil
end

function EntityCompSkillCache:OnClear()
    self._usingSkillId = nil
    self._lockTargetId = nil
    self._targetIdList = nil
end