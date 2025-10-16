---@class Ability
---@classmod Ability
------
---单位的一项能力，可以是主动技能或被动技能

local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local getImpl = require "Core/Common/FrameBattle/Ability/getImpl"
local Group = require("Core/Common/FrameBattle/Ability/Group")
local AbilityConfigLoader = require "Core/Common/FrameBattle/Ability/AbilityConfigLoader"
local AbilityTrigger = require("Core/Common/FrameBattle/Ability/AbilityTrigger")
local AbilityFilter = require("Core/Common/FrameBattle/Ability/AbilityFilter")
local BattleConst = AbilityDataTable.BattleConst
local ResBattleTrap = AbilityDataTable.ResBattleTrap
local Enum = require("Core/Common/FrameBattle/Ability/Enum")

local tableunpack = table.unpack or unpack

local Ability = {}

local function getOwnerImpl(ability)
    return getImpl(ability:getOwnerUnit())
end

local function toString(self)
    return self._name
end

local AbilityMt = {__index = Ability, __tostring = toString}

--- 创建新能力对象
---@param configType string 配置类型（"skill"/"state"/"card"等）
---@param configName string 配置名称
---@param skillLevel integer 技能等级
---@param ownerUnit Unit 所属单位
---@param fromAbility Ability 施加来源能力
---@param fromUnit Unit 施加来源单位
---@param sourceAbility Ability 根源能力
---@param sourceUnit Unit 根源单位
---@return Ability
local function newAbility(configType, configName, skillLevel, ownerUnit, fromAbility, fromUnit, sourceAbility, sourceUnit)
    local loaderLogger = fromAbility and fromAbility._logger or getImpl(ownerUnit).logger
    local abilityConfig = configType and AbilityConfigLoader(configType, configName, loaderLogger)
    local name = string.format('%s_%s@%s', configType or '@', configName or '', ownerUnit or '')
    local ability = {
        _name = name,
        _configType = configType,
        _configName = configName,
        _abilityConfig = abilityConfig,
        _skillLevel = skillLevel or (fromAbility and fromAbility._skillLevel) or 1,
        _ownerUnit = ownerUnit,
        _fromAbility = fromAbility,
        _fromUnit = fromUnit or (fromAbility and fromAbility._ownerUnit),
    }
    ability._sourceAbility = sourceAbility or fromAbility or ability
    ability._sourceUnit = sourceUnit or (fromAbility and fromAbility._sourceUnit) or ownerUnit
    setmetatable(ability, AbilityMt)
    ability._logger = loaderLogger:newLogger('Ability', ability)
    if abilityConfig ~= nil then
        if type(abilityConfig) == "table" then
            ability:registerTriggerTable(abilityConfig)
        else
            abilityConfig(ability)
        end
    end
    return ability
end

--- @table Enum
--- @see Enum
Ability.Enum = Enum

function Ability:getLogger()
    return self._logger
end

function Ability:log(...)
    return self._logger:debug(...)
end
--- 获取能力配置信息
---@return string configType 配置类型
---@return string configName 配置名称
function Ability:getConfig()
    return self._configType, self._configName
end

--- 取技能等级
---@return integer
function Ability:getSkillLevel()
    return self._skillLevel
end

--- 取所在单位
---@return Unit @返回能力所属的宿主单位实例
function Ability:getOwnerUnit()
    return self._ownerUnit
end

--- 取直接来源能力（父能力）
---@return Ability|nil @返回直接创建此能力的父能力。若没有父能力则返回nil
function Ability:getFromAbility()
    return self._fromAbility
end

--- 取直接来源单位（施加者单位）
---@return Unit|nil @返回直接施加此能力的单位。如果是自身创建的能力则返回nil
function Ability:getFromUnit()
    return self._fromUnit
end

--- 取最初来源能力（根源能力）
---@return Ability @返回最初创建此能力的根源能力。当能力被多次传递时，始终指向最原始的创建能力
---@usage 能力A创建能力B，B创建能力C，则C的sourceAbility是A
function Ability:getSourceAbility()
    return self._sourceAbility
end

--- 取最初来源单位（根源单位）
---@return Unit @返回最初施加能力的根源单位。当能力被多次传递时，追踪到最原始的施加者
---@usage 单位A施加给B，B再施加给C，则C能力的sourceUnit仍是A
function Ability:getSourceUnit()
    return self._sourceUnit
end

--- 取所在单位正在使用的主动技能信息
--- @return Ability|nil 技能的信息，包含（skillId,cardId,cardType)字段，如果当前没在放技能返回nil
function Ability:getOwnerUsingSkillInfo()
    return getImpl(self:getOwnerUnit()).usingSkillInfo
end

--- 取所在单位正在使用的主动技能的瞄准目标
--- @return Unit|nil 技能目标的Unit对象，如果当前没在放技能返回nil
function Ability:getOwnerAimUnit()
    return getImpl(self:getOwnerUnit()).aimUnit
end


--- 注册各种触发器
--- @param triggerTable table 触发函数表
function Ability:registerTriggerTable(triggerTable)
    self._triggerTableList = self._triggerTableList or {}
    table.insert(self._triggerTableList, 1, triggerTable)
end

--- 获取触发函数表。
--- @param index number 触发函数表的索引，当前函数表是1，底层函数表是2
--- @return table 指定的触发函数表
--- - 注意：不要修改底层触发函数表
function Ability:getTriggerTable(index)
    return self._triggerTableList and self._triggerTableList[index]
end

--- 获取事件处理函数。
--- @see getTriggerTable
--- - 仅限系统内部使用。
function Ability:inquiryTrigger(triggerName)
    for _, map in ipairs(self._triggerTableList) do
        local f = map[triggerName]
        if f then
            return f
        end
    end
end

--- 获取事件处理函数。
--- @see getTriggerTable
--- - 仅限系统内部使用。
function Ability:inquiryGroupTrigger(triggerGroup, triggerName, groupId)
    for _, map in ipairs(self._triggerTableList) do
        local g = map[triggerGroup]
        local gf = g and g[groupId]
        local f = gf and gf[triggerName]
        if f then
            return f
        end
    end
end


--- 扩展方法
--- - 仅限系统内部使用。在配置脚本中，推荐用触发回调函数处理业务逻辑。
function Ability:addMetatableIndexExtension(index)
    local meta = getmetatable(self)
    setmetatable(index, {__index = meta.__index})
    setmetatable(self, {__index = index, __tostring = meta.__tostring})
end

--- 获取当前堆叠层数
--- @return integer 当前生效的总层数（默认返回0）
function Ability:getStackLayer()
    return self._layer or 0
end

--- 获取永久生效的固定层数（无时间限制的层数）
--- @return integer 固定层数
function Ability:getPermanentLayer()
    return self:getStackLayer() - self:getTemporaryLayer()
end

--- 获取时限生效的临时层数（有时间限制的层数）
--- @return integer 临时层数
function Ability:getTemporaryLayer()
    return self._tempLayerSum or 0  -- 新增缓存字段
end


local function checkRemoveLayer(self, oldLayer)
    if oldLayer ~= self._layer then
        if self.stateId then
            if self._layer and self._layer > 0 then
                self:addOutput( BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE, {self:getSourceUnit():getId(), self.stateId, self:getSkillLevel(), self:getStackLayer()} )
            else
                self:addOutput( BattleConst.MATRIX_EVENT_ENTITY_DELSTATE, {self:getSourceUnit():getId(), self.stateId, self:getSkillLevel(), self:getStackLayer()} )
            end
        end
        AbilityTrigger.call(self, 'onSelfStackLayerChange', self._layer or 0, oldLayer)
        if self._layer and self._layer <= 0 then
            self:detach()
        end
        local ownerUnit = self:getOwnerUnit()
        AbilityTrigger.unit(ownerUnit, 'onOwnerStateLayerChange', self)
    end
