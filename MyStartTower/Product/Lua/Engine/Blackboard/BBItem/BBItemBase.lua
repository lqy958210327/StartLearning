

---@class BBItemBase 黑板条目基类
BBItemBase = Class("BBItemBase")

function BBItemBase:ctor()
    self._bbKey = 0
    self._itemKey = 0
end

function BBItemBase:InternalInit(bbKey, itemKey)
    self._bbKey = bbKey
    self._itemKey = itemKey
    self:onInit()
end

function BBItemBase:InternalClear()
    self:onClear()
end

---@type function ：可以被继承重写
function BBItemBase:onInit()

end

---@type function ：可以被继承重写
function BBItemBase:onClear()

end

function BBItemBase:GetBBKey() return self._bbKey end
function BBItemBase:GetItemKey() return self._itemKey end