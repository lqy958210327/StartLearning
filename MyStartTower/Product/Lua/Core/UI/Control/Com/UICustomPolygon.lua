---
--- Created by gzw.
--- DateTime: 2024/3/16 11:09
---
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

local className = "UICustomPolygon"
local UICustomPolygon = Class(className, UIBaseControl)

function UICustomPolygon:ctor(parent, path, textPath)

end

function UICustomPolygon:setAllData(_allData)
    local obj = self:getComObj()
    if obj ~= nil then
        obj:SetAllData(_allData)
    end
end

function UICustomPolygon:initData(maxValue, minScale)
    local obj = self:getComObj()
    if obj ~= nil then
        obj:InitData(maxValue, minScale)
    end
end

function UICustomPolygon:setColorByRGBA(r, g, b, a)
    if a == nil then
        a = 255
    end
    local obj = self:getComObj()
    if obj ~= nil then
        obj.color = UnityEngine.Color(r / 255, g / 255, b / 255, a / 255)
    end
end

-- function UICustomPolygon:setDefendData()
--     local obj = self:getComObj()
--     if obj ~= nil then
--         obj:SetDefendData()
--     end
-- end

function UICustomPolygon:setMaxData()
    local obj = self:getComObj()
    if obj ~= nil then
        obj:SetMaxData()
    end
end

function UICustomPolygon:setMinData()
    local obj = self:getComObj()
    if obj ~= nil then
        obj:SetMinData()
    end
end

function UICustomPolygon:_getControlType()
    return UIConst.UICustomPolygon
end

return UICustomPolygon
