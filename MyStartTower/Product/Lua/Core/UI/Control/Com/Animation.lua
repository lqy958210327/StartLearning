-- Animation类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

local strClassName = "Animation"
---@class Animation : UIBaseControl
local Animation = Class(strClassName, UIBaseControl)

-- 构造函数。
function Animation:ctor(parent, path)

end

function Animation:_getControlType()
    return UIConst.ControlTypeUIAni
end

function Animation:startAni(aniName, sampleAtStart)
    local obj = self:getComObj()
    if obj then
        obj:StartAni(aniName, sampleAtStart or false)
    end
end

function Animation:startAniWithCallback(aniName, sampleAtStart)
    local obj = self:getComObj()
    if obj then
        obj:StartAniWithFinish(aniName, sampleAtStart or false)
    end
end

function Animation:startAniLoop(aniName)
    local obj = self:getComObj()
    if obj then
        obj:StartAniLoop(aniName)
    end
end

function Animation:stopAni(aniName)
    local obj = self:getComObj()
    if obj then
        obj:StopAni(aniName)
    end
end

function Animation:resetAni(aniName)
    local obj = self:getComObj()
    if obj then
        obj:ResetAni(aniName)
    end
end

function Animation:addEventFinish(eventFunc)
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():AddAniOnFinish(obj, self:_packageCallback(eventFunc))
    end
end

function Animation:clearEventFinish()
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():ClearAniOnFinish(obj)
    end
end

function Animation:addEventInterrupt(eventFunc)
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():AddAniOnInterrupt(obj, self:_packageCallback(eventFunc))
    end
end

function Animation:clearEventInterrupt()
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():ClearAniOnInterrupt(obj)
    end
end

function Animation:addEventAnimateCue( eventFunc )
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():AddAniOnAnimateCue(obj, self:_packageCallback(eventFunc))
    end
end

function Animation:clearEventAnimateCue()
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():ClearAniOnAnimateCue(obj)
    end
end

function Animation:setAniSpeed(speed)
    local obj = self:getComObj()
    if obj then
        obj:SetAniSpeed(speed)
    end
end

return Animation

