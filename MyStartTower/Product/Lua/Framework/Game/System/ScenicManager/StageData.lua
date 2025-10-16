
local className = "StageData"
---@class StageData 展台数据
StageData = Class(className)

function StageData:ctor()
    self._stageTag = 0 ---@type number 展台类型
end

---@type fun(stageType: number): StageData 配置展台类型
function StageData:WithStageTag(stageTag)
    self._stageTag = stageTag
    return self
end

---@type fun(): number 获取展台类型
function StageData:GetStageTag()
    return self._stageTag
end

---@type fun(other: StageData): boolean 比较
---@param other StageData 其他展台数据
function StageData:Compare(other)
    if not other then
        return false
    end
    if self._stageTag ~= other:GetStageTag() then
        return false
    end
    return true
end