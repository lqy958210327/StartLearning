local UIMiscConfig = ConstTable.UIMiscConfig
local ResHeroVocal = DataTable.ResHeroVocal


local AudioCueMediator = {}
local self = AudioCueMediator

local GROUP_VOCAL = {
    [Const.HERO_VOCAL_ULTIMATEX1] = true,
    [Const.HERO_VOCAL_ULTIMATESHORTX1] = true,
    [Const.HERO_VOCAL_ULTIMATEX2] = true,
    [Const.HERO_VOCAL_ULTIMATESHORTX2] = true,
}

-------------------- BGM ------------------------------

-- 设置基准的BGM，在各种“需要播放默认音乐”的场合播放此音乐
function AudioCueMediator.setBaseBGM( bgmId )
    -- logerror("wy..........setBaseBGM", bgmId )
    self.baseBGM = bgmId
end








-----------------Vocal---------------------
function AudioCueMediator.heroHasVocal( heroId, vocalType )
    return ResHeroVocal[heroId]~=nil and ResHeroVocal[heroId][vocalType]~=nil
end

--function AudioCueMediator.playHeroVocal( heroId, vocalType, fashionTag )
--    if self.heroHasVocal( heroId, vocalType ) then
--        if GROUP_VOCAL[vocalType] then
--            self.playGroupVocal(ResHeroVocal[heroId][vocalType], fashionTag)
--        else
--        end
--    end
--end

-- play vocal by id
function AudioCueMediator.playVocal( vocalId)
    CueManager.audioMgr:playVocal( vocalId)
end

---- play vocal by group id
---- 由于Group在c#层组织组织path，所以暂时不支持时装替换
--function AudioCueMediator.playGroupVocal( groupId, fashionTag )
--    if CueManager.audioMgr:hasGroup(groupId) then
--        CueManager.audioMgr:playVocalGroup(groupId)
--    else
--        CueManager.audioMgr:playVocalById(groupId, nil, fashionTag)
--    end
--end



-----------------UISfx---------------------
function AudioCueMediator.playUISfx( path, priority, volume )
    CueManager.audioMgr:playUISfx( path, priority, volume )
end

-----------------Noise---------------------
-- 目前只支持场景播放noise，退出场景关闭
function AudioCueMediator.playNoise( noiseId )
    CueManager.audioMgr:playNoiseById(noiseId)
end

function AudioCueMediator.stopNoise(  )
    CueManager.audioMgr:stopNoise()
end

--


--
function AudioCueMediator.setAudiosMute( isMute )
    for _, path in ipairs(UIMiscConfig.PERFORM_MUTE_AUDIOS) do
        CueManager.audioMgr:setMuteByPath( path, isMute )
    end
end

-----------------Settings---------------------
function AudioCueMediator.setVocalLanguage( langStr )
    CueManager.audioMgr:setVocalLanguage(langStr)
end

function AudioCueMediator.changeSettingVolume( volumeType, settingBaseVolume )
    CueManager.audioMgr:changeSettingVolume( volumeType, settingBaseVolume )
end

return AudioCueMediator
