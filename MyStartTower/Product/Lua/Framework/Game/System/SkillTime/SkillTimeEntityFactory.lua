local SceneSwitchEventEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/SceneSwitchEventEntity")
local CharacterSwitchEventEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/CharacterSwitchEventEntity")
local LoadAssetEventEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/LoadAssetEventEntity")
local HUDSwitchEventEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/HUDSwitchEventEntity")
local UISwitchEventEntity = require("Framework/Game/System/SkillTime/SkillTimeEntity/UISwitchEventEntity")

---@class SkillTimeEntityFactory
SkillTimeEntityFactory = {}

---@param curFrame number 当前帧
---@param event table 事件
---@return table | nil 事件实体表格
function SkillTimeEntityFactory.Creator(curFrame,endFrame, event, skillTag)
    local eventEntity = nil
    local eventName = event.EventName
    local duration = event.switchEvent and event.switchEvent.durationFrame or 0
    local nextEntityExecuteFrame = curFrame + duration
    if nextEntityExecuteFrame > endFrame then
        --local errorMsg = string.format("SkillTimeEvent配置错误! 技能:%d, 第%d帧，事件名：%s，执行帧: %d > 结束帧: %d", skillTag, curFrame, eventName, nextEntityExecuteFrame, endFrame)
        --LuaCallCsUtilCommon.LogError(errorMsg)
        nextEntityExecuteFrame = endFrame
    end
    if eventName == "SceneSwitchEvent" then
        local objectType = event.objectTypeEnum
        local swtichType = event.switchEvent.switchType == 1
        local ultimateColor = event.ultimateColor == nil and SkillTimeHelper.DefaultUltimateColor() or event.ultimateColor
        eventEntity = SceneSwitchEventEntity(curFrame, objectType, swtichType, ultimateColor)
        local nextEntity = SceneSwitchEventEntity(nextEntityExecuteFrame, objectType, not swtichType, ultimateColor)
        eventEntity:SetNextEntity(nextEntity)

    elseif eventName == "CharacterSwitchEvent" then
        local targetType = event.targetTypeEnum
        local swtichType = event.switchEvent.switchType == 1
        eventEntity = CharacterSwitchEventEntity(curFrame, targetType, swtichType)
        local nextEntity = CharacterSwitchEventEntity(nextEntityExecuteFrame, targetType, not swtichType)
        eventEntity:SetNextEntity(nextEntity)

    elseif eventName == "LoadAssetEvent" then
        eventEntity = LoadAssetEventEntity(curFrame, event)

    elseif eventName == "HUDSwitchEvent" then
        local targetType = event.targetTypeEnum
        local swtichType = event.switchEvent.switchType == 1
        eventEntity = HUDSwitchEventEntity(curFrame, targetType, swtichType)
        local nextEntity = HUDSwitchEventEntity(nextEntityExecuteFrame, targetType, not swtichType)
        eventEntity:SetNextEntity(nextEntity)

    elseif eventName == "UISwitchEvent" then
        local uiType = event.uiType
        local swtichType = event.switchEvent.switchType == 1
        eventEntity = UISwitchEventEntity(curFrame, uiType, swtichType)
        local nextEntity = UISwitchEventEntity(nextEntityExecuteFrame, uiType, not swtichType)
        eventEntity:SetNextEntity(nextEntity)
    end

    return eventEntity
end

return SkillTimeEntityFactory