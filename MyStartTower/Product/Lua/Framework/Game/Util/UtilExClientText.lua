


-- 客户端读取配置文本

local tab = {}

function tab.GetText(id)
    assert(id, "---   Util.ClientText(id)  id = nil")
    assert(type(id) == "number", "---   Util.ClientText(id), id必须是number类型!  id = "..tostring(id))
    local cfg = DataTable.ResClientTextReveal[id]
    if cfg and cfg.content then
        return cfg.content
    end
    return "ClientTextReveal未配置文本:"..id
end

Util.ClientText = tab
