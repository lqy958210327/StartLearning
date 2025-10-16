local SkillTimeEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/SkillTimeEntity")
local className = "SceneSwitchEventEntity"

---@class SceneSwitchEventEntity : SkillTimeEntity 场景切换事件实体
local SceneSwitchEventEntity = Class(className, SkillTimeEntity)
function SceneSwitchEventEntity:ctor(executeFrame, objectType, switchType, ultimateColor)
    self._objectType = objectType ---@type number 目标类型
    self._switchType = switchType ---@type boolean 开关事件 0:关闭 1:打开
    self._ultimateColor = ultimateColor ---@type number 终极技颜色
end

---@override
---@type fun(self:SceneSwitchEventEntity) 用于重写事件的执行逻辑。
function SceneSwitchEventEntity:OnExecute(entityUid, skillTag)
    print("SceneSwitchEventEntity:OnExecute, self._switchEvent:", self._switchEvent, " self._objectType:", self._objectType);  
    local active = self._switchType
    if self._objectType == SkillTimeEnumDefine.ObjectTypeEnum.Light then
        EventManager.Global.Dispatch(EventType.SceneMgrChangeObjectLight, active)
    elseif self._objectType == SkillTimeEnumDefine.ObjectTypeEnum.Object then
        EventManager.Global.Dispatch(EventType.SceneMgrChangeObjectUltimateColor, active, self._ultimateColor)
    elseif self._objectType == SkillTimeEnumDefine.ObjectTypeEnum.SkyBox then
        EventManager.Global.Dispatch(EventType.SceneMgrChangeObjectSkybox, active)
    elseif self._objectType == SkillTimeEnumDefine.ObjectTypeEnum.Effect then
        EventManager.Global.Dispatch(EventType.SceneMgrChangeObjectEffect, active)
    end
end

---@override
---@type fun(self:SceneSwitchEventEntity) 用于重写事件的字符串表示。
---@return string
function SceneSwitchEventEntity:ToString()
    return "SceneSwitchEventEntity ".."objectType:"..self._objectType.."; switchType:"..tostring(self._switchType)
end

return SceneSwitchEventEntity