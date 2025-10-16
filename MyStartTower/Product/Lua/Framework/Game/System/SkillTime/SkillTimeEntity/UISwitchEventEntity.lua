local SkillTimeEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/SkillTimeEntity")
local className = "UISwitchEventEntity"

---@class UISwitchEventEntity : SkillTimeEntity 场景切换事件实体
local UISwitchEventEntity = Class(className, SkillTimeEntity)

function UISwitchEventEntity:ctor(executeFrame, uiType, switchType)
    self._uiType = uiType ---@type number 目标类型
    self._switchType = switchType ---@type boolean 开关事件
end

---@override
---@type fun(self:UISwitchEventEntity) 用于重写事件的执行逻辑。
function UISwitchEventEntity:OnExecute(entityUid, skillTag)
    print("UISwitchEventEntity:OnExecute")
    local active = self._switchType
    if self._uiType == SkillTimeEnumDefine.UITypeEnum.UIRoot then
        --LuaCallCsUtilCommon.SetUIRootActive(active)
        BattleProgressManager:Get():ShowBattleUI(active)
    --elseif self._uiType == SkillTimeEnumDefine.UITypeEnum.BattleNum then
    --    LuaCallCsUtilCommon.SetFloatingWordsDisplay(active)
    --    LuaCallCsUtilCommon.SetFloatingWordsPause(active)
    elseif self._uiType == SkillTimeEnumDefine.UITypeEnum.BossHp then
        -- ...
    elseif self._uiType == SkillTimeEnumDefine.UITypeEnum.BattleDamgeEffect then
        BattleProgressManager:Get():OpenBattleDamageEffectUI(active)
    elseif self._uiType == SkillTimeEnumDefine.UITypeEnum.BattleHealEffect then
        BattleProgressManager:Get():OpenBattleHealEffectUI(active)
    end

    -- LuaCallCsUtilCommon.SetUIRootEntityActive(active)
    -- LuaCallCsUtilCommon.SetUIRootModelActive(active)
end

---@override
---@type fun(self:UISwitchEventEntity) 用于重写事件的字符串表示。
---@return string
function UISwitchEventEntity:ToString()
    return "UISwitchEventEntity ".."uiType:"..self._uiType.."; switchType:"..tostring(self._switchType)
end

return UISwitchEventEntity