



---@class BaseEntity
BaseEntity = Class("BaseEntity")

function BaseEntity:ctor()
    self._id = nil
    ---@type table<string, BaseEntityComp>
    self._compDict = {}
end

function BaseEntity:InternalInit(id, entType)
    self._id = id
    self._entType = entType
    self:OnInit()
end

function BaseEntity:InternalClear()
    for k, v in pairs(self._compDict) do
        v:InternalClear()
    end
    self._compDict = {}
    self:OnClear()
end

function BaseEntity:OnInit()

end

function BaseEntity:OnClear()

end

---@param comp BaseEntityComp
function BaseEntity:AddComponent(comp)
    -- comp.typeName 不建议这么调用,这个字段名字,这是底层的class里的字段，这个字段索引不到
    assert(comp, "---   AddEntityComponent异常：comp = nil")
    assert(type(comp) == "table", "---   AddEntityComponent异常：comp 必须继承 BaseEntityComp")
    assert(comp.InternalInit ~= nil and comp.InternalClear ~= nil, "---   AddEntityComponent异常：comp 没有继承 BaseEntityComp")--lua语言的特殊性，没法精准限制类型
    local className = comp.typeName
    if self._compDict[className] then
        LuaCallCs.LogError("---   Entity重复添加Component, entityId = "..self._id)
    else
        local c = comp()
        c:InternalInit(self._id)
        self._compDict[className] = c
        return c
    end
end

function BaseEntity:EntityID() return self._id end
function BaseEntity:EntityType() return self._entType end