local TimeUtils = {}
local TimeString = ConstTable.TimeString

local _serverTimeInterval = 0

local st = 0;
local serverT=0;
-- 同步服务器时间
function TimeUtils.onSetServerTime(serverTime, fromLogin)
    --log('onSetServerTime',os.date("%Y-%m-%d %H:%M:%S", serverTime))
    --_serverTimeInterval = serverTime - os.time()  老总改
    st = os.time();
    serverT = serverTime;

    -- 关闭过时替换逻辑 sw
    --[[if fromLogin then
        ClientUtils.initTimeReplace()
    end]]
end

function TimeUtils.getServerTime()
    --return os.time() + _serverTimeInterval  老总改
    return (os.time() - st) + serverT;
end

function TimeUtils.getRemainTime(time)
    return time - TimeUtils.getServerTime();
end

--6点
local NewDayHour = 6
--获取到第二天的剩余时间 返回秒数
function TimeUtils.getRemainTimeToNewDay(time)
    local serverTime = TimeUtils.getServerTime()
    local server_current_date = ClientUtils.getServerTimeData(serverTime)
    server_current_date.hour = time or NewDayHour
    server_current_date.min = 0
    server_current_date.sec = 0

    local server_target_time = ClientUtils.getServerTimeByTimeTable(server_current_date)
    local remainTime = server_target_time - serverTime
    -- 超过6点 则小于0 需要加24H 获得距离明天6点的时间
    if remainTime <= 0 then
        remainTime = remainTime + 24 * 60 * 60
    end

    return remainTime;
end

function TimeUtils.getWeekNum()
    local serverTime = TimeUtils.getServerTime()
    local nowDate = ClientUtils.getServerTimeData(serverTime)
    local weekNum = nowDate.wday - 1
    if weekNum == 0 then
        weekNum = 7
    end
    return weekNum
end

function TimeUtils.getMonthDay()
    local serverTime = TimeUtils.getServerTime()
    local year = os.date("%Y", serverTime)
    local month = os.date("%m",serverTime) + 1
    local dayAmount = os.date("%d", serverTime({year=year, month=month, day=0}))
    return dayAmount
end

function TimeUtils.getFutureTime(futureDays, _hour)
    local serverTime = TimeUtils.getServerTime()
    local dayTimestamp = 24*60*60
    local newTime = serverTime + dayTimestamp * futureDays
    local newDate = os.date("*t", newTime)
    return os.time({year = newDate.year, month = newDate.month, day = newDate.day, hour = _hour, minute = newDate.minute, second = newDate.second})
end

function TimeUtils.getLastTime(datetype)
    local serverTime = TimeUtils.getServerTime()
    local nowDate = ClientUtils.getServerTimeData(serverTime)
    local result = nil
    if datetype == "TODAY" then
        return TimeUtils.getRemainTimeToNewDay(24)
    elseif datetype == "WEEK" then
        local weekNum = 7 - TimeUtils.getWeekNum()
        local dayTimestamp = 24*60*60

        return TimeUtils.getRemainTimeToNewDay(24) + weekNum * dayTimestamp
        --result = TimeUtils.getFutureTime(weekNum, 24)
    elseif datetype == "MONTH" then
        local totalDay = TimeUtils.getMonthDay()
        local newDate = {year = nowDate.year, month = nowDate.month, day = totalDay, hour = 24, minute = 0, second = 0}
        result = os.time(newDate)
    end
    local remainTime = TimeUtils.getRemainTime(result)
    return remainTime
end

function TimeUtils.getDeadlineStr( Deadline, ignoreHour, ignoreYear)
    if ignoreHour then
        return os.date("%Y/%m/%d", Deadline )
    elseif ignoreYear then
        return os.date("%m/%d %H:%M:%S", Deadline )
    else
        return os.date("%Y/%m/%d %H:%M", Deadline )
    end
    return " "
end

function TimeUtils.calcTimeTxt( timeSecond , ignoreHour)
    if timeSecond < 0  then
        timeSecond = 0
    end
    local hour = math.floor(timeSecond / 3600)
    local minute = math.floor(math.fmod(timeSecond,3600) / 60)
    local second = math.fmod(timeSecond, 60)
    local timeString = ""
    if hour>24 then
        --timeString=string.format("%d天%d小时",math.floor(hour/24),math.fmod(hour,24))
        --timeString=string.format(TimeString.day..TimeString.hour,math.floor(hour/24),math.fmod(hour,24))
        timeString=string.format(TimeString.day,math.floor(hour/24))
    elseif ignoreHour then   --战斗不显示天
        timeString = string.format("%02d:%02d" , minute, second)
    else
        timeString = string.format("%02d:%02d:%02d",hour, minute, second)
    end
    return timeString
end



