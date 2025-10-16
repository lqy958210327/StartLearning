


local TheMatrixClass = require "Core/Common/FrameBattle/TheMatrix"
local FrameMgr = require "Core/Debug/Modules/Demo/ServerFrameMgr"
local MAX_FRAME = 36000
local MatrixResultToBattleResult = function(type)
    if type == BattleConst.BATTLE_OVER_WIN then
        return BattleConst.BATTLE_RESULT_WIN
    elseif type == BattleConst.BATTLE_OVER_LOSE then
        return BattleConst.BATTLE_RESULT_LOSE
    elseif type == BattleConst.BATTLE_OVER_TIME_OUT then
        return BattleConst.BATTLE_RESULT_TIME_OUT
    elseif type == BattleConst.BATTLE_OVER_LEAVE then
        return BattleConst.BATTLE_RESULT_LOSE
    end
    return nil
end

local ImmediateServerBattle = {}
function ImmediateServerBattle:StartBattle(start_data, client_operate)
    local cfg = DataTable.ResBattleConfig[start_data.start_common.base.pve_id]
    if cfg == nil then
        print("---   Error:数据异常，战场配置数据空")
    end

    local input = MatrixInput()
    input:InitByServerData(start_data)

    local output = WinRuleResult()

    local teamCount = cfg.show_team_num --战场配置
    for i = 1, teamCount do
        local round = i
        local param = input:GenerateInputParam(round)
        local opt = (client_operate and client_operate[round]) and client_operate[round] or nil
        local matrix = TheMatrixClass(param)
        local frameMgr = FrameMgr(matrix)
        if opt then
            for _, frameInfo in ipairs(opt.framedata) do
                local frameNum = frameInfo.frameid
                frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
            end
        end

        -- 运行战斗盒子
        for m = 1, MAX_FRAME do
            if matrix.battleOver then
                break
            else
                frameMgr:nextFrame()
            end
        end


        --统计战斗盒子的战斗结果
        local resultType = MatrixResultToBattleResult(matrix.battleOver)
        local data = MatrixResultData(round, resultType, matrix.lastDeadCamp, matrix)
        output:AddMatrixResult(data)

        -- 战斗结算机制，演算战斗结果
        local formationCfg = DataTable.ResFormation[cfg.formation_id]
        WinRule.CalculateResult(output, cfg.win_type, formationCfg.teamCount)

        if output.IsEnd then
            -- 战斗结果提前计算完成
            break
        end
    end


    -- 构建战斗结算数据
    local msg = GenerateServerBattleDataTool.GenerateResultData(start_data.battle_id, output)

    -- 返回结算数据，服务器做验证
    local msg, resultType = endData:GenerateResult(input)
    return msg, resultType
end

return ImmediateServerBattle

--local BattleConst = require "Core/Common/FrameBattle/BattleConst"
--local PVPCommon=require("Core/Logic/PVP/PVPCommon")
--local StateBattleMixin = require 'Core/Logic/Battle/StateBattleMixin'
--if StateBattleMixin then
--    MixinClass(ImmediateServerBattle, StateBattleMixin)
--end

