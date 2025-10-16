local tab = {}
---@param itemId number
function tab.GetItemIcon(itemId)
    local cfg = DataTable.ResItem[itemId]
    if cfg then
       return ItemHelper.GetItemRawImageIcon(itemId)
    end
    if cfg == nil and DataTable.ResEquipData[itemId] then
        cfg = DataTable.ResEquipData[itemId]
       return DataTable.ResEquipDefine[cfg.level][cfg.position].iconPath
    end
    if cfg == nil and DataTable.ResEmblem[itemId] then
        cfg = DataTable.ResEmblem[itemId]
        return EmblemHelper.GetEmblemIcon(itemId)
    end
    if cfg == nil and RimuruHelper.GetStoneConfig(itemId) then
        cfg = RimuruHelper.GetStoneConfig(itemId)
       return cfg.icon
    end
end

Util.CommonItem = tab