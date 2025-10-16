

local _idx = 0
---@class BBItemNumberRank:BBItemBase 数值排行榜黑板条目：自带number排序，每个number允许设置自定义的唯一Key(默认降序排序)
BBItemNumberRank = Class("BBItemNumberRank", BBItemBase)

function BBItemNumberRank:ctor()
    ---@type table[]
    self._rank = {}
    ---@type table<table, number> key的类型业务侧自定义，注释统一写成table
    self._key = {}
    ---@type table<number, function()>  排名变化回调
    self._valueChangeCB = {}
    ---@type boolean 是否降序排序
    self._isDownSort = true
end

function BBItemNumberRank:onInit() end

function BBItemNumberRank:onClear() end

function BBItemNumberRank:InternalInitValue(isDownSort)
    if isDownSort == nil then isDownSort = true end
    self._isDownSort = isDownSort
end

function BBItemNumberRank:AddValueChangeEvent(act)
    if act then
        assert(type(act) == "function", "---   BBItemNumberRank 设置回调方法异常  actType = "..type(act))
    end
    _idx = _idx + 1
    self._valueChangeCB[_idx] = act
    return _idx
end

function BBItemNumberRank:RemoveValueChangeEvent(id)
    assert(id ~= nil, "---   BBItemNumberRank 移除回调方法异常  id = nil")
    assert(type(id) == "number", "---   BBItemNumberRank 移除回调方法异常  id = "..id)
    self._valueChangeCB[id] = nil
end

function BBItemNumberRank:AddValue(key, value)
    assert(key ~= nil, "---   BBItemNumberRank 新增number错误， key = nil")
    assert(type(value) == "number", "---   BBItemNumberRank 只能设置number类型的值")

    if self._key[key] then
        print("---   BBItemNumberRank 不可重复添加相同key的number")
    else
        table.insert(self._rank, {key, value})
        local idx = #self._rank
        self._key[key] = idx
        self:_sortRank()
    end
end

function BBItemNumberRank:RemoveValue(key)
    assert(key ~= nil, "---   BBItemNumberRank 移除number错误， key = nil")
    local idx = self._key[key]
    if idx then
        self._key[key] = nil
        table.remove(self._rank, idx)
        self:_sortRank()
    end
end

function BBItemNumberRank:SetValue(key, value)
    assert(key ~= nil, "---   BBItemNumberRank 更新number错误， key = nil")
    assert(type(value) == "number", "---   BBItemNumberRank 只能设置number类型的值")
    local idx = self._key[key]
    if idx then
        self._rank[idx][2] = value
        local lastIdx = idx - 1
        local nextIdx = idx + 1
        if (lastIdx > 0 and (self._rank[lastIdx][2] < value)) or (nextIdx <= #self._rank and (self._rank[nextIdx][2] > value)) then
            self:_sortRank()
        end
    end
end

function BBItemNumberRank:ExistValue(key)
    if key and self._key[key] then
        return true
    end
    return false
end

---@return number, number 排名，值
function BBItemNumberRank:GetRankAndValueByKey(key)
    if key and self._key[key] then
        local idx = self._key[key]
        return idx, self._rank[idx][2]
    end
    return nil, nil
end

---@return number, number key,值
function BBItemNumberRank:GetTheFirstValue()
    if #self._rank > 0 then
        local data = self._rank[1]
        return data[1], data[2]
    end
    return nil, nil
end

---@return number, number key,值
function BBItemNumberRank:GetTheLastValue()
    if #self._rank > 0 then
        local data = self._rank[#self._rank]
        return data[1], data[2]
    end
    return nil, nil
end

---@return table[] 获取前N名的排名信息，返回排名信息数组，排名信息的第一个参数是Key，第二个参数是值
function BBItemNumberRank:GetTheFirstList(count)
    local result = {}
    for i = 1, #self._rank do
        local data = self._rank[i]
        if i <= count then
            table.insert(result, {data[1], data[2]})
        else
            break
        end
    end
    return result
end

-----@return table[] 排名信息的数组，排名信息的第一个参数是Key，第二个参数是值
--function BBItemNumberRank:GetTheLastList(count)
--    local result = {}
--    for i = #self._rank, 1 do
--        local data = self._rank[i]
--        if i <= count then
--            table.insert(result, {data[1], data[2]})
--        else
--            break
--        end
--    end
--    return result
--end

function BBItemNumberRank:_sortRank()
    if self._isDownSort then
        table.sort(self._rank,function(a, b)
            return a[2] > b[2]
        end)
    else
        table.sort(self._rank,function(a, b)
            return a[2] < b[2]
        end)
    end

    for i = 1, #self._rank do
        local key = self._rank[i][1]
        self._key[key] = i
    end

    self:_onValueChange()
end


function BBItemNumberRank:_onValueChange()
    local count = 0
    for k,v in pairs(self._valueChangeCB) do
        if v then
            v()
        end
        count = count + 1
    end
    if count > 100 then
        print("---   BBItemNumberRank 注册事件超过100个，检查下是否有内存泄露...")
    end
end
