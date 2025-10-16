

local _sceneObjLight = "ObjectLight"
local _sceneObjSkybox = "ObjectSkybox"
local _sceneObjEffect = "ObjectEffect"
local _sceneObjEnvironment = "ObjectEnvironment"

---@class SceneData
SceneData = Class("SceneData")

function SceneData:InternalInit(cfgId)
    self._cfgId = cfgId
    self._objLight = nil
    self._objSkybox = nil
    self._objEffect = nil
    self._objEnvironment = nil
end

function SceneData:InternalClear()
    self._objLight = nil
    self._objSkybox = nil
    self._objEffect = nil
    self._objEnvironment = nil
    EventManager.Global.Dispatch(EventType.CameraMgrSetCamera, CameraType.BattleStart, nil)
    EventManager.Global.Dispatch(EventType.CameraMgrSetCamera, CameraType.Formation, nil)
    if self._timer then
        Util.Timer.BreakTimer(self._timer)
        self._timer = nil
    end
end

function SceneData:ConfigID() return self._cfgId end
function SceneData:SetObjectLightActive(value) LuaCallCs.GameObjectActive(self._objLight, value) end
function SceneData:SetObjectSkyboxActive(value) LuaCallCs.GameObjectActive(self._objSkybox, value) end
function SceneData:SetObjectEffectActive(value) LuaCallCs.GameObjectActive(self._objEffect, value) end
function SceneData:SetObjectEnvironmentActive(value) LuaCallCs.GameObjectActive(self._objEnvironment, value)end

function SceneData:SetObjectUltimateColor(isUp, color)
    if isUp then
        self:SetObjectEnvironmentActive(true)
        LuaCallCs.SceneCurtainUp(color, 0.5,nil)
    else
        LuaCallCs.SceneCurtainDown(color, 0, function() self:SetObjectEnvironmentActive(false) end)
    end
end

function SceneData:StartLoad()
    local scene = DataTable.ResScene[self._cfgId]
    if not scene then
        LuaCallCs.ThrowException("---   场景配置数据为空， sceneId = "..self._cfgId)
    end


    self._timer = Util.Timer.AddLoop(0.1, function() self:_setSceneLoadProgress() end)

    local path = scene.path
    LuaCallCs.LoadScene(path, function(value)
        self:_loadFinish(value)
    end)
end

--function SceneData:StartUnload(callback)
--    LuaCallCs.ReleaseScene(callback)
--end

function SceneData:_loadFinish(success)
    Util.Timer.BreakTimer(self._timer)
    self._timer = nil

    if success then
        self:_setSceneLoadProgress()
        local list = LuaCallCs.SceneGetRootGameObjects()
        local count = list.Count
        for i = 0, count - 1 do
            local obj = list[i]
            local name = obj.name
            if name == CameraType.BattleStart then
                EventManager.Global.Dispatch(EventType.CameraMgrSetCamera, CameraType.BattleStart, obj)
            elseif name == CameraType.Formation then
                EventManager.Global.Dispatch(EventType.CameraMgrSetCamera, CameraType.Formation, obj)
            elseif name == _sceneObjLight then
                self._objLight = obj
            elseif name == _sceneObjSkybox then
                self._objSkybox = obj
            elseif name == _sceneObjEffect then
                self._objEffect = obj
            elseif name == _sceneObjEnvironment then
                self._objEnvironment = obj
            end
        end

        if not self._objLight then LuaCallCs.LogError("---   场景配置数据错误，场景没有 ObjectLight 对象， sceneId = "..self._cfgId) end
        if not self._objSkybox then LuaCallCs.LogError("---   场景配置数据错误，场景没有 ObjectSkybox 对象， sceneId = "..self._cfgId) end
        if not self._objEffect then LuaCallCs.LogError("---   场景配置数据错误，场景没有 ObjectEffect 对象， sceneId = "..self._cfgId) end
        if not self._objEnvironment then LuaCallCs.LogError("---   场景配置数据错误，场景没有 ObjectEnvironment 对象， sceneId = "..self._cfgId) end
    end

end

function SceneData:_setSceneLoadProgress()
    local progress = LuaCallCs.SceneGetLoadProgress()
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.SceneLoadProgress, progress)
end
