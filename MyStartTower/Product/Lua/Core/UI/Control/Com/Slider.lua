-- Slider类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")
local Label = require("Core/UI/Control/Com/Label")

local UIConst = UIConst
local strClassName = "Slider"


---@class Slider : UIBaseControl
local Slider = Class(strClassName, UIBaseControl)


Slider.MIN_CHANGE_THRESHOLD = 0.01
Slider.MIN_DURATION_THRESHOLD = 0.05
-- 构造函数。
function Slider:ctor(parent, path, textPath)
    if textPath ~= nil then
        local p = textPath
        if path ~= "" then
            p = path.."/"..p
        end
        self._text = Label(parent, p)
    end
end

function Slider:_getControlType()
    return UIConst.ControlTypeSlider
end





function Slider:setText(v)
    if self._text ~= nil then
        self._text:setText(v)
    end
end



function Slider:setFontColor(color)
    if self._text ~= nil then
        self._text:setFontColor(color)
    end
end

function Slider:setMaxValue(num)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.maxValue = num
    end
end

-- forReset：强制重置value
function Slider:setValue(v, costTime, forReset)
    local diffValue = -1
    if not forReset and self._cachedValue then
        diffValue = math.abs(self._cachedValue - v)
        if diffValue < Slider.MIN_CHANGE_THRESHOLD then
            return
        end
    end
    local obj = self:getComObj()
    if obj ~= nil then
        if self._isloading then
            self:getController():SetLoadingValue(obj, v)
        else
            if diffValue>=0 and diffValue <= Slider.MIN_DURATION_THRESHOLD then
                costTime = 0  -- 如果变化值小到一定程度，就不做动画了
            end
            if costTime and costTime > 0 then
                local go = self:getGameObject()
                if go and go.activeInHierarchy then
                    self:getController():SetSliderValue(obj, v, costTime or 0, 0.03)
                end
            else
                self:getController():SetSliderValue(obj, v, costTime or 0, 0.03)
            end
        end
        if costTime and costTime > 0.5 then
            self._cachedValue = nil
        else
            self._cachedValue = v
        end        
    end
end

function Slider:doValue(targetValue, speed)
    if self._sliderTweenAgent == nil then
        self._sliderTweenAgent = self:getController():GetCom(UIConst.SliderDoTweenAgent, self.mPath)
    end
    if self._sliderTweenAgent ~= nil then
        self._sliderTweenAgent:DoSlider(targetValue, speed)
    end
end

function Slider:getValue()
    local obj = self:getComObj()
    if obj ~= nil then
        self._cachedValue = obj.value
        return self._cachedValue
    end
end

function Slider:setFillImage( filePath, spriteName )


end







return Slider