end

--- 增加堆叠层数（支持定时衰减）
--- @param addLayer integer 要增加的层数（必须>0）
--- @param time number|nil 持续时间（秒），nil表示永久层数
------
--- - 功能说明：
--- 1. 实际增加层数可能被'onCheckIncStackLayer'回调修改
--- 2. 临时层数会创建计时器，到期自动移除对应层数
--- 3. 设置time=0会创建瞬时计时器，在当前帧或下一帧自动移除
--- 4. onCheckIncStackLayer返回值小于参数addLayer时，替换最老的若干层临时层数
function Ability:incStackLayer(addLayer, time)
    local diffLayer = AbilityTrigger.call(self, 'onCheckIncStackLayer', addLayer)
    if not diffLayer then
        return
    end
    local oldLayer = self._layer or 0
    if not self._layerList then
        self._layerList = {}
        self._tempLayerSum = 0
    end
    local layerList = self._layerList
    --更新最早的若干层的时间
    local delLayer = math.max(0, math.min(self._tempLayerSum, addLayer - diffLayer))
    local toDel = delLayer
    while toDel > 0 do
        local layer1 = layerList[1]
        local del1 = math.min(layer1.layer, toDel)
        toDel = toDel - del1
        self._tempLayerSum = self._tempLayerSum - del1
        layer1.layer = layer1.layer - del1
        if layer1.layer <= 0 then
            table.remove(layerList, 1)
        end
    end
    --增加层数
    local layer = diffLayer + delLayer
    if layer <= 0 then
        return
    end
    if not time then
        --增加永久层数
        self._layer = oldLayer + layer
        checkRemoveLayer(self, oldLayer)
        return
    end
    self._tempLayerSum = self._tempLayerSum + layer
    self._layer = (self._layer or 0) + layer
    local layerData = {layer = layer}
    table.insert(self._layerList, layerData)
    local function removeLayer()
        for i = #self._layerList, 1, -1 do
            if self._layerList[i] == layerData then
                local nowLayer = self._layer
                self._layer = nowLayer - layerData.layer
                self._tempLayerSum = self._tempLayerSum - layerData.layer
                table.remove(self._layerList, i)
                checkRemoveLayer(self, nowLayer)
                break
            end
        end
    end
    self:createTimer(layerData, time, removeLayer)
    checkRemoveLayer(self, oldLayer)
end

