local className = "PlotActionBGM"
---@class PlotActionBGM : PlotActionBase
PlotActionBGM = Class(className, PlotActionBase)

function PlotActionBGM:OnInit()
    ---@type string 背景音乐ID
    self.bgmID = nil
    ---@type string 语音音乐
    self.storyVocalID = nil
end

--- 设置动作数据
---@param _bgmID number 背景音乐ID
---@param _storyVocal number 语音ID
function PlotActionBGM:SetActionData(_bgmID, _storyVocal)
    self.bgmID = _bgmID
    self.storyVocalID = _storyVocal
end

function PlotActionBGM:ShowAction()
    if self.bgmID then
        local cfg = DataTable.ResMusic[self.bgmID]
        if cfg then
            EventManager.Global.Dispatch(EventType.AudioSystemPlayMusic, cfg.path, 0.7, true)
        end
    end
    --- 播放语音
    AudioCueMediator.playVocal(self.storyVocalID)
end

function PlotActionBg:OnClear()
    self.bgmID = nil
    self.storyVocal = nil
end