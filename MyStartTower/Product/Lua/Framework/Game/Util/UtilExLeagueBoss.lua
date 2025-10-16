
---@type LeagueBossEntity
local __leagueBossEntity = function()
    local leagueDB = LeagueHelper.GetLeagueDB()
    if leagueDB == nil then
        LuaCallCs.ThrowException("---   数据异常：没有工会数据，无法使用工会boss相关功能...")
    end
    local bossData = leagueDB:GetLeagueBoss()
    if bossData == nil then
        LuaCallCs.ThrowException("---   数据异常：没有工会Boss数据，无法使用工会boss相关功能...")
    end
    return bossData
end

local __cfgLayerData = function(indexId, layer)
    indexId = indexId and indexId or 0
    layer = layer and layer or 0
    if DataTable.ResGuildBossIndex[indexId] then
        local type = DataTable.ResGuildBossIndex[indexId].type
        if type and DataTable.ResGuildBossData[type] and DataTable.ResGuildBossData[type][layer] then
            return DataTable.ResGuildBossData[type][layer]
        end
    end

    LuaCallCs.ThrowException("---   配置错误：工会boss表找不到对应关卡数据，ResGuildBossData   indexId = "..indexId.."   layer = "..layer)
    return nil
end

local __cfgMisc = function()
    return DataTable.ResGuildBossMisc[1]
end

local __cfgBuffData = function(buffIdx)
    local cfg = DataTable.ResGuildBossGuildBuff[buffIdx]
    if cfg then
        return cfg
    end
    LuaCallCs.ThrowException("---   配置错误：工会buff表找不到数据，ResGuildBossGuildBuff   buffIdx = "..buffIdx)
    return nil
end

---@class LeagueBossMonsterInfo
local __leagueBossMonsterInfo = Class("LeagueBossMonsterInfo")
function __leagueBossMonsterInfo:Init(monsterId, hp)
    self.MonsterCfgId = monsterId
    self.HP = hp
end

---@class LeagueBossMonsterGroupInfo
local __leagueBossMonsterGroupInfo = Class("LeagueBossMonsterGroupInfo")
function __leagueBossMonsterGroupInfo:Init(groupState, layerIdList, layerStateList)
    -- 状态 0：未开始 1：挑战中 2：已通过
    self.GroupState = groupState
    self.LayerIDList = layerIdList
    self.LayerStateList = layerStateList
end

---@class LeagueBossPassRewardReview
local __leagueBossPassRewardReview = Class("LeagueBossPassRewardReview")
function __leagueBossPassRewardReview:Init(layer, layerName, rewardId, icon, isGet)
    self.Layer = layer
    self.LayerName = layerName
    self.RewardId = rewardId
    self.BossIcon = icon
    self.IsGet = isGet
end


local tab = {}

----- 配置表相关接口 -----
function tab.TabGetIndexType(indexId) -- 本期boss类型
    if DataTable.ResGuildBossIndex[indexId] then
        local type = DataTable.ResGuildBossIndex[indexId].type
        return type
    end
    return 0
end
function tab.TabGetStageName(indexId, layer) -- 关卡名称
    local cfg = __cfgLayerData(indexId, layer)
    return cfg.name
end
function tab.TabGetStageArtName(indexId, layer) -- 关卡名称（美术效果字）
    local cfg = __cfgLayerData(indexId, layer)
    return cfg.art_name
    --return "<size=50>挑<size=36>战者第 <size=46>3 <size=36>层"
end
function tab.TabGetStageTitleBg(indexId, layer) -- 关卡标题背景
    local cfg = __cfgLayerData(indexId, layer)
    return cfg.title_bg
    --return "Texture/Dynamic/UIGuildBoss/guild_boss_info_bg1"
end
function tab.TabGetStageBossPic(indexId, layer) -- 关卡boss图片
    local cfg = __cfgLayerData(indexId, layer)
    return cfg.Main_Picture
end
function tab.TabGetStageBossEfx(indexId, layer) -- 关卡boss特效
    local cfg = __cfgLayerData(indexId, layer)
    return cfg.Main_Efx
end
function tab.TabGetStageBattleID(indexId, layer) -- 关卡对应的战场ID
    local cfg = __cfgLayerData(indexId, layer)
    return cfg.battle_id
end
function tab.TabGetStagePassReward(indexId, layer) -- 关卡通过后的全员奖励
    local cfg = __cfgLayerData(indexId, layer)
    return cfg.pass_reward
end
function tab.TabGetStageRecommendLineup(indexId, layer) -- 关卡推荐阵容
    local cfg = __cfgLayerData(indexId, layer)
    return cfg.recommended_lineup
