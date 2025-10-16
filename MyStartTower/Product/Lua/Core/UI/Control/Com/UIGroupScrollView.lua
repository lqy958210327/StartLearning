-- UIGroupScrollView类的定义
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")
local UIConst = UIConst
local className = "UIGroupScrollView"

---@class UIGroupScrollView : UIBaseControl 自定义toggleGroup组件
local UIGroupScrollView = Class(className, UIBaseControl)

---@type fun(self:UIGroupScrollView, parent:string, path:string) 构造函数
function UIGroupScrollView:ctor(parent, path)

end


---@type fun( self:UIGroupScrollView, capacity: number[] )
---@param capacity number[] 容量 List<int>类型
---设置容量
function UIGroupScrollView:WithCapacity(capacity)
    local o = self:getComObj()
    if o ~= nil then
        o:WithCapacity(capacity)
    end
end

-- Action<GameObject, int, int> callback
---@type fun( self:UIGroupScrollView, callback: fun(go:userdata, groupIndex:number, dataIndex:number) )
---@param callback fun(go:userdata, groupIndex:number, dataIndex:number) 数据改变时回调
---设置数据调整后的回调
function UIGroupScrollView:WithDataChangeCallBack(callback)
    local o = self:getComObj()
    if o ~= nil then
        LuaCallCsUtilCommon.FuncRefByCSharpHandleRegister(o)
        o:WithDataChangeCallBack(callback)
    end
end

---@type fun( self:UIGroupScrollView )
---强制刷新数据
function UIGroupScrollView:ForceUpdateGridData()
    local o = self:getComObj()
    if o ~= nil then
        o:ForceUpdateGridData()
    end
end

function UIGroupScrollView:_getControlType()
    return UIConst.UIGroupScrollView
end

function UIGroupScrollView:ScrollToTitle(titleIndex)
    local o = self:getComObj()
    if o ~= nil then
        o:ScrollToTitle(titleIndex)
    end
end

---@type fun(self:UIGroupScrollView) 移动到顶
function UIGroupScrollView:MoveToStart()
    local o = self:getComObj()
    if o ~= nil then
        o:MoveToStart()
    end
end

return UIGroupScrollView