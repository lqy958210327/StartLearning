---@class GridGraph
---@classmod GridGraph
local Grid = require("Core/Common/FrameBattle/Ability/Grid")
local AbilityDataTable = require("Core/Common/FrameBattle/Ability/AbilityDataTable")
local BattleMiscConfig = AbilityDataTable.BattleMiscConfig


local GridGraph = {}

function GridGraph:createMap(matrixType)
    local gridConfig
    if matrixType == 2 then
        -- 植物大战僵尸模式
        gridConfig = BattleMiscConfig.ZOMBIE_POS_CONFIG
    elseif matrixType == 1 then
        -- 五行BOSS模式
        gridConfig = BattleMiscConfig.SPE_BOSS_POS_CONFIG
    else
        -- 普通模式
        gridConfig = BattleMiscConfig.NORMAL_POS_CONFIG
    end
    local LR_LEN, UD_LEN, oddShorter = gridConfig.LR_LEN or 1, gridConfig.UD_LEN or 1, gridConfig.oddShorter and true or false
    self.sizeX, self.sizeY, self.oddShorter = LR_LEN, UD_LEN, oddShorter
    self.graph = {}
    self.pos = {}
    self.origin = {coordX = -(LR_LEN-1)*0.5, coordY = -(UD_LEN-1)*0.5}
    for y = 0, UD_LEN-1 do
        local odd = y%2 == 1
        local offset = odd and (oddShorter and 0.5 or -0.5) or 0
        local count = odd and (oddShorter and (LR_LEN - 1) or (LR_LEN + 1)) or LR_LEN
        local line = {}
        for x = 0, count-1 do
            local pos = gridConfig.LineConfig[y+1][x+1]
            local grid = Grid(x + offset + self.origin.coordX, y + self.origin.coordY, pos)
            table.insert(line, grid)
            self.pos[pos] = grid
        end
        table.insert(self.graph, line)
    end
    -- 建立邻居关系
    for y_idx, line in ipairs(self.graph) do
        for x_idx, grid in ipairs(line) do
            grid.neighbors = {}
            local isOddRow = (y_idx - 1) % 2 == 1  -- y_idx从1开始，原y坐标是y_idx-1
            local isShort = isOddRow == oddShorter
            local directions = {
                {ny = y_idx,   nx = x_idx+1},                        -- 右
                {ny = y_idx,   nx = x_idx-1},                        -- 左
                {ny = y_idx-1, nx = isShort and x_idx or x_idx-1},   -- 上左
                {ny = y_idx+1, nx = isShort and x_idx or x_idx-1},   -- 下左
                {ny = y_idx-1, nx = isShort and x_idx+1 or x_idx},   -- 上右
                {ny = y_idx+1, nx = isShort and x_idx+1 or x_idx}    -- 下右
            }
            for _, dir in ipairs(directions) do
                if dir.ny > 0 and dir.ny <= #self.graph then
                    local target_line = self.graph[dir.ny]
                    if target_line[dir.nx] then
                        table.insert(grid.neighbors, target_line[dir.nx])
                    end
                end
            end
        end
    end
end

-- 取周围一圈格子
function GridGraph:aroundGrid(grid)
    return grid.neighbors
end

function GridGraph:clearUnits()
    for _, line in ipairs(self.graph) do
        for _, grid in ipairs(line) do
            grid.unit = nil
            grid.around = nil
        end
    end
end

--- 根据战场坐标查找对应网格
--- @param coordX number 战场X坐标
--- @param coordY number 战场Y坐标
--- @return Grid|nil 找到返回网格对象，否则返回nil
--- @usage 获取单位所在网格：
--- local grid = gridGraph:findGrid(unit.coordX, unit.coordY)
function GridGraph:findGrid(coordX, coordY)
    local gridY = math.floor(coordY - self.origin.coordY) + 1
    if gridY <= 0 or gridY > #self.graph then
        return nil
    end
    local line = self.graph[gridY]
    local odd = (gridY-1)%2
    local offset = self.oddShorter and 0.5 or -0.5
    local gridX = math.floor(coordX - self.origin.coordX - odd * offset) + 1
    return line[gridX]
end
function GridGraph:updateUnit(unit)
    self:removeUnit(unit)
    local grid = self:findGrid(unit.coordX, unit.coordY)
    unit.grid = grid
    grid.unit = unit
    self:log('updateUnit', unit, unit.coordX, unit.coordY, unit.grid)
    if unit.bigMonster then
        local around = unit.grid.neighbors
        for _, g in ipairs(around) do
            g.around = (g.around or 0) + 1
        end
    end
end
function GridGraph:removeUnit(unit)
    if unit.grid then
        self:log('removeUnit', unit, unit.coordX, unit.coordY, unit.grid)
        if unit.bigMonster then
            local around = unit.grid.neighbors
            for _, g in ipairs(around) do
                g.around = g.around - 1
            end
        end
        unit.grid.unit = nil
        unit.grid = nil
    end
end

-- 求六边形网格中的距离格子数，不考虑单位的影响
function GridGraph:getDistance(unit, target)
    local dy = math.abs(unit.coordY - target.coordY) -- Y方向距离
    local dx = math.abs(unit.coordX - target.coordX) -- X方向距离，可能有半格
    return math.max(dy, dx + dy / 2) -- 沿Y方向移动每一格附带移动X方向半格
