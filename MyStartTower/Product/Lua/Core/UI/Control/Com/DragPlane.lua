local UIUtils = Framework.UI.UIUtils
local DragObject = require "Core/UI/Control/Com/DragObject"


local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local ResBattleTrap = DataTable.ResBattleTrap
local BattleMiscConfig = require "Core/Common/BattleMiscConfig"

local GRID_NONE = 0     -- 无效果
local GRID_RED = 1      -- 伤害
local GRID_GREEN = 2    -- 治疗

local __isExistSkillArea = false
local __caTarget = nil ---@type DragObject

local DragPlane = {}

local self = DragPlane
function DragPlane.start(centerGo, playerEnterState, battleConfig)
    if battleConfig.matrix_type == 1 then
        self._plane = UIUtils.InitDragField(centerGo, "Prefab/Other/BattlePlane2.prefab")        -- 五行模式
        self.GridConfig = BattleMiscConfig.SPE_BOSS_POS_CONFIG
        BattleConst.BATTLE_MAX_POS = 12
        UIUtils.SetDragFieldBound(5, -4, 6.5, -7)
    else
        self.GridConfig = BattleMiscConfig.NORMAL_POS_CONFIG
        self._plane = UIUtils.InitDragField(centerGo, "Prefab/Other/BattlePlane.prefab")         -- 九宫格
        BattleConst.BATTLE_MAX_POS = 9
        UIUtils.SetDragFieldBound(4, -3, 6.5, -7)
    end

    ---@type table<number, DragObject>  位置：对象
    self.fieldObjs = {} --pos:dragObj

    self._focusObj = nil
    self.ready = false
    self.inRunning = true

    self.LockAllGrid(true)
    if playerEnterState and playerEnterState[1] then
        self.playerEnterState = playerEnterState[1]
    else
        self.playerEnterState = nil
    end
    Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.FormationClickObjectActionType, DragPlaneClickObjectActionType.ShowTips)
    self.DISABLE_DELETE = nil
    local cfg = DataTable.ResFormation[battleConfig.formation_id]
    self.MAX_PUT_COUNT = cfg.num_limit or BattleConst.FORMATION_DEFAULT_NUM
    self.setTeamLimitCheck(nil)
    self:_checkBattleConfig(battleConfig)
end

function DragPlane.setTeamLimitCheck(teamLimitCheck)
    self.teamLimitCheck = teamLimitCheck
    if self.teamLimitCheck then
        self.limitNoTeamNumber = self.teamLimitCheck.noTeamNumber
    else
        self.limitNoTeamNumber = 0
    end
end

-- start之后 加载模型 但是不加载logo和操作   等ready接口后才进入正常模式
function DragPlane.onReady()
    self.ready = true
    for pos, obj in pairs(self.fieldObjs) do
        obj:onReady()
        obj:checkStartCue(self.playerEnterState)
    end
    for pos = 1, BattleConst.BATTLE_MAX_POS do
        if self.fieldObjs[pos] and self.fieldObjs[pos]:IsMonster() then
            self.LockGrid(pos, true)
        else
            self.LockGrid(pos, false)
        end
    end

end

function DragPlane.stop()
    if not self._plane then
        return
    end
    if not self.inRunning then
        return
    end
    self:clearTrap()
    self.inRunning = false
    for pos, obj in pairs(self.fieldObjs) do
        obj:destroy()
    end 
    self.fieldObjs = {}

    self._clearSkillArea()

    UIUtils.StopDragField()
    self.playerEnterState = nil
    self._plane = nil
end

---@param clearType number ： nil全部清理  1清理己方 2清理敌方
function DragPlane.clearObject(clearType)
    for pos, obj in pairs(self.fieldObjs) do
        local clear = false
        clear = (clearType == nil) or (clearType == 1 and pos > 0) or (clearType == 2 and pos < 0)
        if clear then
            self._plane:ShowGridSupportHint(obj.did, 0, {})
            obj:destroy()
            self.fieldObjs[pos] = nil
        end
    end

    self._clearSkillArea()

end



function DragPlane.addDragObj(heroGid, heroConfigId, monsterConfigId, pos, camp, lv, star, isShowHp, hp, mp)
    if pos == nil or self.GridConfig.PosToCoord[pos] then
        ---@type DragObject
        local obj = DragObject(self, heroGid, heroConfigId, monsterConfigId, pos, camp, lv, star, isShowHp, hp, mp)
        if heroGid then
            obj.mEventDragPut = self.onDragPut
            obj.mEventDragEnter = self.onDragEnter
            obj.mEventDragLeave = self.onDragLeave
            obj.mEventDragCatch = self.onDragCatch
        else
            if pos > 0 then
                self.LockGrid(pos, true)
            end
        end


        obj.mEventDragClick = self.onDragClick
        --拖拽显示英雄技能范围
        obj.mEventDragShowSkillArea = self.onDragShowSkillArea
        if self.ready then
            obj:onReady()
        end
        if pos then
            self.fieldObjs[pos] = obj
            self.showSupport(obj, pos, true)
        end
        return obj
    end
