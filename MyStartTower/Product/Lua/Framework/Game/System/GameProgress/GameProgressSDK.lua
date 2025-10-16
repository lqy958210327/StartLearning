


---@class GameProgressSDK : GameProgressBase
GameProgressSDK = Class("GameProgressSDK", GameProgressBase)

function GameProgressSDK:OnInit()

end

function GameProgressSDK:OnClear()

end

function GameProgressSDK:OnEnter(lastProgress)
    if true then
        -- 如果没有SDK，就直接进入blank，等待用户输入
        EventManager.Global.Dispatch(EventType.GameProgressChange, GameProgressID.Blank)
    else
        -- 走SDK流程，流程走完后切换blank
    end
end

function GameProgressSDK:OnExit()

end
