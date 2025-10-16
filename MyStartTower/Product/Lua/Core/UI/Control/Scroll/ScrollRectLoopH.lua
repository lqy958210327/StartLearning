local ScrollRectLoopV = require("Core/UI/Control/Scroll/ScrollRectLoopV")

local UIConst = UIConst
local strClassName = "ScrollRectLoopH"
local ScrollRectLoopH = Class(strClassName, ScrollRectLoopV)

function ScrollRectLoopH:ctor(parent, path, totalCount, cellInitFunc)
    
end

function ScrollRectLoopH:_getControlType()
    return UIConst.ControlTypeLoopScrollRectHorizontal
end

return ScrollRectLoopH

