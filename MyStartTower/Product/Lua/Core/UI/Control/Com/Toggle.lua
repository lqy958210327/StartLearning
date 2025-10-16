-- Toggle类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")
local Label = require("Core/UI/Control/Com/Label")

local UIConst = UIConst
local strClassName = "Toggle"

---@class Toggle: UIBaseControl
local Toggle = Class(strClassName, UIBaseControl)




-- 构造函数。
function Toggle:ctor(parent, path, textPath)
    if textPath ~= nil then
        local p = textPath
        if path ~= "" then
            p = path.."/"..p
        end
        self._text = Label(parent, p)
    end
end

function Toggle:_getControlType()
    return UIConst.ControlTypeToggle
end


function Toggle:setText(v)
    if self._text ~= nil then
        self._text:setText(v)
    end
end

function Toggle:setOn(v)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.isOn = v
    end
end

function Toggle:setOnVoidUnChange(v)
    local obj = self:getComObj()
    if obj ~= nil and self:isOn() ~= v then
        obj:SetIsOnWithoutNotify(v)
    end
end

function Toggle:isOn()
    return self:getComObj().isOn
end

function Toggle:addEventValueChanged(eventFunc,isPlayAudio)
    local obj = self:getComObj()
    if isPlayAudio == nil then
        isPlayAudio = true
    end
    if obj ~= nil then
        self:getController():AddToggleOnValueChanged(obj, self:_packageCallback(eventFunc),isPlayAudio)
    end
end



function Toggle:setToggleGroup(toggleGroup)
    local obj = self:getComObj()
    local toggleGroup = toggleGroup:getComObj()
    if obj ~= nil then
        self:getController():SetToggleGroup(obj,toggleGroup)
    end
end



function Toggle:removeTipsGuide()
    local obj = self:getComObj()
    if obj ~= nil then
        if not  self.tips then 
            return
        end 
        self.tips:setVisible(false)
    end
end
return Toggle

