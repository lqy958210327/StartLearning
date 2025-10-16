local CueLogicConfig = ConstTable.CueLogicConfig
local ResSkillConfig = DataTable.ResSkillConfig

local CueLogicMediator = {}

function CueLogicMediator.getSkillCardCueId(cardId)
    local cardCueId = nil
    local cardData = ResSkillConfig[cardId] or {}
    cardData = cardData[1]
    if cardData and cardData.skill_cue == 1 then
        cardCueId = CueLogicConfig.SKILL_CARD_CUE_ID
    end
    return cardCueId
end

function CueLogicMediator.getStateHitedCueId(stateArgs)
    local hitedCueId = nil
    if stateArgs == "stun" then
        hitedCueId = CueLogicConfig.STUN_CUE_ID
    elseif stateArgs == "freeze" then
        hitedCueId = CueLogicConfig.FREEZE_CUE_ID
    elseif stateArgs == "sleep" then
        hitedCueId = CueLogicConfig.SLEEP_CUE_ID
    elseif stateArgs == "timelock" then
        hitedCueId = CueLogicConfig.TIMELOCK_CUE_ID
    end
    return hitedCueId
end

function CueLogicMediator.getBattleFetterCueId()
    return CueLogicConfig.BATTLE_FETTER_CUE_ID
end

return CueLogicMediator