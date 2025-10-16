-- 客户端的定时逻辑, 典型应用场景:
--  1. 定点触发逻辑
--  2. 给定时间戳触发逻辑

local ClientTimerManager = {}
local self = ClientTimerManager

-- 客户端预定义的定点触发逻辑
ClientTimerManager.TimerDict = { -- key:时间  value:callback list
    -- ["04:00:00"] = {"freeCastWeapon", "freeDrawSkill", "checkWantedSystem"},
    -- ["16:00:00"] = {"freeDrawSkill"},
    -- ["18:00:00"] = {"nightGiftOpen",},
    -- ["22:00:00"] = {"nightGiftClose",},
}
ClientTimerManager.FuncDict = {}

function ClientTimerManager.initAllTimer(  )
    self.stopAllTimer()
    self.clientTimers = {}
    for timeString, callbackList in pairs(ClientTimerManager.TimerDict) do
        -- 计算,并开启所有定点定时器
        self._startSingleTimer(timeString)
    end

    self.globalTimers = {}
end

function ClientTimerManager.stopAllTimer(  )
    if self.clientTimers then
        for k,timer in pairs(self.clientTimers) do
            timer:Stop()
        end
    end
    self.clientTimers = nil

    if self.globalTimers then
        for timerName, _ in pairs(self.globalTimers) do
            self.stopGlobalTimer(timerName)
        end
    end
    self.globalTimers = nil
end

------------------- public ------------------------
-- 定点timer的func添加
function ClientTimerManager.addTimerFunc( timeString, funcString, func )
    if not ClientTimerManager.TimerDict[timeString] then
        ClientTimerManager.TimerDict[timeString] = {funcString}
    else
        local alreadyExist = false
        for i, funcName in ipairs(ClientTimerManager.TimerDict[timeString]) do
            if funcName == funcString then
                alreadyExist =  true
                break
            end
        end
        if not alreadyExist then
            table.insert( ClientTimerManager.TimerDict[timeString], funcString )
        end
    end
    ClientTimerManager.FuncDict[funcString] = func

    -- 开启定时器
    if not self.clientTimers[timeString] then
        self._startSingleTimer(timeString)
    end
end
-- 定点timer的func删除
function ClientTimerManager.delTimerFunc( timeString, funcString )
    local funcList = ClientTimerManager.TimerDict[timeString]
    if funcList and #funcList>0 then
        for i=#funcList,1,-1 do
            local funcName = funcList[i]
            if funcName == funcString then
                table.remove(funcList, i)
            end
        end

        if #funcList == 0 and self.clientTimers[timeString] then
            self._stopSingleTimer(timeString)
        end
    end
    ClientTimerManager.FuncDict[funcString] = nil
end

function ClientTimerManager.startGlobalTimer( timerName, timeStamp, func )
    if self.globalTimers[timerName] then
        self.stopGlobalTimer(timerName)
    end
    local nextBeatLength = timeStamp + 5
    local timer = Timer.New( Slot(self._globalTimerBeat, timerName), nextBeatLength, 1, false) 
    self.globalTimers[timerName] = {timer, func }
    timer:Start() 
end

function ClientTimerManager.stopGlobalTimer( timerName )
    if self.globalTimers == nil then
        return
    end
    if self.globalTimers[timerName] then
        local timer = self.globalTimers[timerName][1]
        if timer then
            timer:Stop()
        end
        self.globalTimers[timerName] = nil
    end
end


--------------------- private ----------------
function ClientTimerManager._timeStringToStamp( timeString )
    local timeSplitList = utils.splitString(timeString, ":")
    local hour = tonumber( timeSplitList[1] )
    local minute = tonumber( timeSplitList[2])
    local second = tonumber( timeSplitList[3])
    local todayStamp = ClientUtils.getTodayTimeStamp( hour, minute, second )
    return todayStamp
end

local OneDaySeconds = 86400
function ClientTimerManager._calcNextBeat( targetTimeStamp )
    local nowTimeStamp = TimeUtils.getServerTime()
    
    if targetTimeStamp > nowTimeStamp then
        -- 今天目标时间还未达到
        return targetTimeStamp - nowTimeStamp
    else
        -- 今天目标时间已经过了
        return 86400 - (nowTimeStamp - targetTimeStamp)
    end
end

function ClientTimerManager._startSingleTimer( timeString )
    local targetTimeStamp = self._timeStringToStamp(timeString)
    local nextBeatLength = ClientTimerManager._calcNextBeat(targetTimeStamp) + 5 -- 进行一点小修正, 确保服务器已经到达时间
    local timer = Timer.New( Slot(self._timerBeat, timeString), nextBeatLength, 1, false) -- 定时触发一次, 使用unscaledTime
    self.clientTimers[timeString] = timer
    timer:Start() 
end

function ClientTimerManager._stopSingleTimer( timeString )
    local timer = self.clientTimers[timeString]
    if timer then
        timer:Stop()
        self.clientTimers[timeString] = nil
    end
end

function ClientTimerManager._timerBeat( timeString )
    -- 触发所有注册的函数
    local callbackList = ClientTimerManager.TimerDict[timeString]
    if callbackList then
        for i, funcString in ipairs(callbackList) do
            local func = ClientTimerManager.FuncDict[funcString]
            if func then
                func()
            end
        end
    end

    -- 重新计算并开启定时器
    self._stopSingleTimer(timeString)
    self._startSingleTimer(timeString)
end

function ClientTimerManager._globalTimerBeat( timerName )
    if not self.globalTimers[timerName] then
        return
    end

    local func = self.globalTimers[timerName][2]
    if func then
        func()
    end 
end