--- 减少堆叠层数（立即生效）
--- @param layer integer 要移除的层数（默认1）
--- - 优先扣除永久层数，剩余部分从最后添加的临时层开始扣除
--- 临时层数扣减时会取消对应定时器
function Ability:decStackLayer(layer)
    layer = layer or 1
    if layer <= 0 or (self._layer or 0) <= 0 then return end
    local oldLayer = self._layer
    local permanentLayer = self:getPermanentLayer()
    local reducePermanent = math.min(layer, permanentLayer)
    if reducePermanent > 0 then
        self._layer = oldLayer - reducePermanent
        layer = layer - reducePermanent
    end
    while layer > 0 and self._layerList and #self._layerList > 0 do
        local data = self._layerList[#self._layerList]
        local reduce = math.min(layer, data.layer)
        data.layer = data.layer - reduce
        self._tempLayerSum = self._tempLayerSum - reduce
        self._layer = self._layer - reduce
        layer = layer - reduce
        if data.layer <= 0 then
            self:removeTimer(data)
            table.remove(self._layerList)  -- 移除最后一个元素效率更高
        end
    end
    checkRemoveLayer(self, oldLayer)
end

--- 设置堆叠层数。
--- @param layer integer 目标的层数
--- @param time number|nil 如果目标层数比当前层数高，设置持续时间，nil表示永久
--- - 根据当前层数与目标层数之差增加或减少堆叠层数
--- 实际增加层数可能被'onCheckIncStackLayer'回调修改，因此最终结果可能不是目标层数
--- @see incStackLayer
--- @see decStackLayer
function Ability:setStackLayer(layer, time)
    local oldLayer = self._layer or 0
    local needLayer = layer or 0
    if oldLayer < needLayer then
        self:incStackLayer(needLayer - oldLayer, time)
    elseif oldLayer > needLayer then
        self:decStackLayer(oldLayer - needLayer)
    end
end

function Ability:addStateGroupList(list)
    for _, group in ipairs(list) do
        self:addStateGroup(group)
    end
end

--- 添加状态组到能力对象
--- @param group integer 要添加的状态组标识
function Ability:addStateGroup(group)
    if self._stateGroup == nil then
        self._stateGroup = {}
    end
    self._stateGroup[group] = true
end

--- 检查能力对象是否拥有指定状态组
--- @param group integer 要检查的状态组标识
--- @return boolean 如果拥有状态组则返回true，否则返回false
function Ability:hasStateGroup(group)
    if self._stateGroup == nil then
        return false
    end
    return self._stateGroup[group]
end

--- 从能力对象中移除指定状态组
--- @param group integer 要移除的状态组标识
function Ability:removeStateGroup(group)
    if self._stateGroup == nil then
        return
    end
    self._stateGroup[group] = nil
end

--- 注册定时器
--- @param timerId notnil 随便编
--- @param timeout float 时间，秒
--- @param func function 到时间要执行的函数
function Ability:createTimer(timerId, timeout, func, ...)
    self:removeTimer(timerId)
    if self._timerList == nil then
        self._timerList = {}
    end
    local timerList = self._timerList
    local ownerUnit = self:getOwnerUnit()
    local timeoutFrame = math.floor(timeout * ownerUnit:getFramePerSec())
    local beginFrame = ownerUnit:getRealFrameNumber()
    local timer = {timerId = timerId, timeoutFrame = timeoutFrame, beginFrame = beginFrame, func = func, args = {...}}
    table.insert(timerList, timer)
end

--- 延长定时器
--- @param timerId notnil 已注册的定时器ID
--- @param timeout float 时间，秒
function Ability:extendTimer(timerId, timeout)
    if self._timerList == nil then
        return
    end
    local timerList = self._timerList
    local ownerUnit = self:getOwnerUnit()
    local timeoutFrame = math.floor(timeout * ownerUnit:getFramePerSec())
    for i, timer in ipairs(timerList) do
        if timer.timerId == timerId then
            timer.timeoutFrame = timer.timeoutFrame + timeoutFrame
            return
        end
    end
end

--- 注册循环定时器
--- @param timerId notnil 随便编
--- @param timeout float 间隔时间，秒
--- @param func function 到时间要执行的函数
function Ability:createRepeatingTimer(timerId, timeout, func, ...)
    local function repeating(...)
        self:createTimer(timerId, timeout, repeating, ...)
        func(...)
    end
    self:createTimer(timerId, timeout, repeating, ...)
end

--- 注册循环技能定时器
--- @param timerId notnil 随便编
--- @param timeout float 间隔时间，秒
--- @param func function 到时间要执行的函数
---
--- - 与普通定时器的区别是在大招暂停期间攻击方的技能定时器继续走
function Ability:createRepeatingSkillTimer(timerId, timeout, func, ...)
    local function repeating(...)
        self:createSkillTimer(timerId, timeout, repeating, ...)
        func(...)
    end
    self:createSkillTimer(timerId, timeout, repeating, ...)
end

--- 取消定时器
--- @param timerId notnil 随便编
function Ability:removeTimer(timerId)
    if self._timerList == nil then
        return
    end
    local timerList = self._timerList
    for i, timer in ipairs(timerList) do
        if timer.timerId == timerId then
            table.remove(timerList, i)
            return
        end
    end
end
--- 注册技能定时器
--- @param timerId notnil 随便编
--- @param timeout float 时间，秒
--- @param func function 到时间要执行的函数
---
--- - 与普通定时器的区别是在大招暂停期间攻击方的技能定时器继续走
function Ability:createSkillTimer(timerId, timeout, func, ...)
    self:removeSkillTimer(timerId)
    if self._skillTimerList == nil then
        self._skillTimerList = {}
    end
    local timerList = self._skillTimerList
    local ownerUnit = self:getOwnerUnit()
    local timeoutFrame = math.floor(timeout * ownerUnit:getFramePerSec())
    local beginFrame = ownerUnit:getFrameNumber()
    local timer = {timerId = timerId, timeoutFrame = timeoutFrame, beginFrame = beginFrame, func = func, args = {...}}
    table.insert(timerList, timer)
end

--- 取消技能定时器
--- @param timerId notnil 随便编，与setSkillTimer对应
function Ability:removeSkillTimer(timerId)
    if self._skillTimerList == nil then
        return
    end
    local timerList = self._skillTimerList
    for i, timer in ipairs(timerList) do
        if timer.timerId == timerId then
            table.remove(timerList, i)
            return
        end
    end
end

--- 技能暂停。
--- @param pauseFrame number 暂停的逻辑帧数
--- - 仅限系统内部使用，播放大招期间非攻击者的技能定时器暂停。
function Ability:skillPauseFrame(pauseFrame)
    if self._skillTimerList then
        local timerList = self._skillTimerList
        for _, timer in ipairs(timerList) do
            timer.pauseFrame = (timer.pauseFrame or 0) + pauseFrame
        end
    end
end

--- 每帧检查定时器。
--- - 仅限系统内部使用。
function Ability:tick(frameNumber, realFrameNumber)
    if self._skillTimerList then
        local timerList = self._skillTimerList
        repeat
            local kickTimer = nil
            for idx, timer in ipairs(timerList) do
                if timer.beginFrame + timer.timeoutFrame + (timer.pauseFrame or 0) <= frameNumber then
                    kickTimer = timer
                    table.remove(timerList, idx)
                    timer.func(tableunpack(timer.args))
                end
            end
        until kickTimer == nil
    end
    if self._timerList then
        local timerList = self._timerList
        repeat
            local kickTimer = nil
            for idx, timer in ipairs(timerList) do
                if timer.beginFrame + timer.timeoutFrame <= realFrameNumber then
                    kickTimer = timer
                    table.remove(timerList, idx)
                    timer.func(tableunpack(timer.args))
                end
            end
        until kickTimer == nil
    end
end

--- 设置冷却时间
--- @param cooldownId any 随便编
function Ability:setCooldown(cooldownId)
    if self._cooldownMap == nil then
        self._cooldownMap = {}
    end
    local cooldownMap = self._cooldownMap
    local ownerUnit = self:getOwnerUnit()
    local nowFrame = ownerUnit:getRealFrameNumber()
    cooldownMap[cooldownId] = nowFrame
end

--- 清除冷却
--- @param cooldownId any 与设置冷却时间的cooldownId对应
--- @see setCooldown
function Ability:unsetCooldown(cooldownId)
    if self._cooldownMap then
        self._cooldownMap[cooldownId] = nil
    end
end

--- 判断冷却时间
--- @param cooldownId any 与设置冷却时间的cooldownId对应
--- @param time number 冷却时间
--- @return boolean 成功返回true
--- @see setCooldown
function Ability:getCooldown(cooldownId, time)
    if self._cooldownMap == nil then
        return true
    end
    local cooldownMap = self._cooldownMap
    local ownerUnit = self:getOwnerUnit()
    local nowFrame = ownerUnit:getRealFrameNumber()
    local cdFrame = math.floor(time * ownerUnit:getFramePerSec())
    local cooldownFrame = cooldownMap[cooldownId]
    if cooldownFrame and cooldownFrame + cdFrame > nowFrame then
        return false
    end
    return true
end

--- 检查冷却时间
--- @param cooldownId any 与设置冷却时间的cooldownId对应
--- @param time number 冷却时间
--- @return boolean 成功返回true，并记录本次发生时间
function Ability:checkCooldown(cooldownId, time)
    if self._cooldownMap == nil then
        self._cooldownMap = {}
    end
    local cooldownMap = self._cooldownMap
    local ownerUnit = self:getOwnerUnit()
    local nowFrame = ownerUnit:getRealFrameNumber()
    local cdFrame = math.floor(time * ownerUnit:getFramePerSec())
    local cooldownFrame = cooldownMap[cooldownId]
    if cooldownFrame and cooldownFrame + cdFrame > nowFrame then
        return false
    end
    cooldownMap[cooldownId] = nowFrame
    return true
end

--- 累加计数
--- @param countId any 随便编
--- @param addValue number 计数增加值
--- @param untilValue number 计数目标值
--- @return boolean 计数达到则返回true，并清空计数
function Ability:addCountUntil(countId, addValue, untilValue)
    if self._countMap == nil then
        self._countMap = {}
    end
    local count = (self._countMap[countId] or 0) + addValue
    if count >= untilValue then
        self._countMap[countId] = nil
        return true
    else
        self._countMap[countId] = count
    end
end

--- 清除计数
--- @param countId any 与addCountUntil对应
--- @see addCountUntil
function Ability:clearCount(countId)
    if self._countMap then
        self._countMap[countId] = nil
    end
end

--- 增加子能力
--- @param ability Ability 子能力对象
--- - 当本能力结束时子能力也结束
function Ability:addSubAbility(ability)
    if self._childGroup == nil then
        self._childGroup = Group()
    end
    local childGroup = self._childGroup
    childGroup:insert(ability)
end


--- 获取战场随机数生成器
--- @return RandomGenerator 随机数生成器对象
--- - 不建议在配置层直接使用，应通过封装好的随机方法操作
function Ability:getRandomGenerator()
    return getOwnerImpl(self).matrixAbility.randomGenerator
end

--- 生成区间随机整数
--- @param max integer 最大值（包含）
--- @return integer 随机数范围 [1, max]
function Ability:getRandomInt(max)
    return self:getRandomGenerator():random(1, max)
end

--- 从列表中随机选择一个元素
--- @param list table 候选列表
--- @return any 随机选择的元素，如果列表为空，则返回nil
function Ability:getRandomChoice(list)
    if not list or not next(list) then
        return nil
    end
    if #list == 1 then
        return list[1]
    end
    local n = self:getRandomGenerator():random(1, #list)
    return list[n]
end

--- 概率判定（万分比）
--- @param prob integer 概率值，范围 [0,10000]，例如：输入3000表示30%概率
--- @return boolean 是否命中
function Ability:getRandomProb(prob)
    local n = self:getRandomGenerator():random(1, 10000)
    return n <= prob
end

--- 随机打乱列表顺序（Fisher-Yates算法）
--- @param list table 需要打乱的可变列表
--- @return table 原列表引用（已原地修改）
--- - 注意：会直接修改传入的列表
function Ability:randomShuffle(list)
    local iterations = #list
    for i = iterations, 2, -1 do
        local j = self:getRandomInt(i)
        list[i], list[j] = list[j], list[i]
    end
    return list
end

--- 给目标单位添加新能力
--- @param targetUnit Unit 要附加能力的目标单位（必填）
--- @param configType string 能力配置类型（"skill"/"state"/"card"等，必填）
--- @param configName integer|string 能力配置名称（对应配置表中的ID，必填）
--- @param skillLevel integer|nil 能力等级（用于技能等级计算，可选，默认继承父能力等级）
--- @param fromUnit Unit|nil 施加者单位（可选，nil表示使用当前能力的施加者单位）
--- @return Ability|nil 成功返回新创建的能力对象，失败返回nil
------
--- - 功能说明：
--- 1. 创建新能力对象，继承当前能力的来源信息
--- 2. 触发能力附加前的检查（onCheckAttach 回调）
--- 3. 触发能力附加成功事件（onSelfAttach 回调）
--- 4. 当目标单位已存在相同配置的能力时，会创建新的独立能力实例
--- 5. 若需要合并层数，应使用 `incStateLayer` 系列方法
--- @usage local fireSkill = ability:addAbility(target, "skill", "fire_blast", 3)
function Ability:addAbility(targetUnit, configType, configName, skillLevel, fromUnit)
    self:log('addAbility', targetUnit, configType, configName, skillLevel)
    local ability = newAbility(configType, configName, skillLevel, targetUnit, self, nil, nil, fromUnit)
    if AbilityTrigger.call(ability, 'onCheckAttach') then
        return nil
    end
    getImpl(targetUnit).abilityGroup:insert(ability)
    AbilityTrigger.call(ability, 'onSelfAttach')
    return ability
end

--- 移除目标单位的一项能力
--- @param targetUnit Unit     目标单位
--- @param ability Ability     被移除的能力
--- @param fromUnit Unit|nil   施加者单位（nil时使用当前能力施加者）
function Ability:delAbility(targetUnit, ability, fromUnit)
    if getImpl(targetUnit).abilityGroup:remove(ability) then
        fromUnit = fromUnit or self:getOwnerUnit()
        AbilityTrigger.call(ability, 'onSelfDettach', self, fromUnit)
    end
end

--- 查找并移除目标单位符合条件的能力
--- @param targetUnit Unit      目标单位
--- @param filter function     能力过滤器（可通过AbilityFilter工具类创建）
--- @param fromUnit Unit|nil    施加者单位（nil时使用当前能力施加者）
function Ability:findDelAbility(targetUnit, filter, fromUnit)
    local ability = targetUnit:findAbility(filter)
    if ability then
        self:delAbility(targetUnit, ability, fromUnit)
    end
end

--- 从所属单位移除当前能力（级联移除所有子能力）
--- @param fromAbility Ability  触发移除的根源能力（用于事件溯源）
--- @param fromUnit Unit        触发移除的施加单位
------
--- - 功能说明：
--- 1. 递归移除通过addSubAbility添加的所有子能力
--- 2. 触发onDettach生命周期事件
--- 3. 从单位abilityGroup中移除自身
--- 注意：这是能力移除的标准方法，直接操作abilityGroup可能造成状态不一致
function Ability:detach(fromAbility, fromUnit)
    local ownerUnit = self:getOwnerUnit()
    local childGroup = self._childGroup
    if childGroup then
        local function detachChild(ability)
            ability:detach(fromAbility, fromUnit)
        end
        childGroup.forEach(detachChild)
    end
    self:clearAttrBuff()
    if getImpl(ownerUnit).abilityGroup:remove(self) then
        AbilityTrigger.call(self, 'onDettach', fromAbility or self, fromUnit or ownerUnit)
    end
end

--- 设置为指定标签的独占能力（同标签能力只能存在一个）
--- @param exclusiveTag string   独占类型标识
--- @return boolean              是否发生能力替换（true=替换旧能力，false=已是当前能力不变）
------
--- - 新旧能力替换时会触发旧能力的onSelfDettach事件
--- - 同个标签多次调用安全，不会重复触发事件
function Ability:setExclusiveAbility(exclusiveTag)
    local ownerUnit = self:getOwnerUnit()
    local exclusiveMap = getImpl(ownerUnit).exclusiveMap
    local oldAbility = exclusiveMap[exclusiveTag]
    if oldAbility == self then
        return false
    end
    exclusiveMap[exclusiveTag] = self
    if oldAbility then
        self:delAbility(ownerUnit, oldAbility)
    end
    return true
end

--- 解除当前能力的独占状态
--- @param exclusiveTag string   需要解除的独占标签（必须与set时一致）
--- @return boolean              是否成功解除（true=解除成功，false=非当前独占能力）
------
--- - 状态自然结束时会自动调用
--- - 主动替换能力时应优先使用setExclusiveAbility
function Ability:unsetExclusiveAbility(exclusiveTag)
    local ownerUnit = self:getOwnerUnit()
    local exclusiveMap = getImpl(ownerUnit).exclusiveMap
    local oldAbility = exclusiveMap[exclusiveTag]
    if oldAbility == self then
        exclusiveMap[exclusiveTag] = nil
        return true
    end
    return false
end

--- 判断是否是当前独占能力
--- @param exclusiveTag string   需要解除的独占标签（必须与set时一致）
function Ability:isExclusive(exclusiveTag)
    local ownerUnit = self:getOwnerUnit()
    local exclusiveMap = getImpl(ownerUnit).exclusiveMap
    local oldAbility = exclusiveMap[exclusiveTag]
    return oldAbility == self
end

--- 设置状态标签列表
--- @param tagList string[]       标签数组（如{"Buff","Debuff"}）
--- @usage
--- 标记为增益状态：
--- ability:setTagList({"Buff", "AtkBoost"})
function Ability:setTagList(tagList)
    self._tagList = tagList
end

--- 获取当前状态标签列表
--- @return string[]|nil          返回标签数组（修改影响原始数据）
--- @usage
--- if ability:getTagList() and table.contains(ability:getTagList(), "Control") then
---     print("这是一个控制类状态")
--- end
function Ability:getTagList()
    return self._tagList
end

--- 判断是否包含指定标签
--- @param tag string             要检查的标签（区分大小写）
--- @return boolean               存在返回true
--- @usage
--- 检查是否为眩晕状态：
--- if ability:hasTag("Stun") then
---     target:beStunned()
--- end
function Ability:hasTag(tag)
    local tagList = self._tagList
    if tagList then
        for _, tagName in ipairs(tagList) do
            if tagName == tag then
                return true
            end
        end
    end
    return false
end

--- 增加来源绑定的状态层数（仅合并同来源状态）
--- @param targetUnit Unit 要附加能力的目标单位（必填）
--- @param stateId integer     状态配置ID（对应ResStateData.id）
--- @param skillLevel integer  技能等级
--- @param layer integer       叠加层数
--- @param time number|nil 持续时间（秒），nil表示永久层数
---
--- - 不存在时创建新状态，存在时调用incStackLayer叠加
--- - 用于中毒、灼烧等多来源可叠加状态
function Ability:incStateLayer(targetUnit, stateId, skillLevel, layer, time)
    local filter = AbilityFilter.filterState(stateId, self:getSourceUnit())
    local ability = targetUnit:findAbility(filter) or self:addAbility(targetUnit, 'state', stateId, skillLevel)
    if ability then
        ability:incStackLayer(layer, time)
    end
end

--- 增加唯一状态层数（合并不同来源状态）
--- @param targetUnit Unit 要附加能力的目标单位（必填）
--- @param stateId integer     状态配置ID（对应ResStateData.id）
--- @param skillLevel integer  技能等级
--- @param layer integer       叠加层数
--- @param time number|nil 持续时间（秒），nil表示永久层数
---
--- - 用于全局唯一的状态管理（如眩晕、沉默等控制状态）
function Ability:incUniqueStateLayer(targetUnit, stateId, skillLevel, layer, time)
    local filter = AbilityFilter.filterStateId(stateId)
    local ability = targetUnit:findAbility(filter) or self:addAbility(targetUnit, 'state', stateId, skillLevel)
    if ability then
        ability:incStackLayer(layer, time)
    end
end

--- 减少来源绑定的状态层数
--- @param targetUnit Unit 要附加能力的目标单位（必填）
--- @param stateId integer     状态配置ID
--- @param layer integer       减少层数
---
--- - 层数减至0时自动触发状态移除
function Ability:decStateLayer(targetUnit, stateId, layer)
    local filter = AbilityFilter.filterState(stateId, self:getSourceUnit())
    local ability = targetUnit:findAbility(filter)
    if ability then
        ability:decStackLayer(layer)
    end
end

--- 减少唯一状态层数
--- @param targetUnit Unit 要附加能力的目标单位（必填）
--- @param stateId integer     状态配置ID
--- @param layer integer       减少层数（默认1层）
function Ability:decUniqueStateLayer(targetUnit, stateId, layer)
    local filter = AbilityFilter.filterStateId(stateId)
    local ability = targetUnit:findAbility(filter)
    if ability then
        ability:decStackLayer(layer)
    end
end

--- 设置来源绑定的状态层数（精确控制同来源状态）
--- @param targetUnit Unit 要附加能力的目标单位（必填）
--- @param stateId integer     状态配置ID（对应ResStateData.id）
--- @param skillLevel integer  技能等级（影响基础数值）
--- @param layer integer|nil   目标层数（nil=保持当前，0=清除状态）
--- @param time integer|nil    新持续时间（帧数，nil=保持原有时长）
---
--- - 仅操作当前能力来源创建的状态实例
--- - 适用于需要精确控制特定来源状态层数的场景
--- - 与incStateLayer的区别在于直接设置而非增减
function Ability:setStateLayer(targetUnit, stateId, skillLevel, layer, time)
    local filter = AbilityFilter.filterState(stateId, self:getSourceUnit())
    local ability = targetUnit:findAbility(filter)
    if ability == nil and layer and layer > 0 then
        ability = self:addAbility(targetUnit, 'state', stateId, skillLevel)
    end
    if ability then
        ability:setStackLayer(layer, time)
    end
end

--- 设置全局状态层数（跨来源合并）
--- @param targetUnit Unit 要附加能力的目标单位（必填）
--- @param stateId integer     状态配置ID（对应ResStateData.id）
--- @param skillLevel integer  技能等级（影响基础数值）
--- @param layer integer|nil   目标层数（nil=保持当前，0=清除状态）
--- @param time integer|nil    新持续时间（帧数，nil=保持原有时长）
---
--- - 操作所有来源的同ID状态实例
--- - 适用于需要跨来源统一管理状态的场景
--- - 如果存在多个状态实例（如不是用`incUniqueStateLayer`创建的），实际会修改最早创建的状态实例
function Ability:setUniqueStateLayer(targetUnit, stateId, skillLevel, layer, time)
    local filter = AbilityFilter.filterStateId(stateId)
    local ability = targetUnit:findAbility(filter)
    if ability == nil and layer and layer > 0 then
        ability = self:addAbility(targetUnit, 'state', stateId, skillLevel)
    end
    if ability then
        ability:setStackLayer(layer, time)
    end
end


--- 被嘲讽
function Ability:beTaunted()
    getOwnerImpl(self):interruptMoving()
end


--- 被集火
function Ability:beAimed()
    self:setAttrBuff('beAimed', 1, true)
end


--- 累加属性值（直接修改基础属性）
--- @param attrName string 属性名称（对应ResAttrData.id）
--- @param addValue number 属性增加值（可为负数）
--- -
--- 1. 直接修改单位的基础属性值（非增强值）
--- 2. 多次调用会累加效果
--- @usage
--- 增加50点攻击力：
--- ability:addAttr('atk', 50)
function Ability:addAttr(attrName, addValue)
    getOwnerImpl(self):addAttr(attrName, addValue)
end

--- 设置属性绝对值（直接覆盖基础属性）
--- @param attrName string 属性名称
--- @param value number 要设置的属性值
------
--- - 会完全覆盖当前基础属性值
--- - 适用于需要精确控制属性值的场景
function Ability:setAttr(attrName, value)
    getOwnerImpl(self):setAttr(attrName, value)
end

--- 设置属性增强值（替换式修改）
--- @param attrName string 属性名称
--- @param value number|nil 增强值（nil表示清除增强）
--- @param disableShowNum boolean 是否隐藏状态显示
------
--- - 与addAttr的区别：此处修改的是属性增强值（buff/debuff）
--- - 多次调用会覆盖之前的增强值
--- - 当此能力移除时自动撤销属性增强
--- @usage
--- 设置攻击力增强+1000（显示状态图标）：
--- ability:setAttrBuff('atk', 1000)
function Ability:setAttrBuff(attrName, value, disableShowNum)
    if self._attrMap == nil then
        self._attrMap = {}
    end
    local attrMap = self._attrMap
    local oldValue = attrMap[attrName] or 0
    local diff = (value or 0) - oldValue
    attrMap[attrName] = value
    getOwnerImpl(self):addAttr(attrName, diff)
    if not disableShowNum and BattleConst.STATE_PROP_SHOW[attrName] then
        local isDebuff = diff < 0 --TODO
        self:addOutput( BattleConst.MATRIX_EVENT_ENTITY_STATESHOW, {attrName, isDebuff} )
    end
end

--- 取消指定属性的增强值
--- @param attrName string 要取消的属性名称
------
--- - 会自动计算属性差值并还原
--- - 会触发状态显示更新（如果原属性需要显示）
--- @see setAttrBuff
--- @usage
--- 清除攻击力增强：
--- ability:unsetAttrBuff('atk')
function Ability:unsetAttrBuff(attrName)
    return self:setAttrBuff(attrName, nil)
end

--- 清除所有属性增强.
------
--- - 功能说明：
---   1. 按照属性名字母顺序逐个清除
---   1. 在能力被移除时自动调用
--- @see setAttrBuff
function Ability:clearAttrBuff()
    while self._attrMap and next(self._attrMap) do
        local attrMap = self._attrMap
        local attrList = {}
        for attrName, _ in pairs(attrMap) do
            table.insert(attrList, attrName)
        end
        table.sort(attrList)
        for _, attrName in ipairs(attrList) do
            self:unsetAttrBuff(attrName)
        end
    end
end

--- 取属性增强值
--- @param attrName string 属性名称
function Ability:getAttrBuff(attrName)
    if self._attrMap == nil then
        return 0
    end
    local attrMap = self._attrMap
    return attrMap[attrName] or 0
end


--- 触发一次本技能的卡牌使用
function Ability:loadOnce(triggerCd, cardUseCd)
    if not self._useOnce then
        self._useOnce = {triggerCd = triggerCd, cardUseCd = cardUseCd}
    end
end

--- 检查单次触发技能的使用许可
--- @return table|nil 返回触发技能冷却参数，空表示当前不可使用
------
--- - 功能说明：
--- 1. 用于标记触发型技能已使用（如被动触发的追击技能）
--- 2. 使用技能后应清除内部标记，确保单次触发只生效一次
function Ability:checkShootOnce()
    return self._useOnce
end

--- 检查主动技能是否允许使用
--- @return boolean 是否允许释放该技能
------
--- - 功能说明：
--- 1. 返回true表示技能可用，false表示不可用
function Ability:checkShootInput()
    return getOwnerImpl(self):checkShootInput()
end

--- 主动技能施放完成
------
--- - 功能说明：
--- 1. 清除手动施放标记
function Ability:clearShootInput()
    return getOwnerImpl(self):clearShootInput()
end

--- 播放技能特效指令
--- @param targetUnit Unit 特效目标单位
--- @param cueList integer[] 特效配置ID列表（对应ResCue表）
--- @param startUnit Unit|nil 特效起始单位（nil表示从施法者位置发出）
--- @param flyTime number|nil 特效飞行时间（秒），0表示立即生效，nil表示不是子弹类特效
------
--- - 功能说明：
--- 1. 用于触发技能前摇/飞行/命中阶段的完整特效链
--- 2. 特效路径会自动计算（起始单位到目标单位的向量方向）
--- @usage
--- 播放火球术飞行特效（从施法者到目标，飞行时间1.5秒）：
--- ability:playCue(target, {666}, caster, 1.5)
function Ability:playCue(targetUnit, cueList, startUnit, flyTime)
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAYCUE, { targetUnit:getId(), cueList, startUnit and startUnit:getId(), flyTime })
end

--- 触发受击单位的表现动画
--- @param targetUnit Unit 受击单位
--- @param hitedAnim string 受击动画ID（对应动作状态机配置）
function Ability:playHitAnim(targetUnit, hitedAnim)
    targetUnit:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HITED_AIM, { hitedAnim })
