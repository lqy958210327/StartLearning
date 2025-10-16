

--在object身上get一个component

local tab = {}


function tab.GetComponentJButton(obj)
    return CS_LuaCallCs.GetComponentJButton(obj)
end

function tab.GetComponentJSwitchButton(obj)
    return CS_LuaCallCs.GetComponentJSwitchButton(obj)
end

function tab.GetModelAux(obj)
    return CS_LuaCallCs.GetModelAux(obj)
end

LuaCallCs.GetComponent = tab
