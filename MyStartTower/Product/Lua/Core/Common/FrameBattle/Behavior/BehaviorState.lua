--local Class = require "Core/Framework/Class"
local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local strClassName = "BehaviorState"
local BehaviorState = Class(strClassName)

--一个技能一个状态，在状态里管理片段跳转
--考虑用一个字段控制片段的播放

--对应播放的动画片段字典
--  key：跳转条件 value：对应动作
local mAnimationClipDict

-- 构造函数
function BehaviorState:ctor(parentSM, name, data, cacheData)
    self.mStateMachine = parentSM
    if cacheData then
        self:initDataFromCacheData(cacheData)
    else
        self:initData(data)
    end
end

------------------------Event--------------------------------------------------
function BehaviorState.Event(eventInfo)
    return BehaviorState.EventByElems(
        eventInfo["functionName"],
        eventInfo["data"],
        eventInfo["stringParameter"],
        eventInfo["floatParameter"],
        eventInfo["intParameter"]
    )
end

function BehaviorState.EventByElems(eventName, data, stringParameter, floatParameter, intParameter)
    local eventData = {}
    eventData.Name = eventName
    eventData.Data = data
    eventData.StringParameter = stringParameter or ""
    eventData.FloatParameter = floatParameter or 0
    eventData.IntParameter = intParameter or 0

    if BattleConst.EVENT_MAP[eventData.Name] then
        eventData.Type = BattleConst.EVENT_MAP[eventData.Name]
    else
        utils.logToLogger("Register Event First!" .. eventData.Name)
    end
    return eventData
end

local function SortOfEvents(A, B)
    if A.IntParameter ~= 0 or B.IntParameter ~= 0 then
        return A.IntParameter > B.IntParameter
    else
        return A.Name > B.Name
    end
end

function BehaviorState:initDataFromCacheData(cacheData)
    self.mStateName = cacheData.mStateName
    self.mSkillName = cacheData.mSkillName
    self.mSkillLength = cacheData.mSkillLength
    self.motionInfo = cacheData.motionInfo
    self.supercancelTime = cacheData.supercancelTime
end

function BehaviorState:getCacheData()
    local cacheData = {}
    cacheData.mSkillName = self.mSkillName
    cacheData.mSkillLength = self.mSkillLength
    cacheData.motionInfo = self.motionInfo
    cacheData.mStateName = self.mStateName
    cacheData.supercancelTime = self.supercancelTime
    return cacheData
end

------------------------Init--------------------------------------------------
function BehaviorState:initData(data)
    self.mStateName = data["stateName"]
    self.mSkillLength = data["skillLength"]
    self.motionInfo = data["motion"]
    self.supercancelTime = self.mSkillLength
    if self.motionInfo then
        for _, eventInfo in pairs(self.motionInfo["events"]) do
            if eventInfo.functionName == BattleConst.BEHAVIOR_EVENT_SUPER_CANCEL then
                self.supercancelTime = eventInfo["time"] or 0
            end
        end
    end
end

