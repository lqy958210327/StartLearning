


--备注：这个功能虽然起名叫状态机，但实际上不是状态机，只是参考状态机的设计模式划分了几个大类
-- 优化第一步：这个fsm功能结合的太深了，短时间内很难改，先用过度方式把接口收拢，把各个State里的接口和数据封闭
-- 优化第二步：之后有时间的话再设计一个状态机系统，然后把这套fsm用状态机系统重写一遍



local NetService = require("Core/Network/NetService")

local GameFsm = {}
local self = GameFsm

function GameFsm.ctor()
    require "Core/GameFsm/GameStateLogin"
    local GameStateBattle = require "Core/GameFsm/GameStateBattle"
    require "Core/GameFsm/GameStateMain"
    local Fsm = require("Core/GameFsm/Fsm")

    self._fsm = Fsm()
    self._fsm:addState(GameStateLogin(Const.STATE_LOGIN))
    self._fsm:addState(GameStateMain(Const.STATE_MAIN))
    self._fsm:addState(GameStateBattle(Const.STATE_BATTLE))
end


-- 过渡期接口
function GameFsm.InterfaceIsInState(stateName)  -- 是否在某一个大状态里
    return GameFsm.isInState(stateName)
end
function GameFsm.InterfaceTranslateState(stateName, enterArgs) -- 强制切换到一个大状态里
    GameFsm.translateState(stateName, enterArgs)
end
function GameFsm.InterfaceLogout(code)
    EventManager.Global.Dispatch(EventType.GameProgressChange, GameProgressID.Logout, code)
end
function GameFsm.InterfaceGetState(stateName)  -- 返回State的类
    return GameFsm.getState(stateName)
end
-- 过渡期接口


-----------------------------------------------------------------------------------------------------

function GameFsm.translateState(tgtStateName, enterArgs)
    local curState = self.getState()
    --大状态切换
    if self._fsm.mStates[tgtStateName] then
        --离开当前状态的子状态
        if curState and curState.fsm then
            curState.fsm:translateState(nil)
        end
        self._fsm:translateState(tgtStateName, enterArgs)
        collectgarbage("collect")
    end
end

-- 获得当前的大状态  登录  主状态 战斗状态
function GameFsm.getState(tgtStateName)
    local state=self._fsm:getState(tgtStateName)
    if state then
        return state
    end
end

function GameFsm.isInState(tgtStateName)
    if self._fsm.mStates[tgtStateName] then
        return self._fsm.mCurStateName == tgtStateName
    else
        local curState = self.getState()
        if curState and curState.fsm then
            return curState.fsm.mCurStateName == tgtStateName
        else
            return false
        end
    end
end

function GameFsm.getCurState()
    return self.getState()
end

-- 初始化链接时根据信息决定状态跳转问题
function GameFsm.onReady(enter_game,time_zone)
    ClientUtils.SetServerDiffTime(time_zone)

    -- 同步服务器时间
    TimeUtils.onSetServerTime(enter_game.time, true)

    NetService.clearReconnectFlag( )
end

function GameFsm.destroy()
    -- 切换到空状态,使当前状态触发退出回调,实现状态清理逻辑
    self._fsm:translateState(nil)
    collectgarbage("collect")
    -- 断开网络连接
    NetService.stopReconnect()
    NetService.disconnect()
end

function GameFsm.isBattleState(state)
    return state == Const.STATE_BATTLE
end

return GameFsm
