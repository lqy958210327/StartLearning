

--注意这种写法有两个好处
--1.这种写法可以保证业务侧拿到数据后，可以正常访问变量名，像C#一样可以点出来
--2.这个类在外部无法创建实例，只能通过特定的接口创建实例，类似C#的私有类，但不完全一样

---@class BossTowerProgressReward
local BossTowerProgressReward = Class("BossTowerProgressReward")
function BossTowerProgressReward:Init(idx, progress, itemId, itemCount)
    ---@type number 序号
    self.Idx = idx
    ---@type string 进度(字符串类型，%格式，如：10%)
    self.ProgressStr = string.format("%d%%", progress * 0.01)
    ---@type number 进度(0-10000)
    self.Progress = progress
    self.ItemId = itemId
    self.ItemCount = itemCount
end

---@return BossTowerData
local __getDB = function(bossType)
    ---@type BossTowerDB
    local db = GameDB.GetDB(DBId.BossTower)
    return db:GetData(bossType)
end


-- 资源本玩法 小算法
local tab = {}

-- 根据bossType和layer解析阶段奖励配置数据
---@return BossTowerProgressReward[]
function tab.AnalyseProgressReward(bossType, layer)
    local result = {}
    local cfg = DataTable.ResBossTower[bossType][layer]
    if cfg then
        local num = cfg.wave_num
        local per = 10000 / num
        local itemIdList = cfg.wave_item_id
        local itemNumList = cfg.wave_item_num
        for i = 1, #itemIdList do
            local progress = per * i
            local data = BossTowerProgressReward()
            data:Init(i, progress, itemIdList[i], itemNumList[i])
            table.insert(result, data)
        end
    end
    return result
end

-- 当前层数
function tab.GetLayer(bossType)
    local data = __getDB(bossType)
    return data.CurLayer
end

-- 当前排名
function tab.GetRank(bossType)
    local data = __getDB(bossType)
    return data.Rank
end

-- 当前层伤害进度
function tab.GetProgress(bossType)
    local data = __getDB(bossType)
    return data.CurProgress
end

-- 扫荡层
function tab.GetSweepLayer(bossType)
    local data = __getDB(bossType)
    return data.SweepLayer
end

--奖励层数据
function tab.GetOriginalSweepLayer(bossType)
    local data = __getDB(bossType)
    return data.Original_sweepLayer
end

-- 扫荡奖励索引号
function tab.GetSweepRewardIdx(bossType)
    local data = __getDB(bossType)
    return data.SweepRewardIdx
end

-- 免费扫荡次数
function tab.GetFreeSweepCount(bossType)
    local data = __getDB(bossType)
    return data.FreeSweepCount
end

-- 当前达到最大层级 以及最大进度
function tab.IsAchieveMaxcurProgress(bossType)
    local db = GameDB.GetDB(DBId.BossTower)
    return db:IsAchieveMaxcurProgress(bossType)
end


-- 是否有扫荡奖励(扫荡奖励索引号大于0)
function tab.IsHaveSweepReward(bossType)
    local data = __getDB(bossType)
    return data.SweepRewardIdx > 0
end

-- 当前扫荡奖励
---@return SimpleRewardItem[]
function tab.GetSweepReward(bossType)
    local data = __getDB(bossType)

    local sweepLayer = data.SweepLayer
    local sweepRewardIdx =  data.SweepRewardIdx
    local  cfg = DataTable.ResBossTower[bossType][sweepLayer]
    local show_percentage =  sweepRewardIdx /cfg.wave_num * 100

    local rewardId = cfg.wave_award[sweepRewardIdx]
    return Util.RewardTable.AnalyseStaticRewardList(rewardId), sweepLayer, show_percentage

end

Util.BossTower = tab
