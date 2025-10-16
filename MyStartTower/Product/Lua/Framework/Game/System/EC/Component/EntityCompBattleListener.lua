


-- 战斗Entity的事件监听器

---@class EntityCompBattleListener : BaseEntityComp
EntityCompBattleListener = Class("EntityCompBattleListener", BaseEntityComp)

function EntityCompBattleListener:OnInit()
    local k = self:EntID()

    self._evtDictEntityHpInit       = function(...) EntityCmd.Common.OnHpChange(k, ...) end
    self._evtDictEntityHpChange     = function(...) EntityCmd.Common.OnHpChange(k, ...) end
    self._evtDictEntityDead         = function(...) EntityCmd.Common.OnDead(k, ...) end
    self._evtDictEntityReborn       = function(...) EntityCmd.Common.OnReborn(k, ...) end
    self._evtDictEntityMpInit       = function(...) EntityCmd.Common.OnMpChange(k, ...) end
    self._evtDictEntityMpChange     = function(...) EntityCmd.Common.OnMpChange(k, ...) end
    self._evtDictEntitySkillBegin   = function(...) EntityCmd.Common.OnSkillBegin(k, ...) end
    self._evtDictEntitySkillEnd     = function(...) EntityCmd.Common.OnSkillEnd(k, ...) end
    self._evtDictEntityAddBuff      = function(...) EntityCmd.Common.OnAddBuff(k, ...) end
    self._evtDictEntityRemoveBuff   = function(...) EntityCmd.Common.OnRemoveBuff(k, ...) end
    self._evtDictEntityShieldChange = function(...) EntityCmd.Common.OnShieldChange(k, ...) end
    self._evtDictEntityDamage       = function(...) EntityCmd.Common.OnDamage(k, ...) end

    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_HP_INIT, self._evtDictEntityHpInit, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE, self._evtDictEntityHpChange, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_DEAD, self._evtDictEntityDead, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_REBORN_ENTITY, self._evtDictEntityReborn, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_MANA_INIT,  self._evtDictEntityMpInit, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_SETMANA,  self._evtDictEntityMpChange, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN, self._evtDictEntitySkillBegin, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_SKILL_END, self._evtDictEntitySkillEnd, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE, self._evtDictEntityAddBuff, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_DELSTATE, self._evtDictEntityRemoveBuff, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE, self._evtDictEntityShieldChange, k)
    EventCenter.addEventListener(BattleConst.MATRIX_EVENT_ENTITY_DAMAGE, self._evtDictEntityDamage, k)

end

function EntityCompBattleListener:OnClear()
    local k = self:EntID()
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_HP_INIT, self._evtDictEntityHpInit, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE, self._evtDictEntityHpChange, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_DEAD, self._evtDictEntityDead, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_REBORN_ENTITY, self._evtDictEntityReborn, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_MANA_INIT,  self._evtDictEntityMpInit, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_SETMANA,  self._evtDictEntityMpChange, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN, self._evtDictEntitySkillBegin, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_SKILL_END, self._evtDictEntitySkillEnd, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE, self._evtDictEntityAddBuff, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_DELSTATE, self._evtDictEntityRemoveBuff, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE, self._evtDictEntityShieldChange, k)
    EventCenter.removeEventListener(BattleConst.MATRIX_EVENT_ENTITY_DAMAGE, self._evtDictEntityDamage, k)
end
