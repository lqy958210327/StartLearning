
-- 获取 付费商店 配置
local _getActivityCfg = function(activityId)
    local cfg = DataTable.ResActivityTimeOpenData[activityId]
    assert(cfg, "---   数据异常：ResActivityTimeOpenData配置数据空 activityId = "..activityId)
    return cfg
end

-- 活动 工具
local tab = {}

---@param activityId number 活动ID
---@return number gropId 返回任务组ID
function tab.GetTaskGroupId(activityId)
    local cfgData = _getActivityCfg(activityId)
    if cfgData and cfgData.genreId == ActivityEnum.GenreId.Task then
        return cfgData.gropId
    end
    return 0
end

---@param activityId number 活动ID
---@return number gropId 返回充值组ID
function tab.GetRechargeGroupId(activityId)
    local cfgData = _getActivityCfg(activityId)
    if cfgData and cfgData.genreId == ActivityEnum.GenreId.Recharge then
        return cfgData.gropId
    end
    return 0
end


---@param activityId number 活动ID
---@return ActivityTaskData[] taskList 返回任务组ID
function tab.GetTaskListByActivityId(activityId)
    local groupId = tab.GetTaskGroupId(activityId)
    local taskList = {}
    local taskDataList = DataTable.ResActivityConfigTask[groupId]
    for i, cfgData in ipairs(taskDataList) do
        local taskData = ActivityTaskData()
        taskData:SetTaskData(cfgData.taskId, cfgData.continuePath, cfgData.continueName)
        table.insert(taskList, taskData)
    end
    return taskList
end

Util.Activity = tab