end
---@return LeagueBossMonsterInfo[]
function tab.TabGetStageMonsters(indexId, layer) -- 关卡怪物列表
    local ent = __leagueBossEntity()
    local battleID = Util.LeagueBoss.TabGetStageBattleID(indexId, layer)
    local list = FormationHelper.GetMonstersByTeamIdx(battleID, 1)
    local result = {}
    for i = 1, #list do
        local monsterCfgId = list[i]
        local hp = BattleConst.MAX_HP
        if monsterCfgId > 0 then
            if ent then
                for m = 1, #ent.monsterHp do
                    if ent.monsterHp[m].pos == i then
                        hp = ent.monsterHp[m].hppct
                        break
                    end
                end
            end
            local info = __leagueBossMonsterInfo()
            info:Init(monsterCfgId, hp)
            table.insert(result, info)
        end
    end
    return result
end
function tab.TabGetStageMonsterStateIcon(indexId, layer, state) -- 关卡怪状态图标
    -- 状态 0：未开始 1：挑战中 2：已通过
    local cfg = __cfgLayerData(indexId, layer)
    if state == 0 then
        return cfg.layer_icon_before
    elseif state == 1 then
        return cfg.layer_icon_on
    elseif state == 2 then
        return cfg.layer_icon_after
    end
    return ""
end
function tab.TabGetStageGroupStateIconState(indexId, layer, state) -- 关卡组图标
    -- 状态 0：未开始 1：挑战中 2：已通过
    local cfg = __cfgLayerData(indexId, layer)
    if state == 0 then
        return cfg.group_icon_before
    elseif state == 1 then
        return cfg.group_icon_on
    elseif state == 2 then
        return cfg.group_icon_after
    end
    return ""
end
function tab.TabGetMiscMaxChallengeCount() -- 每日最大挑战次数
    local cfg = __cfgMisc()
    return cfg.challenge_times
end
function tab.TabGetMiscReportKey1() -- 工会日报类型1:PVP玩法(等同与积分道具id)
    local cfg = __cfgMisc()
    return cfg.guild_buff_item_1
end
function tab.TabGetMiscReportKey2() -- 工会日报类型2:3v3玩法(等同与积分道具id)
    local cfg = __cfgMisc()
    return cfg.guild_buff_item_2
end
function tab.TabGetMiscReportKey3() -- 工会日报类型3:世界boss玩法(等同与积分道具id)
    local cfg = __cfgMisc()
    return cfg.guild_buff_item_3
end
function tab.TabGetBuffQueue() -- buff表-buff链
    local result = {}
    for i = 1, #DataTable.ResGuildBossGuildBuff do
        local cfg = DataTable.ResGuildBossGuildBuff[i]
        table.insert(result, cfg.id)
    end
    return result
end
function tab.TabGetBuffName(buffIdx) -- buff表-buff名字
    local cfg = __cfgBuffData(buffIdx)
    return cfg.buff_name
end
function tab.TabGetBuffDesc(buffIdx) -- buff表-buff描述
    local cfg = __cfgBuffData(buffIdx)
    return cfg.buff_desc
end
function tab.TabGetBuffLimitValue(buffIdx) -- buff表-buff生效的积分值
    local cfg = __cfgBuffData(buffIdx)
    return cfg.buff_point
end
function tab.TabGetBuffIcon(buffIdx) -- buff表-buff图标（图集+图标）
    local cfg = __cfgBuffData(buffIdx)
    return cfg.buff_icon_path, cfg.buff_icon
end
function tab.TabGetBuffId(buffIdx) -- buff表-真实buffId
    local cfg = __cfgBuffData(buffIdx)
    return cfg.state_id
end
function tab.TabGetBuffLv(buffIdx) -- buff表-真实buff等级
    local cfg = __cfgBuffData(buffIdx)
    return cfg.state_level
end
----- 配置表相关接口 -----




----- 数据接口 -----
function tab.IsExistBossData() -- 是否有工会boss 数据
    local leagueDB = LeagueHelper.GetLeagueDB()
    if leagueDB == nil then
        LuaCallCs.ThrowException("---   数据异常：没有工会数据，无法使用工会boss相关功能...")
    end
    local bossData = leagueDB:GetLeagueBoss()
    return bossData ~= nil
end
function tab.GetCurIndexID() -- 当前周期ID
    local ent = __leagueBossEntity()
    if ent then
        return ent.indexId
    end
    return 0
    --return 1 --测试
end
function tab.GetCurLayer() -- 当前关卡ID
    local ent = __leagueBossEntity()
    if ent then
        return ent.layer
    end
    return 0
    --return 9 --测试
end
function tab.GetTotalBuffValue() -- 工会boss-buff总积分
    local ent = __leagueBossEntity()
    if ent then
        return ent.talent
    end
    return 0
    --return 11700
end
function tab.GetMaxBuffIdx() -- 工会boss-当前激活的最高buffIdx
    local totalValue = Util.LeagueBoss.GetTotalBuffValue()
    local result = 0
    for i = 1, #DataTable.ResGuildBossGuildBuff do
        local cfg = DataTable.ResGuildBossGuildBuff[i]
        if cfg.buff_point <= totalValue then
            result = i
        end
    end
    return result
