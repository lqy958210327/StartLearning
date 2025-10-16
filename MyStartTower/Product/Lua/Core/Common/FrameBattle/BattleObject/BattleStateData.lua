--技能数据获取类

-- @author ZH
-- @date 2016-11-07

local StateData = DataTable.ResBattleState
local BattleStateData = {}
local levelMap = {}


-- 找到最大的小于等级的等级
local function getMaxLevel(level, levelDict)
    for i = level, 1, -1 do
        if levelDict[i] then
            return i
        end
    end
    return nil
end

function BattleStateData.getStateData( stateId, stateLevel )
    local data = StateData[stateId]
    if data then
        local level = stateLevel
        local stateLevelMap = levelMap[stateId]
        if stateLevelMap and stateLevelMap[level] then
            level = stateLevelMap[level]
        elseif not data[level] then
            local maxLevel = getMaxLevel(level, data)
            if maxLevel then
                if stateLevelMap then
                    stateLevelMap[level] = maxLevel
                else
                    levelMap[stateId] = {}
                    levelMap[stateId][level] = maxLevel
                end
                level = maxLevel
            end
        end
        return data[level] or {}
    else
        logerror("BattleState not has:"..stateId)
    end
    return {}
end

return BattleStateData

