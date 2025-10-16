

---@class EntityManager : SystemBase 私有数据管理器，业务侧不要调用
EntityManager = Class("EntityManager", SystemBase)

function EntityManager:OnInit()
    self._evtAddEntity = function(entId, entType) self:_addEntity(entId, entType) end
    self._evtRemoveEntity = function(entId) self:_removeEntityByID(entId) end

    EventManager.Battle.RegisterEvent(EventType.EntityMgrAddEntity, self._evtAddEntity)
    EventManager.Battle.RegisterEvent(EventType.EntityMgrRemoveEntity, self._evtRemoveEntity)
end

function EntityManager:OnClear()
    EventManager.Battle.UnRegisterEvent(EventType.EntityMgrAddEntity, self._evtAddEntity)
    EventManager.Battle.UnRegisterEvent(EventType.EntityMgrRemoveEntity, self._evtRemoveEntity)
end

function EntityManager:OnGameStart()
    EntityDict:Get():OnInit()
end

function EntityManager:OnGameEnd()
    EntityDict:Get():OnClear()
end

---@param entType EntityType
function EntityManager:_addEntity(entId, entType)
    EntityDict:Get():AddEntity(entId, entType)
end

function EntityManager:_removeEntityByID(entId)
    EntityDict:Get():RemoveEntityByID(entId)
end

function EntityManager:_removeEntityByType(entType)
    EntityDict:Get():RemoveEntityByType(entType)
end
