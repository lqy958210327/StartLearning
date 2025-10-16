

local _idx = 0
---@class BBItemString:BBItemBase 最基础的string类型黑板条目
BBItemString = Class("BBItemString", BBItemBase)

function BBItemString:ctor()
    ---@type string
    self._value = ""
    ---@type table<number, function(string, string)>  值变化回调
    self._valueChangeCB = {}
end

function BBItemString:onInit() end

function BBItemString:onClear() end

function BBItemString:InternalInitValue(value)
    assert(type(value) == "string", "---   BBItemString 只能设置string类型的值")
    self._value = value
end

function BBItemString:AddValueChangeEvent(act)
    if act then
        assert(type(act) == "function", "---   BBItemString 设置回调方法异常  actType = "..type(act))
    end
    _idx = _idx + 1
    self._valueChangeCB[_idx] = act
    return _idx
end

function BBItemString:RemoveValueChangeEvent(id)
    assert(id ~= nil, "---   BBItemString 移除回调方法异常  id = nil")
    assert(type(id) == "number", "---   BBItemString 移除回调方法异常  id = "..id)
    self._valueChangeCB[id] = nil
end

function BBItemString:GetValue()
    return self._value
end

function BBItemString:SetValue(value)
    assert(type(value) == "string", "---   BBItemString 只能设置string类型的值")
    local oldValue = self._value
    self._value = value
    if oldValue ~= value then
        self:_onValueChange(oldValue)
    end
end

function BBItemString:_onValueChange(oldValue)
    local count = 0
    for k,v in pairs(self._valueChangeCB) do
        if v then
            v(self._value, oldValue)
        end
        count = count + 1
    end
    if count > 100 then
        print("---   BBItemString 注册事件超过100个，检查下是否有内存泄露...")
    end
end

