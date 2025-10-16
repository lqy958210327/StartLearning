local strClassName = "BaseObject"
local ResItem = DataTable.ResItem
local BaseObject = Class(strClassName)





function BaseObject.isAttrs( resID )
    return resID >= 100000 and resID < 200000
end





function BaseObject:ctor(data)
    self._serverData = data
    self:_initData()
end

function BaseObject:destroy()

end

function BaseObject:_initData()
    -- self.gid = self._serverData.gid
end

function BaseObject:getName(name)
    if IS_EDITOR_ID and self.gid then
        if self.id then
            name = name .. '[' .. self.id .. ']'
        end
        if self.gid then
            name = name .. '(' .. self.gid .. ')'
        end
    end
    return name
end

function BaseObject:refreshObject( serverData )
    self._serverData = serverData
    self:_initData()
end

function BaseObject:getIconPath()
    if self.resData and self.resData.iconPath and self.resData.icon then
        return {UIConst.ITEM_ICON_PATH..self.resData.iconPath, self.resData.icon}
    end
end

function BaseObject:getQualityPath()
    if self.quality then
        return UIConst.COMMON_QUALITY_CONFIG[self.quality]
    end
end

function BaseObject:isRare()
    return false
end

function BaseObject:getQualityName()
    if self.name == nil then
        return ""
    end
    local color = self:getQualityColor()
    if color and color ~= UIColor.QUALITYWHITE then
        return "<color=#"..color.hex..">"..self.name.."</color>"
    else
        return self.name
    end
end

function BaseObject:getQualityColor(getQuality)
    local quality = getQuality or self.quality

    local color = nil
    if quality == Const.OBJ_QUALITY_WHITE then
        color = UIColor.QUALITYWHITE
    elseif quality == Const.OBJ_QUALITY_GREEN then
        color = UIColor.QUALITYGREEN
    elseif quality == Const.OBJ_QUALITY_BLUE then
        color = UIColor.QUALITYBLUE
    elseif quality == Const.OBJ_QUALITY_PURPLE then
        color = UIColor.QUALITYPURPLE
    elseif quality == Const.OBJ_QUALITY_GOLD then
        color = UIColor.QUALITYORANGE
    end
    return color
end

function BaseObject:isCommonItem()
    return false
end

function BaseObject:isEquip()
    return false
end

function BaseObject:isFragmentItem()
    return false
end

function BaseObject:isArtifact()
    return false
end

function BaseObject:isHero()
    return false
end

function BaseObject:isPetGem()
    return false
end

function BaseObject:isSkin()
    return false
end

function BaseObject:getNumStr()
    return ""
end

function BaseObject:isFurniture(  )
    return false
end

return BaseObject