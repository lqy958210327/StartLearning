--local json = require("Core/cjson")
local ClientUtils = {}
local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local ResRoleAttrConfig = DataTable.ResRoleAttrConfig

local BugReport = require "Core/SDK/Plugin/BugReport"

local ResClientNotice = DataTable.ResClientNotice

local ResItem = DataTable.ResItem

local ResTimeValidConfig = DataTable.ResTimeValidConfig
local UserData = require("Core/Helper/UserData")


local TimeString = ConstTable.TimeString
local LanguageConst = require("Game/Logic/LanguageConst")

local SystemInfo = UnityEngine.SystemInfo

function ClientUtils.isHuawei( )
    local model = string.lower(SystemInfo.deviceModel)
    if string.find(model, "huawei") then
        return true
    else
        return false
    end
end



function ClientUtils.string2Table(stringData)
    local tableData = {}
    if type(stringData) ~= "string" then
        log("Json Parse Error, type mismatch", stringData)
    else
        local succ, t = pcall(json.decode, stringData)
        if succ and type(t) == "table" then
            tableData = t
        else
            log("Json Parse Error", tostring(t) .. "  Original Data:" .. stringData)
        end
    end
    return tableData
end

function ClientUtils.table2String(tableData)
    if type(tableData) ~= "table" then
        return nil
    end
    local stringData = "{}"
    local succ, t = pcall(json.encode, tableData)
    if succ then
        stringData = t
    else
        log("Json Encode Error: ", t)
    end
    return stringData
end




local SERVER_DIFF_TIME = 8 * 3600    --GMT与服务器所在时区差(单位秒)
local LOCAL_SERVER_DIFF_TIME = nil   --本地与服务器所在时区差(单位秒)
---@type fun(diffTime:number) 服务器同步时间偏移(单位为秒)
function ClientUtils.SetServerDiffTime(diffTime)
    if diffTime then
        SERVER_DIFF_TIME = diffTime
        LOCAL_SERVER_DIFF_TIME = nil
        ClientUtils.initServerTimeDiff()
    end
end

function ClientUtils.initServerTimeDiff()
    local localTime = os.time()
    local baseTimeData = os.date("!*t", localTime)
    local baseTime = os.time(baseTimeData)
    local localDiffTime = os.difftime(localTime, baseTime)
    LOCAL_SERVER_DIFF_TIME = localDiffTime - SERVER_DIFF_TIME
end

function ClientUtils.isTimeConfigPassed(timeValidId)
    return ClientUtils.getTimeConfigTimestamp( timeValidId ) <= TimeUtils.getServerTime()
end




function ClientUtils.getTimeConfigTimestamp( timeValidId )
    if timeValidId then
        local timeValidData = ResTimeValidConfig[timeValidId]
        if timeValidData then
            return ClientUtils.getServerTimeByTimeStr(timeValidData.valid_tick)
        else
            log("时间生效控制表ID不存在", timeValidId)
        end
    end
    return 0
end

