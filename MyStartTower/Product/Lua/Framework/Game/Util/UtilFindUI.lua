
-- 简化接口:查询UI接口

local tab = {}

---@type fun(_uiID:string) 根据UIID查询UIName
---@return number uiID 返回UIID
function tab.UIIDToName(_uiID)
    if _uiID == nil then
        LuaCallCs.LogError("查找UIID接口不能填空值！")
        return 
    end
    ---@type UIDB
    local db = GameDB.GetDB(DBId.UIData)
    
    local uiDataList = db:GetUIDataList()
    for i, uiData in pairs(uiDataList) do
        if uiData.uiID == _uiID then
            return uiData.uiName
        end
    end
    --LuaCallCs.LogError("Not Find UIName:".._uiID)
    return nil
end

---@type fun(_uiName:string) 根据UI名字查询UIID
---@return string uiname 返回UIname

function tab.UINameToID(_uiName)
    if _uiName == nil then
        LuaCallCs.LogError("查找UIID接口不能填空值！")
        return 
    end
    ---@type UIDB
    local db = GameDB.GetDB(DBId.UIData)
    
    local uiDataList = db:GetUIDataList()
    for i, uiData in pairs(uiDataList) do
        if uiData.uiName == _uiName then
            return uiData.uiID
        end
    end
    --LuaCallCs.LogError("Not Find UIName:".._uiName)
    return 0
end

---@type function() 根据UI名字，获取货币栏列表
---@return number[] 货币栏列表
function tab.GetUICurrencyList(_uiName)
    local uiID = Util.FindUI.UINameToID(_uiName)
    local uiCfg = DataTable.ResMusic[uiID]
    local list = {}
    if uiCfg then
        list = uiCfg.currency
    end
    return list
end

---@type function() 根据UI名字，获取UI名字
---@return string UI名字
function tab.GetUIName(_uiName)
    local uiID = Util.FindUI.UINameToID(_uiName)
    local uiCfg = DataTable.ResMusic[uiID]
    if uiCfg then
        return uiCfg.name
    end
    return ""
end

---@type function() 根据UI名字，获取tipsID
---@return number tipsID
function tab.GetTipsID(_uiName)
    local uiID = Util.FindUI.UINameToID(_uiName)
    local uiCfg = DataTable.ResMusic[uiID]
    if uiCfg then
        return uiCfg.tipsId
    end
    return 0
end



Util.FindUI = tab