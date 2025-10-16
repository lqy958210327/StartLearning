local strClassName = "BehaviorManager"
local BehaviorManager = Class(strClassName)

--单例
function BehaviorManager:ctor()
    --behavior字典
    -- key是entity id
    -- value是behavior
    self.mBehaviors ={}
    self.orderBehaviors = {}
end

function BehaviorManager:destroy()
    self.mBehaviors = nil
end

function BehaviorManager:addBehavior(entityID,bh)
    --已经存在且不可覆盖，则返回
    if self.mBehaviors[entityID] then
        return false
    end
    self.mBehaviors[entityID] = bh
    table.insert(self.orderBehaviors, entityID)
    return true
end

function BehaviorManager:delBehavior( entityID )
    if self.mBehaviors[entityID] then
        self.mBehaviors[entityID] = nil
        for index, eid in ipairs(self.orderBehaviors) do
            if eid == entityID then
                table.remove(self.orderBehaviors, index)
                break
            end
        end
        return true
    else
        return false
    end
end

--先所有人tick一遍，再集中处理所有的事件。
function BehaviorManager:tick(  )
    for index, id in ipairs(self.orderBehaviors) do
        local bh = self.mBehaviors[id]
        bh:tick()
    end

    --如果想对事件顺序进行定制，now is the time
    for index, id in ipairs(self.orderBehaviors) do
        local bh = self.mBehaviors[id]
        bh:handleEventList()
    end
end

return BehaviorManager