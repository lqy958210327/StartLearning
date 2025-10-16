local UserData = require "Core/Helper/UserData"
local EventConst = require ("Core/EventConst")
local ResClientNotice = DataTable.ResClientNotice

local ResItem = require "Core/ClientData/ResItem"




local MsgManager = {}
local MAX_PERSONAL_RECORD=50--每个人存储的聊天记录
local MAX_SHIELD_COUNT=50   --屏蔽人数
local SAVE_COUNTER=
{
    [Const.CHANNEL_WORLD] = 10,
    [Const.CHANNEL_GUILD] = 30,
    [Const.CHANNEL_PRIVATE] = 10,
}--每收到多少条私聊信息保存一次,所有频道都这样保存一下，不然杀进程的方式没有办法判断是否是读过的消息
local SAVE_INTERVAL=300--收到消息时检查上一次保存时间到现在如果超过这个时间则保存一次
local self = MsgManager
-- 成员变量。

local UserDataKey = "chat_save"
local bulletDatakey="Bullet_save"
local UserDataCount = 300   --最大记录信息条目
local SEND_CD = {
    [Const.CHANNEL_WORLD] = 0,
    [Const.CHANNEL_GUILD] = 2,
    [Const.CHANNEL_SHOUT] = 1,
}

self.receivers = {}
self.mMsgDatas = {}
self.privateRepeatMap = {}
self.mSendCDInfo = {}

function MsgManager.initMsg()
    self._initCounter()
    self._loadMsg()
    --self.bulletTimeStamp=math.max(self.bulletTimeStamp or 0,os.time())
    --断线重连时清除弹幕
    --local bulletDlg=UIManager.getUI("bulletDlg",nil,false)
    --if bulletDlg then
    --    bulletDlg:clearAll()
    --end

    for i, receiver in ipairs(self.receivers) do
        receiver:update()
    end
    --self.counter=0

end

function MsgManager._initCounter( ... )
    self.counter={}
    self.shieldDic={}--屏蔽列表
    self.saveTime=os.time()
    if self.curUid == nil or self.curUid ~= CurAvatar.uid then
        self._loadBulletConfig()
    end
    self.curUid = CurAvatar.uid
    ----print("stiger---------------------------------------------------initcounter")
    for i,channelData in ipairs(Const.CHANNEL_TABS) do
        self.counter[channelData.sendChannel]=0
    end
    self.getBulletChannels()--因为弹幕那边和这边不一定谁先运行，如果这边先运行，则这边保证一下

end

function MsgManager._loadMsg()
    self._puid=CurAvatar.uid
    self.mMsgDatas = {}
    self.privateRepeatMap = {}
    local saveInfo = UserData.loadCommonData(CurAvatar.uid.. UserDataKey)
    if saveInfo == nil then
        return
    end
    ------print(saveInfo)
    saveInfo = utils.unserialize(saveInfo)
    local isNewMsg=false--是否存在没看过的消息
    --local test={}
    if saveInfo ~= nil then
        --self.saveMsg()--清空记录
        if saveInfo.uid == self._puid and saveInfo.msgs ~= nil then
            -- VoiceManager.cleanVoiceFiles(saveInfo.msgs)
            for i, msg in ipairs(saveInfo.msgs) do
                if msg.time == nil then
                    msg.time = 0
                end
                if msg.is_unread then--只要有一条新的就要做红点提示，具体消除红点的逻辑在私聊里面做
                    isNewMsg=true
                    --print("stiger------------zheli读取消息新")
                end
                ------print("从本地加载了一条消息")
                --table.insert(self.mMsgDatas, msg)
                self._addMsg(msg)
                self.privateRepeatMap[msg.seq] = true
            end
        end
        self.notFriends=saveInfo.friendInfos or {}
        self.shieldDic=saveInfo.shieldDic or {}
    end