end

--- 设置受击单位的位置偏移
--- @param targetUnit Unit 受击单位
--- @param offsetPath string 偏移路径配置ID（对应ResOffsetPath表）
function Ability:playHitOffset(targetUnit, offsetPath)
    targetUnit:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HITED_OFFSET, { offsetPath })
end

--- 计算命中判定
--- @param targetUnit Unit 目标单位
--- @param skillType number 技能类型（0=普通，1=技能，2=触发）
--- @param disablePassive boolean 是否禁用被动技能触发（true=不触发被动）
--- @return boolean 是否命中（true=命中，false=未命中）
---
--- - 检查目标免疫状态
--- - 计算命中率公式：最终命中率 = 攻击方命中率 - 目标闪避率
--- - 未命中时触发attackMiss回调
function Ability:checkHitChance(targetUnit, skillType, disablePassive)
    if targetUnit:isDead() then
        return false
    end
    local ownerUnit = self:getOwnerUnit()
    if targetUnit:isImmune('damageImmune') then
        self:attackImmune(targetUnit, skillType, disablePassive)
        return false
    end
    local hitRate = ownerUnit:getAttr('hit_rate')
    local missRate = targetUnit:getAttr('miss')
    local realHitRate = hitRate - missRate
    local hit = self:getRandomProb(realHitRate)
    if not hit then
        self:attackMiss(targetUnit, skillType, disablePassive)
        return false
    end
    return hit
