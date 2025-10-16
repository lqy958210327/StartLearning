


-- 私有数据管理器，业务侧禁止调用!!!

local _entIdValid = function(entId) assert(type(entId) == "number", "---   数据异常：entId 类型必须是 number") end

---@class EntityDict 私有数据管理器，业务侧禁止调用!!!
EntityDict = Class("EntityDict")

function EntityDict:ctor()
    ---@type EntityDict
    self._instance = nil
    ---@type table<number, BaseEntity>
    self._entDict = {}
end

function EntityDict:Get()
    if self._instance == nil then self._instance = EntityDict() end
    return self._instance
end

function EntityDict:OnInit()

end

function EntityDict:OnClear()

end

function EntityDict:GetEntity(entId)
    _entIdValid(entId)
    return self._entDict[entId]
end

---@return number[]
function EntityDict:GetEntityByType(entType)
    assert(entType, "---   参数异常, entType = nil")
    local entList = {}
    for _, ent in pairs(self._entDict) do
        if ent:EntityType() == entType then
            table.insert(entList, ent:EntityID())
        end
    end
    return entList
end

---@param entType EntityType
function EntityDict:AddEntity(entId, entType)
    _entIdValid(entId)
    assert(entType, "---   创建Entity失败, entType = nil")
    if self._entDict[entId] then
        LuaCallCs.ThrowException("---   重复创建Entity, entId = "..entId)
    end
    ---@type BaseEntity
    local ent = nil
    if entType == EntityType.Battle then
        ent = BattleEntity()
    elseif entType == EntityType.Show then

    end
    if ent == nil then
        LuaCallCs.ThrowException("---   创建Entity失败，没有对应的EntityType，EntityType = "..entType)
    end
    ent:InternalInit(entId, entType)
    self._entDict[entId] = ent
end

function EntityDict:RemoveEntityByID(entId)
    _entIdValid(entId)
    if self._entDict[entId] then
        local ent = self._entDict[entId]
        ent:InternalClear()
        self._entDict[entId] = nil
    else
        LuaCallCs.LogError("---   数据异常：Entity = nil, 无法移除Entity， entId = "..entId)
    end
end

function EntityDict:RemoveEntityByType(entType)

end
