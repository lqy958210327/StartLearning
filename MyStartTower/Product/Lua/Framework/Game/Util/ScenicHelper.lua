
---@enum ScenicTypeEnum 场景类型枚举
ScenicTypeEnum = {
    HeroDisplay = 1, --英雄展示
    HeroStarUp = 2, --英雄升星
    BattleSettlement = 3, -- 战斗结算
}


local tab = {}

---@type fun(scenicType: number, modelTag: number) 加载场景
---@param scenicType number 场景类型
---@param modelTag number 模型id
function tab.Load(scenicType, modelTag)
    --EventManager.Global.Dispatch(EventType.ScenicLoad, scenicType, modelTag)
    EventManager.Global.Dispatch(EventType.ScenicSwitch, scenicType, modelTag)
end

---@type fun() 卸载场景
function tab.UnLoad()
    --EventManager.Global.Dispatch(EventType.ScenicUnLoad)
    EventManager.Global.Dispatch(EventType.ScenicRelease)
end

---@type fun() 启用场景模型
function tab.EnableModel()
    EventManager.Global.Dispatch(EventType.ScenicActorEnable, true)
end

---@type fun() 禁用场景模型
function tab.DisableModel()
    EventManager.Global.Dispatch(EventType.ScenicActorEnable, false)
end

---@type fun(heroTag: number) 显示英雄
function tab.LoadHero(heroTag)
    ---TODO: 找策划，改ResScenicData配置 转换数据信息
    local modelTag = ModelUtils.getHeroShowModelId(heroTag)
    local scenicType = ModelUtils.GetModelScenicTag(modelTag)
    tab.Load(scenicType, modelTag)
end


function tab.GetScenicConfig(scenicType)
    local scenicCfg = DataTable.ResScenicData[scenicType]
    if scenicCfg == nil then
        logerror("Scenic Config is NUll: ", scenicType)
        return nil
    end
    return scenicCfg
end


function tab.GetModlePathConfig(showId)

    local cfg = tab.GetModelConfig(showId)
    if cfg == nil then
        return "", ""
    end

    local showModleId = cfg.show_hero.id
    local  commonModel =  DataTable.ResCommonModel[showModleId]
    if not commonModel then
        logerror("ResCommonModel Show Data is NUll: ", showModleId)
        return
    end

    return  commonModel
end

local _scenicType = -1
local _cacheSceicRoleActionAnim = {}

function tab.GetScenicTypeCacheAnim(anim)
    return  _cacheSceicRoleActionAnim[anim]
end

function tab.SetScenicTypeCacheAnim(anim)
    _cacheSceicRoleActionAnim[anim] = 1
end

function tab.ClearScenicCacheAnim()
    _scenicType  = -1
    _cacheSceicRoleActionAnim ={}
end

function tab.SetScenicType(scenicType)
    if _scenicType ~= scenicType then
        _scenicType = scenicType
        _cacheSceicRoleActionAnim ={}
    end
end



function tab.GetModelConfig(showTag)
    local cfg =  DataTable.ResCommonModel[showTag]
    if cfg == nil then
        logerror("ResCommonModel Show Data is NUll: ", showTag)
        return nil
    end

    return cfg
end


Util.Scenic = tab