end
--规则：每个uid最多存储50条聊天记录，只为前20个聊天对象存储
function MsgManager.saveMsg()
    if not CurAvatar or not CurAvatar.uid then
        return
    end
    print("stiger--------33333333333保存聊天信息")
    self.saveTime=os.time()
    ------------------------↑----------------------------------------------------
    local saveData = {}
    saveData.uid = self._puid
    local checkRepeat={count=0}
    local msgs = {}
    local index = 0
    local privateMsgs=self.mMsgDatas[Const.CHANNEL_PRIVATE] or {}
    local len = #privateMsgs
    ------print("保存前的消息数：",len)
    for i = 1, len do
        index = len - i + 1
        local msgItem = privateMsgs[index]
        if msgItem ~= nil then
            --msgItem.is_unread = true
            --------print("保存一条私聊消息")
            ----print("原先消息是新的：",msgItem.is_unread,msgItem.content)
            local uid=0
            if msgItem.ruid==CurAvatar.uid then
                uid=msgItem.suid
            else
                uid=msgItem.ruid
            end
            if ClientUtils.record.checkRecord[uid] then
                if msgItem.is_unread then--如果已经判断为新消息，那么再次检查重新判断一下，红点容易出问题
                    msgItem.is_unread=(msgItem.suid~=CurAvatar.uid and  msgItem.time>ClientUtils.record.checkRecord[uid].time)
                end
            end
            ----print("之后处理过的消息是新的：",msgItem.is_unread,msgItem.content)
            if checkRepeat[uid]  then
                if checkRepeat[uid]<MAX_PERSONAL_RECORD then
                    table.insert(msgs, 1, msgItem)
                    checkRepeat[uid]=checkRepeat[uid]+1
                end
            elseif checkRepeat.count<Const.MAX_PRIVATE_FRIEND then
                checkRepeat[uid]=1
                checkRepeat.count=checkRepeat.count+1
                table.insert(msgs, 1, msgItem)
            end
        end
        if #msgs >= UserDataCount then
            break
        end
    end

    local friends={}
    for uid,info in pairs(checkRepeat) do
        if self.notFriends and  self.notFriends[uid] then
            friends[uid]=self.notFriends[uid]
        end
    end
    saveData.shieldDic=self.shieldDic
    saveData.friendInfos=friends
    saveData.msgs = msgs
    UserData.saveCommonData(CurAvatar.uid.. UserDataKey, utils.serialize(saveData))
    self.saveBulletConfig()
end

function MsgManager.onAccountChange( ... )
    self.saveMsg()
end

function MsgManager.clearMsgByChannel( cid )
    if cid then
        if self.mMsgDatas[cid] then
            self.mMsgDatas[cid] = {}
        end
    end
end

function MsgManager.isPrivateRepeat( seq )
    return self.privateRepeatMap[seq] == true