end

function DragPlane.LockGrid(pos, isLock)
    if pos then
        if isLock then
            self._plane:LockGrid(1, pos)
        else
            self._plane:LockGrid(0, pos)
        end
    end
end

function DragPlane.LockAllGrid(isLock)
    for pos = 1, BattleConst.BATTLE_MAX_POS do
        if isLock then
            self._plane:LockGrid(1, pos)
        else
            self._plane:LockGrid(0, pos)
        end
    end
end

function DragPlane.ShowGuideEffect(pos, isShow)
    if pos then
        isShow = isShow or false
        self._plane:ShowGridGuideHit(pos, isShow)
    end
end

function DragPlane.GetGridPos(pos)
    if pos then
        return self._plane:GetGridPos(pos)
    end
end







-- 初始化战斗配置相关的内容
function DragPlane:_checkBattleConfig(battleConfig)
    self.battleConfig = battleConfig

    if battleConfig.traps then
        for index = 0, BattleConst.BATTLE_MAX_TRAP_INIT_NUM do
            local trapId = battleConfig.traps[index * 2 + 1]
            local trapPos = battleConfig.traps[index * 2 + 2]
            if trapId and trapPos then
                self:addTrap(trapId, trapPos)
            else
                break
            end
        end
    end

end



-- 陷阱初始化增加
function DragPlane:addTrap(trapId, trapPos)
    local trapData = ResBattleTrap[trapId]
    if trapData and trapData.effect then

    end
end

function DragPlane:clearTrap()


end

-- 向服务端请求开始战斗  此时隐藏全部玩家的血条
function DragPlane.onBattleStart()
    for pos, obj in pairs(self.fieldObjs) do
        obj:onBattleStart()
    end
end

function DragPlane.delDragObj(dragObj, tgtPos)
    for pos, obj in pairs(self.fieldObjs) do
        if obj == dragObj then
            self.fieldObjs[pos] = nil
            AudioCueMediator.playUISfx("Audios/sfx/ui/UI_Pitch_Into_The_Work.ogg")
            break
        end
    end
    self.onDragLeave(dragObj, tgtPos)
    dragObj:destroy()
end

function DragPlane.showSupport(targetObj, tgtPos, isShow)
    local tempPos = tgtPos
    if not isShow then
        tempPos = nil
    end
    for pos, obj in pairs(self.fieldObjs) do
        if pos > 0 and obj:IsPlayer() and obj:IsHero() then
            if obj ~= targetObj then
                self.updateSupport(obj, pos, targetObj, tempPos)
            end
        end
    end
    self.updateSupport(targetObj, tgtPos, targetObj, nil, isShow)
end





-- 得到支援英雄影响的范围
function DragPlane._getSupportPos(dragObj, pos)
    return {},0
end

--dragingPos 拖拽中的pos
function DragPlane.updateSupport(obj, pos, dragingObj, dragingPos, isEnter)
    local objSuptPoses, maxNum = DragPlane._getSupportPos(obj, pos)
    if maxNum <= 0 then
        return
    end


    if obj == dragingObj then
        local gridInfo = isEnter and pos or 0
        local supportAll = maxNum == BattleConst.BATTLE_MAX_POS
        local supportInfos = (isEnter and not supportAll) and objSuptPoses or {}
        self._plane:ShowGridSupportHint(obj.did, gridInfo, supportAll, supportInfos)
    end
end

function DragPlane.getObjectCount(campFlag, exceptObj)
    local fieldCount = 0
    for pos, obj in pairs(self.fieldObjs) do
        if ((campFlag == nil and pos > 0 and obj:IsPlayer() and obj:IsHero()) or--我方阵营
            (campFlag == 1 and pos < 0) or--地方阵营
            campFlag == 2) and --全部
            obj ~= exceptObj then --不包含包含
            fieldCount = fieldCount + 1
        end
    end
    return fieldCount
end

function DragPlane.getObjectEnableNum()
    return self.MAX_PUT_COUNT - DragPlane.getObjectCount()
end

function DragPlane.getNoTeamCount(teams)
    local fieldCount = 0
    for pos, obj in pairs(self.fieldObjs) do
        if pos > 0 and obj:IsPlayer() and obj:IsHero() then --不包含包含
            if true then
                fieldCount = fieldCount + 1
            end
        end
    end
    return fieldCount
end


