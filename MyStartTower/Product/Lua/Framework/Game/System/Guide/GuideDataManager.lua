
---@class GuideConditionContext
local GuideConditionContext = Class("GuideConditionContext")

function GuideConditionContext:Init()
    self._mainStory = 0
    self._lastGuideGroup = 0
    ---@type table<number, boolean>
    self._serverGroupID = {}
    ---@type table<number, boolean>
    self._heroDB = {}
end

function GuideConditionContext:Clear()
    self:Init()
end

function GuideConditionContext:SetMainStory(value)
    self._mainStory = value
end

function GuideConditionContext:GetMainStory()
    return self._mainStory
end

function GuideConditionContext:SetLastGuideGroup(value)
    self._lastGuideGroup = value
end
function GuideConditionContext:GetLastGuideGroup()
    return self._lastGuideGroup
end

function GuideConditionContext:SetServerGroupID(value)
    self._serverGroupID[value] = true
end

function GuideConditionContext:GetSetServerGroupID()
    return self._serverGroupID
end

function GuideConditionContext:GetHeroDB()
    return self._heroDB
end



-- 私有数据管理器，业务侧禁止调用!!!

---@class GuideDataManager
GuideDataManager = Class("GuideDataManager")

---@return GuideDataManager
function GuideDataManager:Get()
    if self._instance == nil then
        self._instance = GuideDataManager()
    end
    return self._instance
end

function GuideDataManager:Init()
    ---@type table<string, GuideStep[]>
    self._stepDict = {}
    for k, v in pairs(GuideDefine.TriggerType) do
        self._stepDict[v] = {}
    end

    self._contextData = GuideConditionContext()
    self._contextData:Init()

    self:_initGuideStepList()
end

function GuideDataManager:ClearCache()
    self._contextData:Clear()
end

---@return GuideStep[]
function GuideDataManager:GetGuideListByTriggerType(triggerType)
    local list = self._stepDict[triggerType]
    return list
end

function GuideDataManager:StoreServer(stepId, groupId, isStore)
    if isStore then
        GuideDataManager:Get():UpdateContext(GuideDefine.ContextKey.ServerGroupID, groupId)
        -- send msg
        SendHandlers.ReqGuide(stepId, groupId, true)
    end
end

function GuideDataManager:UpdateContext(contextKey, value)
    if contextKey == GuideDefine.ContextKey.MainStory then
        self._contextData:SetMainStory(value)
    elseif contextKey == GuideDefine.ContextKey.LastGuideGroup then
        self._contextData:SetLastGuideGroup(value)
    elseif contextKey == GuideDefine.ContextKey.ServerGroupID then
        self._contextData:SetServerGroupID(value)
    elseif contextKey == GuideDefine.ContextKey.HeroDB then
    end
end

function GuideDataManager:GetContextValue(contextKey)
    if contextKey == GuideDefine.ContextKey.MainStory then
        return self._contextData:GetMainStory()
    elseif contextKey == GuideDefine.ContextKey.LastGuideGroup then
        return self._contextData:GetLastGuideGroup()
    elseif contextKey == GuideDefine.ContextKey.ServerGroupID then
        return self._contextData:GetSetServerGroupID()
    elseif contextKey == GuideDefine.ContextKey.HeroDB then
        return self._contextData:GetHeroDB()
    end
end

function GuideDataManager:_initGuideStepList()
    for k, v in pairs(DataTable.ResPlayerGuideData) do
        local step = self:_generateGuideStep(v)
        if step then
            self:_addConditionData(step, v.limit1)
            self:_addConditionData(step, v.limit2)
            self:_addConditionData(step, v.limit3)
            self:_addConditionData(step, v.limit4)
            self:_addConditionData(step, v.limit5)
            self:_addConditionData(step, v.limit6)

            local list = self._stepDict[step._triggerType]
            table.insert(list, step)
        end
    end

    self:_sortGuideStepList()
end


function GuideDataManager:_sortGuideStepList()
    for k, v in pairs(self._stepDict) do
        table.sort(v, function(a, b)
            return a._configId < b._configId
        end)
    end
end

---@return GuideStep
function GuideDataManager:_generateGuideStep(cfg)
    local id = cfg.id
    local type = cfg.type
    local group = cfg.groupId
    local storeServer = cfg.storeServer
    local triggerType = cfg.trigger
    local triggerParam = cfg.triggerParam
    local triggerUI = cfg.targetUI
    local actionId = cfg.guideBeginExAction
    local actionParam = cfg.guideBeginExActionParam
    local valid, error = GuideInternalUtil.CheckTriggerTypeValid(triggerType)
    if not valid then
        LuaCallCs.LogError("---   新手引导报错: 配置错误，无法初始化GuideStep，id = "..id.."   error = "..error)
        return nil
    end
    valid, error = GuideInternalUtil.CheckTriggerParamValid(triggerType, triggerParam)
    if not valid then
        LuaCallCs.LogError("---   新手引导报错: 配置错误，无法初始化GuideStep，id = "..id.."   error = "..error)
        return nil
    end

    triggerParam = GuideInternalUtil.AnalyseConfigTriggerParam(triggerType, triggerParam)
    local step = GuideStep()
    step:Init(id, type, group, storeServer, triggerType, triggerParam, triggerUI, actionId, actionParam)
    return step
end

---@param step GuideStep
function GuideDataManager:_addConditionData(step, limit)
    if limit then
        local str = string.split(limit, ',')
        local key = str[1]
        local opt = str[2]
        local v1 = str[3] and tonumber(str[3]) or nil
        local v2 = str[4] and tonumber(str[4]) or nil
        local valid, error = GuideInternalUtil.CheckConditionValid(key, opt, v1, v2)
        if not valid then
            LuaCallCs.LogError("---   新手引导报错: 配置错误，无法初始化Condition，id = "..step._configId.."   limit = "..limit.."   error = "..error)
            return
        end
        step:AddCondition(key, opt, v1, v2)
    end
end
