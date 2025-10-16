

---@class GuideConditionData
local GuideConditionData = Class("GuideConditionData")

function GuideConditionData:InternalInit(key, opt, v1, v2)
    self._key = key
    self._opt = opt
    self._value1 = v1
    self._value2 = v2
end



---@class GuideStep
GuideStep = Class("GuideStep")

function GuideStep:Init(id, guideType, group, storeServer, triggerType, triggerParam, triggerUI, actionId, actionParam)
    self._configId = id
    self._guideType = guideType
    self._groupId = group
    self._isStoreServer = storeServer == 1
    self._triggerType = triggerType
    self._triggerParam = triggerParam
    self._triggerUI = triggerUI
    ---@type GuideConditionData[]
    self._conditionList = {}

    self._beginActionEx = actionId
    self._beginActionExParam = actionParam
end

function GuideStep:AddCondition(key, opt, v1, v2)
    local data = GuideConditionData()
    data:InternalInit(key, opt, v1, v2)
    table.insert(self._conditionList, data)
end

function GuideStep:CheckTrigger(value)
    if GuideInternalUtil.CalculateTriggerResult(self._triggerType, self._triggerParam, value) then
        return true
    end
    return false
end

function GuideStep:CheckCondition()
    local result = true
    for i = 1, #self._conditionList do
        local data = self._conditionList[i]
        local key = data._key
        local opt = data._opt
        local value1 = data._value1
        local value2 = data._value2
        local value = GuideDataManager:Get():GetContextValue(key)
        if not GuideInternalUtil.CalculateConditionResult(value, opt, value1, value2) then
            result = false
            break
        end
    end
    return result
end

function GuideStep:Execute()
    LuaCallCs.LogError("---    新手引导日志: 触发引导，id = "..self._configId)

    -- 通知引导UI做表现
    UIManager.InterfaceOpenUI(UIName.UIGuide)
    Blackboard.UIEvent.SendMessage(UIName.UIGuide, UIEventID.UIGuideSetGuideData, self._configId)

    -- 弱引导类型立即标记已完成
    if self._guideType == GuideDefine.GuideType.Weak then
        GuideDataManager:Get():StoreServer(self._configId, self._groupId, self._isStoreServer)
    end

    if self._beginActionEx then
        GuideActionEx.DoAction(self._beginActionEx, self._beginActionExParam)
    end

end
