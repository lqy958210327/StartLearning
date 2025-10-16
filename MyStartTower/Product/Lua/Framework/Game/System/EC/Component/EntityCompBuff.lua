

-- buff数据

---@class EntityBuffData
local EntityBuffData = Class("EntityBuffData")
function EntityBuffData:Init(attackId, buffId, lv)
    self.AttackID = attackId
    self.BuffID = buffId
    self.BuffLV = lv
end
function EntityBuffData:Update(layer)
    self.BuffLayer = layer
end

---@class EntityCompBuff : BaseEntityComp
EntityCompBuff = Class("EntityCompBuff", BaseEntityComp)

function EntityCompBuff:OnInit()
    ---@type EntityBuffData[]
    self._buffList = {}
end

function EntityCompBuff:OnClear()
    self._buffList = {}
end

function EntityCompBuff:AddBuff(attackId, buffId, lv, layer)
    for i = 1, #self._buffList do
        local data = self._buffList[i]
        if data.AttackID == attackId and data.BuffID == buffId and data.BuffLV == lv then
            data:Update(layer)
            return
        end
    end
    local data = EntityBuffData()
    data:Init(attackId, buffId, lv)
    data:Update(layer)
    table.insert(self._buffList, data)

    table.sort(self._buffList, function(a, b)
        local weightA = BattleStateHelper.GetBuffShowPriority(a.BuffID, a.BuffLV)
        local weightB = BattleStateHelper.GetBuffShowPriority(b.BuffID, b.BuffLV)
        return weightA > weightB
    end)
end

function EntityCompBuff:RemoveBuff(attackId, buffId)
    for i = #self._buffList, 1, -1 do
        local data = self._buffList[i]
        if data.AttackID == attackId and data.BuffID == buffId then
            table.remove(self._buffList, i)
        end
    end
end

---@return EntityBuffData[]
function EntityCompBuff:GetBuffList()
    return self._buffList
end
