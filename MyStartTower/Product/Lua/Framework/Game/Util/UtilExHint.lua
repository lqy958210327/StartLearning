


-- 简化接口:红点系统
local tab = {}

--刷新静态红点
function tab.UpdateRedPoint(key, value)
    LuaCallCs.Hint.UpdateRedPoint(key, value)
end

--刷新动态红点
function tab.SetDynamicRedPoint(parent, path, idx, value)
    LuaCallCs.Hint.SetDynamicRedPoint(parent, path, idx, value)
end

-- 向HintSystem里动态添加HintData
function tab.AddHintData(hintId, statId, layoutId)
    LuaCallCs.Hint.AddHintData(hintId, statId, layoutId)
end

-- 重新构建HintData的树形关系
function tab.RefactoringHintDataRelation(hintId, parent)
    LuaCallCs.Hint.RefactoringHintDataRelation(hintId, parent)
end

-- 保存统计数据
function tab.StoreStat()
    LuaCallCs.Hint.StoreStat()
end

-- 修改HintBehaviour的HintID
function tab.ReplaceHintID(parent, path, hintId)
    LuaCallCs.Hint.ReplaceHintID(parent, path, hintId)
end

Util.RedPoint = tab
