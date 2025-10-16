local className = "SkillTimeEntity"
---@class SkillTimeEntity 技能时间事件实体
local SkillTimeEntity = Class(className)

function SkillTimeEntity:ctor(executeFrame)
    self._isExecute = false ---@type boolean 是否执行
    self._executeFrame = executeFrame ---@type number 执行帧
    self._nextEntity = nil ---@type SkillTimeEntity 下一个事件
end

---@type fun(self:SkillTimeEntity, entityUid:string, skillTag:number) 执行
function SkillTimeEntity:ToExecute(entityUid, skillTag)
    if self._isExecute then ---已经执行过。
        return
    end

    self._isExecute = true;
    self:OnExecute(entityUid, skillTag)
end

---@type fun(self:SkillTimeEntity) 是否执行过
---@return boolean
function SkillTimeEntity:IsExecute()
    return self._isExecute
end

---@type fun(self:SkillTimeEntity, nextEntity:SkillTimeEntity) 设置下一个事件
---@param nextEntity SkillTimeEntity 下一个事件
function SkillTimeEntity:SetNextEntity(nextEntity)
    self._nextEntity = nextEntity
end

---@type fun(self:SkillTimeEntity) 获取下一个事件
---@return SkillTimeEntity
function SkillTimeEntity:GetNextEntity()
    return self._nextEntity
end

---@type fun(self:SkillTimeEntity) 获取执行帧
---@return number
function SkillTimeEntity:GetExecuteFrame()
    return self._executeFrame
end



------override------
---@override fun(self:SkillTimeEntity)用于重写事件的执行逻辑。
function SkillTimeEntity:OnExecute(entityUid, skillTag)

end

---@override fun(self:SkillTimeEntity)用于重写事件的字符串表示。
function SkillTimeEntity:ToString()    
    return "SkillTimeEntity"
end

return SkillTimeEntity
