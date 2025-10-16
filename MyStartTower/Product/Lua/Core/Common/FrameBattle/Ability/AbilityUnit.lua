---@class Unit
---@classmod Unit 单位，代表一个英雄或怪物。
------
--- - 单位类的函数用于获取单位信息或战场信息，不对单位做修改。如需对单位产生效果，应使用Ability类，以便追踪来源。
--- - 单位对象与单位ID是一一对应的关系，允许在技能脚本中直接保存单位的引用。
--- - 单位死亡后单位对象不销毁。
local getImpl = require "Core/Common/FrameBattle/Ability/getImpl"
local AbilityUnitImpl = require "Core/Common/FrameBattle/Ability/AbilityUnitImpl"
local AbilityDataTable = require "Core/Common/FrameBattle/Ability/AbilityDataTable"
local AbilityFilter = require("Core/Common/FrameBattle/Ability/AbilityFilter")
local BattleConst = AbilityDataTable.BattleConst
local Enum = require "Core/Common/FrameBattle/Ability/Enum"

local AbilityUnit = {}

--- 获取ID
---@return integer 单位的唯一标识符
function AbilityUnit:getId()
    return getImpl(self).id
end

--- 获取单位的cardID
---@return integer|nil 单位的cardID
function AbilityUnit:getUnitCardId()
    if self and self:isAlive() then
        return getImpl(self).resId
    end
    return nil
end

--- 获取主人单位
---@return Unit|nil 如果是召唤单位返回主人，常规单位返回nil
function AbilityUnit:getMasterUnit()
    return getImpl(self).master
end

--- 获取阵营
---@return integer 阵营常量 CAMP_BLUE(1) 或 CAMP_RED(2)
function AbilityUnit:getCamp()
    return getImpl(self).camp
end

--- 获取进攻方向，蓝队向右+1，红队向左-1
---@return integer @方向标识（1=向右，-1=向左）
function AbilityUnit:getForward()
    return getImpl(self):getForward()
end

--- 获取敌方阵营常量
---@return integer @敌方阵营常量（与getCamp()结果相反）
function AbilityUnit:getEnemyCamp()
    return getImpl(self):getEnemyCamp()
end

--- 是敌方
---@param otherUnit Unit 要判断的目标单位
---@return boolean @true-是敌方单位，false-非敌方
function AbilityUnit:isEnemy(otherUnit)
    return self:getCamp() ~= otherUnit:getCamp()
end

--- 是友方
---@param otherUnit Unit 要判断的目标单位
---@return boolean @true-是友方单位，false-非友方
function AbilityUnit:isFriend(otherUnit)
    return self:getCamp() == otherUnit:getCamp()
end

--- 种族
---@return integer @种族标识符（对应 BattleConst.HERO_RACE_* 常量）
function AbilityUnit:getRace()
    return getImpl(self).race
end

--- 种族克制
---@param targetUnit Unit 目标单位
---@return boolean @true-当前单位种族克制目标单位，false-无克制关系
function AbilityUnit:isRaceOvercome(targetUnit)
    return BattleConst.HERO_CAMP_OVERCOME[self:getRace()] == targetUnit:getRace()
end

--- 是英雄
---@return boolean @true-是英雄单位，false-不是英雄
function AbilityUnit:isHero()
    return getImpl(self).type == 'Hero'
end

--- 是怪物
---@return boolean @true-怪物单位，false-不是怪物单位
function AbilityUnit:isMonster()
    return getImpl(self).type == 'Monster'
end

--- 取本阵营利姆鲁单位
---@return Unit? 本阵营的利姆鲁（可能为空）
function AbilityUnit:getRimuruUnit()
    local function filter(unit)
        return unit:getCamp() == self:getCamp() and getImpl(unit).type == 'Rimuru'
    end
    return self:findUnit(filter)
end

--- 是Boss怪
---@return boolean @true-是Boss类型怪物，false-普通怪物或英雄
function AbilityUnit:isBoss()
    return getImpl(self).resData.monster_type == 2
end

--- 是否是主体单位（非召唤单位）
---@return boolean @true-是常规单位，false-是召唤单位
function AbilityUnit:isMajor()
    return self:getMasterUnit() == nil
end

--- 是否是召唤单位
---@return boolean @true-是召唤单位，false-是常规单位
function AbilityUnit:isMinor()
    return not self:isMajor()
end

--- 筛选主体单位（常规单位）
---@return fun(unit: Unit):boolean 判断单位是否为主体单位的函数
function AbilityUnit:filterMajor()
    return function(unit)
        return unit:isMajor()
    end
end

--- 筛选召唤单位
---@return fun(unit: Unit):boolean 判断单位是否为召唤单位的函数
function AbilityUnit:filterMinor()
    return function(unit)
        return unit:isMinor()
    end
end

--- 筛选当前单位的召唤单位
---@return fun(unit: Unit):boolean 判断单位是否为当前单位召唤物的函数
function AbilityUnit:filterMyMinor()
    return function(unit)
        return unit:isMinor() and unit:getMasterUnit() == self
    end
end

--- 放技能时播放长视频
function AbilityUnit:isLongSkill()
    local impl = getImpl(self)
    return impl:isLongSkill()
end

--- 获取帧率
function AbilityUnit:getFramePerSec()
    return getImpl(self).framePerSec
end

--- 获取帧数
function AbilityUnit:getRealFrameNumber()
    return getImpl(self):getRealFrameNumber()
end
--- 获取帧数
function AbilityUnit:getFrameNumber()
    return getImpl(self):getFrameNumber()
end

