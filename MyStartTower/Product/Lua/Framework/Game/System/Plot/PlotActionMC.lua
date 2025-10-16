local className = "PlotActionMC"
---@class PlotActionMC : PlotActionBase
PlotActionMC = Class(className, PlotActionBase)

function PlotActionMC:OnInit()
    ---@type string 背景资源地址
    self.mcUrl = nil
end

--- 设置动作数据
---@param _mcUrl string 显示数据
function PlotActionMC:SetActionData(_mcUrl)
    self.mcUrl = _mcUrl
end

function PlotActionMC:ShowAction()
    -- UIManager.playAVG( tonumber(self.mcUrl), nil)
end

function PlotActionMC:OnClear()

end
