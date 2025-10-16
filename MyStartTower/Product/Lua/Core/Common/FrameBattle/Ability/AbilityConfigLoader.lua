local AbilityConfigBattle = require("Core/Common/FrameBattle/Ability/AbilityConfigBattle")
local AbilityConfigPassive = require("Core/Common/FrameBattle/Ability/AbilityConfigPassive")
local AbilityConfigState = require("Core/Common/FrameBattle/Ability/AbilityConfigState")
local AbilityConfigSkill = require("Core/Common/FrameBattle/Ability/AbilityConfigSkill")
local AbilityConfigCard = require("Core/Common/FrameBattle/Ability/AbilityConfigCard")

local function loadConfig(configType, configName, logger)
    logger:debug('AbilityConfigLoader', 'loading', configType, configName)
    local default = nil
    if configType == 'passive' then
        default = AbilityConfigPassive(configName)
    elseif configType == 'state' then
        default = AbilityConfigState(configName)
    elseif configType == 'skill' then
        default = AbilityConfigSkill(configName)
    elseif configType == 'card' then
        default = AbilityConfigCard(configName)
    elseif configType == 'battle' then
        default = AbilityConfigBattle(configName)
    end
    local modname = 'Config/AbilityScript/'..configName..'_'..configType
    local ok = nil
    local script = nil
    local exist = not LuaCallCs or LuaCallCs.CheckLuaFileExist(modname)
    if exist then
        ok, script = pcall(require, modname)
    end
    if ok and script then
        if default then
            logger:debug('AbilityConfigLoader', 'load script with default', configType, configName)
            local function initWithDefault(ability)
                return script(ability, default)
            end
            return initWithDefault
        else
            logger:debug('AbilityConfigLoader', 'load script without default', configType, configName)
            return script
        end
    end
    if default then
        if script then
            logger:warn('AbilityConfigLoader', 'load default with errors in script!', configType, configName, script)
        else
            logger:debug('AbilityConfigLoader', 'load default', configType, configName)
        end
        return default
    end
    local errormsg = script or 'file not exists! '..modname
    logger:error('AbilityConfigLoader', 'load error', configType, configName, errormsg)
end

local AbilityConfigData = {}

local function AbilityConfigLoader(configType, configName, logger)
    local configTypeData = AbilityConfigData[configType]
    if configTypeData == nil then
        configTypeData = {}
        AbilityConfigData[configType] = configTypeData
    end
    local abilityConfig = configTypeData[configName]
    if abilityConfig == nil then
        abilityConfig = loadConfig(configType, configName, logger) or false
        configTypeData[configName] = abilityConfig
    end
    return abilityConfig or nil
end

return AbilityConfigLoader