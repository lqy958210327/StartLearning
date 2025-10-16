-- 条件限制mgr  用于在未达条件时屏蔽入口

local ConditionLimitManager = {}
local self = ConditionLimitManager
self.unlockNotifyMap = {}       -- 解锁回调注册列表


function ConditionLimitManager.initPlayerData()
    -- self.systemMap = {}             -- 当前状态映射   true 表示被锁了
    -- self.extraCondMap = {}          -- 一些存在特殊条件的ID  需求实时在获取时额外判断下
    -- self.levelConditions = {}       -- 等级对应的解锁数据
    -- self.stageConditions = {}       -- 关卡对应的解锁数据
    -- self.taskConditions  = {}       -- 任务对应的解锁数据
    -- self.achieveConditions = {}     -- 成就对应的解锁数据
    -- self.resultCache = {}           -- 结果缓存(缓存到主界面再触发)
    -- self.houseLevelConditions = {}       -- 等级对应的解锁数据
    -- self.crystalLevelConditions = {}       -- 等级对应的解锁数据
    -- self.vipLevelConditions = {}        --vip等级对应的解锁数据
    -- local level = Util.Account.PlayerLv()
    -- local houseLevel = 0--CurAvatar:getRearHouseLevel()--获取后院等级
    -- local crystalLevel = 0--CurAvatar:getCrystalMaxLevel()
    -- for limitId, limitInfo in pairs(ResConditionLimit) do
    --     if limitInfo.unlock_level then
    --         self.systemMap[limitId] = limitInfo.unlock_level > level
    --         self.levelConditions[limitId] = limitInfo.unlock_level
    --     elseif limitInfo.unlock_stage then
    --         if DataTable.ResStageData_IDX[limitInfo.unlock_stage] then
    --             local season = tonumber(DataTable.ResStageData_IDX[limitInfo.unlock_stage].season or 1)
    --             local chapter = tonumber(DataTable.ResStageData_IDX[limitInfo.unlock_stage].chapter or 1)
    --             local level = tonumber(DataTable.ResStageData_IDX[limitInfo.unlock_stage].level or 1)
    --             local value = season * 10000 + chapter * 100 + level
    --             local flag = false
    --             flag = FuncOpenData:getCurrentStageInfo() < value
    --             self.systemMap[limitId] = flag
    --             self.stageConditions[limitId] = {season,chapter,level}
    --         end
    --         --zzc 增加兼容
    --         --for i, v in pairs(ResStage) do
    --         --    for x, y in pairs(v) do
    --         --        for z, c in pairs(y) do
    --         --            if c.idx ==limitInfo.unlock_stage then
    --         --                local season = tonumber(c.season or 1)
    --         --                local chapter = tonumber(c.chapter or 1)
    --         --                local level = tonumber(c.level or 1)
    --         --                local value = season * 10000 + chapter * 100 + level
    --         --                local flag = false
    --         --                flag = FuncOpenData:getCurrentStageInfo() <= value
    --         --                self.systemMap[limitId] = flag
    --         --                self.stageConditions[limitId] = {c.season,c.chapter,c.level}
    --         --            end
    --         --        end
    --         --    end
    --         --end
    --     elseif limitInfo.unlock_task then
    --         local taskType = limitInfo.unlock_task[1]
    --         local id = limitInfo.unlock_task[2]
    --         local condition = limitInfo.unlock_task[3]
    --         self.systemMap[limitId] = self._checkTaskLocked(taskType, id, condition) 
    --         if taskType == UNLOCK_TYPE_ACHIEVE then
    --             self.achieveConditions[id] = {["limitId"]=limitId, ["condition"] = condition }
    --         elseif taskType == UNLOCK_TYPE_TASK then
    --             self.taskConditions[id] = {["limitId"]=limitId, ["condition"] = condition }
    --         end
    --     elseif limitInfo.unlock_house_level then
    --         self.systemMap[limitId] = limitInfo.unlock_house_level > houseLevel
    --         self.houseLevelConditions[limitId] = limitInfo.unlock_house_level
    --     elseif limitInfo.unlock_crystal_level then
    --         self.systemMap[limitId] = limitInfo.unlock_crystal_level > crystalLevel
    --         self.crystalLevelConditions[limitId] = limitInfo.unlock_crystal_level
    --     elseif limitInfo.VIP_level then
    --         self.vipLevelConditions[limitId] = limitInfo.VIP_level
    --     end
    --     if limitInfo.VIP_level then
    --         self.extraCondMap[limitId] = limitInfo
    --     end

  
    -- end
    --self:refreshRedDot()
