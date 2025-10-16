local className = "PlotActionDialog"
---@class PlotActionDialog : PlotActionBase
PlotActionDialog = Class(className, PlotActionBase)

function PlotActionDialog:OnInit()
    ---@type string 对话内容
    self.talkStr = nil
    ---@type string 对话时长
    self._talkTime = nil
end

--- 设置动作数据
---@param _talkStr string 对话内容
---@param _talkTime string 对话时长
---@param _talkHeroName string 对话人名称
---@param _talkHeadpath string 对话人头像路径
---@param _talkHeadName string 对华人头像资源名
function PlotActionDialog:SetActionData(_talkStr, _talkTime, _talkHeroName, _talkHeadpath, _talkHeadName)
    local playerName = Util.Account.PlayerName()
    -- self.talkStr = WildCardHelper.stringFormat(_talkStr, playerName, LightColor)
    self.talkStr = string.format(_talkStr, playerName)
    self.talkTime = _talkTime
    self.talkHeroName = _talkHeroName
    self.talkHeadpath = _talkHeadpath
    self.talkHeadName = _talkHeadName
end

function PlotActionDialog:ShowAction()
    Blackboard.UIEvent.SendMessage("UIPlot", UIEventID.UIPlot_Refresh_Txt, self.talkStr, self.talkTime, self.talkHeroName, self.talkHeadpath, self.talkHeadName)
end

function PlotActionBg:OnClear()
    self.talkStr = nil
    self.talkTime = nil
    self.talkHeroName = nil
    self.talkHeadpath = nil
    self.talkHeadName = nil
end