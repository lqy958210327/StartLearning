local ResScene = DataTable.ResScene
local ResBattleConfig = DataTable.ResBattleConfig
local BattleMiscConfig = require "Core/Common/BattleMiscConfig"

local strClassName = "GridTrans"
local GridTrans = Class(strClassName)
-- 构造函数。
function GridTrans:ctor(mgr,battleNo,sceneNo)
    self.mgr = mgr

    local matrix_type = ResBattleConfig[battleNo].matrix_type

    if matrix_type == 2 then
        -- 植物大战僵尸模式
        self.GridConfig = BattleMiscConfig.ZOMBIE_POS_CONFIG
        self.oddShorter = true           -- 特殊的奇数行更长
    elseif matrix_type == 1 then
        -- 五行BOSS模式
        self.GridConfig = BattleMiscConfig.SPE_BOSS_POS_CONFIG
    else
        -- 普通模式
        self.GridConfig = BattleMiscConfig.NORMAL_POS_CONFIG
    end

    self.LR_LEN = self.GridConfig.LR_LEN            -- grid的左右size
    self.UD_LEN = self.GridConfig.UD_LEN            -- grid的上下size

    local sceneInfo = ResScene[sceneNo]
    if sceneInfo and sceneInfo.chuyin_pos then
        self.CHUYIN_POS = sceneInfo.chuyin_pos
    else
        self.CHUYIN_POS = self.GridConfig.DEFAULT_CHUYIN_POS
    end
    if sceneInfo and sceneInfo.pet_skill_pos then
        self.PET_INIT_POS = sceneInfo.pet_skill_pos
    else
        self.PET_INIT_POS = self.GridConfig.DEFAULT_PET_ANIM_POS
    end
    -- Combat
    self.max_lr = self.LR_LEN - 0.5
    self.min_lr = -0.5
    self.max_ud = self.UD_LEN - 1
    self.min_ud = 0

    self.POS_CONFIG = self.GridConfig.PosToCoordXY
end

local GRID_SIZE = BattleConst.GRID_SIZE

local function IS_RIGHT(actor)
    return actor.camp ~= BattleConst.CAMP_PLAYER
end

-----------------------------------CombatUnitMgr-----------------------------

function GridTrans:_getCoordByPos(pos, isRight)
    if self.GridConfig.GridType == 1 or self.GridConfig.GridType == 2 then
        -- 五行模式下  有特殊的-13 -14 所以没法用对称去求
        -- 植物大战僵尸模式 也扩充了-16 -17 所以也没法用对称去求
        if isRight then
            pos = -pos
        end
        local posInfo = self.POS_CONFIG[pos] or self.POS_CONFIG[0]
        return posInfo[1], posInfo[2]
    else
        -- 正常模式下  尽量用对称去求  因为此时左右长度可能被拉长了
        local posInfo = self.POS_CONFIG[pos] or self.POS_CONFIG[0]
        local orderX = posInfo[1]
        local orderY = posInfo[2]
        if isRight then
            orderX = self.LR_LEN - 1 - orderX
        end
        return orderX, orderY
    end
end

function GridTrans:setCoord(actorInfo)
    -- 在右方 （开启镜像）
    actorInfo.coordR = IS_RIGHT(actorInfo) -- 初始在右边需要镜像
    local orderX, orderY = self:_getCoordByPos(actorInfo.pos, actorInfo.coordR)
    -- 左右网格位置
    actorInfo.coordX = orderX        -- 当前X位置 相对坐标
    actorInfo.coordY = orderY        -- 当前Y位置 相对位置
end

function GridTrans:setShowCoord(combatUnit)
    combatUnit.showCoordX = self.CHUYIN_POS[1]
    combatUnit.showCoordY = self.CHUYIN_POS[2]
end

local function _getDist(coordX, coordY, targetCoordX, targetCoordY)
    local xDist = math.abs(targetCoordX - coordX)
    local yDist = math.abs(targetCoordY - coordY)
    if yDist * 0.5 <= xDist then
        -- 左右较远 此时路径是 先左右顺便上下移动到y位置 再向左右平移 上下每走两步  左右需要多走一次
        return math.floor(xDist + yDist * 0.5), yDist
    else
        -- 否则都是直接左上/右上可直达区域
        return yDist, yDist
    end
end

