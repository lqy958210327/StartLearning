-- EffectManager不同于其他效果mgr，不隶属于CueManager
---------------------------------------------------------------
-- 关于特效生命周期的分类 Const.EFFECT_LIFE_MODE
-- StateControl. 逻辑管理, 随状态清除
-- LogicControl. 逻辑管理, 不随状态清除, 逻辑保证回收
-- JustPlay. 不受逻辑管理, 自生自灭
---------------------------------------------------------------
local strClassName = "EffectManager"
local EffectManager = Class(strClassName)

local EffectLifeMode = Const.EFFECT_LIFE_MODE


local EffectFactory = Framework.EffectSystem.EffectFactory
local GameSettings = require "Core/Helper/GameSettings"

function EffectManager:ctor()
    assert(EffectManager._instance == nil, "[ERROR] The EffectManager instance is created already!")
    self:_init()
end

function EffectManager:_init(  )
    EffectFactory.Init()
    self.effectInstancesDict = {}
    self.needTurnonDict = {}  -- 在加载过程中的特效，可以先用insId记录加载后默认开启，节省一个callback
end

function EffectManager:destroy()
    EffectFactory.Destroy()
    self.effectInstancesDict = nil
end



--------------------Release----------------------
function EffectManager:releaseEffect( insId )
    if not insId then
        print("Try to release a null instance id.")
        return
    end
    EffectFactory.ReleaseEffect(insId)
    if self.effectInstancesDict[insId] then
        self.effectInstancesDict[insId] = nil
    end
    self.needTurnonDict[insId] = nil
end

function EffectManager:despawnUnuseEffect(  )
    EffectFactory.CleanDespawnedEffect()
end

----------------------Get-----------------------------
function EffectManager:getController( insId )
    if self.effectInstancesDict[insId] then
        return self.effectInstancesDict[insId]
    end
end

--------------Pause & Resume----------------
function EffectManager:pauseEffectGroup( logicTag )
    EffectFactory.BatchProcessPause(logicTag, true)
end

function EffectManager:resumeEffectGroup( logicTag )
    EffectFactory.BatchProcessPause(logicTag, false)
end

--------------Hide & Reshow------------------
function EffectManager:hideEffectGroup( logicTag )
    EffectFactory.BatchProcessHide(logicTag, true)
end

function EffectManager:reshowEffectGroup( logicTag )
    EffectFactory.BatchProcessHide(logicTag, false)
end

-----------------特殊的播放接口






function EffectManager:_getLogicGroupByMode( mode, extraParam )
    if not mode or mode == EffectLifeMode["JustPlay"] then
        return -1
    elseif mode == EffectLifeMode["StateControl"] then
        return 0
    else
        return extraParam
    end
end

----------------Set Pool



---------Batch process
function EffectManager:batchReleaseEffects( logicGroup )
    EffectFactory.BatchProcessRelease(logicGroup)
end



---------------Preload


function EffectManager:changePoolCleanCount( cleanCount )
    EffectFactory.ChangePrefabPoolCleanCount(cleanCount)
end








return EffectManager