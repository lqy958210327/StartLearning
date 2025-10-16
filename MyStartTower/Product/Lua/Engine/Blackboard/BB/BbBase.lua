

---@class BbBase 黑板基类
BbBase = Class("BbBase")

function BbBase:ctor()
    self._key = 0
    ---@type table<number, BBItemBase>
    self._itemDict = {}
end

function BbBase:InternalInit(bbKey)
    self._key = bbKey
    self:onInit()
end

function BbBase:InternalClear()
    self:onClear()
end

---@type function ：可以被继承重写
function BbBase:onInit()

end

---@type function ：可以被继承重写
function BbBase:onClear()

end

---@param itemKey number
---@param item BBItemBase
function BbBase:InternalAddItem(itemKey, item)
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    assert(item, "---   BBItem = nil")
    if self._itemDict[itemKey] then
        return
    end
    if item then
        item:InternalInit()
    end
    self._itemDict[itemKey] = item
end

---@param itemKey number
function BbBase:InternalRemoveItem(itemKey)
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    if self._itemDict[itemKey] then
        self._itemDict[itemKey] = nil
    end
end

function BbBase:InternalGetItem(itemKey)
    if itemKey then
        return self._itemDict[itemKey]
    end
end

function BbBase:InternalExistItem(itemKey)
    if itemKey then
        return self._itemDict[itemKey] ~= nil
    end
    return false
end

function BbBase:GetKey() return self._key end
function BbBase:GetAllItemKey()
    local result = {}
    for k, v in pairs(self._itemDict) do
        table.insert(result, k)
    end
    return result
end

