local tab = {}

---@type fun(anchor: GameObject, data:FloatingWordsData) 显示飘字
---@param anchor GameObject 飘字锚点
---@param data FloatingWordsData 飘字数据
function tab.ShowWord(anchor, data)
    CS_LuaCallCs.ShowWord(anchor, data:GetType(), data:GetIcon(), data:GetCrit(), data:GetWords(), data:GetAnim(), data:GetFontGradientPreset(), data:GetFontMaterial())
end

LuaCallCs.FloatingWords = tab