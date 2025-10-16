local className = "PlotActionBg"
---@class PlotActionBg : PlotActionBase
PlotActionBg = Class(className, PlotActionBase)

function PlotActionBg:OnInit()
    ---@type string 背景资源地址
    self.bgTextUrl = nil
    ---@type bool 背景抖动
    self.isShake = nil
end

--- 设置动作数据
---@param _showData string 显示数据
---@param _bg_shake number 是否抖动
---@param _isFollowRole boolean 是否跟随人物立绘抖动
function PlotActionBg:SetActionData(_showData, _bg_shake, _isFollowRole)
    self.bgTextUrl = _showData
    self.isShake = _bg_shake ~= nil
    self.isFollowRole = _isFollowRole
end
function PlotActionBg:ShowAction()
    Blackboard.UIEvent.SendMessage("UIPlot", UIEventID.UIPlot_Refresh_Bg, self.bgTextUrl, self.isShake, self.isFollowRole)
end

function PlotActionBg:OnClear()
    self.bgTextUrl = nil
    self.isShake = nil
end
