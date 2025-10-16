


local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

---@class JButton : UIBaseControl
local JButton = Class("JButton", UIBaseControl)
-- 构造函数。
function JButton:ctor()

end

function JButton:_getControlType()
    return UIConst.JButton
end

function JButton:AddClickEvent(evt, p1, p2)
    local btn = self:getComObj()
    if btn then
        LuaCallCsUtilCommon.FuncRefByCSharpHandleRegister(btn)
        LuaCallCsUtilCommon.JButtonAddClickEvent(btn, evt, p1, p2)
    end
end

function JButton:SetBtnLabel( str )
    local btn = self:getComObj()
    if btn then
        btn:SetBtnLabel(str)
    end
end





function JButton:InvokeClickEvent()
    local btn = self:getComObj()
    if btn then
        --btn:InvokeClickEvent()
        LuaCallCs.UI.JButtonInvokeClickEvent(btn)
    end
end

function JButton:OnToggle(value)
    local btn = self:getComObj()
    if btn then
        --btn:OnToggle(value)
        LuaCallCs.UI.JButtonOnToggle(btn, value)
    end
end

function JButton:OnButtonDisable(isDisable)
    local btn = self:getComObj()
    if btn then
        LuaCallCs.UI.JButtonOnDisable(btn, isDisable)
    end
end

function JButton:BreakHold()
    local btn = self:getComObj()
    if btn then
        LuaCallCs.UI.JButtonBreakHold(btn)
    end
end

return JButton
