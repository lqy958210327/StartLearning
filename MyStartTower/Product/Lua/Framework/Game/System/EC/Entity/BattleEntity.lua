



---@class BattleEntity : BaseEntity
BattleEntity = Class("BattleEntity", BaseEntity)

function BattleEntity:OnInit()
    ---@type EntityCompBattleListener
    self.CompBattleListener = self:AddComponent(EntityCompBattleListener)
    ---@type EntityCompSkillCache
    self.CompSkillCache = self:AddComponent(EntityCompSkillCache)
    ---@type EntityCompProp
    self.CompProp = self:AddComponent(EntityCompProp)
    ---@type EntityCompBattleActor
    self.CompBattleActor = self:AddComponent(EntityCompBattleActor)
    ---@type EntityCompFx
    self.CompFx = self:AddComponent(EntityCompFx)
    ---@type EntityCompInfo
    self.CompInfo = self:AddComponent(EntityCompInfo)
    ---@type EntityCompBuff
    self.CompBuff = self:AddComponent(EntityCompBuff)
end
