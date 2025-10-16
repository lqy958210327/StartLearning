


---@class AutoFightSystem : SystemBase
AutoFightSystem = Class("AutoFightSystem", SystemBase)

function AutoFightSystem:OnInit()
    self._autoEnable = false
    self._autoType = nil
    self._autoCount = 0
    self._passCount = 0
    self._startBattleTitle = ""
    self._startBattleSubtitle = ""
    self._curBattleTitle = ""
    self._curBattleSubtitle = ""



    self._evtStart = function(autoType, autoCount, battleTitle, battleSubtitle, isOpenRelics, isImmediateFight) self:_start(autoType, autoCount, battleTitle, battleSubtitle, isOpenRelics, isImmediateFight) end
    self._evtContinueFormation = function(battleTitle, battleSubtitle, isOpenRelics) self:_continueFormation(battleTitle, battleSubtitle, isOpenRelics) end
    self._evtContinueFight = function() self:_continueFight() end
    self._evtResult = function() self:_result() end
    self._evtBreak = function() self:_break() end
    EventManager.Global.RegisterEvent(EventType.AutoFightStart, self._evtStart)
    EventManager.Global.RegisterEvent(EventType.AutoFightContinueFormation, self._evtContinueFormation)
    EventManager.Global.RegisterEvent(EventType.AutoFightContinueFight, self._evtContinueFight)
    EventManager.Global.RegisterEvent(EventType.AutoFightResult, self._evtResult)
    EventManager.Global.RegisterEvent(EventType.AutoFightBreak, self._evtBreak)
end

function AutoFightSystem:OnClear()
    EventManager.Global.UnRegisterEvent(EventType.AutoFightStart, self._evtStart)
    EventManager.Global.UnRegisterEvent(EventType.AutoFightContinueFormation, self._evtContinueFormation)
    EventManager.Global.UnRegisterEvent(EventType.AutoFightContinueFight, self._evtContinueFight)
    EventManager.Global.UnRegisterEvent(EventType.AutoFightResult, self._evtResult)
    EventManager.Global.UnRegisterEvent(EventType.AutoFightBreak, self._evtBreak)
end

function AutoFightSystem:OnGameStart()

end

function AutoFightSystem:OnGameEnd()

end

---@param autoType AutoFightType
function AutoFightSystem:_start(autoType, autoCount, battleTitle, battleSubtitle, isOpenRelics, isImmediateFight)
    self._autoEnable = true
    self._autoType = autoType
    self._autoCount = autoCount or 0
    self._startBattleTitle = battleTitle
    self._startBattleSubtitle = battleSubtitle
    self._curBattleTitle = battleTitle
    self._curBattleSubtitle = battleSubtitle

    UIManager.InterfaceOpenUI(UIName.UIAutoFighting)
    Blackboard.UIEvent.SendMessage(UIName.UIAutoFighting, UIEventID.UIAutoFighting_Start, self._autoType, self._startBattleTitle, self._startBattleSubtitle, self._curBattleTitle, self._curBattleSubtitle)
    if isImmediateFight then
        if isOpenRelics then
            self:_cmdImmediatelyOpenSelectBuff()
            self:_cmdDelaySelectRelics()
        else
            self:_cmdImmediatelyStartBattle()
        end
    else
        self:_continueFormation(battleTitle, battleSubtitle, isOpenRelics)
    end
end

function AutoFightSystem:_continueFormation(battleTitle, battleSubtitle, isOpenRelics)
    if not self._autoEnable then
        return
    end

    self._curBattleTitle = battleTitle
    self._curBattleSubtitle = battleSubtitle
    UIManager.InterfaceOpenUI(UIName.UIAutoFighting)
    Blackboard.UIEvent.SendMessage(UIName.UIAutoFighting, UIEventID.UIAutoFighting_Start, self._autoType, self._startBattleTitle, self._startBattleSubtitle, self._curBattleTitle, self._curBattleSubtitle)

    if isOpenRelics then
        self:_cmdDelayOpenSelectBuff()
    else
        self:_cmdDelayStartBattle()
    end
end

function AutoFightSystem:_continueFight()
    if not self._autoEnable then
        return
    end

    self._passCount = self._passCount + 1


    local isEnd = (self._autoType == AutoFightType.NextBattle and (not Util.BattleExitJump.ExistNextBattle()))
    isEnd = isEnd or (self._autoType == AutoFightType.Sweep and self._passCount >= self._autoCount)
    if isEnd then
        self:_result()
        return
    end

    self:_cmdDelayContinue()
end

function AutoFightSystem:_result()
    if not self._autoEnable then
        return
    end

    Blackboard.UIEvent.SendMessage(UIName.UIAutoFighting, UIEventID.UIAutoFighting_Result, self._passCount)
end

function AutoFightSystem:_break()
    if not self._autoEnable then
        return
    end

    UIManager.InterfaceCloseUI(UIName.UIAutoFighting)

    self:_clearCache()
end

function AutoFightSystem:_clearCache()
    self._autoEnable = false
    self._autoType = nil
    self._autoCount = 0
    self._passCount = 0
    self._startBattleTitle = ""
    self._startBattleSubtitle = ""
    self._curBattleTitle = ""
    self._curBattleSubtitle = ""
    if self._timerFormation then
        Util.Timer.BreakTimer(self._timerFormation)
        self._timerFormation = nil
    end
    if self._timerSelectRelics then
        Util.Timer.BreakTimer(self._timerSelectRelics)
        self._timerSelectRelics = nil
    end
    if self._timerOpenSelectBuff then
        Util.Timer.BreakTimer(self._timerOpenSelectBuff)
        self._timerOpenSelectBuff = nil
    end
    if self._timerFight then
        Util.Timer.BreakTimer(self._timerFight)
        self._timerFight = nil
    end
end

function AutoFightSystem:_cmdImmediatelyStartBattle()
    BattleProgressManager:Get():StopFormation()
end

function AutoFightSystem:_cmdImmediatelyOpenSelectBuff()
    ---@type UIFormationDB
    local db = GameDB.GetDB(DBId.Formation)
    db:OpenUISelectBuff()
end

function AutoFightSystem:_cmdDelayStartBattle()
    self._timerFormation = Util.Timer.AddTimer(3, function()
        self._timerFormation = nil
        BattleProgressManager:Get():StopFormation()
    end)
end

function AutoFightSystem:_cmdDelayOpenSelectBuff()
    self._timerOpenSelectBuff = Util.Timer.AddTimer(2, function()
        self._timerOpenSelectBuff = nil
        ---@type UIFormationDB
        local db = GameDB.GetDB(DBId.Formation)
        db:OpenUISelectBuff()
        self:_cmdDelaySelectRelics()
    end)
end

function AutoFightSystem:_cmdDelaySelectRelics()
    self._timerSelectRelics = Util.Timer.AddTimer(2, function()
        self._timerSelectRelics = nil
        ---@type UIFormationDB
        local db = GameDB.GetDB(DBId.Formation)
        db:SelectRelicsCB(1)
    end)
end

function AutoFightSystem:_cmdDelayContinue()
    self._timerFight = Util.Timer.AddTimer(3, function()
        self._timerFight = nil
        if self._autoType == AutoFightType.NextBattle then
            Util.BattleExitJump.NextBattle()
        elseif self._autoType == AutoFightType.Sweep then
            Util.BattleExitJump.ReChallenge()
        end
    end)
end

