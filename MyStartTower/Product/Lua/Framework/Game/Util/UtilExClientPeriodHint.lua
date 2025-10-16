-- 客户端周期性提示接口
-- 1.每日首次提示(每日提示1次)
-- 2.每日提醒
-- 3.关闭当日提醒
--
-- 使用示例:
-- 1.每日登录弹出一个界面，关闭后当日不再弹出。(当日换手机登录也会弹出)
--    local isShow = Util.ClientPeriodHint.EverydayFirstHint(ClientPeriodHintDefine.ID.LeagueBossReport)
--    if isShow then
--        -- 弹出界面
--    end
--
-- 2.收到组队邀请弹出一个界面，选择今日不再提示后，当日收到邀请不在弹出界面。
--    local isShow = Util.ClientPeriodHint.TodayHint(ClientPeriodHintDefine.ID.LeagueBossReport)
--    if isShow then
--        -- 弹出界面
--        ...
--        -- 选择今日不在弹出界面
--        Util.ClientPeriodHint.TodayHintDisable(ClientPeriodHintDefine.ID.LeagueBossReport)
--    end
-- -----------------------------------------------------------------------------------------

---@class ClientPeriodHintDefine
ClientPeriodHintDefine = {}
-- 提示类型
local _id = {
    LeagueBossReport = "LeagueBossReport",
    FirstRecharge="FirstRecharge",
    MonthlyCard="MonthlyCard",
}
ClientPeriodHintDefine.ID = _id


local __generateKey = function(id)
    local playerId = Util.Account.PlayerUid()
    local str = "PeriodHint"
    local key = playerId..str..id
    return key
end

local __checkPeriodHint = function(key, curTime, deltaSecond)
    local saveTime = LuaCallCs.PlayerPrefs.GetInt(key, 0)
    if saveTime == 0 or curTime - saveTime >= deltaSecond then
        return true
    end
    return false
end

-- 客户端周期性提示

local tab = {}

---@param id string 提示id,ClientPeriodHintDefine.ID
---@return boolean 是否提示
function tab.EverydayFirstHint(id)-- 每日首次提示(每日只提示1次)
    local key = __generateKey(id)
    local curTime = Util.TimeFormat.GetServerTimeStamp()
    local temp = __checkPeriodHint(key, curTime,86400) --24*60*60
    if temp then --如果是第一次提示或者距离上次提示超过24小时
        LuaCallCs.PlayerPrefs.SetInt(key, curTime)
        return true
    end
    local saveTime = LuaCallCs.PlayerPrefs.GetInt(key, 0)
    local isToday = Util.TimeFormat.TimeIsToday(saveTime)
    if not isToday then
        LuaCallCs.PlayerPrefs.SetInt(key, curTime)
        return true
    end
    return temp
end

---@param id string 提示id,ClientPeriodHintDefine.ID
---@return boolean 是否提示
function tab.TodayHint(id)-- 今日提示
    local key = __generateKey(id)
    local curTime = Util.TimeFormat.GetServerTimeStamp()
    local temp = __checkPeriodHint(key, curTime,86400) --24*60*60
    if temp then --如果是第一次提示或者距离上次提示超过24小时
        return true
    end
    temp = Util.TimeFormat.TimeIsToday(curTime)
    return temp
end

---@param id string 提示id,ClientPeriodHintDefine.ID
function tab.TodayHintDisable(id)-- 今日提示禁用(也就是今日不在提示了)
    local key = __generateKey(id)
    local curTime = Util.TimeFormat.GetServerTimeStamp()
    LuaCallCs.PlayerPrefs.SetInt(key, curTime)
end

Util.ClientPeriodHint = tab
