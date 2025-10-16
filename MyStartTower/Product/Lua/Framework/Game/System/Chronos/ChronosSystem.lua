-- 时钟系统

---@class ChronosSystem : SystemBase
ChronosSystem = Class("ChronosSystem", SystemBase)

function ChronosSystem:OnInit()
    ---@type number 时钟时间 从服务器时间获取
    self._chronosTime = 0

    ---@type ChronosData 时钟数据
    self._chronosData = ChronosData()
    self._chronosData:InternalInit()

    ---@type table<number> 时钟ID数据 时钟内数据未空时，关闭时钟
    self._chornosIDList = {}

    self._evtOpenChronos = function(id) self:OpenChronos(id) end
    self._evtCloseChronos = function(id) self:CloseChronos(id) end
    
    EventManager.Global.RegisterEvent(EventType.ChronosOpen, self._evtOpenChronos)
    EventManager.Global.RegisterEvent(EventType.ChronosClose, self._evtCloseChronos)
end

function ChronosSystem:OnClear()
    EventManager.Global.UnRegisterEvent(EventType.ChronosOpen, self._evtOpenChronos)
    EventManager.Global.UnRegisterEvent(EventType.ChronosClose, self._evtCloseChronos)
end

---@type fun(ChronosID : number) 开启时钟
---@param ChronosID number 时钟计时ID
function ChronosSystem:OpenChronos(ChronosID)
    self._timer = Util.Timer.AddLoop(0.1, function() self:_refreshChronosTime() end)
    ---先获取一次时间戳
    self:_refreshChronosTime()
    ---计数增加
    table.insert(self._chornosIDList, ChronosID)
end

---@type fun(ChronosID : number) 关闭时钟
---@param ChronosID number 时钟计时ID  所有计时ID被清除后关闭时钟
function ChronosSystem:CloseChronos(ChronosID)
    for i, key in pairs(self._chornosIDList) do
        if key == ChronosID then
            ---计数减少
            table.remove(self._chornosIDList, i)
        end
    end
    if table.count(self._chornosIDList) <= 0 then
        Util.Timer.BreakTimer(self._timer)
    end
end

---@type fun() 刷新时钟时间，刷新距离日，周，月结束时间
function ChronosSystem:_refreshChronosTime()
    self._chronosTime = TimeUtils.getServerTime()

    self._chronosData:RefreshTime(self._chronosTime)
end

