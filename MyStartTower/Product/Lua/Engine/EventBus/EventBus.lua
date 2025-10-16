

-- 因为lua语言的特殊性，订阅事件写法做了调整，改为缓存委托(function)的方式
-- 一是因为在Lua里设计Interface后，阅读性不好，EmmyLua插件也不支持Interface注释
-- 二是因为监听对象收到Message后，无法很方便的通过Message类型调用不同的回调


---@class EventBus
EventBus = Class("EventBus")

function EventBus:ctor()
    ---@type EventBus
    self._instance = nil
    ---@type table<number, SubBus>
    self._busDict = {}
end

function EventBus:Get()
    if self._instance == nil then
        self._instance = EventBus()
    end
    return self._instance
end

function EventBus:InternalInit()

end

function EventBus:InternalClear()

end

function EventBus:InternalGenerateSubBus(busKey)
    if self._busDict[busKey] then

    else
        local bus = SubBus()
        bus:InternalInit()
        self._busDict[busKey] = bus
    end
end

function EventBus:InternalGetSubBus(busKey)
    return self._busDict[busKey]
end

function EventBus:InternalRemoveSubBus(busKey)
    if self._busDict[busKey] then
        self._busDict[busKey]:InternalClear()
        self._busDict[busKey] = nil
    end
end