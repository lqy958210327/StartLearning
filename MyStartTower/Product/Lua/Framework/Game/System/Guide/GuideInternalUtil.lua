


---@class GuideInternalUtil
GuideInternalUtil = {}

local tab = {}

function tab.CheckTriggerTypeValid(triggerType) -- 检查TriggerType是否合法
    local result = true
    local errorStr = ""
    if triggerType == nil then
        result = false
        errorStr = "触发类型 = nil"
    end
    if type(triggerType) ~= "string" then
        result = false
        errorStr = "触发类型必须是string"
    end
    for k, v in pairs(GuideDefine.TriggerType) do
        if v == triggerType then
            return result, errorStr
        end
    end
    result = false
    errorStr = "未知的触发类型，triggerType = "..triggerType
    return result, errorStr
end

function tab.CheckTriggerParamValid(triggerType, triggerParam) -- 检查TriggerType和TriggerParam是否匹配
    local result = true
    local errorStr = ""
    if triggerType == GuideDefine.TriggerType.UIOpen then
        if triggerParam == nil then
            result = false
            errorStr = "TriggerType为UIOpen时，triggerParam = nil"
        end
        if tonumber(triggerParam) == nil then
            result = false
            errorStr = "TriggerType为UIOpen时，triggerParam类型必须是number"
        end
    elseif triggerType == GuideDefine.TriggerType.FightingTimer then
    elseif triggerType == GuideDefine.TriggerType.HeroManaFull then
        if triggerParam == nil then
            result = false
            errorStr = "TriggerType为HeroManaFull时，triggerParam = nil"
        end
        if tonumber(triggerParam) == nil then
            result = false
            errorStr = "TriggerType为HeroManaFull时，triggerParam类型必须是number"
        end
    elseif triggerType == GuideDefine.TriggerType.NextStep then
    elseif triggerType == GuideDefine.TriggerType.UIClose then
        if triggerParam == nil then
            result = false
            errorStr = "TriggerType为UIClose时，triggerParam = nil"
        end
        if tonumber(triggerParam) == nil then
            result = false
            errorStr = "TriggerType为UIClose时，triggerParam类型必须是number"
        end
    elseif triggerType == GuideDefine.TriggerType.FormationGuideFinish then
    end
    return result, errorStr
end

function tab.CheckContextKeyValid(contextKey) -- 检查ContextKey是否合法
    local result = true
    local errorStr = ""
    if contextKey == nil then
        result = false
        errorStr = "contextKey = nil"
    end
    if type(contextKey) ~= "string" then
        result = false
        errorStr = "contextKey必须是string类型"
    end
    for k, v in pairs(GuideDefine.ContextKey) do
        if v == contextKey then
            return result, errorStr
        end
    end
    result = false
    errorStr = "未知的ContextType, contextType = "..contextKey
    return result, errorStr
end

function tab.CheckContextValueValid(contextKey, value) -- 检查ContextType和ContextValue是否匹配
    local result = true
    local errorStr = ""
    if contextKey == GuideDefine.ContextKey.MainStory then
        if value == nil then
            result = false
            errorStr = "contextKey = MainStory时，value = nil"
        end
        if type(value) ~= "number" then
            result = false
            errorStr = "contextKey = MainStory时，value必须是number"
        end
    elseif contextKey == GuideDefine.ContextKey.LastGuideGroup then
        if value == nil then
            result = false
            errorStr = "contextKey = LastGuideGroup时，value = nil"
        end
        if type(value) ~= "number" then
            result = false
            errorStr = "contextKey = LastGuideGroup时，value必须是number"
        end
    elseif contextKey == GuideDefine.ContextKey.ServerGroupID then
        if value == nil then
            result = false
            errorStr = "contextKey = ServerGroupID时，value = nil"
        end
        if type(value) ~= "number" then
            result = false
            errorStr = "contextKey = ServerGroupID时，value必须是number"
        end
    elseif contextKey == GuideDefine.ContextKey.HeroDB then
        if value == nil then
            result = false
            errorStr = "contextKey = HeroDB时，value = nil"
        end
        if type(value) ~= "number" then
            result = false
            errorStr = "contextKey = HeroDB时，value必须是number"
        end
    end
    return result, errorStr
end

function tab.CheckContextValid(contextKey, value) -- 检查ContextType和ContextValue是否匹配
    local result = true
    local errorStr = ""
    result, errorStr = tab.CheckContextKeyValid(contextKey)
    if result then
        result, errorStr = tab.CheckContextValueValid(contextKey, value)
    end
    return result, errorStr
end

function tab.CheckOperateTypeValid(opt) -- 检查OperateType是否合法
    local result = true
    local errorStr = ""
    if opt == nil then
        result = false
        errorStr = "operateType = nil"
    end
    if type(opt) ~= "string" then
        result = false
        errorStr = "operateType必须是string类型"
    end
    for k, v in pairs(GuideDefine.OperateType) do
        if v == opt then
            return result, errorStr
        end
    end
    result = false
    errorStr = "未知的operateType, operateType = "..opt
    return result, errorStr
end