--- 本场战斗是PVP
function AbilityUnit:isPvp()
    return getImpl(self).matrixAbility.isPvp
end

--- 获取战场随机数生成器
-- @return RandomGenerator 随机数生成器对象
-- @note 不建议在配置层直接使用，应通过封装好的随机方法操作
function AbilityUnit:getRandomGenerator()
    return getImpl(self).matrixAbility.randomGenerator
end

--- 生成区间随机整数
--- @param max integer 最大值（包含）
--- @return integer 随机数范围 [1, max]
function AbilityUnit:getRandomInt(max)
    return self:getRandomGenerator():random(1, max)
end

--- 从列表中随机选择一个元素
--- @param list table 候选列表
--- @return any 随机选择的元素
--- @comment 如果列表为空，则返回nil
function AbilityUnit:getRandomChoice(list)
    if not list or not next(list) then
        return nil
    end
    local n = self:getRandomGenerator():random(1, #list)
    return list[n]
end

--- 从列表中随机选择指定数量的不重复元素
--- @param list table 候选列表
--- @param count integer 需要选择的元素数量
--- @return table 包含随机选择元素的列表
--- @comment 如果列表为空或count<=0，返回空表；如果count>=列表长度，返回列表的副本
function AbilityUnit:getRandomChoices(list, count)
    if not list or not next(list) or count <= 0 then
        return {}
    end

    -- 始终先创建列表副本以避免修改原表
    local copy = {}
    for i, v in ipairs(list) do
        copy[i] = v
    end

    -- 如果请求数量大于等于列表长度，直接返回副本
    if count >= #copy then
        return copy
    end

    -- 随机选择count个不重复元素
    local result = {}
    for i = 1, count do
        local index = self:getRandomInt(#copy)
        table.insert(result, copy[index])
        -- 移除已选元素避免重复
        table.remove(copy, index)
    end

    return result
end

--- 概率判定（万分比）
--- @param prob integer 概率值，范围 [0,10000]
--- @return boolean 是否命中
function AbilityUnit:getRandomProb(prob)
    local n = self:getRandomGenerator():random(1, 10000)
    return n <= prob
end

--- 获取指定属性数值
--- @param attrName string 属性名称
--- @return number 属性数值
function AbilityUnit:getAttr(attrName)
    return getImpl(self):getAttr(attrName)
end

--- 判断指定属性是否有效（数值大于0）
--- @param attrName string 属性名称
--- @return boolean
function AbilityUnit:hasAttr(attrName)
    return self:getAttr(attrName) > 0
end

--- 创建属性筛选器（用于maxUnit等需要优先级数值的场景）
--- @param attrName string 要比较的属性名称
--- @return fun(unit: Unit):number 返回单位属性值
function AbilityUnit:filterAttr(attrName)
    local function filter(unit)
        local attr = unit:getAttr(attrName)
        return attr > 0 and attr
    end
    return filter
end

--- 判断免疫
function AbilityUnit:isImmune(immuneName)
    return getImpl(self):isImmune(immuneName)
end

--- 判断免疫，如果自身属性有对应的免疫项，则成功免疫
--- @param immuneList table 需判断的免疫项
--- @return boolean 是否成功免疫
function AbilityUnit:isImmuneAny(immuneList)
    for _, name in ipairs(immuneList) do
        if self:isImmune(name) then
            return true
        end
    end
    return false
end

--- 是否存活（HP大于0)
function AbilityUnit:isAlive()
    return self:getAttr('hp') > 0
end

--- 是否已死亡
function AbilityUnit:isDead()
    return self:getAttr('hp') <= 0
end

--- 是否是地元素
function AbilityUnit:isElemEarth()
    return self:getAttr('elem') == 1
end

--- 是否是冰元素
function AbilityUnit:isElemIce()
    return self:getAttr('elem') == 2
end

--- 是否是火元素
function AbilityUnit:isElemFire()
    return self:getAttr('elem') == 3
end

--- 是否是风元素
function AbilityUnit:isElemWind()
    return self:getAttr('elem') == 4
end

--- 是否是光元素
function AbilityUnit:isElemLight()
    return self:getAttr('elem') == 5
end

--- 是否是暗元素
function AbilityUnit:isElemDark()
    return self:getAttr('elem') == 6
end

--- 获取当前受击控制状态标识
---@return string|nil @受击状态标识（"stun"=眩晕，"freeze"=冻结等），nil表示未受控制
function AbilityUnit:getHitedFlag()
    return getImpl(self).hitedFlag
end

--- 判断是否处于指定类型的受击控制状态
---@param flag string 要检测的状态标识（"stun"/"freeze"/"timelock"等）
---@return boolean @true-当前处于该控制状态，false-未处于该状态
function AbilityUnit:isHited(flag)
    return getImpl(self).hitedFlag == flag
end


--- 查询一个符合条件的能力。
-- @param filter function 筛选函数，接受ability对象，返回boolean
-- @return Ability|nil 符合条件的能力
function AbilityUnit:findAbility(filter)
    return getImpl(self).abilityGroup:find(filter)
end

--- 查询所有符合条件的能力。
-- @param filter function 筛选函数，接受ability对象，返回boolean
-- @return Ability[] 符合条件的能力
function AbilityUnit:searchAbility(filter)
    return getImpl(self).abilityGroup:search(filter)
end

--- 查询所有符合条件的能力数量。
-- @param filter function 筛选函数，接受ability对象，返回boolean
-- @return interger
function AbilityUnit:countAbility(filter)
    return getImpl(self).abilityGroup:count(filter)
end

--- 查询随机count个符合条件的能力。
-- @param filter function 筛选函数，接受ability对象，返回boolean
-- @param count number 数量
-- @return Ability[] 符合条件的能力
function AbilityUnit:randomListAbility(filter, count)
    local abilityGroup = getImpl(self).abilityGroup
    local randomGenerator = self:getRandomGenerator()
    return abilityGroup:randomList(randomGenerator, filter, count)
end

function AbilityUnit:getExclusiveAbility(exclusiveTag)
    local exclusiveMap = getImpl(self).exclusiveMap
    return exclusiveMap and exclusiveMap[exclusiveTag]
end

--- 获取指定状态层数（相同状态ID不同来源单位会单独计算）
---@param stateId number 状态ID
---@param sourceUnit Unit 来源单位
---@return number 状态层数总和
function AbilityUnit:getStateLayer(stateId, sourceUnit)
    local total = 0
    local abilities = self:searchAbility(
        AbilityFilter.filterAnd(
            AbilityFilter.filterStateId(stateId),
            AbilityFilter.filterSourceUnit(sourceUnit)
        )
    )
    for _, ability in ipairs(abilities) do
        total = total + ability:getStackLayer()
    end
    return total
end

--- 获取唯一状态层数（相同状态ID不同来源单位会合并计算）
---@param stateId integer 状态ID
---@return integer 状态层数总和
function AbilityUnit:getUniqueStateLayer(stateId)
    local total = 0
    local abilities = self:searchAbility(
        AbilityFilter.filterStateId(stateId)
    )
    for _, ability in ipairs(abilities) do
        total = total + ability:getStackLayer()
    end
    return total
end

--- 获取状态组的总层数
--- @param group integer 要检查的状态组标识
--- @return integer 当前这个单位身上groupId下的状态层数的总和，没有返回nil
function AbilityUnit:stateGroupCount(group)
    local total = 0
    local abilities = self:searchAbility(
        AbilityFilter.filterStateGroup(group)
    )
    for _, ability in ipairs(abilities) do
        total = total + ability:getStackLayer()
    end
    return total
end

function AbilityUnit:countAbilityWithTag(tag)
    local filter = AbilityFilter.filterTag(tag)
    return self:countAbility(filter)
end


--- 自己是否被集fired
function AbilityUnit:isAimed()
    return self:getExclusiveAbility('beAimed') ~= nil
end

function AbilityUnit:getGrid()
    return getImpl(self).grid
end
function AbilityUnit:getDistance(unit)
    local impl = getImpl(self)
    local target = getImpl(unit)
    return impl.gridGraph:getDistance(impl, target)
end

function AbilityUnit:getDistanceX(unit)
    return math.abs(getImpl(self).coordX - getImpl(unit).coordX)
end

function AbilityUnit:getDistanceY(unit)
    return math.abs(getImpl(self).coordY - getImpl(unit).coordY)
end

--- 根据Y轴偏移量和自身单位朝向查找空网格
--- @param diffY number Y轴方向的偏移量，用于计算目标行坐标（当前网格Y坐标+偏移量）
--- @return table|nil 找到的空网格对象，若未找到则返回nil
function AbilityUnit:findEmptyGridByLine(diffY)
    local bestY = self:getGrid().coordY + diffY
    local forward = self:getForward()
    return getImpl(self).gridGraph:getEmptyGridByLine(bestY, forward)
end

--- 判断自身在另一个单位身后
function AbilityUnit:isBackOf(unit)
    return unit:getForward() * (getImpl(unit).coordX - getImpl(self).coordX) > 0
end

--- 创建一个组合筛选器
function AbilityUnit:filterAnd(...)
    return AbilityFilter.filterAnd(...)
end

--- 创建一个组合筛选器
function AbilityUnit:filterOr(...)
    return AbilityFilter.filterOr(...)
end

--- 创建一个组合筛选器
function AbilityUnit:filterNot(filter1)
    return AbilityFilter.filterNot(filter1)
end

--- 返回一个筛选器，永远成功
function AbilityUnit:filterTrue()
    return function (unit)
        return true
    end
end

--- 返回一个筛选器，永远失败
function AbilityUnit:filterFalse()
    return function (unit)
        return false
    end
end

--- 返回一个筛选器，按概率成功
function AbilityUnit:filterProb(prob)
    return function (unit)
        return self:getRandomProb(prob)
    end
end

--- 返回一个筛选器，匹配ID
function AbilityUnit:filterId(id)
    return function (unit)
        return unit:getId() == id
    end
end

--- 返回一个筛选器，只匹配自身
function AbilityUnit:filterSelf()
    return function (unit)
        return unit == self
    end
end

--- 返回一个筛选器，不匹配自身
function AbilityUnit:filterNotSelf()
    return function (unit)
        return unit ~= self
    end
end
--- 筛选友方
function AbilityUnit:filterFriend()
    return function (unit)
        return unit:isAlive() and unit:isFriend(self)
    end
end

--- 筛选敌方
function AbilityUnit:filterEnemy()
    return function (unit)
        return unit:isAlive() and unit:isEnemy(self)
    end
end

--- 筛选指定阵营
function AbilityUnit:filterCamp(camp)
    return function (unit)
        return unit:getCamp() == camp
    end
end

--- 筛选被集火的敌方
function AbilityUnit:filterAimed()
    return function (unit)
        return unit:isEnemy(self) and unit:isAimed()
    end
end

--- 筛选具有某属性的单位
function AbilityUnit:filterAttr(attrName)
    return function (unit)
        return unit:getAttr(attrName)
    end
end

--- 筛选存活单位
function AbilityUnit:filterAlive()
    return AbilityUnit.isAlive
end
--- 筛选死亡单位
function AbilityUnit:filterDead()
    return AbilityUnit.isDead
end

--- 筛选火元素单位
function AbilityUnit:filterFireUnit()
    return AbilityUnit.isElemFire
end

--- 筛选距离。筛选距离不超过范围的单位，筛选器返回优先级，数越大越近
---@param distance number 最大有效距离
---@return fun(unit: Unit):number|boolean 返回优先级函数，当单位在范围内时返回距离，否则返回false
function AbilityUnit:filterDistance(distance)
    return function (unit)
        local distance1 = self:getDistance(unit)
        if distance1 > distance then
            return false
        end
        local distanceY = self:getDistanceY(unit)
        return distance1 + 0.001 * distanceY
    end
end

--- 筛选X轴距离。筛选水平距离不超过范围的单位
---@param distanceX number 最大水平距离
---@return fun(unit: Unit):number|boolean 返回优先级函数，当单位在范围内时返回水平距离，否则返回false
function AbilityUnit:filterDistanceX(distanceX)
    return function (unit)
        local distance1 = self:getDistanceX(unit)
        if distance1 > distanceX then
            return false
        end
        return distance1
    end
end

--- 筛选Y轴距离。筛选垂直距离不超过范围的单位
---@param distanceY number 最大垂直距离
---@return fun(unit: Unit):number|boolean 返回优先级函数，当单位在范围内时返回垂直距离，否则返回false
function AbilityUnit:filterDistanceY(distanceY)
    return function (unit)
        local distance1 = self:getDistanceY(unit)
        if distance1 > distanceY then
            return false
        end
        return distance1
    end
end

--- 返回用于前方优先排序的优先级函数
---@return fun(unit: Unit):number 排序函数，返回的数值越大表示单位越靠前
---@note 排序逻辑：根据单位的面向方向和X坐标计算优先级
function AbilityUnit:filterForward()
    return function (unit)
        local forward = unit:getForward()
        local coordX = getImpl(unit).coordX
        return forward * coordX
    end
end

--- 判断自己是否处于友方最前排位置
---@return boolean 是否是最前排单位
---@note 筛选条件：同阵营、Y轴距离为0、使用前方优先排序规则
function AbilityUnit:isFront()
    local filter = self:filterAnd(self:filterFriend(), self:filterDistanceY(0), self:filterForward())
    return self:maxUnit(filter) == self
end

--- 判断自己是否处于友方最后排位置
---@return boolean 是否是最后排单位
---@note 筛选条件：同阵营、Y轴距离为0、使用后方优先排序规则
function AbilityUnit:isBack()
    local filter = self:filterAnd(self:filterFriend(), self:filterDistanceY(0), self:filterForward())
    return self:minUnit(filter) == self
end

--- 创建前排单位筛选器
---@return fun(unit: Unit):boolean 返回判断单位是否在前排的函数
function AbilityUnit:filterFront()
    return AbilityUnit.isFront
end

--- 创建后排单位筛选器
---@return fun(unit: Unit):boolean 返回判断单位是否在后排的函数
function AbilityUnit:filterBack()
    return AbilityUnit.isBack
end

--- 筛选周围一圈目标
function AbilityUnit:filterAroundTarget(camp)

    if camp == -1 or camp == nil then
        return self:filterAnd(self:filterEnemy(), self:filterDistance(1))
    elseif camp == 0 then 
        return self:filterDistance(0)
    end

    return self:filterAnd(self:filterFriend(), self:filterDistance(1))
end

function AbilityUnit:checkCondition(conditionArgs, targetUnit)
    return getImpl(self):checkCondition(conditionArgs, targetUnit)
end
--- 筛选符合条件的单位。
--- 不推荐。可以用各种条件判断函数代替。
function AbilityUnit:filterCondition(conditions)
    return function (unit)
        return self:checkCondition(conditions, unit)
    end
end

function AbilityUnit:filterEnemyInRange(attackDistance)
    attackDistance = attackDistance or self:getAttr('attack_range')/10000
    return self:filterAnd(self:filterEnemy(), self:filterDistance(attackDistance))
end

function AbilityUnit:filterVisible()
    local function filter(unit)
        return not getImpl(unit).hide
    end
    return filter
end

--- 查询一个目标。
--- @param filter function 筛选函数，接受unit对象，返回boolean
--- @return Unit|nil 符合条件的单位
function AbilityUnit:findUnit(filter)
    local visibleFilter = self:filterAnd(self:filterVisible(), filter)
    return getImpl(self).abilityGroup:find(visibleFilter)
end

--- 取优先级最大的目标
--- @param filterWithPriority function 筛选函数，接受unit对象，返回int
--- @return Unit|nil 符合条件的单位
function AbilityUnit:maxUnit(filterWithPriority)
    local visibleFilter = self:filterAnd(self:filterVisible(), filterWithPriority)
    return getImpl(self).unitGroup:max(visibleFilter)
end

--- 取优先级最小的目标
--- @param filterWithPriority function 筛选函数，接受unit对象，返回int
--- @return Unit|nil 符合条件的单位
function AbilityUnit:minUnit(filterWithPriority)
    local visibleFilter = self:filterAnd(self:filterVisible(), filterWithPriority)
    return getImpl(self).unitGroup:min(visibleFilter)
end

--- 搜索目标
-- @param filter function 筛选函数，接受unit对象，返回boolean
-- @return table 符合条件的单位列表
function AbilityUnit:searchUnit(filter)
    local visibleFilter = self:filterAnd(self:filterVisible(), filter)
    return getImpl(self).unitGroup:search(visibleFilter)
end

--- 取自己的嘲讽来源
function AbilityUnit:getTauntUnit()
    local tauntState = self:getExclusiveAbility('beTaunted')
    return tauntState and tauntState:getFromUnit()
end

--- 查找自己的集火敌人
function AbilityUnit:findAimedEnemy()
    return self:findUnit(self:filterAimed())
end

--- 查找自己的射程内最近敌人
function AbilityUnit:findNearestEnemy()
    return self:minUnit(self:filterEnemyInRange())
end

--- 查找自己的射程内最远敌人
function AbilityUnit:findFarestEnemy()
    return self:maxUnit(self:filterEnemyInRange())
end

--- 查找自己的攻击目标
function AbilityUnit:findNormalTarget()
    return self:getTauntUnit() or self:findNearestEnemy()
end

--- 查找自己的集火目标
function AbilityUnit:findAimedTarget()
    return self: findAimedEnemy() or self:getTauntUnit() or self:findNearestEnemy()
end

--- 生命值最少的敌人
function AbilityUnit:findMinHpTarget()
    return self:minUnit(self:filterAnd(self:filterEnemy(), self:filterAttr('hp')))
end

--- 生命值最少的友方
function AbilityUnit:findMinHpFriendTarget()
    return self:minUnit(self:filterAnd(self:filterFriend(), self:filterAttr('hp')))
end

--- 获取除自己外所有友方Unit
function AbilityUnit:findOtherFriendTarget()
    return self:searchUnit(self:filterAnd(self:filterFriend(),self:filterNotSelf()))
end

--- 攻击最高的友方
function AbilityUnit:findMaxAtkFriendTarget()
    return self:maxUnit(self:filterAnd(self:filterFriend(), self:filterAttr('final_atk')))
end

--- 攻击最高的友方（不含自己）
function AbilityUnit:findMaxAtkFriendTargetNoSelf()
    return self:maxUnit(self:filterAnd(self:filterFriend(), self:filterNotSelf(), self:filterAttr('final_atk')))
end

--- 能量值最多的敌人
function AbilityUnit:findMaxManaTarget()
    return self:maxUnit(self:filterAnd(self:filterEnemy(), self:filterAttr('mana')))
end

--- 随机一名或多名友方
function AbilityUnit:findRandomFriendTarget(count)

    if count == nil then count = 1 end

    if count == 1 then
        local allFriend = self:searchUnit(self:filterAnd(self:filterFriend(), self:filterAlive()))
        local randomFriend = self:getRandomChoice(allFriend)
        return randomFriend
    else
        local allFriend = self:searchUnit(self:filterAnd(self:filterFriend(), self:filterAlive()))
        local randomFriend = self:getRandomChoices(allFriend,count)
        return randomFriend
    end
end

--- 随机一名或多名敌人
function AbilityUnit:findRandomEnemyTarget(count)

    if count == nil then count = 1 end

    if count == 1 then
        local allEnemys = self:searchUnit(self:filterAnd(self:filterEnemy(), self:filterAlive()))
        local randomEnemy = self:getRandomChoice(allEnemys)
        return randomEnemy
    else
        local allEnemys = self:searchUnit(self:filterAnd(self:filterEnemy(), self:filterAlive()))
        local randomEnemy = self:getRandomChoices(allEnemys,count)
        return randomEnemy
    end
end

--- 随机一名友方（不含自己）
function AbilityUnit:findRandomFriendTargetNoSelf()

    local allFriend = self:searchUnit(self:filterAnd(self:filterFriend(), self:filterNotSelf(), self:filterAlive()))
    local randomFriend = self:getRandomChoice(allFriend)
    return randomFriend
    
end

--- 周围一圈目标 return {unit}
function AbilityUnit:findAroundTarget(camp)
    local allTargets
    if camp == nil then camp = -1 end
    if camp == -1 then
        allTargets = self:filterAnd(self:filterEnemy(), self:filterDistance(1))
    elseif camp == 0 then 
        allTargets = self:filterAnd(self:filterDistance(0))
    else
        allTargets = self:filterAnd(self:filterFriend(), self:filterDistance(1))
    end
    return self:searchUnit(allTargets)
end

--- 筛选：参数在调用者的后方并且是同一排
function AbilityUnit:filterAtBack(range)
    local function filter(unit)
        if not unit:isBackOf(self) or self:getDistanceY(unit) > 0.01 then
            return false
        end
        local distanceX = self:getDistanceX(unit)
        return distanceX <= range and distanceX
    end
    return filter
end

--- 筛选:指定的职业
function AbilityUnit:filterCareer(career_1,career_2,career_3,career_4,career_5)
    return function(unit)
        local career = unit:getAttr('career')
        return career == career_1 or career == career_2 or career == career_3 or career == career_4, career == career_5
    end
end

--- 获取职业为x的友方
function AbilityUnit:findCareerFriend(career_1,career_2,career_3,career_4,career_5)
    local filter = self:filterAnd(self:filterFriend(),self:filterCareer(career_1,career_2,career_3,career_4,career_5))
    return self:searchUnit(filter)
end

--- 身后N格内的友方
function AbilityUnit:findFriendAtBack(range)
    local filter = self:filterOr(self:filterAnd(self:filterFriend(), self:filterAlive(), self:filterAtBack(range)),self:filterSelf())
    return self:searchUnit(filter)
end

--- 身后N格内的敌方
function AbilityUnit:findEnemyAtBack(range)
    local filter = self:filterOr(self:filterAnd(self:filterEnemy(), self:filterAlive(), self:filterAtBack(range)),self:filterSelf())
    return self:searchUnit(filter)
end

--- 身后N格内的友方（不含自己）
function AbilityUnit:findFriendAtBackNoSelf(range)
    local filter = self:filterAnd(self:filterFriend(), self:filterAlive(), self:filterAtBack(range))
    return self:searchUnit(filter)
end

--- 身后N格内的敌方（不含自己）
function AbilityUnit:findEnemyAtBackNoSelf(range)
    local filter = self:filterAnd(self:filterEnemy(), self:filterAlive(), self:filterAtBack(range))
    return self:searchUnit(filter)
end


--- 生命值百分比最少的友方
function AbilityUnit:findMinHpPCTFriendTarget()
    local allFriend = self:filterAnd(self:filterFriend(), self:filterHPPercent())
    local minHpFriend = self:minUnit(allFriend)
    return minHpFriend
end

--- 返回所有友方（根据生命值百分比排序）
function AbilityUnit:findMinHpPCTTarget()
    local allFriend = self:filterAnd(self:filterFriend(), self:filterHPPercent())
    local minHpFriends = self:searchUnit(allFriend)
    return minHpFriends
end

--- 生命值百分比最少的友方
function AbilityUnit:findMinHpPCTFriendTargetNoSelf()
    local allFriend = self:filterAnd(self:filterFriend(), self:filterNotSelf(), self:filterHPPercent())
    local minHpFriend = self:minUnit(allFriend)
    return minHpFriend
end


--- 生命值百分比最少的敌方
function AbilityUnit:findMinHpPCTEnemyTarget()
    local allEnemys = self:filterAnd(self:filterEnemy(), self:filterHPPercent())
    local minHpEnemy = self:minUnit(allEnemys)
    return minHpEnemy
end

---同一排的目标
function AbilityUnit:findSameRowFriendTarget()
    local targets = self:filterAnd(self:filterFriend(),self:filterDistanceX(0.6))
    return self:searchUnit(targets)
end

---最近的敌方单位
function AbilityUnit:findNearestEnemyInRange(range)
    return self:minUnit(self:filterEnemyInRange(range))
end

--- 创建当前生命百分比筛选器（用于maxUnit等需要优先级数值的场景）
--- @return fun(unit: Unit):number 返回单位属性值
function AbilityUnit:filterHPPercent()
    local function filter(unit)
        local hp = unit:getAttr("hp")
        local mhp = unit:getAttr("final_mhp")
        local hppct = hp/mhp
        return hppct > 0 and hppct
    end
    return filter
end


--- 打印属性log
---@param ... string Attr的字符串，需要打印几个写几个，如："final_mhp"
function AbilityUnit:printAllAttr(...)
    local args = {...}
    local str = string.format("以下是%s的全部属性",self:getId())
    for i,attr in ipairs(args) do
        str = str..string.format("\n%s = %s",attr,self:getAttr(attr))
    end
    print(str)
end


--------------------------------------------------------------------------------

--- 计算物理伤害倍数
--- @param targetUnit Unit 目标单位
--- @param skillType integer 技能类型 Enum.SkillType
--- @param elemType integer 元素类型 Enum.ElemType
--- @param critDmgAdd number 暴击伤害加成（万分比，例如1000表示+10%暴击伤害）
--- @param defPercent number|nil 目标防御系数（万分比，nil表示100%，例如1000表示只代入10%目标防御）
--- @return number damageFactor 伤害倍数
--- @return boolean isCrit 是否触发暴击
---
--- - 伤害倍数 = 防御系数 × 暴击系数 × 格挡系数 × 威力系数 × 伤害系数 × 元素系数
--- - 实际伤害 = 基础伤害值 × 伤害倍数
--- - 系数分解：
---   1. 防御系数 (`factorDefense`)：计算目标物理防御减伤
---   1. 暴击系数 (`factorCrit`)：包含暴击率和暴击伤害计算
---   1. 格挡系数 (`factorBlock`)：计算目标格挡概率及减伤
---   1. 威力系数 (`factorPower`)：基于技能类型的攻击强化
---   1. 伤害系数 (`factorHurt`)：综合攻防双方的伤害增减益
---   1. 元素系数 (`factorElem`)：元素克制关系计算
function AbilityUnit:factorSkillDamage(targetUnit, skillType, elemType, critDmgAdd, defPercent)
    local f1 = self:factorDefense(targetUnit, defPercent)
    local f2, crit = self:factorCrit(targetUnit, critDmgAdd)
    local f3 = self:factorBlock(targetUnit)
    local f4 = self:factorPower(targetUnit, skillType) * self:factorHurt(targetUnit, skillType)
    local f5 = self:factorElem(targetUnit, elemType)
    return f1*f2*f3*f4*f5, crit
end

--- 计算生命流失倍数（无视防御、暴击机制）
--- @param targetUnit Unit 目标单位
--- @param skillType integer 技能类型 Enum.SkillType
--- @return number 流失倍数
---
--- - 流失倍数 = 威力系数
--- - 实际流失值 = 基础值 × 流失倍数
--- - 受技能类型的威力系数影响
--- - 无视防御、暴击等常规战斗机制
--- - 系数分解：
---   1. 威力系数 (`factorPower`)：基于技能类型的攻击强化
function AbilityUnit:factorSkillLoss(targetUnit, skillType)
    -- 仅使用技能类型的威力系数
    return self:factorPower(targetUnit, skillType)
end

--- 计算治疗倍数
--- @param targetUnit Unit 被治疗单位
--- @param skillType integer 技能类型 Enum.SkillType
--- @return number 治疗倍数
---
--- - 治疗倍数 = 威力系数 × 治疗系数
--- - 实际治疗量 = 基础值 × 治疗倍数
--- - 系数分解：
---   1. 威力系数 (`factorPower`)：基于技能类型的治疗强化
---   1. 治疗系数 (`factorHeal`)：施法者治疗效能 × 目标受治疗增益
function AbilityUnit:factorSkillHeal(targetUnit, skillType)
    return self:factorPower(targetUnit, skillType) * self:factorHeal(targetUnit)
end

--- 计算护盾生成倍数
--- @param targetUnit Unit 目标单位
--- @param skillType integer 技能类型 Enum.SkillType
--- @return number 护盾倍数
---
--- - 护盾倍数 = 威力系数 × 护盾系数
--- - 实际护盾值 = 基础值 × 护盾倍数
--- - 系数分解：
---   1. 威力系数 (`factorPower`)：基于技能类型的护盾强化
---   1. 护盾系数 (`factorShield`)：施法者护盾效能 × 目标护盾增益
function AbilityUnit:factorSkillShield(targetUnit, skillType)
    -- 威力系数 × 护盾效能系数
    return self:factorPower(targetUnit, skillType) * self:factorShield(targetUnit)
end

--- 计算物理防御减伤系数
--- @param targetUnit Unit 受击目标单位
--- @param defPercent number|nil 防御系数，万分比，nil表示100%
--- @return number 防御减伤系数（范围：0~1）
--- - 计算逻辑：
---   1. 根据目标护甲值、攻击方破甲属性计算真实护甲
---   1. 应用护甲收益曲线公式：1 / (1 + 真实护甲 / 护甲系数1)
---   1. 最终系数不低于目标单位的防御下限值
function AbilityUnit:factorDefense(targetUnit, defPercent)
    local ownerUnit = self
    local def = targetUnit:getAttr('final_p_def') * (defPercent or 10000) / 10000
    local percent = ownerUnit:getAttr('arp_percent')
    local target = getImpl(targetUnit)
    local realArmor = def  / (target.level * BattleConst.BATTLE_ARMOR_ARG2) * (10000 - percent) / 10000
    realArmor = math.max(realArmor, 0)
    return math.max(target.defReduceLimit, (1 /  (1 + realArmor/BattleConst.BATTLE_ARMOR_ARG1)))
end

--- 计算暴击系数及暴击判定
--- @param targetUnit Unit 受击目标单位
--- @param critDmgAdd integer 额外暴击伤害加成（万分比）
--- @return number 暴击伤害系数（1表示未暴击）
--- @return boolean 是否触发暴击
---
--- - 计算逻辑：
---   1. 暴击率 = 攻击方暴击率 - 目标暴击抵抗
---   1. 暴击伤害 = 基础暴伤 + 加成 - 目标暴伤减免（最低125%）
---   1. 万分比数值除以10000为倍数
function AbilityUnit:factorCrit(targetUnit, critDmgAdd)
    if not critDmgAdd then
        return 1, false
    end
    local ownerUnit = self
    local critRate = ownerUnit:getAttr('cri_rate') - targetUnit:getAttr('cri_reduce')
    local isCrit = ownerUnit:getRandomProb(critRate)
    if isCrit then
        local critDamage = ownerUnit:getAttr('cri_dmg') - targetUnit:getAttr('cri_dmg_reduce') + (critDmgAdd or 0)
        return math.max(12500, critDamage) / 10000, true
    end
    return 1, false
end
--- 计算格挡减伤系数
--- @param targetUnit Unit 受击目标单位
--- @return number 格挡减伤系数（1表示未格挡）
---
--- - 流程说明：
---   1. 根据目标格挡率进行随机判定
---   1. 触发格挡时添加表现层事件
---   1. 格挡减伤公式：1 - 目标格挡减伤百分比
function AbilityUnit:factorBlock(targetUnit)
    local ownerUnit = self
    local isBlock = ownerUnit:getRandomProb(targetUnit:getAttr('blockRate'))
    if isBlock then
        targetUnit:addOutput( BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {BattleConst.STATE_BLOCK_RATE} )
        return (1 - targetUnit:getAttr('block_dmg'))
    end
    return 1
end

--- 计算技能威力系数
--- @param targetUnit Unit 目标单位（未使用）
--- @param skillType integer 技能类型 @see Enum.SkillType
--- @return number 技能威力倍数
---
--- - 类型加成规则：
---   1. 普攻：受 ca_percent（普攻加成）属性影响
---   1. 大招：受 sp_percent（大招加成）属性影响
function AbilityUnit:factorPower(targetUnit, skillType)
    local ownerUnit = self
    local x = 1.0
    if skillType == Enum.SkillType.PuGong then
        x = 1 + ownerUnit:getAttr('ca_percent') / 10000
    elseif skillType == Enum.SkillType.DaZhao then
        x = 1 + ownerUnit:getAttr('sp_percent') / 10000
    end
    return x
end

--- 计算治疗效能系数
--- @param targetUnit Unit 被治疗单位
--- @return number 治疗效能系数
---
--- - 计算公式：（10000 + 治疗者强度） × （10000 + 受治疗者增益） / 100000000
--- - 属性说明：
---   1. heal_effect：治疗者的治疗强度
---   1. heal_enhance_percent：受治疗者的治疗增益
function AbilityUnit:factorHeal(targetUnit)
    local ownerUnit = self
    local a = 10000 + math.max(0, ownerUnit:getAttr('heal_effect'))
    local d = 10000 + math.max(0, targetUnit:getAttr('heal_enhance_percent'))
    return a / 10000 * d / 10000
end

--- 计算护盾效能系数
--- @param targetUnit Unit 护盾目标单位
--- @return number 护盾效能系数
---
--- - 计算公式：（10000 + 护盾强度） × （10000 + 护盾增益） / 100000000
--- - 属性说明：
---   1. shield_effect：施法者的护盾强度
---   1. shield_enhance_percent：目标的护盾增益
function AbilityUnit:factorShield(targetUnit)
    local ownerUnit = self
    local a = 10000 + ownerUnit:getAttr('shield_effect')
    local d = 10000 + targetUnit:getAttr('shield_enhance_percent')
    return a / 10000 * d / 10000
end

--- 计算综合伤害系数（含PVP和技能类型修正）
--- @param targetUnit Unit 受击目标单位
--- @param skillType integer 技能类型 @see Enum.SkillType
--- @return number 伤害系数
---
--- - 计算步骤：
---   1. 基础伤害加成计算
---   1. PVP环境特殊修正
---   1. 战力压制修正
---   1. 技能类型专属修正
function AbilityUnit:factorHurt(targetUnit, skillType)
    local ownerUnit = self
    local a = 10000 + ownerUnit:getAttr('damage_percent')
    local d = 10000 - targetUnit:getAttr('damage_reduce_percent')
    local x = a / 10000 * d / 10000
    if ownerUnit:isPvp() then
        local a1 = ownerUnit:getAttr('pvp_dmgup_per')
        local d1 = targetUnit:getAttr('pvp_dmgreduce_per')
        x = x * math.max(0 , 10000 + a1 - d1) / 10000
    end
    local a2 = 10000 + ownerUnit:getAttr('battlerate_dmgup_per')
    local d2 = 10000 - targetUnit:getAttr('battlerate_dmgreduce_per')
    x = x * a2 / 10000 * d2 / 10000
    local a3 = 10000 + ownerUnit:getAttr('skill_dmgup_per_'..skillType)
    local d3 = 10000 - targetUnit:getAttr('skill_dmgreduce_per_'..skillType)
    x = x * a3 / 10000 * d3 / 10000
    return x
end

--- 计算元素克制系数
--- @param targetUnit Unit 受击目标单位
--- @param elemType integer 元素类型
--- @see Enum.ElemType
--- @return number 元素克制系数
---
--- - 计算规则：
---   1. 元素强化值范围：-10000~+∞
---   1. 元素抗性值范围：-∞~10000
---   1. 最终系数 = （强化百分比 × 抗性百分比）
function AbilityUnit:factorElem(targetUnit, elemType)
    local ownerUnit = self
    if elemType then
        local elemEnhancePercent = 10000 + math.max(-10000, ownerUnit:getAttr('elem_enhance_'..elemType))
        local elemResistPercent = 10000 - math.min(10000, targetUnit:getAttr('elem_resist_'..elemType))
        return elemEnhancePercent / 10000 * elemResistPercent / 10000
    end
    return 1
end

--- 获取敌人数量
--- @return number 敌人数量
function AbilityUnit:getEnemyCount(elem)

    local arr = 0

    if elem == 0 or elem == nil then
        arr = self:searchUnit(self:filterEnemy())
    elseif elem == 1 then
        arr = self:searchUnit(self:filterEnemy(),self:isElemEarth())
    elseif elem == 2 then
        arr = self:searchUnit(self:filterEnemy(),self:isElemIce())
    elseif elem == 3 then
        arr = self:searchUnit(self:filterEnemy(),self:isElemFire())
    elseif elem == 4 then
        arr = self:searchUnit(self:filterEnemy(),self:isElemWind())
    elseif elem == 5 then
        arr = self:searchUnit(self:filterEnemy(),self:isElemLight())
    elseif elem == 6 then
        arr = self:searchUnit(self:filterEnemy(),self:isElemDark())
    end

    return #arr

end

--- 获取友军数量
--- @return number 友军数量
function AbilityUnit:getFriendCount(elem)

    local arr = 0

    if elem == 0 or elem == nil then
        arr = self:searchUnit(self:filterFriend())
    elseif elem == 1 then
        arr = self:searchUnit(self:filterFriend(),self:isElemEarth())
    elseif elem == 2 then
        arr = self:searchUnit(self:filterFriend(),self:isElemIce())
    elseif elem == 3 then
        arr = self:searchUnit(self:filterFriend(),self:isElemFire())
    elseif elem == 4 then
        arr = self:searchUnit(self:filterFriend(),self:isElemWind())
    elseif elem == 5 then
        arr = self:searchUnit(self:filterFriend(),self:isElemLight())
    elseif elem == 6 then
        arr = self:searchUnit(self:filterFriend(),self:isElemDark())
    end

    return #arr

end

--- 输出信息到表现层
function AbilityUnit:addOutput(outputType, args)
    getImpl(self):addOutput(outputType, args)
end

function AbilityUnit:toString()
    return getImpl(self):toString()
end

local AbilityUnitMt = {__index=AbilityUnit, __tostring = AbilityUnit.toString}

local function newAbilityUnit(id, logger)
    local unit = {}
    local impl = AbilityUnitImpl(unit, id, logger)
    unit.___impl = impl
    setmetatable(unit, AbilityUnitMt)
    return unit, impl
end

return newAbilityUnit
