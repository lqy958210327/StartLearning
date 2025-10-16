
local tab = {}

function tab.WorldToScreenPoint(cam, worldX, worldY, worldZ)
    local screenX, screenY = 0
    screenX, screenY = CS_LuaCallCs.WorldToScreenPoint(cam, worldX, worldY, worldZ, screenX, screenY)
    return screenX, screenY
end

function tab.ScreenPointToLocalPointInRectangle(rect, screenX, screenY, cam)
    local anchorX, anchorY = 0, 0
    anchorX, anchorY = CS_LuaCallCs.ScreenPointToLocalPointInRectangle(rect, screenX, screenY, cam, anchorX, anchorY)
    return anchorX, anchorY
end

function tab.ScreenPointToWorldPointInRectangle(rect, screenX, screenY, cam)
    local worldX, worldY, worldZ = 0, 0, 0
    worldX, worldY, worldZ = CS_LuaCallCs.ScreenPointToWorldPointInRectangle(rect, screenX, screenY, cam, worldX, worldY, worldZ)
    return worldX, worldY, worldZ
end

LuaCallCs.RectTransformUtility = tab