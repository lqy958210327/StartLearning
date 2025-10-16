-- 技能事件组件
-- 技能事件组件用于处理技能的渲染帧事件，每个技能对应一个技能事件组件。
-- 技能事件组件中，包含多个事件。
-- 存储结构为Dictionary，key为目标帧，value为事件列表（多个事件实体SkillTimeEntity）。
-- 每帧执行事件列表中的事件。施行后从事件列表中移除。
-- 执行到最后一帧时，执行所有未完成事件。
-- 当前帧事件执行完毕后释放资源。

local className = "SkillTimeComponent"
---@class SkillTimeComponent 技能渲染帧事件组件
SkillTimeComponent = Class(className)

function SkillTimeComponent:ctor(entityUid, skillTag)
    self._entityUid = entityUid ---@type string 实体UID
    self._skillTag = skillTag ---@type number 技能id
    self._pasue = true  ---@type boolean 是否暂停
    self._sentryFrame = 0 ---@type number 下次更新时的起始执行帧(哨兵帧)
    self._current = 0 ---@type number 当前时间(秒)
    self._waitTriggeredNextEntityDic = {} ---@type table<number, SkillTimeEntity[]> | nil 已触发entity的NextEntity缓存。技能被打断，或正常状态下都要触发。
    self._syncTime = 0 ---@type number 同步次数
    self._config = SkillTimeHelper.GetConfig(skillTag) ---@type SkillTimeEventConfig | nil 配置
    if self._config == nil then
        return
    end
    self._eventEntityDic = SkillTimeHelper.AdapterEventEntities(self._config) ---@type table<number, SkillTimeEntity[]> | nil 事件字典 key:tick value:事件实体列表

end

---@type fun(self:SkillTimeComponent): SkillTimeComponent 开始执行事件
function SkillTimeComponent:Begin()
    SkillTimeHelper.HideAndPauseFloatingWorks()
    return self:Continue()
end

---@type fun(self:SkillTimeComponent): SkillTimeComponent 继续执行事件
function SkillTimeComponent:Continue()
    self._pasue = false
    return self
end

---@type fun(self:SkillTimeComponent): SkillTimeComponent 暂停执行事件
function SkillTimeComponent:Pause()
    self._pasue = true
    return self
end

---@type fun(self:SkillTimeComponent, isEnd:boolean): SkillTimeComponent 释放资源
function SkillTimeComponent:Dispose(isEnd)
    self:Pause(); ---暂停OnFrameUpdate
    if isEnd then
        print("CurTime:"..self._current.."; SkillTimeComponent is End! ".."entityUid:"..self._entityUid.."; skillTag:"..self._skillTag)
    else
        print("CurTime:"..self._current.."; SkillTimeComponent is interrupt! ".."entityUid:"..self._entityUid.."; skillTag:"..self._skillTag)
    end

    if isEnd then ---技能正常结束。执行后续事件
        local endFrame = SkillTimeHelper.TimeToFrame(self:GetDurationSec(), self:GetFPS())
        if endFrame >= self._sentryFrame then --当前帧小于上一帧时不执行
            for executeFrame = self._sentryFrame, endFrame do
                self:ToExecute(executeFrame)
            end
            self._current = self:GetDurationSec()
            self._sentryFrame = endFrame + 1
        end
    end

    self._eventEntityDic = nil    
    self:ToExecuteEndEvents()
    SkillTimeHelper.ShowAndResumeFloatingWorks()
end

---@type fun(self:SkillTimeComponent, tick:number) 帧更新
function SkillTimeComponent:OnFrameUpdate(deltaTime)
    if self:IsPause() then
        return
    end

    self._syncTime = self._syncTime + 1
    self._current = self._current + deltaTime
    local curFrame = SkillTimeHelper.TimeToFrame(self._current, self:GetFPS())
    ---第0帧也要执行一次。
    if curFrame > 0 and curFrame < self._sentryFrame then --当前帧小于上一帧时不执行
        return
    end

    for executeFrame = self._sentryFrame, curFrame do
        self:ToExecute(executeFrame)
    end

    self._sentryFrame = curFrame + 1 ---下次更新的起始执行帧
    if not self:IsEnd() then return end
    self:Pause()