--------------------------------------------------------------
function ClientTimerManager.freeCastWeapon(  )
    HintManager.triggerEvent( UIConst.HINT_EVENT["FREE_WEAPON_CAST"], true )
end

function ClientTimerManager.freeDrawSkill(  )
    HintManager.triggerEvent( UIConst.HINT_EVENT["FREE_SKILL_DRAW"], true )
end

function ClientTimerManager.checkWantedSystem(  )
    local ca = GameContext.CurrentEntity
    if ca then
        local ui = UIManager.getUI("newWantedDlg", nil, false)
        if ui and ui:getVisible() then
            RPC.taskNewWantedLinkGet()
        end
        local wantedMonsterDlg = UIManager.getUI("wantedMonsterDlg", nil, false)
        if wantedMonsterDlg then
            wantedMonsterDlg:setVisible(false)
        end
    end
end

------------------------------------------ ↓ 每秒定时器 ↓ ------------------------------------------
ClientTimerManager.SecondTickDict = {}
-- 参数：increase：上升还是倒计时 preStr：label设置的前缀 
-- afterStr：label设置的后缀 callBack：结束的毁掉 upBound：上升时的最大值
-- timeMode:1=短倒计时模式 大于天数时只显示天数  2=纯秒数倒计时显示  其他=正常几天几小时模式
function ClientTimerManager.AddSecondTickUI(uiLabel, second, increase, preStr, afterStr, callBack, upBound, timeMode)
    local root = uiLabel.mRoot
    if not root then
        logerror("ClientTimerManager get Root Error!")
        return
    end
    preStr = preStr or ""
    afterStr = afterStr or ""
    --defaultStr = defaultStr or ""
    local result=self._updateSecondStr(uiLabel, second, preStr.."%s"..afterStr, callBack, increase, upBound, timeMode)
    if result==true then
        if not self.SecondTickDict[root.id] then
            self.SecondTickDict[root.id] = {}
        end
        if increase then    -- 秒数增加
            self.SecondTickDict[root.id][uiLabel] = {Time.unscaledTime - second, increase, preStr.."%s"..afterStr, callBack, upBound, timeMode}
        else                -- 倒计时 秒数降低
            self.SecondTickDict[root.id][uiLabel] = {Time.unscaledTime + second, increase, preStr.."%s"..afterStr, callBack, upBound, timeMode}
        end
        if not self.SecondTickTimer:IsRunning() then
            self.SecondTickTimer:Start()
        end
    end
end

function ClientTimerManager.AddSecondFormatTickUI(uiLabel, second, increase, format, callBack, upBound, timeMode)
    local root = uiLabel.mRoot
    if not root then
        logerror("ClientTimerManager get Root Error!")
        return
    end
    format = format or "%s"
    --defaultStr = defaultStr or ""
    local result=self._updateSecondStr(uiLabel, second, format, callBack, increase, upBound, timeMode)
    if result==true then
        if not self.SecondTickDict[root.id] then
            self.SecondTickDict[root.id] = {}
        end
        if increase then    -- 秒数增加
            self.SecondTickDict[root.id][uiLabel] = {Time.unscaledTime - second, increase, format, callBack, upBound, timeMode}
        else                -- 倒计时 秒数降低
            self.SecondTickDict[root.id][uiLabel] = {Time.unscaledTime + second, increase, format, callBack, upBound, timeMode}
        end
        if not self.SecondTickTimer:IsRunning() then
            self.SecondTickTimer:Start()
        end
    end
end

function ClientTimerManager.RemoveSecondTickUI(uiLabel)
    local root = uiLabel.mRoot
    if root and self.SecondTickDict[root.id] then
        self.SecondTickDict[root.id][uiLabel] = nil
        if next(self.SecondTickDict[root.id]) == nil then
            self.SecondTickDict[root.id] = nil
        end
    end
end

function ClientTimerManager._tickSecondQuest()
    if next(self.SecondTickDict) == nil then
        self.SecondTickTimer:Stop()
    else
        local nowTime = Time.unscaledTime
        for rootId, quests in pairs(self.SecondTickDict) do
            for uiLabel, timeInfo in pairs(quests) do
                local second = nil
                if timeInfo[2] then
                    second = math.floor(nowTime - timeInfo[1])
                else
                    second = math.floor(timeInfo[1] - nowTime)
                end
                local result=self._updateSecondStr(uiLabel, second, timeInfo[3], timeInfo[4], timeInfo[2], timeInfo[5], timeInfo[6])
                if result==false then
                    self.RemoveSecondTickUI(uiLabel)
                end
            end
        end
    end
end

function ClientTimerManager._updateSecondStr(uiLabel, second, strFormat, callBack, increase, upBound, timeMode)
    if not uiLabel:isAlive() then
        return false
    end
    if increase then
        if upBound and second > upBound then
            --uiLabel:setText(defaultStr)
            if callBack then
                callBack()
            end
            return false
        end
    else
        if second < 0 then
            --uiLabel:setText(defaultStr)
            if callBack then
                callBack()
            end
            return false
        end
    end
    if timeMode == 1 then
        uiLabel:setText(TimeUtils.calcShortTimeTxt(second, strFormat))
    elseif timeMode == 2 then
        uiLabel:setText(string.format(strFormat, math.floor(second)))
    else
        uiLabel:setText(string.format(strFormat, TimeUtils.calcTimeTxt(second)))
    end
    return true
end

function ClientTimerManager.RemoveSecondTickRoot(rootId)
    if self.SecondTickDict[rootId] then
        self.SecondTickDict[rootId] = nil
    end
end

ClientTimerManager.SecondTickTimer = Timer.New(ClientTimerManager._tickSecondQuest, 1, -1)
------------------------------------------ ↑ 每秒定时器 ↑ ------------------------------------------

return ClientTimerManager