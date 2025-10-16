
---@class GMBtn
local strClassName = "GMBtn"
local GMBtn = Class(strClassName)

-- 构造函数。
function GMBtn:init(obj)
    self._root = obj
    self:initUI()
    self.useChild = false
end

function GMBtn:initUI()
    LuaCallCs.UI.SetJButton(self._root, "sendBtn", function() self:OnSendGMBtn() end)
    LuaCallCs.UI.SetJButton(self._root, "funBtn", function() self:OnFunGMBtn() end)
    LuaCallCs.SetGameObjectActive(self._root, "InputField", false)
end

---@type fun()
---@param uiData GMUIData 
function GMBtn:setting(uiData)
    if uiData.ShowTips then
        LuaCallCs.UI.UGUISetLabel(self._root, "Placeholder", uiData.ShowTips)
    end
    LuaCallCs.UI.UGUISetTextMeshPro(self._root, "funName", uiData.Name)
    --LuaCallCs.SetGameObjectActive(self._root, "InputField", uiData.Type == GMBtnEmun.BTN_TYPE_INPUT)
    self.gmFun = uiData.FUN
    self.uiType = uiData.Type
end

function GMBtn:OnFunGMBtn() 
    if self.uiType ~= GMBtnEmun.BTN_TYPE_INPUT then
        self.gmFun(gmStr)
    else
        local isShow = LuaCallCs.GetGameObjectActive(self._root, "InputField")
        LuaCallCs.SetGameObjectActive(self._root, "InputField", not isShow)
    end
end

function GMBtn:OnSendGMBtn(sender)
    local gmStr = LuaCallCs.UI.UGUIInputFieldGetValue(self._root, "InputField")
    self.gmFun(gmStr)
end

return GMBtn