


---@class Util
Util = {}

Util.Log = function(log)
    print("---   Util说明：去看require_list里注释")
end

---@return table 返回的数据结构是数组，每个数据的结构是{图集名，图片名}
Util.CalculateHeroStarSprite = function(star)
    local result = {}

    local curStar = star -- 取得当前实体的品质
    local formStar = curStar < 6 and 0 or 5
    for i = 1, 5 do
        local starLv = formStar + i
        local starState = StarLvState.Active  
        if starLv > curStar then
            starState = StarLvState.UnActive
        end

        local altas, image = CommonHelper.GetStarImage(starLv, starState)
        table.insert(result, { altas, image }) ---@type table[]
    end

    -- CommonHelper.GetStarImage()

    -- local starDark = "hero_card_star_0"
    -- local starLight = "hero_card_star_1"
    -- if star > 5 then
    --     starDark = "hero_card_star_2"
    --     starLight = "hero_card_star_1"
    -- end
    -- local mod = star
    -- if star > 5 then mod = star - 5 end
    -- for i = 1, 5 do
    --     if mod == 0 then
    --         table.insert(result, { "atlas_Public", starDark })
    --     elseif i <= mod then
    --         table.insert(result, { "atlas_Public", starLight })
    --     else
    --         table.insert(result, { "atlas_Public", starDark })
    --     end
    -- end
    return result
end

Util.UnityOpenUrl = function(webUrl)
    print("---   打开外部链接，老代码，没测试过")

    local WebView = require("Core/SDK/Plugin/WebView")
    if not webUrl then
        return
    end
    WebView.unityOpenUrl(webUrl)

    --WebView.openWebView(webUrl, nil, string.find(webUrl, "?"))
end

---检查searchStr是否能完全匹配targetStr的一部分
---@param searchStr string 要搜索的字符串
---@param targetStr string 被搜索的目标字符串
---@return boolean 如果searchStr是targetStr的子串则返回true，否则返回false
Util.StringContains = function(searchStr, targetStr)
    return string.find(targetStr, searchStr, 1, true) ~= nil
end


---
Util.MergeAndSumTables = function(inputTable)
    local result = {}
    for _, item in ipairs(inputTable) do
        local ids = item[1]    -- 假设第一个元素是ID表，如{10000, 10002}
        local quantities = item[2] -- 假设第二个元素是数量表，如{1, 10}
        -- 确保ID和数量数量一致
        if #ids == #quantities then
            for i, id in ipairs(ids) do
                local quantity = quantities[i]
                -- 检查结果表中是否已有该ID
                local found = false
                for _, resultItem in ipairs(result) do
                    if resultItem[1] == id then
                        -- 如果存在，则累加数量
                        resultItem[2] = resultItem[2] + quantity
                        found = true
                        break
                    end
                end
                -- 如果不存在，则添加新条目
                if not found then
                    table.insert(result, {id, quantity})
                end
            end
        end
    end

    return result
end