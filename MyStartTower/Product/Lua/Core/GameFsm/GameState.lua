local EventConst = require("Core/EventConst")

local strClassName = "GameState"


---@class GameState
local GameState = Class(strClassName)

-- 构造函数。
-- sceneNo 空则不做场景跳转
function GameState:ctor(name, sceneNo)
    self.stateName = name 
    self.sceneNo = sceneNo
    self._slotLoadEnded = Slot(self.onLoadEnded, self)
end

function GameState:InternalEnter(lastStateName)

end

function GameState:InternalExit()

end








--------------------------------------------------------------------------------------------------------

function GameState:destroy()
    self.stateName = nil
end

function GameState:enter(preStateName, enterArgs)
    self.preStateName = preStateName
    self.enterArgs = enterArgs
    self:onEnter(preStateName)
end

function GameState:exit(tgtStateName)
    EventCenter.sendEvent(EventConst.GAME_STATE_EXIT, { self.stateName, tgtStateName})
    self:onExit(tgtStateName)
end

function GameState:onEnter(preStateName)
    -- 关闭云加载逻辑
    if self.sceneNo then
        EventManager.Global.Dispatch(EventType.SceneMgrChangeScene, self.sceneNo, false, true, function()
            self:onLoadEnded()
        end)

        -- 这里不应该有计时
        -- 登录时客户端接收初始数据完毕，现在没有这个标记，所以这里加一个计时器硬解，等找个时间跟服务器协商把这里优化掉
        if self._timer then
            LuaCallCs.LogError("---   GameState 计时器数据异常，GameState:onEnter事件接收了多次...")
        else
            self._timer = Util.Timer.AddTimer(1,function() self:_clearTimer() end)
        end

    end
    --CueManager.clearAllCue()
end


function GameState:_clearTimer()
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.SceneLogicProgress, 1)
    self._timer = nil
end



-- 场景load后并且loading马上就要消失
function GameState:onLoadEnded()

end

function GameState:onExit(tgtStateName)
    -- body
end








return GameState


