local SkillTimeEnumDefine = require("Framework/Game/System/SkillTime/SkillTimeEnumDefine")
local SkillTimeEventConfig = require("Framework/Game/System/SkillTime/SkillTimeEntity/SkillTimeEventConfig")
local SkillTimeEntityFactory = require("Framework/Game/System/SkillTime/SkillTimeEntityFactory")

---@class SkillTimeHelper
SkillTimeHelper = {}
local framesPerSecond = 30; --每秒30帧
local _defaultUltimateColor = { r = 0, g = 0, b = 0, a = 0, } -- 默认的终极技颜色


local DataPath = "Config/EditorTable/SkillTimeEventData/"
local loadedConfig = {}

---@type fun():number 获取默认的帧率
function SkillTimeHelper.DefaultFPS()
    return framesPerSecond
end

---@type fun():table 获取默认的终极技颜色
function SkillTimeHelper.DefaultUltimateColor()
    return _defaultUltimateColor
end


---@type fun() 隐藏并暂停当前时刻之前的全部飘字对象及动画
function SkillTimeHelper.HideAndPauseFloatingWorks()
    LuaCallCsUtilCommon.SetFloatingWordsDisplay(false)
    LuaCallCsUtilCommon.SetFloatingWordsPause(true)
end

---@type fun() 显示并继续当前时刻之前的全部飘字对象及动画
function SkillTimeHelper.ShowAndResumeFloatingWorks()
    LuaCallCsUtilCommon.SetFloatingWordsDisplay(true)
    LuaCallCsUtilCommon.SetFloatingWordsPause(false)
end

---@type fun(seconds:number):number 将秒转换为帧数
---@param seconds number 秒
---@param fps number 帧率
---@return number 秒对应的帧
function SkillTimeHelper.TimeToFrame(seconds, fps)
    if fps == nil or fps <= 0 then
        fps = SkillTimeHelper.DefaultFPS()
    end
    local result = math.floor(seconds * fps)
    -- print("CurTime:"..seconds.."; to Frame:"..result.."; fps:"..fps)
    return result
end

---@type fun(skillTag:number):string 获取技能配置文件名
---@param skillTag number 技能Tag
---@return string 配置文件名
function SkillTimeHelper.GetConfigName(skillTag)
    return string.format("SkillTimeEvent_%d", skillTag)
end

---@type fun(skillTag:number):SkillTimeEventConfig 获取配置
---@param skillTag number 技能Tag
---@return SkillTimeEventConfig | nil 配置
function SkillTimeHelper.GetConfig(skillTag)
    if loadedConfig[skillTag] == nil then
        local fullDataPath = DataPath..SkillTimeHelper.GetConfigName(skillTag)
        -- 判断文件是否存在
        local status, requireConfig = pcall(require, fullDataPath)
        if not status then
            local errorMsg = string.format("加载SkillTimeEvent配置文件失败! 技能:%d, 文件路径:%s, 错误信息:%s", skillTag, fullDataPath, requireConfig)
            LuaCallCsUtilCommon.LogError(errorMsg)
            return nil
        end
        loadedConfig[skillTag] = SkillTimeEventConfig(requireConfig)
    end
    return loadedConfig[skillTag]
end

---@type fun(config:SkillTimeEventConfig):table<number, SkillTimeEntity[]>, table<number, SkillTimeEntity[]> 事件实体表格和结束事件表格
---@param config SkillTimeEventConfig 配置
---@return table<number, SkillTimeEntity[]> | nil 事件实体表格和结束事件表格
function SkillTimeHelper.AdapterEventEntities(config)    
    if not config or not config:GetEventMap() then
        return nil
    end
    local eventEntityDic = {}
    local endFrame = config:GetDurationFrame()
    local configEventsDic = config:GetEventMap()

    for curFrame, _ in pairs(configEventsDic) do
        local events = configEventsDic[curFrame]
        if events then
            eventEntityDic[curFrame] = eventEntityDic[curFrame] or {}            
            for index, _ in pairs(events) do
                local event = events[index]
                if event then
                    local eventEntity = SkillTimeEntityFactory.Creator(curFrame, endFrame, event, config._skillTag)
                    table.insert(eventEntityDic[curFrame], eventEntity)
                end
            end
        end
    end
    return eventEntityDic
end


