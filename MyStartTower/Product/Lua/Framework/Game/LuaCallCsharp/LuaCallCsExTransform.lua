


local tab = {}

function tab.SetPosition(obj, x, y, z)
    CS_LuaCallCs.TransformSetPosition(obj, x, y, z)
end

function tab.SetLocalPosition(obj, x, y, z)
    CS_LuaCallCs.TransformSetLocalPosition(obj, x, y, z)
end
function tab.SetScale(obj, x, y, z)
    CS_LuaCallCs.TransformSetScale(obj, x, y, z)
end
function tab.SetRotation(obj, x, y, z)
    CS_LuaCallCs.TransformSetRotation(obj, x, y, z)
end
function tab.SetLocalRotation(obj, x, y, z)
    CS_LuaCallCs.TransformSetLocalRotation(obj, x, y, z)
end
function tab.SetEulerAngles(obj, x, y, z)
    CS_LuaCallCs.TransformSetEulerAngles(obj, x, y, z)
end
function tab.SetLocalEulerAngles(obj, x, y, z)
    CS_LuaCallCs.TransformSetLocalEulerAngles(obj, x, y, z)
end

function tab.GetPosition(obj)
    local x, y, z = 0
    x, y, z = CS_LuaCallCs.GetPosition(obj, x, y, z)
    return x, y, z
end

function tab.GetLocalPosition(obj)
    local x, y, z = 0
    x, y, z = CS_LuaCallCs.GetLocalPosition(obj, x, y, z)
    return x, y, z
end

function tab.GetScale(obj)
    local x, y, z = 0
    x, y, z = CS_LuaCallCs.GetScale(obj, x, y, z)
    return x, y, z
end

function tab.GetRotation(obj)
    local x, y, z, w = 0
    x, y, z, w = CS_LuaCallCs.GetRotation(obj, x, y, z, w)
    return x, y, z, w
end

function tab.SetDicePlayToGameObject(obj, path, idx)
    CS_LuaCallCs.SetDicePlayToGameObject(obj, path, idx)
end

function tab.SetDiceGoToGameObject(obj, path, idx)
    CS_LuaCallCs.SetDiceGoToGameObject(obj, path, idx)
end

LuaCallCs.Transform = tab
