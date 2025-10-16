local BattleConst = require "Core/Common/FrameBattle/BattleConst"

local Vector3 = Vector3
local CueManager = CueManager
local Const = Const

local BattleActorReceiver = {}
function BattleActorReceiver:onHitedAnim(hitedFlag)
    if hitedFlag and hitedFlag ~= "" then
        if true then    -- 暂时取消受击特效播放和是否暂停的关系 -- Ma Yinchao -- 2025.6.26
            if hitedFlag == "end" then
                if self.entityModel and self.entityModel.modelAux and self.preAnim and self.preAniTime then
                    self.entityModel.modelAux:PlayAnimatorWithNTime(self.preAnim, self.preAniTime)
                    self.entityModel.modelAux:PauseOn()
                end
            else
                if self.entityModel and self.entityModel.modelAux and self.movementAux then
                    if self.preAniTime == 0 then
                        self.preAniTime = self.entityModel.modelAux:GetCurStateTime()
                    end
                    self.entityModel.modelAux:PauseOff()
                    self:playAnimator(hitedFlag)
                end
            end
        end
    end
end

-- 表演受击位移 Animator方式
function BattleActorReceiver:onHitedOffset(hitedOffsetPath)
    self:startAnimationOffset(hitedOffsetPath)
end

function BattleActorReceiver:onMoveOutOfPos()
    --local pos = self.actorMgr.gridTrans:getOutPosition(self)
    --self:teleport(pos.x, pos.y, pos.z)
    -- self:_moveTo(pos, 1.0)
end

function BattleActorReceiver:PauseOn()
    if self.over then
        return
    end
    self.pauseDict['skill'] = true
    self.pauseEffDict['skill'] = true
    self:refreshPause()
    if self.movementAux then
        self.preAniTime = 0
    end
end

function BattleActorReceiver:refreshPause()
    self.inPause = false
    for reason, _ in pairs(self.pauseDict) do
        self.inPause = true
        break
    end
    self.effPause = false
    for reason, _ in pairs(self.pauseEffDict) do
        self.effPause = true
        break
    end
    if self.inPause then
        if self.movementAux then
            self.movementAux:PauseOn()
        end
        -- 动作暂停
        if self.modelLoaded and self.entityModel and self.entityModel.modelAux then
            self.entityModel.modelAux:PauseOn()
        end
    else
        if self.movementAux then
            self.movementAux:PauseOff()
        end
        if self.modelLoaded and self.entityModel and self.entityModel.modelAux then
            self.entityModel.modelAux:PauseOff()
        end
    end
    if self.effPause then
        EffectCueMediator.pauseEffectGroup( self.entityId )
    else
        EffectCueMediator.resumeEffectGroup( self.entityId )
    end
end

function BattleActorReceiver:PauseOff()
    self.pauseDict['skill'] = nil
    self.pauseEffDict['skill'] = nil
    self:refreshPause()
end

function BattleActorReceiver:onSkillJump(dist, jumpTime, lockTargetId)
    --dist = tonumber(dist) or 0
    --if self.movementAux and lockTargetId and jumpTime > 0 then
    --    local destActor = self.actorMgr:getActor(lockTargetId)
    --    if not destActor then
    --        return
    --    end
    --    self:lookAtGrid()
    --    local vec = self.actorMgr.gridTrans:getVector(self,destActor,dist)
    --    local speed = vec*30/jumpTime
    --    self.movementAux:startMoving(speed.x, speed.y, speed.z, jumpTime/30)
    --end
    LuaCallCs.LogError("---   这里根据需求重新实现一下...")
end

function BattleActorReceiver:onSkillBack(backTime)
    for _, obj in pairs(self.actorMgr.actors) do        -- 跳回来的时机  受击位移需要回复原状
        obj:stopAnimationOffset()
    end
    if self.movementAux and backTime > 0 then
        local pos = self.actorMgr:getGridPosition(self.coordX, self.coordY)
        local vec = pos - self:getPosition()
        local speed = vec*30/backTime
        self.movementAux:startMoving(speed.x, speed.y, speed.z, backTime/30)
    end
