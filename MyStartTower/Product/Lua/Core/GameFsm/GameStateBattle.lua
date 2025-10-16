local GameState = require("Core/GameFsm/GameState")
local FrameMgr = require "Core/Debug/Modules/Demo/DemoFrameMgr"
local TheMatrixClass = require "Core/Common/FrameBattle/TheMatrix"
local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local BattleActorMgr = require "Core/Logic/Battle/BattleActorMgr"
local DragPlane = require "Core/UI/Control/Com/DragPlane"
local EventConst = require("Core/EventConst")
require "Core/Logic/Battle/FloatingWords"

local ResBattleConfig = DataTable.ResBattleConfig
local ResScene = DataTable.ResScene


local SceneTrans = require("Core/GameFsm/SceneTrans")

local listenerFuncConfig = {
        ['onMatrixOver'] = BattleConst.MATRIX_EVENT_BATTLE_OVER,
    }

local strClassName = "GameStateBattle"


---@class GameStateBattle : GameState
local GameStateBattle = Class(strClassName, GameState)







function GameStateBattle:showSceneObjects()
    -- 显示
    if self.preHideSceneObjects then
        for _, node in ipairs(self.preHideSceneObjects) do
            if node and not tolua.isnull(node) then
                node:SetActive(true)
            end
        end
        self.preHideSceneObjects = nil
    end
end
function GameStateBattle:initTagInfo()
    self.inPause = false
end

function GameStateBattle:onPause()
    self.inPause = true
    if self.frameMgr then
        self.frameMgr:pause()
    end
    if self.mActorMgr then
        self.mActorMgr:onPause()
    end
end

function GameStateBattle:onResume()
    self.inPause = false
    if self.frameMgr then
        self.frameMgr:resume()
    end
    if self.mActorMgr then
        self.mActorMgr:onResume()
    end
end






function GameStateBattle:ctor(name)
    self:_initData()
end

function GameStateBattle:_initData()


    self.slotOnRefreshShadow = Slot(self._onRefreshShadow, self)
end

function GameStateBattle:onEnter(preStateName)
    GameStateBattle.super.onEnter(self, preStateName)
    self.preStateName = preStateName
    EventCenter.addEventListenerGroup(self, listenerFuncConfig)
    -- SceneSettingsManager.EnableSceneVideos(-1, false)
end

function GameStateBattle:onExit(nextState)
    GameStateBattle.super.onExit(self, nextState)
    self:clearBattleComponents()
    self:showSceneObjects()
    CueManager.revertForceStopDof()
    AudioCueMediator.stopNoise()
    EventCenter.removeEventListenerGroup(self, listenerFuncConfig)
    UnityEngine.Time.timeScale = 1
    CueManager.setSfxSpeed( 1 )
    TouchManager.enabled(false)
    -- SceneSettingsManager.EnableSceneVideos(-1, true)
end

-- 初始化设置进入战场可能需要的数据  布阵后战斗才真正开始  下一步是等待状态完毕 onLoadEnded
function GameStateBattle:initPreBattleInfo(battleNo)
    self.battleNo = battleNo
    self.battleConfig = ResBattleConfig[self.battleNo] or {}
    self.isZombie = self.battleConfig.matrix_type == 2


    self:initTagInfo()--去StateBattleMixin里找方法
    self:_initBattleArgs()

    self:_initSceneNo()
end

function GameStateBattle:_initBattleArgs()
    UnityEngine.Time.timeScale = 1
    self:clearBattleComponents()
end

function GameStateBattle:_initSceneNo()

    self.sceneNo = self.battleConfig.sceneId or 1

    WarManager:Get():SetValueSceneID(self.sceneNo)

    ---@type table ： 配置表Scene
    self.sceneInfo = ResScene[self.sceneNo]

    ---@type SceneTrans ： Lua侧自定义脚本
    self.sceneTrans = SceneTrans(self.sceneNo)
    WarManager:Get():SetValueSceneTrans(self.sceneTrans)
end



-- 服务端回应 真正开始战斗的接口
-- battleType 房间类型
-- seed 随机种子
-- battleNo 战场ID
-- heros 英雄列表
-- speData 房间类型相关的配置
-- 进入状态之前需要配置战场相关信息 然后才能进入战斗状态

