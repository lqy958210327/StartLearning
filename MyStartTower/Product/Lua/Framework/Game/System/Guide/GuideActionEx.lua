


---@class GuideActionEx
GuideActionEx = {}

-- 布阵UI，指引英雄上阵
local __formationUpHero = function(actionParam)
    local str = string.split(actionParam, ',')
    local heroId = tonumber(str[1])
    local pos = tonumber(str[2])
    WarHelper.EnterBattleStage(Util.Account.PlayerMainStory(), heroId, GuideBattleParam(pos))
end

-- 布阵UI，指引英雄换位
local __formationChangePos = function(actionParam)
    local str = string.split(actionParam, ',')
    local heroId = tonumber(str[1])
    local pos = tonumber(str[2])
    WarHelper.EnterBattleStage(Util.Account.PlayerMainStory(), heroId, GuideBattleParam(nil, pos))
end

-- 打开英雄界面(英雄列表)，定位目标青雄
local __ToJumpUIHero = function(actionParam)
    local heroTag = tonumber(actionParam)
    local heroEntity = HeroHelper.GetEntityByHeroTag(heroTag)
    if heroEntity == nil then
        MsgManager.notice(__"错误~! 未找到英雄数据")
        return
    end
    UIJump.ToOpenUIHero(heroEntity.gid, UIHeroMenuBarEnum.Prop)
end


-- 战斗暂停、战斗取消暂停
local __battlePause = function(actionParam)
    local isPause = actionParam == "1"
    Util.Battle.BattlePause(isPause)
end

-- 英雄等级连升
local __heroQuickLvUp = function(actionParam)
    local str = string.split(actionParam, ',')
    local heroTag = tonumber(str[1])
    local addLv = tonumber(str[2])

    local entity = HeroHelper.GetEntityByHeroTag(heroTag)
    if entity == nil then
        MsgManager.notice(__"错误~! 未找到英雄数据")
        return
    end

    local lv, state = HeroHelper.GetHeroLevel(entity);
    if state == CorridorEnum.Resonance then
        MsgManager.notice(__"错误~! 该英雄为共鸣者，无法手动升级")
        return
    end

    if lv >= HeroHelper.LEVEL_MAX then --等级封顶
        return
    end

    if lv + addLv > HeroHelper.LEVEL_MAX then --等级封顶
        addLv = HeroHelper.LEVEL_MAX - lv
    end

    local canAddLv = 0
    local allCosts = {}
    for i = 1, addLv do
        local nextLv = lv + i
        local costs = HeroHelper.GetHeroLvCostData(heroTag, nextLv)
        if costs == nil then
            MsgManager.notice(__"错误~! 升级配置获取错误")
            break
        end
        allCosts = CostData.MergeCost(allCosts, costs)
        local hasEnoughCost = true
        for i = 1, #allCosts do
            local costData = allCosts[i]
            local costTag = costData:GetTag()
            local hasNum = ItemHelper.GetItemCount(costTag)
            if hasNum < costData:GetNum() then
                hasEnoughCost = false
                logerror("---   英雄第"..lv + i.."级，升级资源不足, costTag = "..costTag..", needNum = "..costData:GetNum()..", hasNum = "..hasNum)
                break
            end
        end

        if not hasEnoughCost then
            break
        end
        canAddLv = i
    end

    if canAddLv > 0 then
        SendHandlers.ReqHeroLvUp(entity.gid, lv + canAddLv)
    end
end



local __findButtonHeroAtFightingByHeroId = function(actionParam)
    local configId = tonumber(actionParam)
    ---@type UIFightingDB
    local db = GameDB.GetDB(DBId.Fighting)
    return db:FindHeroBtnObjByConfigID(configId)
end

local __findGameObjectAtUIByStaticPath = function(actionParam)
    if actionParam then
        local str = string.split(actionParam, ',')
        local ui = str[1] and tonumber(str[1]) or nil
        local path = str[2]
        local uiName = Util.FindUI.UIIDToName(ui)
        if path and uiName then
            local target = UIManager.InterfaceFindObjectInWindow(uiName, path)
            return target
        end
        LuaCallCs.LogError("---   新手引导报错: 无法在UI里找到指定路径的GameObject, findTypeParam = "..actionParam)
    else
        LuaCallCs.LogError("---   新手引导报错: 无法在UI里找到指定路径的GameObject, findTypeParam = nil")
    end
    return nil
end

function GuideActionEx.DoAction(actionId, actionParam)
    if actionId == nil then
        LuaCallCs.LogError("---   新手引导警告：执行扩展action失败, actionId = nil, 无效操作")
        return
    end
    if actionId == 1 then
        __formationUpHero(actionParam)
    elseif actionId == 2 then
        __formationChangePos(actionParam)
    elseif actionId == 3 then
        __ToJumpUIHero(actionParam)
    elseif actionId == 4 then
        __battlePause(actionParam)
    elseif actionId == 5 then
        __heroQuickLvUp(actionParam)
    elseif actionId == 100 then
        return __findGameObjectAtUIByStaticPath(actionParam)
    elseif actionId == 101 then
        return __findButtonHeroAtFightingByHeroId(actionParam)
    else
        LuaCallCs.LogError("---   新手引导报错：执行扩展action报错, 未知的actionId = "..actionId)
    end
end