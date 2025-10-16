local className = "PlotActionRole"
---@class PlotActionRole : PlotActionBase
PlotActionRole = Class(className, PlotActionBase)

function PlotActionRole:OnInit()
    ---@type string 立绘资源
    self.roleImgName = nil
    ---@type number 立绘位置
    self.rolePos = false
    ---@type number 是否有动作
    self.isAction = false
end

--- 设置动作数据
---@param _roleData string 立绘角色数据
---@param _rolePos number 立绘角色位置数据
---@param _actionType number 立绘角色动作类型   位移方式: 1 左移2 右移3 放大4 震动
---@param _actionParam number 位移参数
function PlotActionRole:SetActionData(_actionType, _actionParam, _actionIndex, _actionTime, _actionDelay)
    self.isAction = true
    self.actionType = _actionType
    self.actionParam = _actionParam
    self.actionIndex = _actionIndex
    self.actionTime = _actionTime
    self.actionDelay = _actionDelay
end

--- 设置动作数据
---@param _roleData string 立绘角色数据
---@param _rolePos number 立绘角色位置数据
---@param _roleLight number 立绘角色明暗数据
function PlotActionRole:SetRoleData(_roleID, _rolePos, _roleLight, _roleScale)
    self.rolePos = _rolePos
    self.roleScale = _roleScale
    if _roleID then
        local roleData = PlotTableHelper.GetPlotResRoleImgData(_roleID)
        self.roleImgName = roleData.img_name
        self.roleType = roleData.img_type
        self.roleLight = _roleLight == 1 and true or false
    end
end

function PlotActionRole:ShowAction()
    -- 角色立绘动作
    if self.isAction then
        Blackboard.UIEvent.SendMessage("UIPlot", UIEventID.UIPlot_Refresh_RoleAction, self.rolePos, self.actionType, self.actionParam, self.actionIndex, self.actionTime, self.actionDelay)
    end
    
    Blackboard.UIEvent.SendMessage("UIPlot", UIEventID.UIPlot_Refresh_Role, self.roleImgName, self.roleType, self.rolePos, self.roleLight, self.isAction, self.roleScale)
end

function PlotActionBg:OnClear()
    self.roleImgName = nil
    self.roleType = nil
    self.roleLight = nil
    self.isAction = nil
    self.actionType = nil
    self.actionParam = nil
    self.actionIndex = nil
    self.actionTime = nil
    self.actionDelay = nil
end