---@param dragObj DragObject
function DragPlane.putObject(pos, dragObj)
    if dragObj == nil then return end
    local checkCampEff = nil
    local oriPos = pos
    if pos == 99 and self.DISABLE_DELETE then
        pos = dragObj.pos
    end
    if false then       -- 当前位置被锁了

    elseif pos == 99 then               -- 拖到了屏幕外 不在任何一个格子上
        self.delDragObj(dragObj, pos)
    else                                -- 替换或者放到某个格子
        local curObj = self.fieldObjs[pos]
        local needVoice = false
        if curObj then
            if curObj ~= dragObj then
                if dragObj.pos then--互换判定

                    self.fieldObjs[dragObj.pos] = nil
                    curObj:put2Pos(dragObj.pos)
                    dragObj.pos = nil
                else--不是场内互换则删除原对象

                    checkCampEff = true
                    self.delDragObj(curObj, curObj.pos)
                    needVoice = true
                end
            elseif oriPos == 99 then        -- 本来放弃的操作  修正成回原位
                dragObj:put2Pos(dragObj.pos)
            end
        else
            local count = self.getObjectCount(nil, dragObj)
            if count >= self.MAX_PUT_COUNT then
                self.onDragLeave(dragObj, pos)
                DragPlane.putObject(99, dragObj)
                MsgManager.clientNotice(702 ,{self.MAX_PUT_COUNT})
                return
            end
            if not dragObj.pos and self.teamLimitCheck then
                local noTeamCount = self.getNoTeamCount(self.teamLimitCheck.limitTeam)
                if noTeamCount >= self.limitNoTeamNumber then
                    if dragObj:IsPlayer() and dragObj:IsHero() then


                        if true then
                            self.onDragLeave(dragObj, pos)
                            DragPlane.putObject(99, dragObj)
                            MsgManager.notice(self.teamLimitCheck.limit_desc)
                            return
                        end
                    end
                end
            end
            checkCampEff = true
            if not dragObj.pos then
                needVoice = true
            end
        end
        local startPos = dragObj.pos
        if dragObj.pos then
            self.fieldObjs[dragObj.pos] = nil
        end
        self.fieldObjs[pos] = dragObj
        dragObj.pos = pos
        dragObj:ChangePos(pos)
        if checkCampEff then
            checkCampEff = pos
        end
        dragObj:checkStartCue(self.playerEnterState)
        self._plane:ShowGridPutHint(pos, true)
        dragObj:playAnimator("OnDrag")
        if needVoice then
            -- 第一次被拖出来放到格子上，播放语音
            dragObj:playDragVoice()
        end
    end
    --





    if pos == 99 then
        self:_clearSkillArea()
    elseif dragObj.pos then
        self.onPutDragObjectSucc(dragObj)
    end
    if self._focusObj then
        self._focusObj:setSelect(false)
    end
    self._focusObj = dragObj
    dragObj:setSelect(true)
end



function DragPlane.onPutDragObjectSucc(dragObj)
    self.showCampOvercome(dragObj)

    self.showSupportInfo(dragObj)
end

function DragPlane.showSupportInfo(dragObj)
    local beSupported = false
    local objSuptPoses, maxNum = DragPlane._getSupportPos(dragObj, dragObj.pos)
    for i, suptPos in ipairs(objSuptPoses) do
        local suptObj = self.fieldObjs[suptPos]
        if suptObj then--支援对象中不包含拖拽中的对象
            suptObj:onSupportEffect()
        end
    end
    for pos, otherObj in pairs(self.fieldObjs) do
        if beSupported then
            break
        elseif otherObj ~= dragObj and otherObj.camp == dragObj.camp then
            local objSuptPoses, maxNum = DragPlane._getSupportPos(otherObj, pos)
            for _, suptPos in ipairs(objSuptPoses) do
                if suptPos == dragObj.pos then
                    beSupported = true
                    break
                end
            end
        end
    end
    if beSupported then
        dragObj:onSupportedEffect()
    end
end

---@param dragObj DragObject
function DragPlane.showCampOvercome(dragObj, isLoop)
    if dragObj == nil then
        for _, otherObj in pairs(self.fieldObjs) do
            otherObj:stopBattleOvercome()
        end
        return
    end
    local camp = dragObj:GetCampIdx()
    camp = BattleConst.HERO_CAMP_OVERCOME[camp]
    if camp then
        for _, otherObj in pairs(self.fieldObjs) do
            local raceOK = (otherObj:IsHero() and otherObj:GetCampIdx() == camp) or (otherObj:IsMonster() and otherObj:GetCampIdx() == camp)
            local campOK = (dragObj:IsPlayer() and not otherObj:IsPlayer()) or (not dragObj:IsPlayer() and otherObj:IsPlayer())
            if campOK and raceOK then
                otherObj:playBattleOvercome(isLoop)
            else
                otherObj:stopBattleOvercome()
            end
        end
    end
end