function TimeUtils.calcTimeTxt_1( timeSecond , ignoreHour)
    if timeSecond < 0  then
        timeSecond = 0
    end
    local hour = math.floor(timeSecond / 3600)
    local minute = math.floor(math.fmod(timeSecond,3600) / 60)
    local second = math.fmod(timeSecond, 60)
    local timeString = ""
    -- if hour>24 then
    --     --timeString=string.format("%d天%d小时",math.floor(hour/24),math.fmod(hour,24))
    --     --timeString=string.format(TimeString.day..TimeString.hour,math.floor(hour/24),math.fmod(hour,24))
    --     timeString=string.format(TimeString.day,math.floor(hour/24))
    if ignoreHour then   --战斗不显示天
        timeString = string.format("%02d:%02d" , minute, second)
    else
        timeString = string.format("%02d:%02d:%02d",hour, minute, second)
    end
    return timeString
end


function TimeUtils.calcShortTimeTxt( timeSecond , strFormat)      -- 短时间模式被用在按钮倒计时  显示天数时才需要附带后缀
    if timeSecond < 0  then
        timeSecond = 0
    end
    local hour = math.floor(timeSecond / 3600)
    local minute = math.floor(math.fmod(timeSecond,3600) / 60)
    local second = math.fmod(timeSecond, 60)
    local timeString = ""
    if hour>=24 then
        if strFormat then
            --timeString=string.format(strFormat, utils.format("%1d天", math.floor(hour/24)))
            timeString=string.format(strFormat, utils.format(TimeString.day, math.floor(hour/24)))
        else
            --timeString=string.format("%d天",math.floor(hour/24))
            timeString=string.format(TimeString.day,math.floor(hour/24))
        end
    else
        timeString = string.format("%02d:%02d:%02d",hour, minute, second)
    end
    return timeString
end

function TimeUtils.getRemainTimeTxt(time, ignoreHour)
    return TimeUtils.calcTimeTxt(TimeUtils.getRemainTime(time), ignoreHour)
end

function TimeUtils.getRemainTimeTxtShowTypeTwo(time,ignoreHour)
    local timeSecond = TimeUtils.getRemainTime(time)
    if timeSecond < 0  then
        timeSecond = 0
    end
    local hour = math.floor(timeSecond / 3600)
    local minute = math.floor(math.fmod(timeSecond,3600) / 60)
    local second = math.fmod(timeSecond, 60)
    local timeString = ""
    if ignoreHour then   --战斗不显示天
        timeString = string.format("%02d:%02d" , minute, second)
    else
        timeString = string.format("%02d:%02d:%02d",hour, minute, second)
    end
    return timeString
end

function TimeUtils.getRemainTimeTxtShowTypeThree(time)
    local timeSecond = TimeUtils.getRemainTime(time)
    if timeSecond < 0  then
        timeSecond = 0
    end
    local hour = math.floor(timeSecond / 3600)
    local minute = math.floor(math.fmod(timeSecond,3600) / 60)
    local second = math.fmod(timeSecond, 60)
    local timeString = ""
    if hour>=24 then
        timeString = string.format(TimeString.day.."%02d:%02d:%02d",math.floor(hour/24) ,hour%24, minute, second)
    elseif hour>=1 then
        timeString = string.format("%02d:%02d:%02d", hour,minute, second)
    else
        --timeString = string.format("%02d:%02d" , minute, second)
        timeString = string.format("%02d:%02d:%02d", hour,minute, second)
    end
    return timeString
end

-- sTime 格式 "2023-7-10 23:59:59"
function TimeUtils.getTimeStampWithTxt(sTime)
    --local _, _, y, m, d, _hour, _min, _sec = string.find(sTime, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
    --local timestamp = os.time({year=y, month = m, day = d, hour = _hour, min = _min, sec = _sec})
    --return timestamp
    return ClientUtils.getServerTimeByTimeStr(sTime)
end

function TimeUtils.getTimeStampWithTxt2(sTime)
    local _, _, y, m, d, _hour, _min, _sec = string.find(sTime, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
    return y..'.'..m..'.'..d
end

function TimeUtils.getTimeString(time,color)
    if time < 0 then
        return ""
    end
    local hours = math.floor(time / 3600)
    local minutes = math.floor((time % 3600) / 60)
    local seconds = math.floor(time % 60)
    if(hours < 10) then hours = "0"..hours end
    if(minutes < 10) then  minutes = "0"..minutes end
    if(seconds < 10) then seconds = "0"..seconds end
    local timeContent
    if color then
        timeContent = color..hours..":"..minutes..":"..seconds..'</color>'
    else
        timeContent = '<color=#ffffff>'..hours..":"..minutes..":"..seconds..'</color>'
    end
    return Util.TimeFormat.SecondToString(time)
end



function TimeUtils.getTimeStringTypeTwo(time)
    local hours = math.floor(time / 3600)
    local minutes = math.floor((time % 3600) / 60)
    local seconds = math.floor(time % 60)
    return hours,minutes,seconds
end


function TimeUtils.getIntegerTime(time)
    --返回多少天，或者多少小时 取最大其他舍去 如果需要其他需要自己拓展
    local hours,minutes,seconds =TimeUtils.getTimeStringTypeTwo(time)

    if hours>24 then
        return string.format(TimeString.day,math.floor(hours/24))
    elseif hours>0 then
        return string.format(TimeString.hour,hours)
    end

    return 0

end


function TimeUtils.GetTimeStr(interval)
    return Util.TimeFormat.SecondToString(interval)
end


return TimeUtils