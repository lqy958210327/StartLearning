local getImpl = require "Core/Common/FrameBattle/Ability/getImpl"
local MatrixOp = require "Core/Common/FrameBattle/Lib/MatrixOp"
local Group = require("Core/Common/FrameBattle/Ability/Group")
local Random = require("Core/Common/FrameBattle/Ability/Random")
local GridGraph = require("Core/Common/FrameBattle/Ability/GridGraph")
local BattleWave = require("Core/Common/FrameBattle/Ability/BattleWave")
local AbilityTrigger = require("Core/Common/FrameBattle/Ability/AbilityTrigger")
local AbilityDataTable = require("Core/Common/FrameBattle/Ability/AbilityDataTable")
local BehaviorManager = require("Core/Common/FrameBattle/Behavior/BehaviorManager")
local AbilityUnit = require("Core/Common/FrameBattle/Ability/AbilityUnit")
local GridTrigger = require("Core.Common.FrameBattle.Ability.GridTrigger")
local BattleConst = AbilityDataTable.BattleConst
local ResBattleField = AbilityDataTable.ResBattleField

local AbilityConfigBattle = {}
function AbilityConfigBattle:onAttach()
    self.unitGroup = Group()
    self.gridGraph = GridGraph(self:getLogger())
    self.gridTrigger = GridTrigger(self:getLogger())
    local rootUnitImpl = getImpl(self:getOwnerUnit())
    rootUnitImpl.matrixAbility = self
    rootUnitImpl.unitGroup = self.unitGroup
    rootUnitImpl.gridGraph = self.gridGraph
    --注意unitGroup里没有rootUnit自身
end
function AbilityConfigBattle:battleInit(initInfo, frameLength, frameOutput, frameInput)
    self.frameOutput = frameOutput
    self.frameInput = frameInput
    self.frameInputIndex = 0
    self.matrixId = initInfo.matrixInit.battleId
    self.debugGmEnable = initInfo.matrixInit.debugGmEnable
    local randomSeed = initInfo.matrixInit.randomSeed
    self.randomGenerator = Random(randomSeed)
    self.matrixOptions = {auto = true, long = true}
    local resBattle = self.resBattle
    self.frameLength = frameLength
    self.framePerSec = 1000 / frameLength
    self.maxTime = resBattle.maxTime or BattleConst.MATRIX_DEFAULT_MAX_TIME
    self.curTime = 0
    self.frameNumber = 0
    self.realFrameNumber = 0
    self.prepareFrame = BattleConst.MATRIX_ENTITY_PREPARE_FRAME
    self.resumePauseFrame = self.prepareFrame
    self.isPvp = resBattle.is_pvp
    self.bhMgr = BehaviorManager()
    self.gridGraph:createMap(resBattle.matrix_type)
    self.isZombie = resBattle.matrix_type == 2
    self.battleWave, self.holdPos = BattleWave(self.battleId, self:getLogger())
    local matrixInit = initInfo.matrixInit
    local round = initInfo.round
    self.initCamp = {}
    for campId, campInit in ipairs(matrixInit.camp) do
        self.initCamp[campId] = {
            unit = campInit.raid.team[round].unit,
            capacity = campInit.raid.team[round].capacity,
            modifier = campInit.modifier,
            roundModifier = campInit.roundModifier[round],
        }
    end
    if resBattle.traps then
        local traps = resBattle.traps
        for i = 1, #traps, 2 do
            local trapId, trapPos = traps[i], traps[i+1]
            local grid = trapPos and self.gridGraph:getPosInfo(trapPos)
            if trapId and grid then
                self:createTrapById(grid, trapId)
            end
        end
    end
--    self.weatherManager = BattleWeatherManager(self, initInfo.battleConfig)
--    self.petManager = CombatPetManager(self, initInfo.petEntity, initInfo.entityDict)

    -- 一定条件加强的敌对状态
