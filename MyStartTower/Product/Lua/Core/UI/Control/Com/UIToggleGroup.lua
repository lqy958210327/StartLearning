-- UIToggleGroup类的定义
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")
local JButton = require("Core/UI/Control/Com/JButton")
local UIConst = UIConst
local className = "UIToggleGroup"

---@class UIToggleGroup : UIBaseControl 自定义toggleGroup组件
local UIToggleGroup = Class(className, UIBaseControl)


---@type fun(self:UIToggleGroup, parent:string, path:string) 构造函数
function UIToggleGroup:ctor(parent, path)

end


---@type fun(self:UIToggleGroup):number 获取当前激活"toggle"的索引值
function UIToggleGroup:CurrentIndex()
    local o = self:getComObj()
    if o ~= nil then
        return o:CurrentIndex()
    end
    return -1
end

---获取全部"toggle"组件
---@type fun(self:UIToggleGroup): JButton[] | nil 
function UIToggleGroup:Buttons()
    local o = self:getComObj()
    if o ~= nil then
        return o:Buttons()
    end
    return nil
end

---逻辑控制点击按钮，注意index从0开始
---@type fun(self:UIToggleGroup, index:number, force:boolean)
---@param index number Buttons组中任意一个按钮的索引，索引从0开始。
---@param force boolean 重复点击时是否再次刷新。
function UIToggleGroup:SetClick(index, force)
    local o = self:getComObj()
    if o ~= nil then
        o:SetClick(index, force)
    end
end

---只设置toggle状态，不触发点击事件，注意index从0开始
---@type fun(self:UIToggleGroup, index:number, force:boolean)
---@param index number Buttons组中任意一个按钮的索引，索引从0开始。
---@param force boolean 重复点击时是否再次刷新。
function UIToggleGroup:SetUpdate(index, force)
    local o = self:getComObj()
    if o ~= nil then
        o:SetUpdate(index, force)
    end
end

---自定义点击按钮的执行事件。
---Func<int, bool> clickAction 
---参数：按钮点击后会把按钮的索引值作为参数回传。
---返回值：自定义本次点击按钮是否执行成功。如不需判断默认返回true即可。
---@alias clickAction fun(index:number):boolean
---自定义点击数按钮时的执行事件，可以自定义本次点击是否有效。
---@type fun(self:UIToggleGroup, clickAction: clickAction)
---@param clickAction clickAction 自定义点击按钮的执行事件
function UIToggleGroup:WithClickAction(clickAction)
    local o = self:getComObj()
    if o ~= nil then
        LuaCallCsUtilCommon.FuncRefByCSharpHandleRegister(o)
        o:WithClickAction(clickAction)
    end
end

---自定义更新按钮样式事件。
---Action <int> updateAction
---参数：按钮点击且执行事件成功后，会把按钮的索引值作为参数回传。
---@alias updateAction fun(index:number)
---自定义更新按钮样式逻辑
---@type fun(self:UIToggleGroup, updateAction: updateAction)
---@param updateAction updateAction 自定义更新按钮样式事件
function UIToggleGroup:WithUpdateAction(updateAction)
    local o = self:getComObj()
    if o ~= nil then
        LuaCallCsUtilCommon.FuncRefByCSharpHandleRegister(o)
        o:WithUpdateAction(updateAction)
    end
end

---更新按钮样式逻辑还原为默认事件。
---@type fun(self:UIToggleGroup) 
function UIToggleGroup:SetUpdateActionDefault()
    local o = self:getComObj()
    if o ~= nil then
        o:SetUpdateActionDefault()
    end
end

---重置toggle状态
---@type fun(self:UIToggleGroup)
function UIToggleGroup:ResetToggle()
    local o = self:getComObj()
    if o ~= nil then
        o:ResetToggle()
    end
end

function UIToggleGroup:_getControlType()
    return UIConst.UIToggleGroup
end

return UIToggleGroup