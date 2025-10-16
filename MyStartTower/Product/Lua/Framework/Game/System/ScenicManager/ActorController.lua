------------------------------ ActorCache ------------------------------
---@class ActorCache 展台实例缓存
local ActorCache = Class("ActorCache")

function ActorCache:ctor()
    self._instance = nil ---@type UnityEngine.GameObject 预制体
    self._assetPath = "" ---@type string 资源路径
    self._animator = nil ---@type UnityEngine.GameObject 动画组件
end

---@type fun(instance: UnityEngine.GameObject): ActorCache 设置预制体实例
function ActorCache:WithInstance(instance)
    self._instance = instance
    return self
end

---@type fun(): UnityEngine.GameObject 获取预制体实例
function ActorCache:GetInstance()
    return self._instance
end

---@type fun(assetPath: string): ActorCache 设置资源路径
function ActorCache:WithAssetPath(assetPath)
    self._assetPath = assetPath ---@type string 资源路径
    return self
end

---@type fun(): string 获取资源路径
function ActorCache:GetAssetPath()
    return self._assetPath
end

---@type fun(animator: UnityEngine.GameObject): ActorCache 设置资源路径
function ActorCache:WithAnimator(animator)
    self._animator = animator ---@type UnityEngine.GameObject 动画组件
    return self
end




------------------------------ ActorController ------------------------------

local className = "ActorController"
---@class ActorController 表演者系统
ActorController = Class(className)
------------------------------ override ------------------------------
---@private 只调用一次，相当于构造函数
function ActorController:ctor()
    self:InitField():InitBind():AddListener()
end


function ActorController:InitField()
    self._enable = true ---@type boolean 是否显示表演者
    self._actorCache = nil ---@type ActorCache 表演者缓存
    self._rotateThreshold = 10000 ---@type number 旋转阈值
    self._lvUpEffect = nil ---@type UnityEngine.GameObject 升级特效
    self._timelines = {} ---@type table<string, UnityEngine.Timeline.TimelineAsset> 时间轴缓存
    return self
end

function ActorController:InitBind()
    self._actor = UnityEngine.GameObject('Actor')
    self._effect = UnityEngine.GameObject('Effect')
    LuaCallCs.InitDragRotate(self._actor, self._rotateThreshold, false) -- 初始化拖拽旋转
    return self
end

function ActorController:ReleaseField()
    self._actorCache = nil
    self._lvUpEffect = nil
    return self
end

------------------------------ public ------------------------------
---@return ActorController
function ActorController:Instance()
    if self._instance == nil then
        self._instance = ActorController()
    end
    return self._instance
end

function ActorController:WithActorRoot(actorRoot)
    LuaCallCs.SetParentAndReset(actorRoot, self._actor)
    LuaCallCs.SetParentAndReset(actorRoot, self._effect)
    return self
end

function ActorController:ToDestory()
    self:RemoveListener():ReleaseField()
end

function ActorController:ToRelease()
    self:ReleaseActor()
    self:ToCleanTimelineCache()
end

function ActorController:EnableActor(enable)
    if self._enable == enable then
        return self
    end

    if not enable then
        self:SetRotate(false)
        if self._actorCache then --正在播放timeline的时候先停止timeline
            LuaCallCs.Timeline.Stop(self._actorCache:GetInstance())
        end
    end

    self._enable = enable
    if self._actor then
        local y = enable and 0 or 2000 -- 如果不显示表演者，则将其位置移出视野
        self._actor.transform.localPosition = Vector3(0, y, 0)
        self:SetRotate(true)
    end

end

