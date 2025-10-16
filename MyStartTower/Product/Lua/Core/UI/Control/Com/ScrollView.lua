-- ScrollView类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")
local Vector2 = Vector2

local RectTransform = typeof(UnityEngine.RectTransform)

local UIConst = UIConst
local strClassName = "ScrollView"
---@class ScrollView : UIBaseControl
local ScrollView = Class(strClassName, UIBaseControl)

--ScrollRect
--[[ScrollRect-attribute
ScrollRect.content = Scroll View/Viewport/Content
ScrollRect.verticalScrollbar = Scroll View/Scrollbar Vertical(Scrollbar)
ScrollRect.horizontalScrollbar =Scroll View/Scrollbar Horizontal(Scrollbar)
-child
Scroll View/Viewport/Content
Scroll View/Scrollbar Horizontal(Scrollbar)
Scroll View/Scrollbar Vertical(Scrollbar)
]]

-- 构造函数。
function ScrollView:ctor(parent, path)

end

function ScrollView:_getControlType()
    return UIConst.ControlTypeScrollRect
end

function ScrollView:setContentSize(width, height)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.content.sizeDelta = Vector2(width, height)
    end
end

function ScrollView:getContentSize()
    local obj = self:getComObj()
    if obj ~= nil then
        return {obj.content.sizeDelta.x,obj.content.sizeDelta.y}
    end
end



function ScrollView:setScrollEnable(enable)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.enabled = enable
    end
end





function ScrollView:getVerticalValue()
    local obj = self:getComObj()
    if obj ~= nil then
        return obj.verticalScrollbar.value
    end
    return -1
end



--滚动控件是否启动滚动功能（显示/遮罩尺寸小于实际尺寸）
function ScrollView:isScroll()
    local obj = self:getComObj()
    if obj ~= nil then
        local tran = obj.transform
        local content = obj.content
        return (obj.horizontal and tran.sizeDelta.x < content.sizeDelta.x) or
            (obj.vertical and tran.sizeDelta.y < content.sizeDelta.y)
    end
end










function ScrollView:setContentY(y)
    local obj = self:getComObj()
    local curPos = obj.content.anchoredPosition 
    curPos.y = y
    obj.content.anchoredPosition = curPos
end

function ScrollView:setContentX(x)
    local obj = self:getComObj()
    local curPos = obj.content.anchoredPosition 
    curPos.x = x
    obj.content.anchoredPosition = curPos
end










return ScrollView

