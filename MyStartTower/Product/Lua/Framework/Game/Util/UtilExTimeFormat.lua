

local __formatDay = "%s天"
local __formatMinuteSecond = "%02d:%02d" -- 分:秒
local __formatHourMinuteSecond = "%02d:%02d:%02d" -- 时:分:秒
local __formatYearMonthDay = "%04d-%02d-%02d" -- 年-月-日
local _daySeconds=86400--24*60*60
-- 时间格式转换

local tab = {}

---@return number 服务器时间戳
function tab.GetServerTimeStamp()
    return TimeUtils.getServerTime()
end

---@type fun(dateTime:string) : number
---@param dateTime string 时间字符串 格式 "2025-6-1 00:00:00"
function tab.DateTimeToStamp(dateTime)
    return ClientUtils.getServerTimeByTimeStr(dateTime)
end


function tab.SecondToString(timeSecond, ignoreHour) -- 时间戳转字符串
    if timeSecond < 0  then
        timeSecond = 0
    end
    local hour = math.floor(timeSecond / 3600)
    local minute = math.floor(math.fmod(timeSecond,3600) / 60)
    local second = math.fmod(timeSecond, 60)
    local timeString = ""
    if hour > 24 then
        timeString = string.format(__formatDay, math.floor(hour/24))
    else
        if ignoreHour then
            timeString = string.format(__formatMinuteSecond, minute, second)
        else
            timeString = string.format(__formatHourMinuteSecond,hour, minute, second)
        end
    end
    return timeString
end

function tab.TimeToStringYearMonthDay(time) -- 时间戳转化成年-月-日
    local dateTable = ClientUtils.getServerTimeData(time)
    return string.format(__formatYearMonthDay, dateTable.year, dateTable.month, dateTable.day)
end

---@return boolean 时间戳是否是今天
function tab.TimeIsToday(time)
    return ClientUtils.isTickToday(time)
end
---@return number  time当日零点时间戳
---@param  time number 时间戳
function tab.GetTodayZeroTime(time)
    local dateTable = os.date("*t", time)
    dateTable.hour = 0
    dateTable.min = 0
    dateTable.sec = 0
    dateTable.day = dateTable.day + 1
    return os.time(dateTable)
end
--- 一天的秒数
function tab.DaySeconds()
    return _daySeconds
end

function tab.DaySeconds()
    return _daySeconds
end
---@param  time number 时间戳
---@return number  周几
function tab.GetWeekNum(time)
    local dateTable = ClientUtils.getServerTimeData(time)
    local weekNum = dateTable.wday - 1
    if weekNum == 0 then
        weekNum = 7
    end
    return weekNum
end
function tab.GetMonthDay(time) --获取现在年份月份
    local dateTable = ClientUtils.getServerTimeData(time)
    return dateTable.year,dateTable.month
end
---@param time number 时间戳
---@return number 时间戳月末时间
function tab.GetMonthLastTime(time)
    local dateTable = os.date("*t", time)
    dateTable.hour = 0
    dateTable.min = 0
    dateTable.sec = 0
    dateTable.day = 1
    dateTable.month = dateTable.month + 1
    local monthLastTime = os.time(dateTable) 
    return monthLastTime
end
---@param month number 月份
---@return number 月份获取月末时间
function tab.GetMonthLastTimeByMonth(month)
    local dateTable = os.date("*t", tab.GetServerTimeStamp())
    dateTable.hour = 0
    dateTable.min = 0
    dateTable.sec = 0
    dateTable.day = 1
    dateTable.month = month+1
    local monthLastTime = os.time(dateTable) 
    return monthLastTime
end
Util.TimeFormat = tab
