


---@class EventManager
EventManager = {}

EventManager.Init = function()
    EventHelper.Init()
    EventHelper.GenerateBus(SubBusKey.Battle)
end

EventManager.Clear = function()
    EventHelper.Clear()
end


local _global = {}
function _global.RegisterEvent(eventType, evt)
    EventHelper.Default.RegisterEvent(eventType, evt)
end
function _global.UnRegisterEvent(eventType, evt)
    EventHelper.Default.UnRegisterEvent(eventType, evt)
end
function _global.SubscribeEvent(eventType, objFlag, evt)
    EventHelper.Default.SubscribeEvent(eventType, objFlag, evt)
end
function _global.UnSubscribeEvent(eventType, objFlag, evt)
    EventHelper.Default.UnSubscribeEvent(eventType, objFlag, evt)
end
function _global.Dispatch(eventType, ...)
    EventHelper.Default.Dispatch(eventType, ...)
end
function _global.SendMessage(eventType, objFlag, ...)
    EventHelper.Default.SendMessage(eventType, objFlag, ...)
end
function _global.ClearEvent(eventType)
    EventHelper.Default.ClearEvent(eventType)
end
EventManager.Global = _global

local _battle = {}
function _battle.RegisterEvent(eventType, evt)
    EventHelper.RegisterEvent(SubBusKey.Battle, eventType, evt)
end
function _battle.UnRegisterEvent(eventType, evt)
    EventHelper.UnRegisterEvent(SubBusKey.Battle, eventType, evt)
end
function _battle.SubscribeEvent(eventType, objFlag, evt)
    EventHelper.SubscribeEvent(SubBusKey.Battle, eventType, objFlag, evt)
end
function _battle.UnSubscribeEvent(eventType, objFlag, evt)
    EventHelper.UnSubscribeEvent(SubBusKey.Battle, eventType, objFlag, evt)
end
function _battle.Dispatch(eventType, ...)
    EventHelper.Dispatch(SubBusKey.Battle, eventType, ...)
end
function _battle.SendMessage(eventType, objFlag, ...)
    EventHelper.SendMessage(SubBusKey.Battle, eventType, objFlag, ...)
end
function _battle.ClearEvent(eventType)
    EventHelper.ClearEvent(SubBusKey.Battle, eventType)
end
EventManager.Battle = _battle