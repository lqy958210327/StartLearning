
local className = "ScenicManager"
---@class ScenicManager : SystemBase 角色展示系统
ScenicManager = Class(className, SystemBase)

------------------------------ override ------------------------------
---@private 只调用一次，相当于构造函数
function ScenicManager:OnInit()

end

---@private 只调用一次，相当于析构函数
function ScenicManager:OnClear()

end

---@private 登录游戏就会调用一次
function ScenicManager:OnGameStart()
    self:InitField():InitBind():AddListener()
end

---@private 退出游戏就会调用一次
function ScenicManager:OnGameEnd()
    self:RemoveListener():ReleaseBind():ReleaseField()
end

------------------------------ private ------------------------------

---@private 初始化字段
function ScenicManager:InitField()
    self._tick = 0 ---@type number 时间缓存(从管理器启动开始计算)
    self._stageData = nil ---@type StageData 当前舞台数据
    self._actorData = nil ---@type ActorData 当前表演者数据
    return self
end

function ScenicManager:ReleaseField()
    self._tick = 0
    self._stageData = nil
    self._actorData = nil

    return self
end

function ScenicManager:InitBind()
    local mgr = UnityEngine.GameObject('ScenicManager') ---@type userdata 管理器对象父节点
    mgr.transform.localPosition = Vector3(0, 2000, 0)
    mgr.transform.localRotation = Quaternion.identity
    UnityEngine.Object.DontDestroyOnLoad(mgr)
    self._MgrRoot = mgr

    self._stageRoot = UnityEngine.GameObject('StageRoot') ---@type userdata 舞台对象父节点
    LuaCallCs.SetParentAndReset(self._MgrRoot, self._stageRoot)
    self.stageController = StageController:Instance():WithStageRoot(self._stageRoot)

    self._actorRoot = UnityEngine.GameObject('ActorRoot') ---@type userdata 模型对象父节点
    LuaCallCs.SetParentAndReset(self._MgrRoot, self._actorRoot)
    self.actorController = ActorController:Instance():WithActorRoot(self._actorRoot)

    return self
end

function ScenicManager:ReleaseBind()
    self.stageController:ToDestory()
    self.actorController:ToDestory()
    return self
end

------------------------------ Event ------------------------------

---@private 添加事件
function ScenicManager:AddListener()
    GameUpdate:Get():AddUpdate(GameUpdateID.ScenicManager , self.OnFrameUpdate, self)
    self._onScenicSwitchCallback = function(scenicType, modelTag) self:ScenicSwitchCallback(scenicType, modelTag) end
    EventManager.Global.RegisterEvent(EventType.ScenicSwitch, self._onScenicSwitchCallback)

    self._onScenicReleaseCallback = function() self:ScenicReleaseCallback() end
    EventManager.Global.RegisterEvent(EventType.ScenicRelease, self._onScenicReleaseCallback)

    self._onScenicActorEnableCallback = function(enable) self:ScenicActorEnableCallback(enable) end
    EventManager.Global.RegisterEvent(EventType.ScenicActorEnable, self._onScenicActorEnableCallback)

    self._onScenicActorRootPosChangedCallback = function( worlPosition ) self:ScenicActorRootPosChangedCallback(worlPosition) end
    EventManager.Global.RegisterEvent(EventType.ScenicActorRootPosChanged, self._onScenicActorRootPosChangedCallback)

    return self
end

---@private 移除事件
function ScenicManager:RemoveListener()
    GameUpdate:Get():RemoveUpdate(GameUpdateID.ScenicManager)
    EventManager.Global.UnRegisterEvent(EventType.ScenicSwitch, self._onScenicSwitchCallback)
    EventManager.Global.UnRegisterEvent(EventType.ScenicRelease, self._onScenicReleaseCallback)
    EventManager.Global.UnRegisterEvent(EventType.ScenicActorEnable, self._onScenicActorEnableCallback)
    EventManager.Global.UnRegisterEvent(EventType.ScenicActorRootPosChanged, self._onScenicActorRootPosChangedCallback)
    return self
end

function ScenicManager:OnFrameUpdate(deltaTime)
    self._tick = self._tick + deltaTime
end

function ScenicManager:ScenicSwitchCallback(scenicType, modelTag)
    local scenicCfg = Util.Scenic.GetScenicConfig(scenicType)
    if scenicCfg == nil then
        logerror("ScenicManager:ScenicSwitchCallback scenicType not found: ", scenicType)
        return
    end

    local stageData = StageData():WithStageTag(scenicType)
    if not stageData:Compare(self._stageData) then --舞台发生变化
        self._stageData = stageData
        self.stageController:SwitchStage(stageData)
    end

    local actorData = ActorData()
            :WithTag(modelTag)
            :WithSuggest(scenicCfg.suggest_asset)
            :WithEnterClip(scenicCfg.entrance)

    if not actorData:Equal(self._actorData) then --表演者发生变化
        self._actorData = actorData
        self.actorController:SwitchActor(actorData)
    end
end

function ScenicManager:ScenicReleaseCallback()
    if self.stageController then
        self.stageController:ToRelease()
    end

    if self.actorController then
        self.actorController:ToRelease()
    end

    self._actorData = nil
    self._stageData = nil
end

function ScenicManager:ScenicActorEnableCallback(enable)
    self.actorController:EnableActor(enable)
end

function ScenicManager:ScenicActorRootPosChangedCallback(worldPos)
    self._actorRoot.transform.position = worldPos
end