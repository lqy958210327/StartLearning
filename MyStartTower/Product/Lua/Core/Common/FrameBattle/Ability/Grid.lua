---@class Grid
---@classmod Grid
---@field coordX number 横坐标（正方向是屏幕右方向、蓝方单位初始前方向、红方单位初始后方向）
---@field coordY number 纵坐标（正方向是屏幕上方向、蓝方单位初始左方向、红方单位初始右方向）
---@field pos integer 格子编号（初始布阵用）
---@field unit Unit|nil 当前占据格子的单位

local GridMt = {
    __tostring = function (grid)
        return string.format('(%.1f,%.1f,%s)', grid.coordX, grid.coordY, grid.unit)
    end
}

local function newGrid(coordX, coordY, pos)
    return setmetatable({coordX = coordX, coordY = coordY, pos = pos}, GridMt)
end

return newGrid