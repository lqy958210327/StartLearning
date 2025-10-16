-- Panel类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

local strClassName = "Panel"


---@class Panel : UIBaseControl
local Panel = Class(strClassName, UIBaseControl)

local Vector3 = Vector3


-- 构造函数。
function Panel:ctor(parent, path)
    self.mIsScaleHide = false
end

function Panel:setRectSize(width, height)
    if not width or not height then
        return 
    end
    local obj = self:getComObj()
    if obj ~= nil then
        obj.transform.sizeDelta = UnityEngine.Vector2(width, height)
    end
end

function Panel:getRectSize()
    local obj = self:getComObj()
    if obj ~= nil then
        local size = obj.transform.sizeDelta
        return {width = size.x, height = size.y}
    end
end

function Panel:setHeight(height)
    local rectData = self:getRectSize()
    rectData.height = height
    self:setRectSize(rectData.width, rectData.height)
end

function Panel:setlocalPosition(x, y)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.transform.localPosition=Vector3(x, y, 0)
    end
end
return Panel

