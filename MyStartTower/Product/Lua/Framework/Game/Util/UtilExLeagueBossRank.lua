


---@class LeagueBossDamageRank
local __leagueBossDamageRank = Class("LeagueBossDamageRank")
function __leagueBossDamageRank:Init(rank, head, frame, title, medals, name, damage)
    self.Rank = rank or 0
    self.PlayerHeadID = head or 0
    self.PlayerFrameID = frame or 0
    self.PlayerTitleID = title or 0
    self.PlayerMedalIds = medals or {}
    self.PlayerName = name or ""
    self.BossDamage = damage or 0
end

---@class LeagueBossBuffScoreRank
local __leagueBossBuffScoreRank = Class("LeagueBossBuffScoreRank")
function __leagueBossBuffScoreRank:Init(rank, head, frame, title, medals, name, buffScore)
    self.Rank = rank or 0
    self.PlayerHeadID = head or 0
    self.PlayerFrameID = frame or 0
    self.PlayerTitleID = title or 0
    self.PlayerMedalIds = medals or {}
    self.PlayerName = name or ""
    self.BuffScore = buffScore or 0
end

---@class LeagueBossProgressRank
local __leagueBossProgressRank = Class("LeagueBossProgressRank")
function __leagueBossProgressRank:Init(rank, leagueFlag, leagueName, leagueLeader, layer, hpPer)
    self.Rank = rank or 0
    self.LeagueFlag = leagueFlag or {}
    self.LeagueName = leagueName or ""
    self.LeagueLeader = leagueLeader or ""
    self.Layer = layer or 0
    self.HpPer = hpPer or 1
end




local tab = {}



----- 个人伤害榜 -----
---@return LeagueBossDamageRank[], LeagueBossDamageRank 排行榜总数据，个人排名数据
function tab.GetDamageRank() -- 工会boss-伤害排行榜
    ---@type LeagueMemberEntity[]
    local memberList = {}
    local members = LeagueHelper.GetMyLeagueMember()
    for i = 1, #members do
        if members[i].bossDamage > 0 then
            table.insert(memberList, members[i])
        end
    end
    table.sort(memberList, LeagueHelper.GetMemberTreasureCompare(LeagueTreasureMemberSortType.BossDamage))
    local result = {}
    local selfRankData = nil
    for i = 1, #memberList do
        local member = memberList[i]
        local rank = i
        local playerUid = member.head.uid
        local playerName = member.head.name
        local playerHead = member.head.head
        local playerFrame = member.head.frame
        local playerTitle = member.head.title
        local playerMedals = member.head.medals
        local playerDamage = member.bossDamage
        local rankData = __leagueBossDamageRank()
        rankData:Init(rank, playerHead, playerFrame, playerTitle, playerMedals, playerName, playerDamage)
        table.insert(result, rankData)
        if Util.Account.PlayerUid() == playerUid then
            selfRankData = rankData
        end
    end
    return result, selfRankData
end



----- 个人buff积分榜 -----
---@return LeagueBossBuffScoreRank[], LeagueBossBuffScoreRank 排行榜总数据，个人排名数据
function tab.GetBuffScoreRank() -- 工会boss-buff积分榜
    ---@type LeagueMemberEntity[]
    local memberList = {}
    local members = LeagueHelper.GetMyLeagueMember()
    for i = 1, #members do
        if members[i].buffScore > 0 then
            table.insert(memberList, members[i])
        end
    end
    table.sort(memberList, LeagueHelper.GetMemberTreasureCompare(LeagueTreasureMemberSortType.BuffScore))
    local result = {}
    local selfRankData = nil
    for i = 1, #memberList do
        local member = memberList[i]
        local rank = i
        local playerUid = member.head.uid
        local playerName = member.head.name
        local playerHead = member.head.head
        local playerFrame = member.head.frame
        local playerTitle = member.head.title
        local playerMedals = member.head.medals
        local buffScore = member.buffScore
        local rankData = __leagueBossBuffScoreRank()
        rankData:Init(rank, playerHead, playerFrame, playerTitle, playerMedals, playerName, buffScore)
        table.insert(result, rankData)
        if Util.Account.PlayerUid() == playerUid then
            selfRankData = rankData
        end
    end
    return result, selfRankData
end

---@param msg table<number,SC_GuildRankDataInfo>
---@return LeagueBossProgressRank[], LeagueBossProgressRank 排行榜总数据，自己排名数据
function tab.GetBossProgressRank(msg) -- 工会boss-进度排行榜
    local result = {}
    local selfRankData = nil
    for i = 1, #msg do
        local data = msg[i]
        local rank = i
        local leagueId = data.guild.brand.guildId
        local flag = data.guild.brand.flag
        local leagueName = data.guild.brand.name
        local leader = data.guild.leader.name
        local layer = data.layer
        local damagePer = data.damagePercent
        local rankData = __leagueBossProgressRank()
        rankData:Init(rank, flag, leagueName, leader, layer, damagePer)
        table.insert(result, rankData)
        if LeagueHelper.GetMyLeagueGid() == leagueId then
            selfRankData = rankData
        end
    end
    return result, selfRankData
end



Util.LeagueBossRank = tab
