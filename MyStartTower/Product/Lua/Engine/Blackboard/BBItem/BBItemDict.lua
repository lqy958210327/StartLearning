

-- （Lua语言的特殊性，BBItemDict与BBItemTable功能相似，使用的时候建议不要把BBItemTable当成字典使用，也不要把BBItemDict当成class用）

local _idx = 0
---@class BBItemDict:BBItemBase 最基础的字典类型黑板条目，等价于C#的Dictionary
BBItemDict = Class("BBItemDict", BBItemBase)

function BBItemDict:ctor()
    ---@type table
    self._dict = {}
    ---@type table<number, function()>  值变化回调
    self._valueChangeCB = {}
end

function BBItemDict:onInit() end

function BBItemDict:onClear() end

function BBItemDict:AddValueChangeEvent(act)
    assert(act, "---   BBItemDict 设置回调方法异常  act = nil")
    assert(type(act) == "function", "---   BBItemDict 设置回调方法异常  actType = "..type(act))
    _idx = _idx + 1
    self._valueChangeCB[_idx] = act
    return _idx
end

function BBItemDict:RemoveValueChangeEvent(id)
    assert(id, "---   BBItemDict 移除回调方法异常  id = nil")
    assert(type(id) == "number", "---   BBItemDict 移除回调方法异常  id = "..id)
    self._valueChangeCB[id] = nil
end

function BBItemDict:SetValue(key, value)
    local isChange = (self._dict[key] == nil)
    self._dict[key] = value
    if isChange then
        self:_onValueChange()
    end
end

function BBItemDict:RemoveValue(key)
    local isChange = (self._dict[key] ~= nil)
    self._dict[key] = nil
    if isChange then
        self:_onValueChange()
    end
end

function BBItemDict:ClearDict()
    self._dict = {}
    self:_onValueChange()
end

function BBItemDict:GetValue(key)
    return self._dict[key]
end

function BBItemDict:GetDict()
    local result = {}
    for i, v in pairs(self._dict) do
        result[i] = v
    end
    return result
end

function BBItemDict:GetArray()
    local result = {}
    for i, v in pairs(self._dict) do
        table.insert(result, v)
    end
    return result
end

function BBItemDict:_onValueChange()
    local count = 0
    for k,v in pairs(self._valueChangeCB) do
        if v then
            v()
        end
        count = count + 1
    end
    if count > 100 then
        print("---   BBItemDict 注册事件超过100个，检查下是否有内存泄露...")
    end
end

