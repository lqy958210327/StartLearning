local tab = {}

---@type fun(uniqueTag:number) 取消延迟操作。
---@param uniqueTag number 操作的唯一标识。
function tab.Cancel(uniqueTag)
    if uniqueTag == nil or uniqueTag <= 0 then
        logerror("UniTash.Cancel: uniqueTag is nil or <= 0, uniqueTag = " .. tostring(uniqueTag))
        return
    end
    CS_LuaCallCs.Cancel(uniqueTag)
end

---@type fun(ms:number, action:fun(), ignoreTimeScale:boolean):number
---@param ms number 延迟的毫秒数
---@param action fun() 延迟后执行的函数
---@param ignoreTimeScale boolean 是否忽略时间缩放
---@return number uniqueTag 该操作的唯一标识。可用于取消延迟这件事
function tab.Delay(ms, action, ignoreTimeScale)
    ignoreTimeScale = ignoreTimeScale or false
    return CS_LuaCallCs.Delay(ms, action, ignoreTimeScale)
end

---@type fun(frameCount:number, action:fun()):number
---@param frameCount number 延迟的帧数
---@param action fun() 延迟后执行的函数
---@return number uniqueTag 该操作的唯一标识。可用于取消延迟这件事
function tab.DelayFrame(frameCount, action)
    if frameCount <= 0 then
        logerror("UniTash.DelayFrame: frameCount must be greater than 0, frameCount = " .. tostring(frameCount))
        return
    end
    return CS_LuaCallCs.DelayFrame(frameCount, action)
end

---@type fun(predicate:function, action:function):number
---@param predicate fun():boolean 返回一个布尔值的函数，用于判断是否满足条件
---@param action fun() 满足条件后执行的函数。
---@return number uniqueTag 该操作的唯一标识。可用于取消延迟这件事
function tab.WaitUntil(predicate, action)
    if predicate == nil or action == nil then
        logerror("UniTash.WaitUntil: predicate or action is nil")
        return
    end
    return CS_LuaCallCs.WaitUntil(predicate, action)
end

LuaCallCs.UniTask = tab