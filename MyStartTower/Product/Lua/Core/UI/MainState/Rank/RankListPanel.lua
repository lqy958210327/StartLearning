
local strClassName = "RankListPanel"
local RankListPanel = Class(strClassName, UIControls.Panel)

-- 构造函数。
function RankListPanel:ctor()
    self:initUI()
end

function RankListPanel:initUI()
    self.scrollRank = UIControls.ScrollViewLoopV(self,self.mPath)
    self.scrollRank:addEventCellChanged(self.onRankCellChanged)
    self.cells = {}
end



function RankListPanel:refreshRankScroll()
    --print("新数据长度"..#self.data..'最后一页吗'..tostring(isLastPage))
    if self.dataList == nil then
        return
    end
    
    if self.isLastPage then
        self.scrollRank:setTotalCount(#self.dataList)
    else
        self.scrollRank:setTotalCount(#self.dataList + 1)
    end
end

function RankListPanel:enableScrollSlot()
    self.scrollRank:getComObj().vertical = true
end

-- 排行榜cell初始化，加载到超出当前页数量时，请求下一页数据
function RankListPanel:onRankCellChanged(sender, targetCell, newIdx)
    if not targetCell  then
        if self.mWindow.typeRank == Const.RANK_TYPE_HOUSEFAVOR then
        else
            targetCell = UIControls.BtnPlayerRankCellLoop(sender,"System/Rank/BtnPlayerRank",newIdx)
        end
    end
    if not self.dataList or #self.dataList==0 then
        return
    end
    if self.dataList[newIdx] ~= nil then
        targetCell:setData(self.dataList[newIdx], newIdx)
    else
        -- targetCell:setData(nil, newIdx)
        --print('nilindex::'..tostring(newIdx).."nextPage")
        --CurAvatar:onRankListRequestNextPage(self.mWindow.typeRank)
    end
    self.cells[newIdx] = targetCell
end



function RankListPanel:clear( ... )
    self.dataList = nil
end

return RankListPanel