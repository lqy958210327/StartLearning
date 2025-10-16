


---@type LeagueBossReportEntity
local __reportEntity = function()
    local leagueDB = LeagueHelper.GetLeagueDB()
    if leagueDB == nil then
        LuaCallCs.ThrowException("---   数据异常：没有工会数据，无法使用工会boss相关功能...")
    end
    local report = leagueDB:GetLeagueBossReport()
    if report == nil then
        print("---   工会boss日报暂未生成...")
    end
    return report
end

local tab = {}

function tab.AutoOpenReport() -- 自动打开工会boss-日报
    local report = __reportEntity()
    if report then
        if Util.ClientPeriodHint.EverydayFirstHint(ClientPeriodHintDefine.ID.LeagueBossReport) then
            UIManager.InterfaceOpenUI(UIName.UILeagueBossReport)
        end
    end
end

function tab.OpenReport() -- 打开工会boss-日报
    local report = __reportEntity()
    if report then
        UIManager.InterfaceOpenUI(UIName.UILeagueBossReport)
    else
        Util.Notice.Show("工会boss日报暂未生成...")
    end
end

---@return LeagueBossReportEntity
function tab.GetReport() -- 日报数据
    local report = __reportEntity()
    return report
end

Util.LeagueBossReport = tab
