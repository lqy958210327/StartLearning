local EventConst = require("Core/EventConst")
local UIMiscConfig = ConstTable.UIMiscConfig
local LuaToolkit = Framework.Tools.LuaToolkit

local FlyIconUtils = {}
local self = FlyIconUtils

-------------public ------------
----给定源icon和target控件, itemId和itemNum可不传----
function FlyIconUtils.setFlyUItoUI( startUIObj, endUIObj, itemId, itemNum, scale )


end

function FlyIconUtils.setFlyImagetoUI( startUIObj, endUIObj, iconPath, iconName, scale )


end

function FlyIconUtils.setFly2DPosToUI( startWorldPos, endUIObj, itemId, itemNum, scale)

end

----给定item、起始位置和target控件
function FlyIconUtils.setFly3DtoUI(  realWorldPos, endUIObj, itemId, itemNum, scale )


end


function FlyIconUtils.setFlyEffect3DToUI( realWorldPos, endUIObj, effectPath, belongScene, scale )
    local startWorldPos = self._calc3dWorldPos(realWorldPos)
    local endWorldPos = self._calcUIWorldPos(endUIObj)
    if startWorldPos and endWorldPos then
        if belongScene then
            local flyDlg = UIManager.getUI("fly3DIconDlg", true)
            flyDlg:setFlyEffectData(startWorldPos, endWorldPos, effectPath, scale)
        else
            --local flyDlg = UIManager.getUI("flyIconDlg", true)
            --flyDlg:setFlyEffectData(startWorldPos, endWorldPos, effectPath, scale)
        end
    end
end


---------------------
function FlyIconUtils.sendFlyEvent( obj, itemId, itemNum )
    --if UIManager.tryGetUI("captureDlg") then    -- 皮肤点击分享时候会额外飞一次
    --    return
    --end
    EventCenter.sendEvent(EventConst.MONEY_FLY, { UIConst.FLY_MODE_UI_OBJ, { { itemId, obj, itemNum } } } )
end

function FlyIconUtils.send3DFlyEvent( worldPos, itemId, itemNum )
    EventCenter.sendEvent(EventConst.MONEY_FLY, { UIConst.FLY_MODE_3D, { { itemId, worldPos, itemNum } } } )
end
---------------private-------------



function FlyIconUtils._calcUIWorldPos( uiObj )
    if uiObj then
        local pos = uiObj:getAbsPosition()
        if pos and pos.x then
            return Vector2(pos.x , pos.y)
        end
    end
end

function FlyIconUtils._calc3dWorldPos( realWorldPos )
    local worldPos = LuaToolkit.WorldTo2DCameraPos(realWorldPos)
    return Vector2(worldPos.x, worldPos.y)
end

return FlyIconUtils