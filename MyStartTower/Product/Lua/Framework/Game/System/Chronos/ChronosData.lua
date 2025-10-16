
---@class ChronosData
ChronosData = Class("ChronosData")

---@type fun()获取日时间
function ChronosData:GetDayTime() return self.dayTime end
function ChronosData:GetWeekTime() return self.weekTime end 
function ChronosData:GetMoonTime() return self.moonTime end
function ChronosData:GetYearTime() return self.yearTime end

function ChronosData:InternalInit()
    ---@type number 当日结束时间戳
    self.dayTime = 0
    ---@type number 当周结束时间戳
    self.weekTime = 0
    ---@type number 当月结束时间戳
    self.moonTime = 0
    ---@type number 当年结束时间戳
    self.yearTime = 0
end

function ChronosData:RefreshTime(_chronosTime)
    self:RefreshDayTime(_chronosTime)
    self:RefreshWeekTime(_chronosTime)
    self:RefreshMoonTime(_chronosTime)
    -- self:RefreshYearTime(_chronosTime)
end

---@type fun() 更新当日结束时间（第二天0点）
function ChronosData:RefreshDayTime(_chronosTime)
    local dateTable = os.date("*t", _chronosTime)
    dateTable.hour = 0
    dateTable.min = 0
    dateTable.sec = 0
    dateTable.day = dateTable.day + 1
    self.dayTime = os.time(dateTable)

    self.dayTime = self.dayTime - TimeUtils.getServerTime();
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.ChronosDayTime, self.dayTime)
end

---@type fun() 更新当周结束时间（周日23:59:59）
function ChronosData:RefreshWeekTime(_chronosTime)
    local dateTable = os.date("*t", _chronosTime)
    
    -- Lua中星期日是1，星期一是2，...，星期六是7
    ---@type fun() 更新距离周日的天数偏移（如果今天是周日，则偏移0天；周一则偏移6天...）
    local offset = (8 - dateTable.wday) % 7
    
    -- 设置到本周日23:59:59
    dateTable.hour = 23
    dateTable.min = 59
    dateTable.sec = 59
    dateTable.day = dateTable.day + offset
    self.weekTime = os.time(dateTable)

    self.weekTime = self.weekTime - TimeUtils.getServerTime();
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.ChronosWeekTime, self.weekTime)
end

---@type fun() 更新当月结束时间（下个月1号0点）
function ChronosData:RefreshMoonTime(_chronosTime)
    local dateTable = os.date("*t", _chronosTime)
    dateTable.hour = 0
    dateTable.min = 0
    dateTable.sec = 0
    dateTable.day = 1
    dateTable.month = dateTable.month + 1
    self.moonTime = os.time(dateTable)

    self.moonTime = self.moonTime - TimeUtils.getServerTime();
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.ChronosMoonTime, self.moonTime)
end

---@type fun() 更新当年结束时间（下一年1月1号0点）
function ChronosData:RefreshYearTime(_chronosTime)
    local dateTable = os.date("*t", _chronosTime)
    dateTable.hour = 0
    dateTable.min = 0
    dateTable.sec = 0
    dateTable.day = 1
    dateTable.month = 1
    dateTable.year = dateTable.year + 1
    self.yearTime = os.time(dateTable)

    self.yearTime = self.yearTime - TimeUtils.getServerTime();
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.ChronosYearTime, self.yearTime)
end
