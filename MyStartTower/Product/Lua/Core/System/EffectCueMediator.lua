

local EffectCueMediator = {}




--------------Pause & Resume----------------
function EffectCueMediator.pauseEffectGroup(logicTag)
    CueManager.effectMgr:pauseEffectGroup(logicTag)
end

function EffectCueMediator.resumeEffectGroup(logicTag)
    CueManager.effectMgr:resumeEffectGroup(logicTag)
end

--------------Hide & Reshow------------------
function EffectCueMediator.hideEffectGroup(logicTag)
    CueManager.effectMgr:hideEffectGroup(logicTag)
end

function EffectCueMediator.reshowEffectGroup(logicTag)
    CueManager.effectMgr:reshowEffectGroup(logicTag)
end

---------------Preload
function EffectCueMediator.changePoolCleanCount( cleanCount )
    CueManager.effectMgr:changePoolCleanCount( cleanCount )
end

return EffectCueMediator