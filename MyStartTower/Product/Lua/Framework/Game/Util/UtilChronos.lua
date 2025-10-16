
-- 简化接口:时钟系统

local tab = {}

---@type fun(number : number, fun : fun()) 开启时钟计时，增加一个计数
---@param timeType number 使用黑板Key，传一个计数类型 日，周，月     BbItemKey.ChronosMoonTime
---@return number, number timerID:注册和销毁的ID, timeValue:时间
function tab.Open(timeType, fun)
    local timerID = Blackboard.ListenBBItemNumber(BbKey.Global, timeType, fun)
    ---开启时钟
    EventManager.Global.Dispatch(EventType.ChronosOpen, timerID)
    ---开启时钟后，再获取数据
    local timeValue = Blackboard.ReadBBItemNumber(BbKey.Global, timeType)
    return timerID, timeValue
end

---@type fun()
---@param timerID number 时钟ID
---@return number 返回时钟时间
function tab.GetTimeValueByTimeID(timerID)
    ---开启时钟后，再获取数据
    local timeValue = Blackboard.ReadBBItemNumber(BbKey.Global, timerID)
    return timeValue
end

function tab.Close(itemKey, timerID)
    Blackboard.RemoveListenBBItemNumber(BbKey.Global, itemKey, 0)
    ---时钟内清除一个计数
    EventManager.Global.Dispatch(EventType.ChronosClose, timerID)
end

Util.ChronosUtils = tab
