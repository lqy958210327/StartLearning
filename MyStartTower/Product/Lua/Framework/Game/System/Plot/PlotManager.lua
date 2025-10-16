---@class PlotManager
PlotManager = Class("PlotManager", SystemBase)
---@type PlotData
local curPlotData = nil
---@type function   剧情结束回调
local endBackCall = nil

function PlotManager:OnInit()
    -- 初始化配置表数据
    self.plotDataList = PlotTableHelper.Init()
    
    self._evtSetPlot = function(id, backCall) self:SetPlotID(id, backCall) end
    EventManager.Global.RegisterEvent(EventType.PlotShow, self._evtSetPlot)
end

--- 设置剧情ID
---@param plotID number 剧情ID
---@param _backCall function 结束回调
function PlotManager:SetPlotID(plotID, _backCall)
    PlotManager:StartPlot(plotID)
    endBackCall = _backCall
end

--- 开始播放剧情
function PlotManager:StartPlot(plotID)
    if curPlotData then
        ---防止快速点击
        if plotID == curPlotData.plotID then
            return
        end
        logerror("已有剧情正在播放！！！当前剧情ID"..curPlotData.plotID)
        return
    end
    
    curPlotData = PlotData()
    curPlotData:InternalInit()
    local isShowPlot = curPlotData:SetPlotID(plotID)
    if not isShowPlot then
        curPlotData = nil
        return
    end
    
    --- 起名剧情
    if not curPlotData.showName then
        --打开剧情UI界面
        UIJump.ToOpenUIPlot()
        curPlotData:Start()
    end
end

--- 播放剧情下一步
function PlotManager:NextStep()
    if curPlotData then
        curPlotData:Next()
    end
end

--- 跳过剧情
function PlotManager:SkipStep()
    curPlotData:SkipStep()
end

function PlotManager:ChangeAuto()
    curPlotData:ChangeAuto()
end

function PlotManager:EndPlot()
    --- 关闭界面预留方法
    UIManager.getUI("UIPlot", false)
    curPlotData:OnClear()
    curPlotData = nil
    --- 停止播放背景音乐
    EventManager.Global.Dispatch(EventType.AudioSystemStopMusic)
    --- 播放语音音乐
    LuaCallCs.Audio.AudioStopVoice()
    --- 剧情结束，调用结束回调
    if endBackCall then
        endBackCall()
        endBackCall = nil
    end
end
