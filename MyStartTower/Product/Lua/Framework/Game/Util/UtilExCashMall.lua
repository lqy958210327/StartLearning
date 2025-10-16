


-- 付费商城 工具

-- 获取 付费商店 配置
local _getShopCfg = function(shopId)
    local cfg = DataTable.ResMarketShop[shopId]
    assert(cfg, "---   数据异常：ResMarketShop配置数据空 shopId = "..shopId)
    return cfg
end

-- 获取 付费商店组 配置
local _getShopGroupCfg = function(groupId)
    local cfg = DataTable.ResMarketTab[groupId]
    assert(cfg, "---   数据异常：ResMarketTab配置数据空 groupId = "..groupId)
    return cfg
end

-- 获取 付费商店组 配置
local _getShopGroupCfgByShopId = function(shopId)
    local cfg = _getShopCfg(shopId)
    cfg = DataTable.ResMarketTab[cfg.tabID]
    assert(cfg, "---   数据异常：ResMarketTab配置数据空 shopId = "..shopId)
    return cfg
end



-- 获取 付费商店组 配置
local _cashMallDB = function()
    ---@type CashMallDB
    local db = GameDB.GetDB(DBId.CashMall)
    return db
end

local tab = {}

-- 商店名字
function tab.GetShopName(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.pageName
end

-- 商店权重
function tab.GetShopWeight(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.pageSort
end

-- 商店组
function tab.GetShopGroupID(shopId)
    local cfg = _getShopGroupCfgByShopId(shopId)
    return cfg.id
end

-- 商店组名字
function tab.GetShopGroupName(groupId)
    local cfg = _getShopGroupCfg(groupId)
    return cfg.marketName
end

-- 商店组权重
function tab.GetShopGroupWeight(groupId)
    local cfg = _getShopGroupCfg(groupId)
    return cfg.marketSort
end

-- 商店是否开启
function tab.IsOpen(shopId)
    local cfg = _getShopCfg(shopId)
    return ActivityHelper.IsOpenActivity(cfg.activityDataID)
end

-- 商店是否开启
function tab.GetCloseTime(shopId)
    local cfg = _getShopCfg(shopId)
    return ActivityHelper.GetActivityCloseTime(cfg.activityDataID)
end

-- 商店模板类型
function tab.GetShopTempType(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.uiShowType
end

-- 商店模板数据ID
function tab.GetShopTempDataID(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.uiShowID
end

-- 商店货物组ID
function tab.GetShopGoodsID(shopId)
    local cfg = _getShopCfg(shopId)
    if cfg.uiShowType == 108 then
        -- 2025.9.9
        -- 任务类型的商店里没有货物，目前没有货物的商店只有这一个类型，暂时这么写，如果出现第二中没有货物的商店，就新加字段用来区分商店类型
        return 0
    else
        return cfg.uiShowID
    end
end

-- 商店背景图
function tab.GetShopBackground(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.bg
end

-- 商店背景图特效
function tab.GetShopBackgroundFx(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.bgEff
end

-- 商店货币组
function tab.GetShopCurrencyList(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.funds
end

-- 商店参数
function tab.GetShopDataParameter(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.DataParameter
end

-- 商店组列表
---@return number[],table<number, number[]> 第一个参数:商城组列表 第二个参数:key=商城组ID,value=商店列表
function tab.GetShopGroupList()
    local db = _cashMallDB()
    return db:GetShopGroupList()
end

-- 获取商店数据
---@return CashShopBase 商店数据
function tab.GetShopData(shopId)
    local db = _cashMallDB()
    return db:GetShopData(shopId)
end

-- 商店绑定活动id
function tab.GetMarketActivityID(shopId)
    local cfg = _getShopCfg(shopId)
    return cfg.activityDataID
end

--商店礼包数据
function tab.GetMarketBundleGroup(shopid)
   local config=DataTable.ResRechargeBundleBundleGroup
   local cfg=config[shopid]
    assert(cfg, "---   数据异常：ResRechargeBundleBundleGroup配置数据空 id = "..shopid)
   return cfg
end

---@return number[] 返回礼包ID组
function tab.GetBundleListByShopId(shopid)
    local shopData = tab.GetShopData(shopid)
    local bundleGroupId = shopData.rechargeActivityID
    local bundleGroupData = tab.GetMarketBundleGroup(bundleGroupId)
    return bundleGroupData.Bundle
end

-- 商店功能是否结束
function tab.IsFuncNotOver(shopId)
    local db = tab.GetShopData(shopId)
    return db:IsFuncNotOver()
end

Util.CashMall = tab
