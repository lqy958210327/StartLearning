
local className = "SkillCutInMgr"
---@class SkillCutInMgr : SystemBase 战斗技能渲染帧事件管理器
SkillCutInMgr = Class(className, SystemBase)

local _sceneEffectPath = "Prefab/Effect/Scene/BattleScenes/SkillCutInEffect" ---@type string 场景特效路径


function SkillCutInMgr:ctor()
    self._effect = nil ---@type GameObject 光爆
end

function SkillCutInMgr:OnInit()
    self:AddListener()
end

function SkillCutInMgr:OnClear()
    self:RemoveListener()
end

function SkillCutInMgr:InitData()
    self._uiSkillCutIn = nil ---@type UISkillCutIn 技能切入UI
end

function SkillCutInMgr:AddListener()
    self._evtSkillCutInStandby = function(isStandby) self:SkillCutInStandby(isStandby) end
    EventManager.Global.RegisterEvent(EventType.SkillCutInStandby, self._evtSkillCutInStandby)
    self._evtSkillCutInPlay = function(entId, skillTag) self:SkillCutInPlay(entId, skillTag) end
    EventManager.Global.RegisterEvent(EventType.SkillCutInPlay, self._evtSkillCutInPlay)
    return self;
end

function SkillCutInMgr:RemoveListener()
    EventManager.Global.UnRegisterEvent(EventType.SkillCutInStandby, self._evtSkillCutInStandby)
    EventManager.Global.UnRegisterEvent(EventType.SkillCutInPlay, self._evtSkillCutInPlay)
    return self;
end

---@private 技能切入动画待命
function SkillCutInMgr:SkillCutInStandby(isStandby) --是否显示战斗中有关的UI
    if isStandby then
        self._uiSkillCutIn = UIManager.getUI(UIName.UISkillCutIn, true)
    else
        UIManager.InterfaceCloseUI(UIName.UISkillCutIn)
        self._uiSkillCutIn = nil
    end
end

---@private 技能切入动画待命
function SkillCutInMgr:SkillCutInPlay(entId, skillTag)
    local ent = EntityCmd._entity(entId)
    --找实体。播发光特效。
    local heroTag = ent.CompInfo._heroConfigId
    self:PlaySceneEffect(entId)
    self:PlayUIAnim(heroTag, skillTag)
    self:PlaySound(heroTag)
end

---@private 播放场景特效
function SkillCutInMgr:PlaySceneEffect(entId)
    if self._effect == nil then
        self._effect = LuaCallCs.LoadPrefabSync(_sceneEffectPath)
        local root = LuaCallCs.GetEntityRootGameObject()
        LuaCallCs.SetParentAndReset(root, self._effect)
    end

    local x, y, z = EntityCmd.BattleActor.GetMountPosition(entId, BattleDefine.MountType.HitPoint)
    LuaCallCs.SetGameObjLocalPosition(self._effect, x, y, z)
    LuaCallCs.GameObjectActive(self._effect, true)

    LuaCallCs.UniTask.Delay(2000, function()
        if self._effect ~= nil then
            LuaCallCs.GameObjectActive(self._effect, false)
        end
    end)

end

---@private 播放UI技能切入动画
function SkillCutInMgr:PlayUIAnim(heroTag, skillTag)
    if self._uiSkillCutIn ~= nil then
        self._uiSkillCutIn:SkillCutInPlay(heroTag, skillTag)
    end
end

function SkillCutInMgr:PlaySound(heroTag)
    local cfg = SoundHelper.GetHeroCutInConfig(heroTag)
    if cfg == nil then
        print("SkillCutInMgr:PlaySound() - No sound config found for heroTag: " .. tostring(heroTag))
    end

    local path = cfg.path
    local asset = cfg.name
    local volume = cfg.volume
    --local priority = cfg.priority
    local assetPath = ""
    if not string.IsNilOrEmpty(path) and not string.IsNilOrEmpty(asset) then
        assetPath = path .. "/" .. asset
    end
    if assetPath ~= "" then
        LuaCallCs.Audio.AudioPlayVoice(assetPath, 0, volume)
    end
end




