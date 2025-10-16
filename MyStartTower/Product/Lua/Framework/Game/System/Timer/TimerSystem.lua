


-- 不打算设计时钟系统，做一个简单的计时器够用就行了

---@class TimerSystem : SystemBase
TimerSystem = Class("TimerSystem", SystemBase)

function TimerSystem:OnInit()
    ---@type table<number, TimerData>
    self._timerList = {}

    ---@type TimerData[]
    self._waitingAdd = {}

    ---@type TimerData[]
    self._waitingRemove = {}

    self._evtAddTimer = function(interval, count, callback, del) self:_addTimer(interval, count, callback, del) end
    self._evtBreakTimer = function(id) self:_breakTimer(id) end
    EventManager.Global.RegisterEvent(EventType.TimerMgrAddTimer, self._evtAddTimer)
    EventManager.Global.RegisterEvent(EventType.TimerMgrBreakTimer, self._evtBreakTimer)

    GameUpdate:Get():AddUpdate(GameUpdateID.Timer , self._tick, self)
end

function TimerSystem:OnClear()
    GameUpdate:Get():RemoveUpdate(GameUpdateID.Timer)
    EventManager.Global.UnRegisterEvent(EventType.TimerMgrAddTimer, self._evtAddTimer)
    EventManager.Global.UnRegisterEvent(EventType.TimerMgrBreakTimer, self._evtBreakTimer)
end

function TimerSystem:OnGameStart()

end

function TimerSystem:OnGameEnd()

end

function TimerSystem:_tick(deltaTime)
    if #self._waitingAdd > 0 then
        for i = 1, #self._waitingAdd do
            local id = self._waitingAdd[i]:GetId()
            self._timerList[id] = self._waitingAdd[i]
        end
        self._waitingAdd = {}
    end

    for k,v in pairs(self._timerList) do
        if v:IsValid() then
            v:InternalTick(deltaTime)
        end

        if not v:IsValid() then
            table.insert(self._waitingRemove, v)
        end
    end

    if #self._waitingRemove > 0 then
        for i = 1, #self._waitingRemove do
            local id = self._waitingRemove[i]:GetId()
            self._timerList[id]:InternalClear()
            self._timerList[id] = nil
        end
        self._waitingRemove = {}
    end

end


function TimerSystem:_addTimer(interval, count, callback, del)
    local data = TimerData()
    data:InternalInit()
    data:InternalStart(interval, count, callback)
    table.insert(self._waitingAdd, data)
    if del then
        del(data:GetId())--返回计时器ID
    end
end

function TimerSystem:_breakTimer(id)
    assert(type(id) == "number", "---   TimerSystem:_breakTimer id is not number")
    for i = 1, #self._waitingAdd do
        local tempId = self._waitingAdd[i]:GetId()
        if tempId == id then
            table.remove(self._waitingAdd, i)
            break
        end
    end
    if self._timerList[id] then
        self._timerList[id]:InternalStop()
    end
end



