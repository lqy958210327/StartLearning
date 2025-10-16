local getImpl = require "Core/Common/FrameBattle/Ability/getImpl"

local unpack = unpack or table.unpack

local loggerConfig = {
    onBattleFrame = 'tick'
}

local AbilityTrigger = {}

local function logError(err)
    return err .. ' ' .. debug.traceback()
end

local function logcall(ability, triggerName, f, ...)
    local logger = ability:getLogger()
    local method = loggerConfig[triggerName] or 'trace'
    logger[method](logger, 'CallTrigger', triggerName, ...)
    local results = {xpcall(f, logger.traceback, ability, ...)}
    local ok = results[1]
    if not ok then
        local err = results[2]
        logger:error('TriggerError', triggerName, err)
    else
        local maxIndex = 0
        for k in pairs(results) do
            if k > maxIndex then
                maxIndex = k
            end
        end
        if maxIndex > 1 then
            logger[method](logger, 'TriggerReturn', triggerName, unpack(results, 2, maxIndex))
            return unpack(results, 2, maxIndex)
        end
    end
end

function AbilityTrigger.callGroup(ability, triggerGroup, triggerName, group, ...)
    local f = ability:inquiryGroupTrigger(triggerGroup, triggerName, group)
    if f then
        return logcall(ability, triggerName, f, ...)
    end
    return AbilityTrigger.call(ability, triggerName, group, ...)
end

function AbilityTrigger.call(ability, triggerName, ...)
    local f = ability:inquiryTrigger(triggerName)
    if f then
        return logcall(ability, triggerName, f, ...)
    end
end

function AbilityTrigger.unit(unit, triggerName, ...)
    getImpl(unit).abilityGroup:forEach(AbilityTrigger.call, triggerName, ...)
end

function AbilityTrigger.global(unit, triggerName, ...)
    getImpl(unit).unitGroup:forEach(AbilityTrigger.unit, triggerName, ...)
end

return AbilityTrigger