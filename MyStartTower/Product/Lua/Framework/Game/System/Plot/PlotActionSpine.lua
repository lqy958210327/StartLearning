local className = "PlotActionSpine"
---@class PlotActionSpine : PlotActionBase
PlotActionSpine = Class(className, PlotActionBase)

function PlotActionSpine:OnInit()
    self.pos = 1    ---@type number Spine位置索引
    self.spine_name = ""    ---@type string Spine位置索引
    self.spine_action = ""  ---@type string Spine位置索引
end

--- 设置动作数据
---@param _npcDataID number Spine数据ID
---@param _pos number Spine动画位置索引
---@param _spine_name string Spine动画路径
---@param _spine_action string Spine动画动作名
---@param _spine_Light string Spine动画明暗数据
---@param _isAction boolean Spine动画是否有动作
function PlotActionSpine:SetActionData(_npcDataID, _pos, _spine_name, _spine_action, _spine_Light, _isAction)
    self.npcDataID = _npcDataID
    self.pos = _pos
    self.spine_name = _spine_name
    self.spine_action = _spine_action
    self.spine_Light = _spine_Light == 1 and true or false
    self.isAction = _isAction
end

function PlotActionSpine:ShowAction()
    Blackboard.UIEvent.SendMessage("UIPlot", UIEventID.UIPlot_Refresh_Spine, self.pos, self.spine_name, self.spine_action, self.spine_Light, self.isAction)
end