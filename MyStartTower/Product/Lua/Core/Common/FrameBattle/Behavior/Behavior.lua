
local BehaviorState = require "Core/Common/FrameBattle/Behavior/BehaviorState"
local BehaviorSerialization = require "Core/Common/FrameBattle/Behavior/BehaviorSerialization"
local BattleConst = require "Core/Common/FrameBattle/BattleConst"

local strClassName = "Behavior"
local Behavior = Class(strClassName)

-- 构造函数。
function Behavior:ctor( entity,bhVariables,bhMgr )
    self.entityID = entity.id
    self.weaponType = entity.weaponType
    --所有状态的信息字典
    self.mStateDict = {}
    --当前状态tick后会产生事件放在这里
    -- 数组存储，value为event
    self.mEventList = {}
    --处理事件的实体在此注册事件处理函数
    self.mEventHandler = {}
    --bh的一些参数，其中“frameLength”需要在任意动作片段播放之前设置
    self.mVariables = bhVariables or {}

    -- TODO  数据做成全局，提供接口取
    BehaviorSerialization.init(self, self.weaponType)
    --BH Manager注册自己
    self.bhMgr = bhMgr
    bhMgr:addBehavior(self.entityID,self)
    self.mEntity = entity
    --激活
    if self:getVariable("frameLength") == nil then
        self:setVariable("frameLength",50)
    end
    self.inPause = false
end

-- 析构函数。
function Behavior:destroy()
    self.bhMgr:delBehavior(self.entityID)
    self.bhMgr = nil
    self:clearEventHandler()
    self.mEventList = nil
    self.mEventHandler = nil
    self.mVariables = nil
end

----------------EventHandler相关-------------------------------
function Behavior:addEventHandler(eventName, func)
    if BattleConst.EVENT_MAP[eventName] == nil then
        utils.logToLogger("Add event handler fail,register event in BattleConst.EVENT_MAP first.")
        return nil
    end
    if BattleConst.EVENT_MAP[eventName] == BattleConst.BEHAVIOR_IGNORE then
        return nil
    end

    if not self.mEventHandler[eventName] then
        self.mEventHandler[eventName] = {}
    end

    table.insert(self.mEventHandler[eventName],func)
end

function Behavior:clearEventHandler(eventName)
    if self.mEventHandler[eventName] then
        self.mEventHandler[eventName] = {}
    end
end

function Behavior:delEventHandler(eventName,func)
    if self.mEventHandler[eventName] then
        local removeIndex = utils.getIndexByValue(self.mEventHandler[eventName] , func)
        if removeIndex >= 0 then
            table.remove(self.mEventHandler[eventName],removeIndex)
        end
    end
end
--------------END:   EventHandler相关------------------------

function Behavior:useSkill(conditionName, useSkillArgs)
    if self.mStateDict[conditionName] then
        self:changeState(conditionName, -1, useSkillArgs)
    else
        logerror("找不到技能的动作", self.mEntity.name, conditionName)
        table.insert(self.mEventList, BehaviorState.SkillEndEvent)
    end
end

function Behavior:changeState(nextState, duration, useSkillArgs, behaviorAnim)
    if self.mCurrentState then
        self.mCurrentState:exit()
        self.mCurrentState = nil
    end
    self.mEventList = {}
    if self.mStateDict[nextState] then      -- 攻击状态下的规则
        self.duration = -1
        self.mCurrentState = self.mStateDict[nextState]
        self.mCurrentState:enter(useSkillArgs or {})
        self.mEntity:addOutput(BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM ,{self.mCurrentState.mStateName, self.mCurrentState.aniSpeed, self.mCurrentState.skillCd})
    else
        self.stateName = BattleConst.DEFAULT_BH_STATE[nextState]
        self.mEntity:addOutput(BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM ,{self.stateName or behaviorAnim})
        if duration > 0 then
            self.duration = self:timeToFrame(duration)
            self.nowFrame = 0

        else
            self.duration = nil
            self.nowFrame = nil
        end
    end
    self:handleEventList()
end

function Behavior:extendStateTime(state, duration)
    if self.duration > 0 and self.stateName == BattleConst.DEFAULT_BH_STATE[state]then
        self.duration = self.duration + self:timeToFrame(duration)
    end
end

function Behavior:timeToFrame(seconds)
    local frame = math.floor(seconds * 1000 /self:getVariable("frameLength"))
    return frame
end

--设置bh相关的属性
function Behavior:setVariable( varName,varValue)
    if self.mVariables[varName] == nil then
        self.mVariables[varName] = 0
    end
    self.mVariables[varName] = varValue
end

--获取bh的值
function Behavior:getVariable( varName )
    return self.mVariables[varName]
end

--------------behavior manager调用的接口---------------------
--状态机的tick
function Behavior:tick( )
    if self.inPause then
        return false
    end
    if self.mCurrentState then
        self.mCurrentState:tick()
    else
        if self.duration and self.duration > 0 then
            self.nowFrame = self.nowFrame + 1
            if self.nowFrame >= self.duration then
                table.insert(self.mEventList, {Type = BattleConst.BEHAVIOR_NOTICE_EVENT, Name = BattleConst.BEHAVIOR_END})
            end
        end
    end
end

function Behavior:pauseBH( )
    self.inPause = true
end

function Behavior:cancelPauseBH( )
    self.inPause = false
end

function Behavior:handleEventList()
    if #self.mEventList > 0 then
        local eventInfo = self.mEventList[1]
        table.remove(self.mEventList, 1)
        self:_handleEvent(eventInfo)
    end
    if #self.mEventList>0 then
        self:handleEventList()
    end
end

function Behavior:_handleEvent( eventInfo )
    local eventName = eventInfo["Name"]
    local eventType = eventInfo["Type"]
    if eventType == BattleConst.BEHAVIOR_NOTICE_EVENT then
        --通知上层结算
        local eventPackage = {eventName, eventInfo["StringParameter"],eventInfo["FloatParameter"],eventInfo["IntParameter"]}
        if self.mEventHandler[eventName] then
            -- 绑定的方法主要在 CombatUnit:initSkillEventHandler()
            for i,f in ipairs(self.mEventHandler[eventName]) do
                f(eventPackage)
            end
        else
            utils.logToLogger("Notice Gua to handle skill event:"..eventName)
        end
    end
end

return Behavior