end

function BattleActorReceiver:onSkillFlash(flashing, srcX, srcY, dstX, dstY, flashFrame)
    if self.movementAux then
        local endPos = self.actorMgr:getGridPosition(dstX, dstY)
        if flashing then
            local startPos = self:getPosition()
            local vec = endPos - startPos
            local speed = vec * 30 / flashFrame
            self:lookatGrid()
            self.movementAux:startMoving(speed.x, speed.y, speed.z, flashFrame / 30)
        else
            local pos = self.actorMgr:getGridPosition(srcX, srcY)
            self.movementAux:stopMoving(pos.x, pos.y, pos.z, 0)
            self.movementAux:FaceTo(endPos)
            -- mirror adjust
            self:refreshModelFaceByCoordX()
        end
    end
end

function BattleActorReceiver:onPlayCue(targetId, cueList, startId, time )
    self.actorMgr:onPlayCue(self.fashionTag, targetId, cueList, startId, time)
end

function BattleActorReceiver:_moveTo(endPos, moveTime)
    local startPos = self:getPosition()
    local speedDir = endPos - startPos
    local len = speedDir:Magnitude()
    speedDir = Vector3.Normalize(speedDir) * (len / moveTime)
    if speedDir then
        self.movementAux:startMoving(speedDir.x, speedDir.y, speedDir.z, moveTime)
    end
end

-- 朝前进方向看
function BattleActorReceiver:onSetMove(moving, srcX, srcY, dstX, dstY, moveTime, noBack, noAnim, noFace)
    if self.movementAux then        -- 移动中对动作的处理
        if moving then
            if not self.inRunningAnim then
                if not noAnim then
                    self.preAnim = "Run"
                    self:playAnimator("Run")
                    self.inRunningAnim = true
                end
            end
        else
            if self.inRunningAnim then
                if self.preAnim == "Run" then
                    self.preAnim = "idle"
                    self:playAnimator("idle")
                end
                self.inRunningAnim = false
            end
        end
        if moving then
            local startPos = self:getPosition()
            local endPos = self.actorMgr:getGridPosition(dstX, dstY)
            local speedDir = endPos - startPos
            local len = speedDir:Magnitude()
            speedDir = Vector3.Normalize(speedDir) * (len / moveTime)
            if speedDir then
                self.movementAux:startMoving(speedDir.x, speedDir.y, speedDir.z, moveTime)
                if not noFace then
                    self.movementAux:FaceTo(endPos)
                    -- mirror adjust
                    self:refreshModelFaceByCoordX()
                end
            end
        else
            if not noBack then
                local pos = self.actorMgr:getGridPosition(srcX, srcY)
                self.movementAux:stopMoving(pos.x, pos.y, pos.z, 0)
            else
                self.movementAux:stopMoving(0, 0, 0, 1)
            end
        end
    end
end

function BattleActorReceiver:onBehaviorAnim(animName, aniSpeed, skillCd)
    if animName and animName ~= "" then
        self.preAnim = animName
        if aniSpeed and skillCd then
            if self.modelLoaded and self.entityModel then
                self.entityModel.modelAux:SetFloatParam("Cattackspeed", aniSpeed)
            end
        end
        self:playAnimationWithDuration(animName, 0.1)
        local target = self.baseTarget
        if target then
            self:lookatTarget(target)
        end
    end
end

-- 看目标
function BattleActorReceiver:lookatTarget( targetId )
    if targetId == self.entityId then
        return
    end
    local target = self.actorMgr.actors[targetId]
    if target then
        local targetObject = target.gameObject
        if self.movementAux then
            self.movementAux:FaceToTarget(targetObject)
        end
        -- mirror adjust
        self:refreshModelFaceByCoordX()
    end
