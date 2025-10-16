------------------------------ StageCache ------------------------------
---@class StageCache 展台实例缓存
local StageCache = Class("StageCache")

function StageCache:ctor()
    self._instance = nil ---@type userdata 当前展台GameObject
    self._stageType = 0 ---@type number 当前展台类型
    self._assetPath = "" ---@type string 当前展台资源路径
end

---@type fun(stageGo: userdata): StageCache 配置展台数据
function StageCache:WithInstance(instance)
    self._instance = instance
    return self
end

---@type fun(): userdata 获取展台GameObject
function StageCache:GetInstance()
    return self._instance
end

---@type fun(stageType:number): StageCache 配置展台类型
function StageCache:WithType(stageType)
    self._stageType = stageType
    return self
end

---@type fun(): number 获取展台类型
function StageCache:GetType()
    return self._stageType
end

---@type fun(stagePath:string): StageCache 配置展台资源路径
function StageCache:WithAssetPath(stagePath)
    self._assetPath = stagePath
    return self
end

---@type fun(): string 获取展台资源路径
function StageCache:GetAssetPath()
    return self._assetPath
end


------------------------------ StageController ------------------------------

local className = "StageController"
---@class StageController 展台管理器
StageController = Class(className)

------------------------------ override ------------------------------
---@private 只调用一次，相当于构造函数
function StageController:ctor()
    self:InitField():AddListener()
end


function StageController:InitField()
    self._stageCache = nil ---@type StageCache 当前展台缓存
    return self
end

function StageController:ReleaseField()
    self:ReleaseStage()
    self._stageCache = nil
    return self
end

------------------------------ public ------------------------------
---@return StageController
function StageController:Instance()
    if self._instance == nil then
        self._instance = StageController()
    end
    return self._instance
end

function StageController:WithStageRoot(stageRoot)
    self._stageRoot = stageRoot
    return self
end

function StageController:ToDestory()
    self:RemoveListener():ReleaseField()
end

function StageController:ToRelease()
    self:ReleaseStage()
end

---@type fun(stageData: StageData) 切换舞台
---@param stageData StageData 舞台数据
function StageController:SwitchStage(stageData)
    if stageData == nil then
        logerror("stage load error! stageData is nil or stageType is nil")
        return
    end

    local stageTag = stageData:GetStageTag()
    local stageCfg = Util.Scenic.GetScenicConfig(stageTag)
    if not stageCfg then
        logerror("stage load error! cant find stageType: ", stageTag)
        return
    end

    self:ReleaseStage() --先卸载之前的舞台

    local stagePath = stageCfg.Sceeicpath
    if string.IsNilOrEmpty(stagePath) then
        logerror("stage load error! cant find stageType: ", stageTag)
        return
    end

    local instance = LuaCallCs.LoadPrefabSync(stagePath)
    local stagePos = stageCfg.SceeicPos or { 0, 0, 0 }

    LuaCallCs.SetParentAndReset(self._stageRoot, instance)
    LuaCallCs.SetGameObjLocalPosition(instance, stagePos[1], stagePos[2], stagePos[3])
    LuaCallCs.GameObjectActive(instance,true)

    local actorRoot = LuaCallCs.GetObject(instance,"ModelRoot")
    local actorRootPos = self._stageRoot.transform.position
    if actorRoot then
        actorRootPos = actorRoot.transform.position
    end
    EventManager.Global.Dispatch(EventType.ScenicActorRootPosChanged, actorRootPos) --调整表演者根节点位置
    self._stageCache = StageCache():WithInstance(instance):WithType(stageTag):WithAssetPath(stagePath) ---@type StageCache
end

------------------------------ private ------------------------------
---@private 卸载舞台
function StageController:ReleaseStage()
    if self._stageCache then
        local instance = self._stageCache:GetInstance()
        local assetPath = self._stageCache:GetAssetPath()
        if instance and not string.IsNilOrEmpty(assetPath) then
            LuaCallCs.DisposePrefab(instance)
            LuaCallCs.ReleasePrefab(assetPath)
        end
        self._stageCache = nil
    end
end

function StageController:AddListener()

    self._onStageBackEnableCallback = function(enable) self:StageBackEnable(enable) end
    EventManager.Global.RegisterEvent(EventType.ScenicStageBackEnable, self._onStageBackEnableCallback)
    self._onStageBackChangedCallback = function(backTexture) self:StageBackChanged(backTexture) end
    EventManager.Global.RegisterEvent(EventType.ScenicStageBackChanged, self._onStageBackChangedCallback)
    return self
end

function StageController:RemoveListener()
    EventManager.Global.UnRegisterEvent(EventType.ScenicStageBackEnable, self._onStageBackEnableCallback)
    EventManager.Global.UnRegisterEvent(EventType.ScenicStageBackChanged, self._onStageBackChangedCallback)
    return self
end

function StageController:StageBackEnable(enable)
    if self._stageCache then
        local stage = self._stageCache:GetInstance()
        if stage then
            LuaCallCs.Scenic.EnableStageBackGround(stage, enable)
        end
    end
end

function StageController:StageBackChanged(backTexture)
    if self._stageCache then
        local stage = self._stageCache:GetInstance()
        if stage then
            LuaCallCs.Scenic.EnableStageBackGround(stage, true)
            LuaCallCs.Scenic.ChangeStageBackGround(stage, backTexture)
        end
    end
end

