-- RawImage类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")


local UIConst = UIConst
local strClassName = "RawImage"

---@class RawImage : UIBaseControl
local RawImage = Class(strClassName, UIBaseControl)



-- 构造函数。
function RawImage:ctor(parent, path)
    self.isGray = false
end

function RawImage:_getControlType()
    return UIConst.ControlTypeRawImage
end


function RawImage:setImage(filePath, imgName)
    LuaCallCs.LogError("---   这个接口有内存泄露，使用新接口：InterfaceSetTexture() 或 LuaCallCs.UI.UGUISetRawImage()", true)

    --local url = imgName
    --if filePath ~= "" then
    --    if string.endswith(filePath, "/") then
    --        url = filePath .. imgName
    --    else
    --        url = filePath .. '/' .. imgName
    --    end
    --end
    --
    --local obj = self:getGameObject()
    --LuaCallCs.UI.UGUISetRawImage(obj, obj.name, url)
end

---@param groupId number 资源组ID(必填)
---@param resName string 资源名称
function RawImage:InterfaceSetTexture(groupId, resName)
    local obj = self:getGameObject()
    if obj then
        LuaCallCs.UI.UGUISetRawImage(obj, obj.name, resName, groupId)
    end
end

function RawImage:setImageGray(isGray)
    local obj = self:getComObj()
    if obj ~= nil then
        if self.isGray == isGray then
            return
        end
        self.isGray = isGray
        self:getController():SetImageGray(obj, isGray)
    end
end

function RawImage:setImageColor(color)
    self:setObjColor(color)
end


return RawImage