end

local function empty(grid)
    return not grid.unit and (grid.around or 0) == 0
end
--求unit到target的最短路径，路径上的格子不能有单位占据或附近有大体型单位，返回路径的第一步的格子
function GridGraph:getMoveInfo(unit, target)
    local start = self:findGrid(unit.coordX, unit.coordY)
    local goal = self:findGrid(target.coordX, target.coordY)
    if not start or not goal or start == goal then
        self:log('getMoveInfo bad', unit, target, start, goal)
        return nil
    end
    -- A* 算法核心实现
    local openSet = { [start] = true }
    local cameFrom = {}
    local gScore = { [start] = 0 }
    local fScore = {}
    -- 六边形距离启发函数
    local function heuristic(a, b)
        local y = a.coordY - b.coordY -- Y方向距离
        local x = a.coordX - b.coordX -- X方向距离，可能有半格
        local dy = math.abs(y) -- Y方向距离
        local dx = math.abs(x) -- X方向距离，可能有半格
        local dist = math.max(dy, dx + dy / 2) -- 沿Y方向移动每一格附带移动X方向半格
        return dist + dx * 0.001 + x * 0.0001 + y * 0.00001  -- 优先走X方向，优先向+X，优先向+Y
    end
    fScore[start] = heuristic(start, goal)
    while next(openSet) do
        -- 寻找最低f值的节点
        local current, minF
        for node in pairs(openSet) do
            if not minF or fScore[node] < minF then
                current = node
                minF = fScore[node]
            end
        end
        if current == goal then
            -- 直接回溯第一步
            local step = goal
            while step and cameFrom[step] do
                if cameFrom[step] == start then
                    return step  -- 找到起点后的第一个移动步骤
                end
                step = cameFrom[step]
            end
            return step -- 当路径只有一步时直接返回
        end
        openSet[current] = nil
        -- 遍历预存的邻居节点
        for _, neighbor in ipairs(current.neighbors) do
            -- 检查格子是否可用
            if empty(neighbor) or neighbor == goal then
                local tentativeG = gScore[current] + 1
                -- 发现更好路径
                if tentativeG < (gScore[neighbor] or math.huge) then
                    cameFrom[neighbor] = current
                    gScore[neighbor] = tentativeG
                    fScore[neighbor] = tentativeG + heuristic(neighbor, goal)
                    if not openSet[neighbor] then
                        openSet[neighbor] = true
                    end
                end
            end
        end
    end
    -- 寻找最低f值的节点
    -- fScore[start] = fScore[start] + 1.1 -- 降低起点权重
    local current, minF
    for node, f in pairs(fScore) do
        if not minF or f < minF then
            current = node
            minF = fScore[node]
        end
    end
    if current then
        -- 直接回溯第一步
        local step = current
        while step and cameFrom[step] do
            if cameFrom[step] == start then
                return step  -- 找到起点后的第一个移动步骤
            end
            step = cameFrom[step]
        end
        if step ~= start then
            return step
        end
    end
    self:log('getMoveInfo fail', start, goal)
    return nil
end

-- 找距离目标最近的一个未被任何单位占据或被unit占据的格子，如果有多个与目标距离相同的格子，默认取距离unit最远的一个
function GridGraph:getFlashInfo(unit, target, near)
    local start = self:findGrid(unit.coordX, unit.coordY)
    local goal = self:findGrid(target.coordX, target.coordY)
    if not start or not goal then return end

    local visited = { [goal] = true }
    local queue = { goal }
    local candidates = {}
    -- BFS逐层搜索
    while not next(candidates) and next(queue) do
        local levelSize = #queue
        for _ = 1, levelSize do
            local current = table.remove(queue, 1)
            for _, neighbor in ipairs(current.neighbors) do
                if not visited[neighbor] then
                    visited[neighbor] = true
                    table.insert(queue, neighbor)
                    if empty(neighbor) or neighbor == start then
                        table.insert(candidates, neighbor)
                    end
                end
            end
        end
    end
    -- 筛选最终结果
    local maxGrid = nil
    local maxDist = -1
    local minGrid = nil
    local minDist = 1000000
    for _, grid in ipairs(candidates) do
        local dist = self:getDistance(grid, start)
        if dist > maxDist then
            maxGrid = grid
            maxDist = dist
        end
        if dist < minDist then
            minGrid = grid
            minDist = dist
        end
    end
    return near and minGrid or maxGrid
end
function GridGraph:getPosInfo(pos)
    return self.pos[pos]
end

function GridGraph:getEmptyGridByLine(coordY, forward)
    local gridY = math.floor(coordY - self.origin.coordY)
    for stepY = 0, self.sizeY do
        local line = self.graph[(gridY+stepY)%self.sizeY+1]
        local from = forward > 0 and 1 or #line
        local to = #line - from + 1
        for x = from, to, forward do
            local grid = line[x]
            if empty(grid) then
                return grid
            end
        end
    end
    return nil
end
function GridGraph:log(...)
    self.logger:trace(...)
end

function GridGraph:toString()
    return 'graph'
end

local GridGraphMt = {__index = GridGraph, __tostring = GridGraph.toString}

local function newGridGraph(logger)
    local graph = setmetatable({}, GridGraphMt)
    graph.logger = logger:newLogger('GridGraph', graph)
    return graph
end
return newGridGraph