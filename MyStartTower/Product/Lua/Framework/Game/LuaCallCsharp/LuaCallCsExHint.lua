
local tab = {}

function tab.UpdateRedPoint(key, value)
    if key then
        CS_LuaCallCs.UpdateRedPoint(key, value)
    end
end

function tab.SetDynamicRedPoint(parent, path, idx, value)
    if idx then
        CS_LuaCallCs.SetDynamicRedPoint(parent, path, idx, value)
    end
end

function tab.AddHintData(hintId, statId, layoutId)
    CS_LuaCallCs.AddHintData(hintId, statId, layoutId)
end

function tab.RefactoringHintDataRelation(hintId, parent)
    CS_LuaCallCs.RefactoringHintDataRelation(hintId, parent)
end

function tab.StoreStat()
    CS_LuaCallCs.StoreStat()
end

function tab.ReplaceHintID(parent, path, hintId)
    CS_LuaCallCs.ReplaceHintID(parent, path, hintId)
end


LuaCallCs.Hint = tab
