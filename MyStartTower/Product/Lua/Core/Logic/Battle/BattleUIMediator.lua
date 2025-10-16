-- for BattleActorMgr
local BattleUIMediator = {}

function BattleUIMediator.mainUI()
    --if BattleConst.DebugUseOldFightingUI then
    --    --UIManager.getUI(mainDlgName):initConfig()
    --else
    --    UIManager.getUI(UIName.UIFighting, true, true)
    --    Blackboard.UIEvent.SendMessage(UIName.UIFighting, UIEventID.UIFighting_SetData)
    --end
    UIManager.InterfaceOpenUI(UIName.UIFighting)
    Blackboard.UIEvent.SendMessage(UIName.UIFighting, UIEventID.UIFighting_SetData)
    EventManager.Global.Dispatch(EventType.SkillCutInStandby, true) -- 技能切入待机状态
end

--function BattleUIMediator.recordUI()
--    UIManager.getUI("battleRecordDlg", true):onShow()
--end

function BattleUIMediator.skillShortUI(showId,isPlayer)
end

return BattleUIMediator