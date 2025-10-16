


---@class GameProgressLogin : GameProgressBase
GameProgressLogin = Class("GameProgressLogin", GameProgressBase)

function GameProgressLogin:OnInit()

end

function GameProgressLogin:OnClear()
    if self._evtId then
        Blackboard.RemoveListenBBItemTable(BbKey.Global, BbItemKey.LoginState, self._evtId)
        self._evtId = nil
    end
end

function GameProgressLogin:OnEnter(lastProgress, username)
    self._evtId = Blackboard.ListenBBItemTable(BbKey.Global, BbItemKey.LoginState, function(data) self:_onLoginStateChange(data) end)
    SimpleLoginTool.EnterGame(username)
end

function GameProgressLogin:OnExit()
     Blackboard.RemoveListenBBItemTable(BbKey.Global, BbItemKey.LoginState, self._evtId)
end

---@param data BBClassLoginState
function GameProgressLogin:_onLoginStateChange(data)
    if data.State == 0 then
        -- 登录中...
        EventManager.Global.Dispatch(EventType.SceneMgrChangeScene, 30000, true, true, function()
            EventManager.Global.Dispatch(EventType.GameProgressChange, GameProgressID.Main)
        end)
    elseif data.State == 1 then
        print("---   BBItemLoginState切换：登录成功")
        Blackboard.WriteBBItemNumber(BbKey.Global,BbItemKey.SceneLogicProgress, 1)
    elseif data.State == 2 then
        local str = "登录失败，未知原因...   code:"..data.OptCode
        if data.OptCode == 1 then
            str = "登录失败，你被封号了..."
        elseif data.OptCode == 2 then
            str = "登录失败，你的账号被删了..."
        end
        print("---   "..str)
        Util.MsgBox.OpenShowInfo(str)
        EventManager.Global.Dispatch(EventType.GameProgressChange, GameProgressID.Blank)
    end
end
