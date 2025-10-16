

local __enable = true

---@class GuideSystem : SystemBase
GuideSystem = Class("GuideSystem", SystemBase)

function GuideSystem:OnInit()
    ---@type GuideStep
    self._curGuideStep = nil

    self._evtEnable = function(value) __enable = value end
    self._evtTrigger = function(triggerType, param) self:_trigger(triggerType, param) end
    self._evtUpdateContext = function(contextKey, value) self:_updateLimitData(contextKey, value) end
    self._evtGuideEnd = function(id) self:_guideEnd(id) end
    self._evtBreakWeakGuide = function(uiId) self:_breakWeakGuide(uiId) end
    EventManager.Global.RegisterEvent(EventType.GuideSystemEnable, self._evtEnable)
    EventManager.Global.RegisterEvent(EventType.GuideSystemTrigger, self._evtTrigger)
    EventManager.Global.RegisterEvent(EventType.GuideSystemUpdateContext, self._evtUpdateContext)
    EventManager.Global.RegisterEvent(EventType.GuideSystemGuideEnd, self._evtGuideEnd)
    EventManager.Global.RegisterEvent(EventType.GuideSystemBreakWeakGuide, self._evtBreakWeakGuide)

    GuideDataManager:Get():Init()
end

function GuideSystem:OnClear()
    EventManager.Global.UnRegisterEvent(EventType.GuideSystemEnable, self._evtEnable)
    EventManager.Global.UnRegisterEvent(EventType.GuideSystemTrigger, self._evtTrigger)
    EventManager.Global.UnRegisterEvent(EventType.GuideSystemUpdateContext, self._evtUpdateContext)
    EventManager.Global.UnRegisterEvent(EventType.GuideSystemGuideEnd, self._evtGuideEnd)
    EventManager.Global.UnRegisterEvent(EventType.GuideSystemBreakWeakGuide, self._evtBreakWeakGuide)
end

function GuideSystem:OnGameStart()

end

function GuideSystem:OnGameEnd()
    GuideDataManager:Get():ClearCache()
end



function GuideSystem:_trigger(triggerType, param)
    if not __enable then
        return
    end

    local valid, error = GuideInternalUtil.CheckTriggerTypeValid(triggerType)
    if not valid then
        LuaCallCs.LogError("---   新手引导报错: 触发引导失败，triggerType校验失败.   error = "..error)
        return
    end

    local list = GuideDataManager:Get():GetGuideListByTriggerType(triggerType, param)
    for i = 1, #list do
        local step = list[i]
        local canTrigger = step:CheckTrigger(param)
        if canTrigger then
            canTrigger = step:CheckCondition()
            if canTrigger then
                self._curGuideStep = step
                step:Execute()
                break
            end
        end
        --LuaCallCs.LogError("---    触发新手引导测试日志，这个引导不满足条件，不触发，id = "..step._configId)
    end
end

function GuideSystem:_updateLimitData(contextKey, value)
    local valid, error = GuideInternalUtil.CheckContextValid(contextKey, value)
    if not valid then
        LuaCallCs.LogError("---   新手引导报错: 更新Context数据失败.   error = "..error)
        return
    end
    GuideDataManager:Get():UpdateContext(contextKey, value)
end

function GuideSystem:_guideEnd(id)
    if id == nil then
        LuaCallCs.LogError("---   新手引导报错: 引导结束时数据异常，EndGuideId = nil")
        return
    end
    if self._curGuideStep == nil then
        LuaCallCs.LogError("---   新手引导报错: 引导结束时数据异常，当前引导为空.   EndGuideId = "..id)
        return
    end
    if id ~= self._curGuideStep._configId then
        LuaCallCs.LogError("---   新手引导报错: 数据异常，引导结束id与当前引导id不一致.   id = "..id)
    end
    local groupId = self._curGuideStep._groupId
    local isStoreServer = self._curGuideStep._isStoreServer
    self._curGuideStep = nil
    GuideDataManager:Get():UpdateContext(GuideDefine.ContextKey.LastGuideGroup, id)
    GuideDataManager:Get():StoreServer(id, groupId, isStoreServer)
    UIManager.InterfaceCloseUI(UIName.UIGuide)
end

function GuideSystem:_breakWeakGuide(uiId)
    if self._curGuideStep and self._curGuideStep._guideType == GuideDefine.GuideType.Weak and self._curGuideStep._triggerUI == uiId then
        UIManager.InterfaceCloseUI(UIName.UIGuide)
    end
end

function GuideSystem:_checkLimitData(id)

end

function GuideSystem:_checkLimitData()

end