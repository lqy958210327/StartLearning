--注意这种写法有两个好处
--1.这种写法可以保证业务侧拿到数据后，可以正常访问变量名，像C#一样可以点出来
--2.这个类在外部无法创建实例，只能通过特定的接口创建实例，类似C#的私有类，但不完全一样
---@class MarsketRewardItem
local MarsketRewardItem = Class("MarsketRewardItem")
function MarsketRewardItem:Init(itemId, itemCount)
    self.ItemId = itemId
    self.ItemCount = itemCount
end


-- 付费商品信息

local tab = {}

---@param bundleId number 礼包id
function tab.ReadLimit(bundleId)
    return Blackboard.ReadBBItemDictGetValue(BbKey.Global, BbItemKey.RechargeLimitNum, bundleId) or 0
end

---@param addBundle table<number, SC_RechargeBundle>
---@param delBundle table<number, number> 应该只有GM用到
function tab.WriteLimit(addBundle, delBundle)
    for i, bundleData in ipairs(addBundle) do
        local key = bundleData.resId
        local value = bundleData.purchase
        Blackboard.WriteBBItemDictSetValue(BbKey.Global, BbItemKey.RechargeLimitNum, key, value)
    end

    for i, key in ipairs(delBundle) do
        Blackboard.WriteBBItemDictSetValue(BbKey.Global, BbItemKey.RechargeLimitNum, key, 0)
    end

    -- 充值结果变更后，推送一个消息出去，需要更新充值相关的地方自己处理
    EventManager.Global.Dispatch(EventType.RechargeResultUpdate)
end

---@type function() 获取名称
---@return string
function tab.GetName(bundleId)
    local cfg = DataTable.ResRechargeBundleData[bundleId]
    if cfg then
        return cfg.rechargeNameUSD
    end
    return ""
end

---@type function() 获取礼包名称
---@return string
function tab.GetNameByGiftId(giftid)
    local cfg = tab.GetMarketBundle(giftid)
    if cfg then
        return cfg.bundleName
    end
    return ""
end

---@type function() 获取价格
---@return number
function tab.GetPrice(bundleId)
    local cfg = DataTable.ResRechargeBundleData[bundleId]
    if cfg then
        return cfg.priceUSD
    end
    return 0
end


--礼包内容
function tab.GetMarketBundle(giftid)
   local config=DataTable.ResRechargeBundleBundle
   local cfg=config[giftid]
    assert(cfg, "---   数据异常：ResRechargeBundleBundle配置数据空 Id = "..giftid)
   return cfg
end

--礼包超值标签
function tab.GetMarketBundleOverflow(giftid)
   local cfg=tab.GetMarketBundle(giftid)
   local active= cfg.overflow~=nil
   return active ,cfg.overflow
end
--热卖
function tab.GetMarketGiftisSalable(giftid)
    local cfg=tab.GetMarketBundle(giftid)
    local active= cfg.isSalable~=nil
    return active 
end

-- 礼包展示道具内容
---@return MarsketRewardItem[]
function tab.GetMarketRewardItem(giftid)
    local result = {}
    local cfg =  tab.GetMarketBundle(giftid)
    if cfg then
        local total = #cfg.itemID
        for i = 1, total do
            local itemId = cfg.itemID[i]
            local itemCount = cfg.itemNum[i]
            local item =  MarsketRewardItem()
            item:Init(itemId, itemCount)
            table.insert(result, item)
        end
    end
    return result
end

-- 获取充值档位 配置
function tab.ResRechargeBundleData(id)
    local cfg=DataTable.ResRechargeBundleData[id]
    assert(cfg, "---   数据异常：ResRechargeBundleData配置数据空 Id = "..id)
    return cfg
end
-- 礼包展示人名币价格
function tab.GetMarketGiftPrice(giftid)
    local config = tab.GetMarketBundle(giftid)
    local cfg=tab.ResRechargeBundleData(config.rechargeID)
    if tab.GetMarketGiftFree(giftid) then
        return cfg.rechargeNameCNY
    else
        return string.format("￥%s",cfg.priceCNY/100)
    end
end
-- 原价展示
function tab.GetMarketGiftDiscountUSD(giftid)
    local config = tab.GetMarketBundle(giftid)
    local cfg=tab.ResRechargeBundleData(config.rechargeID)
    return cfg.discountUSD
end

-- 是否免费礼包
function tab.GetMarketGiftFree(giftid)
    local config = tab.GetMarketBundle(giftid)
    local cfg=tab.ResRechargeBundleData(config.rechargeID)
    return cfg.priceCNY==0
end

-- 是否一键购买
function tab.GetMarketGiftBuyAll(giftid)
    local config = tab.GetMarketBundle(giftid)
    return config.buyAll~=nil,config.buyAll
end

-- 一键购买 礼包可购买状态
function tab.GetMarketBuyAllGiftBuyEnable(giftid)

    local isbuyAll,buyAll=tab.GetMarketGiftBuyAll(giftid)
    if isbuyAll then
        for k, v in pairs(buyAll) do
            if tab.ReadLimit(v)>0 then
                return false
            end
        end
    else
        return tab.GetMarketGiftSoldOut(giftid)
    end
end

---购买
function tab.BuyGift(rechargeActivityId, giftid)
   
    local callback=function()
       
        local soldOut=tab.GetMarketGiftSoldOut(giftid)
        if soldOut then
            return
        end
        if tab.GetMarketGiftFree(giftid) then
            LuaCallCs.LogError("免费领取  todo")
        else
             LuaCallCs.LogError(" 充值弹窗   todo")
            --直接购买
            EventManager.Global.Dispatch(EventType.RechargeReqOrder, rechargeActivityId, giftid)
        end
    end
    local gift = tab.GetMarketBundle(giftid)
    local isPopCommonBuy=(nil~= gift.bundleWindow) and gift.bundleWindow==1
    if isPopCommonBuy then
        local uiName = UIName.UIMarketCommonBuy
        UIManager.InterfaceOpenUI(uiName)
        Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIMarketCommonBuy, gift, callback)
    else
        callback()
    end
end

-- 是否售罄
function tab.GetMarketGiftSoldOut(giftid)
    local config =  tab.GetMarketBundle(giftid)
    local limt=config.purchaseLimit
    local buyCount=tab.ReadLimit(giftid)
    return buyCount>=limt,limt,buyCount
end


Util.CashGoods = tab
