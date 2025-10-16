local Group = require("Core/Common/FrameBattle/Ability/Group")
local AbilityDataTable = require("Core/Common/FrameBattle/Ability/AbilityDataTable")
local ResBattleWaveMonster = AbilityDataTable.ResBattleWaveMonster
local ResBattleWaveBoss = AbilityDataTable.ResBattleWaveBoss
local BattleMiscConfig = AbilityDataTable.BattleMiscConfig

local BattleWave = {}

function BattleWave:log(...)
    self.logger:trace(...)
end

function BattleWave:toString()
    return 'BattleWave'
end

function BattleWave:startWave(realFrameNumber)
    if self.monsterIdx then
        return
    end
    self.waveStartFrame = realFrameNumber
    self.waveIdx = (self.waveIdx or 0) + 1
    self.monsterIdx = 1
    return self.waveIdx, #self.resWave.monster_waves
end

function BattleWave:finished()
    return self.waveIdx and self.waveIdx > #self.resWave.monster_waves
end

function BattleWave:updateFrame(realFrameNumber)
    if self.monsterIdx == nil then
        return
    end
    local wave = self.resWave.monster_waves[self.waveIdx]
    if not wave then
        return
    end
    local monsterId = wave.monsters[self.monsterIdx]
    local pos = wave.monsters_pos[self.monsterIdx] or 1
    local frame = wave.monsters_frame[self.monsterIdx] or 0
    if not monsterId then
        self.monsterIdx = nil
        return
    end
    if realFrameNumber >= self.waveStartFrame + wave.frame_num + frame then
        self.monsterIdx = self.monsterIdx < #wave.monsters and self.monsterIdx + 1 or nil
        return monsterId, pos
    end
end

local BattleWaveMt = {__index = BattleWave, __tostring = BattleWave.toString}

local function newBattleWave(battleId, logger)
    local resWave = ResBattleWaveMonster[battleId]
    if resWave == nil then
        return nil
    end
    local resBoss = ResBattleWaveBoss[battleId]
    local wave = setmetatable({resWave = resWave, resBoss = resBoss}, BattleWaveMt)
    wave.logger = logger:newLogger('BattleWave', wave)
    return wave, resWave.pos_type==1
end
return newBattleWave