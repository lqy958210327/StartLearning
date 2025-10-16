


---@class AvgVideoPlayer : UIBaseWindow
local AvgVideoPlayer = Class("AvgVideoPlayer", UIControls.Window)

function AvgVideoPlayer:UILiftOnInit( ... )
    self:initUI()


    
end

function AvgVideoPlayer:initUI( ... )
    self.videoPanel = UIControls.Panel(self, "VideoPlayer")
    self.videoBlock = UIControls.Panel(self, "VideoPlayer/Block")
    local videoGO = self.videoPanel:getGameObject()
    if videoGO then
        self.videoPlayer = videoGO:GetComponent(MaterialVideoPlayer)
    end

    self.funcPanel = UIControls.Panel(self, "FuncPanel")
    self.skipBtn = UIControls.Button(self, "FuncPanel/BtnSkip","Text")
    self.skipBtn:setText(ConstTable.AvgString.btnSkip)
    self.skipBtn:addEventClick(self._onClickSkip)

    self.jumpBtn = UIControls.Button(self, "FuncPanel/BtnJump","Text")
    self.jumpBtn:setText(ConstTable.AvgString.btnSkip)
    self.jumpBtn:addEventClick(self._onClickJump)
    self.funcPanel:setVisible(true)

    -- 弹幕相关界面 begin-- 



    -- 弹幕相关界面 end--
end

function AvgVideoPlayer:hideSkip()
    self.funcPanel:setVisible(false)
end

----------------Main---------------------------

function AvgVideoPlayer:OnRegisterEvent()
    self:RegisterEventByID(UIEventID.avgVideoPlayer_Refresh, self.RefreshVideoData)
end

function AvgVideoPlayer:RefreshVideoData(videoPath, timeInSeconds, endCallback, speed, isJump, isClose)
    self:playVideoAvgByPath(videoPath, timeInSeconds, endCallback)
    
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "BtnJump", isJump)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "BtnSkip", isClose)
    
    self:SetVideoSpeed(speed)
end

function AvgVideoPlayer:RefreshAndSpeedVideoData(videoPath, speed, endCallback, isCanJump, isShowClose)
    self:playVideoAvgByPath(videoPath, 500000000, endCallback)
    
    self:SetVideoSpeed(speed)
    
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "BtnJump", not isNotJump)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "BtnSkip", not isNotClose)
end

function AvgVideoPlayer:playVideoAvgByPath(video_path, timeInSeconds, endCallback)
    self:playVideo(video_path)
    self.timeInSeconds = timeInSeconds
    self.endCallback = endCallback

end


function AvgVideoPlayer:_onVideoEnd(  )
    self.videoPanel:setVisible(false)

    self:setVisible(false)
    if self.endCallback then
        self.endCallback()
    end
end





function AvgVideoPlayer:_onClickSkip( ... )
    -- 可以点击这个skip的时候，是avg没在播放的时候
    -- 所以这里不可能会出现avgPlaying的情况
    if not self.avgPlaying then
        self:stopVideo()

    end
end

function AvgVideoPlayer:_onClickJump()
    -- 可以点击这个skip的时候，是avg没在播放的时候
    -- 所以这里不可能会出现avgPlaying的情况
    if not self.avgPlaying then
        self:seekToTime()
        EventManager.Global.Dispatch(EventType.PlotPause)
    end
end


---------------Main End-------------------------

------------------Video----------------------------
function AvgVideoPlayer:playVideo( url,subtitlesUrl )
    self.videoPanel:setVisible(true)
    if self.videoPlayer then
        local lang = RegionUtils.curLanguage
        local trackIdx = RegionConst.langTrackNum[lang]
        local subtitleIdxPath = not subtitlesUrl and "" or "UI/subtitle/"..lang.."/"..subtitlesUrl..".srt"
        self.videoPlayer:PlayVideo(url, Slot(self._onVideoEnd, self),trackIdx,subtitleIdxPath )
    end
end

function AvgVideoPlayer:stopVideo(  )
    if self.videoPlayer then
        self.videoPlayer:StopVideo()
    end 
    self:_onVideoEnd()
end

function AvgVideoPlayer:pauseVideo( ... )
    if self.videoPlayer then
        self.videoPlayer:PauseVideo()
        
        --- 暂停后，不能再次跳转， 取名界面需求，如果修改考虑这个问题
        LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnJump", false)
    end
end

function AvgVideoPlayer:resumeVideo( ... )
    if self.videoPlayer then
        self.videoPlayer:ResumeVideo()


    end
end

function AvgVideoPlayer:mirrorVideo( isMirror )
    if self.videoPlayer then
        self.videoPlayer:MirrorVideo(isMirror)
    end
end

function AvgVideoPlayer:seekToTime()
    if self.videoPlayer then
        self.videoPlayer:SeekToTime(self.timeInSeconds)
    end
end

function AvgVideoPlayer:seekAndStop()
    if self.videoPlayer then
        self.videoPlayer:SeekAndStop(self.timeInSeconds)
    end
end

function AvgVideoPlayer:loopVideo( isLoop )
    if self.videoPlayer then
        self.videoPlayer:LoopVideo(isLoop)
    end
end

function AvgVideoPlayer:SetVideoSpeed( speed )
    if self.videoPlayer then
        self.videoPlayer:SetVideoSpeed( speed )
    end
end
-----------------Video End-----------------------------




-- 弹幕相关  end--
return AvgVideoPlayer