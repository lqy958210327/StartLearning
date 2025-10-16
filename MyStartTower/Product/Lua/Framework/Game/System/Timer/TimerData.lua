


local __timerId = 0

---@class TimerData
TimerData = Class("TimerData")

function TimerData:GetId() return self._id end
function TimerData:IsValid() return self._isValid end

function TimerData:InternalInit()
    __timerId = __timerId + 1
    self._id = __timerId

    self._interval = 0 --间隔时间
    self._loop = 0 --循环次数
    self._callback = nil --回调函数
    self._curTime = 0 --当前时间
    self._curLoop = 1 --当前循环次数
    self._isValid = false -- 是否有效
end

function TimerData:InternalClear()

end

function TimerData:InternalStart(interval, loop, callback)
    self._interval = interval
    self._loop = loop
    self._callback = callback
    self._curTime = 0
    self._curLoop = 1
    self._isValid = true
end

function TimerData:InternalStop()
    self._isValid = false
end

function TimerData:InternalTick(deltaTime)
    self._curTime = self._curTime + deltaTime

    if self._loop > 0 then
        -- 有限次数循环
        local errorCount = 0
        while true do
            errorCount = errorCount + 1
            if errorCount > 50 then
                LuaCallCs.LogError('---   警告:TimerData:InternalTick errorCount > 50')
                break
            end

            local temp = self._interval * self._curLoop
            if self._curTime >= temp then
                if self._isValid then
                    if self._callback then
                        self._callback(self._curLoop)
                    end
                    self._curLoop = self._curLoop + 1
                    if self._curLoop > self._loop then
                        self:InternalStop()
                    end
                else
                    break
                end
            else
                break
            end
        end

    else

        -- 无限次数循环
        local errorCount = 0
        while true do
            errorCount = errorCount + 1
            if errorCount > 50 then
                LuaCallCs.LogError('---   警告:TimerData:InternalTick errorCount > 50')
                break
            end

            if self._curTime >= self._interval then
                if self._isValid then
                    if self._callback then
                        self._callback(self._curLoop)
                    end
                    self._curLoop = self._curLoop + 1
                    self._curTime = self._curTime - self._interval
                else
                    break
                end
            else
                break
            end
        end



    end

end
