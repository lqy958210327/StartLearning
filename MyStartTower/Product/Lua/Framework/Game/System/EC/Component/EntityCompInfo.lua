

-- Entity本身的一些固定数据

---@class EntityCompInfo : BaseEntityComp
EntityCompInfo = Class("EntityCompInfo", BaseEntityComp)

function EntityCompInfo:OnInit()
    self._isHero = false
    self._heroConfigId = 0 -- 英雄配置ID
    self._heroGid = "" -- 英雄GID
    self._isMonster = false
    self._monsterConfigId = 0 -- 怪物配置ID
    self._isRimuru = false
    self._rimuruId = 0
    self._isBloodShake = true--受到伤害时，血条是否震动，从怪的配置表里读
    self._isSummoned = false -- 是否是召唤物
    self._level = 0 -- 等级
    self._star = 0 -- 星级
    self._camp = 0 -- 我方敌方
    self._pos = 0 -- 战场初始占位
end
