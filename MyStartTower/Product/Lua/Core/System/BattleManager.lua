local BattleManager = {}
BattleManager.CurrentScene = GameProgressID.Main--进入战斗之前的所在状态
function BattleManager.enterMain()
    --TODO:LOG:走测试流程 STATE_MAIN-->STATE_DEMO_MAIN

    EventManager.Global.Dispatch(EventType.GameProgressChange, BattleManager.CurrentScene)
end

function BattleManager.enterDemo(demoNo,robotDemoNo)


end


return BattleManager
