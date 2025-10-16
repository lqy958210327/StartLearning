local DebugConst = require("Core/Debug/DebugConst")
local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local BattleReplayHelper = require("Core/Debug/BattleReplayHelper")
local BattleStateData = require "Core/Common/FrameBattle/BattleObject/BattleStateData"
--local CombatUnit = require "Core/Common/FrameBattle/BattleObject/CombatUnit"

--local ResAttackEffect = DataTable.ResAttackEffect

local DebugModule = {}

--入口中文描述
DebugModule.ENTRY_NAME = "战斗"

local BATTLE_TEMP_FILE = Framework.Tools.FileUtils.GetTempPath() .. "battle_temp.txt"



local NUM_TYPES = {}
for typeStr, typeInt in pairs(Const.NUM_TYPE) do
    table.insert(NUM_TYPES, typeStr)
end


function DebugModule.pause()
    local state = GameFsm.getCurState()
    if not state.frameMgr then
        MsgManager.notice("没有在战斗状态")
        return
    end

end


function DebugModule.winBattle()
    --DebugModule.battleOver(BattleConst.CAMP_ENEMY)
    if GameFsm.InterfaceIsInState(Const.STATE_BATTLE) then
        WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 1)
    end
end
function DebugModule.loseBattle()
    --DebugModule.battleOver(BattleConst.CAMP_PLAYER)
    if GameFsm.InterfaceIsInState(Const.STATE_BATTLE) then
        WarManager:Get():MatrixReceiveOpt(BattleConst.INPUT_EVENT_LEAVE, 2)
    end
end


local BOX_TYPE_PHYSICS = 0      --0物理
local BOX_TYPE_MAGIC = 1        --1魔法
local BOX_TYPE_SACRED = 2       --2纯粹
local BOX_TYPE_HEAL = 3         --3治疗
local BOX_TYPE_SHIELD = 4       --4护盾
local BOX_TYPE_HP_REMOVE = 5    --5生命移除
local BOX_TYPE_ELEMENT = 6      --6元素（不能填6）
local BOX_TYPE_NO_CRIT = 7      -- 无法暴击
local BOX_TYPE_NO_ARMOR = 8     -- 无视护甲
local BOX_TYPE_HP_SHIELD_REMOVE = 9    --生命移除 会计算护盾



local function CombatUnit_addBattleState(self, attacker, stateId, level, delayTime )
    print(attacker.name.." 给 "..self.name.." 增加状态"..stateId.." 等级"..level.." Frame:"..self.frameNumber)
    local stateData = BattleStateData.getStateData(stateId, level)
    if stateData and stateData.conditionName and stateData.conditionValue then
        if self[stateData.conditionName] ~= stateData.conditionValue then
            return
        end
    end
    self.stateGroup:addState(attacker, stateId, level, delayTime)
end

local MAX_MANA = BattleConst.MAX_MANA
local function CombatUnit_onChangeMana(self, changeValue, autoAdd)
    if not autoAdd then
        print(self.name.." 能量变化  变化前能量:"..self.mana.." 变化量:"..changeValue.." Frame:"..self.frameNumber)
    end
    self.mana = math.max(0, math.min(self.mana + changeValue, MAX_MANA))
    if not autoAdd or self.mana == MAX_MANA then
        self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SETMANA, {self.mana, MAX_MANA})
    end
    if self.mana == 0 then
        self:raiseSimpleEvent({BattleConst.PASSIVE_TRIGGER_SIMPLE_MANA_ZERO})
    end
end




function DebugModule.showDamageCalc(sender, menu, value)
    if IS_EDITOR then
        --DamageCalc.calcDamageResult = DamageCalc_calcDamageResult
        --CombatUnit.addBattleState = CombatUnit_addBattleState
        --CombatUnit.onChangeMana = CombatUnit_onChangeMana
    end
end


function DebugModule.recordBattle(sender, menu, value)

end

function DebugModule.tryReplayBattle(sender, menu, value)
    if value ~= "无" then
        local replayDate = BattleReplayHelper.getRecorderData(value)

    end
end