--local CA_CUE_ID = 10000007         -- 普攻cue
function DragPlane.startShowSkillArea(dragObj, pos)
    if pos == nil then
        pos = dragObj.pos
    end


    self._clearSkillArea()


    local ca, skillTarget, grids = self.getSkillTargets(dragObj, pos)
    if ca then
        __isExistSkillArea = true
        __caTarget = ca
        ca:setTargetEff(dragObj)
    else
        return
    end

    local targetGridPos = 0
    local targetGridState = 0
    if skillTarget then
        targetGridPos = skillTarget[1]
        targetGridState = skillTarget[2]
    end

    local targetsGridPos = table.keys(grids)
    local targetsGridState = table.values(grids)
    self._plane:ShowSkillArea( targetGridPos,  targetGridState,  targetsGridPos,  targetsGridState)
end

function DragPlane._closeTargetEff()
    if __caTarget then
        __caTarget:closeTargetEff()     --关闭上一个攻击目标的特效
    end    
end

function DragPlane._clearSkillArea()
    if __isExistSkillArea then
        __isExistSkillArea = false
        self._plane:ClearSkillArea()
        self._closeTargetEff()
        __caTarget = nil
    end
end

---@param sender DragObject
function DragPlane.onDragClick(sender)
    if sender.isMisteryMan then
        MsgManager.clientNotice(329) --隐藏阵容
        return
    end

    if self._focusObj then
        self._focusObj:setSelect(false)
    end
    self.showCampOvercome(sender)

    local actionType = Blackboard.ReadBBItemNumber(BbKey.Global, BbItemKey.FormationClickObjectActionType)
    if actionType == DragPlaneClickObjectActionType.ShowTips then
        if sender:IsPlayer() and sender:IsHero() then
            UIJump.ToOpenUIHeroTipsByHeroGid(sender:GetHeroGid(), nil, nil, UITempSmallHeroHeadLayout(true))
        elseif sender:IsMonster() then
            local battleId = Util.BattleParam.GetBattleID()
            local monsterCfgId = sender:GetMonsterConfigID()
            UIJump.ToOpenUIRoleTipsByMonsterTag(monsterCfgId, battleId)
        elseif (not sender:IsPlayer()) and sender:IsHero() then
            UIJump.ToOpenUIHeroTipsByCustom(sender:GetHeroConfigID(), sender:GetLv(), sender:GetStar(), nil, nil, nil, UITempSmallHeroHeadLayout(true))
        end
    elseif actionType == DragPlaneClickObjectActionType.ShowSkillArea then
        self.startShowSkillArea(sender, sender.DragEntData:GetPos())
    end
    self._focusObj = sender
    sender:setSelect(true,true)
end

--英雄拖拽结束，显示影响技能范围
function DragPlane.onDragShowSkillArea(sender, tgtPos)
    self.startShowSkillArea(sender, tgtPos)
end

-- 拿到某个模型到鼠标上的回调
function DragPlane.onDragCatch(sender, tgtPos)

    self.showSupport(sender, tgtPos, false)
    self.showCampOvercome(sender, true)
end

-- 放下某个模型 -99是丢弃 否则会告知正常的Pos
---@param sender DragObject
function DragPlane.onDragPut(sender, tgtPos)
    ---@type UIFormationDB
    local db = GameDB.GetDB(DBId.Formation)
    -- DragPlane里缺个数据，阵容变化的时候没有返回变化类型(上阵，下阵，换位，上阵替换，互换)，也没有相应的数据
    -- 所以在业务层对数据做一个备份，这是垃圾写法，不要模仿
    local snapshot = db:GetDragPlaneResult()

    self.showCampOvercome(nil)
    self.putObject(tgtPos, sender)


    --关闭攻击范围
    self._clearSkillArea()
    if tgtPos ~=99 then
        AudioCueMediator.playUISfx("Audios/sfx/ui/UI_Pitch_Into_The_Work.ogg")
    end

    local count = self.getObjectCount(nil, sender)
    if count < self.MAX_PUT_COUNT then
        if sender:IsPlayer() and sender:IsHero() then
            -- 用业务层的数据反算阵容的变化类型和变化参数
            local heroGid = sender:GetHeroGid()
            local dragType, oldGid, oldGidPos = DragPlane._calculateDragType(snapshot, heroGid, tgtPos)
            db:OnDragHeroEndCB(dragType, heroGid, tgtPos, oldGid, oldGidPos)
        end
    end
end