end

--- 攻击结果是被闪避
function Ability:attackMiss(targetUnit, skillType, disablePassive)
    local ownerUnit = self:getOwnerUnit()
    local extraHitedInfo = {} --TODO
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_DAMAGE, { 0, BattleConst.DAMAGE_TYPE_MISS, false, ownerUnit:getId(), extraHitedInfo, nil, nil, skillType })
    if not disablePassive then
        AbilityTrigger.unit(ownerUnit, 'onOwnerAttackMiss', targetUnit)
        AbilityTrigger.unit(targetUnit, 'onOwnerBeHitMiss', ownerUnit)
    end
end

--- 攻击结果是被免疫
function Ability:attackImmune(targetUnit, skillType, disablePassive)
    local ownerUnit = self:getOwnerUnit()
    local extraHitedInfo = {} --TODO
    self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_DAMAGE, { 0, BattleConst.DAMAGE_TYPE_HURT_IMMUE, false, ownerUnit:getId(), extraHitedInfo, nil, nil, skillType })
    if not disablePassive then
        AbilityTrigger.unit(ownerUnit, 'onOwnerAttackImmune', targetUnit)
        AbilityTrigger.unit(targetUnit, 'onOwnerBeHitImmune', ownerUnit)
    end
end


--- 技能移动效果：向目标单位闪现
--- @param targetUnit Unit 目标单位对象
--- @param movingFlash integer 移动过程经过几个逻辑帧
--- @param near boolean true表示移动到目标周围的空位中的距离起点最近的位置，即闪现到敌人面前。false或nil表示移动到最远位置，即敌人身后。
function Ability:attackMovingFlash(targetUnit, movingFlash, near)
    getImpl(self:getOwnerUnit()):beHitedMovingFlash(targetUnit, movingFlash, near)
