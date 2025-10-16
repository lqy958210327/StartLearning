



---@class GameProgressMain : GameProgressBase
GameProgressMain = Class("GameProgressMain", GameProgressBase)

function GameProgressMain:OnInit()

end

function GameProgressMain:OnClear()

end

function GameProgressMain:OnEnter(lastProgress)
    GameFsm.InterfaceTranslateState(Const.STATE_MAIN)

    ---创建角色 取名
    local isCreatName = Blackboard.ReadBBItemBool(BbKey.Global, BbItemKey.PlayerIsCreatName)

 

    if isCreatName then
        EventManager.Global.Dispatch(EventType.PlotShow, 2001, function(...)
            LuaCallCs.PlayerPrefs.SetInt("asdfasdfasdfasdf", 1)
            UIManager.getUI("UIMap",true)
        end)
    end
    self:_dumpUI()
end

function GameProgressMain:OnExit()

end

function GameProgressMain:_dumpUI()
    UIManager.InterfaceOpenUI(UIName.UIMain)

    local toMain = Blackboard.ReadBBItemString(BbKey.Global, BbItemKey.BattleEndToMainType)
    local toStronger = Blackboard.ReadBBItemNumber(BbKey.Global, BbItemKey.BattleEndToStrongerType)
    Blackboard.WriteBBItemString(BbKey.Global, BbItemKey.BattleEndToMainType, 0)
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleEndToStrongerType, 0)

    if toStronger == BattleStateToMainStateJumpType.toStrongerHero then
        UIJump.ToOpenUIHero()
    elseif toStronger == BattleStateToMainStateJumpType.toStrongerEquip then
        UIJump.ToOpenUIHero(nil, UIHeroMenuBarEnum.Equip)
    elseif toStronger == BattleStateToMainStateJumpType.toStrongerFormation then
        print("---   这里功能与重新挑战相同...")
    elseif toMain == BattleStateToMainStateJumpType.toMain then

    elseif toMain == BattleStateToMainStateJumpType.toBossTower then
        ---@type BBClassBattleSpecialParam
        local param = Blackboard.ReadBBItemString(BbKey.Global, BbItemKey.BattleSpecialParam)
        UIManager.InterfaceOpenUI(UIName.UIAbyssalMystery)
        UIManager.getUI(UIName.UIWarpSpace, true):into(param.BossTowerType)
    elseif toMain == BattleStateToMainStateJumpType.toMaze then
        UIManager.InterfaceOpenUI(UIName.UIAbyssalMystery)
        UIManager.InterfaceOpenUI(UIName.UIStageDungeon)
        UIManager.InterfaceOpenUI(UIName.UIStageDungeonMain)
    elseif toMain == BattleStateToMainStateJumpType.toPvp then
        UIManager.InterfaceOpenUI(UIName.UIAbyssalMystery)
        UIManager.InterfaceOpenUI(UIName.UIStageArenaMain)
        UIManager.InterfaceOpenUI(UIName.UIStageArenaRankMain)
    elseif toMain == BattleStateToMainStateJumpType.toMultiPvp then
        UIManager.InterfaceOpenUI(UIName.UIAbyssalMystery)
        UIManager.InterfaceOpenUI(UIName.UIStageArenaMain)
        UIManager.InterfaceOpenUI(UIName.UIStageArenaRankMain3V3)
    elseif toMain == BattleStateToMainStateJumpType.toWorldBoss then
        UIManager.InterfaceOpenUI(UIName.UIAbyssalMystery)
        UIManager.InterfaceOpenUI(UIName.UIWordBossMain)
    elseif toMain == BattleStateToMainStateJumpType.toUpWorldBoss then
        UIManager.InterfaceOpenUI(UIName.UIAbyssalMystery)
        UIManager.InterfaceOpenUI(UIName.UIUpHeroBossMain)
    elseif toMain == BattleStateToMainStateJumpType.toEquipCopy then
        ---@type BBClassBattleSpecialParam
        local param = Blackboard.ReadBBItemString(BbKey.Global, BbItemKey.BattleSpecialParam)
        UIManager.InterfaceOpenUI(UIName.UIAbyssalMystery)
        UIManager.InterfaceOpenUI(UIName.UIEquipDungeon)
        UIJump.ToEquipDungeonMain(param.EquipCopyType)
    elseif toMain == BattleStateToMainStateJumpType.toElementCopy then
        UIManager.InterfaceOpenUI(UIName.UIAbyssalMystery)
    elseif toMain == BattleStateToMainStateJumpType.toLeagueBoss then
        if Util.LeagueBoss.IsExistBossData() then
            UIManager.InterfaceOpenUI(UIName.UILeagueBossMain)
        end
    end


end







