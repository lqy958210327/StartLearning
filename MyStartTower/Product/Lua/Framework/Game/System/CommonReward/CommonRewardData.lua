---@enum CommonRewardEnum
CommonRewardEnum = {
    EnumItem = 1,           ---道具
    EnumHero = 2,           ---英雄
    EnumType = 3,           ---
    EnumHeroSignAni = 4,
    EnumDiceAni = 5,
}

---@class CommonRewardItemData  此逻辑只在恭喜获得内使用，不要在里面新加自己的结构
CommonRewardItemData = Class("CommonRewardItem")

function CommonRewardItemData:SetItemData(_itemId, _itemNum)
    self.itemId = _itemId       ---@type number 道具ID
    self.itemNum = _itemNum       ---@type number 道具ID
end

function CommonRewardItemData:SetEquipGid(_equipGid)
    self.equipGid = _equipGid       ---@type number 装备实体ID
end

---@class CommonRewardData
CommonRewardData = Class("itemDatas")

---@type fun()
---@param type number 显示类型
function CommonRewardData:init(_type)
    self.type = _type       ---@type number 类型
end

---@type fun(itemDatas:ItemEntity[])
---@param itemDatas ItemEntity[]
function CommonRewardData:WithItemData(itemDatas)
    self.itemDatas = {}         ---@type CommonRewardItemData[]
    for i, itemData in ipairs(itemDatas) do
        local itemId = itemData.itemId
        local itemNum = itemData.count
        ---先判定一下是否显示在恭喜获得内
        local itemCfg = ItemHelper.GetItemConfig(itemId)
        if not itemCfg.not_in_show then
            local rewardItemData = CommonRewardItemData()
            rewardItemData:SetItemData(itemId, itemNum)

            local equipGid = itemData.EquipGid
            if equipGid then
                rewardItemData:SetEquipGid(equipGid)
            end
            table.insert(self.itemDatas, rewardItemData)
        end
    end
end

---@type fun(_heroDatas:table[])
function CommonRewardData:WithHeroData(_heroDatas)
    self.heroDatas = _heroDatas     ---@type table[]
end

---@type fun()
function CommonRewardData:WithOtherData(_param1, _param2)
    self.param1 = _param1
    self.param2 = _param2
end

---@type fun() 签到送全英雄数据， 不在乎有多少数据，全部传出去 
function CommonRewardData:WithHeroSignData(_param1, _param2, _param3)
    self.param1 = _param1
    self.param2 = _param2
    self.param3 = _param3
end 