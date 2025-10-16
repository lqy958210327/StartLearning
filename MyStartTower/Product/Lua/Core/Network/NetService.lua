-- 网络模块
local LibConApi = require("Game/RPC/LibConApi")
local UpdateBeat = UpdateBeat
local protobuf = protobuf
local NetService = { name = "NetService" }
local Time = Time.unity_time -- 时间敏感:网络延时需要精确的时间,Time缓存的时间在同帧内不变,会计算出0延时,所以此处只能使用Unity时间

-- 心跳参数 (2.5s一次,60s内未收到心跳回复,触发断线重连)(服务器的断线时间为120s)
local HEARTBEAT_INTERVAL = 2.5
local HEARTBEAT_MISS_DISCONNECT_TIME = 60
-- 断点调试 (编辑器断线重连时间为15m)(内网服务器的断线时间为15m)
if IS_EDITOR then
    HEARTBEAT_MISS_DISCONNECT_TIME = 15 * 60
end
local HEARTBEAT_MISS_DISCONNECT_COUNT = HEARTBEAT_MISS_DISCONNECT_TIME / HEARTBEAT_INTERVAL

-- 网络状态
local NETSERVICE_ST_CONNECTING = 0 --正在连接
local NETSERVICE_ST_CONNECTED = 1 -- 已经连接
local NETSERVICE_ST_DISCONNECTED = 2 -- 未连接或连接断开

local MAX_PACKATE_NUM_PRE_UPDATE = 20       -- 每帧尝试收取网络包的最大数量

local RECONNECT_COUNT_DOWN = 1.0 -- 断线重连的间隔约束
local MAX_RECONNECT_NUM = 5 -- 断线重连的最大尝试次数
-- local MAX_RECONNECT_NUM = 0 -- 0次尝试，暂时关闭断线重连功能

NetService._openID = "10001"
NetService._token = ""
NetService._sdkJson = {}

NetService._serviceID = 0 -- 服务器ID
NetService._serviceIP = ""
NetService._serviceName = "" --83 -- 59
NetService._servicePort = 0

NetService._connectHandle = {}
NetService._connectInitialized = false
NetService._logicID = 0

-- ↓↓↓ 网络连接 ↓↓↓ --

function NetService._initProtobufLib()
    local pbfiles = {
        'protocol.pb.bytes',
    }
    for _, pbfile in ipairs(pbfiles) do
        local _assetName = string.format("Scriptable/%s", pbfile)
        local bytes = LuaToolkit.ReadFileBytes(_assetName)
        if bytes then
            protobuf.register(bytes)
        else
            logerror("proto load failed:", pbfile)
        end
    end
end

function NetService._initConnectEnv()
    NetService._initProtobufLib()
    return true
end

-- 网络模块初始化
function NetService.init()
    -- print("--------------------------------------------------------------------------------------------------")
    -- print(protobuf.enum("proto.server.DCUpdate", "PLAYER"))
    -- print(protobuf.enum("proto.server.DCUpdate", "ITEM_FULL"))
    -- print("--------------------------------------------------------------------------------------------------")
    if not NetService.hbTimer then
        NetService._initConnectEnv()
        NetService.hbTimer = Timer.New(NetService.sendHeartBeat, HEARTBEAT_INTERVAL, -1)
        NetService.reconnectTimer = nil                                     -- 正常情况下自动断线重连  连接过快时可能需要断线重连
    end

    Avatar.fakeAvatar()
end

function NetService.setAccountInfo(openID, accountToken,sdkJson,deviceID)
    NetService._openID = openID
    NetService._token = accountToken
    NetService._deviceID = deviceID
    -- 给服务端传的基本日志信息
    NetService._sdkJson = sdkJson
end

function NetService.setServiceInfo(id, ip, port, name, logic)
    NetService._serviceID = tonumber(id) or 0
    NetService._serviceIP = ip
    NetService._serviceName = name
    NetService._servicePort = port
    NetService._logicID = tonumber(logic) or 0
    -- print("================NetService.setServiceInfo==================", logic)
end

-- 开始连接服务器
function NetService.connect(succCB, failedCB)
    NetService._connSuccCB = succCB
    NetService._connFailedCB = failedCB
    if NetService.reconnectTimer then
        NetService.reconnectTimer:Stop()
        NetService.reconnectTimer = nil
    end

    if false == NetService.connectZoneSvr() then
        NetService.onConnectedFailed()
    else
        NetService._setConnectStatus(NETSERVICE_ST_CONNECTING)
        NetService.testDisconnect = false
        UpdateBeat:Add(NetService.update,NetService) -- 接报定时器
    end