---@param snapshot DragPlaneResult[]
---@param dragGid string
---@param tarPos number
function DragPlane._calculateDragType(snapshot, dragGid, tarPos)
    local dragType = BattleConst.DragTypeNone
    local oldGid = nil
    local oldGidPos = nil
    if tarPos == 99 then
        local exist = false
        for i = 1, #snapshot do
            if snapshot[i].gid == dragGid then
                exist = true
                break
            end
        end
        if exist then
            dragType = BattleConst.DragTypeRemove -- 下阵
        end
    else
        local exist = false
        local tarGid = nil
        for i = 1, #snapshot do
            if snapshot[i].gid == dragGid then
                exist = true
                oldGidPos = snapshot[i].idx
            end
            if snapshot[i].idx == tarPos then
                tarGid = snapshot[i].gid
            end
        end
        if exist then
            if tarGid then
                if tarGid ~= dragGid then
                    dragType = BattleConst.DragTypeChange -- 互换
                    oldGid = tarGid
                end
            else
                dragType = BattleConst.DragTypeMove -- 已上阵的一个单位移动到一个新的空白处
            end
        else
            if tarGid then
                dragType = BattleConst.DragTypeReplace -- 上阵替换
                oldGid = tarGid
            else
                dragType = BattleConst.DragTypeAdd -- 上阵
            end
        end
    end
    return dragType, oldGid, oldGidPos
end

-- 拖拽过程中进入某个grid
function DragPlane.onDragEnter(sender, tgtPos)
    if self._focusObj then
        self._focusObj:setSelect(false)
    end
    self._focusObj = sender
    sender:setSelect(true)
    if false then
        return
    end
    self.showSupport(sender, tgtPos, true)
    self._plane:ShowGridPutHint(tgtPos, false)


end


-- 拖拽过程中离开某个grid
function DragPlane.onDragLeave(sender, tgtPos)
    self.showSupport(sender, tgtPos, false)
    self._plane:ShowGridPutHint(99, false)
    --self.curTarget = nil
end


local CAMP_ATTACK = 0   -- 攻击敌方
local CAMP_HEAL = 1     -- 治疗友方

local function AddCoordToContainer(coord, container, value)
    local key = self.GridConfig.CoordToPos[coord]
    if key then
        container[key] = value
    end
end
-- 前面一格
local function getForward(pos, defaultGridState, outGrids)
    local coord = self.GridConfig.PosToCoord[pos]
    if pos > 0 then
        AddCoordToContainer(coord+1, outGrids, defaultGridState)
    else
        AddCoordToContainer(coord-1, outGrids, defaultGridState)
    end
end

-- 前面两格
local function getForwardTwo(pos, defaultGridState, outGrids)
    local coord = self.GridConfig.PosToCoord[pos]
    if pos > 0 then
        AddCoordToContainer(coord+1, outGrids, defaultGridState)
        AddCoordToContainer(coord+2, outGrids, defaultGridState)
    else
        AddCoordToContainer(coord-1, outGrids, defaultGridState)
        AddCoordToContainer(coord-2, outGrids, defaultGridState)
    end
end

-- 前面扇形
local function getForwardSector(pos, defaultGridState, outGrids)
    local coord = self.GridConfig.PosToCoord[pos]
    if pos > 0 then
        AddCoordToContainer(coord+1, outGrids, defaultGridState)
    else
        AddCoordToContainer(coord-1, outGrids, defaultGridState)
    end
    local nowLine = math.floor(coord/BattleMiscConfig.ONE_LINE_MAX)
    local index = coord%BattleMiscConfig.ONE_LINE_MAX
    local isLonger = false
    if self.GridConfig.LineNumConfig[nowLine+1] and self.GridConfig.LineNumConfig[nowLine+1] < self.GridConfig.LineNumConfig[nowLine] then
        isLonger = true
    elseif self.GridConfig.LineNumConfig[nowLine-1] and self.GridConfig.LineNumConfig[nowLine-1] < self.GridConfig.LineNumConfig[nowLine] then
        isLonger = true
    end
    if isLonger and pos > 0 then
        AddCoordToContainer(nowLine*BattleMiscConfig.ONE_LINE_MAX+BattleMiscConfig.ONE_LINE_MAX+index, outGrids, defaultGridState)
        AddCoordToContainer(nowLine*BattleMiscConfig.ONE_LINE_MAX-BattleMiscConfig.ONE_LINE_MAX+index, outGrids, defaultGridState)
    elseif isLonger and pos < 0 then
        AddCoordToContainer(nowLine*BattleMiscConfig.ONE_LINE_MAX+BattleMiscConfig.ONE_LINE_MAX-1+index, outGrids, defaultGridState)
        AddCoordToContainer(nowLine*BattleMiscConfig.ONE_LINE_MAX-BattleMiscConfig.ONE_LINE_MAX-1+index, outGrids, defaultGridState)
    elseif pos > 0 then
        AddCoordToContainer(nowLine*BattleMiscConfig.ONE_LINE_MAX+BattleMiscConfig.ONE_LINE_MAX+1+index, outGrids, defaultGridState)
        AddCoordToContainer(nowLine*BattleMiscConfig.ONE_LINE_MAX-BattleMiscConfig.ONE_LINE_MAX+1+index, outGrids, defaultGridState)
    else
        AddCoordToContainer(nowLine*BattleMiscConfig.ONE_LINE_MAX+BattleMiscConfig.ONE_LINE_MAX+index, outGrids, defaultGridState)
        AddCoordToContainer(nowLine*BattleMiscConfig.ONE_LINE_MAX-BattleMiscConfig.ONE_LINE_MAX+index, outGrids, defaultGridState)
    end
