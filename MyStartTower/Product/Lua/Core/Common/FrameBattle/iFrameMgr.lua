-- 进行黑盒运行帧率控制的基类  
-- 根据接收的数据接口  onReceiveMsg   设置最大帧率   用nextFrame去控制行走一帧  并对返回的黑盒输出进行处理

-- iFrameManager类的定义
-- @author ZH
-- @date 2016-11-21

local strClassName = "iFrameManager"
local iFrameManager = Class(strClassName)

-- 构造函数。
function iFrameManager:ctor(matrixInstance)
    -- 黑盒实例
    self.matrixInstance = matrixInstance
    -- 输入数据（帧率为Key）
    --self.frameQueue = {}

    -- 当前帧率 及已经接收到的信息最大帧率
    self.curFrame = 0
    --self.maxFrame = 0
    self.matrixFrameLength = matrixInstance.frameLength
end

-----------------------------------------------------------------事件相关接口---------------------------------------------------------------------------
function iFrameManager:onReceiveMsg(inputType, packArgs, frameNum)
    if not frameNum then
        frameNum = self.curFrame + 1
    end
--[[    if not self.frameQueue[frameNum] then
        self.frameQueue[frameNum] = {}
    end
    table.insert(self.frameQueue[frameNum], {inputType, packArgs})]]
    self.matrixInstance:receiveInputInfo(inputType, packArgs, frameNum)
end

-- tick函数  当时间改变时 根据现有数据该进行如何的计算入口  具体算法在这个函数内实现
--[[function iFrameManager:tick()
    -- local outInfo = self:nextFrame()    -- 行走一帧  并得到输出事件列表
    -- if outInfo then                     -- 遍历输出数据  处理之
    --     for i, output in ipairs(outputQueue) do
    --     end
    -- end
end]]

-- 下一帧函数 取一帧数据 然后对黑盒进行计算
--[[function iFrameManager:nextFrame()
    -- 当前帧率已经和接收到的消息的帧同步时不进行操作  返回失败
    if self.curFrame >= self.maxFrame then
        return nil
    end
    self.curFrame = self.curFrame + 1
    local frameData = self.frameQueue[self.curFrame]                    -- 读取下一Frame数据进行处理
    self.matrixInstance:addEvent(self.curFrame, frameData)
    self.matrixInstance:nextFrame()
    return self.matrixInstance:getFrameOutput()
end]]

function iFrameManager:destroy()
end

return iFrameManager