end
--- 与目标换位
--- @param targetUnit Unit 目标单位对象
function Ability:attackMovingSwap(targetUnit)
    getImpl(self:getOwnerUnit()):beHitedMovingSwap(targetUnit)
end
--- 击退目标
--- @param targetUnit Unit 目标单位对象
--- @param movingBackDistance number 击退距离
--- @param movingBackSpeed number 击退速度
function Ability:attackMovingBack(targetUnit, movingBackDistance, movingBackSpeed)
    getImpl(targetUnit):beHitedMovingBack(movingBackDistance, movingBackSpeed)
end

--- 造成控制
function Ability:attackControl(targetUnit, controlType, controlTime, skipImmunityControl)
    if not skipImmunityControl and targetUnit:isImmune('immuneControlled') then
        targetUnit:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, { BattleConst.STATE_IMMUNE_CONTROLLED })
        return
    end
    local duration = controlTime * (1 - targetUnit:getAttr('ControlledResist') / 10000)
    local ownerUnit = self:getOwnerUnit()
    getImpl(targetUnit):beHitedControlled(controlType, duration, ownerUnit)
    AbilityTrigger.unit(ownerUnit, 'onOWnerAttackControl', targetUnit, controlType)
    AbilityTrigger.unit(targetUnit, 'onOwnerBeHitControl', ownerUnit, controlType)
end
--- 解除控制
function Ability:attackControlDel(targetUnit, controlType)
    getImpl(targetUnit):beHitedControlledDel(controlType)
end
--- 延长控制
function Ability:attackControlExtend(targetUnit, controlType, controlTime)
    local duration = controlTime * (1 - targetUnit:getAttr('ControlledResist') / 10000)
    getImpl(targetUnit):beHitedControlledExtend(controlType, duration)
end

---造成对方能量变化
function Ability:attackChangeMana(targetUnit, addMana, notShow)
    local target = getImpl(targetUnit)
    if addMana ~= 0 then
        target:changeMana(addMana, false, notShow)
    end
    if addMana <= 0 then
        local changeValue = targetUnit:getAttr('behited_mana_gen')
        target:changeMana(changeValue, false, true)
    end
end

---自身能量变化
function Ability:changeMana(changeValue, notShow)
    getImpl(self:getOwnerUnit()):changeMana(changeValue, false, notShow)
end

--- 检查伤害是否被免疫
function Ability:checkDamageImmune(targetUnit, immuneType)
    if targetUnit:isImmune(immuneType) then
        targetUnit:addOutput( BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {immuneType} )
        return true
    end
    return false
end

