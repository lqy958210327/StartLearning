
local tab={}

---获取热门英雄展示列表
---@param  recommendId 热门英雄表ID

function tab.GetRecommendedSpeByID (recommendId)
   local cfg = DataTable.ResRecommendLineupData[recommendId]
   if nil==cfg then
        LuaCallCsUtilCommon.ThrowException("推荐英雄表ResRecommendLineup配置错误，找不到id：截图给策划      "..recommendId)
        return nil
   end
   return cfg.recommended_spe
end

---获取热门英雄Tips展示列表
---@param recommendId number 热门英雄表ID
function tab.RecommendedLineUpByID (recommendId)
   local cfg = DataTable.ResRecommendLineupData[recommendId]
   if nil==cfg then
        LuaCallCsUtilCommon.ThrowException("推荐英雄表ResRecommendLineup配置错误，找不到id：截图给策划      "..recommendId)
        return nil
   end
   local recommended={}
   for i = 1, 3 do
        table.insert(recommended,cfg["recommended_lineup_"..i])
   end
   return recommended
end
Util.HotHero = tab