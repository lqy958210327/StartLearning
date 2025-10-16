-- ServerFrameMgr类的定义


local iFrameMgr = require "Core/Common/FrameBattle/iFrameMgr"

local strClassName = "ServerFrameMgr"
local ServerFrameMgr = Class(strClassName, iFrameMgr)

-- function iFrameManager:onReceiveMsg( frameNumber, frameData )  -- 接收到某一帧的数据
-- function iFrameManager:nextFrame()   -- 下一帧函数 取一帧数据 然后对黑盒进行计算

-- tick函数  当时间改变时 根据现有数据该进行如何的计算入口  具体算法在这个函数内实现


-- 构造函数。
function ServerFrameMgr:ctor(matrixInstance)
    self.curFrame = 0                       -- 黑盒帧
end

function ServerFrameMgr:nextFrame()
    self.curFrame = self.curFrame + 1
    self.matrixInstance:nextFrame()
end


function ServerFrameMgr:_handleOutQueue()
    -- handle matrix output
    local outputQueue = self.matrixInstance:getFrameOutput()
    if outputQueue then
        for i, output in pairs(outputQueue) do
            EventCenter.sendEvent(output[1], output[2], output[3])
        end
    end
end

return ServerFrameMgr
