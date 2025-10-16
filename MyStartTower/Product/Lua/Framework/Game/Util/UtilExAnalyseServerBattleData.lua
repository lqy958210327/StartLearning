


-- 战斗通用算法

local tab = {}

---@param msg SC_BattleStart
function tab.AnalyseElementBuffID(msg, campIdx, round)
    local abilityList = msg.matrixInit.camp[campIdx].roundModifier[round].ability
    for k, v in pairs(abilityList) do
        if v.type == "state" then
            if true then-- 配置表是否存在 v.resId
                return v.resId
            end
        end
    end
end

Util.AnalyseServerBattleData = tab
