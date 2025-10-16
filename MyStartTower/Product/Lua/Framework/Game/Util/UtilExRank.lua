


---@class RankStageRewardData
local __rankStageRewardData = Class("RankStageRewardData")
function __rankStageRewardData:Init(cfgId, minRank, maxRank, minPer, maxPer, staticRewardId)
    self.CfgId = cfgId
    self.MinRank = minRank
    self.MaxRank = maxRank
    self.MinPer = minPer
    self.MaxPer = maxPer
    self.StaticRewardId = staticRewardId
end

local tab = {}

---@return RankStageRewardData[]
function tab.GetRewardStateList(rankType) -- 排行榜分段奖励列表
    ---@type RankStageRewardData[]
    local result = {}
    for k, v in pairs(DataTable.ResRankAwardData) do
        local id = v.id
        local type = v.rank_id
        local minRank = v.min_rank
        local maxRank = v.max_rank
        local minPer = v.min_percent
        local maxPer = v.max_percent
        local reward = v.award
        if type == rankType then
            local data = __rankStageRewardData()
            data:Init(id, minRank, maxRank, minPer, maxPer, reward)
            table.insert(result, data)
        end
    end
    table.sort(result, function(a, b) return a.CfgId < b.CfgId end)
    return result
end

function tab.ReqRank(rankType) -- 请求排行榜数据
    SendHandlers.ReqRankData(rankType)
end


Util.Rank = tab