BehaviorState.SkillAnimEndEvent = BehaviorState.Event({functionName = BattleConst.BEHAVIOR_EVENT_TO_IDLE_ANIM})
BehaviorState.SkillEndEvent = BehaviorState.Event({functionName = BattleConst.BEHAVIOR_EVENT_SKILL_END})
function BehaviorState:initSkillEvent(useSkillArgs)
    local adjustTime = useSkillArgs.attackRealTime
    local skillCd = useSkillArgs.attackCd
    local delayFrame = 0
    if useSkillArgs.delayFrame then
        delayFrame = useSkillArgs.delayFrame
    end
    self.skillCd = skillCd
    if adjustTime == nil then
        if self.mMaxCount then -- 已经初始化了
            return
        else
            adjustTime = self.mSkillLength
        end
    end
    if self.adjustTime == adjustTime then
        return
    end
    self.adjustTime = adjustTime
    local nextEnableTime = math.min(self.adjustTime, self.supercancelTime)
    self.nextSkillEnableFrame = self:timeToFrame(nextEnableTime)
    self.mMaxCount = delayFrame + self:timeToFrame(adjustTime)
    local nowSpeed = 1.0
    if adjustTime < self.supercancelTime then
        nowSpeed = self.supercancelTime / adjustTime -- 只加速supercancel之前的
    elseif skillCd and adjustTime > skillCd then
        nowSpeed = skillCd / adjustTime -- 减速规则
    end
    if self.aniSpeed == nowSpeed then
        return
    end
    self.aniSpeed = nowSpeed
    local timeRate = 1 / nowSpeed
    self.mEventsDict = {}
    if self.motionInfo then
        -- TODO:LOG: pairs 修改为有序遍历 table.sortpairs
        for eventName, eventInfo in table.sortpairs(self.motionInfo["events"]) do
            -- 事件如果插在了hasExit之后,则强制修正为最后一帧触发
            local eTime = eventInfo["time"] or 0
            if eTime > self.supercancelTime then
                if self.aniSpeed >= 1.0 then
                    eTime = self.supercancelTime -- 加速/原速
                else
                    eTime = self.supercancelTime * timeRate -- 减速
                end
            end
            eTime = eTime * timeRate
            local eventInfoSerial = self.Event(eventInfo)
            local triggerFrame = delayFrame + self:timeToFrame(eTime)
            if not self.mEventsDict[triggerFrame] then
                self.mEventsDict[triggerFrame] = {eventInfoSerial}
            else
                table.insert(self.mEventsDict[triggerFrame], eventInfoSerial)
            end
        end
        for triggerFrame, eventSerials in pairs(self.mEventsDict) do
            if #eventSerials > 1 then
                table.sort(eventSerials, SortOfEvents)
            end
        end
        -- 添加纯表现层的  技能动作结束事件
        local animEndFrame = delayFrame + self:timeToFrame(self.mSkillLength * timeRate)
        if not self.mEventsDict[animEndFrame] then
            self.mEventsDict[animEndFrame] = {BehaviorState.SkillAnimEndEvent}
        else
            table.insert(self.mEventsDict[animEndFrame], BehaviorState.SkillAnimEndEvent)
        end
        table.insert(self.mEventsDict[animEndFrame], BehaviorState.SkillEndEvent)
    else
        --logerror("Oh shit! Game skill configuration error!  not motionInfo ! " .. self.mStateName)
        logerror("---   技能数据异常：BehaviorData 中的 motion = nil，key = "..self.mStateName.. "   WeaponType = "..self.mStateMachine.weaponType)
    end
end

function BehaviorState:timeToFrame(seconds)
    local frame = math.floor(seconds * 1000 / self.mStateMachine:getVariable("frameLength"))
    if seconds > 0 then
        frame = math.max(1, frame)
    end
    return frame
end

function BehaviorState:enter(useSkillArgs)
    self.mStateCurrentFrame = 0
    self:initSkillEvent(useSkillArgs)
    if self.mEventsDict[self.mStateCurrentFrame] then
        for i, eventInfo in ipairs(self.mEventsDict[self.mStateCurrentFrame]) do
            table.insert(self.mStateMachine.mEventList, eventInfo)
        end
    end
end

function BehaviorState:destroy()
    self.mStateMachine = nil
    self.mEventsDict = nil
end

function BehaviorState:exit()
    self.mStateCurrentFrame = 0
end

function BehaviorState:tick()
    self.mStateCurrentFrame = self.mStateCurrentFrame + 1
    if self.mEventsDict[self.mStateCurrentFrame] then
        for i, eventInfo in ipairs(self.mEventsDict[self.mStateCurrentFrame]) do
            table.insert(self.mStateMachine.mEventList, eventInfo)
        end
    end
    -- if self.mStateCurrentFrame >= self.mMaxCount then
    --     table.insert(self.mStateMachine.mEventList, BehaviorState.SkillEndEvent)
    -- end
end

return BehaviorState
