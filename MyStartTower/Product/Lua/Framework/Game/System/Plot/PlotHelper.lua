---@class PlotHelper
PlotHelper = {}

--- 开始播放剧情
---@param plotID  number ID
function PlotHelper.StartPlot(plotID)
    PlotManager:StartPlot(plotID)
end

function PlotHelper.NextStep()
    PlotManager:NextStep()
end

function PlotHelper.SkipStep()
    PlotManager:SkipStep()
end

function PlotHelper.EndPlot()
    PlotManager:EndPlot()
end

function PlotHelper.ChangeAuto()
    PlotManager:ChangeAuto()
end

function PlotHelper.Clear()
    
end