end
--function ConditionLimitManager.refreshRedDot()
--
--end
function ConditionLimitManager._checkTaskLocked(unlockType, id, condition )
    -- local isLocked = true
    -- if unlockType == UNLOCK_TYPE_ACHIEVE then
    --     if condition == Const.CONDITION_TASK_QUALIFY_UNLOCK then
    --         isLocked =false --not CurAvatar.achieveQualify[id]
    --     elseif condition == Const.CONDITION_TASK_GOT_UNLOCK then
    --         isLocked = false--not CurAvatar.achieveAwardGot[id]
    --     end
    -- elseif unlockType == UNLOCK_TYPE_TASK then
    --     local taskStatus = nil --CurAvatar:getTaskStatus(id)
    --     if condition == Const.CONDITION_TASK_QUALIFY_UNLOCK then
    --         isLocked = taskStatus~=Const.TASK_STATUS.COMPLETE and taskStatus~=Const.TASK_STATUS.AWARD_GOT
    --     elseif condition == Const.CONDITION_TASK_GOT_UNLOCK then
    --         isLocked = taskStatus~=Const.TASK_STATUS.AWARD_GOT
    --     end
    -- end
    -- return isLocked
end

-- 返回值为true表示被锁了
function ConditionLimitManager.inLimitState(limitId)
    local value, lockShow = Util.LimitOpen.GetLimitOpen(limitId)
    logerror("功能开启已换新接口，此接口废弃，用以下逻辑替换")
    return value, lockShow
end

function ConditionLimitManager.extraCondMapLocked(limitInfo)
    -- if limitInfo.VIP_level then
    --     return CurAvatar.vipLevel < limitInfo.VIP_level
    -- end
    logerror("功能开启已换新接口，此接口废弃，用以下逻辑替换")
    return false, "此逻辑废弃，查看报错日志"
    -- local value, lockShow = Util.LimitOpen.GetLimitOpen(key)
    -- return value, lockShow
end

function ConditionLimitManager.inGamePlayLimitState(gamePlayerId)
    -- if ResGamePlayNotice[gamePlayerId] then
    --     return self.inLimitState(ResGamePlayNotice[gamePlayerId].condition_id)
    -- end
    logerror("功能开启已换新接口，此接口废弃，用以下逻辑替换")
    return false, "此逻辑废弃，查看报错日志"
    -- local value, lockShow = Util.LimitOpen.GetLimitOpen(key)
    -- return value, lockShow
end

function ConditionLimitManager.getLimitUnlockDesc(limitId, isButton)
    local value, lockShow = Util.LimitOpen.GetLimitOpen(limitId)
    logerror("功能开启已换新接口，此接口废弃，用以下逻辑替换")
    return lockShow
end



function ConditionLimitManager.triggerHouseLevelCondition( level )
    -- for limitId, limitLv in pairs(self.houseLevelConditions) do
    --     if self.inLimitState(limitId) and level >= limitLv then
    --         -- 等级大于等于限制的等级,则解锁
    --         self._limitUnlock(limitId)
    --     end
    -- end
    -- self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerCrystalLevelCondition( level )
    -- for limitId, limitLv in pairs(self.crystalLevelConditions) do
    --     if self.inLimitState(limitId) and level >= limitLv then
    --         -- 等级大于等于限制的等级,则解锁
    --         self._limitUnlock(limitId)
    --     end
    -- end
    -- self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerStageUnlock(idx)
    -- if self.stageConditions then
    --     for limitId, unlockStage in pairs(self.stageConditions) do
    --         local temp = DataTable.ResStage[unlockStage[1]][unlockStage[2]][unlockStage[3]]
    --         if self.inLimitState(limitId) and DataCoreTools.getMainStoryPass(temp.idx) then
    --             --解锁功能时，并且同时打开功能
    --             self.unlockFuncAndOpen(limitId)
    --             self._limitUnlock(limitId)
    --         end
    --     end
    -- end

    -- self.scheduleUnlockNotify()