end
function tab.GetBuffCount() -- 工会boss-当前激活的buff数量
    local totalValue = Util.LeagueBoss.GetTotalBuffValue()
    local result = 0
    for i = 1, #DataTable.ResGuildBossGuildBuff do
        local cfg = DataTable.ResGuildBossGuildBuff[i]
        if cfg.buff_point <= totalValue then
            result = result + 1
        end
    end
    return result
end

---@return number[]
function tab.GetActiveBuffList() -- 工会boss-当前激活的buff列表
    local tempDict = {}
    local totalValue = Util.LeagueBoss.GetTotalBuffValue()
    for i = 1, #DataTable.ResGuildBossGuildBuff do
        local cfg = DataTable.ResGuildBossGuildBuff[i]
        local buffIdx = cfg.id
        local buffId = Util.LeagueBoss.TabGetBuffId(buffIdx)
        local buffLv = Util.LeagueBoss.TabGetBuffLv(buffIdx)
        local limitValue = Util.LeagueBoss.TabGetBuffLimitValue(buffIdx)
        if limitValue <= totalValue then
            if tempDict[buffId] then
                local tempBuffLv = Util.LeagueBoss.TabGetBuffLv(tempDict[buffId])
                if tempBuffLv < buffLv then
                    tempDict[buffId] = buffIdx
                end
            else
                tempDict[buffId] = buffIdx
            end
        end
    end

    local result = {}
    for k, v in pairs(tempDict) do
        table.insert(result, v)
    end
    table.sort(result, function(a, b) return a > b end)
    return result
end
function tab.GetChallengeCount() -- 工会boss-挑战次数
    local ent = __leagueBossEntity()
    if ent then
        return ent.challenge
    end
    return 0
end
function tab.GetCanRewardLayer() -- 工会boss-可领取奖励的层数
    local result = nil
    local ent = __leagueBossEntity()
    if ent then
        local maxPassLayer = ent.layer - 1
        local haveGetLayer = ent.reward
        for i = 1, maxPassLayer do
            for m = 1, #haveGetLayer do
                if haveGetLayer[m] == i then
                    break
                end
            end
        end
    end
    return result
    --return 5
end
---@return LeagueBossMonsterGroupInfo[]
function tab.GetGroupProgress(indexId) -- 工会boss-关卡进度
    indexId = indexId and indexId or 0
    local bossType = Util.LeagueBoss.TabGetIndexType(indexId)
    local cfg = DataTable.ResGuildBossData[bossType]
    local maxLayer = cfg and #cfg or 0
    local curLayer = Util.LeagueBoss.GetCurLayer()
    local result = {}

    for groupIdx = 0, 5 do
        local layerId = {}
        local layerState = {}
        for layerIdx = 1, 3 do
            local tempLayer = groupIdx * 3 + layerIdx
            local enable = tempLayer <= maxLayer -- 是否有效
            if enable then
                local state = 0-- 未开始
                if tempLayer == curLayer then
                    state = 1-- 挑战中
                elseif tempLayer < curLayer then
                    state = 2-- 已通过
                end
                table.insert(layerId, tempLayer)
                table.insert(layerState, state)
            end
        end
        if #layerId > 0 then
            local groupState = 0
            for i = 1, #layerState do
                if layerState[i] == 1 then
                    groupState = 1
                    break
                elseif layerState[i] == 2 then
                    groupState = 2
                end
            end
            local info = __leagueBossMonsterGroupInfo()
            info:Init(groupState, layerId, layerState)
            table.insert(result, info)
        end
    end
    return result
end

---@return LeagueBossPassRewardReview[]
function tab.GetPassRewardReview(indexId) -- 工会boss-全员通关奖励预览
    indexId = indexId and indexId or 0
    local bossType = Util.LeagueBoss.TabGetIndexType(indexId)
    local indexCfg = DataTable.ResGuildBossData[bossType]
    local curLayer = Util.LeagueBoss.GetCurLayer()
    local result = {}
    for i = 1, #indexCfg do
        local cfg = indexCfg[i]
        local layer = cfg.layer
        local layerName = Util.LeagueBoss.TabGetStageName(indexId, layer)
        local rewardId = Util.LeagueBoss.TabGetStagePassReward(indexId, layer)
        local icon = Util.LeagueBoss.TabGetStageGroupStateIconState(indexId, layer, 0)
        local isGet = curLayer >= layer
        local data = __leagueBossPassRewardReview()
        data:Init(layer, layerName, rewardId, icon, isGet)
        table.insert(result, data)
    end
    return result
end

function tab.GetBossProgressRank() -- 工会boss-进度排行榜名次
    local ent = __leagueBossEntity()
    if ent then
        return ent.progressRank
    end
    return 0
end

---@return HeroChallengeEntity[]
function tab.GetHeroChallengeData() -- 工会boss-英雄挑战记录
    local ent = __leagueBossEntity()
    if ent then
        return ent.heroChallenge
    end
    return {}
end

Util.LeagueBoss = tab
