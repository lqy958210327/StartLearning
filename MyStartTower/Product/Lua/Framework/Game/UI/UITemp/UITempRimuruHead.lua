

local __analyseDetailParam = function(id, moduleId)
    local param = UITempRimuruHeadDetailParam()
    param.ConfigID = id
    param.ModuleId = moduleId
    param.Icon = RimuruHelper.GetStoneTreeHeadIcon(id)
    return param
end

---@class UITempRimuruHead
UITempRimuruHead = Class("UITempRimuruHead")
function UITempRimuruHead:_setData(obj, param)
    self._obj = obj ---@type GameObject
    self._param = param ---@type UITempRimuruHeadDetailParam

    local isEmpty = not (self._param.ConfigID > 0)
    LuaCallCs.SetGameObjectActive(self._obj, "Embty", isEmpty)
    if not isEmpty then
        LuaCallCs.UI.UGUISetRawImage(self._obj, "img_Head", self._param.Icon, self._param.ModuleId)
    end
    LuaCallCs.UI.SetJButton(self._obj, "btn",function()

    end)
end

-----------------------外部可见的接口和结构体--------------------------

---@class UITempRimuruHeadDetailParam
UITempRimuruHeadDetailParam = Class("UITempRimuruHeadDetailParam")
function UITempRimuruHeadDetailParam:ctor()
    self.ConfigID = nil -- 配置id
    self.Icon = nil -- 头像
    self.ModuleId = nil -- 模块ID
end

local tab = {}

---@param obj GameObject
---@param cfgId number rimuruID，必填
---@param moduleId number 模块ID，如果不填，无法精准卸载RawImage资源
---@return UITempRimuruHead
function tab.SetDataByConfigID(obj, cfgId, moduleId)
    local param = __analyseDetailParam(cfgId, moduleId)
    local temp = UITempRimuruHead()
    temp:_setData(obj, param)
    return temp
end

UITemp.RimuruHead = tab