function ClientUtils.getServerTimeByTimeStr(timeStr)
    if timeStr ==nil then
        return 0
    end
    local timeList = utils.splitString(timeStr, " ")
    if #timeList ~= 2 and #timeList ~= 3 then
        print("Time Str of getServerTimeByTimeStr is Error ", timeStr)
        return 0
    end
    local dayList = utils.splitString(timeList[1], ".")
    if #dayList ~= 3 then
        dayList = utils.splitString(timeList[1], "-")
    end
    if #dayList ~= 3 then
        dayList = utils.splitString(timeList[1], "/")
    end

    local hourList = utils.splitString(timeList[2], ":")
    if #dayList ~= 3 or #hourList ~= 3 then
        print("Time Str of getServerTimeByTimeStr Format is Error ", timeStr, dayList[1], dayList[2], #hourList)
        return 0
    end

    local timeDict = {}
    timeDict.year = math.min(tonumber(dayList[1]), 2037)
    timeDict.month = tonumber(dayList[2])
    timeDict.day = tonumber(dayList[3])
    timeDict.hour = tonumber(hourList[1])
    timeDict.min = tonumber(hourList[2])
    timeDict.sec = tonumber(hourList[3])
    return ClientUtils.getServerTimeByTimeTable(timeDict)
end

function ClientUtils.getServerTimeByTimeTable(timeTable)
    -- 所有日期都不应该有夏令时
    timeTable.isdst = false
    local clientTime = os.time(timeTable)
    return clientTime + (LOCAL_SERVER_DIFF_TIME or 0)
end

--将服务器时间戳转换成服务器所在时区的时间table
--无参数则返回当前服务器时间table
function ClientUtils.getServerTimeData(time, format)
    if LOCAL_SERVER_DIFF_TIME == nil then
        ClientUtils.initServerTimeDiff()
    end
    if time == nil then
        time = TimeUtils.getServerTime()
    end
    if format == nil then
        format = "*t"
    end

    local localTime = time - LOCAL_SERVER_DIFF_TIME
    -- 如果是夏令时制的时区，那么要减去1小时
    if localTime >= 0 and os.date("*t", localTime).isdst then
        localTime = localTime - 3600
    end
    -- 如果传入了0，可能由于时差产生负值，最小为0防止报错
    if localTime < 0 then
        localTime = 0
    end

    return os.date(format, localTime)
end

local TIME_CONST_DAY = 86400
-- 返回当前时区今日特定时间的时间戳
function ClientUtils.getTodayTimeStamp( hour, minute, second )
    local localZoneTime = hour*3600 + minute*60 + second
    local nowTime = TimeUtils.getServerTime( )
    local targetStamp = nowTime - (nowTime + SERVER_DIFF_TIME) % TIME_CONST_DAY + localZoneTime
    return targetStamp
end

--获得明天跨天时间点的时间戳
function ClientUtils.getServerTimeNextDay()
    local time = TimeUtils.getServerTime()
    local timeData = ClientUtils.getServerTimeData(time, "*t")
    local runTime = timeData.hour*3600+timeData.min*60+timeData.sec
    --print(timeData.hour,timeData.min,timeData.sec)
    time = time- runTime + Const.TIME_NEXT_DAY
    if runTime >= Const.TIME_NEXT_DAY then
        time = time + 3600*24
    end
    return time
end

-- check某个时间戳是不是当天
function ClientUtils.isTickToday(tick)
    local nextDayTick = ClientUtils.getServerTimeNextDay()
    local todayStartTick = nextDayTick - 3600*24
    local isToday = (tick >=todayStartTick and tick < nextDayTick)
    return isToday
end



---@param timeData table 服务器时间戳
function ClientUtils.timeStampToTimeFormat2(timeData) --获得%1s年%2s月%3s日 %4s:%5s
    if timeData == nil then
        return
    end
    local timeTable = os.date("*t", timeData)
    local timeStr =  utils.format(UIViewConst.timeStr, timeTable.year, timeTable.month, timeTable.day, timeTable.hour, timeTable.min)
    return timeStr
end

-- 获得今天跨天时间点的时间戳
function ClientUtils.getServerTimeTodayStart(serverTime)
    if not serverTime then
        serverTime = TimeUtils.getServerTime()
    end
    local timeData = ClientUtils.getServerTimeData(serverTime, "*t")
    local runTime = timeData.hour*3600+timeData.min*60+timeData.sec
    serverTime = serverTime- runTime + Const.TIME_NEXT_DAY
    if runTime < Const.TIME_NEXT_DAY then
        -- 当前时间在今天跨天之前，则返回前一天的跨天
        serverTime = serverTime - TIME_CONST_DAY
    end
    return serverTime
end



--获得下个指定周天跨天时间点的时间戳
--wday 星期1到星期7
function ClientUtils.getServerTimeNextWday(wday)
    wday = wday + 1
    if wday == 8 then wday = 1 end
    -- containToday = containToday or false
    local time = TimeUtils.getServerTime()
    local timeData = ClientUtils.getServerTimeData(time, "*t")
    local timeRun = timeData.hour*3600+timeData.min*60+timeData.sec
    local timeStart = time - timeRun
    if timeRun <= Const.TIME_NEXT_DAY then
        timeStart = timeStart - 24*3600
    end
    local startIdx = 1
    -- if containToday then
    --     startIdx = 0
    -- end
    for i = startIdx, 7 do
        local nowT = timeStart + i * 3600*24
        local nowData = ClientUtils.getServerTimeData(nowT, "*t")
        if nowData.wday == wday then
            return nowT + Const.TIME_NEXT_DAY
        end
    end
end



function ClientUtils.trycall(func, ...)

--    -- xpcall 异常时会截断流程(原因未知) 编辑器直接调用
--    if IS_EDITOR then
--        return func(...)
--    end

    local flag, msg = xpcall(func, debug.traceback, ...)
    if not flag then
        ClientUtils.trySendException("ClientUtils", msg)
    end
    return flag
end

-- type = "event"  "matrix"  "timer"
local ExceptionList = {}
function ClientUtils.trySendException( type, exceptionMsg )
    if not IS_PUBLISH_VERSION then
        LuaCallCs.LogError(exceptionMsg)
    end
    for inde, msg in pairs(ExceptionList) do
        if msg == exceptionMsg then
            return
        end
    end
    BugReport.reportException(type, type, exceptionMsg)
    table.insert(ExceptionList, exceptionMsg )
end

function ClientUtils.getRolePropZhName( attrName, attrValue, fromPlayer )
    local zhName = attrName
    local isSpAttr = false --高级属性
    if ResRoleAttrConfig[attrName] then
        local attrData = ResRoleAttrConfig[attrName]
        zhName = attrData.zhName
        attrValue = attrValue or 0
        if attrValue and attrData.isPercent then
            if fromPlayer then
                attrValue = string.format("%.1f%%",tonumber(string.format('%.2f', attrValue*100)))
            else
                attrValue = string.format("%.1f%%",tonumber(string.format('%.2f', attrValue/100)))
            end
        else
            attrValue = math.floor(attrValue)
        end
        isSpAttr = attrData.isSpecial
    end
    return zhName, attrValue, isSpAttr
end


--获得属性类型ID返回描述文本
function ClientUtils.getRolePropZhNameByType(attrTypeID, attrValue, fromPlayer)
    local attrName = BattleConst.PROP_TYPE_CONFIG[attrTypeID]
    return ClientUtils.getRolePropZhName(attrName, attrValue, fromPlayer)
end

function ClientUtils.getRolePropIcon(attrName)
    if ResRoleAttrConfig[attrName] and ResRoleAttrConfig[attrName].iconPath then
        return {ResRoleAttrConfig[attrName].iconPath, ResRoleAttrConfig[attrName].icon}--UIConst.COMMON_ICON_PATH..
    end
end

function ClientUtils.getRolePropIconByType(attrTypeID)
    local attrName = BattleConst.PROP_TYPE_CONFIG[attrTypeID]
    return ClientUtils.getRolePropIcon(attrName)
end




-- 得到上次下线时间
local ONE_MINUTE = 60
local ONE_HOUR = 60 * 60
local ONE_DAY = ONE_HOUR * 24
local TEN_DAY = ONE_DAY * 10
local ONE_MONTH = ONE_DAY * 30
local ONE_YEAR = ONE_MONTH * 12
function ClientUtils.timeFormat4Record(timeSecond)
    if timeSecond<0 then
        timeSecond=0
    end
    if timeSecond <= ONE_MINUTE then
        return string.format(TimeString.sec_ago, math.floor(timeSecond))
    elseif timeSecond <= ONE_HOUR then
        return string.format(TimeString.min_ago, math.floor(timeSecond/ONE_MINUTE))
    elseif timeSecond <= ONE_DAY then
        return string.format(TimeString.hour_ago, math.floor(timeSecond/ONE_HOUR))
    elseif timeSecond <= ONE_MONTH then
        return string.format(TimeString.day_ago, math.floor(timeSecond/ONE_DAY))
    elseif timeSecond <= ONE_YEAR then
        return string.format(TimeString.month_ago, math.floor(timeSecond/ONE_MONTH))
    else
        return string.format(TimeString.year_ago, math.floor(timeSecond/ONE_YEAR))
    end
end








--获取指定货币数量
function ClientUtils.getMoney(moneyID)

    if moneyID == Const.MONEY_ID_STAGE_ENERGY then
        return DataCore.player.stamina or 0
    end

    return  0
end

--获取货币的图标
function ClientUtils.getMoneyIcon(moneyID)
    if UIConst.MONEY_ID2INFO[moneyID] then
        return UIConst.MONEY_ID2INFO[moneyID]
    else
        local resData = ResItem[moneyID]
        if resData and resData.sourceIconPath and resData.sourceIcon then
            return {UIConst.ITEM_ICON_PATH..resData.sourceIconPath, resData.sourceIcon}
        else
            log("道具缺少资源栏图标", moneyID)
            if resData and resData.iconPath and resData.icon then
                return {UIConst.ITEM_ICON_PATH..resData.iconPath, resData.icon}
            end
        end
    end
end



--获取客户端提示语
function ClientUtils.getClientNotice( id )
    if id == nil then
        return ""
    end
    if not ResClientNotice[id] then
        log("客户端操作反馈表未填写，ID: "..id)
        return ""
    end
    return ResClientNotice[id].notice or ""
end






--输入字符范围
local MIN_NUM = 4
local MAX_NUM = 14
local CHN_COUNT = 2
local SP_KEY = {"(",")",".","%","+","-","*","?","[","^","$", "/", ";", "?", "@", "<", "=", ">", "\\", "]", "_", "`", "{", "}", "|", "~",
"!", "#", "&", ":"}
function ClientUtils.checkPlayerName(name)
    local num = utils.utf8len(name, CHN_COUNT)
    local failMsg = ""
    if num == 0 then
        failMsg = LanguageConst.ChangeName1
    elseif num < MIN_NUM then
        failMsg = LanguageConst.ChangeName1
    elseif num > MAX_NUM then
        failMsg = utils.format(LanguageConst.ChangeName2, MAX_NUM/CHN_COUNT,MAX_NUM)
    elseif string.find(name, " ") then
        failMsg = LanguageConst.ChangeName3
    elseif string.match(name, '%d+') == name then
        failMsg = LanguageConst.ChangeName4
    else
        for i, c in ipairs(SP_KEY) do
            if string.find(name, "%"..c) then
                failMsg = LanguageConst.ChangeName5
                break
            end
        end
    end
    return failMsg
end







function ClientUtils.isMobile(str)
    return string.match(str,"[1][3,4,5,6,7,8,9]%d%d%d%d%d%d%d%d%d") == str;
end

local PATTERN_CONFIG = {
    [1] = {pattern = "<quad.->?", rep = "*"},
    [2] = {pattern = "<%w.->(.-)</.->", rep = "*%1*"},
}
--检查文本是否包含屏蔽字
function ClientUtils.checkMarkIllegal( content, forbidList )
    if not content then
        return ""
    end
    --这里可能有点问题，会自动把这种格式的删除掉，处理完成后是合法的文本了
    for i, info in ipairs(PATTERN_CONFIG) do
        content = string.gsub(content, info.pattern, info.rep)
    end
    if forbidList then
        for _, keyWord in ipairs(forbidList) do
            local replaceStr = ""
            local markCount = utils.utf8len(keyWord, 1)
            for i=1,markCount do
                replaceStr = replaceStr.."*"
            end
            content = utils.replaceString(content, keyWord, replaceStr)
            -- content = string.gsub(content, keyWord, replaceStr)
        end
    end
    return content
end






function ClientUtils.urlEncode(s)
    s = string.gsub(s, "[\128-\191\194-\244]", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

function ClientUtils.composeGetParams(data)
    local encoded = {}
    for k, v in pairs(data) do
        table.insert(encoded, string.format("%s=%s", ClientUtils.urlEncode(k), ClientUtils.urlEncode(v)))
    end
    return table.concat(encoded,'&')
end

function ClientUtils.composeGetUrl(url, data, hasQuestionMark)
    local paramStr = ClientUtils.composeGetParams(data)
    local questionMark = hasQuestionMark and "&" or "?"
    if nil ~= paramStr and #paramStr > 0 then
        if "string" == type(url) then
            return url..questionMark..paramStr
        else
            url:SetUrlAppend(questionMark..paramStr)
            return url
        end
    else
        return url
    end
end





function ClientUtils.getMainStageLevelStr(season,chapter,level)
    return chapter.."-"..level
end









local isFirst
function ClientUtils.isFirstOpen()
    if isFirst ~= nil then
        return isFirst
    else
        local isFirstOpen = UserData.loadCommonData("IsFirstOpen")
        if isFirstOpen ~= "True" then
            isFirst = true
            UserData.saveCommonData("IsFirstOpen", "True")
        else
            isFirst = false
        end
        return isFirst
    end
end





return ClientUtils