end
--获取私聊消息本地保存的最新的seq
function MsgManager.getNewestPrivateSeq( ... )
    local data = self.mMsgDatas[Const.CHANNEL_PRIVATE]
    if data and #data > 0 then
        local msg = data[#data]
        return msg.seq
    else
        return "1420750023695540201"--这个是7月29日左右的
    end
end

function MsgManager._getLastMsgTime( channel )
    if self.mMsgDatas then
        local data = self.mMsgDatas[channel]
        if data and #data > 0 then
            return data[#data].time
        end
    end
    return -1
end

function MsgManager._addMsg( msg)
    self.mMsgDatas[msg.channel]=self.mMsgDatas[msg.channel] or {}
    local data=self.mMsgDatas[msg.channel]
    --print("stiger----------managerprecount",#data)
    self.checkMsgCount(data, msg.channel)
    --print("stiger-----------manangeraftercount",#data)
    local len = #data
    if len == 0 or data[len].time <= msg.time then
        table.insert(data, msg)
    else
        local idx = 1
        for i = 0, len - 1 do
            local item = data[len -i]
            if item.time <= msg.time then
                idx = len -i + 1
                break
            end
        end
        table.insert(data, idx, msg)
    end
end

function MsgManager.checkMsgCount( msgDatas , channel )
    if msgDatas == nil or channel == nil then
        return
    end
    local limitCount ,removeNum = self.getMsgLimitCount(channel)
    if #msgDatas >= limitCount then
        for i = 1, removeNum  do
            table.remove(msgDatas, 1)
        end
    end
end

function MsgManager.getMsgLimitCount( channel )
    if channel == nil then
        return Const.DEFAULT_MAX_MSG_COUNT, Const.DEFAULT_REMOVE_MSG_COUNT
    end
    local info = Const.CHANNEL_CONFIG[channel]
    if info then
        return info.limitCount or Const.DEFAULT_MAX_MSG_COUNT,info.removeNum or Const.DEFAULT_REMOVE_MSG_COUNT
    end
    return Const.DEFAULT_MAX_MSG_COUNT, Const.DEFAULT_REMOVE_MSG_COUNT
end

--根据频道获得对应的消息，一般在注册的界面初始化的时候调用，要排序
function MsgManager.getChannelMsgs( channelIds )
    channelIds=channelIds or {}
    local tempData={}
    for i,cid in pairs(channelIds) do
        local data=self.mMsgDatas[cid]
        if data then
            for i, msg in ipairs(data) do
                table.insert(tempData,msg)
            end
        end
    end
    table.sort(tempData,function ( v1,v2 )
        return v1.time<v2.time
    end)
    return tempData
end

function MsgManager.receive(msg, channel, name, uid, time, voiceID, voiceLength,noticeType)
    local sattr ={}-- {['simple'] = {['comm'] = {}}}
    sattr.name = name or ""
    local msgItem = {}
    msgItem.suid = uid or ""
    msgItem.time = time
    msgItem.content = msg
    msgItem.sattr = sattr
    msgItem.voiceid = voiceID
    msgItem.voicetime = voiceLength
    msgItem.show = {}
    self.receiveFromServer(channel, msgItem,nil,noticeType)
end

--local test=1
--roledata/ChatMsgItem
function MsgManager.receiveFromServer(channel, msgItem, history,noticeType)
    --print("receiveFromServer:", channel, " : ", msgItem.content, msgItem.seq)
    local entity = CurAvatar
    if entity and  msgItem.ruid ~= entity.uid then
        if entity and msgItem.suid and entity.inMyBlackList and entity:inMyBlackList(msgItem.suid) then
            return
        end
        if channel == Const.CHANNEL_GUILD then
            --if tostring(entity:getCircleChatId())  ~= msgItem.gid then--不是同一个公会
            --    return
            --end
        elseif channel == Const.CHANNEL_WORLD then
            if entity.chatWorldGid ~= msgItem.gid then --不是同一个世界聊天分组
                return
            end
        end
    end
    --msgItem.sub_channel = Const.GUILD_CHANNEL_SYSTEM
    msgItem.channel = msgItem.channel or channel
    msgItem.is_unread = true
    ----print("stiger----------------消息是未读过的吗：",msgItem.is_unread,msgItem.content,msgItem.channel,history)
    if msgItem.time == 0 or msgItem.time == nil then
        local time = self._getLastMsgTime(msgItem.channel)
        time = time + 0.5
        if time < 0 then
            time = TimeUtils.getServerTime()
        end
        msgItem.time = time
        --print("stiger------------------消息没有time字段，要读取当前时间")
    end
    --print("stiger----------------------os.time:",os.time(),msgItem.time)
    msgItem.isVoice = false
    -- msgItem.isVoice = msgItem.voice_id ~= nil and msgItem.voice_id ~= ""
    -- local len = #self.mMsgDatas
    -- if len == 0 or self.mMsgDatas[len].time <= msgItem.time then
    --     table.insert(self.mMsgDatas, msgItem)
    -- else
    --     local idx = 1
    --     for i = 0, len - 1 do
    --         local item = self.mMsgDatas[len -i]
    --         if item.time <= msgItem.time then
    --             idx = len -i + 1
    --             break
    --         end
    --     end
    --     table.insert(self.mMsgDatas, idx, msgItem)
    -- end
    self._addMsg( msgItem)

    self.checkRedHint(msgItem)

    self.checkPlayerInfo(msgItem)
    for i, receiver in pairs(self.receivers) do
        receiver:onReceive(msgItem,noticeType)
    end
    EventCenter.sendEvent(EventConst.RECEIVE_NEW_MSG, { channel, msgItem })
    if entity and msgItem.suid == entity.uid then
        EventCenter.sendEvent(EventConst.MSG_SELF_SENDED, { msgItem })
    end
    self._checkSaveCounter(msgItem)

end

function MsgManager.checkRedHint( lastMsgItem )
    if not lastMsgItem or lastMsgItem.channel ~= Const.CHANNEL_PRIVATE then return end
    local uid=lastMsgItem.suid
    if uid==CurAvatar.uid then return end
    if lastMsgItem.is_unread then--如果是离线的不处理

    else
        lastMsgItem.is_unread=true
    end


end
--一些由系统发送的消息用这个接口，服务端就不会对消息字符进行合法检测






function MsgManager.clientNotice(noticeId,noticeParams)
    if ResClientNotice[noticeId] then
        local notice = ResClientNotice[noticeId].notice or ""
        if noticeParams then
            notice = string.format(notice, unpack(noticeParams))
        end
        self.notice(notice)
    else
        logerror("ResClientNotice 缺少提示信息 ID："..noticeId)
    end
end

function MsgManager.notice(msg)
    UIJump.ShowScrollTips(msg)
    --self.receive(msg, Const.CHANNEL_NOTICE,nil,nil,nil,nil,nil,1)
end

function MsgManager.registReceiver(newReceiver)
    local length = 999
    for i = 1, length do
        local receiver = self.receivers[i]
        if receiver == nil then
            self.receivers[i] = newReceiver
            return i
        end
    end
    --连续遍历都没有找到空位则添加末尾返回长度
    table.insert(self.receivers, newReceiver)
    return #self.receivers
end

function MsgManager.unregistReceiver(id)
    self.receivers[id] = nil
end

function MsgManager._checkSaveCounter( msgItem )
    ----print("stiger---------------------------------------check channel")
    --print("stiger-------消息的时间",msgItem.content,msgItem.time)
    if not self.counter then--那种notice消息先来，所以这里判断下
        return
    end
    local isSave=false
    if os.time()-self.saveTime>SAVE_INTERVAL then--无论什么消息，都检测是否是否超过了保存私聊的时间，这样才能尽可能的多保存
        self.saveMsg()
        isSave=true
        self.counter[Const.CHANNEL_PRIVATE]=0
    end
    local channel=msgItem.channel
    local num=self.counter[channel]
    if not self.isRedMsgRelate(msgItem) then--红包信息不刷新弹幕时间
        self.refreshBulletTimeInfo(msgItem)--每条弹幕频道消息都要刷新弹幕的时间戳
    end
    if channel==Const.CHANNEL_PRIVATE and isSave==false then--如果是私聊，每收到一条看条数超过没有
        num=num+1
        if num>=SAVE_COUNTER[channel] then
            self.saveMsg()
            num=0
        end
        self.counter[channel]=num
    end
end


function MsgManager.checkPlayerInfo( msgItem )
    ------print("消息中心",msgItem.channel)
    if msgItem.channel~= Const.CHANNEL_PRIVATE then
        return
    end
    --local ui=UIManager.getUI("chatDlg",nil ,false)
    local player=nil
    local uid=0
    local comm=nil
    if msgItem.ruid==CurAvatar.uid then
        uid=msgItem.suid
        comm=msgItem.sattr
    else
        uid=msgItem.ruid
    end

    --if ui then
    --    player=ui:getPlayerInfo(uid)
    --end
    if player==nil then

    end
    if player then
        self.notFriends[player.uid]=player
    end
    --print("stiger-----------ischange",isChange)
    --if isChange then
    --    --if ui then
    --    --    ui:refreshFriendList(player)
    --    --end
    --end
end

function MsgManager._updatePlayerInfo( player,comm )
    if comm and player then
        local isChange=false
        for k,attr in pairs(comm) do
            if player[k]==nil or player[k]~=attr then
                isChange=true
            end
            player[k]=attr
        end
        return isChange
    end
end



--弹幕规则解释：
--1.第一次登录进来本地没有保存上一次显示弹幕的时间，保证取出来的是0
--2.self.checkTimeInfo保存的是各个频道弹幕消息的最新时间，随着消息到来实时更新
--3.self.lastBulletTimeInfo保存的是各个频道上一次显示的弹幕时间点，比如进战斗后就要记录此时的时间，出来后只要有消息超过这个时间点就显示此消息弹幕
--4.运行时会有个保存弹幕消息的时间，这个时间下次登录时会作为显示弹幕的时间
--5.弹幕界面那边，如果第一次打开弹幕界面，则用所有消息和上一次显示弹幕时间做对比，如果是后续运行时收到的消息则和记录的各个频道的弹幕时间对比


function MsgManager._loadBulletConfig( ... )
    --print("stiger---------------_loadBulletConfig")
    local saveInfo = UserData.loadCommonData(bulletDatakey)
    --print("stiger----------------------------------------",saveInfo=="")
    if saveInfo == nil or saveInfo=="" then
        print("读取本地保存的弹幕设置失败")
        self.saveBulletConfig()
        return
    end
    ------print(saveInfo)
    local data=utils.unserialize(saveInfo)
    if data.bulletChannels then
        self.bulletChannels = {}
        for k, v in pairs(Const.DEFAULT_BULLET_CHANNELS) do
            if data.bulletChannels[k] then
                self.bulletChannels[k] = data.bulletChannels[k]
            else
                self.bulletChannels[k] = false
            end
        end
    else
        self.bulletChannels = utils.copyTable(Const.DEFAULT_BULLET_CHANNELS)
    end

    local checkInfo = UserData.loadCommonData(CurAvatar.uid .. bulletDatakey)
    local data = utils.unserialize(checkInfo)
    self.checkTimeInfo=data.checkTimeInfo or {}--key:channel, value :上一次查看的时间
    self._setLastBulletTime(self.checkTimeInfo)
end
--返回上一次显示弹幕的时间，当第一次获取会返回本地记录的时间，后续都是运行时的记录
function MsgManager.getLastBulletTime( channel )
    return self.lastBulletTimeInfo and  self.lastBulletTimeInfo[channel] or 0
end
--保存显示弹幕的时间，会将此时的最新弹幕时间作为显示弹幕的时间保存
function MsgManager.saveLastBulletTime( ... )
    self.saveBulletConfig()
    self._setLastBulletTime(self.checkTimeInfo)

end

function MsgManager._setLastBulletTime( timeInfo )
    self.lastBulletTimeInfo = {}
    for c,t in pairs(timeInfo) do
        self.lastBulletTimeInfo[c]= t
    end
end

function MsgManager.getBulletChannels( ... )
    --print("stiger-----------------------getBulletChannels")
    if not self.bulletChannels then
        self._loadBulletConfig()
    end
    return self.bulletChannels
end

--设置全部弹幕开关
function MsgManager.changeBulletAllChannels( isOn )
    for channel , _ in pairs(Const.DEFAULT_BULLET_CHANNELS) do
        self.changeBulletChannels(channel, isOn)
    end
end

--获取弹幕开启状态
function MsgManager.getBulletChannelState( channel )
    return self.getBulletChannels()[channel] ~= false
end

function MsgManager.isAllBulletChannelOff( ... )
    for c, _ in pairs(Const.DEFAULT_BULLET_CHANNELS) do 
        if self.getBulletChannelState(c) then 
            return false 
        end
    end
    return true
end

--设置弹幕是否开启
function MsgManager.changeBulletChannels( channel,isOn )
    local curChannels = self.getBulletChannels()
    if isOn then
        if not curChannels[channel] then
            curChannels[channel]=Const.CHANNEL_TO_TYPE[channel] or 0
        end
    else
        curChannels[channel]=false
    end

    self.checkTimeInfo[channel]=self.checkTimeInfo[channel] or 0
    --print("stiger--------------弹幕时间",channel,self.checkTimeInfo[channel],os.time())
    self.saveBulletConfig()
    self._setLastBulletTime(self.checkTimeInfo)
    --local ui=UIManager.getUI("bulletDlg",nil,false)
    --if ui then
    --    ui:refreshChannels(self.getBulletChannels())
    --end
end

function MsgManager.getTableCountWithoutNil( t )
    local count=0
    for i,data in pairs(t) do
        if data then
            count=count+1
        end
    end
    return count
end

function MsgManager.saveBulletConfig(  )
    local data={}
    if self.bulletChannels == nil then
        self.bulletChannels = utils.copyTable(Const.DEFAULT_BULLET_CHANNELS)
    end
    self.checkTimeInfo= self.checkTimeInfo or {}

    --print("stiger-------------------------保存弹幕时间",self.bulletTimeStamp)
    for name,id in pairs(self.bulletChannels) do
        self.checkTimeInfo[name]=self.checkTimeInfo[name] or 0

    end
    data.bulletChannels=self.bulletChannels

    local checkData = {}
    checkData.checkTimeInfo=self.checkTimeInfo
    --self.bulletTimeStamp=nil
    if not CurAvatar or not CurAvatar.uid then
        return
    end
    UserData.saveCommonData(CurAvatar.uid .. bulletDatakey, utils.serialize(checkData))
    UserData.saveCommonData(bulletDatakey, utils.serialize(data))
end
--获得消息频道记录的弹幕时间
function MsgManager.getBulletTimeInfo( channel )
    if self.checkTimeInfo then
        return self.checkTimeInfo[channel] or 0
    end
end
--刷新当前弹幕时间，如果forceNow则强制将当前将显示弹幕时间设置为恢复重连时的时间
function MsgManager.refreshBulletTimeInfo( msgItem ,forceNow)
    self.checkTimeInfo=self.checkTimeInfo or {}
    local channels= self.getBulletChannels()
    if forceNow then
        for c,t in pairs(channels) do
            self.checkTimeInfo[c]=math.max(self.checkTimeInfo[c] or 0, 0)
        end
        self.saveLastBulletTime()
    elseif msgItem and channels[msgItem.channel]~=nil then
        local preTime=self.checkTimeInfo[msgItem.channel] or 0
        self.checkTimeInfo[msgItem.channel]=math.max(self.checkTimeInfo[msgItem.channel] or 0 ,msgItem.time)
    end
end

function MsgManager.addShield( uid )
    if utils.getTableElemCount(self.shieldDic,true) >=MAX_SHIELD_COUNT then
        utils.removeTableElements(self.shieldDic,5,function ( v1,v2 )
            return v1<v2
        end)
    end
    self.shieldDic[uid]=os.time()
end

function MsgManager.removeShield( uid )
    self.shieldDic[uid]=nil
end

function MsgManager.isInShield( uid )
    return self.shieldDic[uid] or false
end

--是否屏幕上显示弹幕或者走马灯
function MsgManager.showMsgOnScreen( v )
    --local ui = UIManager.getUI("bulletDlg", nil ,false)
    --if ui then
    --    ui:showMsg(v)
    --end
    --local ui = UIManager.getUI("speakerbox", nil ,false)
    --if ui then
    --    ui:showMsg(v)
    --end
end

function MsgManager.getScreenMsgHideflag(  )
    local hideFlag = false
    --local ui = UIManager.getUI("speakerbox", nil ,false)
    --if ui then
    --    hideFlag = ui.hideFlag
    --end
    return hideFlag
end

local COLOR_HEADFRAME = {
    [7] = "ff3700",
    [6] = "ff71b1",
    [5] = "eecb42",
    [4] = "cf75fe",
}




function MsgManager.isSuperRedPacket( msg )
    if msg == nil or msg.content == nil or MsgManager.isSystemMsg(msg) then
        return false
    end
    if msg.share ~= Const.CHAT_SHARE_TYPE.RED_PACKET then
        return false
    end
    local specData = msg.share_content.specData
    if specData then
        local item = ResItem[specData.item_id]
        if item and item.extend_args2 == 2 then
            return item
        end
    end
end

function MsgManager.isNormalRedPacket( msg )
    if msg == nil or msg.content == nil or MsgManager.isSystemMsg(msg) then
        return false
    end
    if msg.share ~= Const.CHAT_SHARE_TYPE.RED_PACKET then
        return false
    end
    local specData = msg.share_content.specData
    if specData then
        local item = ResItem[specData.item_id]
        if item and item.extend_args2 == 1 then
            return item
        end
    end
end


local _functionParseMsgOtherInfo = function( other )
    if other == nil or other == "" then
        return
    end
    local strs = utils.splitString(other, "|")
    return strs
end


function MsgManager.isRedMsgRelate( msg )
    if msg == nil or msg.content == nil or MsgManager.isSystemMsg(msg) then
        return false
    end
    local _isRedMsgRelate = false
    if self.isNormalRedPacket(msg) or self.isSuperRedPacket(msg) then--是红包
        _isRedMsgRelate = true
    end
    if not _isRedMsgRelate then
        local data = _functionParseMsgOtherInfo(msg.other)
        if data and (data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_THX or data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM) then
            _isRedMsgRelate = true
        end
    end
    return _isRedMsgRelate
end










function MsgManager.isSystemMsg( msg )
    if msg.channel ~= Const.MAIN_CHANNEL_SYSTEM and msg.sub_channel == Const.CHANNEL_NONE then
        return false
    end
    return true
end





return MsgManager