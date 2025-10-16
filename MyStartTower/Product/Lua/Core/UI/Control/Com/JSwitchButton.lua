


local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

---@class JSwitchButton : UIBaseControl
local JSwitchButton = Class("JSwitchButton", UIBaseControl)
-- 构造函数。
function JSwitchButton:ctor()

end

function JSwitchButton:_getControlType()
    return UIConst.JSwitchButton
end

function JSwitchButton:ClearClickEvent()--清理所有点击事件
    local btn = self:getComObj()
    if btn then
        btn:ClearClickEvent()
    end
end

function JSwitchButton:AddClickEvent(evt)--注册点击事件，一个点击事件对应一个变身模板
    local btn = self:getComObj()
    if btn then
        LuaCallCsUtilCommon.FuncRefByCSharpHandleRegister(btn)
        btn:AddClickEvent(evt)
    end
end

function JSwitchButton:SetSwitchFinishCallback(evt)--变身后的回调方法
    local btn = self:getComObj()
    if btn then
        LuaCallCsUtilCommon.FuncRefByCSharpHandleRegister(btn)
        btn:SetSwitchFinishCallback(evt)
    end
end

function JSwitchButton:InvokeClickEvent()--手动触发button事件，模拟点击了一次按钮
    local btn = self:getComObj()
    if btn then
        btn:InvokeClickEvent()
    end
end

function JSwitchButton:ForceSwitch(idx)--强制切换按钮的变身状态，不触发点击事件, C#侧idx从0开始
    local btn = self:getComObj()
    if btn then
        btn:ForceSwitch(idx)
    end
end

function JSwitchButton:SwitchNext()--切换下一个变身状态，只有非自动变身的情况下，这个接口才有意义
    local btn = self:getComObj()
    if btn then
        btn:SwitchNext()
    end
end

function JSwitchButton:ActiveTemplate(idx, value)--激活或禁用一个变身模板。禁用的变身模板，切换的时候会自动跳过
    local btn = self:getComObj()
    if btn then
        btn:ActiveTemplate(idx, value)
    end
end

return JSwitchButton