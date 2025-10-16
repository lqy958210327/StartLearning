local ClientAccount = require "Core/Avatar/ClientAccount"
local NetService = require("Core/Network/NetService")
local UserData = require "Core/Helper/UserData"

local strClassName = "ClientAvatar"


---@class ClientAvatar 搓了一堆其他Table，大坑，没法填
local ClientAvatar = Class(strClassName,ClientAccount)
local AvatarString = ConstTable.AvatarString

-- 混合所有的附属组件
local AvatarMixins = {

    "FriendMixin",
    "AVGBulletMixin"
}
print("---   require(ClientAvatar) begin mixin")
for i = 1, #AvatarMixins do
    local mixin = require("Core/Avatar/AvatarMixins/" .. AvatarMixins[i])
    if mixin then
        MixinClass(ClientAvatar, mixin)
    end
end

-- 构造函数。
function ClientAvatar:ctor()

    ---@type ClientAvatar
    CurAvatar = self
    self.syncDataReady = false
end

function ClientAvatar:_ctor(gameData, all_data_num, shortUid)
    CurAvatar = self
    --CHATRPC.setAgent(self)
    self.shortUid = shortUid
    self.isAvatar = true
    self.baseData = gameData.role_data
    self.syncData = {}
    self.syncDataNum = all_data_num
    self.syncDataReady = false
    self.gender = self.baseData.base.gender or 0
    self.head = self.baseData.base.head
    self.headFrameId=self.baseData.base.head_frame_id==0 and  44 or self.baseData.base.head_frame_id
    if not self.head or self.head == 0 then
        self.head = 1
    end
    self.uid = self.baseData.uid
    self.openid = self.baseData.openid
    self.serverFormatName = self.baseData.base.name
    self:initPlayerName(self.serverFormatName)
    --临时处理主界面场景数据，之后调整进入主界面状态切换时机
    self.idCard = self.baseData.necessary.misc.addiction.id_card                    -- 角色身份证
    self.inAntiAddiction = self.baseData.necessary.misc.addiction.flag == 1         -- 被防沉迷了
    -- self.todalOnlineTime = self.baseData.necessary.misc.today_online_time       -- 今天在线时长
    -- self.onlineTickTime = TimeUtils.getServerTime()                           -- 在线时长记录时候的服务器时间
    ClientTimerManager.initAllTimer()
    self:checkLoginInfo()
    --客户端运行时的一些数据保存在这里，断线重连时不清除，切换账号时清除
    if ClientUtils.uid==nil or ClientUtils.uid~=self.uid then
        ClientUtils.uid=self.uid
        ClientUtils.record={}
    end
    self.isMobileRecorded = self:_getMobileRecordState(self.baseData.necessary.misc.bitmem)
    self:_callMixinMemberFunc("initBase@", self.baseData)

end

function ClientAvatar:checkLoginInfo()
    local preLoginName = UserData.loadCommonData("LoginName")
    if preLoginName ~= self.name then
        self:onNewNameLogin()
    end
    local preLoginTime = UserData.loadCommonData("LoginTick")
    local todayStart = ClientUtils.getServerTimeTodayStart()
    if tonumber(preLoginTime) == nil or tonumber(preLoginTime) < todayStart then
        self:onNewDayLogin()
    end
end

function ClientAvatar:onNewNameLogin()
    UserData.saveCommonData("LoginName", self.name)
    UserData.saveCommonData("HookScriptScene", "")
end

function ClientAvatar:onNewDayLogin()
    local todayStart = ClientUtils.getServerTimeTodayStart()
    UserData.saveCommonData("LoginTick", tostring(todayStart))
    UserData.saveCommonData("HookScriptScene", "")
end

function ClientAvatar:initPlayerName(playerName)
    local nameList = utils.splitString(playerName, '-')
    local serverID = tonumber(nameList[1])
    local serverName = SvrListManager.getServerName(serverID)

    if serverName then
        self.name = nameList[2]
        self.serverName = serverName
    else
        self.name = playerName
        self.serverName = nil
    end
    self.genderTitle = self.gender == 1 and AvatarString.genderTitle_1 or AvatarString.genderTitle_0
    self.genderHonorTitle = self.gender == 1 and AvatarString.genderHonorTitle_1 or AvatarString.genderHonorTitle_0
end



function ClientAvatar:playerNameInited(  )
    return self.name~=nil and self.name~=""
end



