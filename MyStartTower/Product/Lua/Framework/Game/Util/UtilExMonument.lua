


-- 简化接口:排行榜

local tab = {}


function tab.IsBlankRank()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:IsBlankRank()
end

function tab.TheFirstPlayer()
    return Util.Monument.GetPlayerInfoByRank(1)
end

function tab.GetPlayerInfoByRank(rank)
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:GetPlayerInfoByRank(rank)
end

function tab.RankPlayerCount()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:RankPlayerCount()
end

function tab.GetSelfRank()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:GetSelfRank()
end

function tab.GetSelfRankInfo()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:GetSelfRankInfo()
end

function tab.GetVirtualSelfRankInfo()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:GetVirtualSelfRankInfo()
end

function tab.GetRankDataList()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:GetRankDataList()
end

function tab.SetCurRankType(type)
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    db:SetCurRankType(type)
end

function tab.GetCurRankType()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:GetCurRankType()
end

function tab.GetCurRankFormationID()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:GetCurRankFormationID()
end


function tab.GetCurRankStaticInfo()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    local curType = db:GetCurRankType()
    return db:GetRankStaticInfoByType(curType)
end

function tab.GetStaticRankDataList()
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    return db:GetStaticRankDataList()
end

function tab.AnalyseStageNum(num)
    local a = math.floor(num % 10000 / 100)
    local b = num % 10000 % 100
    return string.format("%d-%d", a, b)
end


function tab.SetRankMountainTime(group,index,value)
    ---@type MonumentDB
    local db = GameDB.GetDB(DBId.UIMonument)
    db:SetRankMountainTime(group,index,value)
end


Util.Monument = tab