local function _getTargetDist(actor, target,ignoreBig)
    local xDist = math.abs(target.coordX - actor.coordX)
    local yDist = math.abs(target.coordY - actor.coordY)
    local xyDist = nil
    if yDist * 0.5 <= xDist then
        -- 左右较远 此时路径是 先左右顺便上下移动到y位置 再向左右平移 上下每走两步  左右需要多走一次
        xyDist = math.floor(xDist + yDist * 0.5)
    else
        -- 否则都是直接左上/右上可直达区域
        xyDist = yDist
    end

    if target.bigMonster then
        if ignoreBig then
            yDist = math.max(0, yDist - 0.5)
        else
            yDist = math.max(0, yDist - 1)
            xyDist = xyDist - 1
        end
    end
    return xyDist , yDist
end

GridTrans._getTargetDist = _getTargetDist

function GridTrans:_coordOutOfRange(coordX, coordY)
    return coordX < self.min_lr or coordX > self.max_lr or coordY < self.min_ud or coordY > self.max_ud
end

-- 得到位置是否有活着的单位 返回false没有   返回nil位置非法  返回obj有人
function GridTrans:_getObject(coordX, coordY)
    if self:_coordOutOfRange(coordX,coordY) then
        return nil
    end
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        local dist = _getDist(coordX, coordY, obj.coordX, obj.coordY)
        if (dist == 0 or (obj.bigMonster and dist <= 1)) then
            return obj
        end
    end
    return false
end

function GridTrans:_getObjectByPos(pos, isRight)
    local coordX, coordY = self:_getCoordByPos(pos, isRight)
    return self:_getObject(coordX, coordY)
end

function GridTrans:_getOneLineEmptyPos(nowLine,isRight)
    local nowLineConfig = self.GridConfig.LineConfig[nowLine]
    if nowLineConfig then
        local nowLineAllNum = #nowLineConfig
        local nowLineHalfNum = math.floor(nowLineAllNum / 2)
        local emptyIndex = nil
        for index = 1, nowLineHalfNum do
            local obj = self:_getObjectByPos(nowLineConfig[index], isRight)
            if obj == false then
                emptyIndex = index
            elseif obj and obj:attackNear() then
                break
            end
        end
        return nowLineConfig[emptyIndex]
    end
end