function tab.CheckOperateParamValid(opt, v1, v2) -- 检查OperateType对应的参数是否合法
    local result = true
    local errorStr = ""
    if opt == GuideDefine.OperateType.Equal then
        if v1 == nil then
            result = false
            errorStr = "operateType = Equal时，v1 = nil"
        end
    elseif opt == GuideDefine.OperateType.More then
        if v1 == nil then
            result = false
            errorStr = "operateType = More时，v1 = nil"
        end
    elseif opt == GuideDefine.OperateType.Less then
        if v1 == nil then
            result = false
            errorStr = "operateType = Less时，v1 = nil"
        end
    elseif opt == GuideDefine.OperateType.Round then
        if v1 == nil then
            result = false
            errorStr = "operateType = Round时，v1 = nil"
        end
        if v2 == nil then
            result = false
            errorStr = "operateType = Round时，v2 = nil"
        end
    elseif opt == GuideDefine.OperateType.Exist then
        if v1 == nil then
            result = false
            errorStr = "operateType = Exist时，v1 = nil"
        end
    elseif opt == GuideDefine.OperateType.NotExist then
        if v1 == nil then
            result = false
            errorStr = "operateType = NotExist时，v1 = nil"
        end
    end
    return result, errorStr
end

function tab.CheckConditionAndOperateTypeValid(contextKey, opt) -- 检查contextKey和OperateType是否匹配
    local result = true
    local errorStr = ""
    if opt == GuideDefine.OperateType.Equal or opt == GuideDefine.OperateType.More or opt == GuideDefine.OperateType.Less or opt == GuideDefine.OperateType.Round then
        if tab.CheckContextTypeMatchNumber(contextKey) then

        else
            result = false
            errorStr = "ContextKey 和 OperateType 不匹配， ContextKey = "..contextKey..", OperateType = "..opt
        end
    end
    if opt == GuideDefine.OperateType.Exist or opt == GuideDefine.OperateType.NotExist then
        if tab.CheckContextTypeMatchMap(contextKey) then

        else
            result = false
            errorStr = "ContextKey 和 OperateType 不匹配， ContextKey = "..contextKey..", OperateType = "..opt
        end
    end
    return result, errorStr
end

function tab.CheckConditionValid(contextKey, opt, v1, v2) -- 检查limit配置 是否合法
    local result = true
    local errorStr = ""
    result, errorStr = tab.CheckContextKeyValid(contextKey)
    if result then
        result, errorStr = tab.CheckOperateTypeValid(opt)
        if result then
            result, errorStr = tab.CheckOperateParamValid(opt, v1, v2)
            if result then
                result, errorStr = tab.CheckConditionAndOperateTypeValid(contextKey, opt)
            end
        end
    end
    return result, errorStr
end


function tab.CheckContextTypeMatchNumber(contextKey) -- 检查contextKey是否是number类型的数据
    if contextKey == GuideDefine.ContextKey.MainStory or contextKey == GuideDefine.ContextKey.LastGuideGroup then
        return true
    end
    return false
end
function tab.CheckContextTypeMatchMap(contextKey) -- 检查contextKey是否是map类型的数据
    if contextKey == GuideDefine.ContextKey.ServerGroupID or contextKey == GuideDefine.ContextKey.HeroDB then
        return true
    end
    return false
end

function tab.CalculateConditionResult(value, opt, v1, v2) -- 计算condition结果
    local result = false
    if opt == GuideDefine.OperateType.Equal then
        if value == v1 then
            result = true
        end
    elseif opt == GuideDefine.OperateType.More then
        if value >= v1 then
            result = true
        end
    elseif opt == GuideDefine.OperateType.Less then
        if value <= v1 then
            result = true
        end
    elseif opt == GuideDefine.OperateType.Round then
        if value >= v1 and value <= v2 then
            result = true
        end
    elseif opt == GuideDefine.OperateType.Exist then
        if value[v1] then
            result = true
        end
    elseif opt == GuideDefine.OperateType.NotExist then
        if not value[v1] then
            result = true
        end
    end
    return result
end

function tab.CalculateTriggerResult(triggerType, triggerParam, value) -- 计算trigger的触发结果
    local result = false
    if triggerType == GuideDefine.TriggerType.UIOpen then
        result = triggerParam == value
    elseif triggerType == GuideDefine.TriggerType.FightingTimer then
        result = true
    elseif triggerType == GuideDefine.TriggerType.HeroManaFull then
        result = triggerParam == value
    elseif triggerType == GuideDefine.TriggerType.NextStep then
        result = true
    elseif triggerType == GuideDefine.TriggerType.UIClose then
        result = triggerParam == value
    elseif triggerType == GuideDefine.TriggerType.FormationGuideFinish then
        result = true
    end
    return result
end

function tab.AnalyseConfigTriggerParam(triggerType, triggerParam) -- 解析配置数据，triggerParam
    local result = nil
    if triggerType == GuideDefine.TriggerType.UIOpen then
        result = tonumber(triggerParam)
    elseif triggerType == GuideDefine.TriggerType.FightingTimer then

    elseif triggerType == GuideDefine.TriggerType.HeroManaFull then
        result = tonumber(triggerParam)
    elseif triggerType == GuideDefine.TriggerType.NextStep then

    elseif triggerType == GuideDefine.TriggerType.UIClose then
        result = tonumber(triggerParam)
    elseif triggerType == GuideDefine.TriggerType.FormationGuideFinish then
    end
    return result
end

GuideInternalUtil = tab
