


-- 活跃任务相关的计算方法

local tab = {}


function tab.AnalyseEverydayRewardTaskList()
    return DataTable.ResActiveTask[1]
end

function tab.AnalyseEverydayScoreTaskList()
    return DataTable.ResActiveTask[2]
end

function tab.AnalyseWeeklyRewardTaskList()
    return DataTable.ResActiveTask[3]
end

function tab.AnalyseWeeklyScoreTaskList()
    return DataTable.ResActiveTask[4]
end

Util.ActiveTask = tab
