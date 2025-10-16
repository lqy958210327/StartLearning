


---@class GuideDefine
GuideDefine = {}

-- 触发类型，相当于触发接口的调用位置
local _triggerType = {
    UIOpen = "UIOpen",
    HeroManaFull = "HeroManaFull",
    FightingTimer = "FightingTimer",
    NextStep = "NextStep",
    UIClose = "UIClose",
    FormationGuideFinish = "FormationGuideFinish",
}

--
local _limitDataType = {
    Number = "Number", -- 数值类型
    Map = "Map", -- 字典类型
}

local _operateType = {
    Equal = "Equal", -- 等于，适用于数值类型
    More = "More", -- 大于等于，适用于数值类型
    Less = "Less", -- 小于等于，适用于数值类型
    Round = "Round", -- 范围(大于等于 且 小于等于)，适用于数值类型
    Exist = "Exist", -- 存在，适用于字典类型
    NotExist = "NotExist", -- 不存在，适用于字典类型
}
local _contextKey = {
    MainStory = "MainStory", -- Number, 主线关卡已通关的进度
    LastGuideGroup = "LastGuideGroup", -- Number, 上次完成的引导组ID
    HeroDB = "HeroDB", -- Map, 玩家英雄卡牌库
    ServerGroupID = "ServerGroupID", -- Map, 服务器数据库已完成的引导ID
}

local _guideType = {
    Force = 1,
    Weak = 2,
}

GuideDefine.TriggerType = _triggerType
GuideDefine.LimitDataType = _limitDataType
GuideDefine.OperateType = _operateType
GuideDefine.ContextKey = _contextKey
GuideDefine.GuideType = _guideType