


---@class LeagueBossTaskFinishDetail
local __leagueBossTaskFinishDetail = Class("LeagueBossTaskFinishDetail")
function __leagueBossTaskFinishDetail:Init(playerHeadID, playerFrameID, playerName, taskName)
    self.PlayerHeadID = playerHeadID
    self.PlayerFrameID = playerFrameID
    self.PlayerName = playerName
    self.TaskName = taskName
end

---@class LeagueBossTaskData
local __leagueBossTaskData = Class("LeagueBossTaskData")
function __leagueBossTaskData:Init(taskName, isFinish, finishCount, finishMax, rewardCount, selfCount, selfCountMax, jumpId, details)
    self.TaskName = taskName
    self.IsFinish = isFinish
    self.FinishCount = finishCount
    self.FinishMax = finishMax
    self.IsFinish = finishCount >= finishMax
    self.RewardCount = rewardCount
    self.SelfCount = selfCount
    self.SelfCountMax = selfCountMax
    self.JumpId = jumpId
    ---@type LeagueBossTaskFinishDetail[]
    self.Details = details
end

local tab = {}



function tab.GetTaskFinishCount() -- 工会boss-任务完成总次数
    local myMember = LeagueHelper.GetMySelf()
    if myMember then
        return myMember.bossTaskFinishCount
    end
    return 0
end

function tab.GetTaskTotalScore() -- 工会boss-任务完成总积分
    local myMember = LeagueHelper.GetMySelf()
    if myMember then
        return myMember.bossTaskTotalScore
    end
    return 0
end

---@return LeagueBossTaskData[]
function tab.GetTaskList() -- 工会boss-任务数据列表
    local result = {}
    local list = LeagueHelper.GetMissionConfigsByType(MissionType.Boss)
    --table.sort(list, LeagueHelper.ChallengeListCompare)
    for i = 1, #list do
        local missionTag = list[i]
        local taskTag = LeagueHelper.GetTaskTag(missionTag)
        local taskName = TaskHelper.GetTaskTitle(taskTag)
        local finishMax = LeagueHelper.GetMissionRewardCount(missionTag)
        local rewardCount = LeagueHelper.GetMissionRewardNum(missionTag)
        local selfCount = TaskHelper.GetTaskCompleteNum(taskTag)
        local selfCountMax = TaskHelper.GetTaskConditionNum(taskTag)
        local jumpId = TaskHelper.GetTaskJump(taskTag)
        local data = LeagueHelper.GetMissionByTag(missionTag)
        local isFinish = data and data.selfReward or false
        local finishCount = data and #data.members or 0
        local details = {}
        if data then
            for i = 1, #data.members do
                local uid = data.members[i]
                local member = LeagueHelper.GetMyLeagueMemberByUid(uid)
                if member then
                    local playerHeadId = member.head.head
                    local playerFrameId = member.head.frame
                    local playerName = member.head.name
                    local detail = __leagueBossTaskFinishDetail()
                    detail:Init(playerHeadId, playerFrameId, playerName, taskName)
                    table.insert(details, detail)
                end
            end
        end

        -- 测试数据
        --local detail = __leagueBossTaskFinishDetail()
        --detail:Init(Util.Account.PlayerHeadID(), Util.Account.PlayerFrameID(), Util.Account.PlayerName(), taskName)
        --table.insert(details, detail)

        local taskData = __leagueBossTaskData()
        taskData:Init(taskName, isFinish, finishCount, finishMax, rewardCount, selfCount, selfCountMax, jumpId, details)
        table.insert(result, taskData)
    end
    return result
end


Util.LeagueBossTask = tab