--    self.monsterConditionStates = CombatUtils.getBattleConditionStates(initInfo.battleConfig, initInfo.entityDict)

    self.maxUnitId = 0
    for campId, camp in ipairs(self.initCamp) do
        for _, unit in ipairs(camp.unit) do
            unit.unit = self:battleCreateUnit(campId, unit)
        end
    end
    self:battlePause(self.prepareFrame * self.frameLength / 1000)
    -- 初始化工具人，但不要把它放进战场
    local rootUnit = self:getOwnerUnit()
    local root = getImpl(rootUnit)
    root:init(self, 1, {type='Other', resId=100, pos = 0, hide = true})
    --root:addAttr('immuneChangeCamp', 1)
    --root:addAttr('immuneControlled', 1)
    --root:addAttr('immuneDisarm', 1)
    --root:addAttr('immuneSilence', 1)
    --root:addAttr('immuneForbidPassive', 1)
    --root:addAttr('damageImmune', 1)
    --root:addAttr('unDead', 1)
end

function AbilityConfigBattle:battlePause(pauseTime)
    local pauseFrame = math.floor(pauseTime * self.framePerSec)
    self.resumePauseFrame = self.frameNumber + pauseFrame
    local function pauseUnit(unit)
        getImpl(unit):skillPauseFrame(pauseFrame)
    end
    self.unitGroup:forEach(pauseUnit)
end

function AbilityConfigBattle:battleFrame(frameNumber)
    self.frameNumber = frameNumber
    if self.resumePauseFrame then
        if frameNumber >= self.resumePauseFrame then
            self.resumePauseFrame = nil
        end
    else
        local preTime = self.curTime
        self.realFrameNumber = self.realFrameNumber + 1
        self.curTime = math.floor(self.realFrameNumber * self.frameLength / 1000)
        if self.curTime > preTime then
            self:addOutput(BattleConst.MATRIX_EVENT_BATTLE_TIME, { self.maxTime - self.curTime })
        end
    end
    self:getLogger().writer:setFrame(self.frameNumber, self.realFrameNumber)
    self.bhMgr:tick()
    if not self.resumePauseFrame then
        if frameNumber == BattleConst.MATRIX_ENTITY_PREPARE_FRAME then
            self:addOutput(BattleConst.MATRIX_EVENT_BATTLE_START, {})
            self:startWave()
            local function applyAbility(unit)
                self:applyModifierAbility(unit)
            end
            local function applyHit(unit)
                self:applyModifierHit(unit)
            end
            self.unitGroup:forEach(applyAbility)
            self.unitGroup:forEach(applyHit)
        end
        if self.battleWave then
            local monsterId, line = self.battleWave:updateFrame(self.realFrameNumber)
            if monsterId then
                local grid = self.gridGraph:getEmptyGridByLine(line-2, -1)
                local unitInfo = {grid = grid, resId = monsterId, type = 'Monster'}
                self:battleCreateUnit(2, unitInfo)
            end
        end
        if self.weatherManager then
            self.weatherManager:nextFrame(frameNumber)
        end
    end
    local function tickUnit(unit)
        getImpl(unit):updateFrame(self.frameNumber, self.realFrameNumber)
    end
    self.unitGroup:forEach(tickUnit)
    if self.curTime >= self.maxTime then
        self:makeBattleResult(nil, BattleConst.BATTLE_RESULT_TIMEOUT)
    end
end
function AbilityConfigBattle:pcallNextFrame(frameNumber)
    local logger = self:getLogger()
    local ok, err = xpcall(self.nextFrame, logger.traceback, self, frameNumber)
    if not ok then
        logger:error('nextFrame error!', err)
    end
    local attr = self:snapshotAttr()
    logger:debug('snapshotAttr', attr)
end

function AbilityConfigBattle:nextFrame(frameNumber)
    if self.battleResult then
        return
    end
    self:battleFrame(frameNumber)
    self:processInput()
end

local InputHandler = {
    [BattleConst.INPUT_EVENT_USE_SKILL] = function(self, args)
        self:battleInputSkill(args[1])
    end,
    [BattleConst.INPUT_EVENT_SET_AUTO] = function(self, args)
        if not self.isPvp then
            self.matrixOptions.auto = args[1] == 0
        end
    end,
    [BattleConst.INPUT_EVENT_SET_SHORT] = function(self, args)
        self.matrixOptions.long = args[1] == 0
    end,
    [BattleConst.INPUT_EVENT_LEAVE] = function (self, args)
        local x = args[1]
        if self.debugGmEnable and x ~= 0 then
            if x == 1 then
                self:makeBattleResult(2, BattleConst.BATTLE_RESULT_WIN)
            else -- x == 2
                self:makeBattleResult(1, BattleConst.BATTLE_RESULT_LOSE)
            end
        else
            self:makeBattleResult(nil, BattleConst.BATTLE_RESULT_LEAVE)
        end
    end,
}

