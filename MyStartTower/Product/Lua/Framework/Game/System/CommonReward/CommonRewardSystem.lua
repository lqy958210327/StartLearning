-- 奖励系统

---@class CommonRewardSystem : SystemBase
CommonRewardSystem = Class("CommonRewardSystem", SystemBase)

function CommonRewardSystem:OnInit()
    ---@type table[CommonRewardData]
    self.rewardDatas = {}
    ---@type boolean 是否第一次得到数据，打开UI
    self.isNext = true

    EventManager.Global.RegisterEvent(EventType.CommonRewardAddItemData, function(itemDatas) self:RewardAddItemData(itemDatas) end)
    EventManager.Global.RegisterEvent(EventType.CommonRewardAddHeroData, function(itemDatas) self:RewardAddHeroData(itemDatas) end)
    EventManager.Global.RegisterEvent(EventType.CommonRewardAddShowType, function(param1, param2) self:RewardAddTypeData(param1, param2) end)
    EventManager.Global.RegisterEvent(EventType.CommonRewardShowNext, function() self:RewardShowNext() end)
    EventManager.Global.RegisterEvent(EventType.CommonRewardHeroSign, function(param1, param2, param3) self:HeroSignAni(param1, param2, param3) end)
    EventManager.Global.RegisterEvent(EventType.CommonRewardDiceAni, function() self:DiceAni() end)
end

function CommonRewardSystem:AddRewardData(rewardData)
    table.insert(self.rewardDatas, rewardData)
    if self.isNext then
        self.isNext = false
        self:RewardShowNext()
    end
end

---@type fun(itemDatas:table[]) 添加显示道具
---@param itemDatas ItemEntity[]
function CommonRewardSystem:RewardAddItemData(itemDatas)
    ---@type CommonRewardData
    local rewardData = CommonRewardData()
    rewardData:init(CommonRewardEnum.EnumItem)
    rewardData:WithItemData(itemDatas)
    if #rewardData.itemDatas > 0 then
        self:AddRewardData(rewardData)
    end
end

---@type fun(heroData:table[]) 添加显示英雄
function CommonRewardSystem:RewardAddHeroData(heroData)
    ---@type CommonRewardData
    local rewardData = CommonRewardData()
    rewardData:init(CommonRewardEnum.EnumHero)
    rewardData:WithHeroData(heroData)
    self:AddRewardData(rewardData)
end

---@type fun(itemDatas:table[]) 
function CommonRewardSystem:RewardAddTypeData(param1, param2)
    ---@type CommonRewardData
    local rewardData = CommonRewardData()
    rewardData:init(CommonRewardEnum.EnumType)
    rewardData:WithAllData(param1, param2)
    self:AddRewardData(rewardData)
end

function CommonRewardSystem:HeroSignAni(days, indexs, infos)
    ---@type CommonRewardData
    local rewardData = CommonRewardData()
    rewardData:init(CommonRewardEnum.EnumHeroSignAni)
    rewardData:WithHeroSignData(days, indexs, infos)
    self:AddRewardData(rewardData)
end

---骰子动画
function CommonRewardSystem:DiceAni()
    ---@type CommonRewardData
    local rewardData = CommonRewardData()
    rewardData:init(CommonRewardEnum.EnumDiceAni)
    self:AddRewardData(rewardData)
end

function CommonRewardSystem:RewardShowNext()
    if table.count(self.rewardDatas) <= 0 then
        self.isNext = true
        return
    end
    local rewardData = table.remove(self.rewardDatas, 1)
    if rewardData then
        self:ShowRewardData(rewardData) 
    end
end

---@type fun(rewardData:CommonRewardData)
---@param rewardData CommonRewardData 显示奖励数据
function CommonRewardSystem:ShowRewardData(rewardData)
    if rewardData.type == CommonRewardEnum.EnumItem then
        UIJump.ToOpenUICommonReward(rewardData.itemDatas)
    elseif rewardData.type == CommonRewardEnum.EnumHero then
        UIJump.ToOpenUIHeroAcquireByHeroGID(rewardData.heroDatas)
    elseif rewardData.type == CommonRewardEnum.EnumEquip then
        -- self:onShowUIData(rewardData.param1, rewardData.param2)
    elseif rewardData.type == CommonRewardEnum.EnumHeroSignAni then     ---英雄降临动画
        EventCenter.sendEvent(EventConst.ACTIVITY_HEROSIGN, {rewardData.param1, rewardData.param2, rewardData.param3})
        ---数据发出去以后，就可以执行下一步了
        self:RewardShowNext()
    elseif rewardData.type == CommonRewardEnum.EnumDiceAni then
        ---没有需要处理的内容，只是在播放恭喜获得前播放了一段动画，动画播放中等待下一步
        --self:RewardShowNext()
    end
end

function CommonRewardSystem:OnClear()
    EventManager.Global.UnRegisterEvent(EventType.CommonRewardAddItemData, function() self:RewardAddItemData() end)
    EventManager.Global.UnRegisterEvent(EventType.CommonRewardAddHeroData, function() self:RewardAddHeroData() end)
    EventManager.Global.UnRegisterEvent(EventType.CommonRewardAddShowType, function() self:RewardAddTypeData() end)
    EventManager.Global.UnRegisterEvent(EventType.CommonRewardShowNext, function() self:RewardShowNext() end)
    EventManager.Global.UnRegisterEvent(EventType.CommonRewardHeroSign, function() self:HeroSignAni() end)

    self.rewardDatas = {}
end