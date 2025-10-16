local SkillTimeEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/SkillTimeEntity")
local className = "HUDSwitchEventEntity"

---@class HUDSwitchEventEntity : SkillTimeEntity 场景切换事件实体
local HUDSwitchEventEntity = Class(className, SkillTimeEntity)

function HUDSwitchEventEntity:ctor(executeFrame, targetType, switchType)
    self._switchType = switchType ---@type boolean 开关事件 0:关闭 1:打开
    self._targetType = targetType ---@type number 目标类型
end

---@override
---@type fun(self:HUDSwitchEventEntity) 用于重写事件的执行逻辑。
function HUDSwitchEventEntity:OnExecute(entityUid, skillTag)
    
    local active = self._switchType
    if self._targetType == SkillTimeEnumDefine.TargetTypeEnum.Self then
        EntityCmd.HUD.ShowAttacker(entityUid, active)
    elseif self._targetType == SkillTimeEnumDefine.TargetTypeEnum.Targets then
        EntityCmd.HUD.ShowTargets(entityUid, active)
    elseif self._targetType == SkillTimeEnumDefine.TargetTypeEnum.Others then
        EntityCmd.HUD.ShowOthers(entityUid, active)
    else
        EntityCmd.HUD.ShowAll(active)
    end
end


---@override
---@type fun(self:HUDSwitchEventEntity) 用于重写事件的字符串表示。
---@return string
function HUDSwitchEventEntity:ToString()
    return "HUDSwitchEventEntity ".."targetType:"..self._targetType.."; switchType:"..tostring(self._switchType)
end

return HUDSwitchEventEntity