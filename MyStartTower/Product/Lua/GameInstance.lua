

---@class Game
Game = {}

function Game.GameProgressInit()
    -- 游戏实例生命周期接口, 游戏初始化时调用, 程序启动后只调用一次
    print("---   Lua流程：GameInstance流程 -- Init    Game.GameProgressInit()")

    Blackboard.Init()
    GameDB.Init()
    EventManager.Init()
    GameSystem.Init()
    --LuaCallCs.AdvanceLoadAllTypeBattleNum(10)

    --------------------老代码
    -- 游戏状态
    GameFsm.ctor()
    -- UI
    UIManager.init()


    -- 音效特效
    CueManager.initCueManager()
    -- SDK模块开始
    SDKAgent.onGameStart()

    Util.GameQuality.InitGameQuality()

    -- 转移自 GameStateLogin
    local GameSettings = require "Core/Helper/GameSettings"
    GameSettings.initGameSettings(  )
    local DeviceHelper = require("Core/Helper/DeviceHelper")
    DeviceHelper.resetGCTimer()
    -- 启动之后设置屏幕分辨率
    DeviceHelper.setRenderResolution()
    DeviceHelper.initLoaderMemoryControl()



    -- 初始化各类Manager
    --[[gzw 精简登录流程
    SvrListManager.init()
    ]]




    CustomShadowManager.init()
    CameraModeManager.initCameraControllerNode()
    CameraModeManager.init()
    math.randomseed(os.time())

    -- 转移自 GameStateLogin
    -- shader的warmup移到lua
    -- DeviceHelper.tryWarmUpShader()
    UIManager.emulatorAdjust()
    UIManager.AdvanceLoad()
    --------------------老代码


    Game.Start()

    EventManager.Global.Dispatch(EventType.GameProgressChange, GameProgressID.SDK)
end

function Game.GameProgressDestroy()
    -- 游戏实例生命周期接口, 游戏销毁时调用, 程序启动后只调用一次
    print("---   Lua流程：GameInstance流程 -- Destroy    Game.GameProgressDestroy()")

    Blackboard.Clear()
    GameDB.Clear()
    EventManager.Clear()
    GameSystem.Clear()

    --------------------老代码
    -- 销毁状态
    GameFsm.destroy()
    -- 卸载加载中的场景
    --SceneMgr.destroy()



    -- 各种Manager销毁
    UIManager.destroy()
    CueManager.destroy()

    -- SDK模块清理
    SDKAgent.onGameStop()

    -- TODO:临时逻辑 亟待清理
    -- local UIModelStageLogic = require("Game/Logic/UIModelStageLogic")
    -- UIModelStageLogic:releaseSceneObj()

    -- 清理回调
    local GameSettings = require "Core/Helper/GameSettings"
    GameSettings.clearCallback()
    local DeviceHelper = require("Core/Helper/DeviceHelper")
    DeviceHelper.clearCallback()

    CustomShadowManager.destroy()
    CameraModeManager.destroy()
    --------------------老代码
end


function Game.GameProgressStart()
    -- 游戏实例生命周期接口, 游戏开始时调用(不等于登录游戏)
    -- 程序启动后会调用多次
    -- 这里做的简单点，游戏实例初始化完毕后调用一次，游戏结束后调用一次
    print("---   Lua流程：GameInstance流程 -- Start    Game.GameProgressStart()")

    GameSystem.GameStart()
    Blackboard.ClearCache()
    GameDB.Clear()
    GameDB.RegisterDB()
    UIManager.setUIResident()--这个接口不该调用多次，由于UI管理器的处理方式不好，这个接口只能多次调用，效率和功能上没有任何区别
end

function Game.GameProgressStop()
    -- 游戏实例生命周期接口, 游戏结束时调用(等价退出登录)
    -- 程序启动后会调用多次
    print("---   Lua流程：GameInstance流程 -- Stop    Game.GameProgressStop()")


    UIManager.ClearUICache()
    GameSystem.GameEnd()
    GameDB.Clear()
    GameDB.RegisterDB()
end



------------------------------------------------------------------------------------老代码
-- 游戏暂停的时候被会调用到，比如进程被切到后台
function Game.OnGamePause()

end

-- 游戏从后台被调到前台会调用的逻辑
function Game.OnGameResume()

end

-- 进入初始状态（编辑器可能会重写此方法 ！！！不要修改此处逻辑！！！）
function Game.Start()
    -- 切换状态
    GameFsm.InterfaceTranslateState(Const.STATE_LOGIN)
end

-- 进入重启状态
function Game.Reload()
    -- 调C#重置接口
    CS.Framework.Tools.LuaToolkit.ReloadGame()
end

-- 退出游戏
function Game.Quit()
    -- 调C#退出接口
    CS.Framework.Tools.LuaToolkit.QuitApplication()
end