-- replay查询房间和战斗数据的地址(运营平台)
local REPLAY_URL_ROOM_DEV = "http://106.75.52.55:8888/relay/roomlist"
local REPLAY_URL_ROOM = "http://106.75.52.55:8888/relay/roomlist"
local REPLAY_INFO = {}      -- 记录了当前查询的房间
local useBy = 'dev'         -- 当前选择的版本
local NOW_ACTIVE = nil      -- 当前激活的房间信息
local NOW_UID = nil         -- 当前查询的玩家UID
local function GetRoomIds(result)
    local f = io.open("D:\\temp1.text",'rb')
    local content = f:read("*all")
    REPLAY_INFO = {}
    local names = {}
    result = 0
    if result == 0 then
        local roomData = json.decode(content)
        local dateList = {}
        print("zh------------------- roomData.data", roomData.data)
        for id, data in pairs(roomData.data) do
            table.insert(dateList, data)
        end
        table.sort(dateList, function (a, b)
            return a.Time > b.Time
        end)
        for index, data in ipairs(dateList) do
            local str_t = os.date("%Y-%m-%d %H:%M:%S 星期%w", data.Time)
            REPLAY_INFO[str_t] = {data.Multi, data.RoomID, NOW_UID}
            table.insert(names, str_t)
        end
        print("查询房间列表成功")
    else
        print("查询房间列表失败"..result)
    end
    --UIManager.getUI("debug"):setServerReplayValue(names)
end

function DebugModule.onQueryPlayerBattle(sender, menu, value)
    local s = utils.splitString(value, ",")
    if #s >= 1 and #s[1] > 5 then
        local playerUid = s[1]
        NOW_UID = playerUid
        local roomtype = s[2] or '0'
        local url = REPLAY_URL_ROOM
        local finalUrl = "%s?uid=%s&roomtype=%s"
        finalUrl = string.format(finalUrl, url, playerUid, roomtype)
        Framework.Network.HttpUtils.GetToFile(finalUrl, GetRoomIds, BATTLE_TEMP_FILE)
        print("请求"..finalUrl.."的数据(房间列表)")
    else
        UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "参数格式", "1.玩家UID,2.类型(dev, ios, aos),3.房间类型(0表示全部),中间使用逗号隔开,2 3默认为内服和全部")
    end
end