---@type fun(actorData: ActorData) 切换表演者
---@param actorData ActorData 表演者数据
function ActorController:SwitchActor(actorData)
    if not actorData then
        logerror("SwitchActor load error! actorData is nil")
        return
    end

    local modelTag = actorData:GetTag()
    local modelCfg = Util.Scenic.GetModelConfig(modelTag)
    if not modelCfg then
        logerror("SwitchActor load error! cant find modelTag: ", modelTag)
        return
    end

    local defaultAsset = modelCfg.show_model_path --默认展示资源
    local suggest = actorData:GetSuggest()
    local assetPath = modelCfg[suggest]
    if assetPath == nil then
        assetPath = defaultAsset
    end

    local actorType = ActorType.Timeline
    if assetPath == defaultAsset then
        actorType = ActorType.Model
    end

    self:SetRotate(false) -- 禁用拖拽旋转
    self:ToDisableStageBackGround() --禁用舞台背景
    self:ReleaseActor() -- 卸载之前的表演者

    local scale = modelCfg.show_model_scale
    local instance = LuaCallCs.LoadPrefabSync(assetPath)
    LuaCallCs.ResetLocalRotation(self._actor) -- 重置本地旋转
    LuaCallCs.SetParentAndReset(self._actor, instance)
    LuaCallCs.SetGameObjectLocalScale(instance, scale)
    LuaCallCs.GameObjectActive(instance,true)
    --local propCamera = LuaCallCs.GetObject(instance,"PropCamera_") --我为什么要禁用timeline相机？
    local onAnimEnd = function()
        self:SetRotate(true)
        self:ToChangeStageBack(modelCfg.UI_BG_path..".png")
        end

    local anim = nil
    if actorType == ActorType.Model then
        anim = instance -- Model类的动画在预制体的根节点上
        onAnimEnd()
    elseif actorType == ActorType.Timeline then
        anim = LuaCallCs.GetObject(instance,"Model") -- Timeline类的动画在"Model"节点上。
        local timeline = self:GetTimelineInstance(assetPath)
        if timeline == nil then
            LuaCallCs.Timeline.Play(instance, onAnimEnd)
            self:CacheTimelineInstance(assetPath, instance)
        else
            LuaCallCs.Timeline.Stop(instance)
        end
    end

    if anim ~= nil then
        LuaCallCs.ScenicHeroAnimactionPlay(anim, modelCfg.scenic_show_group, modelCfg.scenic_show_cd)
    end

    self._actorCache = ActorCache():WithInstance(instance):WithAssetPath(assetPath):WithAnimator(anim)
end



------------------------------ private ------------------------------
---@private 卸载表演者
function ActorController:ReleaseActor()
    if self._actorCache then
        local instance = self._actorCache:GetInstance()
        local assetPath = self._actorCache:GetAssetPath()
        if instance and not string.IsNilOrEmpty(assetPath) then
            LuaCallCs.DisposePrefab(instance) -- 先回收
            LuaCallCs.ReleasePrefab(assetPath) -- 再释放
        end
        self._actorCache = nil
    end
end

---@private 切换舞台背景
---@param backTexture string 舞台背景纹理路径
function ActorController:ToChangeStageBack(backTexture)
    EventManager.Global.Dispatch(EventType.ScenicStageBackChanged, backTexture)
end

function ActorController:ToDisableStageBackGround()
    EventManager.Global.Dispatch(EventType.ScenicStageBackEnable, false)
end

function ActorController:GetTimelineInstance(timeAssetPath)
    if not timeAssetPath or string.IsNilOrEmpty(timeAssetPath) then
        logerror("GetTimelineInstance error! timeAssetPath is nil")
        return nil
    end
    return self._timelines[timeAssetPath]
end

function ActorController:CacheTimelineInstance(timeAssetPath, instance)
    if not timeAssetPath or string.IsNilOrEmpty(timeAssetPath) then
        logerror("CacheTimelineInstance error! timeAssetPath is nil")
        return
    end
    self._timelines[timeAssetPath] = instance
end

---@private 清理时间轴缓存
function ActorController:ToCleanTimelineCache()
    self._timelines = {}
end

function ActorController:SetRotate(enable)
    LuaCallCs.WithDragRotateEnable(self._actor, enable) -- 初始化拖拽旋转
end
------------------------------ Event ------------------------------

function ActorController:AddListener()
    self._onScenicActorPlayLvUpEffectCallback = function() self:ScenicActorPlayLvUpEffectCallback() end
    EventManager.Global.RegisterEvent(EventType.ScenicActorPlayLvUpEffect, self._onScenicActorPlayLvUpEffectCallback)
    return self
end

function ActorController:RemoveListener()
    EventManager.Global.UnRegisterEvent(EventType.ScenicActorPlayLvUpEffect, self._onScenicActorPlayLvUpEffectCallback)
    return self
end

function ActorController:ScenicActorPlayLvUpEffectCallback()
    if self._lvUpEffect == nil then
        local effectPath = "Prefab/Effect/Scene/BattleScenes/E_SLM_UIHeroCommon_Up"
        self._lvUpEffect = LuaCallCs.LoadPrefabSync(effectPath)
        LuaCallCs.SetParentAndReset(self._effect, self._lvUpEffect)
    end
    LuaCallCs.GameObjectActive(self._lvUpEffect,false)
    LuaCallCs.GameObjectActive(self._lvUpEffect,true)
end