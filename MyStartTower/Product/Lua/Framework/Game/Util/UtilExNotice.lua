


-- 飘字

local tab = {}

function tab.Show(text)
    MsgManager.notice(text)
end

function tab.ShowByID(id)
    local cfg = DataTable.ResClientNotice[id]
    local text = ""
    if cfg then
        text = cfg.notice or ""
    end
    Util.Notice.Show(text)
end

function tab.GetText(id)
    local cfg = DataTable.ResClientNotice[id]
    if cfg and cfg.notice then
        return cfg.notice
    end
    return "ClientNotice未配置文本:"..id
end

Util.Notice = tab
