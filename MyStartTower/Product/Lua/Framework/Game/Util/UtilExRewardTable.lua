

--注意这种写法有两个好处
--1.这种写法可以保证业务侧拿到数据后，可以正常访问变量名，像C#一样可以点出来
--2.这个类在外部无法创建实例，只能通过特定的接口创建实例，类似C#的私有类，但不完全一样
---@class SimpleRewardItem
local SimpleRewardItem = Class("SimpleRewardItem")
function SimpleRewardItem:Init(itemId, itemCount)
    self.ItemId = itemId
    self.ItemCount = itemCount
end


-- 奖励表接口
local tab = {}

-- 解析固定奖励表奖励数据
---@param id number 固定奖励表 配置ID
---@return SimpleRewardItem[]
function tab.AnalyseStaticRewardList(id)
    local result = {}
    local cfg = DataTable.ResFixedRewardClient[id]
    if cfg then
        local total = #cfg.item_ids
        for i = 1, total do
            local itemId = cfg.item_ids[i]
            local itemCount = cfg.item_nums[i]
            local item =  SimpleRewardItem()
            item:Init(itemId, itemCount)
            table.insert(result, item)
        end
    end
    return result
end

-- 解析随机奖励表奖励数据
---@param id number 随机奖励表 配置ID
---@return SimpleRewardItem[]
function tab.AnalyseRandomRewardList(id)
    local result = {}
    local cfg = DataTable.ResRandClient[id]
    if cfg then
        local total = #cfg.show_ids
        for i = 1, total do
            local itemId = cfg.show_ids[i]
            local itemCount = cfg.show_nums[i]
            local item =  SimpleRewardItem()
            item:Init(itemId, itemCount)
            table.insert(result, item)
        end
    end
    return result
end

Util.RewardTable = tab
