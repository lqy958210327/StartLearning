local EventConst = require("Core/EventConst")

local ShadowMapHelper = Framework.Render.ShadowMap.ShadowMapHelper
local ShadowMapManager = Framework.Render.ShadowMap.ShadowMapManager

local UPDATE_INTERVAL = 0.2
local SHADOW_MAP_SIZE = 2048
local SHADOW_MAP_SIZE_HUAWEI = 2048
local SHADOW_STATE_ID = {
    OFF = 0,
    BATTLE = 1,
    MODEL_STAGE = 3,
}

local SWITCH_DICT = {
    [SHADOW_STATE_ID.OFF] = true,
    [SHADOW_STATE_ID.BATTLE] = true,
}

-- ShadowState
local ShadowState = Class("ShadowState")

function ShadowState:ctor(stateID)
    self.stateID = stateID
    self.isOn = SWITCH_DICT[stateID]
    self._active = false
end

function ShadowState:enter(oldStateID, ...)
    local succ = true
    if not self.isOn then
        succ = false
        return succ
    end

    if oldStateID ~= self.stateID then
        self:_onActiveChanged(true)
    end
    self:_onEnterCommon(...)
    return succ
end

-- 从其他状态第一次进入时候的回调
function ShadowState:_onActiveChanged(active)
    self._active = active
end

-- 每次进入状态都会走的回调
function ShadowState:_onEnterCommon(...)

end

function ShadowState:_shouldExit(...)
    return true
end

function ShadowState:exit(newStateID, ...)
    local succ = true
    if self.stateID ~= newStateID then
        self:_onActiveChanged(false)
    elseif self:_shouldExit(...) then
        self:_onActiveChanged(false)
    else
        succ = false
    end
    return succ
end


-- OFF
local ShadowStateOff = Class("ShadowStateOff", ShadowState)

function ShadowStateOff:_onActiveChanged(active)
    ShadowStateOff.super._onActiveChanged(self, active)

    if active then
        ShadowMapManager.ClearLight()
    end
end

-- BATTLE
local ShadowStateBattle = Class("ShadowStateBattle", ShadowState)

function ShadowStateBattle:_onActiveChanged(active)
    ShadowStateBattle.super._onActiveChanged(self, active)
    -- print("onActiveChanged", self.stateID, active)

    ShadowMapHelper.RegisterDefaultLightAndCamera(active)
    ShadowMapManager.SetVisibleLayer("Battle",Const.LAYER_PLAYER, active)
    ShadowMapManager.SetVisibleLayer("Battle",Const.LAYER_NPC, active)
    ShadowMapManager.SetShadowFrustrumStatic(active)

    if not active then
        ShadowMapManager.RemoveStaticBounds("Battle")
    end
end

function ShadowStateBattle:_onEnterCommon(x, y, z, radius)
    -- print("onEnterBattle:", self.stateID)
    ShadowMapHelper.RegisterDefaultLightAndCamera(true) -- todo 同状态下换主光，这里会不会有额外开销？
    ShadowMapManager.AddStaticBounds("Battle", x, y, z, radius)
    ShadowMapManager.RefreshShadow()
end










-- CustomShadowManager

local CustomShadowManager = {}
local self = CustomShadowManager
self.SHADOW_STATE_ID = SHADOW_STATE_ID

function CustomShadowManager.init()
    self._stateDict = {}
    for name, id in pairs(SHADOW_STATE_ID) do
        self._stateDict[id] = self._createState(id)
    end
    self._curStateID = SHADOW_STATE_ID.OFF

    if ClientUtils.isHuawei( ) then
        ShadowMapManager.SetTextureSize(SHADOW_MAP_SIZE_HUAWEI)
    else
        ShadowMapManager.SetTextureSize(SHADOW_MAP_SIZE)
    end
    ShadowMapManager.SetUpdateInterval(UPDATE_INTERVAL)
end

function CustomShadowManager.destroy()
    ShadowMapManager.DeleteInstance()
end




function CustomShadowManager._createState(id)
    if id == SHADOW_STATE_ID.BATTLE then
        return ShadowStateBattle(id)
    else
        return ShadowStateOff(id)
    end
end







function CustomShadowManager.getState(stateID)
    return self._stateDict[stateID]
end




-- 战斗
function CustomShadowManager.setBattleShadowActive(active, x, y, z, radius)
    -- print("【CustomShadowManager】 try _setBattleShadowActive", active, x, y, z, radius)
    self._handlerRequest(SHADOW_STATE_ID.BATTLE, active, x, y, z, radius)
end





-------------------------------




function CustomShadowManager._handlerRequest(stateID, active, ...)
    active = true == active
    local curStateID = self._curStateID
    local curState = self.getState(curStateID)
    if curStateID == stateID then
        if active then
            curState:enter(curStateID, ...)
        else
            if curState:exit(stateID, ...) then
                self._curStateID = SHADOW_STATE_ID.OFF
            end
        end
    else
        local newState = self.getState(stateID)
        if active then
            if curState:exit(stateID) then
                -- 如果无法进入预期的状态，则进入到OFF态
                if newState:enter(curStateID, ...) then
                    self._curStateID = stateID
                else
                    self._curStateID = SHADOW_STATE_ID.OFF
                end
            end
        else
            -- do nothing
        end
    end
end

return CustomShadowManager