end

-- 链接服务器
function NetService.connectZoneSvr()
    local rs, _ = LibConApi:create(128000, 3, false)

    if false == rs then
        print("[LUA] zone create", rs, ", lastError", LibConApi:lastError())
        return rs
    end

    rs = LibConApi:setOptions(NetService._serviceID, NetService._openID, NetService._token, NetService._sdkJson, NetService._logicID,NetService._deviceID)
    if false == rs then
        print("[LUA] zone setAccount", rs, ", lastError", LibConApi:lastError())
        return rs
    end

    --NetService._serviceIP = "192.168.1.102"
    --NetService._servicePort = 4321
    rs = LibConApi:start(NetService._serviceIP, NetService._servicePort)
    if false == rs then
        print("[LUA] zone start", rs, ", lastError", LibConApi:lastError())
        LibConApi:destroy()
    end

    return rs
end

function NetService._setConnectStatus(status)
    NetService._connectStatus = status
end

function NetService._setConnectInitState()
    if not NetService._getConnectInitialized() then
        NetService._setConnectInitialized(true)
        NetService.onConnectedSuccess()
    end
end

function NetService._getConnectInitialized()
    return NetService._connectInitialized
end

function NetService._setConnectInitialized(init)
    NetService._connectInitialized = init
    LibConApi._connectInitialized = init
end

-- 连接服务器失败时的调用(只有在点击登录的时候  Zone连接失败才会调用)
function NetService.onConnectedFailed()
    NetService.disconnect()

    if NetService._connFailedCB then
        NetService._connFailedCB()
    end
end

function NetService.onConnectedSuccess()
    NetService._setConnectStatus(NETSERVICE_ST_CONNECTED)

    NetService.resetHeartBeat()
    NetService.StartHeartBeat()
    Analytics.adSdkTimerStart()

    if NetService._connSuccCB then
        NetService._connSuccCB()
    end
end

-- 主动断开网络连接
function NetService.disconnect()
    NetService.resetHeartBeat()
    NetService.StopHeartBeat()


    UpdateBeat:Remove(NetService.update,NetService)
    NetService._setConnectStatus(NETSERVICE_ST_DISCONNECTED)

    LibConApi:destroy()
    NetService._setConnectInitialized(false)
    EventCenter.sendEvent(EventConst.ZONE_SERVER_DISCONNECT)

    ----------------
    Analytics.adSdkTimerStop()
end

-- ↑↑↑ 网络连接 ↑↑↑ --

-- ↓↓↓ 消息处理 ↓↓↓ --

-- 每幀調用
function NetService.update()
    NetService._updateConnectImpl()
end

function NetService._updateConnectImpl()
    if false == LibConApi:update() or NetService.testDisconnect then
        -- TODO: 在C层增加一个Stop事件类型以及StopCode, 上层lua逻辑根据StopCode执行不同网络连接逻辑
        -- 区分: 1. 连接失败; 2. 建立连接后的网络异常; 3. 服务端主动断开连接;
        -- 在这里暂时同时调用连接失败和网络异常的回调
        NetService._onConnectUpdateFailed()
        NetService.testDisconnect = false
        return
    else
        if LibConApi:hasDataOutEvent() then
            NetService._setConnectInitState()
        end
        if LibConApi:hasDataInEvent() then
            NetService._recvAndProcessMsg()
        end
    end
end

-- 定时更新包时某连接断开了～
function NetService._onConnectUpdateFailed()
    if NetService._connectStatus == NETSERVICE_ST_DISCONNECTED then
        return
    end

    NetService.disconnect()
    if NetService.netDisconnectCB then
        NetService.netDisconnectCB()
    end
    -- UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "失去连接", "与服务器断开连接，是否重连？", NetService._realAutoReconnect, NetService._reconnectNoFunc)
end

-- 处理并分发msg
function NetService._recvAndProcessMsg()
    local hasMsg, multiMsg = LibConApi:recvMsg(MAX_PACKATE_NUM_PRE_UPDATE)
    if hasMsg and multiMsg ~= nil then
        for i = 0, multiMsg.Length - 1 do
            LibConApi:processMsg(multiMsg[i])
        end
    end
end

-- ↑↑↑ 消息处理 ↑↑↑ --

-- ↓↓↓ 心跳逻辑 ↓↓↓ --

local heartBeatVersion = 1
local heartBeatTable = {}
local heartBeatMissCount = 0
NetService.netDelay = 0 -- 单位:s

