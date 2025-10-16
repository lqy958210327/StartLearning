local className = "UIEquipTipsData"
---@class UIEquipTipsData UIHeroTipsData的窗口数据
UIEquipTipsData = Class(className)

---@type fun(self: UIEquipTipsData)
function UIEquipTipsData:ctor()
    self._equipTag = 0 ---@type number 装备类型
    self._equipUid = 0 ---@type number 装备GID
    self._compareEquipUid = 0 ---@type number 对比装备GID
    self._strengthLv = 0
    self._isSimpleBeing = false ---@type boolean 是否简单显示装备绑定信息(ture:穿戴中文字提示，false:穿戴英雄的图标)
end

---@type fun(self: UIEquipTipsData, equipTag:number):UIEquipTipsData
function UIEquipTipsData:WithEquipTag(equipTag)
    self._equipTag = equipTag ---@type number 装备类型
    return self
end

---@type fun(self: UIEquipTipsData, equipUid:number):UIEquipTipsData
function UIEquipTipsData:WithEquipGid(equipUid)
    self._equipUid = equipUid ---@type number 装备UID
    return self
end

---@type fun(self: UIEquipTipsData, compareEquipUid:number):UIEquipTipsData
function UIEquipTipsData:WithCompareEquipGid(compareEquipUid)
    self._compareEquipUid = compareEquipUid ---@type number 对比装备UID
    return self
end

---@type fun(self: UIEquipTipsData, strengthLv:number):UIEquipTipsData
function UIEquipTipsData:WithStrengthLv(strengthLv)
    self._strengthLv = strengthLv ---@type number 强化等级
    return self
end

---@type fun(self: UIEquipTipsData):UIEquipTipsData 激活简单绑定信息
function UIEquipTipsData:EnableSimpleBeing()
    self._isSimpleBeing = true ---@type boolean 是否是简单的被动装备
    return self
end

---@type fun(self: UIEquipTipsData):number 获取装备标记
function UIEquipTipsData:GetEquipTag()
    return self._equipTag
end

---@type fun(self: UIEquipTipsData):number 获取装备GID
function UIEquipTipsData:GetEquipGid()
    return self._equipUid
end

---@type fun(self: UIEquipTipsData):number 获取对比装备GID
function UIEquipTipsData:GetCompareEquipGid()
    return self._compareEquipUid
end

---@type fun(self: UIEquipTipsData):boolean 是否简单显示装备绑定
function UIEquipTipsData:IsSimpleBeing()
    return self._isSimpleBeing
end

---@type fun(self: UIEquipTipsData):number 获取强化等级
function UIEquipTipsData:GetStrengthLv()
    return self._strengthLv or 0 ---@type number 强化等级
end


