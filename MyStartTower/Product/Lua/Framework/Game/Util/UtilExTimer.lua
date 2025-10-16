


-- 简化接口:计时器

local tab = {}

--添加一个计时器
function tab.AddTimer(during, callback)
    local timerId = 0
    EventManager.Global.Dispatch(EventType.TimerMgrAddTimer, during, 1, callback, function(id) timerId = id end)
    return timerId
end

--添加一个循环计时器
function tab.AddLoop(interval, callback)
    local timerId = 0
    EventManager.Global.Dispatch(EventType.TimerMgrAddTimer, interval, 0, callback, function(id) timerId = id end)
    return timerId
end

--添加一个循环计时器，带次数限制
function tab.AddLimitLoop(interval, loop, callback)
    local timerId = 0
    EventManager.Global.Dispatch(EventType.TimerMgrAddTimer, interval, loop, callback, function(id) timerId = id end)
    return timerId
end

function tab.BreakTimer(id)
    EventManager.Global.Dispatch(EventType.TimerMgrBreakTimer, id)
end

Util.Timer = tab
