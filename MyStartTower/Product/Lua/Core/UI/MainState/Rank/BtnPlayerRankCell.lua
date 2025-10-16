--local Circle = require "Core/Common/Object/Circle"
local BtnPlayerRankCell = {}

function BtnPlayerRankCell:ctorMixin()
    self:initUI()
end

function BtnPlayerRankCell:initUI()
    self.imgBg = UIControls.Image(self,"BgPanel/Bg")
    self.imgBgPanel = UIControls.Image(self, "BgPanel" )
    self.txtPlayerName = UIControls.Label(self,"BgPanel/TextPlayerName")
    self.txtRankNum = UIControls.Label(self,"BgPanel/TextRankNum")
    self.txtRankNone = UIControls.Panel(self,"BgPanel/TextRankNone")
    self.txtTime = UIControls.Label(self,"BgPanel/TextTime")
    -- self.txtScoreTitle = UIControls.Label(self,"BgPanel/TextTitleRank")
    self.txtScore = UIControls.Label(self,"BgPanel/TextNumRank")
    if UIControls.checkControlFunc(self,"BgPanel/TextServer") then
        self.txtServer = UIControls.Label(self,"BgPanel/TextServer")
    end
    self.imgRank = UIControls.Image(self,"BgPanel/ImgRank")
    self.imgSelf = UIControls.Image(self,"")
end

function BtnPlayerRankCell:setData(data,idx)
    self.data = data
    self.idx = idx
    local rankBgSprite = (self.data.rank <= 3 and self.data.rank >= 1) and "BgRank"..self.data.rank or "BgRankOther"
    if self.data.rankType == Const.RANK_TYPE_MULTIPVP or self.data.rankType == Const.RANK_TYPE_OPACTPVP then
        local rankBgPanelSprite = (self.data.rank <= 3 and self.data.rank >= 1) and "BgRanking"..self.data.rank or "BgRankingOther"
        self.imgBgPanel:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2",rankBgPanelSprite)
        self.imgBg:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2",rankBgSprite)
    else
        self.imgBg:setImage("Atlas/OtherBattleAtlas/AsynPVPAtlas",rankBgSprite)
    end
    self.txtRankNum:setVisible(self.data.rank > 3)
    self.txtRankNum:setText(self.data.rank)
    self.txtRankNone:setVisible(self.data.rank <= 0)
    self.imgRank:setVisible(self.data.rank >= 1 and self.data.rank <= 3)
    if self.data.rank >= 1 and self.data.rank <= 3 then
        if self.data.rankType == Const.RANK_TYPE_MULTIPVP or self.data.rankType == Const.RANK_TYPE_OPACTPVP then
            self.imgRank:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2","IconRank"..self.data.rank)
        else
            self.imgRank:setImage("Atlas/OtherBattleAtlas/AsynPVPAtlas","IconRank"..self.data.rank)
        end
    end
    if self.data.data.comm.uid == CurAvatar.uid then
        self.data.data.comm = nil
    end
    local commonData = self.data.data
    if commonData.tick > 0 then
        if self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER or self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_FEAT then
            local txtTimeTitleStr = self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER and "通关时间：%s" or "挑战时间：%s"
            self.txtTime:setText(string.format(txtTimeTitleStr, os.date("%Y/%m/%d %H:%M:%S", commonData.tick)))--os.date("%Y.%m.%d",commonData.tick))
        else
            self.txtTime:setText(string.format("挑战时间：%s", TimeUtils.getDeadlineStr(commonData.tick ,true)))--os.date("%Y.%m.%d",commonData.tick))
        end
    end
        --自己排名的cell的话没有idx，隐藏txtTime。。
    self.rankUIInfo = UIConst.RANK_UI_INFO[self.data.rankType]
    self.txtTime:setVisible((self.idx ~= nil) and not self.rankUIInfo.hideTime)
    if self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
        self.playerName = commonData.comm.name
    else
        self.playerName = ""
        self.svrName = ""
    end
    self.txtPlayerName:setText(self.playerName)
    if self.txtServer then
        self.txtServer:setVisible(self.rankUIInfo.showSvrName ~= nil)
        if self.rankUIInfo.showSvrName ~= nil then
            self.txtServer:setText(string.format("服务器：%s", self.svrName))
        end
    end
    -- self.txtScoreTitle:setText(UIConst.RANK_UI_INFO[self.data.rankType].title)
    self.txtScore:setText(UIConst.getRankScoreStr(self.data.rankType,commonData.score))
    if self.txtPower then
        self:refreshPower(commonData.power or 0)
    end
    self:chekReplayData()
end




function BtnPlayerRankCell:chekReplayData( ... )
    if self.data.rankType == Const.RANK_TYPE_WORLDBOSS or Const.RANK_TYPE_BOSS_EXPAND_MAP[self.data.rankType] then
        --由于有的排行榜数据不是走的通用的逻辑，新增的字段如果写在上面通用的逻辑里会报错，所以写在需要这个字段的地方
        self.replayId = self.data.data.replay_id
        if self.btnReplay ==nil then
            self.btnReplay = UIControls.Button(self, "BgPanel/BtnReplay")
            self.btnReplay:addEventClick(self.onBtnReplayClick)
            self.imgLine = UIControls.Image(self, "BgPanel/ImgLine")
        end
        if self.data.rankType == Const.RANK_TYPE_WORLDBOSS then
            if self.data.data.comm.uid == CurAvatar.uid then
                local actData = CurAvatar:getWorldBossActData()
                if actData then 
                    self.replayId = actData:getReplayId()
                end
            end
        end
        if self.replayId == "0" then
            self.btnReplay:setVisible(false)
            self.imgLine:setVisible(false)
        else
            self.btnReplay:setVisible(true)
            self.imgLine:setVisible(true)
        end
    end
end

function BtnPlayerRankCell:onBtnReplayClick( ... )
    if self.replayId == nil or self.replayId == "0" then
        MsgManager.clientNotice(333)
        return
    end
    
    if self.data.rankType == Const.RANK_TYPE_WORLDBOSS then
        CurAvatar.cachedWorldBossRecord = {}
        CurAvatar.cachedWorldBossRecord.name = self.playerName
        RPC.pVEBattleReplay(self.replayId, BattleConst.BATTLE_TYPE_WORLD_BOSS)
    --elseif Const.RANK_TYPE_BOSS_EXPAND_MAP[self.data.rankType] then
        --CurAvatar.cachedBossExpandRecord = {}
        --CurAvatar.cachedBossExpandRecord.levelId = self.data.data.param
        --RPC.pVEBattleReplay(self.replayId, BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND)
    end
end


return BtnPlayerRankCell