end

-- 相邻六格
local function getNearBy(pos, defaultGridState, outGrids)
    for _, nebPos in ipairs(self.GridConfig.NebConfig[pos]) do
        outGrids[nebPos] = defaultGridState
    end
end

-- 相邻两行
local function getNearByTwo(pos, defaultGridState, outGrids)
    local nebs = self.GridConfig.NebConfig[pos]
    for _, nebPos in ipairs(self.GridConfig.NebConfig[pos]) do
        outGrids[nebPos] = defaultGridState
        for _, nebNebPos in ipairs(self.GridConfig.NebConfig[nebPos]) do
            outGrids[nebNebPos] = defaultGridState
        end
    end
end

-- 当前行
local function getLine(pos, defaultGridState, outGrids)
    local coord = self.GridConfig.PosToCoord[pos]
    local nowLine = math.floor(coord/BattleMiscConfig.ONE_LINE_MAX)
    for _, tPos in ipairs(self.GridConfig.LineConfig[nowLine]) do
        outGrids[tPos] = defaultGridState
    end
end

-- 目标及其横排内身后一格
---@param outCATarget DragObject
local function getTargetTwo(outCATarget, defaultGridState, outGrids)
    local pos = outCATarget:GetPos()
    local monsterCfgId = outCATarget:GetMonsterConfigID()
    local tLen = 2
    if outCATarget:IsMonster() and MonsterHelper.IsBigMonster(monsterCfgId) then
        tLen = 3
    end
    local coord = self.GridConfig.PosToCoord[pos]
    if pos < 0 and tLen == 2 then
        AddCoordToContainer(coord, outGrids, defaultGridState)
        AddCoordToContainer(coord+1, outGrids, defaultGridState)
    elseif pos < 0 and tLen ==3 then
        AddCoordToContainer(coord, outGrids, defaultGridState)
        AddCoordToContainer(coord+1, outGrids, defaultGridState)
        AddCoordToContainer(coord+2, outGrids, defaultGridState)
    else
        AddCoordToContainer(coord, outGrids, defaultGridState)
        AddCoordToContainer(coord-1, outGrids, defaultGridState)
    end
end

-- 1  自身前一格(不包括自身)
-- 2  自身前条形两格(不包括自身)
-- 3  自身前方扇形三格(不包括自身)
-- 4  自身周围(不包括自身)
-- 5  自身及自身当前行
-- 6  自身及自身周围两格
-- 7  自身所在行的距离自身最近的一个敌方的单位
-- 8  自身所在行的距离自身最近的一个敌方的单位，如果自身所在行没有找到目标则找其他行的目标
-- 9  自身所在行的距离自身最远的一个敌方的单位
-- 10 自身所在行的距离自身最远的一个敌方的单位，如果自身所在行没有找到目标则找其他行的目标

-- 21 普攻目标
-- 22 普攻目标及普攻目标当前行
-- 23 普攻目标及普攻目标周围
-- 24 普攻目标及普攻目标所在横排内身后一格
-- 25
-- 26
-- 27
-- 28
-- 29

-- 41 敌方所有行前排
-- 42 敌方所有行后排
-- 43
-- 44
-- 45
-- 46
-- 47
-- 48
-- 49

-- 51 特殊算法：治疗所有友方单位
-- 52 特殊算法：攻击所有敌方单位
-- 53 特殊算法：攻击普攻目标，治疗普攻目标周围的单位
-- 54
-- 55
-- 56
-- 57
-- 58
-- 59

DragPlane.TestSkillTarget = nil -- GM测试
DragPlane.TestSkillCamp = nil -- GM测试

