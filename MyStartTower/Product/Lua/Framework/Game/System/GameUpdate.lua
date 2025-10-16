

-- 这个也应该放进 SystemMgr，因为Update接口的调用方式不能随意继承，这里暂时放在外面

----------所有需要每帧执行的方法，在这里统一管理
--function GlobeFunction_GameUpdate()
--    GameUpdate:Get():Update()
--end

---@type GameUpdate
local __instance

---@class GameUpdate
GameUpdate = Class("GameUpdate")

function GameUpdate:Get()
    if __instance == nil then __instance = GameUpdate() end
    return __instance
end

function GameUpdate:ctor()
    self.eventMap = {}
end

function GameUpdate:AddUpdate(eventID, func, class)
    assert(type(eventID) == "number", "---   数据异常：GameUpdate.AddUpdate()   eventID 必须是 number")
    local count = #self.eventMap
    for i = 1, count do
        if self.eventMap[i].eventID == eventID then
            print("Error:GameUpdate repeat add, id:",eventID)
            return
        end
    end

    local data = {
        eventID = eventID,
        func = func,
        class = class,
    }
    table.insert(self.eventMap, data)

    self:EnableUpdate()
end

function GameUpdate:RemoveUpdate(eventID)
    assert(type(eventID) == "number", "---   数据异常：GameUpdate.RemoveUpdate()   eventID 必须是 number")
    local count = #self.eventMap
    for i = 1, count do
        if self.eventMap[i].eventID == eventID then
            table.remove(self.eventMap, i)
            break
        end
    end

    self:EnableUpdate()
end

function GameUpdate:EnableUpdate()
    -- 控制CS侧参数，CS侧会根据这个参数判断，是否每帧调用Lua的Tick方法
    -- 原有的 Looper 绑了太多功能，没法从根上改，这个功能就不启用了
    -- CS.GameProperties:Get().enableGameUpdate = #self.eventMap > 0
end

function GameUpdate:Update(deltaTime, unscaledDeltaTime)
    local count = #self.eventMap
    for i = 1, count do
        local mapdata = self.eventMap[i]
        if mapdata.class == nil then
            mapdata.func(deltaTime, unscaledDeltaTime)
        else
            mapdata.func(mapdata.class, deltaTime, unscaledDeltaTime)
        end
    end
end

function GameUpdate:ContainKey(eventID)
    assert(type(eventID) == "number", "---   数据异常：GameUpdate.ContainKey()   eventID 必须是 number")
    local count = #self.eventMap
    for i = 1, count do
        if self.eventMap[i].eventID == eventID then
            return true
        end
    end
    return false
end


