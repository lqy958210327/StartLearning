


-- 这是个过度组件！！！
-- 这里存的是原来的BattleActor数据

---@class EntityCompBattleActor : BaseEntityComp
EntityCompBattleActor = Class("EntityCompBattleActor", BaseEntityComp)

function EntityCompBattleActor:OnInit()
    self._actor = nil
end

function EntityCompBattleActor:OnClear()

end

function EntityCompBattleActor:SetBattleActor(actor)
    self._actor = actor
end