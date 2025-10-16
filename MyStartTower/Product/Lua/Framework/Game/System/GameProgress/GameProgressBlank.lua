


---@class GameProgressBlank : GameProgressBase
GameProgressBlank = Class("GameProgressBlank", GameProgressBase)

function GameProgressBlank:OnInit()

end

function GameProgressBlank:OnClear()

end

function GameProgressBlank:OnEnter(lastProgress)
    UIManager.InterfaceCloseAll()

    Game.GameProgressStart()

    SimpleLoginTool.RequestServerList()
end

function GameProgressBlank:OnExit()

end
