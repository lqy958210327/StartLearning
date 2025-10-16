

local _idx = 0
---@class BBItemBool:BBItemBase 最基础的bool类型黑板条目
BBItemBool = Class("BBItemBool", BBItemBase)

function BBItemBool:ctor()
    ---@type boolean
    self._value = false
    ---@type table<number, function(boolean, boolean)>  值变化回调
    self._valueChangeCB = {}
end

function BBItemBool:onInit() end

function BBItemBool:onClear() end

function BBItemBool:InternalInitValue(value)
    assert(type(value) == "boolean", "---   BBItemBool 只能设置boolean类型的值")
    self._value = value
end

function BBItemBool:AddValueChangeEvent(act)
    if act then
        assert(type(act) == "function", "---   BBItemBool 设置回调方法异常  actType = "..type(act))
    end
    _idx = _idx + 1
    self._valueChangeCB[_idx] = act
    return _idx
end

function BBItemBool:RemoveValueChangeEvent(id)
    assert(id ~= nil, "---   BBItemBool 移除回调方法异常  id = nil")
    assert(type(id) == "number", "---   BBItemBool 移除回调方法异常  id = "..id)
    self._valueChangeCB[id] = nil
end

function BBItemBool:GetValue()
    return self._value
end

function BBItemBool:SetValue(value)
    assert(type(value) == "boolean", "---   BBItemBool 只能设置boolean类型的值")
    local oldValue = self._value
    self._value = value
    if oldValue ~= value then
        self:_onValueChange(oldValue)
    end
end

function BBItemBool:_onValueChange(oldValue)
    local count = 0
    for k,v in pairs(self._valueChangeCB) do
        if v then
            v(self._value, oldValue)
        end
        count = count + 1
    end
    if count > 100 then
        print("---   BBItemBool 注册事件超过100个，检查下是否有内存泄露...")
    end
end