-- 得到空位  按照从边缘到中心 找到最前空格的规则
function GridTrans:getEmptyPos(object, priorLine, target)
    if priorLine >= 10 then
        priorLine = priorLine - 10
        if target then
            object = target
        end
    end
    if not priorLine or priorLine == 0 then
        -- 当前行
        priorLine = object.realCoordY + 1
    elseif priorLine == 1 or priorLine == 2 then
        -- 1 2 下一 下二 不用改
    elseif priorLine == 3 then
        -- 3 上一
        priorLine = #self.GridConfig.LineConfig
    elseif priorLine == 4 then
        -- 4 上二
        priorLine = #self.GridConfig.LineConfig - 1
    elseif priorLine == 5 then
        -- 5 中间
        priorLine = math.floor(#self.GridConfig.LineConfig / 2) + 1
    elseif priorLine == 6 then
        -- 6 当前 master的pos
        return object.pos
    end

    local isRight = IS_RIGHT(object)
    local nowResult = self:_getOneLineEmptyPos(priorLine, isRight)
    if nowResult then
        return nowResult
    end
    for index = 1, #self.GridConfig.LineConfig - 1 do
        local upResult = self:_getOneLineEmptyPos(priorLine + index, isRight)
        if upResult then
            return upResult
        end
        local downResult = self:_getOneLineEmptyPos(priorLine - index, isRight)
        if downResult then
            return downResult
        end
    end
end

function GridTrans:getRebornCoord(target)
    local rebornCoordX = nil
    local rebornCoordY = nil
    if not self:_getObject(target.realCoordX, target.realCoordY) then
        rebornCoordX = target.realCoordX
        rebornCoordY = target.realCoordY
    else
        local pos = self:getEmptyPos(target)
        if pos and self.POS_CONFIG[pos] then
            rebornCoordX, rebornCoordY = self:_getCoordByPos(pos, IS_RIGHT(target))
        end
    end

    return rebornCoordX, rebornCoordY
end

function GridTrans:getTrapCoord(trapPos)
    local isRight = false
    if trapPos < 0 then
        trapPos = -trapPos
        isRight = true
    end
    local coordX, coordY = self:_getCoordByPos(trapPos, isRight)
    return coordX, coordY
end

-- 获取一行中的空位 从己方后位向前查找 包含敌方区域 忽略近战检测
function GridTrans:_getOneLineAnyEmptyPos(nowLine, isRight)
    local nowLineConfig = self.GridConfig.LineConfig[nowLine]
    if nowLineConfig then
        local start, stop, step = 1, #nowLineConfig, 1
        if isRight then
            start, stop, step = #nowLineConfig, 1, -1
        end
        for index = start, stop, step do
            local pos = nowLineConfig[index]
            local obj = self:_getObjectByPos(pos, false)
            if obj == false then
                -- 点位转换修正
                if isRight then
                    pos = -pos
                end
                return pos
            end
        end
    end
end

-- 多波刷怪 如果位置被占用 尝试获取新的空位
function GridTrans:checkPos(actorInfo)
    local isRight = IS_RIGHT(actorInfo)
    local orderX, orderY = self:_getCoordByPos(actorInfo.pos, isRight)
    if not self:_getObject(orderX, orderY) then
        return
    end
    -- 优先当前行查找
    local priorLine = orderY + 1
    local newPos = self:_getOneLineAnyEmptyPos(priorLine, isRight)
    if not newPos then
        for index = 1, #self.GridConfig.LineConfig - 1 do
            newPos = self:_getOneLineAnyEmptyPos(priorLine + index, isRight)
            if newPos then
                break
            end
            newPos = self:_getOneLineAnyEmptyPos(priorLine - index, isRight)
            if newPos then
                break
            end
        end
    end
    -- 找到空位 则修改到对应位置
    if newPos then
        actorInfo.pos = newPos
    end
    -- 如果没找到 只好重叠显示
end

-----------------------------------CombatUnit-----------------------------

local function _isCloserTarget(needDist, objDist, yDist, minY, minDist, target, obj)
    if objDist <= needDist then
        if not target then
            -- 没有目标
            return true
        end
        if objDist < minDist then
            -- 距离更近
            return true
        end
        if objDist == minDist then
            if yDist < minY then
                -- 行数更近
                return true
            end
            if yDist == minY then
                if target.coordY <= obj.coordY then
                    -- 行数更靠上
                    return true
                end
            end
        end
    end
end

function GridTrans:getNearestEnemy(actor,needDist,ignoreBig)
    needDist = needDist or 9999

    local target
    local minY
    local minDist
    -- 第一次check  同行敌对目标
    for index, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        if obj.camp ~= actor.attackCamp and obj.hp > 0 and obj ~= actor then
            local objDist, yDist = _getTargetDist(actor, obj, ignoreBig)
            if _isCloserTarget(needDist, objDist, yDist, minY, minDist, target, obj) then
                target = obj
                minY = yDist
                minDist = objDist
            end
        end
    end
    return target
end

function GridTrans:isNeededTarget(actor, target, needDist,ignoreBig)
    needDist = needDist or 9999
    if target.camp ~= actor.attackCamp and target.hp > 0 and target ~= actor then
        local targetDist = _getTargetDist(actor, target, ignoreBig)
        return targetDist <= needDist
    end
end

function GridTrans:outAttackDist(actor, target,ignoreBig)
    local targetDist = _getTargetDist(actor,target,ignoreBig)
    return targetDist > actor.attackDist
end

-- 只向前移动
function GridTrans:getForwardInfo(actor,target)
    local forwardX = actor.coordX<target.coordX and 1 or -1
    if math.abs(actor.coordX - target.coordX) <= 1 then
        -- 已经很近了 此时不动了
        return nil
    else
        -- 僵尸只会往前
        if self:_getObject(actor.coordX + forwardX, actor.coordY) == false then
            return {actor.coordX + forwardX, actor.coordY}
        else
            return nil
        end
    end
end

function GridTrans:checkHitedBack(actor, hitedFlag, attacker)
    local back = true
    if self:_getObject(actor.movePreX, actor.movePreY) then
        back = false
    elseif hitedFlag == "stun" and attacker and attacker.coordX and attacker.coordY then
        -- 眩晕受击时根据方向决定受击 -- 有可能是陷阱
        if actor.movePreY == actor.coordY then
            if attacker.coordX == actor.movePreX then
                back = false
            elseif attacker.coordX > actor.movePreX then
                if actor.coordX < actor.movePreX then
                    back = false
                end
            else
                if actor.coordX > actor.movePreX then
                    back = false
                end
            end
        else
            if attacker.coordY == actor.movePreY then
                back = false
            elseif attacker.coordY > actor.movePreY then
                if actor.coordY < actor.movePreY then
                    back = false
                end
            else
                if actor.coordY > actor.movePreY then
                    back = false
                end
            end
        end
    else
        -- 其他时候保持原位置  看一看当前离哪个更近
        if actor.realCoordX == actor.coordX and actor.realCoordY == actor.coordY then
            back = false
        end
    end

    return back
end

-----------------------------------AttackCalc-----------------------------

function GridTrans:getObjectReal(coordX, coordY)
    if self:_coordOutOfRange(coordX,coordY) then
        return nil
    end
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        local dist = _getDist(coordX, coordY, obj.realCoordX, obj.realCoordY)
        if dist == 0 or (obj.bigMonster and dist <= 1) then
            return obj
        end
    end
    return false
end

function GridTrans:nearIsEmpty(target, isFriend)
    if target and target.outOfPos then
        return true
    end
    local nearDist = 1
    local camp = target.camp
    if not isFriend then
        camp = camp == BattleConst.CAMP_PLAYER and BattleConst.CAMP_ENEMY or BattleConst.CAMP_PLAYER
    end
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        if obj ~= target then
            if camp == obj.camp then
                local dist = _getDist(target.coordX, target.coordY, obj.realCoordX, obj.realCoordY)
                if dist <= nearDist or (obj.bigMonster and dist <= (nearDist + 1)) then
                    return false
                end
            end
        end
    end
    return true
end

function GridTrans:getObjectOfNear(container, coordX, coordY, camp, isBigger, nearDist)
    nearDist = nearDist or 1
    if isBigger then
        nearDist = nearDist + 1
    end
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        if not camp or camp == obj.camp then
            local dist = _getDist(coordX, coordY, obj.realCoordX, obj.realCoordY)
            if dist <= nearDist or (obj.bigMonster and dist <= (nearDist + 1)) then
                container[objId] = obj
            end
        end
    end
end

function GridTrans:getObjectByCoordY(container, coordY, camp)
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        if not coordY or obj.realCoordY == coordY or (obj.bigMonster and math.abs(obj.realCoordY - coordY) <= 1) then
            if not camp or obj.camp == camp then
                container[objId] = obj
            end
        end
    end
end

function GridTrans:getObjectByCoordX(container, coordX, camp, excludeSummon, includeOutOfPos)
    if includeOutOfPos then
        for _, unitContainer in ipairs(self.mgr.tickAllUnits) do
            for _, objId in ipairs(unitContainer) do
                local obj = self.mgr.objects[objId]
                if not coordX or obj.realCoordX == coordX then
                    if not camp or obj.camp == camp then
                        if not (excludeSummon and obj.master) then
                            container[objId] = obj
                        end
                    end
                end
            end
        end
    else
        for _, objId in ipairs(self.mgr.orderObjects) do
            local obj = self.mgr.objects[objId]
            if not coordX or obj.realCoordX == coordX then
                if not camp or obj.camp == camp then
                    if not (excludeSummon and obj.master) then
                        container[objId] = obj
                    end
                end
            end
        end
    end
end

function GridTrans:getObjectOfCoordNearest(container, coordX, coordY, camp, mirror)
    if mirror then
        coordX = self.LR_LEN - 1 - coordX
    end
    local needDist = 9999
    local target
    local minY
    local minDist
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        if not camp or camp == obj.camp then
            local objDist, yDist = _getDist(coordX, coordY, obj.realCoordX, obj.realCoordY)
            if _isCloserTarget(needDist, objDist, yDist, minY, minDist, target, obj) then
                target = obj
                minY = yDist
                minDist = objDist
            end
        end
    end
    if target then
        container[target.id] = target
    end
end

-- 得到某阵营某一行最后排的那个角色
function GridTrans:getObjectOfFarest(container, coordY, camp, excludeSummon)
    local farObj = nil
    local coordX = nil
    local farCoordY = nil
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        if camp == obj.camp and (not (excludeSummon and obj.master)) and (coordY == nil or obj.realCoordY == coordY or (obj.bigMonster and math.abs(obj.realCoordY-coordY)<=1)) then
            if camp == BattleConst.CAMP_PLAYER and (coordX == nil or obj.realCoordX < coordX) then
                farObj = obj
                coordX = obj.realCoordX
                farCoordY = obj.realCoordY
            elseif camp == BattleConst.CAMP_ENEMY and (coordX == nil or obj.realCoordX > coordX) then
                farObj = obj
                coordX = obj.realCoordX
                farCoordY = obj.realCoordY
            elseif coordY == nil and coordX and obj.realCoordX == coordX then
                local objAbsY = math.abs(obj.realCoordY - 2)
                local farAbsY = math.abs(farCoordY - 2)
                if objAbsY > farAbsY or (objAbsY == farAbsY and obj.realCoordY > farCoordY) then
                    farObj = obj
                    coordX = obj.realCoordX
                    farCoordY = obj.realCoordY
                end
            end
        end
    end
    if farObj then
        container[farObj.id] = farObj
    end
end

-- 得到某行阵营的前排/后排
function GridTrans:getObjectOfLine(container, coordY, camp, isFront)
    local searchMin = true
    if camp == BattleConst.CAMP_PLAYER and isFront then
        searchMin = false
    elseif camp == BattleConst.CAMP_ENEMY and not isFront then
        searchMin = false
    end
    local lineRecords = {}
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        if not camp or camp == obj.camp then
            local adjustY = nil
            if not coordY or coordY == obj.realCoordY then
                adjustY = obj.realCoordY
            elseif coordY and obj.isBigger then
                adjustY = coordY
            end
            if adjustY then
                if not lineRecords[adjustY] then
                    lineRecords[adjustY] = { obj.realCoordX, obj }
                elseif searchMin and obj.realCoordX < lineRecords[adjustY][1] then
                    lineRecords[adjustY] = { obj.realCoordX, obj }
                elseif not searchMin and obj.realCoordX > lineRecords[adjustY][1] then
                    lineRecords[adjustY] = { obj.realCoordX, obj }
                end
            end
        end
    end
    for lineNum, lineInfo in pairs(lineRecords) do
        container[lineInfo[2].id] = lineInfo[2]
    end
end

function GridTrans:getObjectOfLineMiddle(container, coordY, camp)
    local lineRecords = {}
    for _, objId in ipairs(self.mgr.orderObjects) do
        local obj = self.mgr.objects[objId]
        if not camp or camp == obj.camp then
            local adjustY = nil
            if not coordY or coordY == obj.realCoordY then
                adjustY = obj.realCoordY
            elseif coordY and obj.isBigger then
                adjustY = coordY
            end
            if adjustY then
                if not lineRecords[adjustY] then
                    lineRecords[adjustY] = { obj.realCoordX, obj, obj.realCoordX, obj, obj }
                else
                    local line = lineRecords[adjustY]
                    if obj.realCoordX < line[1] then
                        line[1] = obj.realCoordX
                        line[2] = obj
                    elseif obj.realCoordX > line[3] then
                        line[3] = obj.realCoordX
                        line[4] = obj
                    end
                    table.insert(lineRecords, obj)
                end
            end
        end
    end
    for lineNum, lineInfo in pairs(lineRecords) do
        for i = 5, #lineInfo do
            local obj = lineInfo[i]
            if obj ~= lineInfo[2] and obj ~= lineInfo[4] then
                container[obj.id] = obj
            end
        end
    end
end

-----------------------------------BattleActorMgr-----------------------------

function GridTrans:extendBattleInfo(sceneTrans)
    self.leftDir = sceneTrans.leftDir
    self.upDir = sceneTrans.upDir
    self.gridAngle = sceneTrans.gridAngle

    -- 最左下0 0格子的坐标计算
    local lrSub = GRID_SIZE * (self.LR_LEN - 1) / 2
    local udSub = GRID_SIZE * 0.866 * (self.UD_LEN - 1) / 2

    self.gridUpDir = self.upDir * 0.866 * GRID_SIZE
    self.gridLeftDir = self.leftDir * GRID_SIZE

    self.centerPosition = sceneTrans:getCenterPointPos()
    self.oriPosition = self.centerPosition - self.leftDir * lrSub - self.upDir * udSub
end

function GridTrans:getPosition(orderX, orderY)
    return self.gridLeftDir * orderX + self.oriPosition + self.gridUpDir * orderY
end

function GridTrans:getOutPosition(actor)
    local outPosX = self.CHUYIN_POS[1]
    local outPosY = self.CHUYIN_POS[2]
    if IS_RIGHT(actor) then
        outPosX = self.LR_LEN - 1 - outPosX
    end
    local pos = self:getPosition(outPosX, outPosY)
    if self.CHUYIN_POS[3] then
        pos.y = pos.y + self.CHUYIN_POS[3]
    end
    return pos
end

function GridTrans:getPetInitPosition(camp)
    local outPosX = self.PET_INIT_POS[1]
    local outPosY = self.PET_INIT_POS[2]
    if camp ~= BattleConst.CAMP_PLAYER then
        outPosX = self.LR_LEN - 1 - outPosX
    end
    local pos = self:getPosition(outPosX, outPosY)
    if self.PET_INIT_POS[3] then
        pos.y = pos.y + self.PET_INIT_POS[3]
    end
    return pos
end

-----------------------------------BattleActor-----------------------------

function GridTrans:lookAtForward(actor, isRight)
    if nil == isRight then
        isRight = IS_RIGHT(actor)
    end

    local movementAux = actor.movementAux
    if movementAux == nil then
        return
    end

    local actorPos = actor:getPosition()
    if isRight then
        actorPos = actorPos - self.leftDir
    else
        actorPos = actorPos + self.leftDir
    end

    movementAux:FaceTo(actorPos)
end

function GridTrans:getVector(actor,target,dist)
    local actorPos = actor:getPosition()
    local targetPos = target:getPosition()

    if actor.coordR then
        targetPos = targetPos - self.leftDir * dist
    else
        targetPos = targetPos + self.leftDir * dist
    end

    return targetPos - actorPos
end

function GridTrans:getFixedAngle(eulerAngles)
    return self.gridAngle - 90 - eulerAngles.y
end

-----------------------------------PerformActorMgr-----------------------------

local function _getNodePosition(nodeName)
    local node = UnityEngine.GameObject.Find(nodeName)
    if node then
        return node.transform.position
    end
end

function GridTrans:extendPerformInfo(start_node,battle_node,end_node)
    local startPos = _getNodePosition(start_node)
    local battlePos = _getNodePosition(battle_node)
    local endPos = _getNodePosition(end_node)

    if not startPos or not battlePos then
        self.performInfo = nil
        return
    end

    self.GridConfig = BattleMiscConfig.PERFORM_POS_CONFIG
    self.LR_LEN = self.GridConfig.LR_LEN            -- grid的左右size
    self.UD_LEN = self.GridConfig.UD_LEN            -- grid的上下size
    self.posConfig = self.GridConfig.PosConfig

    -- Perform
    local dir = battlePos - startPos
    local len = dir:Magnitude()
    local runTime = len/BattleConst.ACTOR_SPEED
    dir:SetNormalize()
    self.leftDir = dir
    self.upDir = Vector3(-dir.z, 0, dir.x)
    local lrSub =  GRID_SIZE * (self.LR_LEN-1)/2
    local udSub = GRID_SIZE * 0.866 * (self.UD_LEN-1)/2
    self.gridUpDir = self.upDir * 0.866 * GRID_SIZE
    self.gridLeftDir = self.leftDir * GRID_SIZE
    self.oriPosition = battlePos - self.leftDir * lrSub - self.upDir * udSub

    self.performInfo = {
        [1] = startPos,
        [2] = battlePos,
        [3] = endPos,
        runTime = runTime,
    }
end

local function _getPositionByBattleCoord(dir, centerPosition, coordX, coordY)
    local leftDir = dir * GRID_SIZE
    local upDir = Vector3(-dir.z, 0, dir.x) * GRID_SIZE * 0.866
    local newOffset = -leftDir*(self.LR_LEN-1)/2 - upDir* (self.UD_LEN-1)/2
    return leftDir * coordX + centerPosition + newOffset + upDir * coordY
end

local function _getPositionByBattlePos(dir, centerPosition, battlePos, camp)
    local pos = self.posConfig[battlePos] or self.posConfig[0]
    local orderX = pos[1]
    local orderY = pos[2]
    if camp == BattleConst.CAMP_ENEMY then
        orderX = self.LR_LEN - 1 - orderX
    end
    return _getPositionByBattleCoord(dir, centerPosition, orderX, orderY)
end

function GridTrans:getPerformPosition(actor,node)
    return _getPositionByBattlePos(self.leftDir, self.performInfo[node], actor.pos, actor.camp)
end

return GridTrans