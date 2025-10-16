-- 好友模块

local FriendMixin = {}
function FriendMixin:initFriendMixin(  )
    self.friendList = {}            -- 好友列表  接口onBuddyInfoNotify异步接收
    self.inviteList = {}            -- 新好友列表
    self.blackList  = {}            -- 黑名单
    self.recommendList = {}         -- 推荐好友
    self.onlineInfoList = {}        -- 记录请求的在线信息的列表
    self.friendSend = 0             -- 好友友好度赠送过的数量
    self.friendReceive = 0          -- 好友友好度接收过的数量
    self:checkInviteHint()
    self:checkFriendGiftHint()
end

-- message RoleBuddyItemBase { // 角色好友信息(内存信息)
--   optional string uid           = 1;  // 角色UID
--   optional string name          = 2;  // None
--   optional uint32 gender        = 3;  // 性别
--   optional int32  level         = 4;  // 等级
--   optional uint32 head          = 5;  // 头像ID
--   optional string clangid       = 6;  // 公会ID
--   optional uint32 logout_tick   = 7;  // 离线时间
--   optional int32  head_frame_id = 8;  // 头像框
--   optional int32  online        = 9;  // 在线标志
--   optional uint32 time          = 10; // 添加时间
-- }
function FriendMixin:_getFriendDataByServerData( baseData, oldData )
    if baseData.simple.comm.uid == self.uid then
        return nil
    end
    if oldData then
        oldData:updateFriendData(baseData)
        return oldData
    else
        --local buddyInfo = OtherPlayer()
        --buddyInfo:initFriendData(baseData)
        --return buddyInfo
    end
end

function FriendMixin:newDayFriendData()
    for _, friend in pairs(self.friendList) do
        friend:newDayFriendData()
    end
    self.friendSend = 0
    self.friendReceive = 0
    self:_refreshFriendPage()
end

-- 初始化批量发送的接口
function FriendMixin:onBuddyInfoNotify( buddies, giftInfo )
    for i,buddyItem in ipairs(buddies) do
        local uid = buddyItem.base.simple.comm.uid
        self.friendList[uid] = self:_getFriendDataByServerData( buddyItem.base )
    end
    for gName, gValue in pairs(giftInfo) do
        if gName == 'given' then
            self.friendSend = gValue
        elseif gName == 'got' then
            self.friendReceive = gValue
        end
    end
    -- self.friendSend = giftInfo.given
    -- self.friendReceive = giftInfo.got
    self:checkFriendGiftHint()
end

function FriendMixin:onBuddyAddNotify(buddy)
    if not buddy.base then
        return
    end
    local uid = buddy.base.simple.comm.uid
    self.friendList[uid] = self:_getFriendDataByServerData( buddy.base )
    if self.inviteList[uid] then
        self.inviteList[uid] = nil
        self:checkInviteHint()
    end
    local name = self.friendList[uid].name or ""
    MsgManager.notice(string.format("已将玩家 %s 添加为好友", name))
    -- 暂时注释掉,等待服务端附在online相关信息
    -- self:onlineRequest({uid})
    self:_resetFriendPage()
end

function FriendMixin:checkInviteHint()

end

function FriendMixin:checkFriendGiftHint()

end

function FriendMixin:onBuddyDelNotify(uid)
    if self.friendList[uid] then
        self.friendList[uid] = nil
    end
    self:_resetFriendPage()
    self:checkFriendGiftHint()
    --local ui=UIManager.getUI("roleInfoOtherDlg",nil,false)
    --if ui then
    --    ui:setVisible(false)
    --end
end

function FriendMixin:onBuddyInviteOpResp(uid, optype, fail, has_more)
    for index, failInfo in ipairs(fail) do
        if failInfo.reason == "kCSErrorBuddyTargetIsFull" then
            MsgManager.notice("对方好友列表已满，无法添加")
        end
    end
    if has_more == 0 then       -- 后面没有
        if optype == "kBuddyInviteAccept" then
        elseif optype == "kBuddyInviteRefuse" then
            MsgManager.notice("已忽略该玩家的好友申请")
        elseif optype == "kBuddyInviteAcceptAll" then
            if #fail == 0 then
                MsgManager.notice("已通过全部好友申请")
            else
                if next(self.inviteList) then
                    if self:getFriendCount() >= Const.MAX_FRIEND_NUM then
                        MsgManager.notice("你的好友数量达到上限，无法添加好友")
                    end
                end
            end
        elseif optype == "kBuddyInviteRefuseAll" then
            MsgManager.notice("已忽略全部好友申请")
            self.inviteList = {}
            self:checkInviteHint()
        end
    end
end

