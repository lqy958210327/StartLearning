local className = "PlotData"
---@class PlotData
PlotData = Class(className)

function PlotData:InternalInit()
    ---@type number 剧情ID
    self.plotID = nil
    ---@type table<number, PlotStepData>
    self.stepList = {}
    ---@type PlotStepData
    self.curStep = nil
    ---@type number 当期播放剧情的步骤
    self.curStepIndex = nil
    ---@type boolean 是否可以自动
    self.isCanAuto = nil
    ---@type boolean 是否可以跳过
    self.isCanSkip = nil
end

--- 设置播放的剧情ID
---@param plotID number 剧情数据
function PlotData:SetPlotID(plotID)
    self.plotID = plotID
    local plotData = PlotTableHelper.GetPlotResGroupData(plotID)
    if not plotData then
        return false
    end
    --步骤组
    local talk_chain = plotData.talk_chain
    for i, stepID in ipairs(talk_chain) do
        local plotStepData = PlotStepData()
        plotStepData:InternalInit()
        plotStepData:SetStepID(stepID)
        table.insert(self.stepList, plotStepData)
    end
    self.isCanAuto = true
    self.isCanSkip = plotData.can_skip == 1
    return true
end

--- 播放剧情的步骤
function PlotData:Start()
    self.curStepIndex = 1
    self.curStep = self.stepList[self.curStepIndex]
    
    self.curStep:Touch()
    self.curStep:ChangeTimer(self.isCanAuto)

    --- 确认是否可跳过
    Blackboard.UIEvent.SendMessage("UIPlot", UIEventID.UIPlot_Refresh_Skip, self.isCanSkip)
end

function PlotData:Next()
    if not self.curStep then
        return
    end
    if self.curStep:CheckCanNext() == false then
        return
    end
    self.curStepIndex = self.curStepIndex + 1
    self.curStep = self.stepList[self.curStepIndex]

    if self.curStep == nil then
        Blackboard.UIEvent.SendMessage("UIPlot", UIEventID.UIPlot_Refresh_End)
    else
        self.curStep:Touch()
        self.curStep:ChangeTimer(self.isCanAuto)
    end
end

--- 跳过剧情步骤
function PlotData:SkipStep()
    --剧情数据
    if self.curStep ~= nil then
        self.curStep:Skip()
    end
    self:Next()
end

--- 修改是否自动
function PlotData:ChangeAuto()
    self.isCanAuto = not self.isCanAuto
    Blackboard.UIEvent.SendMessage("UIPlot", UIEventID.UIPlot_Refresh_Auto, self.isCanAuto)
    self.curStep:ChangeTimer(self.isCanAuto)
end

function PlotData:End()
    self.curStepIndex = 0
    self.CurStep = nil
    for i = 1, #self.stepList do
        self.stepList[i]:Reset()
    end
    PlotHelper.EndPlot()
end

function PlotData:OnClear()
    for i = 1, #self.stepList do
        self.stepList[i]:OnClear()
    end
    self.plotID = nil
    self.stepList = nil
    self.curStep = nil
    self.curStepIndex = nil
    self.isCanAuto = nil
    self.isCanSkip = nil
end