---@param battleServerInfo SC_BattleStart
function GameStateBattle:startFight(battleServerInfo)
    WarManager:Get():ClearLastRoundCache()
    local matrixInit = battleServerInfo.matrixInit
    local battleUid = matrixInit.battleId -- 战斗唯一ID，目前没啥用
    local battleCfgId = matrixInit.resId --战场配置ID
    local battleType = battleServerInfo.type -- 战斗类型字符串
    local randomSeed = matrixInit.randomSeed -- 随机种子




    DragPlane.onBattleStart()
    self.battleId = battleUid
    WarManager:Get():ResetBattleRound()
    WarManager:Get():CreateWinRuleResult()
    WarManager:Get():CacheServerData(matrixInit)

    local selfBuffList, selfPowerList, enemyBuffList, enemyPowerList = AnalyseServerBattleDataTool.AnalyseElemBuffListAndPowerListByMatrixInit(matrixInit)
    WarManager:Get():SetElementBuffListAndPowerList(selfBuffList, selfPowerList, enemyBuffList, enemyPowerList)

    self.randomSeed = randomSeed
    if battleCfgId ~= self.battleNo then
        LuaCallCsUtilCommon.ThrowException("---   数据异常：客户端与服务器战斗数据不匹配，无法开始战斗！BattleType = "..battleType.."   ClientBattleId = "..self.battleNo.."   ServerBattleId = "..battleCfgId)
    end

    self:_initConfig(matrixInit)
    self:hideSceneObjects()
    --LuaCallCsUtilCommon.SetUIRootNumActive(true)
    LuaCallCsUtilCommon.SetFloatingWordsDisplay(true)



end

function GameStateBattle:hideSceneObjects()
    -- 可能存在上次隐藏的物体
    -- 此处直接显示旧物体再隐藏新物体，尽管它们可能相同
    self:showSceneObjects()
    -- 隐藏
    if self.sceneInfo and self.sceneInfo.hide_go_name then
        self.preHideSceneObjects = {}
        for _, path in ipairs(self.sceneInfo.hide_go_name) do
            local node = UnityEngine.GameObject.Find(path)
            if node then
                table.insert(self.preHideSceneObjects, node)
                node:SetActive(false)
            end
        end
    end
end

function GameStateBattle:showNowTeamResult()        -- 显示当前这一场战斗的结果
    local round = WarManager:Get():GetCurBattleRound()
    local ruleResult = WarManager:Get():GetWinRuleResult()
    for i = 1, #ruleResult.MatrixResultList do
        local data = ruleResult.MatrixResultList[i]
        if data.Round == round then
            local isShow = FormationHelper.GetBattleConfigFightingIsShowStepResult(Util.BattleParam.GetBattleID())
            if isShow == 1 then
                UIManager.InterfaceOpenUI(UIName.UIBattleStepResult)
            else
                BattleProgressManager:Get():NextBattle()
            end
            break
        end
    end

end

function GameStateBattle:startFightNextTeam()       -- 开启下一队伍的战斗
    WarManager:Get():ClearLastRoundCache()
    --self.curBattleRound = self.curBattleRound + 1
    WarManager:Get():NextBattleRound()
    BattleProgressManager:Get():ShowBattleUI(true)
    --local curRound = WarManager:Get():GetCurBattleRound()

    --这是一套反人类的逻辑
    --战斗盒子初始化的时候要填充Entity，己方Entity是用self.heros这个字段初始化的，self.heros这个字段是用服务器的数据解析出来的
    --第一个奇葩逻辑：self.heros这个字段在收到服务器协议的时候就设置了一次，往战斗盒子里填数据的时候又设置了一次
    --第二个奇葩逻辑：开启下一队战斗的时候，self.heros这个字段设置了两次，第一次设置取缓存，第二次设置不生效，所以self.heros这个字段的值是正确的，功能可以正常用
    --
    --LuaCallCsUtilCommon.SetUIRootNumActive(true)
    LuaCallCsUtilCommon.SetFloatingWordsDisplay(true)
    --LuaCallCsUtilCommon.SetFloatingWordsActive(true)
    local matrixInit = WarManager:Get():GetServerDataMatrixInit()
    self:_initConfig(matrixInit)

end





function GameStateBattle:onLoadEnded()
    -- log("RECONNECT .onLoadEnded")
    GameStateBattle.super.onLoadEnded(self)
    self:startBattleFormation()
end






-- 场景加载完毕  创建需求的战场中心点
-- 第一步:   判断并播放AVG(主城场景AVG)  否则进入第二步stepEnterCamera
function GameStateBattle:startBattleFormation()
    BattleProgressManager:Get():EnterBegin()

    --老代码
    self.sceneTrans:newCameraBattleEndLookAtPos()
    self.sceneTrans:setBattleStartOffset(0)       -- 迷宫战斗进入战场会顺切  此时需要初始化修改Center相关的坐标，防止布阵错乱
    self:_applyCustomLight(-1)  -- 新增逻辑：设置为布阵光照
    --老代码
end

function GameStateBattle:clear()
    if self.mActorMgr then
        self.mActorMgr:destroy()
        self.mActorMgr = nil
    end
end


