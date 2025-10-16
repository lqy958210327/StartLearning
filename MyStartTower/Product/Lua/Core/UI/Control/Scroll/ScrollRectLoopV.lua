-- ScrollRectLoopV类的定义
-- @author
-- @date
local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

local UIConst = UIConst
local strClassName = "ScrollRectLoopV"
local ScrollRectLoopV = Class(strClassName, UIBaseControl)

--ScrollRectLoopV
--[[ScrollRectLoopV-attribute
ScrollRectLoopV.content = Scroll View/Viewport/Content
ScrollRectLoopV.verticalScrollbar = Scroll View/Scrollbar Vertical(Scrollbar)
-child
Scroll View/Viewport/Content
Scroll View/Scrollbar Vertical(Scrollbar)
]]

-- 构造函数。
function ScrollRectLoopV:ctor(parent, path, totalCount, cellInitFunc)
    self.mTotalCount = totalCount or 0
    self._cellInitFunc = cellInitFunc
end

function ScrollRectLoopV:_getControlType()
    return UIConst.ControlTypeLoopScrollRectVertical
end

function ScrollRectLoopV:getComObj()
    if self._obj == nil then
        local obj = ScrollRectLoopV.super.getComObj(self)
        obj.TotalCount = self.mTotalCount
        if self._cellInitFunc ~= nil then
            self:addEventCellChanged(self._cellInitFunc)
        end
    end
    return self._obj
end

function ScrollRectLoopV:getTotalCount()
    local obj = self:getComObj()
    if obj ~= nil then
        return obj.TotalCount
    else
        return false
    end
end

--设置scroll拥有cell数量
--jumpIdx: true:置顶 nil:不变化 指定数字:跳转到指定cell位置
--（重新置顶时刷新所有cell,jumpIdx为nil时原地增量刷新）
-- forceRefresh 强制刷新，如果传true，则在列表隐藏时也刷新cell，否则会启动一个协程，等列表显示之后再进行刷新。
function ScrollRectLoopV:setTotalCount(totalCount, jumpIdx, forceRefresh)
    local obj = self:getComObj()
    if obj ~= nil then
        if jumpIdx == true then
            jumpIdx = 1
        end
        if forceRefresh == nil then
            forceRefresh = true
        end
        obj:SetTotalCount(totalCount, jumpIdx or 0, forceRefresh)
    end
end





function ScrollRectLoopV:setPosToCell(index)
    local obj = self:getComObj()
    if obj ~= nil and index > 0 then
        obj:SetPosToCell(index - 1)
    end
end

function ScrollRectLoopV:goToBottom()
    local obj = self:getComObj()
    if obj ~= nil then
        obj:GoToBottom()
    end
end




function ScrollRectLoopV:addItem(insertIndex)
    local obj = self:getComObj()
    if obj ~= nil then
        obj:AddItem(insertIndex or (self:getTotalCount() +1))
    end
end

function ScrollRectLoopV:delItem(tgtIndex)
    local obj = self:getComObj()
    if obj ~= nil then
        obj:DelItem(tgtIndex or self:getTotalCount())
    end
end

--刷新现有显示区间的cell数据(调用oncellchange)
function ScrollRectLoopV:refreshCells()
    local obj = self:getComObj()
    if obj ~= nil then
        obj:RefreshCells()
    end
end

function ScrollRectLoopV:clearPool()
    if VersionUtils.getEngineVersion() >= 113819 then
        local obj = self:getComObj()
        if obj ~= nil then
            obj:ClearPool()
        end
    end
end

function ScrollRectLoopV:clearCells()
    self:setTotalCount(0)
end


function ScrollRectLoopV:jumpToCell(index)
    -- body
end

--index 以1开始计数
--speed 是以deltaTime的像素偏移
function ScrollRectLoopV:scrollToCell(index, speed)
    index = math.max(0, (index or 1) - 1)
    speed = math.max(1, speed or 10000)
    local obj = self:getComObj()
    if obj ~= nil then
        obj:SrollToCell(index, speed)
    end
end


-- function ScrollRectLoopV:setTotalCountAndRefillCells(totalCount,index)
--     local obj = self:getComObj()
--     if obj ~= nil then
--         index = index and index - 1 or 0
--         obj:SetTotalCountAndRefillCells(totalCount,index)
--     end
-- end

-- function ScrollRectLoopV:setTotalCountOriPos(totalCount)
--     local obj = self:getComObj()
--     if obj ~= nil then
--         obj:SetTotalCountOriPos(totalCount)
--     end
-- end

--重新创建现有显示区间的cell(会删除现有控件)
function ScrollRectLoopV:refillCells(offset, fromEnd)
    local obj = self:getComObj()
    if obj ~= nil then
        obj:RefillCells(offset or 0, fromEnd or false)
    end
end

function ScrollRectLoopV:getVerticalValue()
    local obj = self:getComObj()
    if obj ~= nil then
        return obj.verticalScrollbar.value
    end
    return -1
end






function ScrollRectLoopV:addEventCellChanged(eventFunc)
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():AddLoopScrollRectOnCellChanged(obj, self:_packageCallback(eventFunc))
    end
end

function ScrollRectLoopV:clearEventCellChanged()
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():ClearLoopScrollRectOnCellChanged(obj)
    end
end

function ScrollRectLoopV:setRectSize( width, height )
    local obj = self:getComObj()
    if (height ~= nil or width ~= nil) and obj ~= nil then
        local oldSize = obj.transform.sizeDelta
        height = height or oldSize.y
        width = width or oldSize.x
        obj.transform.sizeDelta =  UnityEngine.Vector2(width, height)
    end
end

return ScrollRectLoopV

