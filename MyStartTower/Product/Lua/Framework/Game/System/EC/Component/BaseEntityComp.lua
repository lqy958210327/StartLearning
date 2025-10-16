


---@class BaseEntityComp
BaseEntityComp = Class("BaseEntityComp")

function BaseEntityComp:InternalInit(entId)
    self._entId = entId
    self:OnInit()
end

function BaseEntityComp:InternalClear()
    self:OnClear()
end

function BaseEntityComp:OnInit()

end

function BaseEntityComp:OnClear()

end

function BaseEntityComp:EntID() return self._entId end