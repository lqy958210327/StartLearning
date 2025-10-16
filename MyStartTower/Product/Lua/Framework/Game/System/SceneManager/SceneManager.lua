
-- 场景管理器
-- 这是私有脚本，外部不要掉访问脚本里的任何数据和接口

---@class SceneManager : SystemBase
SceneManager = Class("SceneManager", SystemBase)

function SceneManager:OnInit()
    ---@type SceneData
    self._curScene = nil

    self._callback = nil

    self._evtChangeScene = function(cfgId, isForce, isLogicProgress, callback) self:_changeScene(cfgId, isForce, isLogicProgress, callback) end
    self._evtChangeSceneFinish = function() self:_changeSceneFinish() end
    self._evtChangeObjectLight = function(value) self:_changeObjectLight(value) end
    self._evtChangeObjectSkybox = function(value) self:_changeObjectSkybox(value) end
    self._evtChangeObjectEffect = function(value) self:_changeObjectEffect(value) end
    self._evtChangeObjectEnvironment = function(value) self:_changeObjectEnvironment(value) end
    self._evtChangeObjectUltimateColor = function(value, color) self:_changeObjectUltimateColor(value, color) end
    self._evtSetAllSceneObject = function(value) self:_setAllSceneObject(value) end

    EventManager.Global.RegisterEvent(EventType.SceneMgrChangeScene, self._evtChangeScene)
    EventManager.Global.RegisterEvent(EventType.SceneMgrChangeSceneFinish, self._evtChangeSceneFinish)
    EventManager.Global.RegisterEvent(EventType.SceneMgrChangeObjectLight, self._evtChangeObjectLight)
    EventManager.Global.RegisterEvent(EventType.SceneMgrChangeObjectSkybox, self._evtChangeObjectSkybox)
    EventManager.Global.RegisterEvent(EventType.SceneMgrChangeObjectEffect, self._evtChangeObjectEffect)
    EventManager.Global.RegisterEvent(EventType.SceneMgrChangeObjectEnvironment, self._evtChangeObjectEnvironment)
    EventManager.Global.RegisterEvent(EventType.SceneMgrChangeObjectUltimateColor, self._evtChangeObjectUltimateColor)
    EventManager.Global.RegisterEvent(EventType.SceneMgrSetAllObject, self._evtSetAllSceneObject)
end

function SceneManager:OnClear()
    EventManager.Global.UnRegisterEvent(EventType.SceneMgrChangeScene, self._evtChangeScene)
    EventManager.Global.UnRegisterEvent(EventType.SceneMgrChangeSceneFinish, self._evtChangeSceneFinish)
    EventManager.Global.UnRegisterEvent(EventType.SceneMgrChangeObjectLight, self._evtChangeObjectLight)
    EventManager.Global.UnRegisterEvent(EventType.SceneMgrChangeObjectSkybox, self._evtChangeObjectSkybox)
    EventManager.Global.UnRegisterEvent(EventType.SceneMgrChangeObjectEffect, self._evtChangeObjectEffect)
    EventManager.Global.UnRegisterEvent(EventType.SceneMgrChangeObjectEnvironment, self._evtChangeObjectEnvironment)
    EventManager.Global.UnRegisterEvent(EventType.SceneMgrChangeObjectUltimateColor, self._evtChangeObjectUltimateColor)
    EventManager.Global.UnRegisterEvent(EventType.SceneMgrSetAllObject, self._evtSetAllSceneObject)
end

function SceneManager:OnGameStart()

end

function SceneManager:OnGameEnd()

end

function SceneManager:_changeObjectLight(value)
    assert(type(value) == "boolean", "---   场景灯光显隐参数类型错误, 必须传入boolean类型  ")
    print("---   设置场景灯光显隐  ")
    if self._curScene then
        self._curScene:SetObjectLightActive(value)
    end
end
function SceneManager:_changeObjectSkybox(value)
    assert(type(value) == "boolean", "---   场景天空盒显隐参数类型错误, 必须传入boolean类型  ")
    print("---   设置场景天空盒显隐  ")
    if self._curScene then
        self._curScene:SetObjectSkyboxActive(value)
    end
end
function SceneManager:_changeObjectEffect(value)
    assert(type(value) == "boolean", "---   场景特效显隐参数类型错误, 必须传入boolean类型  ")
    print("---   设置场景特效显隐  ")
    if self._curScene then
        self._curScene:SetObjectEffectActive(value)
    end
end
function SceneManager:_changeObjectEnvironment(value)
    assert(type(value) == "boolean", "---   场景环境显隐参数类型错误, 必须传入boolean类型  ")
    print("---   设置场景环境显隐  ")
    if self._curScene then
        self._curScene:SetObjectEnvironmentActive(value)
    end
end

function SceneManager:_changeObjectUltimateColor(value, ultimateColor)
    print("---   设置场景环境颜色  ")
    if self._curScene then
        self._curScene:SetObjectUltimateColor(value, ultimateColor)
    end
end

function SceneManager:_setAllSceneObject(value)
    self:_changeObjectLight(value)
    self:_changeObjectSkybox(value)
    self:_changeObjectEffect(value)
    self:_changeObjectEnvironment(value)
end

---@param cfgId number 场景配置ID
---@param isLogicProgress boolean 是否有逻辑加载
---@param isForce boolean 是否强制切换场景
---@param callback function 切换完成回调
function SceneManager:_changeScene(cfgId, isForce,  isLogicProgress, callback)
    assert(cfgId, "---   场景配置ID为空, 无法切换场景  ")
    if (not isForce) and self._curScene and self._curScene:ConfigID() == cfgId then
        callback()
        return
    end

    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.SceneLoadProgress, 0)
    -- 有逻辑加载，那么SceneLogicProgress设置为0，否则设置为1
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.SceneLogicProgress, isLogicProgress and 0 or 1)




    UIManager.InterfaceOpenUI(UIName.UILoading)
    local scene = DataTable.ResScene[cfgId]
    if scene and scene.loading_path then
        Blackboard.UIEvent.SendMessage(UIName.UILoading, UIEventID.UILoadingSetData, scene.loading_path)
    end



    EventManager.Global.Dispatch(EventType.CameraMgrChangeCamera, CameraType.MainCamera)


    if self._curScene then
        self._curScene:InternalClear()
        LuaCallCs.ReleaseScene(function()
            self:_loadNewScene(cfgId, callback)
        end)
    else
        self:_loadNewScene(cfgId, callback)
    end
end

function SceneManager:_changeSceneFinish()
    if self._callback then
        self._callback()
        self._callback = nil
    end
end


function SceneManager:_loadNewScene(cfgId, callback)
    local scene = SceneData()
    scene:InternalInit(cfgId)
    self._curScene = scene

    self._callback = callback
    scene:StartLoad()
end
