-- 单机版帧管理类 主要管理战场内获得的黑盒Frame信息 单机版本下只接受事件 然后自己考虑如何tick帧的问题

-- DemoFrameMgr类的定义
-- @author zh
-- @date 2016-11-21


local iFrameMgr = require "Core/Common/FrameBattle/iFrameMgr"

local strClassName = "DemoFrameMgr"
local DemoFrameMgr = Class(strClassName, iFrameMgr)
DemoFrameMgr.name = strClassName
local UpdateBeat = UpdateBeat
local Time = Time

-- function iFrameManager:onReceiveMsg( frameNumber, frameData )  -- 接收到某一帧的数据
-- function iFrameManager:nextFrame()   -- 下一帧函数 取一帧数据 然后对黑盒进行计算

-- tick函数  当时间改变时 根据现有数据该进行如何的计算入口  具体算法在这个函数内实现


-- 构造函数。
function DemoFrameMgr:ctor(matrixInstance)
    self.isRunning = false
    self._heroPropEditorAction = nil -- 英雄属性编辑器回调
end

-- 析构函数。
function DemoFrameMgr:destroy()
    UpdateBeat:Remove(self.tick,self)
    self.matrixInstance = nil
end

function DemoFrameMgr:start(  )
    if self.started then
        return
    end
    self.isRunning = true
    self.curFrame = 0                       -- 黑盒帧
    self.timeAlreadyHandled = 0             -- 毫秒
    self.timePassed = 0                     -- 毫秒
    self:_handleOutQueue()                  -- 初始化也许有一些可能的输出结果
    UpdateBeat:Add(self.tick,self)
    self.started = true
    -- body
end

function DemoFrameMgr:running( )
    return self.isRunning
end

local MAX_FRAME = 3 -- 每次最多追两帧  这样在稳定帧率6以上 表现都是正确的
-- 单机版本时间到了之后直接取下一帧数据 并且数据来源是单次技能直接设置到下一帧执行
function DemoFrameMgr:tick()
    self.timePassed = self.timePassed + Time.deltaTime * 1000
    local unhandledFrameNumber = math.floor((self.timePassed - self.timeAlreadyHandled) / self.matrixFrameLength)
    for index = 1, math.min(unhandledFrameNumber, MAX_FRAME) do
        self:nextFrame()
    end
end

function DemoFrameMgr:nextFrame()
    self.curFrame = self.curFrame + 1
    if self.matrixInstance then
        self.matrixInstance:nextFrame()
    end


    self:_handleOutQueue()
    self.timeAlreadyHandled = self.curFrame * self.matrixFrameLength

    if self._heroPropEditorAction then
        self._heroPropEditorAction()
    end
end

function DemoFrameMgr:WithHeroPropEditorAction(action)
    self._heroPropEditorAction = action
end

function DemoFrameMgr:nextFrameWithoutEvent()
    self.curFrame = self.curFrame + 1
    if self.matrixInstance then
        self.matrixInstance:nextFrame()
    end
end


function DemoFrameMgr:_handleOutQueue()
    -- handle matrix output
    if self.matrixInstance then
        local outputQueue = self.matrixInstance:getFrameOutput()
        if outputQueue then
            for i, output in pairs(outputQueue) do
                --print(table.dump(output))
                EventCenter.sendEvent(output[1], output[2], output[3])
            end
        end
    end
end

function DemoFrameMgr:pause()
    UpdateBeat:Remove(self.tick,self)
    self.isRunning = false
end

function DemoFrameMgr:resume()
    if not self.started then
        return
    end
    if not self.isRunning then
        UpdateBeat:Add(self.tick,self)
        self.isRunning = true
    end
end

return DemoFrameMgr
