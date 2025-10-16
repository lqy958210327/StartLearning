-- Button类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")
local Label = require("Core/UI/Control/Com/Label")
local Vector3 = Vector3
local UIConst = UIConst
local strClassName = "Button"


---@class Button : UIBaseControl
local Button = Class(strClassName, UIBaseControl)



local BTN_CLICK_CD = 0.2
local BTN_PLAY_AUDIO = 1
-- 构造函数。
function Button:ctor(parent, path, textPath, canEmoji)
    if textPath ~= nil then
        local p = textPath
        if path ~= "" then
            p = path.."/"..p
        end
        self._text = Label(parent, p, canEmoji)
    end
end

function Button:_getControlType()
    return UIConst.ControlTypeButton
end

function Button:getComObj()
    if self._obj == nil then
        local obj = Button.super.getComObj(self)
    end
    return self._obj
end




function Button:setText(v)
    if self._text ~= nil then
        self._text:setText(v)
    end
end



function Button:setFontColor(color)
    if self._text ~= nil then
        self._text:setFontColor(color)
    end
end

-- 设置控件的贴图
function Button:setImage(filePath, spriteName)


end


function Button:addEventClick(eventFunc, clickCD,playAudio,isPlayDoTween,thereSelf)
    local obj = self:getComObj()
    if obj ~= nil then
        if clickCD == nil then
            clickCD = BTN_CLICK_CD
        end

        if not playAudio then
            playAudio = BTN_PLAY_AUDIO
        end

        self:getController():AddButtonOnClick(obj, self:_packageCallback(eventFunc), clickCD,playAudio)
    end
end


function Button:setlocalPosition(x, y)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.transform.localPosition=Vector3(x, y, 0)
    end
end


function Button:removeTipsGuide()
    local obj = self:getComObj()
    if obj ~= nil then
        if not  self.tips then 
            return
        end 
        self.tips:setVisible(false)
    end
end
return Button