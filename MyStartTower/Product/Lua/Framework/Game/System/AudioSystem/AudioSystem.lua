


---@class AudioSystem : SystemBase
AudioSystem = Class("AudioSystem", SystemBase)

function AudioSystem:OnInit()
    self._evtPlayMusic = function(source, volume, isLoop) self:_playMusic(source, volume, isLoop) end
    self._evtStopMusic = function() self:_stopMusic() end
    EventManager.Global.RegisterEvent(EventType.AudioSystemPlayMusic, self._evtPlayMusic)
    EventManager.Global.RegisterEvent(EventType.AudioSystemStopMusic, self._evtStopMusic)
end

function AudioSystem:OnClear()
    EventManager.Global.UnRegisterEvent(EventType.AudioSystemPlayMusic, self._evtPlayMusic)
    EventManager.Global.UnRegisterEvent(EventType.AudioSystemStopMusic, self._evtStopMusic)
end

function AudioSystem:OnGameStart()

end

function AudioSystem:OnGameEnd()

end

function AudioSystem:_playMusic(source, volume, isLoop)
    LuaCallCs.Audio.AudioFadeOutMusic(0, volume, Const.TWEEN_EASE.InOutQuad)
    LuaCallCs.Audio.AudioPlayMusicByPath(source, volume, isLoop)
end

function AudioSystem:_stopMusic()
    LuaCallCs.Audio.AudioStopMusic()
end