---@param dragObj DragObject
function DragPlane.getSkillTargets(dragObj, pos)
    local cardId, cardLevel = dragObj.DragEntData:GetCriticalSkillConfigAndLv()
    if cardId == nil then
        return
    end
    if DataTable.ResSkillConfig[cardId] == nil or DataTable.ResSkillConfig[cardId][cardLevel] == nil then
        LuaCallCs.LogError("---   大招攻击范围显示异常，没有技能配置：skillId = "..cardId.."   skillLv = "..cardLevel)
        return
    end

    local configData = DataTable.ResSkillConfig[cardId][cardLevel]
    local outSkillTarget = nil
    local outGrids = {}
    local outCATarget = self:_searchLineEnemy(pos)
    local skillCamp = configData.skill_camp or CAMP_ATTACK
    local skillTarget = configData.skill_target

    if DragPlane.TestSkillTarget and DragPlane.TestSkillCamp then -- GM测试
        skillTarget = DragPlane.TestSkillTarget
        skillCamp = DragPlane.TestSkillCamp
    end


    local defaultGridState = GRID_RED       -- 根据阵营设置显示阵营的状态
    if skillCamp == CAMP_HEAL then
        defaultGridState = GRID_GREEN
    end
    if skillTarget == 1 then    -- 自身前一格(不包括自身)
        outSkillTarget = {pos, GRID_NONE}
        getForward(pos, defaultGridState, outGrids)
    elseif skillTarget == 2 then    -- 自身前条形两格(不包括自身)
        outSkillTarget = {pos, GRID_NONE}
        getForwardTwo(pos, defaultGridState, outGrids)
    elseif skillTarget == 3 then    -- 自身前方扇形三格(不包括自身)
        outSkillTarget = {pos, GRID_NONE}
        getForwardSector(pos, defaultGridState, outGrids)
    elseif skillTarget == 4 then    -- 自身周围(不包括自身)
        outSkillTarget = {pos, GRID_NONE}
        getNearBy(pos, defaultGridState, outGrids)
    elseif skillTarget == 5 then        -- 自身及自身当前行
        outSkillTarget = {pos, defaultGridState}
        getLine(pos, defaultGridState, outGrids)
        outGrids[pos] = nil
    elseif skillTarget == 6 then        -- 自身及自身周围两格
        outSkillTarget = {pos, defaultGridState}
        if outSkillTarget then
            getNearByTwo(pos, defaultGridState, outGrids)
            outGrids[pos] = nil
        end
    elseif skillTarget == 7 then        -- 自身所在行的距离自身最近的一个敌方的单位
        local farestTarget = self:_searchLineEnemy(pos, false, true)
        if farestTarget then
            outGrids[farestTarget.pos] = defaultGridState
        end
    elseif skillTarget == 8 then        -- 自身所在行的距离自身最近的一个敌方的单位，如果自身所在行没有找到目标则找其他行的目标
        local farestTarget = self:_searchLineEnemy(pos, false)
        if farestTarget then
            outGrids[farestTarget.pos] = defaultGridState
        end
    elseif skillTarget == 9 then        -- 自身所在行的距离自身最远的一个敌方的单位
        local farestTarget = self:_searchLineEnemy(pos, true, true)
        if farestTarget then
            outGrids[farestTarget.pos] = defaultGridState
        end
    elseif skillTarget == 10 then        -- 自身所在行的距离自身最远的一个敌方的单位，如果自身所在行没有找到目标则找其他行的目标
        local farestTarget = self:_searchLineEnemy(pos, true)
        if farestTarget then
            outGrids[farestTarget.pos] = defaultGridState
        end
    elseif skillTarget == 21 then        -- 普攻目标
        outSkillTarget = {outCATarget.pos, defaultGridState}
    elseif skillTarget == 22 then        -- 普攻目标及普攻目标当前行
        outSkillTarget = {outCATarget.pos, defaultGridState}
        getLine(outCATarget.pos, defaultGridState, outGrids)
        outGrids[outCATarget.pos] = nil
    elseif skillTarget == 23 then        -- 普攻目标及普攻目标周围
        outSkillTarget = {outCATarget.pos, defaultGridState}
        if outSkillTarget then
            getNearBy(outCATarget.pos, defaultGridState, outGrids)
            outGrids[outCATarget.pos] = nil
        end
    elseif skillTarget == 24 then       -- 普攻目标及普攻目标所在横排内身后一格
        outSkillTarget = {outCATarget.pos, defaultGridState}
        getTargetTwo(outCATarget, defaultGridState, outGrids)
    elseif skillTarget == 41 then        -- 敌方所有行前排
        for linePos = 1, #self.GridConfig.LineConfig do
            local farestTarget = self:_searchLineEnemyByLine(1, false, true, linePos)
            if farestTarget then
                outGrids[farestTarget.pos] = defaultGridState
            end
        end
    elseif skillTarget == 42 then        -- 敌方所有行后排
        for linePos = 1, #self.GridConfig.LineConfig do
            local farestTarget = self:_searchLineEnemyByLine(1, true, true, linePos)
            if farestTarget then
                outGrids[farestTarget.pos] = defaultGridState
            end
        end
    elseif skillTarget == 51 then       -- 特殊算法：治疗所有友方单位
        for aPos = 1, BattleConst.BATTLE_MAX_POS do
            outGrids[aPos] = GRID_GREEN
        end
    elseif skillTarget == 52 then       -- 特殊算法：攻击所有敌方单位
        for aPos = 1, BattleConst.BATTLE_MAX_POS do
            outGrids[-aPos] = GRID_RED
        end
    elseif skillTarget == 53 then       -- 特殊算法：攻击普攻目标，治疗普攻目标周围的单位
        outSkillTarget = {outCATarget.pos, GRID_RED}
        getNearBy(outCATarget.pos, GRID_GREEN, outGrids)
    end
    return outCATarget, outSkillTarget, outGrids
