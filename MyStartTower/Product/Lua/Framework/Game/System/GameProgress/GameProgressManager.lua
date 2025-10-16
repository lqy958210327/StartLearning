

-- 注意：这不是状态机，只是一个进度管理器，不要认为这就是状态机
-- 备注：因为不是状态机，所以流程之间的切换没有限制
-- 不做状态机的主要原因是：状态机是自主运行的，需要一直Tick，在lua里这么写太浪费

-- 流程规划：正常流程如下
-- 0. 游戏启动后，走热更流程，热更过程中lua没启动，所以这里没有热更部分
-- 1. 热更完成后，进入SDK进程
-- 2. SDK进程走完进入Blank进程
-- 3. Blank等待用户输入登录游戏，进入Login进程
-- 4. Login进程走完进入Main进程
-- 5. Main流程可以进入Battle进程
-- 6. Main流程可以进入Ods进程
-- 7. 收到登出操作进入logout流程



---@class GameProgressManager : SystemBase
GameProgressManager = Class("GameProgressManager", SystemBase)

function GameProgressManager:OnInit()
    ---@type table<number, GameProgressBase>
    self._progressDict = {}
    self._curProgress = nil
    self:_addProgress(GameProgressID.SDK   , GameProgressSDK())
    self:_addProgress(GameProgressID.Blank , GameProgressBlank())
    self:_addProgress(GameProgressID.Login , GameProgressLogin())
    self:_addProgress(GameProgressID.Main  , GameProgressMain())
    self:_addProgress(GameProgressID.Battle, GameProgressBattle())
    self:_addProgress(GameProgressID.Logout, GameProgressLogout())

    self._evtSetProgress = function(id, ...) self:SetProgress(id, ...) end
    self._evtSetParam = function(id, value) self:SetParam(id, value) end
    EventManager.Global.RegisterEvent(EventType.GameProgressChange, self._evtSetProgress)
end

function GameProgressManager:OnClear()
    for _, progress in pairs(self._progressDict) do
        progress:InternalClear()
    end
    self._progressDict = nil
    self._curProgress = nil

    EventManager.Global.UnRegisterEvent(EventType.GameProgressChange, self._evtSetProgress)
end

---@param id number
---@param progress GameProgressBase
function GameProgressManager:_addProgress(id, progress)
    progress:InternalInit()
    self._progressDict[id] = progress
end

function GameProgressManager:SetProgress(id, ...)
    assert(type(id) == "number", "---   切换游戏进程错误: GameProgressID必须是number")
    assert(self._progressDict[id], "---    切换游戏进程错误: 没有这个GameProgress, id = "..id)

    if self._curProgress then
        self._progressDict[self._curProgress]:InternalExit()
    end

    self._curProgress = id
    local progress = self._progressDict[id]
    progress:InternalEnter(self._curProgress, ...)

end

function GameProgressManager:SetParam(paramId, value)
    assert(type(paramId) == "number", "---    设置游戏进程参数错误: 参数ID必须是number")
    assert(type(value) == "number" or type(value) == "string" or type(value) == "boolean", "---   设置游戏进程参数错误: 参数值必须是number, string, boolean")

end
