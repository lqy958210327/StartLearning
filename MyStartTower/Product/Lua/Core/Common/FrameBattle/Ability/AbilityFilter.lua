local AbilityFilter = {}

---逻辑与组合过滤器（支持多个过滤器按顺序与操作）
---@param filter1 fun(unit:any):boolean 第一个过滤器
---@param filter2 fun(unit:any):boolean 第二个过滤器
---@return fun(unit:any):boolean 合并后的新过滤器
local function filterAnd(filter1, filter2, ...)
    if filter2 == nil then
        return filter1
    else
        local filterX = filterAnd(filter2, ...)
        return function (unit)
            return filter1(unit) and filterX(unit)
        end
    end
end
AbilityFilter.filterAnd = filterAnd

---逻辑或组合过滤器（支持多个过滤器按顺序或操作）
---@param filter1 fun(unit:any):boolean 第一个过滤器
---@param filter2 fun(unit:any):boolean 第二个过滤器
---@return fun(unit:any):boolean 合并后的新过滤器
local function filterOr(filter1, filter2, ...)
    if filter2 == nil then
        return filter1
    else
        local filterX = filterOr(filter2, ...)
        return function (unit)
            return filter1(unit) or filterX(unit)
        end
    end
end
AbilityFilter.filterOr = filterOr

---逻辑非过滤器
---@param filter1 fun(unit:any):boolean 原始过滤器
---@return fun(unit:any):boolean 取反后的新过滤器
local function filterNot(filter1)
    return function (unit)
        return not filter1(unit)
    end
end
AbilityFilter.filterNot = filterNot

---创建状态类型过滤器
---@param configType string 要匹配的配置类型
---@param configName string 要匹配的配置ID
---@return fun(ability:Ability):boolean 状态匹配过滤器
function AbilityFilter.filterConfig(configType, configName)
    return function (ability)
        return ability._configType == configType and ability._configName == configName
    end
end

---创建状态ID过滤器
---@param stateId number 要匹配的状态ID
---@return fun(ability:Ability):boolean 状态匹配过滤器
function AbilityFilter.filterStateId(stateId)
    return function (ability)
        return ability.stateId == stateId
    end
end

---创建来源单位过滤器
---@param sourceUnit Unit 来源单位实例
---@return fun(ability:Ability):boolean 单位匹配过滤器
function AbilityFilter.filterSourceUnit(sourceUnit)
    return function (ability)
        return ability:getSourceUnit() == sourceUnit
    end
end

---创建复合状态过滤器（同时检查状态ID和来源单位）
---@param stateId number 状态ID
---@param sourceUnit Unit 来源单位实例
---@return fun(ability:Ability):boolean 复合状态过滤器
function AbilityFilter.filterState(stateId, sourceUnit)
    return function (ability)
        return ability.stateId == stateId and ability:getSourceUnit() == sourceUnit
    end
end

---创建状态组过滤器
---@param group integer 要检查的状态组标识
---@return fun(ability:Ability):boolean 状态组匹配过滤器
function AbilityFilter.filterStateGroup(group)
    return function (ability)
        return ability:hasStateGroup(group)
    end
end

---创建标签过滤器
---@param tag string 需要匹配的标签
---@return fun(ability:Ability):boolean 标签匹配过滤器
function AbilityFilter.filterTag(tag)
    return function (ability)
        return ability:hasTag(tag)
    end
end

return AbilityFilter