local DebugConst = require "Core/Debug/DebugConst"
--local AVGEditor = require "Core/Debug/AVGEditor/AVGEditor"
local DebugModule = {}

--入口中文描述
DebugModule.ENTRY_NAME = "剧情编辑"
--功能函数

function DebugModule.playAVG(sender, menu, value)
    --AVGEditor.playAVG(value)
    PlotHelper.StartPlot(tonumber(value))
end

--功能列表
DebugModule.FUNC_MENU = 
{
    { name = "播放AVG(ID)", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.playAVG },
}

return DebugModule

