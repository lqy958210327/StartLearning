local tab = {}

---@type fun(uniqueTag:number) 取消延迟操作。
---@param uniqueTag number 操作的唯一标识。
function tab.ModelBindAnimator(modelGo, animator)
    CS_LuaCallCs.ModelBindAnimator(modelGo, animator)
end


LuaCallCs.Battle = tab