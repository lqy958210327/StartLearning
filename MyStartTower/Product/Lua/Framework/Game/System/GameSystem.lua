


---@class GameSystem
GameSystem = {}

GameSystem.Init = function()
    SystemHelper.Init()

    -- 业务侧自己扩展自己的系统模块
    SystemHelper.RegisterSystem(SystemID.Scene, SceneManager())
    SystemHelper.RegisterSystem(SystemID.SkillTime, SkillTimeMgr())
    SystemHelper.RegisterSystem(SystemID.Camera, CameraMgr())
    SystemHelper.RegisterSystem(SystemID.EntityManager, EntityManager())
    --SystemHelper.RegisterSystem(SystemID.ScenicManager,ScenicControlMgr())
    SystemHelper.RegisterSystem(SystemID.ScenicManager,ScenicManager())
    SystemHelper.RegisterSystem(SystemID.Timer,TimerSystem())
    SystemHelper.RegisterSystem(SystemID.Plot, PlotManager())
    SystemHelper.RegisterSystem(SystemID.GameProgress,GameProgressManager())
    SystemHelper.RegisterSystem(SystemID.AutoFight,AutoFightSystem())
    SystemHelper.RegisterSystem(SystemID.Chronos,ChronosSystem())
    SystemHelper.RegisterSystem(SystemID.Guide,GuideSystem())
    SystemHelper.RegisterSystem(SystemID.CommonRewardSystem,CommonRewardSystem())
    SystemHelper.RegisterSystem(SystemID.SkillCutIn, SkillCutInMgr())
    SystemHelper.RegisterSystem(SystemID.AudioSystem, AudioSystem())
    SystemHelper.RegisterSystem(SystemID.RechargeSystem, RechargeSystem())
end

GameSystem.Clear = function()
    SystemHelper.Clear()
end

GameSystem.GameStart = function()
    SystemHelper.GameStart()
end

GameSystem.GameEnd = function()
    SystemHelper.GameEnd()
end