end

-- 只往"前"看
function BattleActorReceiver:lookatGrid()
    local movementAux = self.movementAux
    local actorPos = self:getPosition()
    local pos = self.actorMgr:getGridPosition(0, 0)
    actorPos.x = pos.x
    movementAux:FaceTo(actorPos)
    -- mirror adjust
    self:refreshModelFace()
end

--function BattleActorReceiver:getCameraAngleFix()
--    local nowR = self.gameObject.transform.rotation.eulerAngles
--    return self.actorMgr.gridTrans:getFixedAngle(nowR)
--end

function BattleActorReceiver:refreshModelFaceByCoordX()
    --local needMirror = selfCoord > targetCoord
    local _, rotY, _ = self:getRotationXYZ()
    local needMirror = (rotY + 360) % 360 > 180
    self:refreshModelFace(needMirror)
end

function BattleActorReceiver:onQuickMove(moveTime)
    if self.movementAux then
        local pos = self.actorMgr:getGridPosition(self.coordX, self.coordY)
        if moveTime and moveTime > 0 then
            local dist = Vector3.Distance(self:getPosition(), pos)
            local speed = dist/moveTime
            self.movementAux:MoveBySpeed(pos.x, pos.z, speed)
        else
            self:teleport(pos.x, pos.y, pos.z)
        end
    end
end

function BattleActorReceiver:onStateEnter(stateType, stateArgs)
    if stateType == BattleConst.ENTITY_STATE_HITED then
        if self.hitedCueInstId then
            CueManager.releaseCue(self, self.hitedCueId, self.hitedCueInstId)
            self.hitedCueInstId = nil
            self.hitedCueId = nil
        end
        self.hitedCueId = CueLogicMediator.getStateHitedCueId(stateArgs)
        if self.hitedCueId then
            self.hitedCueInstId = self:PlayCue(self.hitedCueId)
        end
        if stateArgs == "stun" then
            self:showStateNum(true, BattleConst.STATE_SHOW_STUN)
        elseif stateArgs == "freeze" then
            self:showStateNum(true, BattleConst.STATE_SHOW_FREEZE)
        elseif stateArgs == "timelock" then
            self:showStateNum(true, BattleConst.STATE_SHOW_TIME_LOCK)
        elseif stateArgs == "sleep" then
            self:showStateNum(true, BattleConst.STATE_SHOW_SLEEP)
        elseif stateArgs == "Float" then
            self:showStateNum(true, BattleConst.STATE_SHOW_FLOAT)
        end
        if stateArgs == "freeze" or stateArgs == "timelock" then
            self.pauseDict['freeze'] = true
            self:refreshPause()
        elseif self.pauseDict['freeze'] then
            self.pauseDict['freeze'] = nil
            self:refreshPause()
        end
    end
end

function BattleActorReceiver:onStateLeave(stateType, stateArgs)
    if stateType == BattleConst.ENTITY_STATE_HITED then
        if self.hitedCueInstId then
            CueManager.releaseCue(self, self.hitedCueId, self.hitedCueInstId)
            self.hitedCueInstId = nil
            self.hitedCueId = nil
        end
        if self.pauseDict['freeze'] then
            self.pauseDict['freeze'] = nil
            self:refreshPause()
        end
    end
end

-- 技能结束因为结构问题不会立刻进入Idle状态  此处手动raise idle的behavior  黑盒此时还处于技能逻辑中
function BattleActorReceiver:onIdleAnim()
    self:playAnimationWithDuration("idle", 0.1)
end

-- 一些特殊逻辑下的表现层动作播放 比如变身后 为了保证动作的一致性  播放一个合适的能衔接的动作
function BattleActorReceiver:onPlaySpecialAnim(animName)
    self:playAnimator(animName)
end

function BattleActorReceiver:cancelSkillHide()
end

return BattleActorReceiver