--- 给目标单位施加护盾
--- @param targetUnit Unit 要施加护盾的目标单位
--- @param base number 护盾基础值（受技能等级和配置影响）
--- @param skillType integer 技能类型
--- @see Enum.SkillType
--- @param shieldTime number 护盾持续时间（秒），nil表示永久
--- @param disablePassive boolean 是否禁用被动技能触发
---
--- 功能说明：
--- 1. 计算护盾系数：攻击方护盾效果加成 * 目标护盾增强系数
--- 2. 调用底层接口应用护盾值
--- 3. 护盾值 = 基础值 * 系数
--- 注意事项：
--- - 护盾值会自动叠加
--- - 护盾持续时间使用游戏逻辑帧计算，不同来源的护盾独立计算
--- @usage
--- 给目标施加持续5秒的1000点护盾（大招技能）：
--- ability:attackShield(target, 1000, ability.Enum.SkillType.DaZhao, 5)
function Ability:attackShield(targetUnit, base, skillType, shieldTime, disablePassive)
    local ownerUnit = self:getOwnerUnit()
    local factor = ownerUnit:factorSkillShield(targetUnit, skillType)
    local amount = base * factor
    getImpl(targetUnit):applyShield(ownerUnit, amount, skillType, shieldTime, disablePassive)
    if shieldTime then
        local timerId = {base, shieldTime}
        local function removeShield()
            self:addAttr('max_shield', -amount)
        end
        self:createTimer(timerId, shieldTime, removeShield)
    end
end
--- 对目标单位执行治疗行为
--- @param targetUnit Unit 被治疗的目标单位
--- @param base number 基础治疗值（受技能等级和配置影响）
--- @param skillType integer 技能类型
--- @see Enum.SkillType
--- @param disablePassive boolean 是否禁用被动技能触发
---
--- 实现逻辑：
--- 1. 检查目标治疗免疫状态
--- 2. 计算最终治疗量 = 基础值 * (治疗系数 = 施法者治疗效果 * 目标治疗增强)
--- 3. 调用底层治疗应用逻辑（会触发血量变化事件和被动技能）
function Ability:attackHeal(targetUnit, base, skillType, disablePassive)
    local ownerUnit = self:getOwnerUnit()
    if self:checkDamageImmune(targetUnit, 'healImmune') then
        return
    end
    local factor = ownerUnit:factorSkillHeal(targetUnit, skillType)
    local amount = base * factor
    getImpl(targetUnit):applyHeal(ownerUnit, amount, skillType, disablePassive)
end
--- 对目标单位造成真实伤害
--- @param targetUnit Unit 目标单位
--- @param base number 基础伤害值（受技能等级和配置影响）
--- @param skillType integer 技能类型
--- @see Enum.SkillType
--- @param disablePassive boolean 是否禁用被动技能触发
---
--- 实现流程：
--- 1. 基础校验：目标存活且伤害值有效
--- 2. 伤害计算：基础值 × 伤害系数（含施法者强化/目标抗性）
--- 3. 应用伤害：调用底层接口处理护盾吸收和实际扣血
--- 注意事项：
--- - 固定伤害不受暴击、格挡、连接、吸血、反弹等常规战斗机制影响
--- - 会触发被动技能（除非 disablePassive = true）
function Ability:attackLoss(targetUnit, base, skillType, disablePassive)
    if not targetUnit or targetUnit:isDead() or base <= 0 then
        return
    end
    local ownerUnit = self:getOwnerUnit()
    local factor = ownerUnit:factorSkillLoss(targetUnit, skillType)
    local amount = base * factor
    getImpl(targetUnit):applyHurt(ownerUnit, amount, false, skillType, disablePassive)
end

--- 计算并应用物理伤害
--- @param targetUnit Unit 目标单位
--- @param damageBase number 基础伤害值（经过技能等级加成的初始值，必须≥0）
--- @param skillType integer 技能类型
--- @see Enum.SkillType
--- @param elemType integer 元素类型
--- @see Enum.ElemType
--- @param disablePassive boolean|nil 是否禁用被动技能触发（true=跳过被动回调）
--- @param critDmgAdd number 暴击伤害加成（万分比，例如1000表示+10%暴击伤害）
--- @param defPercent number|nil 目标防御系数（万分比，nil表示100%，例如1000表示只代入10%目标防御）
--- @return integer|nil damangeAmount 经过计算后的伤害值（注意可能大于目标实际扣减的HP值），被免疫返回空。
------
--- 1. 检查目标物理伤害免疫
--- 2. 计算实际伤害因子（含暴击、抗性、等级压制等）
--- 3. 处理伤害分摊、护盾吸收、吸血、反弹等连锁效果
--- 4. 触发伤害相关事件回调
--- @usage
--- 对敌人造成基础1000点火系物理伤害，10%暴击加成，作为大招技能：
--- ability:attackDamage(enemyUnit, 1000, 1000, ability.Enum.SkillType.DaZhao, ability.Enum.ElemType.Fire)
function Ability:attackDamage(targetUnit, damageBase, skillType, elemType, disablePassive, critDmgAdd, defPercent)
    if not targetUnit or targetUnit:isDead() or damageBase <= 0 then
        return
    end
    if self:checkDamageImmune(targetUnit, 'physicsImmune') then
        return
    end
    local ownerUnit = self:getOwnerUnit()
    local factor, crit = ownerUnit:factorSkillDamage(targetUnit, skillType, elemType, critDmgAdd, defPercent)
    local damageAmount = damageBase * factor
    getImpl(targetUnit):applyDamage(ownerUnit, damageAmount, crit, skillType, disablePassive)
    return damageAmount
end

--- 对目标单位施加诅咒攻击并造成属性伤害
--- @param targetUnit Unit 目标单位对象，必须为有效且存活的单位
--- @param attrName string 受影响的属性名称（如"hp"、"mana"等）
--- @param damageBase number 基础伤害值，必须为正数
--- @param skillType number 技能类型，用于计算伤害系数
--- @return number 实际施加的诅咒伤害值（0表示无效攻击）
---
--- 注意事项：
--- 1. 伤害计算：基础值 × 伤害系数（含施法者强化/目标抗性）
--- 2. 对hp和mhp的诅咒至少保留1点生命值，不会导致目标死亡
--- 3. 对hp的诅咒不可被护盾吸收
--- 4. 不受暴击、格挡、连接、吸血、反弹等常规战斗机制影响
--- 5. 诅咒伤害不是state，不可撤销、不可驱散、没有状态图标
--- 6. 触发onOwnerAttackCurse和onOwnerBeHitCurse事件
function Ability:attackCurse(targetUnit, attrName, damageBase, skillType)
    if not targetUnit or targetUnit:isDead() or damageBase <= 0 then
        return 0
    end
    local ownerUnit = self:getOwnerUnit()
    local factor = ownerUnit:factorSkillLoss(targetUnit, skillType)
    local damageAmount = damageBase * factor
    local sub = getImpl(targetUnit):applyCurse(ownerUnit, attrName, damageAmount, skillType)
    return sub
end

--- 在指定网格位置召唤怪物单位
--- @param grid table 召唤位置的网格对象，需包含坐标信息
--- @param monsterId number 怪物资源ID，用于指定召唤的怪物类型
--- @param attrFromUnit table|nil 可选参数，指定属性继承来源单位，若提供则新怪物会继承该单位的部分属性
--- @return Unit 新创建的怪物单位对象
function Ability:summonMonster(grid, monsterId, attrFromUnit)
    local ownerUnit = self:getOwnerUnit()
    local unitInfo = {grid = grid, resId = monsterId, type = 'Monster', master = ownerUnit}
    return getImpl(ownerUnit).matrixAbility:battleCreateUnit(ownerUnit:getCamp(), unitInfo, attrFromUnit)
end