function AbilityConfigBattle:processInput()
    while self.frameInputIndex < #self.frameInput do
        local input = self.frameInput[self.frameInputIndex + 1]
        if input.frame ~= self.frameNumber then
            return
        end
        local args = MatrixOp.unpackMatrixOp(input.opcode, input.data)
        self:getLogger():trace('processInput', input.opcode, args)
        local func = InputHandler[input.opcode]
        if func then
            func(self, args)
        end
        self.frameInputIndex = self.frameInputIndex + 1
    end
end
function AbilityConfigBattle:battleInputSkill(unitId)
    local function filterId(unit)
        return unit:getId() == unitId
    end
    local unit = self.unitGroup:find(filterId)
    if unit then
        getImpl(unit):inputSkill()
    end
end

function AbilityConfigBattle:battleCreateUnit(camp, unitInfo, summonAttr)
    local unitId = self.maxUnitId + 1
    self.maxUnitId = unitId
    local unit, impl = AbilityUnit(unitId, self:getLogger())
    self.unitGroup:insert(unit)
    impl:init(self, camp, unitInfo, summonAttr)
    if self.frameNumber > 0 then
        self:applyModifierAbility(unit)
    end
    return unit
end

function AbilityConfigBattle:addAbilityList(unit, list)
    if list then
        for _, a in ipairs(list) do
            if a.resId and a.level and a.level > 0 then
                local ab = self:addAbility(unit, a.type, a.resId, a.level, unit)
                if ab and a.type == 'state' then
                    ab:incStackLayer(1)
                end
            end
        end
    end
end

function AbilityConfigBattle:applyModifierAbility(unit)
    local camp = unit:getCamp()
    local campInit = self.initCamp[camp]
    self:addAbilityList(unit, campInit.modifier.ability)
    self:addAbilityList(unit, campInit.roundModifier.ability)
    getImpl(unit):enterBattle() -- 开始触发陷阱
end

function AbilityConfigBattle:applyModifierHit(unit)
    local camp = unit:getCamp()
    local campInit = self.initCamp[camp]
    for _, hit in ipairs(campInit.modifier.hit) do
        self:triggerSkillEvent(unit, unit, hit.skillId, hit.eventId, 1)
    end
    for _, hit in ipairs(campInit.roundModifier.hit) do
        self:triggerSkillEvent(unit, unit, hit.skillId, hit.eventId, 1)
    end
end
--    if self.weatherManager.weatherFriendState and obj.camp == self.weatherManager.weatherCamp then
--        self:addGlobalState(self.weatherManager.weatherFriendState, obj)
--    elseif self.weatherManager.weatherEnemyState and obj.camp ~= self.weatherManager.weatherCamp then
--        self:addGlobalState(self.weatherManager.weatherEnemyState, obj)
--    end
--    self.petManager:addEnterBattleBuff(obj, self.speData)

function AbilityConfigBattle:startWave()
    local battleWave = self.battleWave
    if not battleWave then
        return true
    end
    local wave, maxWave = battleWave:startWave(self.realFrameNumber)
    if wave then
        self:addOutput(BattleConst.MATRIX_EVENT_MONSTER_WAVE, {wave, maxWave})
    end
    return battleWave:finished()
end

function AbilityConfigBattle:battleUnitDie(targetUnit)
    local unitImpl = getImpl(targetUnit)
    self.gridGraph:removeUnit(unitImpl)
    local filterFriend = targetUnit:filterFriend()
    local unit = self.unitGroup:find(filterFriend)
    if unit == nil then -- 一个活人都没找到，GG了
        AbilityTrigger.global(targetUnit, 'onGlobalAced', targetUnit)
        local deadCamp = targetUnit:getCamp()
        if deadCamp == 1 or self:startWave() then
            self:makeBattleResult(deadCamp, nil)
        end
    end