function FriendMixin:onBuddyInviteNotify(invite)
    self.inviteList = {}
    for i,inviteItem in ipairs(invite) do
        local uid = inviteItem.base.simple.comm.uid
        self.inviteList[uid] = self:_getFriendDataByServerData( inviteItem.base )
    end
    self:checkInviteHint()
end

-- 别人加我好友, 给我推的
function FriendMixin:onBuddyInviteAddNotify(invite)
    if not invite.base then
        return
    end
    local uid = invite.base.simple.comm.uid
    self.inviteList[uid] = self:_getFriendDataByServerData( invite.base )
    self:checkInviteHint()
end

function FriendMixin:onBuddyInviteDelNotify(uid)
    if self.inviteList[uid] then
        self.inviteList[uid] = nil
    end
    self:checkInviteHint()
end

-- 黑名单 初始化
function FriendMixin:onBuddyBlackListNotify(item)
    for i,buddyItem in ipairs(item) do
        local uid = buddyItem.base.simple.comm.uid
        if uid then
            self.blackList[uid] = self:_getFriendDataByServerData( buddyItem.base )
        end
    end
    self:_refreshFriendPage()
    self:_refreshBlackListDlg()
end

-- 黑名单 增加
function FriendMixin:onBuddyBlackListAddResp(item)
    local uid = item.base.simple.comm.uid
    if uid then
        self.blackList[uid] = self:_getFriendDataByServerData( item.base )
        MsgManager.notice(string.format("已将玩家 %s 加入黑名单", self.blackList[uid].name))
        for index, containers in ipairs({self.friendList, self.inviteList}) do
            containers[uid] = nil
        end
        self:_refreshFriendPage()
        self:_refreshBlackListDlg()
    end
    self:checkFriendGiftHint()
end

function FriendMixin:onBuddyBlackListDelResp(uid)
    if self.blackList[uid] then
        local name = self.blackList[uid].name
        self.blackList[uid] = nil
        MsgManager.notice(string.format("已将玩家 %s 移出黑名单", name))
        self:_refreshFriendPage()
        self:_refreshBlackListDlg()
    end
    self:checkFriendGiftHint()
end

function FriendMixin:onBuddySearchResp( result, respCode )
    --local friendAddDlg = UIManager.getUI("friendAddDlg", nil, false)
    --if friendAddDlg then
    --    friendAddDlg:showSearchResult(result, respCode)
    --end
end



function FriendMixin:onBuddyBondSetResp(uid, bond)
    if self.friendList[uid] then
        self.friendList[uid]:updateConfidant(bond)
        self:_refreshFriendPage() 
    end 
end

----------------------------------------------------↑初始化及服务器接口相关↑-------------------------------------------------

----------------------------------------------------↓客户端接口相关↓-------------------------------------------------
function FriendMixin:getBlackProcess(  )
    local nowCount = 0
    for k,v in pairs(self.blackList) do
        nowCount = nowCount + 1
    end
    return nowCount, Const.MAX_BUDDY_BLACKLISTNUM
end

local function FriendSortFunc(friendA, friendB)
    if friendA.online and friendB.online then
        return friendA.level > friendB.level
    elseif friendA.online then
        return true
    elseif friendB.online then
        return false
    else
        return friendA.logout_tick > friendB.logout_tick
    end
end

function FriendMixin:getSortedFriends(  )
    local curPlayers = {}
    for _, player in pairs(self.friendList) do
        table.insert(curPlayers, player)
    end
    table.sort(curPlayers, FriendSortFunc)
    return curPlayers
end

function FriendMixin:getFriendCount(  )
    local nowCount = 0
    for k,v in pairs(self.friendList) do
        nowCount = nowCount + 1
    end
    return nowCount
end

-- 今天还可发送多少个礼物
function FriendMixin:getFriendSendCount(  )
    return Const.MAX_FRIEND_GIFT_SEND_NUM - self.friendSend
end

function FriendMixin:getFriendGetCount(  )
    return Const.MAX_FRIEND_GIFT_GET_NUM - self.friendReceive
end

function FriendMixin:getFriendInviteCount(  )
    local nowCount = 0
    for k,v in pairs(self.inviteList) do
        nowCount = nowCount + 1
    end
    return nowCount
end

function FriendMixin:isMyFriend( uid )
    if self.friendList and self.friendList[uid] then
        return true
    else
        return false
    end
end

function FriendMixin:inMyBlackList( uid )
    if self.blackList and self.blackList[uid] then
        return true
    else
        return false
    end
end

function FriendMixin:getConfidantCount(  )
    local count = 0
    for uid, friend in pairs(self.friendList) do
        if friend.isMyConfidant then
            count = count + 1
        end
    end
    return count
end

