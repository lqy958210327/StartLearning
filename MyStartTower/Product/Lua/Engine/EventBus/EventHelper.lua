

local __defaultSubBusKey = 0


local _busKeyValid = function(busKey) assert(type(busKey) == "number", "---   busKey必须是Number类型,且BusKey不可以为0") end
local _eventTypeValid = function(eventType) assert(type(eventType) == "number" or type(eventType) == "string", "---   eventType必须是 number 类型或 string 类型") end
local _eventValid = function(evt) assert(evt, "---   event = nil") end
local _objFlagValid = function(objFlag) assert(objFlag, "---   objFlag = nil") end

local _checkBusKeyEventType = function(busKey, eventType)
    _busKeyValid(busKey)
    _eventTypeValid(eventType)
end
local _checkBusKeyEventTypeObjFlag = function(busKey, eventType, objFlag)
    _busKeyValid(busKey)
    _eventTypeValid(eventType)
    _objFlagValid(objFlag)
end


---@class EventHelper
EventHelper = {}

EventHelper.Init = function()
    print("---   EventBus init!")
    EventBus:Get():InternalInit()
    EventBus:Get():InternalGenerateSubBus(__defaultSubBusKey)
end

EventHelper.Clear = function()
    print("---   EventBus Clear!")
    EventBus:Get():InternalClear()
end

EventHelper.GenerateBus = function(busKey)
    _busKeyValid(busKey)
    assert(busKey ~= __defaultSubBusKey, "---   BusKey不可以为0, busKey = "..busKey)
    EventBus:Get():InternalGenerateSubBus(busKey)
end

EventHelper.RemoveSubBus = function(busKey)
    _busKeyValid(busKey)
    EventBus:Get():InternalRemoveSubBus(busKey)
end

EventHelper.RegisterEvent = function(busKey, eventType, evt)
    _checkBusKeyEventType(busKey, eventType)
    _eventValid(evt)
    local bus = EventBus:Get():InternalGetSubBus(busKey)
    if bus then
        bus:InternalRegisterEvent(eventType, evt)
    end
end

EventHelper.UnRegisterEvent = function(busKey, eventType, evt)
    _checkBusKeyEventType(busKey, eventType)
    _eventValid(evt)
    local bus = EventBus:Get():InternalGetSubBus(busKey)
    if bus then
        bus:InternalUnRegisterEvent(eventType, evt)
    end
end

EventHelper.SubscribeEvent = function(busKey, eventType, objFlag, evt)
    _checkBusKeyEventTypeObjFlag(busKey, eventType, objFlag)
    _eventValid(evt)
    local bus = EventBus:Get():InternalGetSubBus(busKey)
    if bus then
        bus:InternalSubscribeEvent(eventType, objFlag, evt)
    end
end

EventHelper.UnSubscribeEvent = function(busKey, eventType, objFlag, evt)
    _checkBusKeyEventTypeObjFlag(busKey, eventType, objFlag)
    _eventValid(evt)
    local bus = EventBus:Get():InternalGetSubBus(busKey)
    if bus then
        bus:InternalUnSubscribeEvent(eventType, objFlag, evt)
    end
end

EventHelper.Dispatch = function(busKey, eventType, ...)
    _checkBusKeyEventType(busKey, eventType)
    local bus = EventBus:Get():InternalGetSubBus(busKey)
    if bus then
        bus:InternalDispatch(eventType, ...)
    end
end

EventHelper.SendMessage = function(busKey, eventType, objFlag, ...)
    _checkBusKeyEventTypeObjFlag(busKey, eventType, objFlag)
    local bus = EventBus:Get():InternalGetSubBus(busKey)
    if bus then
        bus:InternalSendMessage(eventType, objFlag, ...)
    end
end

EventHelper.ClearEvent = function(busKey, eventType)
    _checkBusKeyEventType(busKey, eventType)
    local bus = EventBus:Get():InternalGetSubBus(busKey)
    if bus then
        bus:InternalClearEvent(eventType)
    end
end


local _defaultBus = {}
function _defaultBus.RegisterEvent(eventType, evt)
    EventHelper.RegisterEvent(__defaultSubBusKey, eventType, evt)
end
function _defaultBus.UnRegisterEvent(eventType, evt)
    EventHelper.UnRegisterEvent(__defaultSubBusKey, eventType, evt)
end
function _defaultBus.SubscribeEvent(eventType, objFlag, evt)
    EventHelper.SubscribeEvent(__defaultSubBusKey, eventType, objFlag, evt)
end
function _defaultBus.UnSubscribeEvent(eventType, objFlag, evt)
    EventHelper.UnSubscribeEvent(__defaultSubBusKey, eventType, objFlag, evt)
end
function _defaultBus.Dispatch(eventType, ...)
    EventHelper.Dispatch(__defaultSubBusKey, eventType, ...)
end
function _defaultBus.SendMessage(eventType, objFlag, ...)
    EventHelper.SendMessage(__defaultSubBusKey, eventType, objFlag, ...)
end
function _defaultBus.ClearEvent(eventType)
    EventHelper.ClearEvent(__defaultSubBusKey, eventType)
end
EventHelper.Default = _defaultBus