end

function DragPlane._searchOneLineEnemy(pos, isFar, nowLine)
    local nowLineConfig = self.GridConfig.LineConfig[nowLine]
    if nowLineConfig then
        local nowLineAllNum = #nowLineConfig
        local nowLineHalfNum = math.floor(nowLineAllNum/2)
        if pos>0 and isFar then
            for index = nowLineAllNum, nowLineHalfNum, -1 do
                local mPos = nowLineConfig[index]
                if self.fieldObjs[mPos] and mPos < 0 then
                    return self.fieldObjs[mPos]
                end
            end
        elseif pos>0 then
            for index = nowLineHalfNum, nowLineAllNum do
                local mPos = nowLineConfig[index]
                if self.fieldObjs[mPos] and mPos < 0 then
                    return self.fieldObjs[mPos]
                end
            end
        elseif isFar then
            for index = 1, nowLineHalfNum do
                local mPos = nowLineConfig[index]
                if self.fieldObjs[mPos] and mPos > 0 then
                    return self.fieldObjs[mPos]
                end
            end
        else
            for index = nowLineHalfNum, 1, -1 do
                local mPos = nowLineConfig[index]
                if self.fieldObjs[mPos] and mPos > 0 then
                    return self.fieldObjs[mPos]
                end
            end
        end
    end
end
function DragPlane:_searchLineEnemy(pos, isFar, onlySelfLine)     -- 寻找一行的敌方  isFar表示是不是找最远的
    local coord = self.GridConfig.PosToCoord[pos]
    local nowLine = math.floor(coord/BattleMiscConfig.ONE_LINE_MAX)
    local lineResult = self._searchOneLineEnemy(pos, isFar, nowLine)
    if lineResult then
        return lineResult
    end
    if not onlySelfLine then
        for index = 1, #self.GridConfig.LineConfig do
            local upResult = self._searchOneLineEnemy(pos, isFar, nowLine+index)
            if upResult then
                return upResult
            end
            local downResult = self._searchOneLineEnemy(pos, isFar, nowLine-index)
            if downResult then
                return downResult
            end
        end
    end
end

function DragPlane:_searchLineEnemyByLine(posFlag, isFar, onlySelfLine, nowLine)     -- 寻找一行的敌方  posFlag大于0表示左边
    local lineResult = self._searchOneLineEnemy(posFlag, isFar, nowLine)
    if lineResult then
        return lineResult
    end
    if not onlySelfLine then
        for index = 1, #self.GridConfig.LineConfig do
            local upResult = self._searchOneLineEnemy(posFlag, isFar, nowLine+index)
            if upResult then
                return upResult
            end
            local downResult = self._searchOneLineEnemy(posFlag, isFar, nowLine-index)
            if downResult then
                return downResult
            end
        end
    end
end

--local ENTER_INTERVAL = 0.1
local MAX_ENTER_NUMBER = 10


function DragPlane.startObjEnteringNew()
    self.inObjectEntering = true
    self.canEnterNumber = 0

    while self.canEnterNumber > MAX_ENTER_NUMBER do
        self.canEnterNumber = self.canEnterNumber + 2
        self.onCheckObjEnter()
    end
    self.inObjectEntering = false
end



function DragPlane.onCheckObjEnter()
    local canEnterPlayer = {}
    local canEnterMonster = {}
    local nowEnterNumPlayer = 0
    local nowEnterNumMonster = 0
    for pos, obj in pairs(self.fieldObjs) do
        if obj.modelLoaded then
            if obj:isModelInShow() then
                if pos > 0 then
                    nowEnterNumPlayer = nowEnterNumPlayer + 1
                else
                    nowEnterNumMonster = nowEnterNumMonster + 1
                end
            else
                if pos > 0 then
                    table.insert(canEnterPlayer, obj)
                elseif pos < 0 then
                    table.insert(canEnterMonster, obj)
                end
            end
        end
    end
    for index, obj in ipairs(canEnterPlayer) do
        if nowEnterNumPlayer + index - 1 < self.canEnterNumber then
            obj:onEnterGame()
        else
            break
        end
    end
    for index, obj in ipairs(canEnterMonster) do
        if nowEnterNumMonster + index - 1 < self.canEnterNumber then
            obj:onEnterGame()
        else
            break
        end
    end
end





return DragPlane