-- replay查询房间和战斗数据的地址(运营平台)
local REPLAY_URL_BATTLE_DEV = "http://106.75.52.55:8888/relay/roomdata"
local REPLAY_URL_BATTLE = "http://106.75.52.55:8888/relay/roomdata"
-- 9007199254740993
local function GetBattleData( result )
    print("得到远程服务器回应，结果信息(0表示成功)："..result)
    if result == 0 then
        local f = io.open(BATTLE_TEMP_FILE,'rb')
        local content = f:read("*all")
        local roomData = json.decode(content)
        local battleData = roomData.Data
        print("数据长度为"..#battleData)
        local isMuti = NOW_ACTIVE[1] > 0
        local playerUid = NOW_ACTIVE[3]
        local NetService = require "Core/Network/NetService"
        NetService._initProtobufLib()
        local msgTable = protobuf.decode("datap.BattleData", battleData)
        if msgTable then
            print("解析数据成功")
        else
            print("解析数据失败")
        end
    end
    -- local msgTable = protobuf.decode("datap.RelayRoom", battleData, string.len(battleData))
    -- print("zh--------------------- data", msgTable.roomid)
    -- GameFSM.GetInstance():getState(Const.STATE_BATTLE_REPLAY):tryPlayServerReplay(msgTable)
end

function DebugModule.directReadBattle()
    local f = io.open(BATTLE_TEMP_FILE,'rb')
    local content = f:read("*all")
    -- local roomData = json.decode(content)
    -- local battleData = roomData.Data
    local battleData = content
    print("数据长度为"..#battleData)
    local NetService = require "Core/Network/NetService"
    NetService._initProtobufLib()
    local msgTable = protobuf.decode("datap.BattleData", battleData)
    if msgTable then
        print("解析数据成功")

    else
        print("解析数据失败")
    end
end

function DebugModule.tryReplayServerBattle(sender, menu, value)
    if REPLAY_INFO[value] then
        NOW_ACTIVE = REPLAY_INFO[value]
        local roomid = NOW_ACTIVE[2]
        local uid = NOW_ACTIVE[3]
        local finalUrl = "%s?uid=%s&roomid=%s"
        finalUrl = string.format(finalUrl, REPLAY_URL_BATTLE, uid, roomid)
        Framework.Network.HttpUtils.GetToFile(finalUrl, GetBattleData, BATTLE_TEMP_FILE)
        print("请求"..finalUrl.."的数据(战斗信息)")
    end
end

local PLAY_SERVER_MODE = false
-- 9007199254740993
local function DirectGetBattleData( result )
    print("得到远程服务器回应，结果信息(0表示成功)："..result)
    if result == 0 then
        local f = io.open(BATTLE_TEMP_FILE,'rb')
        local battleData = f:read("*all")
        print("数据长度为"..#battleData)
        local NetService = require "Core/Network/NetService"
        NetService._initProtobufLib()
        local msgTable = protobuf.decode("datap.BattleData", battleData)
        if msgTable then
            print("解析数据成功")
            if PLAY_SERVER_MODE then
                local ServerBattleReplay = require "Core/ServerBattle/ServerBattleReplay"
                ServerBattleReplay._realReplayStart(msgTable)
            else
            end
        else
            print("解析数据失败")
        end
    end
end

function DebugModule.onDirectQueryPlayerBattle(sender, menu, value)
    local s = utils.splitString(value, ",")
    if #s >= 1 and #s[1] > 5 then
        local roomid = s[1]
        local uid = s[2]
        NOW_UID = nil
        if s[3] then
            PLAY_SERVER_MODE = true
        else
            PLAY_SERVER_MODE = false
        end
        local finalUrl = "%s?uid=%s&roomid=%s"
        finalUrl = string.format(finalUrl, REPLAY_URL_BATTLE, uid, roomid)
        Framework.Network.HttpUtils.GetToFile(finalUrl, DirectGetBattleData, BATTLE_TEMP_FILE)
        print("请求"..finalUrl.."的数据(战斗数据)")
    else
        UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "参数格式", "1.玩家UID,2.类型(dev, ios, aos),3.服务端模式")
    end
end



--local TheMatrixClass = require "Core/Common/FrameBattle/TheMatrix"
--local function _initConfig(self)
--    ---------创建Matrix---------------------------------
--    self:clear()
--    if self.isZombie then
--        self.mainDlgName = "battleZombieMainDlg"
--    else
--        self.mainDlgName = "battleMainDlg"
--    end
--    self:initObjInfo()
--    local input = self:getMatrixInput()
--    self.mMatrixInstance = TheMatrixClass(input)
--    -- self.mActorMgr = BattleActorMgr(self, self.mMatrixInstance, self.mEntityDict)
--    -- self.frameMgr = FrameMgr(self.mMatrixInstance)
--    for i =1, 36000 do
--        if self.mMatrixInstance.battleOver then
--            local outputQueue = self.mMatrixInstance:getFrameOutput()
--            if outputQueue then
--                for i, output in pairs(outputQueue) do
--                    EventCenter.sendEvent(output[1], output[2], output[3])
--                end
--            end
--            break
--        else
--            self.mMatrixInstance:nextFrame()
--        end
--    end
--end

--local function startBattleOverAction(self, speResultType, realEnd)
--end

--local function onBattleResult(self, battleResult)
--    local msg = ""
--    if battleResult[2] == "kPVEResultResultTypeWin" then
--        msg = "胜利"
--    elseif battleResult[2] == "kPVEResultResultTypeTimeOut" then
--        msg = "超时"
--    else
--        msg = "失败"
--    end
--    UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "结果", msg, Slot(self.onExitBattle, self))
--end

--local SwitchBattleInfo = {false, }
--function DebugModule.switchBattleMode(sender, menu, value)
--    local quickMode = value == "快速战斗"
--    if SwitchBattleInfo[1] == quickMode then
--        return
--    end
--    local BattleState = require "Core/GameFsm/GameStateBattle"
--    if quickMode then
--        SwitchBattleInfo[1] = true
--        SwitchBattleInfo[2] = BattleState._initConfig
--        BattleState._initConfig = _initConfig
--        SwitchBattleInfo[3] = BattleState.startBattleOverAction
--        BattleState.startBattleOverAction = startBattleOverAction
--        SwitchBattleInfo[4] = BattleState.onBattleResult
--        BattleState.onBattleResult = onBattleResult
--    else
--        SwitchBattleInfo[1] = false
--        BattleState._initConfig = SwitchBattleInfo[2]
--        BattleState.startBattleOverAction = SwitchBattleInfo[3]
--        BattleState.onBattleResult = SwitchBattleInfo[4]
--    end
--end

function DebugModule.winCheatBattle()
    if GameFsm.InterfaceIsInState(Const.STATE_BATTLE) then
        GameFsm.getCurState():onMatrixOver(BattleConst.CAMP_ENEMY, nil)
        GameFsm.getCurState().frameMgr:pause()
    end
end

function DebugModule.changeBattleURL(sender, menu, value)
    REPLAY_URL_ROOM_DEV = "http://"..value.."/relay/roomlist"
    REPLAY_URL_ROOM = "http://"..value.."/relay/roomlist"
    REPLAY_URL_BATTLE_DEV = "http://"..value.."/relay/roomdata"
    REPLAY_URL_BATTLE = "http://"..value.."/relay/roomdata"
end

local _localBattle = false
function DebugModule.localBattle(sender, menu)
    _localBattle = not _localBattle

    IS_EDITOR_BATTLE = _localBattle
    return _localBattle and "联网战斗" or "本地战斗"
end

local _logBattle = false
function DebugModule.logBattle(sender, menu)
    _logBattle = not _logBattle

    IS_LOG_BATTLE = _logBattle
    return _logBattle and "战斗log关闭" or "战斗log存档"
end

function DebugModule.formationSkillArea(sender, menu, value)
    if string.find(value, "-") then
        local args = string.split(value, "-")
        local key1, key2
        key1 = tonumber(args[1])
        key2 = tonumber(args[2])
        local DragPlane = require "Core/UI/Control/Com/DragPlane"
        DragPlane.TestSkillCamp = key1
        DragPlane.TestSkillTarget = key2
    end
end

--功能列表
DebugModule.FUNC_MENU = {
    --{name = "Demo测试", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.enterDemo},
    --{name = "Demo机器人测试", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.enterRobotDemo},
    --{name = "指定英雄入场", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.heroEnterDemo},

    --{name = "暂停/恢复", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.pause},
--[[
    { name = "跳字测试", typ = DebugConst.BTN_TYPE_MENU, value = {
        { name = "类型选择", typ = DebugConst.BTN_TYPE_COMBOX, func = DebugModule.setNumType, value = NUM_TYPES },
        { name = "数字输入", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.setNum },
        { name = "跳字", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.playNum },
    }, },
    ]]
    { name = "本地战斗", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.localBattle },
    { name = "战斗胜利", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.winBattle },
    { name = "战斗失败", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.loseBattle },
    { name = "伤害log显示", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.showDamageCalc },
    { name = "战斗log存档", typ = DebugConst.BTN_TYPE_BUTTON_NAMED, func = DebugModule.logBattle },
    { name = "大招范围", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.formationSkillArea },


    --{name = "记录战斗回放", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.recordBattle},
    --{name = "播放战斗回放", typ = DebugConst.BTN_TYPE_COMBOX, func = DebugModule.tryReplayBattle, value = {}},--BattleReplayHelper.getAllRecorder()},

    --{name = "查询玩家战斗", typ = DebugConst.BTN_TYPE_INPUT, func = GetRoomIds},
    --{name = "玩家战斗回放列表", typ = DebugConst.BTN_TYPE_COMBOX, func = DebugModule.tryReplayServerBattle, value = {}},
    --{name = "直接查询房间(方式2)", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.onDirectQueryPlayerBattle},
    --{name = "战斗方式", typ = DebugConst.BTN_TYPE_COMBOX, func = DebugModule.switchBattleMode, value = {"正常","快速战斗"}},

    --{name = "战斗作弊胜利", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.winCheatBattle},
    --{name = "直接读取战斗", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.directReadBattle},


    --{name = "更改回放网址", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.changeBattleURL},

}

return DebugModule

