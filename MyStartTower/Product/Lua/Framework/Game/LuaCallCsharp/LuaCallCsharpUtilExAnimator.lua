local tab = {}

---@type fun(go, stateName, layer, completed) 播放动画片段，后执行回调
---@param go GameObject 有Animator组件的GameObject
---@param stateName string 动画状态名
---@param layer number 动画层级
---@param completed function|nil 动画播放完成回调
---@return void
function tab.Play(go, stateName, layer, completed)
    CS_LuaCallCs.Play(go, stateName, layer, completed)
end

---@type fun(go, stateName, layer) 动画是否播放完成
---@param go GameObject 有Animator组件的GameObject
---@param stateName string 动画状态名
---@param layer number 动画层级
function tab.IsAnimComplete(go, stateName, layer)
    return CS_LuaCallCs.IsAnimComplete(go, stateName, layer)
end


---@type fun(go, stateName, layer) 判断当前Animator是否有制定状态片段
---@param go GameObject 有Animator组件的GameObject
---@param stateName string 动画状态名
---@param layer number 动画层级
function tab.HasState(go, stateName, layer)
    return CS_LuaCallCs.HasState(go, stateName, layer)
end

---@type fun(go) 恢复Animator的播放
---@param go GameObject 有Animator组件的GameObject
function tab.Resume(go)
    CS_LuaCallCs.Resume(go)
end

---@type fun(go) 停止Animator的播放
---@param go GameObject 有Animator组件的GameObject
function tab.Pause(go)
    CS_LuaCallCs.Pause(go)
end

LuaCallCs.Animator = tab