function GameStateBattle:_initConfig(matrixInit)
    ---------创建Matrix---------------------------------
    self:clear()

    local curRound = WarManager:Get():GetCurBattleRound()
    local inputParam = {matrixInit = matrixInit, round = curRound}
    self.mMatrixInstance = TheMatrixClass(inputParam)
    self.mActorMgr = BattleActorMgr(self, self.mMatrixInstance)

    if self.startTimer then
        LuaCallCs.LogError("---   GameStateBattle 计时器数据异常，_initConfig 调用了多次...")
    else
        self.startTimer = Util.Timer.AddTimer(1, function()
            self.startTimer = nil
            self:startGame()
        end)
    end
end



-- 启动黑盒
function GameStateBattle:startGame()

    -- 清理布阵资源
    DragPlane.stop()

    -- 启动黑盒
    print("---   启动战斗盒子...")
    self.frameMgr = FrameMgr(self.mMatrixInstance)
    WarManager:Get():SetFrameManager(self.frameMgr)
    self.frameMgr:start()

    -- 初始化数据(需要依赖盒子里的数据，所以要在盒子启动后再初始化)
    WarManager:Get():SetUniqueBoss()
    WarManager:Get():SetMonsterMixture()
    WarManager:Get():SetMonsterQueue()
    WarManager:Get():SetFightingDB()

    -- UI表现
    UIManager.InterfaceCloseUI(UIName.UIBattleStartEffect)
    BattleUIMediator.mainUI()

    ---- 清理布阵资源
    --DragPlane.stop()

    -- 老代码，模型开始战斗
    for id, actor in pairs(self.mActorMgr.actors) do
        EntityCmd.BattleActor.ShowModel(id)
    end
    if self.inPause then
        Util.Battle.BattlePause(true)
    end

    BattleModelManager.CleanCache()
end





function GameStateBattle:clearBattleComponents()

    self:clear()

    CueManager.stopPostOutline()


    DragPlane.stop()

    self:stopCoFinish()
    if self.startTimer then
        Util.Timer.BreakTimer(self.startTimer)
        self.startTimer = nil
    end
    if self.sceneTrans then
        self.sceneTrans:destroyCenterPointGo()
        self.sceneTrans:destroyCameraCenterPointGo()
    end
    if self.battleConfig and self.battleConfig.battle_cue then
        CueManager.releaseCue(nil, self.battleConfig.battle_cue)
    end
    CueManager.clearAllCue()
    -- Framework.UI.UIUtils.ClearAllBattleNumber()
end









function GameStateBattle:initDragPlaneObjects()

    DragPlane.start(self.sceneTrans.centerPointGo, self.battleConfig.player_enter_state, self.battleConfig)



end





---------------------------------------- 战斗结算协程规则---------------------------------------------------
-- 战斗结束统一通知入口
function GameStateBattle:onMatrixOver(entId, battleId, battleResult)
    print("---   战斗盒子抛出事件，战斗结束...")
    -- entId 没用
    -- battleId 是战斗盒子里的唯一ID，客户端不用

    -- 计算战斗结果，前后端相同
    local curRound = WarManager:Get():GetCurBattleRound()
    local data = MatrixResultData(curRound, battleResult)
    local ruleResult = WarManager:Get():GetWinRuleResult()
    ruleResult:AddMatrixResult(data)
    local resId = Util.BattleParam.GetBattleID()
    local teamCount = FormationHelper.GetBattleConfigTeamCount(resId)
    WinRule.CalculateResult(ruleResult, WarManager:Get():GetBattleConfig().win_type, teamCount)
    -- 计算战斗结果

    self.win = (data.ResultType == BattleConst.BATTLE_RESULT_WIN) and 1 or 0

    --LuaCallCsUtilCommon.SetUIRootNumActive(false)
    LuaCallCsUtilCommon.SetFloatingWordsDisplay(false)
    EventManager.Global.Dispatch(EventType.SkillCutInStandby, false)
    BattleProgressManager:Get():OpenBattleDamageEffectUI(false)
    BattleProgressManager:Get():OpenBattleHealEffectUI(false)
    BattleProgressManager:Get():ShowBattleUI(false)
    EntityCmd.HUD.ShowAll(false)

    self:startBattleOverAction(data.DetailResultType, ruleResult.IsEnd)

    if ruleResult.IsEnd then
        UnityEngine.Time.timeScale = BattleConst.BATTLE_SHOW_TIME_SCALE
        local during = BattleConst.BATTLE_FINISH_TIME
        Util.Timer.AddTimer(during, function()
            UnityEngine.Time.timeScale = 1.0
            local isSendMsg = (data.DetailResultType ~= BattleConst.BATTLE_RESULT_LEAVE) or ((data.DetailResultType == BattleConst.BATTLE_RESULT_LEAVE and WarManager:Get():GetBattleConfig().is_leave_show_ui == 1))
            if isSendMsg then
                -- 发消息
                local msg = GenerateServerBattleDataTool.GenerateResultData(battleId, ruleResult)
                RPC.pVEFinishNew(msg)
            else
                Util.BattleExitJump.ExitBattle()
            end
        end)
    end
