local CueUIMediator = {}

-- ↓↓↓ uiEffectPlayer ↓↓↓ --

--function CueUIMediator.playUIEffect(effectPath, length, needMirror)
--    local player = UIManager.getUI("uiEffectPlayer", true)
--    local insId = player:playUIEfx(effectPath, length, needMirror)
--    return insId
--end

function CueUIMediator.stopUIEffect()
    --local player = UIManager.getUI("uiEffectPlayer", nil, false)
    --if player then
    --    player:setVisible(false)
    --end
end

-- ↑↑↑ uiEffectPlayer ↑↑↑ --

-- ↓↓↓ sequenceFramePlayer ↓↓↓ --

-- sequence frame
function CueUIMediator.playSequenceFrame(name, frameCount)


end

function CueUIMediator.stopSequenceFrame()


end

-- 2danimation
function CueUIMediator.play2DAnimation(animationPath)


end

function CueUIMediator.stop2DAnimation()


end

-- Video
function CueUIMediator.playUIVideo(url, mirror, endCallback, canSkip, muteBGM, needBg, endTime,screenSkip)


end

function CueUIMediator.stopUIVideo()


end

function CueUIMediator.pauseUIVideo()


end

function CueUIMediator.resumeUIVideo()


end

-- Realtime Stage
function CueUIMediator.playRealtimeStage(stagePath, actor, mirror)


end

-- ↑↑↑ sequenceFramePlayer ↑↑↑ --

return CueUIMediator