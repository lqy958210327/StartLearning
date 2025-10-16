local getImpl = require "Core/Common/FrameBattle/Ability/getImpl"
local AbilityUnit = require "Core/Common/FrameBattle/Ability/AbilityUnit"
local Ability = require "Core/Common/FrameBattle/Ability/Ability"

local function MatrixAbility(logger, initInfo, frameLength, frameOutput, frameInput)
    local rootUnit = AbilityUnit(-1, logger)
    local ability = Ability('battle', initInfo.matrixInit.resId, 1, rootUnit)
    getImpl(rootUnit).abilityGroup:insert(ability)
    ability:onAttach()
    ability:battleInit(initInfo, frameLength, frameOutput, frameInput)
    return ability
end

return MatrixAbility