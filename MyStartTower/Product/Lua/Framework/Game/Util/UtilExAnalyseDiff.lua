

---@param diff table
---@param dataType string
---@return table
local _AnalyseDiff = function(diff, dataType)
    if diff == nil or dataType == nil then
        return nil
    end
    return diff[dataType]
end

--注意这种写法有两个好处
--1.这种写法可以保证业务侧拿到数据后，可以正常访问变量名，像C#一样可以点出来
--2.这个类在外部无法创建实例，只能通过特定的接口创建实例，类似C#的私有类，但不完全一样
---@class DropDownReward
local DropDownReward = Class("DropDownReward")
function DropDownReward:Init(itemId, itemCount, emblemGid)
    self.ItemId = itemId
    self.ItemCount = itemCount
end
function DropDownReward:SetEquip(gid)
    self.EquipGid = gid -- 装备GID
end
function DropDownReward:SetEmblem(gid)
    self.EmblemGid = gid -- 文章gid
end
function DropDownReward:SetRimuruStone(gid)
    self.RimuruStoneGid = gid -- gid
end

function DropDownReward:SetHero(gid)
    self.HeroGid = gid -- 英雄GID
end


-- diff数据 解析算法

local tab = {}

---@return DropDownReward[]
function tab.DropDownReward(diff)
    local result = {}
    if not diff then
        return result
    end

    local itemList = Util.AnalyseDiff.AnalyseItems(diff, DiffsKeyEnum.ADD)
    if itemList then
        for i = 1, #itemList do
            local item = itemList[i]
            local data = DropDownReward()
            data:Init(item.itemId, item.count)
            table.insert(result,data)
        end
    end


    local equipList = Util.AnalyseDiff.AnalyseEquips(diff, DiffsKeyEnum.ADD)
    if equipList then
        for i = 1, #equipList do
            local gid = equipList[i]
            local equip = EquipHelper.GetEntity(gid)
            local data = DropDownReward()
            data:Init(equip.resid, 1)
            data:SetEquip(gid)
            table.insert(result,data)
        end
    end


    local emblemList = Util.AnalyseDiff.AnalyseEmblems(diff, DiffsKeyEnum.ADD)
    if emblemList then
        for i = 1, #emblemList do
            local gid = emblemList[i]
            local emblem = EmblemHelper.GetEntity(gid)
            local data = DropDownReward()
            data:Init(emblem.resId, 1)
            data:SetEmblem(gid)
            table.insert(result,data)
        end
    end


    local rimuruStoneList = Util.AnalyseDiff.AnalyseRimuruStone(diff, DiffsKeyEnum.ADD)
    if rimuruStoneList then
        for i = 1, #rimuruStoneList do
            local gid = rimuruStoneList[i]
            local stone = RimuruHelper.GetStoneEntity(gid)
            local data = DropDownReward()
            data:Init(stone.resId, 1)
            data:SetRimuruStone(gid)
            table.insert(result,data)
        end
    end

    table.sort(result,function (a,b)
        --local adata = DataTable.ResItem[a.ItemId]
        local adata = ItemHelper.GetItemConfig(a.ItemId)
        local aquality = adata and adata.quality or 0
        if not adata then
            --adata = DataTable.ResEquipData[a.ItemId]
            adata = EquipHelper.GetEquipConfig(a.ItemId)
            aquality = adata and adata.big_quality or 0
        end
        if not adata then
            --adata = DataTable.ResEmblem[a.ItemId]
            adata = EmblemHelper.GetEmblemConfig(a.ItemId)
            aquality = adata and adata.big_quality or 0
        end
        --local bdata = DataTable.ResItem[b.ItemId]
        local bdata = ItemHelper.GetItemConfig(b.ItemId)
        local bquality = bdata and bdata.quality or 0
        if not bdata then
            --bdata = DataTable.ResEquipData[b.ItemId]
            bdata = EquipHelper.GetEquipConfig(b.ItemId)
            bquality = bdata and bdata.big_quality or 0
        end
        if not bdata then
            --bdata = DataTable.ResEmblem[b.ItemId]
            bdata = EmblemHelper.GetEmblemConfig(b.ItemId)
            bquality = bdata and bdata.big_quality or 0
        end

        return aquality > bquality
    end)
    return result
end

---@return DropDownReward[] 英雄奖励列表
---@type DropDownReward[]
function tab.DropDownHero(diff)
    local result = {}
    local heroList = Util.AnalyseDiff.AnalyseHeros(diff, DiffsKeyEnum.ADD)
    if heroList then
        for i = 1, #heroList do
            local gid = heroList[i]
            local data = DropDownReward()
            data:Init(gid, 1)
            data:SetHero(gid)
            table.insert(result, data)
        end
    end
    return result
end



---@param diff table
---@param diffKey string
---@return ItemEntity[] 解析道具差分数据
function tab.AnalyseItems(diff, diffKey)
    local result = _AnalyseDiff(diff, DataType.items)
    if result then
        return result[diffKey]
    end
    return nil
end

---@param diff table
---@param diffKey string
---@return string[] 解析英雄差分数据
function tab.AnalyseHeros(diff, diffKey)
    local result = _AnalyseDiff(diff, DataType.heroes)
    if result then
        return result[diffKey]
    end
    return nil
end

---@param diff table
---@param diffKey string
---@return string[] 解析圣徽差分数据
function tab.AnalyseEmblems(diff, diffKey)
    local result = _AnalyseDiff(diff, DataType.emblem)
    if result then
        return result[diffKey]
    end
    return nil
end

--- @param diff table
--- @param diffKey string
--- @return string[] 解析装备差分数据
function tab.AnalyseEquips(diff, diffKey)
    local result = _AnalyseDiff(diff, DataType.equip)
    if result then
        return result[diffKey]
    end
    return nil
end


function tab.AnalyseHeros(diff, diffKey)
    local result = _AnalyseDiff(diff, DataType.heroes)
    if result then
        return result[diffKey]
    end
    return nil
end

--- @param diff table 差分数据
--- @param diffKey string
--- @return string[] 解析利姆鲁石头差分数据
function tab.AnalyseRimuruStone(diff, diffKey)
    local result = _AnalyseDiff(diff, DataType.rimuruStone)
    if result then
        return result[diffKey]
    end
    return nil
end




Util.AnalyseDiff = tab