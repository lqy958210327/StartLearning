

--local __idx = 0
--local __generateGid = function()
--    --简单加个计数，有余力的时候做一个GID生成器
--    __idx = __idx + 1
--    return __idx
--end

-- 对于注册事件，同一个事件类型可以注册多个委托，因为不同的委托可能来自不同的对象
-- 对于订阅事件，一个对象内，同一个事件类型只记录一个委托，没有必要记录多个委托

---@class SubBus 不可继承
SubBus = Class("SubBus")

function SubBus:InternalInit()
    ---@type table<string, table<function, boolean>>
    self._eventDict = {}
    ---@type table<string, table<table, function>>
    self._subscribeDict = {}
end

function SubBus:InternalClear()
    self._eventDict = {}
    self._subscribeDict = {}
end

function SubBus:InternalRegisterEvent(eventType, evt)
    if self._eventDict[eventType] == nil then
        self._eventDict[eventType] = {}
    end
    if self._eventDict[eventType][evt] then
        assert(false, "---   重复注册事件，有内存泄露风险   eventType = "..eventType)
    else
        self._eventDict[eventType][evt] = true
    end
end

function SubBus:InternalUnRegisterEvent(eventType, evt)
    if self._eventDict[eventType] and self._eventDict[eventType][evt] then
        self._eventDict[eventType][evt] = nil
    end
end

function SubBus:InternalSubscribeEvent(eventType, objFlag, evt)
    if self._subscribeDict[eventType] == nil then
        self._subscribeDict[eventType] = {}
    end
    if self._subscribeDict[eventType][objFlag] then
        assert(false, "---   重复订阅事件，有内存泄露风险   eventType = "..eventType)
    else
        self._subscribeDict[eventType][objFlag] = evt
    end
end

function SubBus:InternalUnSubscribeEvent(eventType, objFlag)
    if self._subscribeDict[eventType] and self._subscribeDict[eventType][objFlag] then
        self._subscribeDict[eventType][objFlag] = nil
    end
end

function SubBus:InternalDispatch(eventType, ...)
    if self._eventDict[eventType] then
        local dict = self._eventDict[eventType]
        for k, v in pairs(dict) do
            k(...)
        end
    end
    if self._subscribeDict[eventType] then
        local dict = self._subscribeDict[eventType]
        for k, v in pairs(dict) do
            v(...)
        end
    end
end

function SubBus:InternalSendMessage(eventType, objFlag, ...)
    if self._subscribeDict[eventType] and self._subscribeDict[eventType][objFlag] then
        self._subscribeDict[eventType][objFlag](...)
    end
end

function SubBus:InternalClearEvent(eventType)
    self._eventDict[eventType] = nil
    self._subscribeDict[eventType] = nil
end