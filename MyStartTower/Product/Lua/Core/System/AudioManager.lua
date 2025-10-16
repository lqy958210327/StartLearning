-- TODO: 各种表以及功能的补全

local strClassName = "AudioManager"
local AudioManager = Class(strClassName)

local AudioHub = Framework.AudioSystem.AudioHub
local AudioFactory = Framework.AudioSystem.AudioFactory
local AudioType = Framework.AudioSystem.AudioType
local ResBgNoise = DataTable.ResBgNoise
local ResVoiceConfig = DataTable.ResVoiceConfig
local ResAudioGroup = DataTable.ResAudioGroup
local LackVocal = EditorTable.LackVocal

AudioManager.FootStepSubGroupId = 1

function AudioManager:ctor()
    assert(AudioManager._instance == nil, "[ERROR] The AudioManager instance is created already!")
    self:init()
end

function AudioManager:init(  )
    self.audioSources = {} -- key:AudioType value:AudioSource
    self:initLackVocalPaths()
    self:initAudioGroup()
    self:initPingPongTable()

end

function AudioManager:destroy()
    AudioFactory.CleanAllAudio()
    AudioHub.Destroy()
end

-------------原子操作--------------------------


function AudioManager:releaseAudio( audioPath )
    AudioFactory.ReleaseAudio(audioPath)
end

function AudioManager:cleanAllLoadedSFX(  )
    AudioFactory.ReleaseAudioByType(AudioType.SFX)
    -- AudioFactory.ReleaseAudioByType(AudioType.UISfx)
    -- AudioFactory.ReleaseAudioByType(AudioType.Music)
    AudioFactory.ReleaseAudioByType(AudioType.Vocal)
    -- AudioFactory.ReleaseAudioByType(AudioType.Noise)
end



-- Noise
function AudioManager:playNoise( noisePath, resVolume )
    if not resVolume or resVolume<0 or resVolume>1 then
        resVolume = 1
    end
    self.curNoiseResVolume = resVolume
    AudioHub.PlayFloorNoiseByPath( noisePath, resVolume )
end

function AudioManager:stopNoise(  )
    AudioHub.StopFloorNoise()
end

-- UI
function AudioManager:playUISfx( path, properity, resVolume )
    if not properity then
        properity = 0
    end
    if not resVolume or resVolume<0 or resVolume>1 then
        resVolume = 1
    end
    self.curUISfxResVolume = resVolume
    AudioHub.PlayUISfxByPath(path, properity, resVolume)
end





function AudioManager:setMuteByPath( path, mute )
    AudioHub.SetMuteByPath(path, mute)
end

function AudioManager:_getAudioSource( audioType )
    if not self.audioSources[audioType] then
        self.audioSources[audioType] = AudioHub.GetAudioSource(audioType)
    end
    return self.audioSources[audioType]
end

----------------Public---------------------
function AudioManager:changeSettingVolume( volumeType, settingBaseVolume )
    local resVolume
    if volumeType == AudioType.Music then
        resVolume = self.curMusicResVolume
    elseif volumeType == AudioType.SFX then
        resVolume = self.curSFXResVolume
    elseif volumeType == AudioType.UISfx then
        resVolume = self.curUISfxResVolume
    elseif volumeType == AudioType.Noise then
        resVolume = self.curNoiseResVolume
    elseif volumeType == AudioType.Vocal then
        resVolume = 1
    end
    resVolume = resVolume or 1
    AudioHub.SetSettingVolume(volumeType, settingBaseVolume, resVolume)
end

local function _getVolumeValue( resData, defaultData )
    if not resData then
        return defaultData
    else
        resData = resData / 10000
        return resData
    end
end



function AudioManager:setVocalLanguage( langStr )
    AudioHub.SetVocalMultilingualism(langStr or "")
end




function AudioManager:getBGMVolume(  )
    local source = self:_getAudioSource( AudioType.Music )
    if source then
        return source.volume
    end
end


function AudioManager:playNoiseById( noiseId )
    local cueData = ResBgNoise[noiseId]
    if not cueData or not cueData["path"] then
        return
    end
    local noisePath = cueData["path"]
    local resVolume = _getVolumeValue(cueData["volume"], 1)
    self:playNoise(noisePath, resVolume)
end

function AudioManager:playVocal( vocalId)
    local cueData = ResVoiceConfig[tonumber(vocalId)]
    if not cueData or not cueData["path"] then
        return
    end
    local voicePath = cueData["path"]
    local resVolume = _getVolumeValue(cueData["volume"], 1)
    local priority = cueData["priority"] or 0


    if not priority then
        priority = 0
    end
    if not resVolume or resVolume<0 or resVolume>1 then
        resVolume = 1
    end
    self.curVocalResVolume = resVolume
    LuaCallCs.Audio.AudioPlayVoice(voicePath, priority, resVolume)
end

-----------------Lack Vocal---------------------
function AudioManager:initLackVocalPaths(  )
    AudioHub.SetLackVocals(LackVocal)
end

------------------Audio Group--------------------
function AudioManager:initAudioGroup( )
    self.groupIdDict = {}
    local clipList = {}
    local weightList = {}
    local volumeList = {}
    local priorityList = {}
    for groupId,groupInfo in pairs(ResAudioGroup) do
        self.groupIdDict[groupId] = true

        clipList = {}
        weightList = {}
        volumeList = {}
        priorityList = {}
        for index, audioInfo in ipairs(groupInfo) do
            table.insert(clipList, audioInfo["path"] or "")
            table.insert(weightList, audioInfo["weight"] or "0")
            table.insert(volumeList, audioInfo["volume"] or "10000")
            table.insert(priorityList, audioInfo["priority"] or "-1")
        end
        AudioHub.InitAudioGroups(groupId, clipList, weightList, volumeList, priorityList)
    end
end



---------------战场音效管理------------------------------
function AudioManager:initPingPongTable(  )
    self.sfxPingPongDict = {}
end




function AudioManager:setSfxSpeed( speed )
    AudioHub.SetPitch(AudioType.SFX, speed)
end
------------------------------------------------


return AudioManager