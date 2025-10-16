-- Toggle类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

local UIConst = UIConst
local strClassName = "ToggleGroup"
local ToggleGroup = Class(strClassName, UIBaseControl)




-- 构造函数。
function ToggleGroup:ctor(parent, path, textPath)
end

function ToggleGroup:setAllSwitchOff(isOn)
    local obj = self:getComObj()
    if obj ~= nil then
        obj:SetAllSwitchOff(obj,isOn)
    end
end

function ToggleGroup:_getControlType()
    return UIConst.ControlTypeToggleGroup
end


return ToggleGroup

