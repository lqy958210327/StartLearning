local Group = require("Core/Common/FrameBattle/Ability/Group")


---@class GridTrigger
---@field gridMap table<number, Group> 网格触发器的注册表，按网格坐标存储回调函数组
---网格触发器系统，用于管理基于网格的事件触发
--- 主要功能：
--- 1. 在指定网格注册/移除触发回调
--- 2. 当单位移动时自动触发对应网格的 enter/leave 事件
--- 典型应用场景：
--- - 陷阱触发（当单位进入陷阱网格时触发效果）
--- - 区域效果（持续影响在特定网格内的单位）
--- - 传送点检测（进入特定网格触发传送）
local GridTrigger = {}

function GridTrigger:log(...)
    self.logger:trace(...)
end

function GridTrigger:toString()
    return 'GridTrigger'
end

--- 注册网格触发器
--- @param grid Grid 网格对象（必须来自GridGraph的findGrid结果）
--- @param func function 触发回调函数 function(unit: Unit, triggerType: 'enter'|'leave')
--- @note 使用GridGraph获取的网格对象保证坐标唯一性
--- @see GridGraph.findGrid
function GridTrigger:create(grid, func)
    local stub = self.gridMap[grid]
    if stub == nil then
        stub = Group()
        self.gridMap[grid] = stub
    end
    stub.add(func)
end
--- 移除网格触发器 
--- @param grid Grid 网格对象（必须与create时使用的grid对象一致）
--- @param func function 要移除的回调函数
function GridTrigger:remove(grid, func)
    local stub = self.gridMap[grid]
    if stub then
        stub.remove(func)
    end
end

--- 处理单位移动事件（应由战场系统调用）
---@param unit Unit      发生移动的单位
---@param leaveGrid Grid? 离开的网格坐标（nil表示首次生成）
---@param enterGrid Grid? 进入的网格坐标（nil表示离开战场）
function GridTrigger:unitMove(unit, leaveGrid, enterGrid)
    local leaveStub = leaveGrid and self.gridMap[leaveGrid]
    local enterStub = enterGrid and self.gridMap[enterGrid]
    if leaveStub then
        leaveStub.forEach(pcall, unit, 'leave')
    end
    if leaveStub then
        enterStub.forEach(pcall, unit, 'enter')
    end
end

local GridTriggerMt = {__index = GridTrigger, __tostring = GridTrigger.toString}

--- 创建新的网格触发器实例
---@param logger Logger 日志记录器
---@return GridTrigger 新的网格触发器实例
local function newGridTrigger(logger)
    local trigger = setmetatable({gridMap = {}}, GridTriggerMt)
    trigger.logger = logger:newLogger('GridTrigger', trigger)
    return trigger
end
return newGridTrigger