function NetService.setHeartBeatData(data)
    NetService._heartBeatData = data
end

function NetService.popHeartBeatData()
    local data = NetService._heartBeatData
    NetService._heartBeatData = nil
    return data
end

-- 心跳包
function NetService.sendHeartBeat(...)
    local data = NetService.popHeartBeatData()
    RPC.heartBeat(heartBeatVersion, data)
    heartBeatTable[heartBeatVersion] = Time.realtimeSinceStartup
    heartBeatVersion = heartBeatVersion + 1
    NetService._checkHeartBeat()


end

function NetService._checkHeartBeat()
    heartBeatMissCount = heartBeatMissCount + 1
    if heartBeatMissCount >= HEARTBEAT_MISS_DISCONNECT_COUNT then
        NetService.testDisconnect = true
        heartBeatMissCount = 0
    end
end

function NetService.onHeartBeat(count)
    heartBeatMissCount = 0
    local lastTime = heartBeatTable[count]
    if lastTime then
        NetService.netDelay = Time.realtimeSinceStartup - lastTime
        heartBeatTable[count] = nil
    end
end

function NetService.resetHeartBeat()
    heartBeatMissCount = 0
    heartBeatVersion = 1
    heartBeatTable = {}
end

function NetService.StartHeartBeat()
    NetService.hbTimer:Start() -- 心跳包
end

function NetService.StopHeartBeat()
    if NetService.hbTimer then
        -- 已经初始化之后  disconnect才需要做一些事情
        NetService.hbTimer:Stop()
    end
end

-- ↑↑↑ 心跳逻辑 ↑↑↑ --

-- ↓↓↓ 重连逻辑 ↓↓↓ --

-- 设置重连相关的通知接口
function NetService.setReconnectNoticeCallback( netDisconnectCB, reconnectSuccessCB, reconnectFailedCB )
    NetService.netDisconnectCB = netDisconnectCB
    NetService.reconnectSuccessCB = reconnectSuccessCB
    NetService.reconnectFailedCB = reconnectFailedCB
end

-- 根据时间去进行重连操作
function NetService.onAutoReconnect( )
    if NetService.reconnectTimer then
        return
    end
    if NetService.nextEnableReconnectTime and Time.time < NetService.nextEnableReconnectTime then
        NetService.reconnectTimer = Timer.New(NetService._realAutoReconnect, NetService.nextEnableReconnectTime - Time.time)
        NetService.reconnectTimer:Start()
    else
        NetService._realAutoReconnect( )
    end
end

function NetService._realAutoReconnect( )
    NetService.connect(NetService.reconnectSuccessCB, NetService.reconnect)
end

-- 清楚重连的flag，目前的机制是第一次尝试RECONNECT_COUNT_DOWN秒  第二次尝试在RECONNECT_COUNT_DOWN*2秒后  第三次RECONNECT_COUNT_DOWN*2*2后
--  如果全部失败了  则不会重连  会告知重连失败  然后必须手动登录   (在真正连接上  或者   玩家手动点击登录之后  会重新计算此机制)
function NetService.clearReconnectFlag( )
    NetService.reconnectAlreadyNumber = 0
end

function NetService.reconnect()
    Avatar.fakeAvatar(true)
    NetService.reconnectNextTime()
end

function NetService.stopReconnect()
    if NetService.reconnectTimer then
        NetService.reconnectTimer:Stop()
        NetService.reconnectTimer = nil
    end
end

-- 尝试进行下一次断线重连～～～  超过三次将不再继续自动帮助断线重连
function NetService.reconnectNextTime()
    if NetService.reconnectTimer then
        NetService.reconnectTimer:Stop()
        NetService.reconnectTimer = nil
    end
    if not NetService.reconnectAlreadyNumber or NetService.reconnectAlreadyNumber == 0 then
        NetService.reconnectAlreadyNumber = 1
    else
        NetService.reconnectAlreadyNumber = NetService.reconnectAlreadyNumber + 1
    end
    NetService.nextEnableReconnectTime = Time.time + RECONNECT_COUNT_DOWN * (NetService.reconnectAlreadyNumber or 1)
    if NetService.reconnectAlreadyNumber > MAX_RECONNECT_NUM then
        if NetService.reconnectFailedCB then
            NetService.reconnectFailedCB()
        end
    else
        NetService.onAutoReconnect()
    end
end

-- ↑↑↑ 重连逻辑 ↑↑↑ --

return NetService
