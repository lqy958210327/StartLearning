local SkillTimeEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/SkillTimeEntity")
local className = "CharacterSwitchEventEntity"

---@class CharacterSwitchEventEntity : SkillTimeEntity 场景切换事件实体
local CharacterSwitchEventEntity = Class(className, SkillTimeEntity)

function CharacterSwitchEventEntity:ctor(executeFrame, targetType, switchType)
    self._targetType = targetType ---@type number 目标类型
    self._switchType = switchType ---@type boolean 开关事件
end

---@override
---@type fun(self:CharacterSwitchEventEntity) 用于重写事件的执行逻辑。
function CharacterSwitchEventEntity:OnExecute(entityUid, skillTag)
    -- print("CharacterSwitchEventEntity:OnExecute")
    local active = self._switchType
    if self._targetType == SkillTimeEnumDefine.TargetTypeEnum.Self then
        EntityCmd.Mesh.ShowAttacker(entityUid, active)
    elseif self._targetType == SkillTimeEnumDefine.TargetTypeEnum.Targets then
        EntityCmd.Mesh.ShowTarget(entityUid, active)
    elseif self._targetType == SkillTimeEnumDefine.TargetTypeEnum.Others then
        EntityCmd.Mesh.ShowOther(entityUid, active)
    else
        EntityCmd.Mesh.ShowAll(entityUid, active)
    end
end

---@override
---@type fun(self:CharacterSwitchEventEntity) 用于重写事件的字符串表示。
---@return string
function CharacterSwitchEventEntity:ToString()
    return "CharacterSwitchEventEntity ".."targetType:"..self._targetType.."; switchType:"..tostring(self._switchType)
end

return CharacterSwitchEventEntity