function ClientAvatar:onDataReady()
    self.syncDataReady = true
    -- 玩家数据全部初始化之后  重新设置下当前的相关状态
    ConditionLimitManager.initPlayerData()
    -- 状态保持的重连时  根据情况可能需要保留某些现场  不去初始化  比如新手

end

--function ClientAvatar:_onDataReady()
--    self:_callMixinMemberFunc("init@", self.baseData, self.syncData)
--    self:_callMixinMemberFunc("postinit@", self.baseData, self.syncData)
--    local baseData = self.baseData
--    self.baseData = nil
--    self.syncData = nil
--    self.syncDataReady = true
--    -- 玩家数据全部初始化之后  重新设置下当前的相关状态
--    ConditionLimitManager.initPlayerData()
--    -- 状态保持的重连时  根据情况可能需要保留某些现场  不去初始化  比如新手
--    if not self.isReconnect then
--    end
--    -- 刷新各个系统红点和福利红点
--    self:_checkReddotsAfterInited()
--    self:_callMixinMemberFunc("initCheck@")       -- 全部数据初始化后  check红点 条件等规则
--    SDKAgent.onRoleLogin()
--
--    -- 根据玩家所在章节决定要不要下载剩下的分包资源，如果进入下载流程，则断开连接，等下载完成后重新连接游戏服
--    local record = baseData.necessary.deposit.record
--    if SubpackageHelper.tryDownloadRemaining(record.chapter, ClientAvatar._onSubpackageDownloaded) then
--        GameFsm.reset()
--    end
--    SubpackageHelper.onEnterChapter(record.chapter)
--end

-- 如果登录后开始下载分包，下载完成后重新连接游戏服


-- Avatar的销毁逻辑
function ClientAvatar:destroy()
    CurAvatar = false
end

function ClientAvatar:_destroy()
    ClientTimerManager.stopAllTimer()
    self:_callMixinMemberFunc("destroy@")

    CurAvatar = false
    --CHATRPC.setAgent(false)
end

-- 调用所有组件中与模板对应的函数
function ClientAvatar:_callMixinMemberFunc(funcTemplate, ...)

    print('DEMO：截断所有子事件，单独手动调用')
    do return end

    for i = 1, #AvatarMixins do
        local name = AvatarMixins[i]
         local funcName = string.gsub(funcTemplate, "@", name)
        --logerror(funcName)
        if self[funcName] then
            ClientUtils.trycall(self[funcName], self, ...)
        end
    end
end

function ClientAvatar:onHeartBeatResp(time, count)
    --同步服务器时间
    Const.HEART_BEAT_TIME = Time.time
    TimeUtils.onSetServerTime(time)
    NetService.onHeartBeat(count)

end



local function AddictionYse()
    --if IS_VERIFY_VERSION then
    --    --if CurAvatar and CurAvatar.idCard == nil or CurAvatar.idCard == "" then
    --    --    --UIManager.getUI("idConfirmDlg", true)
    --    --end
    --end
end

function ClientAvatar:noticeInAntiAddiction()
    UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "提示", "您已进入不健康游戏时间，您的游戏收益将降为0，为了您的健康，请尽快下线休息，做适当身体活动，合理安排学习生活。", AddictionYse)
end

function ClientAvatar:catchSvrError( msgID )
    if msgID == "kCSErrorSystemBagIsFull" then
    elseif msgID=="kCSErrorPVECanNotSweep" then
        print("stiger---------扫荡积分变化了，这里刷新积分数据")
        self.pvpScoreRefreshTime=nil
        --local ui=UIManager.getUI("pvpEnemyDlg",nil,false)
        --if ui then
        --    ui:refreshScore()
        --end
    elseif msgID == "kCSErrorTokenInvalid" then
        -- 聊天token错误，重新获取
        RPC.wChatRegister()
    end
end

-- 有些红点依赖Mixin里的数据，有些依赖ConditionLimit，或者同时依赖两者
-- 如果找不到美丽的触发时机，可以放到这里--登录并初始化CurAvatar之后
--function ClientAvatar:_checkReddotsAfterInited(  )
--    self:refreshNewbiePoolReddot()
--    self:refreshWelfareReddot()
--end



function ClientAvatar:_getMobileRecordState(bitmem)
    local index = 1
    local bitDict = {}
    if bitmem ~= nil then
        local tIndex = utils.getBitsListFromByteString(bitmem)
        for _, i in pairs(tIndex) do
            bitDict[i] = true
        end
    end
    return bitDict[index] == true
end

return ClientAvatar

