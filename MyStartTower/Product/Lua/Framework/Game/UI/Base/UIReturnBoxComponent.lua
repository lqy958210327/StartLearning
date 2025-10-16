


---@class UIReturnBoxComponent 通用返回按钮
UIReturnBoxComponent = Class("UIReturnBoxComponent")

function UIReturnBoxComponent:Init(obj, uiName, name, tipId)
    self._root = obj
    self._uiName = uiName
    self._tipId = tipId
    self._customEvent = nil

    LuaCallCs.UI.SetJButton(obj, "btn_Return", function() self:__onClickBtnClose() end)
    LuaCallCs.UI.SetJButton(obj, "btn_Tips", function() self:__onClickBtnTips() end)
    LuaCallCs.UI.UGUISetTextMeshPro(obj, "txt_title", name)
end

function UIReturnBoxComponent:ResetReturnEvent(func)
    self._customEvent = func
end

function UIReturnBoxComponent:ResetName(name)
    LuaCallCs.UI.UGUISetTextMeshPro(self._root, "txt_title", name)
end

function UIReturnBoxComponent:ResetTipID(tipId)
    self._tipId = tipId
end

function UIReturnBoxComponent:SetShow(value)
    LuaCallCs.GameObjectActive(self._root, value)
end

function UIReturnBoxComponent:__onClickBtnClose()
    if self._customEvent then
        self._customEvent()
    else
        UIManager.InterfaceCloseUI(self._uiName)
    end
end

function UIReturnBoxComponent:__onClickBtnTips()
    if self._tipId then
        UIJump.ToOpenInfoNotice(self._tipId)
    end
end

