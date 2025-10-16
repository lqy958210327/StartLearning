


-- 系统
-- 描述：底层系统模块


require("Framework/Game/System/Define")
require("Framework/Game/System/GameUpdate")
require("Framework/Game/System/GameSystem")


-- 扩展的系统模块

-- 场景管理器
require("Framework/Game/System/SceneManager/SceneData")
require("Framework/Game/System/SceneManager/SceneManager")

-- 剧情系统
require("Framework/Game/System/Plot/require_list")

-- SkillTime系统
require("Framework/Game/System/SkillTime/SkillTimeMgr")
require("Framework/Game/System/SkillTime/SkillTimeHelper")
require("Framework/Game/System/SkillTime/SkillTimeComponent")
require("Framework/Game/System/SkillTime/SkillTimeEntity/SkillTimeEntity")

-- 相机管理器
require("Framework/Game/System/CameraMgr/CameraMgr")
require("Framework/Game/System/CameraMgr/Define")

-- 计时器
require("Framework/Game/System/Timer/TimerData")
require("Framework/Game/System/Timer/TimerSystem")

-- Entity + Component
require("Framework/Game/System/EC/require_list")

-- 舞台管理模块
require("Framework/Game/System/ScenicControlMgr")
require("Framework/Game/System/ScenicManager/require_list")

-- 游戏进程管理模块
require("Framework/Game/System/GameProgress/require_list")

-- 游戏进程管理模块
require("Framework/Game/System/AutoFight/AutoFightSystem")
require("Framework/Game/System/AutoFight/Define")

-- 计时器
require("Framework/Game/System/Chronos/ChronosData")
require("Framework/Game/System/Chronos/ChronosSystem")

-- 新手引导
require("Framework/Game/System/Guide/require_list")

-- 
require("Framework/Game/System/CommonReward/CommonRewardSystem")
require("Framework/Game/System/CommonReward/CommonRewardData")

-- 技能CutIn管理器
require("Framework/Game/System/SkillCutIn/SkillCutInMgr")

-- AudioSystem
require("Framework/Game/System/AudioSystem/AudioSystem")

-- 充值系统
require("Framework/Game/System/RechargeSystem/require_list")

