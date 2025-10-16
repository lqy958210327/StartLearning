local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local PropConfig = BattleConst.PropConfig
local PropConfigMap = BattleConst.PropConfigMap

local PropBoard = {}

function PropBoard.set_default_props(owner)
    for _, propConfig in ipairs(PropConfig) do
        local propName = propConfig.propName
        owner[propName] = 0
    end
end

function PropBoard.init_props(owner)
    for _, propConfig in ipairs(PropConfig) do
        local propName = propConfig.propName
        local func = propConfig.calc
        owner[propName] = func(owner, propName)
    end
end

function PropBoard.update_prop(owner, propName, cb)
    cb = cb or owner
    local propConfig = PropConfigMap[propName]
    if propConfig.calc then
        local preValue = owner[propName] or 0
        owner[propName] = propConfig.calc(owner, propName)
        local f = cb["update_" .. propName]
        if f then
            f(cb, preValue)
        end
    end
    local cPropNames = propConfig and propConfig.relation
    if not cPropNames then
        return
    end
    local preValueRecorder = {}
    for i, cPropName in ipairs(cPropNames) do
        preValueRecorder[i] = owner[cPropName] or 0
    end
    for _, cPropName in ipairs(cPropNames) do
        local func = PropConfigMap[cPropName].calc
        owner[cPropName] = func(owner, cPropName)
    end
    for i, cPropName in ipairs(cPropNames) do
        local f = cb["update_" .. cPropName]
        if f then
            f(cb, preValueRecorder[i])
        end
    end
end

return PropBoard
