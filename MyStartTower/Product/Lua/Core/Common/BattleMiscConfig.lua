local BattleMiscConfig = {}

-- 当前的战斗版本号 打patch或者hotfix才需要增加此版本号  不同版本号将导致无法播放回放
BattleMiscConfig.BATTLE_MODIFY_VERSION = 48

BattleMiscConfig.BATTLE_MISS_CD_FRAME = 5

BattleMiscConfig.SHIELD_MAX = 2130000000

BattleMiscConfig.BATTLE_LEVEL_DEF_LIMIT = {
    [1] = {100, 0.45},
    [2] = {150, 0.40},
    [3] = {200, 0.30},
    [4] = {999, 0.22},
}


-- PosToCoord 布阵Pos到坐标Coord的映射  CoordToPos  反向映射
-- LineNumConfig  每一行的数量   LineConfig  每一行的Pos    NebConfig  Pos对应的邻居Pos

BattleMiscConfig.NORMAL_POS_CONFIG = {
    ['LineConfig'] = {
            [1] = {   7,   4,   1,   -1,   -4,   -7},
            [2] = {8,   5,   2,   0,   -2,   -5,   -8},
            [3] = {   9,   6,   3,   -3,   -6,   -9},
    },
    -- LEN 定位最左下 9 号格的位置
    ['LR_LEN'] = 6,
    ['UD_LEN'] = 3,
    -- POS 相对于最左下 9 号格的位置
    ['DEFAULT_CHUYIN_POS'] = {1, 3.5},
    ['DEFAULT_PET_ANIM_POS'] = {2.5, 1},
}

BattleMiscConfig.SPE_BOSS_POS_CONFIG = {
    ['GridType'] = 1,
    ['LineConfig'] = {
            [1] = {   9,  4,  -13,  -4,   -9},
            [2] = {10,  5,   1,   -1,   -5,   -10},
            [3] = {   6,  2,   0,   -2,   -6},
            [4] = {11,  7,   3,   -3,   -7,   -11},
            [5] = {   12, 8,  -14,  -8,   -12},
    },
    -- LEN 定位最左下 12 号格的位置
    ['LR_LEN'] = 5,
    ['UD_LEN'] = 5,
    -- POS 相对于最左下 12 号格的位置
    ['DEFAULT_CHUYIN_POS'] = {1, 4.5},
    ['DEFAULT_PET_ANIM_POS'] = {2, 2},
}

BattleMiscConfig.ZOMBIE_POS_CONFIG = {
    ['GridType'] = 2,
    ['LineConfig'] = {
            [1] = {12,  11,  10, -16,  -10,  -11,  -12},
            [2] = {   7,   4,   1,   -1,   -4,   -7},
            [3] = {8,   5,   2,   0,   -2,   -5,   -8},
            [4] = {   9,   6,   3,   -3,   -6,   -9},
            [5] = {15,  14,  13, -17,  -13,  -14,  -15},
    },
    -- LEN 定位最左下 15 号格的位置
    ['LR_LEN'] = 7,
    ['UD_LEN'] = 5,
    ['oddShorter'] = true,
    -- POS 相对于最左下 15 号格的位置
    ['DEFAULT_CHUYIN_POS'] = {1.5, 4.5},
    ['DEFAULT_PET_ANIM_POS'] = {3, 2},
}

BattleMiscConfig.PERFORM_POS_CONFIG = {
    ['LineConfig'] = {
        [1] = {   7,   4,   1,   -1,   -4,   -7},
        [2] = {8,   5,   2,   0,   -2,   -5,   -8},
        [3] = {   9,   6,   3,   -3,   -6,   -9},
    },
    -- LEN 定位最左下 9 号格的位置
    ['LR_LEN'] = 6,
    ['UD_LEN'] = 3,
    -- 策划定义位置和真实坐标之间的关系
    --   9 6 3
    --  8 5 2 对称点
    --   7 4 1
    ['PosConfig'] = {
        [0] = {2.5, 1},
        [1] = {2, 0},[2] = {1.5, 1},[3] = {2, 2},
        [4] = {1, 0},[5] = {0.5, 1},[6] = {1, 2},
        [7] = {0, 0},[8] = {-0.5, 1},[9] = {0, 2},
    },
}

BattleMiscConfig.ONE_LINE_MAX = 100

local function AddToContainer(key, value, container)
    if container[key] then
        table.insert(container[key], value)
    else
        container[key] = {value}
    end
end

local function _initPosConfig(gridConfig)
    gridConfig.LineNumConfig = {}
    gridConfig.PosToCoord = {}
    gridConfig.CoordToPos = {}                -- 11 = 1
    for lineNum, lineConf in ipairs(gridConfig.LineConfig) do
        gridConfig.LineNumConfig[lineNum] = #lineConf
        local coordStart = lineNum * BattleMiscConfig.ONE_LINE_MAX
        for index, pos in ipairs(lineConf) do
            gridConfig.CoordToPos[coordStart + index] = pos
            gridConfig.PosToCoord[pos] = coordStart + index
        end
    end
    gridConfig.NebConfig = {}
    gridConfig.PosToCoordXY = {}
    local lineNumConfig = gridConfig.LineNumConfig
    local eventStartX = -0.5
    if lineNumConfig[1] > lineNumConfig[2] then
        eventStartX = 0.5
    end
    local totalLine = #lineNumConfig
    for lineNum, gridNum in ipairs(lineNumConfig) do
        local upType = nil
        local upStart = lineNum * BattleMiscConfig.ONE_LINE_MAX + BattleMiscConfig.ONE_LINE_MAX
        if lineNum < totalLine then     -- 上方互加
            if gridNum > lineNumConfig[lineNum + 1] then        -- 当前行比较"长"   左上不一定存在
                upType = 1
            else
                upType = 2
            end
        end
        local coordY = lineNum - 1
        local coordXStart = 0
        if lineNum%2 == 0 then      -- 偶数行的起点不太对
            coordXStart = eventStartX
        end
        for index = 1, gridNum do
            local coord = lineNum*BattleMiscConfig.ONE_LINE_MAX+index
            local pos = gridConfig.CoordToPos[coord]
            gridConfig.PosToCoordXY[pos] = {coordXStart + index - 1, coordY}
            if index < gridNum then     -- 右方互加
                AddToContainer(pos, gridConfig.CoordToPos[coord+1], gridConfig.NebConfig)
                AddToContainer(gridConfig.CoordToPos[coord+1], pos, gridConfig.NebConfig)
            end
            if upType then
                if gridConfig.CoordToPos[upStart+index] then
                    AddToContainer(pos, gridConfig.CoordToPos[upStart+index], gridConfig.NebConfig)
                    AddToContainer(gridConfig.CoordToPos[upStart+index], pos, gridConfig.NebConfig)
                end
                if upType == 2 then
                    AddToContainer(pos, gridConfig.CoordToPos[upStart+index+1], gridConfig.NebConfig)
                    AddToContainer(gridConfig.CoordToPos[upStart+index+1], pos, gridConfig.NebConfig)
                elseif index > 1 then
                    AddToContainer(pos, gridConfig.CoordToPos[upStart+index-1], gridConfig.NebConfig)
                    AddToContainer(gridConfig.CoordToPos[upStart+index-1], pos, gridConfig.NebConfig)
                end
            end
        end
    end
end

_initPosConfig(BattleMiscConfig.NORMAL_POS_CONFIG)
_initPosConfig(BattleMiscConfig.SPE_BOSS_POS_CONFIG)
_initPosConfig(BattleMiscConfig.ZOMBIE_POS_CONFIG)

return BattleMiscConfig