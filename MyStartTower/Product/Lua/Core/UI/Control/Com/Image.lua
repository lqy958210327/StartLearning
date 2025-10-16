-- Image类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

local UIConst = UIConst
local strClassName = "Image"

---@class Image : UIBaseControl
local Image = Class(strClassName, UIBaseControl)



-- 构造函数。
function Image:ctor(parent, path)
    self.isGray = false
end

function Image:_getControlType()
    return UIConst.ControlTypeImage
end

function Image:setNativeSize()
    local obj = self:getComObj()
    if obj ~= nil then
        obj:SetNativeSize()
    end
end


function Image:setImage(filePath, spriteName)
    local obj = self:getGameObject()
    if obj ~= nil then

        LuaCallCs.UI.UGUISetImageSync(obj, obj.name, filePath, spriteName)
        self:setVisible(true)
    end
end


function Image:fillAmount(value)
    local obj = self:getGameObject()
    if obj ~= nil then
        LuaCallCs.UI.UGUISetImageFillAmount(obj, obj.name, value)
    end
end

function Image:setImageGray(isGray)
    local obj = self:getComObj()
    if obj ~= nil then
        if self.isGray == isGray then
            return
        end
        self.isGray = isGray
    end
end

function Image:setImageColor(color)
    self:setObjColor(color)
end

function Image:SetImageHex(hex)
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():SetObjectColor(obj, hex)
    end
end

function Image:setColorByRGBA(r, g, b, a)
    if a == nil then
        a = 255
    end
    local obj = self:getComObj()
    if obj ~= nil then
        obj.color = UnityEngine.Color(r/255, g/255, b/255, a/255)
    end
end


function Image:alphaHitTestMinimumThreshold(value)
    local image = self:getComObj()
    if image ~= nil then
        image.alphaHitTestMinimumThreshold = value
    end
end

return Image

