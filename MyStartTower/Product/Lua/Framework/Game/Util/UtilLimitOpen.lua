
-- 简化接口:功能开启
local tab = {}

---@type fun(openID:number)获取功能开启
---@param openID number 策划配置，或者使用Enum 案例：LimitOpenIDEnum.Enum_FunTask
---@return boolean value, string description 是否开启，未开启提示
function tab.GetLimitOpen(openID)
    if not openID then
        LuaCallCs.LogError("OpenID必须有值！！！")
        return true
    end
    ---@type LimitOpenDB
    local db = GameDB.GetDB(DBId.LimitOpen)
    
    local value = false
    local description = "功能开启，策划未配置！！开启ID："..openID
    ---@type LimitOpenData
    local limitOpenData = db:GetLimitOpenData(openID)
    if limitOpenData then
        ---进度解锁
        if limitOpenData.unlockStage then
            local playerMainStory = Blackboard.ReadBBItemNumber(BbKey.Global, BbItemKey.PlayerMainStory)
            if playerMainStory > limitOpenData.unlockStage then
                value = true
            else
                description = limitOpenData.description
            end
        end
        ---道具解锁
        if limitOpenData.unlockItemId then
            local myItemNum = ItemHelper.GetItemCount(limitOpenData.unlockItemId)
            if myItemNum >= 1 then
                value = true
            else
                description = limitOpenData.description
            end
        end
    end
    return value, description
end

Util.LimitOpen = tab
