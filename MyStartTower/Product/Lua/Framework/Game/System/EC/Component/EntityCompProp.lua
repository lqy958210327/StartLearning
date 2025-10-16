


-- 属性数据

---@class EntityCompProp : BaseEntityComp
EntityCompProp = Class("EntityCompProp", BaseEntityComp)

function EntityCompProp:OnInit()
    ---@type table<EntPropType, number>
    self._propDict = {}
    for k, v in pairs(EntPropType) do
        self._propDict[v] = 0
    end
end

function EntityCompProp:OnClear()

end

function EntityCompProp:_propValid(prop)
    assert(type(prop) == "number", "---   EntPropType类型必须是 number")
    assert(self._propDict[prop], "---   未知类型属性， EntPropType = "..prop)
end

function EntityCompProp:GetProp(prop)
    self:_propValid(prop)

    return self._propDict[prop]
end

---@param prop EntPropType
function EntityCompProp:SetProp(prop, value)
    self:_propValid(prop)

    if prop == EntPropType.MaxShield then
        self:_setMaxShield(value)
    elseif prop == EntPropType.MaxBloodShield then
        self:_setMaxBloodShield(value)
    else
        self:_setProp(prop, value)
    end
end



function EntityCompProp:_setProp(type, value) self._propDict[type] = value end

function EntityCompProp:_setMaxShield(value)
    local prop = self._propDict[EntPropType.MaxShield]
    if prop < value then prop = value end
    self._propDict[EntPropType.MaxShield] = prop
end

function EntityCompProp:_setMaxBloodShield(value)
    local prop = self._propDict[EntPropType.MaxBloodShield]
    if prop < value then prop = value end
    self._propDict[EntPropType.MaxBloodShield] = prop
end