function FriendMixin:isMyConfidant( uid )
    local friend = self.friendList[uid]
    if friend and friend.isMyConfidant then
        return true
    else
        return false
    end
end

function FriendMixin:setConfidantOnMe( uid )
    local friend = self.friendList[uid]
    if friend and friend.confidantOnMe then
        return true
    else
        return false
    end
end




function FriendMixin:onlineRequest( uidList, callback )
    if not self.onlineRequestCallback then
        self.onlineRequestCallback = {}
    end
    if not self.lastGetRoleOnlineCd then
        self.lastGetRoleOnlineCd = 0
    end
    if TimeUtils.getServerTime() - self.lastGetRoleOnlineCd > Const.GET_ROLE_ONLINE_CD then
        if callback then
            table.insert(self.onlineRequestCallback, callback)
        end
        RPC.infoGetRoleOnline( uidList )
        self.lastGetRoleOnlineCd = TimeUtils.getServerTime()
    else
        print("失败角色在线状态请求，剩余cd时间为"..TimeUtils.getServerTime() - self.lastGetRoleOnlineCd)
    end
end

function FriendMixin:roleOnlineReq(  )
    local requestList = {}
    local recordDict = {}   -- key uid, value bool, 用来剔除重复
    for index, containers in pairs({self.friendList}) do
        for uid,_ in pairs( containers ) do
            if not recordDict[uid] then
                table.insert(requestList, uid)
                recordDict[uid] = true
            end
        end
    end
    -- if #requestList > 0 then
    --     self:onlineRequest(requestList)
    -- end
end

function FriendMixin:addFriend(uid)
    if self:isMyFriend(uid) then
        MsgManager.notice("对方已经是你的好友")
    elseif self:getFriendCount() >= Const.MAX_FRIEND_NUM then
        MsgManager.notice("好友人数已满，无法添加")
    elseif self:inMyBlackList(uid) then
        MsgManager.notice("对方处于黑名单中，请先移除黑名单")
    else
        MsgManager.notice("已发送好友申请")
        RPC.buddyAdd(uid)
        return true
    end
end

function FriendMixin:onBuddyUpdateNotify(buddys)
    for _, buddy in ipairs(buddys) do
        if not buddy.base then
            return
        end
        local uid = buddy.base.simple.comm.uid
        if self.friendList[uid] then
            self.friendList[uid] = self:_getFriendDataByServerData(buddy.base, self.friendList[uid])
        end
    end
    self:_refreshFriendPage()
    self:checkFriendGiftHint()
end

function FriendMixin:onBuddySocialNotify(buddies, giftInfo)
    for i,buddyItem in ipairs(buddies) do
        local uid = buddyItem.uid
        if self.friendList[uid] then
            self.friendList[uid]:updateFriendData(buddyItem)
        end
    end
    for gName, gValue in pairs(giftInfo) do
        if gName == 'given' then
            self.friendSend = gValue
        elseif gName == 'got' then
            self.friendReceive = gValue
        end
    end
    self:_refreshFriendPage()
    self:checkFriendGiftHint()
end

function FriendMixin:_refreshBlackListDlg(  )
    --local friendBlackListDlg = UIManager.getUI("friendBlackListDlg",nil, false)
    --if friendBlackListDlg then
    --    friendBlackListDlg:refreshData()
    --end
end


-- 手动更新下好友界面
function FriendMixin:_refreshFriendPage()
    --local friendMainDlg = UIManager.getUI("friendMainDlg", nil, false)
    --if friendMainDlg then
    --    friendMainDlg:refreshPlayer()
    --end
    -- local playerTips = UIManager.getUI("playerTips", nil, false)
    -- if playerTips then
    --     playerTips:refreshPlayer()
    -- end
    --local ui=UIManager.getUI("roleInfoOtherDlg",nil,false)
    --if ui then
    --    ui:refreshUI()
    --end
    --刷新私聊那里的好友显示
    --local ui=UIManager.getUI("chatDlg",nil,false)
    --if ui then
    --    ui:refreshFriendList()
    --end
end

-- 手动更新下好友界面
function FriendMixin:_resetFriendPage()
    --local friendMainDlg = UIManager.getUI("friendMainDlg", nil, false)
    --if friendMainDlg then
    --    friendMainDlg:resetPlayer()
    --end
    -- local playerTips = UIManager.getUI("playerTips", nil, false)
    -- if playerTips then
    --     playerTips:refreshPlayer()
    -- end

    --local ui=UIManager.getUI("roleInfoOtherDlg",nil,false)
    --if ui then
    --    ui:refreshUI()
    --end
end

----------------------------------------------------↑客户端接口相关↑-------------------------------------------------
return FriendMixin