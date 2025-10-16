-- Label类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")


local UIConst = UIConst

local strClassName = "Label"


---@class Label : UIBaseControl
local Label = Class(strClassName, UIBaseControl)

-- 构造函数。
function Label:ctor(parent, path, canEmoji)
end

function Label:_getControlType()
    return UIConst.ControlTypeText
end

function Label:setText(v, needJump)
    if needJump then

    else
        if  type(v) == "number" then

        else

            local obj = self:getComObj()
            if obj ~= nil then
                obj.text = v
                -- dev版本和编辑器检查文本
                if not IS_PUBLISH_VERSION or IS_EDITOR then
                   Framework.Tools.LuaToolkit.CheckText(obj)
                end      
            end
        end
    end

    return self
end



function Label:setFontColor(color)
    self:setObjColor(color)
end



function Label:getWidth()
    local obj = self:getComObj()
    if obj ~= nil then
        return obj.preferredWidth
    else
        return 0
    end
end

function Label:getHeight()
    local obj = self:getComObj()
    if obj ~= nil then
        return obj.preferredHeight
    else
        return 0
    end
end

function Label:SetColorHex(hex)
    if hex == nil then
        return
    end
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():SetObjectColor(obj, hex)
    end
end



return Label

