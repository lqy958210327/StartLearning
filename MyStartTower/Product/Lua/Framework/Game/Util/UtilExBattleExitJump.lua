


-- 战斗中退出到其他界面

local __battleTypeToJumpType = function(battleType)
    if battleType == BattleDefine.ClientBattleType.Stage then
        return BattleStateToMainStateJumpType.toMain
    elseif battleType == BattleDefine.ClientBattleType.MultiStage then
        return BattleStateToMainStateJumpType.toMain
    elseif battleType == BattleDefine.ClientBattleType.BossTower then
        return BattleStateToMainStateJumpType.toBossTower
    elseif battleType == BattleDefine.ClientBattleType.MazeTower then
        return BattleStateToMainStateJumpType.toMaze
    elseif battleType == BattleDefine.ClientBattleType.PVP then
        return BattleStateToMainStateJumpType.toPvp
    elseif battleType == BattleDefine.ClientBattleType.PVPDefend then
        return BattleStateToMainStateJumpType.toPvp
    elseif battleType == BattleDefine.ClientBattleType.MultiPVP then
        return BattleStateToMainStateJumpType.toMultiPvp
    elseif battleType == BattleDefine.ClientBattleType.MultiPVPDefend then
        return BattleStateToMainStateJumpType.toMultiPvp
    elseif battleType == BattleDefine.ClientBattleType.WorldBoss then
        return BattleStateToMainStateJumpType.toWorldBoss
    elseif battleType == BattleDefine.ClientBattleType.UpWorldBoss then
        return BattleStateToMainStateJumpType.toUpWorldBoss
    elseif battleType == BattleDefine.ClientBattleType.CareerCopy then
        return BattleStateToMainStateJumpType.toEquipCopy
    elseif battleType == BattleDefine.ClientBattleType.ElementCopy then
        return BattleStateToMainStateJumpType.toElementCopy
    elseif battleType == BattleDefine.ClientBattleType.GuildBoss then
        return BattleStateToMainStateJumpType.toLeagueBoss
    end
    return BattleStateToMainStateJumpType.None
end

local __changeProgressMain = function()
    EventManager.Global.Dispatch(EventType.GameProgressChange, GameProgressID.Main)
end

local tab = {}

function tab.ToStrongerFormation()
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleEndToStrongerType, BattleStateToMainStateJumpType.toStrongerFormation)
    __changeProgressMain()
end

function tab.ToStrongerHero()
    local isOpen, lockShow = Util.LimitOpen.GetLimitOpen(LimitOpenIDEnum.Enum_FunHero)
    if isOpen then
        Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleEndToStrongerType, BattleStateToMainStateJumpType.toStrongerHero)
        __changeProgressMain()
    else
        UIJump.ShowScrollTips(lockShow)
    end
end

function tab.ToStrongerEquip()
    local isOpen, lockShow = Util.LimitOpen.GetLimitOpen(LimitOpenIDEnum.Enum_FunHero)
    if isOpen then
        Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleEndToStrongerType, BattleStateToMainStateJumpType.toStrongerEquip)
        __changeProgressMain()
    else
        UIJump.ShowScrollTips(lockShow)
    end
end

function tab.ExitBattle()
    local clientType = Util.BattleParam.GetClientBattleType()
    local value = __battleTypeToJumpType(clientType)
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleEndToMainType, value)
    __changeProgressMain()
end

function tab.ReChallenge()
    __changeProgressMain()

    local data = Util.Battle.GetBattleResultData()
    ---@type BBClassBattleSpecialParam
    local param = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.BattleSpecialParam)

    if data.BattleType == BattleConst.BATTLE_TYPE_STAGE then
        WarHelper.EnterBattleStage(param.MainStageId)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_MULTI_STAGE then
        WarHelper.EnterBattleMultiStage(param.MultiMainStageId)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
        WarHelper.EnterBattleTower(param.BossTowerType, param.BossTowerLevel)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
        WarHelper.EnterBattleEquipTower(param.MazeType, param.MazeLevel)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_MULTI_PVP then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
        --没有操作
    elseif data.BattleType == BattleConst.FORMATION_TYPE_CAREER_EQUIP_STAGE then
        --没有操作
        WarHelper.EnterBattleCareerEquipStage(param.EquipCopyType, param.EquipCopyLevel)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_GUILD_BOSS then
        --没有操作
    end
end

function tab.NextBattle()
    __changeProgressMain()
    if not tab.ExistNextBattle() then
        return
    end


    local data = Util.Battle.GetBattleResultData()
    ---@type BBClassBattleSpecialParam
    local param = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.BattleSpecialParam)

    if data.BattleType == BattleConst.BATTLE_TYPE_STAGE then
        WarHelper.EnterBattleStage(param.MainStageNextId)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_MULTI_STAGE then
        WarHelper.EnterBattleMultiStage(param.MultiMainStageNextId)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
        WarHelper.EnterBattleTower(param.BossTowerType, param.BossTowerNextLevel)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
        WarHelper.EnterBattleEquipTower(param.MazeType, param.MazeNextLevel)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_MULTI_PVP then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_GUILD_BOSS then
        --没有操作
    end
end

function tab.ExistNextBattle()

    local data = Util.Battle.GetBattleResultData()
    ---@type BBClassBattleSpecialParam
    local param = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.BattleSpecialParam)
    if data.BattleType == BattleConst.BATTLE_TYPE_STAGE then
        return (param.MainStageNextId ~= nil)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_MULTI_STAGE then
        return (param.MultiMainStageNextId ~= nil)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
        return (param.BossTowerNextLevel ~= nil)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
        return (param.MazeNextLevel ~= nil)
    elseif data.BattleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_MULTI_PVP then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
        --没有操作
    elseif data.BattleType == BattleConst.BATTLE_TYPE_GUILD_BOSS then
        --没有操作
    end
    return false
end

Util.BattleExitJump = tab
