local SkillTimeEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/SkillTimeEntity")
local className = "LoadAssetEventEntity"

---@class LoadAssetEventEntity : SkillTimeEntity 加载资源事件实体
local LoadAssetEventEntity = Class(className, SkillTimeEntity)

function LoadAssetEventEntity:ctor(executeFrame, eventTable)
    self._assetPath = eventTable.assetPath ---@type string
    self._assetType = eventTable.assetType ---@type number 资源类型
    self._parentType = eventTable.parentType ---@type SkillTimeEnumDefine.ParentTypeEnum 目标类型
end

---@override
---@type fun(self:LoadAssetEventEntity) 用于重写事件的执行逻辑。
function LoadAssetEventEntity:OnExecute(entityUid, skillTag)
    print("LoadAssetEventEntity:OnExecute")
    -- if self._parentType == SkillTimeEnumDefine.ParentTypeEnum.Self then
    --     print("LoadAssetEventEntity:OnExecute Self")
    -- elseif self._parentType == SkillTimeEnumDefine.ParentTypeEnum.Target then
    --     print("LoadAssetEventEntity:OnExecute Target")
    -- elseif self._parentType == SkillTimeEnumDefine.ParentTypeEnum.Scene then
    --     print("LoadAssetEventEntity:OnExecute Scene")
    -- end

    -- if self._assetType == SkillTimeEnumDefine.AssetTypeEnum.Timeline then
    --     print("LoadAssetEventEntity:OnExecute Prefab")
    -- elseif self._assetType == SkillTimeEnumDefine.AssetTypeEnum.Prefab then
    --     print("LoadAssetEventEntity:OnExecute Texture")
    -- end
    EntityCmd.Fx.AddSkillFx(entityUid, skillTag, self._assetPath)
    if self._assetType == SkillTimeEnumDefine.AssetTypeEnum.Timeline then
        print("LoadAssetEventEntity:OnExecute Timeline")
        EntityCmd.Fx.EffectPoolRootSetActive(false)
    end
end

---@override
---@type fun(self:LoadAssetEventEntity) 用于重写事件的字符串表示。
---@return string
function LoadAssetEventEntity:ToString()
    return "LoadAssetEventEntity ".."assetPath:"..self._assetPath.."; assetType:"..tostring(self._assetType).."; parentType:"..tostring(self._parentType)
end


return LoadAssetEventEntity
