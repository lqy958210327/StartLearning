local UIGMDialog = Class("UIGMDialog")

function UIGMDialog:SetDBData()
    ---@type GMDB
    local db = GameDB.GetDB(DBId.GM)
    self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBDialog)
    if not self.debugInfoList then
        db:SetGMData(GMEmun.GMDBDialog, DialogFun)
        self.debugInfoList = db:GetGMUIDataList(GMEmun.GMDBDialog)
    end
    return self.debugInfoList
end

function UIGMDialog:UILiftOnClose()
    
end

function UIGMDialog.playAVG(value)
    PlotHelper.StartPlot(tonumber(value))
end

---@type table
DialogFun = {
    { name = "播放AVG(ID)", btnType = GMBtnEmun.BTN_TYPE_INPUT, func = UIGMDialog.playAVG },
}

return UIGMDialog

