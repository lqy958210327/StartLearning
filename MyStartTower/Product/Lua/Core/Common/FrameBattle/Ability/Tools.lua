


local SkillParamData = require("Config/DataTable/ResSkillParamData")

local Tools = {}

function Tools.getSkillParam(self, id, param, level)

    if SkillParamData[id][param].is_float ~= nil and SkillParamData[id][param].is_float ~= 0 then 
        if level == 1 then
            return tonumber(SkillParamData[id][param].level_1_float) or 0
        elseif level == 2 then
            return tonumber(SkillParamData[id][param].level_2_float) or 0
        elseif level == 3 then
            return tonumber(SkillParamData[id][param].level_3_float) or 0
        elseif level == 4 then
            return tonumber( SkillParamData[id][param].level_4_float) or 0
        else 
            return 0
        end
    else
        if level == 1 then
            return SkillParamData[id][param].level_1 or 0
        elseif level == 2 then
            return SkillParamData[id][param].level_2 or 0
        elseif level == 3 then
            return SkillParamData[id][param].level_3 or 0
        elseif level == 4 then
            return SkillParamData[id][param].level_4 or 0
        else 
            return 0
        end
    end

    return 0
end

function Tools.isInList(item, list)
    for _, value in pairs(list) do
        if value == item then
            return true
        end
    end
    return false
end

return Tools