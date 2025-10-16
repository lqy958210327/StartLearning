--region *.lua
--Date
--修改日期：2016.12.27
--修改作者：zh
--修改日志：增加filter规则，默认filter为 DEFAULT_FILTER 及为空字符串    在注册时及事件触发时支持两层key：eventType及filter
--         修改单例模式为Lua传统的方式，减少调用时的消耗
--usage require "Core/System/EventCenter"

local DEFAULT_FILTER = ""

local _EventCenter = {}

_EventCenter.eventDict = {}

-- 析构函数。
function _EventCenter.destroy()
    _EventCenter.eventDict = nil
end

function _EventCenter.clearAllEvent()
    _EventCenter.eventDict = {}
    print("[LOG] clear all events")
end

function _EventCenter.clearOneEvent(inEventType)
    if nil == _EventCenter.eventDict[inEventType] then
        print("[WARNING] no event type = "..inEventType.." in event center")
    else
        _EventCenter.eventDict[inEventType] = nil
    end
    print("[LOG] clear event: "..inEventType)
end

function _EventCenter.addEventListener(eventType, func, filter)--addEventListener
    filter = filter or DEFAULT_FILTER
    if nil == _EventCenter.eventDict[eventType] then
        _EventCenter.eventDict[eventType] = {}
    end
    if nil == _EventCenter.eventDict[eventType][filter] then
        _EventCenter.eventDict[eventType][filter] = {}
    end
    --这里的func做key，暂时没发现性能和重复问题。
    --用list存在反查问题，所以用了双层字典。
    if _EventCenter.eventDict[eventType][filter][func] == nil then
       _EventCenter.eventDict[eventType][filter][func] = func
    else
       print("[WARNING] alreay has int event type = ", eventType, filter, tostring(func))
    end
end

function _EventCenter.removeEventListener(eventType, func, filter)
    filter = filter or DEFAULT_FILTER
    if _EventCenter.eventDict[eventType] then
        if _EventCenter.eventDict[eventType][filter] and func then
            _EventCenter.eventDict[eventType][filter][func] = nil
        end
    end
end

local function trycall(events, args)
    for k, v in pairs(events) do
        if (nil ~= v) then
            ClientUtils.trycall(v, table.unpack(args))
        end
    end
end

-- args必须为table或nil
function _EventCenter.sendEvent(eventType, args, filter)
    filter = filter or DEFAULT_FILTER
    assert(args == nil or type(args) == "table")
    args = args or {}
    if nil == _EventCenter.eventDict[eventType] then
        --print("[WARNING] no event type = ", eventType, " in event center")
    else
        local events = _EventCenter.eventDict[eventType]
        local default_events = events[DEFAULT_FILTER]
        if DEFAULT_FILTER == filter then
            -- DEFAULT_FILTER = ""
            -- filter (nil)
            -- 一般用于mgr
            -- function(...)
            if default_events then
                trycall(default_events, args)
            end
        else
            local id_events = events[filter]
            -- ID_FILTER = 0
            -- filter (number) [["%d+"]]
            -- 一般用于unit
            -- function(...)
            if id_events then
                trycall(id_events, args)
            end
            -- ID_PATTERN_FILTER = "i0"
            -- filter (number) [["%d+", "%0"]]
            -- 一般用于unitmgr
            -- function(filter , ...)
            if default_events then
                -- 插入参数，创建新表避免报错后重复调用参数数据乱掉
                local default_args = {filter, table.unpack(args)}
                trycall(default_events, default_args)
            end
        end
    end
end

-- 这个接口大家不要调用，准备废弃，备注时间2025.1.13
function _EventCenter.addEventListenerGroup(instance, funcConfig, filter)
    for funcName, eventType in pairs(funcConfig) do
        if instance[funcName] then
            instance['listenerFunc'..funcName] = Slot(instance[funcName], instance)
            _EventCenter.addEventListener(eventType, instance['listenerFunc'..funcName], filter)
        end
    end
end

-- 这个接口大家不要调用，准备废弃，备注时间2025.1.13
function _EventCenter.removeEventListenerGroup(instance, funcConfig, filter)
    for funcName, eventType in pairs(funcConfig) do
        if instance['listenerFunc'..funcName] then
            _EventCenter.removeEventListener(eventType, instance['listenerFunc'..funcName], filter)
            instance['listenerFunc'..funcName] = nil
        end
    end
end

--打印数据--


function _EventCenter.dumpEvent(obj)
  for key,value in pairs(_EventCenter.eventDict[obj]) do
        print("[LOG] key: " .. tostring(key) .. ", value: " .. tostring(value))
  end
end

function _EventCenter.dumpAll()
    print("[LOG] dump all begin")
    for k,v in pairs(_EventCenter.eventDict) do
        print("event: "..k)
        _EventCenter.dumpEvent(k)
    end
    print("[LOG] dump all end")
end
--endregion

return _EventCenter