


local tab = {}

---@param obj GameObject
---@param layout BaseHeroCardBigUILayout
function tab.SetLayout(obj, layout)
    local card = HeroCardHelper.GetHeroCardBig(obj)
    card:SetUILayout(layout)
    return card
end

---@param card BaseHeroCardBig
---@param entity HeroEntity
function tab.SetDataByEntity(card, entity, moduleId)
    card:SetDataByHeroEntity(entity, moduleId)
end

---@param card BaseHeroCardBig
---@param id number
function tab.SetDataByConfigID(card, id, moduleId)
    card:SetDataByConfigID(id, moduleId)
end

---@param card BaseHeroCardBig
---@param configId number
---@param star number
---@param lv number
function tab.SetDataByMsgInfo(card, configId, star, lv, moduleId)
    card:SetDataByMsgInfo(configId, star, lv, moduleId)
end

---@param card BaseHeroCardBig
---@param isEmpty boolean
function tab.WithEmpty(card, isEmpty)
    card:WithEmpty(isEmpty)
end

---@param card BaseHeroCardBig
---@param isSelect boolean
function tab.WithSelect(card, isSelect)
    card:WithSelect(isSelect)
end

UITemp.HeroCard = tab