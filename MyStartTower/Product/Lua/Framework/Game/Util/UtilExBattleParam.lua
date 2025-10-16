

---@type BattleParam
local __battleParam = function()
    ---@type BBClassBattleParam
    local item = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.BattleParam)
    if item == nil then
        LuaCallCs.ThrowException("---   数据异常：BattleParam为空，无法读取相关数据...")
    end
    return item.BattleParam
end

-- 战斗参数 接口
local tab = {}

---@return string 服务器定义的战斗类型，BattleConst 里的
function tab.IsExist()
    ---@type BBClassBattleParam
    local item = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.BattleParam)
    return item ~= nil
end

---@return string 服务器定义的战斗类型，BattleConst 里的
function tab.GetServerBattleType()
    local param = __battleParam()
    return param.Type
end

---@return string 客户端定义的战斗类型, BattleDefine.ClientBattleType
function tab.GetClientBattleType()
    local param = __battleParam()
    return param.ClientBattleType
end

---@return string 战场配置ID
function tab.GetBattleID()
    local param = __battleParam()
    return param.BattleID
end

---@return string 战斗标题
function tab.GetTitle()
    local param = __battleParam()
    return param.Title
end

---@return string 战斗副标题
function tab.GetSubTitle()
    local param = __battleParam()
    return param.SubTitle
end

---@return number 队伍首选索引，默认是1号
function tab.GetDefaultTeamIdx()
    local param = __battleParam()
    return param.TeamIdx
end

---@return number 置顶英雄的配置ID
function tab.GetTopHeroConfigID()
    local param = __battleParam()
    return param.TopHeroConfigId
end

---@return GuideBattleParam 是否显示布阵引导
function tab.GetGuideParam()
    local param = __battleParam()
    return param.GuideParam
end

---@return BattleParamAutoFight 自动战斗参数
function tab.GetAutoFightParam()
    local param = __battleParam()
    return param.IsAutoFight
end

---@return BattleParamSpecialHeroData 特殊英雄数据
function tab.GetSpecialHeroDataByGid(gid)
    local param = __battleParam()
    if param.SpecialHeroData then
        return param.SpecialHeroData[gid]
    end
    return nil
end

---@return table 服务器需要的数据，客户端不用
function tab.GetServerParam()
    local param = __battleParam()
    return param.ServerParam
end

Util.BattleParam = tab
