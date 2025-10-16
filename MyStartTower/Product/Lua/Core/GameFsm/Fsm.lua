local strClassName = "Fsm"
local Fsm = Class(strClassName)
-- 成员变量。

function Fsm:ctor()
    self.mStates = {}
    self.mCurStateName = nil
    self.mEventTranslate = nil
end

--增加状态，state类存在mStates中，转移事件存在mEvents中
function Fsm:addState(newState)
    -- assert(newState.stateName)
    self.mStates[newState.stateName] = newState
end

function Fsm:translateState(tgtStateName, enterArgs)
    if self.mCurStateName then
        local curState = self.mStates[self.mCurStateName]
        if curState then
            curState:exit(tgtStateName)
        end
    end
    local preStateName = self.mCurStateName
    self.mCurStateName = tgtStateName
    if tgtStateName then
        local tgtState = self.mStates[tgtStateName]
        if tgtState then
            tgtState:enter(preStateName, enterArgs)
        end
    end
    if self.mEventTranslate ~= nil then
        self.mEventTranslate(preStateName, tgtStateName)
    end
end

function Fsm:getState(tgtStateName)
    if not tgtStateName then
        tgtStateName = self.mCurStateName
    end
    return self.mStates[tgtStateName]
end

function Fsm:isInState(tgtS)
    return self.mCurStateName == tgtS
end

function Fsm:getCurState()
    return self:getState()
end

return Fsm