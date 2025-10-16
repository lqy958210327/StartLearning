---@class PlotTableHelper
PlotTableHelper = {}

PlotTableHelper.Init = function()
    
end

function PlotTableHelper.GetlPlotResDataList()
    
end

--- 获取剧情数据
---@param plotID number 剧情ID
---@return PlotResData plotResData 剧情数据
function PlotTableHelper.GetPlotResGroupData(plotID)
    local plotResData = DataTable.ResNewTalkGroupData[plotID]
    if not plotResData then
        logerror("未查询到剧情数据："..plotID)
    end
    return plotResData
end

--- 获取剧情步骤数据
---@param stepID number 剧情步骤ID
---@return PlotResStepData stepData 步骤数据
function PlotTableHelper.GetPlotResStepData(stepID)
    local stepData = DataTable.ResNewTalkData[stepID]
    return stepData
end

--- 获取剧情玩家立绘位置数据
---@param roleID number 玩家立绘ID
---@return PlotResRolePos rolePosData 立绘位置数据
function PlotTableHelper.GetPlotResRolePosData(roleID)
    local plotRolePosData = DataTable.ResNewTalkPos[roleID]
    if not plotRolePosData then
        logerror("找不到剧情立绘数据："..roleID)
    end
    return plotRolePosData
end

--- 获取剧情玩家立绘数据
---@param roleID number 玩家立绘ID
---@return PlotRoleImgData roleImgData 立绘数据
function PlotTableHelper.GetPlotResRoleImgData(roleID)
    local plotRoleImgData = DataTable.ResNewTalkImg[roleID]
    return plotRoleImgData
end

--- 获取剧情玩家立绘位置数据
---@param roleID number 玩家立绘ID
---@return PlotResRoleAction roleImgData 立绘数据
function PlotTableHelper.GetPlotResRoleActionData(roleID)
    local plotResRoleAction = DataTable.ResNewTalkAction[roleID]
    return plotResRoleAction
end

---@class PlotResData
PlotResData = Class("PlotResData")
function PlotResData:Ctor()
    self.id = 0                 ---@type number 剧情ID
    self.can_skip = 0           ---@type number 是否可跳过
    self.talk_chain = 0         ---@type table<number, number> 对话序列{索引， 步骤ID}
end

---@class PlotResStepData
PlotResStepData = Class("PlotResStepData")
function PlotResStepData:ctor()
    -- 基本信息
    self.id = 0                   ---@type number 剧情ID
    self.talk_npc_name = ""       ---@type string 说话人名字
    self.head_path = ""           ---@type string 头像路径
    self.head_name = ""           ---@type string 头像ID
    -- 对话内容
    self.talk = ""               ---@type string 对白
    self.time_span = 0           ---@type number 持续时间（秒）
    -- 背景音效相关
    self.bg_id = 0                ---@type number 背景
    self.story_vocal = ""         ---@type string 语音
    self.bgm_id = 0               ---@type number BGM
    self.bgm_loop = 0             ---@type number bgm循环
    self.role_Img_1 = 0           ---@type number 立绘角色1
    self.role_Img_2 = 0           ---@type number 立绘角色2
    self.role_Img_3 = 0           ---@type number 立绘角色3
    self.role_pos = {}            ---@type table<number> 角色位置
    self.role_Light = {}          ---@type table<number> 角色明暗
end

---@class PlotResRolePos 剧情中对话立绘位置数据
PlotResRolePos = Class("PlotResRolePos")
function PlotResRolePos:Ctor()
    ---@type number 序号ID
    self.idx = nil
    ---@type string x轴位置偏移
    self.x = nil
    ---@type string y轴位置偏移
    self.y = nil
end

---@class PlotRoleImgData 剧情中对话立绘数据
PlotRoleImgData = Class("PlotRoleImgData")
function PlotRoleImgData:Ctor()
    ---@type number 序号ID
    self.id = nil
    ---@type number 立绘类型
    self.img_type = nil
    ---@type string 立绘名称
    self.img_name = nil
    ---@type string spine立绘
    self.spine_name = nil
    ---@type string spine立绘动作
    self.spine_action = nil
    ---@type number 缩放
    self.scale = nil
    ---@type table<number, number> 位置修正
    self.pos = nil
end

---@class PlotResRoleAction 剧情中对话立绘位置数据
PlotResRoleAction = Class("PlotResRoleAction")
function PlotResRoleAction:Ctor()
    ---@type number 序号ID
    self.id = nil
    ---@type number 位移方式: 1 左移2 右移3 放大4 震动
    self.action_type = nil
    ---@type number 参数
    self.p1 = nil
    ---@type number 时长
    self.time = nil
    ---@type number 延时
    self.delay = nil
end
