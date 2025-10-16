

local _idx = 0
---@class BBItemTable:BBItemBase 最基础的table类型黑板条目(等价于C#的Object类型), 允许设置nil
BBItemTable = Class("BBItemTable", BBItemBase)

function BBItemTable:ctor()
    ---@type string
    self._value = nil
    ---@type table<number, function(table, table)>  值变化回调
    self._valueChangeCB = {}
end

function BBItemTable:onInit() end

function BBItemTable:onClear() end

function BBItemTable:InternalInitValue(value)
    if value then
        assert(type(value) == "table", "---   BBItemTable 只能设置table类型的值")
    end
    self._value = value
end

function BBItemTable:AddValueChangeEvent(act)
    if act then
        assert(type(act) == "function", "---   BBItemTable 设置回调方法异常  actType = "..type(act))
    end
    _idx = _idx + 1
    self._valueChangeCB[_idx] = act
    return _idx
end

function BBItemTable:RemoveValueChangeEvent(id)
    assert(id ~= nil, "---   BBItemTable 移除回调方法异常  id = nil")
    assert(type(id) == "number", "---   BBItemTable 移除回调方法异常  id = "..id)
    self._valueChangeCB[id] = nil
end

function BBItemTable:GetValue()
    return self._value
end

function BBItemTable:SetValue(value)
    if value then
        assert(type(value) == "table", "---   BBItemTable 只能设置table类型的值")
    end
    local oldValue = self._value
    self._value = value
    if oldValue ~= value then
        self:_onValueChange(oldValue)
    end
end

function BBItemTable:_onValueChange(oldValue)
    local count = 0
    for k,v in pairs(self._valueChangeCB) do
        if v then
            v(self._value, oldValue)
        end
        count = count + 1
    end
    if count > 100 then
        print("---   BBItemTable 注册事件超过100个，检查下是否有内存泄露...")
    end
end