end

function SkillTimeComponent:ToString()
    return "SkillTimeComponent entityUid:"..self._entityUid.."; skillTag:"..self._skillTag
end

------private------
---@type fun(self:SkillTimeComponent): boolean
---@return boolean
---@private 是否执行结束
function SkillTimeComponent:IsEnd()
    return self._current >= self:GetDurationSec()
end

---@type fun(self:SkillTimeComponent) : boolean
---@return boolean
---@private 是否暂停
function SkillTimeComponent:IsPause()
    return self._pasue 
end

function SkillTimeComponent:LogSyncTime()
    return 
end

function SkillTimeComponent:LogInfo(frameIndex, event)
    print("CurTime:"..self._current.."; SyncTimes:"..self._syncTime.."; frame:"..frameIndex.."; to excute:"..event:ToString())
end

---@type fun(self:SkillTimeComponent, frameIndex:number)
---@private 执行当前帧事件
function SkillTimeComponent:ToExecute(frameIndex)
    if self._eventEntityDic ~= nil then
        local eventList = self._eventEntityDic[frameIndex]
        if eventList ~= nil then
            for i, _ in pairs(eventList) do
                local event = eventList[i]
                -- self:LogInfo(frameIndex, event)
                event:ToExecute(self._entityUid, self._skillTag)      
                local nextEntity = event:GetNextEntity()
                if nextEntity then -- 记录已触发的event和其对应的endEvent
                    local executeFrame = nextEntity:GetExecuteFrame()
                    self._waitTriggeredNextEntityDic[executeFrame] = self._waitTriggeredNextEntityDic[executeFrame] or {}
                    table.insert(self._waitTriggeredNextEntityDic[executeFrame], nextEntity)
                end
            end
            self._eventEntityDic[frameIndex] = nil ---清理当前帧事件
        end
    end

    if self._waitTriggeredNextEntityDic ~= nil then
        local endEventList = self._waitTriggeredNextEntityDic[frameIndex]
        if endEventList ~= nil then
            for i, _ in pairs(endEventList) do
                local endEvent = endEventList[i]
                -- self:LogInfo(frameIndex, endEvent)
                endEvent:ToExecute(self._entityUid, self._skillTag)
            end
            self._waitTriggeredNextEntityDic[frameIndex] = nil ---清理当前帧结束事件
        end
    end
end

---@type fun(self:SkillTimeComponent)
---@private 执行结束事件
function SkillTimeComponent:ToExecuteEndEvents()
    if self._waitTriggeredNextEntityDic ~= nil then       
        -- 执行所有已触发的startEvent对应的endEvent
        for frame, _ in pairs(self._waitTriggeredNextEntityDic) do
            local endEventList = self._waitTriggeredNextEntityDic[frame]
            if endEventList ~= nil then
                for i, _ in pairs(endEventList) do
                    local endEvent = endEventList[i]
                    if not endEvent:IsExecute() then    
                        -- self:LogInfo(frame, endEvent)
                        endEvent:ToExecute(self._entityUid, self._skillTag)
                    end
                end
            end
        end
        self._waitTriggeredNextEntityDic = nil
    end
end

---@type fun(self:SkillTimeComponent, event:SkillTimeEntity)
---@private 执行当前帧事件
function SkillTimeComponent:GetFPS()
    if self._config == nil then
        return SkillTimeHelper.DefaultFPS();
    end
    return self._config:GetFPS()
end

---@type fun(self:SkillTimeComponent)
---@private 获取总时长(秒)
---@return number
function SkillTimeComponent:GetDurationSec()
    if self._config == nil then
        return 0
    end
    return self._config:GetDurationSec()
end

---@type fun(self:SkillTimeComponent)
---@private 获取总时长(帧)
---@return number
function SkillTimeComponent:GetDurationFrame()
    if self._config == nil then
        return 0
    end
    return self._config:GetDurationFrame()
end
