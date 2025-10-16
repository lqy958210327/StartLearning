

-- 剧情步骤数据类 
local className = "PlotStepData"
---@class PlotStepData
PlotStepData = Class(className)

function PlotStepData:InternalInit()
    ---@type number 剧情步骤ID
    self.plotStepID = nil
    ---@type table<number, PlotActionBase> 剧情Action列表
    self.actionList = {}
    ---是否正在播放中
    self.isPlaying = false
    ---@type table<number, Timer> 时间计时器列表
    self.timerlist = {}
end

--- 设置剧情步骤数据
function PlotStepData:SetStepID(stepID)
    self.stepID = stepID
    local stepData = PlotTableHelper.GetPlotResStepData(stepID)
    if not stepData then
        logerror("找不到剧情步骤数据："..stepID)
        return
    end
    
    --步骤持续时间
    self.stepTimeSpan = stepData.time_span
    --- 剧情动画取名与正常剧情不同
    if stepData.perform_type == PlotTypeEnum.Perform_Type_MC then
        local plotAction = PlotActionMC()
        plotAction:SetActionData(stepData.video_path)
        table.insert(self.actionList, plotAction)
        --- 剧情暂停位置
        self.video_Time = stepData.video_pause_time
        
        self.avgVideoPlayer = UIJump.ToUIAvgVideoPlayer(stepData.video_path, stepData.video_pause_time * 1000, function() PlotHelper.EndPlot() end, 1,true, false)

        EventManager.Global.RegisterEvent(EventType.PlotPause, function() self:VideoTimerFinish() end)
        return
    end
    
    -- 剧情Action
    local diaLogAction = PlotActionDialog()
    diaLogAction:SetActionData(stepData.talk, stepData.time_span, stepData.talk_npc_name, stepData.head_path, stepData.head_name)
    table.insert(self.actionList, diaLogAction)
    -- 背景音乐、语音
    local bgmAction = PlotActionBGM()
    bgmAction:SetActionData(stepData.bgm_id, stepData.story_vocal)
    table.insert(self.actionList, bgmAction)
    --- 背景Action  数据后续添加
    local bgAction = PlotActionBg()
    table.insert(self.actionList, bgAction)

    local isBgShakeFollow = false
    --立绘相关Action
    local lightList = stepData.role_Light   --npc明暗
    -- npc立绘数据
    for pos = 1, 3 do
        local npcDataID = stepData["role_Img_"..pos]
        local roleAction = PlotActionRole()
        local roleSpineAction = PlotActionSpine()
        if not npcDataID then
            roleAction:SetRoleData(nil, pos)
            roleSpineAction:SetActionData(nil, pos)
        else
            local roleLight = lightList[pos]
            local roleData = PlotTableHelper.GetPlotResRoleImgData(npcDataID)
            if roleData then
                -- 动作 立绘与动画都会进行动作
                local actionData = PlotTableHelper.GetPlotResRoleActionData(stepData["role_action_"..pos])
                local actionType = nil     -- 行动类型
                local actionParam = nil    -- 行动参数
                local actionIndex = nil    -- 行动顺序
                local actionTime = nil     -- 行动时长
                local actionDelay = nil    -- 行动延迟
                local isAction = nil       -- 是否有行动
                if actionData then
                    actionType = actionData.action_type
                    actionParam = actionData.p1
                    actionIndex = stepData["role_action_"..pos.."_index"]
                    actionTime = actionData.time
                    actionDelay = actionData.delay
                    roleAction:SetActionData(actionType, actionParam, actionIndex, actionTime, actionDelay)
                    --- 如果有立绘抖动，则背景抖动跟随立绘
                    if actionType == PlotActionTypeEnum.Shake then
                        isBgShakeFollow = true
                    end
                    isAction = true
                end
                if not roleData.spine_name then
                    --立绘数据
                    roleAction:SetRoleData(npcDataID, pos, roleLight, roleData.scale)
                    roleSpineAction:SetActionData(nil, pos)
                else
                    roleAction:SetRoleData(nil, pos, nil, roleData.scale)
                    --Spine数据
                    roleSpineAction:SetActionData(npcDataID, pos, roleData.spine_name, roleData.spine_action, roleLight, isAction)
                end
            end
        end
        table.insert(self.actionList, roleSpineAction)
        table.insert(self.actionList, roleAction)
    end
    -- 背景Action
    bgAction:SetActionData(stepData.bg_pic, stepData.bg_shake, isBgShakeFollow)
end

function PlotStepData:Touch()
    self.isPlaying = true

    local video_Time = tonumber(self.video_Time)
    if video_Time then
        self.videoTimer = Timer.New(function(...) self:VideoTimerFinish() end, video_Time, 1)
        self.videoTimer:Start()
    else
        ---添加结束计时
        local during = tonumber(self.stepTimeSpan)
        local timer = Timer.New(function(...) self:TimerFinish() end, during, 1)
        table.insert(self.timerlist, timer)
        self:TouchActionGroup()
        timer:Start()
    end
end

function PlotStepData:TouchActionGroup()
    for i, plotAction in ipairs(self.actionList) do
        plotAction:ShowAction()
    end
end

--- 开启、关闭计时器
---@param isAuto boolean 是否开启
function PlotStepData:ChangeTimer(isAuto)
    --- 是否进行自动下一步
    self.isAuto = isAuto
    self:SetNext()
end

function PlotStepData:TimerFinish()
    --停止计时器
    for i, time in ipairs(self.timerlist) do
        time:Stop()
    end

    for i, action in ipairs(self.actionList) do
        action:OnClear()
    end
    --- 清除数据
    self.actionList = {}
    self.isPlaying = false
    self:SetNext()
end

---进入剧情暂停时间
function PlotStepData:VideoTimerFinish()
    ---停止计时器
    self.videoTimer:Stop()
    self._evtVideoRun = function() self:VideoRun() end
    EventManager.Global.RegisterEvent(EventType.PlotEndBename, self._evtVideoRun)
    ---剧情暂停
    self.avgVideoPlayer:pauseVideo()
    ---打开取名界面
    UIManager.getUI(UIName.UICreateRole, true)

    ---添加结束计时
    local during = tonumber(self.stepTimeSpan)
    local timer = Timer.New(function(...) self:TimerFinish() end, during, 1)
    table.insert(self.timerlist, timer)
    self:TouchActionGroup()
    timer:Start()
end

---剧情动画继续播放，直到结束
function PlotStepData:VideoRun()
    self.avgVideoPlayer:resumeVideo()
end

function PlotStepData:SetNext()
    --- 如果开启自动，计时结束直接开始下一步
    if self.isAuto and not self.isPlaying then
        PlotHelper.NextStep()
    end
end

---@type funtion() 是否可以进行下一步
---@return boolean 是否不在播放中
function PlotStepData:CheckCanNext()
    return not self.isPlaying
end

---跳出
function PlotStepData:Skip()
    self:TimerFinish()
end

--- 重置
function PlotStepData:Reset()

end

function PlotStepData:OnClear()
    for i, time in ipairs(self.timerlist) do
        time:Stop()
    end
    self.plotStepID = nil
end
