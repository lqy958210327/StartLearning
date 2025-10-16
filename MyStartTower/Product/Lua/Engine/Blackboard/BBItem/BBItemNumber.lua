

local _idx = 0
---@class BBItemNumber:BBItemBase 最基础的number类型黑板条目(int和float)
BBItemNumber = Class("BBItemNumber", BBItemBase)

function BBItemNumber:ctor()
    ---@type number
    self._value = 0
    ---@type table<number, function(number, number)>  值变化回调
    self._valueChangeCB = {}
end

function BBItemNumber:onInit() end

function BBItemNumber:onClear() end

function BBItemNumber:InternalInitValue(value)
    assert(type(value) == "number", "---   BBItemNumber 只能设置number类型的值")
    self._value = value
end

function BBItemNumber:AddValueChangeEvent(act)
    if act then
        assert(type(act) == "function", "---   BBItemNumber 设置回调方法异常  actType = "..type(act))
    end
    _idx = _idx + 1
    self._valueChangeCB[_idx] = act
    return _idx
end

function BBItemNumber:RemoveValueChangeEvent(id)
    assert(id ~= nil, "---   BBItemNumber 移除回调方法异常  id = nil")
    assert(type(id) == "number", "---   BBItemNumber 移除回调方法异常  id = "..id)
    self._valueChangeCB[id] = nil
end

function BBItemNumber:GetValue()
    return self._value
end

function BBItemNumber:SetValue(value)
    assert(type(value) == "number", "---   BBItemNumber 只能设置number类型的值")
    local oldValue = self._value
    self._value = value
    if oldValue ~= value then
        self:_onValueChange(oldValue)
    end
end

function BBItemNumber:_onValueChange(oldValue)
    local count = 0
    for k,v in pairs(self._valueChangeCB) do
        if v then
            v(self._value, oldValue)
        end
        count = count + 1
    end
    if count > 100 then
        print("---   BBItemNumber 注册事件超过100个，检查下是否有内存泄露...")
    end
end

