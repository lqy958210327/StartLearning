local Group = {}

function Group:insert(obj)
    local list = self.list
    table.insert(list, obj)
end

function Group:remove(obj)
    if self.iterating > 0 then
        table.insert(self.deleteList, obj)
    end
    local list = self.list
    for i, a in ipairs(list) do
        if a == obj then
            table.remove(list, i)
            return true
        end
    end
    return false
end

function Group:isRemoving(obj)
    for _, a in ipairs(self.deleteList) do
        if a == obj then
            return true
        end
    end
    return false
end

function Group:beginIterate()
    self.iterating = self.iterating + 1
end

function Group:endIterate()
    self.iterating = self.iterating - 1
    if self.iterating == 0 then
        for _, obj in ipairs(self.deleteList) do
            self:remove(obj)
        end
    end
end

--- 查找符合条件的一个元素
-- @param filter function 接受Unit返回boolean
-- @return Unit
function Group:find(filter)
    local list = self.list
    self:beginIterate()
    for _, obj in ipairs(list) do
        if filter(obj) and not self:isRemoving(obj) then
            self:endIterate()
            return obj
        end
    end
    self:endIterate()
    return nil
end

--- 查找符合条件的所有元素
-- @param filter function 接受Unit返回boolean
-- @return Unit[]
function Group:search(filter)
    local result = {}
    local list = self.list
    self:beginIterate()
    for _, obj in ipairs(list) do
        if not self:isRemoving(obj) then
            if filter(obj) then
                table.insert(result, obj)
            end
        end
    end
    self:endIterate()
    return result
end
--- 查找符合条件的元素个数
-- @param filter function 接受Unit返回boolean
-- @return integer
function Group:count(filter)
    local result = 0
    local list = self.list
    self:beginIterate()
    for _, obj in ipairs(list) do
        if not self:isRemoving(obj) then
            if filter(obj) then
                result = result + 1
            end
        end
    end
    self:endIterate()
    return result
end
--- 取优先级最高的元素
-- @param filterWithPriority function 接受Unit返回number
function Group:max(filterWithPriority)
    local max = -math.huge
    local result
    local list = self.list
    self:beginIterate()
    for _, obj in ipairs(list) do
        if not self:isRemoving(obj) then
            local n = filterWithPriority(obj)
            if n and n > max then
                result = obj
                max = n
            end
        end
    end
    self:endIterate()
    return result
end

--- 取优先级最低的元素
-- @param filterWithPriority function 接受Unit返回number
function Group:min(filterWithPriority)
    local function reverse(unit)
        local priority = filterWithPriority(unit)
        return priority and - priority or false
    end
    return self:max(reverse)
end
--- 取符合条件的随机一个元素
-- @param randomGenerator RandomGenerator 随机数生成器
-- @param filter function 接受Unit返回boolean
-- @return Unit
function Group:random(randomGenerator, filter)
    local list = self.list
    local resultList = {}
    self:beginIterate()
    for _, obj in ipairs(list) do
        if not self:isRemoving(obj) then
            if filter(obj) then
                table.insert(resultList, obj)
            end
        end
    end
    self:endIterate()
    if #resultList > 0 then
        local n = randomGenerator:random(1, #resultList)
        return resultList[n]
    end
    return nil
end

--- 取符合条件的随机count个元素
-- @param randomGenerator RandomGenerator 随机数生成器
-- @param filter function 接受Unit返回boolean
-- @param count number 数量
-- @return Unit[]
function Group:randomList(randomGenerator, filter, count)
    local list = self.list
    local resultList = {}
    self:beginIterate()
    for _, obj in ipairs(list) do
        if not self:isRemoving(obj) then
            if filter(obj) then
                table.insert(resultList, obj)
            end
        end
    end
    self:endIterate()
    if #resultList > count then
        local result = {}
        for i = 1, count do
            local n = randomGenerator:random(1, #resultList)
            table.insert(result, resultList[n])
            table.remove(resultList, n) -- 避免重复
        end
        return result
    end
    return resultList
end
--- 遍历所有元素
-- @param func function 接受Unit
function Group:forEach(func, ...)
    local list = self.list
    self:beginIterate()
    for _, obj in ipairs(list) do
        if not obj._deleted then
            func(obj, ...)
        end
    end
    self:endIterate()
end


local GroupMt = {__index = Group}
local function newGroup()
    return setmetatable({list = {}, iterating = 0, deleteList = {}}, GroupMt)
end

return newGroup