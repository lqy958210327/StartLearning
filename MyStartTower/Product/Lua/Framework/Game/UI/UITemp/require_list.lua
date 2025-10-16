

-- UI模板库：
-- 描述：这是代码层面的UI模板库，不是工程里的 UITemplate文件夹的prefab，注意区分概念
-- 功能：游戏里有很多可以模板化的小UI组件(如：英雄卡牌，物品Item，玩家头像等)，给这些小组件设置数据，需要统一的接口，UI模板库就负责实现这些接口
-- 核心目的：1.简化业务侧的代码逻辑，提高开发速度
--         2.降低代码耦合
--
-- 注意：1.UITemp里的代码属于公用代码，不能引用业务侧的代码，可以引用其他公共模块的代码
--        (例如：UITemp里定义了一个接口来设置英雄卡牌，需要英雄数据结构作为参数，那么这个英雄数据结构是黑板系统里定义的，不是英雄DB里定义的)
--      2.UITemp需要积累，积累的越多，业务侧开发速度越快

-- 通用未分类的
require("Framework/Game/UI/UITemp/UITemp")

-- 英雄大卡牌
require("Framework/Game/UI/UITemp/UITempHeroCard")

-- 英雄小头像
require("Framework/Game/UI/UITemp/UITempSmallHeroHead")

-- 怪物小头像
require("Framework/Game/UI/UITemp/UITempSmallMonsterHead")

-- 通用物品
require("Framework/Game/UI/UITemp/UITempItem")

-- 人物头像信息
require("Framework/Game/UI/UITemp/UITempPlayerInfo")

-- 角色提示信息
require("Framework/Game/UI/UITemp/RoleTipsData")

-- 利姆鲁头像
require("Framework/Game/UI/UITemp/UITempRimuruHead")

-- PVP段位组件
require("Framework/Game/UI/UITemp/UITempPvpGrade")

-- 装备提示信息
require("Framework/Game/UI/UITemp/UIEquipTipsData")