end





function GameStateBattle:startBattleOverAction(speResultType, realEnd)
    --self.noShowResult = nil
    self:stopCoFinish()
    --self:checkRecordWatchCamera()

    if not realEnd then
        self.coFinish = coroutine.start(self.coBattleFinish, self, true)
        return
    end
    UnityEngine.Time.timeScale = 1.0


    if not speResultType or speResultType == BattleConst.BATTLE_RESULT_TIME_OUT then       -- 正常结算 需要表现各种动作
        self.coFinish = coroutine.start(self.coBattleFinish, self)
    else
        if self.frameMgr then
            self.frameMgr:pause()
        end
    end
end

function GameStateBattle:stopCoFinish()
    if self.coFinish then
        coroutine.stop(self.coFinish)
        self.coFinish = nil
    end
end

function GameStateBattle:stopCoQuickBattle()
    if self.coQuickBattle then
        coroutine.stop(self.coQuickBattle)
        self.coQuickBattle = nil
    end
end

function GameStateBattle:coBattleFinish(hasNext)
    --UIManager.tryHideUI(UIName.UIFighting) --关闭UIFighting界面。
    UnityEngine.Time.timeScale = BattleConst.BATTLE_SHOW_TIME_SCALE
    coroutine.wait(BattleConst.BATTLE_FINISH_TIME)
    UnityEngine.Time.timeScale = 1.0
    CueManager.setSfxSpeed(1)
    if hasNext then
        --CameraManager.SwitchToNode(0.3, 0)
        --self:showNowTeamResult()
        BattleProgressManager:Get():StepResult()
        return
    end



end




-- 接收到服务器的结果
function GameStateBattle:onBattleResult(battleType, battleId, isWin, details)
    UnityEngine.Time.timeScale = 1.0
    CueManager.setSfxSpeed( 1 )
    BattleProgressManager:Get():EnterResult()
end

function GameStateBattle:speBattleFinish()

end










function GameStateBattle:hideAllActors(  )
    if self.mActorMgr then
        self.mActorMgr:destroy()
    end
end













function GameStateBattle:exitBattle(needCheckAVG)
    self:_revertCustomLight()
    self:clearBattleComponents()
    self:_setCustomShadowActive(false)
    self:onExitBattle()


end

function GameStateBattle:onExitBattle()
    BattleProgressManager:Get():EnterClear()
    WarManager:Get():LeaveBattle()
    BattleManager.enterMain()
    --CameraManager.CameraGrp:BlurEnd()
end






-- override


-- 获得回放数据




-- 自定义阴影
function GameStateBattle:_setCustomShadowActive(active, registerEvent)
    if nil == registerEvent then
        registerEvent = true
    end
    if active then
        CustomShadowManager.setBattleShadowActive(true, self.sceneTrans:getShadowCenterAndRadius(self))
        if registerEvent then
            EventCenter.addEventListener(EventConst.REFRESH_SHADOW, self.slotOnRefreshShadow)
        end
    else
        if registerEvent then
            EventCenter.removeEventListener(EventConst.REFRESH_SHADOW, self.slotOnRefreshShadow)
        end
        CustomShadowManager.setBattleShadowActive(false)
    end
end

function GameStateBattle:_onRefreshShadow()
    self:_setCustomShadowActive(true, false)
end

function GameStateBattle:_applyCustomLight(extraLightIndex,duration)
    SceneLightManager.ApplySceneLight(Const.SCENE_LIGHT[extraLightIndex],duration or 0)
    CueManager.applySceneImageEffects(Const.SCENE_PPB[extraLightIndex])
    self.inCustomLighting = true
end
function GameStateBattle:_revertCustomLight(duration)
    if not self.inCustomLighting then
        return
    end
    SceneLightManager.ApplySceneLight(Const.SCENE_LIGHT_DEFAULT,duration or 0)
    CueManager.applySceneImageEffects(Const.SCENE_PPB_DEFAULT)

    self.inCustomLighting = nil
end


---------------------------------------- UI控制逻辑 ---------------------------------------------------
-- 退出战斗
function GameStateBattle:onLeaveBattle()
    --self:onRaiseMatrixInput(BattleConst.INPUT_EVENT_LEAVE, 1)
    WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 0)
end

-- 重新尝试







return GameStateBattle

