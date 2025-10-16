


-- 战斗单位特效管理器数据

---@class FxData
local FxData = Class("FxData")
function FxData:Load(resName, positionX, positionY, positionZ, eulerX, eulerY, eulerZ)
    self._obj = nil
    self._resName = resName
    LuaCallCs.LoadPrefabAsync(resName, function(res, obj)
        self._obj = obj
        LuaCallCs.GameObjectActive(obj, true)
        local root = LuaCallCs.GetEntityRootGameObject()
        LuaCallCs.SetParentAndReset(root, obj)
        LuaCallCs.Transform.SetPosition(obj, positionX, positionY, positionZ)
        LuaCallCs.Transform.SetEulerAngles(obj, eulerX, eulerY, eulerZ)
    end)
end
function FxData:Free()
    if self._obj then
        LuaCallCs.DisposePrefab(self._obj)
    else
        LuaCallCs.ReleasePrefab(self._resName)
    end
end

---@class EntityCompFx : BaseEntityComp
EntityCompFx = Class("EntityCompFx", BaseEntityComp)

function EntityCompFx:OnInit()
    --技能特效，跟随技能释放
    ---@type table<number, FxData[]>
    self._skillDict = {}
    --buff特效，跟随buff释放
    self._buffDict = {}
    --被动buff特效，跟随buff释放
    self._passiveDict = {}
    --其他特效，比如单位出场特效等
    self._otherDict = {}
end

function EntityCompFx:OnClear()
    for k, v in pairs(self._skillDict) do
        for i = 1, #v do
            v[i]:Free()
        end
    end
    self._skillDict = {}
end

function EntityCompFx:CreateFxData(resName, positionX, positionY, positionZ, eulerX, eulerY, eulerZ)
    local fxData = FxData()
    fxData:Load(resName, positionX, positionY, positionZ, eulerX, eulerY, eulerZ)
    return fxData
end

function EntityCompFx:ClearFxBySkillId(skillId)
    local dict = self._skillDict[skillId]
    if dict then
        for i = 1, #dict do
            dict[i]:Free()
        end
        self._skillDict[skillId] = nil
    end
end



