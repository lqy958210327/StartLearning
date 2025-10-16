
local tab = {}

function tab.AudioPlayMusicByPath(path, volume, isLoop)
    CS_LuaCallCs.AudioPlayMusicByPath(path, volume, isLoop)
end

function tab.AudioFadeOutMusic(duration, endVolume, fadeEase)
    CS_LuaCallCs.AudioFadeOutMusic(duration, endVolume, fadeEase)
end

function tab.AudioStopMusic()
    CS_LuaCallCs.AudioStopMusic()
end

function tab.AudioPlaySFX(sfxPath, resVolume)
    if not resVolume or resVolume <0 or resVolume > 1 then
        resVolume = 1
    end
    CS_LuaCallCs.AudioPlaySFX(sfxPath, 0, resVolume)
end

function tab.AudioStopSFX()
    CS_LuaCallCs.AudioStopSFX()
end

function tab.AudioPlayVoice(path, prop, resVolume)
    CS_LuaCallCs.AudioPlayVoice(path, prop, resVolume)
end

function tab.AudioStopVoice()
    CS_LuaCallCs.AudioStopVoice()
end

LuaCallCs.Audio = tab
