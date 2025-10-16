
---@class SepatatorItemData
local SepatatorItemData = Class("SepatatorItemData")
function SepatatorItemData:init(itemID, itemNum)
    self.itemID = itemID ---@type number 道具ID
    self.itemNum = itemNum ---@type number 道具数量
end

-- 简化接口:计时器

local tab = {}

---@type fun() 返回一个分隔符计算的道具数据
---@param separatorStr string {100001, 2; 10000,2}
---@return table<number, SepatatorItemData> itemTab 道具数据组
function tab.UtilSeparatorStringByItem(separatorStr)
    local separatorList = string.split(separatorStr, ";")
    local itemTab = {}
    for i, separatorData in ipairs(separatorList) do
        ---@type SepatatorItemData
        local itemData = SepatatorItemData()
        local separatorList = separatorData.split(separatorData, ",")
        local itemID = tonumber(separatorList[1])
        local itemNum = tonumber(separatorList[2])
        itemData:init(itemID, itemNum)
        table.insert(itemTab, itemData)
    end
    return itemTab
end

---@type fun() 根据道具ID列表和道具数量列表返回一组道具数据
---@type table<number, number> 索引，道具ID
---@type table<number, number> 索引，道具数量
---@return table<number, SepatatorItemData> itemTab 道具数据组
function tab.UtilSeparatorListByItem(itemIds, itemNums)
    if table.count(itemIds) ~= table.count(itemNums) then
        logerror("Error：数据错误！！！道具ID和道具数量不匹配！检查传入参数")
        return
    end
    local itemTab = {}
    for i = 1 , table.count(itemIds) do
        local itemID = itemIds[i]
        local itemNum = itemNums[i]
        ---@type SepatatorItemData
        local itemData = SepatatorItemData()
        itemData:init(itemID, itemNum)
        table.insert(itemTab, itemData)
    end
    return itemTab
end

Util.UtilSeparator = tab