end

function AbilityConfigBattle:makeBattleResult(loseCamp, resultType)
    if self.battleResult then
        return
    end
    local detail = {}
    self.battleResult = detail
    detail.frameInput = self.frameInput
    detail.loseCamp = loseCamp
    detail.result = resultType or (loseCamp == 2 and BattleConst.BATTLE_RESULT_WIN or BattleConst.BATTLE_RESULT_LOSE)
    detail.resultType = detail.result --兼容
    detail.totalTime = self.curTime
    detail.totalFrame = self.realFrameNumber
    detail.wave = self.battleWave and (self.battleWave.waveIdx - 1)
    detail.camp = {}
    for _, campInit in ipairs(self.initCamp) do
        local campResult = {unit={},totalMhp=0,totalHp=0,bossMhp=0,bossHp=0,mvpPos=0,capacity=campInit.capacity}
        table.insert(detail.camp, campResult)
        local mScore = -1
        for _, unitInfo in ipairs(campInit.unit) do
            local unit = unitInfo.unit
            local impl = getImpl(unit)
            local hp = unit:getAttr('hp')
            local mhp = unit:getAttr('final_mhp')
            local hppct = unit:getAttr('hppct')
            local mana = unit:getAttr('mana')
            local boss = unit:isBoss()
            local unitResult = {pos = unitInfo.pos, type = unitInfo.type, gid = unitInfo.gid,
                hp = hppct, mana = mana, stat = impl.stat, onceLong = impl.onceLong,
                resId = unitInfo.resId, image = unitInfo.image, star = unitInfo.star, level = unitInfo.level}
            table.insert(campResult.unit, unitResult)
            campResult.totalMhp = campResult.totalMhp + mhp
            campResult.totalHp = campResult.totalHp + hp
            if boss then
                campResult.bossMhp = campResult.bossMhp + mhp
                campResult.bossHp = campResult.bossHp + hp
            end
            local score = impl.stat.totalDamage * 2 + impl.stat.receiveDamage + impl.stat.totalHeal
            if score >= mScore and unitInfo.type == 'Hero' then
                campResult.mvpPos = unitInfo.pos
                mScore = score
            end
        end
    end
    self:addOutput(BattleConst.MATRIX_EVENT_BATTLE_OVER, { self.matrixId, detail })
end

function AbilityConfigBattle:addMatrixOutput(outputType, args, filter)
    table.insert(self.frameOutput, { outputType, args, filter })
end

function AbilityConfigBattle:snapshotAttr()
    local detail = {}
    detail.totalTime = self.curTime
    detail.totalFrame = self.realFrameNumber
    detail.wave = self.battleWave and (self.battleWave.waveIdx - 1)
    detail.unit = {}
    local function detailUnit(unit)
        local impl = getImpl(unit)
        local unitResult = {id=impl.id, type=impl.type, resId=impl.resId, camp=impl.comp, bornPos=impl.bornPos, level=impl.level,
                            receiveDamage=impl.stat.receiveDamage, receiveHeal=impl.stat.receiveHeal, totalDamage=impl.stat.totalDamage}
        if impl.grid then
            unitResult.grid_x=impl.grid.x
            unitResult.grid_y=impl.grid.y
        end
        table.insert(detail.unit, unitResult)
        local attr = impl.attr
        local function comp(a, b)
            return a.name < b.name
        end
        local function copysort(from, to)
            for name, value in pairs(from) do
                table.insert(to, {name = name, value = value})
            end
            table.sort(to, comp)
        end
        unitResult.init = {}
        copysort(attr.base, unitResult.init)
        unitResult.buff = {}
        copysort(attr.buff, unitResult.buff)
        unitResult.total = {}
        copysort(attr.total, unitResult.total)
        unitResult.final = {}
        copysort(attr.final, unitResult.final)
    end
    self.unitGroup:forEach(detailUnit)
    return detail
end

local function newAbilityConfigBattle(battleId)
    return function (ability)
        ability.battleId = battleId
        ability.resBattle = ResBattleField[battleId]
        ability:addMetatableIndexExtension(AbilityConfigBattle)
        ability:registerTriggerTable({})
    end
end

return newAbilityConfigBattle