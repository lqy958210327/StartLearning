---@class Enum
---@module Enum
---@comment 枚举值定义
---可以通过`Ability.Enum`引用，无需require此文件。

local Enum = {}

---@table SkillType
Enum.SkillType = {
    None = -1, -- -1=无(用于一些不想指定技能类型的效果，例如通用的DOT)
    LeaderSkill = 0, -- 0=队长技
    PuGong = 1, -- 1=普攻
    DaZhao = 2, -- 2=大招
    NengLiJi = 3, -- 3=战技
    BeiDong = 4, -- 4=被动
    ZhuanJing = 5, -- 5=专精
}

---@table ElemType
Enum.ElemType = {
    None = 0, -- 0、无
    Earth = 1, -- 1、地
    Ice = 2, -- 2、冰
    Fire = 3, -- 3、火
    Wind = 4, -- 4、风
    Light = 5, -- 5、光
    Dark = 6, -- 6、暗
}

Enum.ShieldType = {
    Max = 2
}

return Enum