end

--解锁功能，并且同时打开功能，找一个合适的位置。不要在条件解锁类中处理
function ConditionLimitManager.unlockFuncAndOpen(limitId)
    -- local UserData = require "Core/Helper/UserData"
    -- if limitId == Const.CONDITION_LIMIT_BATTLE_AUTO then
    --     UserData.saveCommonData(BattleConst.IS_MANUAL_KEY, '1')
    -- end
    -- if limitId == Const.CONDITION_LIMIT_BATTLE_SPEED then
    --     UserData.saveCommonData(BattleConst.SPEED_KEY, "SpeedUp1")
    -- end
end

function ConditionLimitManager.triggerVipLevelUnlock(level)
    -- for limitId, vipLevel in pairs(self.vipLevelConditions) do
    --     if level == vipLevel then
    --         EventCenter.sendEvent(EventConst.CONDITION_LOCK_CHANGED, {limitId})
    --         self._checkRD(limitId)
    --     end
    -- end
    -- self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerTaskUnlock( taskId, opt )
    -- local unlockInfo = self.taskConditions[taskId]
    -- if not unlockInfo then
    --     return
    -- end
    -- local limitId = unlockInfo["limitId"]
    -- local condition = unlockInfo["condition"]
    -- if self.inLimitState(limitId) and condition == opt then
    --     self._limitUnlock(limitId)
    --     self.scheduleUnlockNotify()
    -- end 
end

function ConditionLimitManager.triggerAchieveUnlock( achieveId, opt )
    -- local unlockInfo = self.achieveConditions[achieveId]
    -- if not unlockInfo then
    --     return
    -- end
    -- local limitId = unlockInfo["limitId"]
    -- local condition = unlockInfo["condition"]
    -- if self.inLimitState(limitId) and condition == opt then
    --     self._limitUnlock(limitId)
    --     self.scheduleUnlockNotify()
    -- end 
end

function ConditionLimitManager._limitUnlock( limitId )
    -- self.resultCache[limitId] = true
    -- self.systemMap[limitId] = nil
    -- EventCenter.sendEvent(EventConst.CONDITION_LOCK_CHANGED,{ limitId})
    -- self._checkRD(limitId)
end

function ConditionLimitManager._checkRD( limitId )
    -- if UIConst.CONDITION_RD_MAP[limitId] then
    --     RedDotManager.updateDotsByKey(UIConst.CONDITION_RD_MAP[limitId])
    -- end
end

-- 系统解锁后的回调 在此接口进行resultCache的表现处理及缓存机制
function ConditionLimitManager.scheduleUnlockNotify()

    -- if self.tUnlockNotify == nil then
    --     self.tUnlockNotify = Timer.New(self.notifyUnlockedSystemSlot, 0.5, -1)
    --     self.tUnlockNotify:Start()
    -- elseif not self.tUnlockNotify:IsRunning() then
    --     self.tUnlockNotify:Restart()
    -- end
end

function ConditionLimitManager.registerUnlockEvent(limitId, callback)
    -- if not self.unlockNotifyMap[limitId] then
    --     self.unlockNotifyMap[limitId] = {}
    -- end
    -- table.insert(self.unlockNotifyMap[limitId], callback)
end

-- for GM
function ConditionLimitManager.unlockAllCondition( ... )
    -- for limitId, _ in pairs(self.systemMap) do
    --     self._limitUnlock(limitId)
    -- end
end

return ConditionLimitManager