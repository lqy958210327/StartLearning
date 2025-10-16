

local _idx = 0
---@class BBItemUserdata:BBItemBase 最基础的userdata类型黑板条目
BBItemUserdata = Class("BBItemUserdata", BBItemBase)

function BBItemUserdata:ctor()
    ---@type userdata
    self._value = nil
    ---@type table<number, function(userdata, userdata)>  值变化回调
    self._valueChangeCB = {}
end

function BBItemUserdata:onInit() end

function BBItemUserdata:onClear() end

function BBItemUserdata:InternalInitValue(value)
    if value then
        assert(type(value) == "userdata", "---   BBItemUserdata 只能设置userdata类型的值")
    end
    self._value = value
end

function BBItemUserdata:AddValueChangeEvent(act)
    if act then
        assert(type(act) == "function", "---   BBItemUserdata 设置回调方法异常  actType = "..type(act))
    end
    _idx = _idx + 1
    self._valueChangeCB[_idx] = act
    return _idx
end

function BBItemUserdata:RemoveValueChangeEvent(id)
    assert(id ~= nil, "---   BBItemUserdata 移除回调方法异常  id = nil")
    assert(type(id) == "number", "---   BBItemUserdata 移除回调方法异常  id = "..id)
    self._valueChangeCB[id] = nil
end

function BBItemUserdata:GetValue()
    return self._value
end

function BBItemUserdata:SetValue(value)
    if value then
        assert(type(value) == "userdata", "---   BBItemUserdata 只能设置userdata类型的值")
    end
    local oldValue = self._value
    self._value = value
    if oldValue ~= value then
        self:_onValueChange(oldValue)
    end
end

function BBItemUserdata:_onValueChange(oldValue)
    local count = 0
    for k,v in pairs(self._valueChangeCB) do
        if v then
            v(self._value, oldValue)
        end
        count = count + 1
    end
    if count > 100 then
        print("---   BBItemUserdata 注册事件超过100个，检查下是否有内存泄露...")
    end
end