--function ImmediateServerBattle:startServerBattle(start_data, client_operate)
--
--    -- local filters = {"xpcall", "(for generator)", "ipairs", "print", "ilist", "__index", "ilist", "pairs", "__newindex", "band",
--    --                   "lshift", "decode", "default_table", "decode_message", "_decodeAllSubTable", "bit_xor", "normalize", "GetInstance", "class", "Event",
--    --                   "create", "create", "createObj", "bit_and", "ctor", "getPosition", "func", "Sub", "rawget", "_copy",
--    --                   "type", "tostring", "math_floor", "sub", "insert", "getSkill", "gsub", "dumpTab", "getCurState", "trycall",
--    --                   "sendEvent", "f"}
--    -- local ProfileFilterStr = ""
--    -- for index, fil in pairs(filters) do
--    --     ProfileFilterStr = ProfileFilterStr..fil.."|"
--    -- end
--
--    -- local profiler = require("Core/profiler")
--    -- profiler.start("profiler_%s.out", ProfileFilterStr)
--    -- local LuaHooker = require("Core/Debug/LuaFrameProfiler")
--    -- LuaHooker:start()
--    self.battleId = start_data.battle_id
--    self.battleServerInfo = start_data
--    PlayerUtils.checkRobotPlayerBattleInfo( start_data )
--    local battleInitInfo = ActorUtils.getBattleInitInfo(start_data)
--    self.battleNo = battleInitInfo.battleNo
--    self.randomSeed = battleInitInfo.seed or 0
--    self.battleType = battleInitInfo.battleType
--    self.speData = battleInitInfo.speData
--    if self.battleType == BattleConst.BATTLE_TYPE_MULTI_PVP  then
--        self.battleTeamResult = {}
--        self.battleTeamHeros = battleInitInfo.multiTeamHeros
--        self.battleTeamPets = battleInitInfo.multiTeamPets
--        for round = 1, 3 do
--            self.curBattleRound = round
--            self.heros = self.battleTeamHeros[round] or {}
--            self.pets = self.battleTeamPets[round] or {}
--            self:_initConfig()
--            local oplist = client_operate and client_operate[round] and client_operate[round].framedata or nil
--            if oplist then
--                for _, frameInfo in ipairs(oplist) do
--                    local frameNum = frameInfo.frameid or 0
--                    self.frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
--                end
--            end
--
--            local r = self:Run()
--            self.win = 0
--            local result = BattleConst.BATTLE_RESULT_WIN
--            if self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_WIN then
--                result = BattleConst.BATTLE_RESULT_WIN
--                self.win = 1
--            elseif self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_LOSE then
--                result = BattleConst.BATTLE_RESULT_LOSE
--            elseif self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_TIME_OUT then
--                result = BattleConst.BATTLE_RESULT_TIME_OUT
--            elseif self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_LEAVE then
--                result = BattleConst.BATTLE_RESULT_LOSE
--            end
--            self.battleTeamResult[self.curBattleRound] = {result, self.mMatrixInstance.bObjMgr, self:getServerReplayData()}
--            if self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_LEAVE then
--                return BattleConst.BATTLE_RESULT_LOSE
--            end
--            local winNum = 0
--            local loseNum = 0
--            for roundNum, resultInfo in pairs(self.battleTeamResult) do
--                if resultInfo[1] == BattleConst.BATTLE_RESULT_WIN then
--                    winNum = winNum + 1
--                else
--                    loseNum = loseNum + 1
--                end
--            end
--            if winNum >= 2 then
--                return BattleConst.BATTLE_RESULT_WIN
--            elseif loseNum >= 2 then
--                return BattleConst.BATTLE_RESULT_LOSE
--            end
--        end
--    else
--        self.curBattleRound = 1
--        self.heros = battleInitInfo.heros or {}
--        self.pets = battleInitInfo.pets or {}
--        self:_initConfig()
--        local oplist = client_operate and client_operate[1] and client_operate[1].framedata or nil
--        if oplist then
--            for _, frameInfo in ipairs(oplist) do
--                local frameNum = frameInfo.frameid or 0
--                self.frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
--            end
--        end
--
--        local r = self:Run()
--        self.win = 0
--        local result = BattleConst.BATTLE_RESULT_WIN
--        if self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_WIN then
--            result = BattleConst.BATTLE_RESULT_WIN
--            self.win = 1
--        elseif self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_LOSE then
--            result = BattleConst.BATTLE_RESULT_LOSE
--        elseif self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_TIME_OUT then
--            result = BattleConst.BATTLE_RESULT_TIME_OUT
--        elseif self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_LEAVE then
--            result = BattleConst.BATTLE_RESULT_LOSE
--        end
--        return result
--    end
--end


