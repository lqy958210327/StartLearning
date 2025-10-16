

---@class UITempPvpGrade
UITempPvpGrade = Class("UITempPvpGrade")
function UITempPvpGrade:_setData(obj, grade, moduleId)
    local name = ""
    local icon = ""
    local cfg = DataTable.ResRankData[grade]
    if cfg then
        name = cfg.rank
        icon = cfg.rankIcon
    else
        print("---   pvp段位配置不存在，段位 = "..grade)
    end

    self._obj = obj
    LuaCallCs.UI.UGUISetTextMeshPro(self._obj, "txt_DanName", name)
    LuaCallCs.UI.UGUISetRawImage(self._obj, "raw_DanIcon", icon, moduleId)
end

-----------------------外部可见的接口和结构体--------------------------

local tab = {}

---@param obj GameObject
---@param grade number 段位(不是积分)，必填
---@param moduleId number 模块ID，如果不填，无法精准卸载RawImage资源
---@return UITempPvpGrade
function tab.SetData(obj, grade, moduleId)
    local temp = UITempPvpGrade()
    temp:_setData(obj, grade, moduleId)
    return temp
end

UITemp.PVPGrade = tab