--- 改变天气。别用，没实现。
function Ability:changeWeather(weatherFlag, weatherTime)
    getOwnerImpl(self).matrixAbility.weatherManager:enterWeather(weatherFlag, weatherTime, owner)
end

--- 复活
function Ability:reborn(targetUnit, hppct, mana)
    if targetUnit:isDead() then
        getImpl(targetUnit):reborn(hppct, mana)
    end
end

--- 创建陷阱实例
--- @param stateId integer|nil 关联的状态ID（触发时施加状态）
--- @param skillId integer|nil 关联的技能ID（触发时调用技能）
--- @param eventId integer|nil 关联的技能事件ID
--- @param shot integer|nil 可触发次数（nil表示无限次）
--- @return table 陷阱对象，包含触发逻辑和配置参数
function Ability:makeTrap(stateId, skillId, eventId, shot)
    local trap = {shot = shot}
    local function trigger(unit, type)
        if type == 'enter' then
            if stateId then
                self:incUniqueStateLayer(unit, stateId, 1, self:getSkillLevel())
            end
            if skillId and eventId then
                self:triggerSkillEvent(self:getOwnerUnit(), unit, skillId, eventId, self:getSkillLevel())
            end
            if trap.shot then
                trap.shot = trap.shot - 1
                if trap.shot <= 0 then
                    self:removeTrap(trap)
                end
            end
        elseif type == 'leave' then
            if stateId then
                self:decUniqueStateLayer(unit, stateId, self:getSkillLevel())
            end
        end
    end
    trap.trigger = trigger
    return trap
end

--- 通过配置表ID创建标准化陷阱
--- @param trapId integer 陷阱配置ID（对应ResBattleTrap表）
--- @return table|nil 返回陷阱对象，配置不存在时返回nil
function Ability:makeTrapById(trapId)
    local resTrap = ResBattleTrap[trapId]
    if resTrap == nil then
        return
    end
    local stateId = resTrap.stateId
    local skillId = resTrap.event_id and resTrap.event_id[1]
    local eventId = resTrap.event_id and resTrap.event_id[2]
    local shot = resTrap.trap_type and resTrap.trap_type > 0 and resTrap.trap_type or nil
    local trap = self:makeTrap(stateId, skillId, eventId, shot)
    trap.trapId = trapId
    return trap
end

--- 在指定网格创建标准化陷阱
--- @param grid Grid 目标网格（来自GridGraph）
--- @param trapId integer 陷阱配置ID
--- @return table|nil 成功返回陷阱对象，失败返回nil
function Ability:createTrapById(grid, trapId)
    local trap = self:makeTrapById(trapId)
    return self:createTrap(grid, trap)
end

--- 在指定网格部署陷阱
--- @param grid Grid 目标网格（来自GridGraph）
--- @param trap table 陷阱对象
--- @return table|nil 已部署的陷阱对象，重复部署返回nil
--- @note 会自动绑定陷阱到网格，重复部署同一陷阱无效
function Ability:createTrap(grid, trap)
    if trap.grid == nil then
        trap.grid = grid
        local ownerUnit = self:getOwnerUnit()
        local gridTrigger = getImpl(ownerUnit).matrixAbility.gridTrigger
        gridTrigger:create(trap.grid, trap.trigger)
        if trap.trapId then
            self:addOutput(BattleConst.MATRIX_EVENT_ADD_TRAP,  {trap.trapId, grid.coordX, grid.coordY})
        end
        return trap
    end
    return nil
end

--- 移除已部署的陷阱
--- @param trap table 要移除的陷阱对象
--- @note 会自动解除网格绑定，重复移除安全
function Ability:removeTrap(trap)
    if trap.grid then
        local grid = trap.grid
        local ownerUnit = self:getOwnerUnit()
        local gridTrigger = getImpl(ownerUnit).matrixAbility.gridTrigger
        gridTrigger:remove(grid, trap.trigger)
        trap.grid = nil
        if trap.trapId then
            self:addOutput(BattleConst.MATRIX_EVENT_DEL_TRAP,  {trap.trapId, grid.coordX, grid.coordY})
        end
    end
end

--- 给Ability发送自定义消息
---@param toAbility Ability 要接收消息的目标能力对象
---@param message string 消息标识符（用于区分不同消息类型）
---@param ... any 附加的消息参数（可变参数）
---@usage
--- 发送治疗消息：
--- ability:sendMessage(targetAbility, "HEAL", 500, "红药水")
---
--- 接收方处理：
--- function Ability:onMessage(fromAbility, msgType, ...)
---     if msgType == "HEAL" then
---         local amount, source = ...
---         self:healHp(self:getOwnerUnit(), amount)
---     end
--- end
function Ability:sendMessage(toAbility, message, ...)
    AbilityTrigger.call(toAbility, 'onMessage', self, message, ...)
end

--- 给Unit发送自定义消息
---@param toUnit Unit 要接收消息的目标
---@param message string 消息标识符（用于区分不同消息类型）
---@param ... any 附加的消息参数（可变参数）
function Ability:sendUnitMessage(toUnit, message, ...)
    AbilityTrigger.unit(toUnit, 'onMessage', self, message, ...)
end

--- 给全体发送自定义消息
---@param message string 消息标识符（用于区分不同消息类型）
---@param ... any 附加的消息参数（可变参数）
function Ability:sendGlobalMessage(message, ...)
    local ownerUnit = self:getOwnerUnit()
    AbilityTrigger.global(ownerUnit, 'onMessage', self, message, ...)
end

--- 输出信息到表现层
function Ability:addOutput(outputType, args)
    getImpl(self:getOwnerUnit()):addOutput(outputType, args)
end


--- 触发技能事件
--- 不推荐。直接配具体效果就行。
function Ability:triggerSkillEvent(fromUnit, targetUnit, skillId, eventId, eventLevel)
    local filter = AbilityFilter.filterConfig('skill', skillId)
    local ability = fromUnit:findAbility(filter)
    if not ability then
        ability = self:addAbility(fromUnit, 'skill', skillId, eventLevel, self:getFromUnit())
        if not ability then
            return
        end
        self:addSubAbility(ability)
    end
    AbilityTrigger.call(ability, 'onSelfSkillHit', eventId, targetUnit, targetUnit)
    --TODO 删掉临时技能？
end

--- 触发卡牌技能
--- 该技能会在下一帧优先使用
function Ability:triggerPassiveCard(cardId, cardLevel, triggerCd, cardUseCd, targetUnit)
    local filter = AbilityFilter.filterConfig('card', cardId)
    local ownerUnit = self:getOwnerUnit()
    local ability = ownerUnit:findAbility(filter)
    if not ability then
        ability = self:addAbility(ownerUnit, 'card', cardId, cardLevel, self:getFromUnit())
        if not ability then
            return
        end
        self:addSubAbility(ability)
    end
    ability:loadOnce(triggerCd, cardUseCd, targetUnit)
end

--- 检查条件。
--- 不推荐：直接判断具体条件就行。
function Ability:checkCondition(conditionArgs, targetUnit)
    return self:getOwnerUnit():checkCondition(conditionArgs, targetUnit)
end

--- 检查随机触发。
--- 不推荐：直接调用随机数就行。
--- @return boolean 是否触发
--- @see getRandomProb
function Ability:checkRandomControl(probId, prabLevel, targetUnit, probSourceType, probSourceKey)
    local owner = getImpl(self:getOwnerUnit()).combatUnit
    local target = targetUnit and getImpl(targetUnit).combatUnit
    return true
    --return AttackCalc.onRandomControl(owner.randomGenerator, probId, prabLevel, owner, target, probSourceType, probSourceKey)
end

return newAbility