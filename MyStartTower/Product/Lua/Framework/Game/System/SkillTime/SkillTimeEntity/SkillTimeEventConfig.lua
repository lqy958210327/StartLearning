local className = "SkillTimeEventConfig"
---@class SkillTimeEventConfig  战斗技能渲染帧事件配置
local SkillTimeEventConfig = Class(className)

function SkillTimeEventConfig:ctor( config )       
    self._skillTag = 0 ---@type number 技能Tag
    self._fps = SkillTimeHelper.DefaultFPS() ---@type number 帧率
    self._durationSec = 0 ---@type number 总时长(s)
    self._durationFrame = 0 ---@type number 总帧数
    self._eventDict = {} ---@type table 配置数据

    if config then
        self._skillTag = config.skillTag
        self._fps = config.fps
        self._durationSec = config.durationSec
        self._durationFrame = config.durationFrame
        self._eventDict = config.events
    end

end
function SkillTimeEventConfig:GetSkillTag()
    return self._skillTag
end

function SkillTimeEventConfig:GetFPS()
    return self._fps
end

function SkillTimeEventConfig:GetDurationSec()
    return self._durationSec
end

function SkillTimeEventConfig:GetDurationFrame()
    return self._durationFrame
end

function SkillTimeEventConfig:GetEventMap()
    return self._eventDict
end

return SkillTimeEventConfig