--function ImmediateServerBattle:startServerBattleByResult(start_data, client_operate)
--    self.battleId = start_data.battle_id
--    PlayerUtils.checkRobotPlayerBattleInfo( start_data )
--    local battleInitInfo = ActorUtils.getBattleInitInfo(start_data)
--    self.battleNo = battleInitInfo.battleNo
--    self.randomSeed = battleInitInfo.seed
--    self.battleType = battleInitInfo.battleType
--    self.speData = battleInitInfo.speData
--    if self.battleType == BattleConst.BATTLE_TYPE_MULTI_PVP   then
--        self.battleTeamResult = {}
--        self.battleTeamHeros = battleInitInfo.multiTeamHeros
--        for round = 1, 3 do
--            self.heros = self.battleTeamHeros[round]
--            self:_initConfig()
--            if client_operate and client_operate[round] and client_operate[round].framedata then
--                for _, frameInfo in ipairs(client_operate[round].framedata) do
--                    local frameNum = frameInfo.frameid
--                    self.frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
--                end
--            end
--            local result = self:Run()
--            self.battleTeamResult[self.curBattleRound] = {result, self.mMatrixInstance.bObjMgr, self:getServerReplayData()}
--            local winNum = 0
--            local loseNum = 0
--            for roundNum, resultInfo in pairs(self.battleTeamResult) do
--                if resultInfo[1] == 0 then
--                    winNum = winNum + 1
--                else
--                    loseNum = loseNum + 1
--                end
--            end
--            if winNum >= 2 then
--                return self:getBattleResult(0, self.battleTeamResult)
--            elseif loseNum >= 2 then
--                return self:getBattleResult(1, self.battleTeamResult)
--            end
--        end
--    else
--        self.heros = battleInitInfo.heros
--        self:_initConfig()
--        if client_operate and client_operate[1] and client_operate[1].framedata then
--            for _, frameInfo in ipairs(client_operate[1].framedata) do
--                local frameNum = frameInfo.frameid
--                self.frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
--            end
--        end
--        return self:getBattleResult(self:Run())
--    end
--end

--function ImmediateServerBattle:getBattleResult(lose, battleTeamResult)
--    local result = {}
--    result.win = 0
--    if self.mMatrixInstance then
--        if lose == 0 then
--            result.win = 1
--        end
--        result.frame = self.mMatrixInstance.battleRealPassedFrame
--        result.battle_time = self.mMatrixInstance.bObjMgr:getBattleTime()
--        result.damage = math.floor(self.mMatrixInstance.bObjMgr:getBattleDamage())
--        result.monster_losehp = math.floor(self.mMatrixInstance.bObjMgr:getMonsterLoseHp())
--        local campData = {}
--        campData.team = self.mMatrixInstance.bObjMgr:getDamageResultInfo()
--        result.camp_data = campData
--        local _, _, bitNum = self.mMatrixInstance.bObjMgr.targetManager:getBattleTargetState()
--        result.cond_bit = bitNum
--        result.suppres = self.mMatrixInstance.bObjMgr.suppressLevel
--        if battleTeamResult then
--            local bitNum = 0
--            local base = 1
--            for roundNum, winResult in ipairs(battleTeamResult) do
--                if winResult == 0 then
--                    bitNum = bitNum + base
--                end
--                base = base * 2
--            end
--            result.round_bit = bitNum
--            result.round_cnt = #battleTeamResult
--        end
--    end
--    local buff = protobuf.encode("datap.ReplayResult", result)
--    return buff
--end

--function ImmediateServerBattle:_initConfig( )
--    self:clear()
--    self:initObjInfo()
--    local input = self:getMatrixInput()
--    --local input = BattleParamTools.ServerToMatrixInput()
--    self.mMatrixInstance = TheMatrixClass(input)
--    self.frameMgr = FrameMgr(self.mMatrixInstance)
--end


--function ImmediateServerBattle:Run()
--    for i =1, MAX_FRAME do
--        if self.mMatrixInstance.battleOver then
--            break
--        else
--            self.frameMgr:nextFrame()
--        end
--    end
--    if self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_WIN then
--        return 0        -- 胜利
--    else
--        return 1        -- 失败
--    end
--end

