local DebugConst = require "Core/Debug/DebugConst"

local ResHeroSoulStoneData = DataTable.ResHeroSoulStoneData

local DebugModule = {}

--入口中文描述
DebugModule.ENTRY_NAME = "GM指令2"
--功能函数

function DebugModule.guide(sender, menu, value)
    -- 新手引导id
    UIManager.InterfaceOpenUI(UIName.UIGuide)
end

function DebugModule.addAllHero()
    SendHandlers.ReqGmcmd("addHero")
end

function DebugModule.reqGM(value)
    log("gm send to server:" .. value)
    SendHandlers.ReqGmcmd(value)
end

function DebugModule.dataCoreData()
    local serverInfo = SimpleLoginTool.getServerInfo()
    if serverInfo then
        CS.UnityEngine.Application.OpenURL("http://" .. serverInfo.ip .. ":82/?action=Gm&_id=" .. Util.Account.PlayerUid())
    end
end

function DebugModule.reqNamedGM(name, value)
    local split = utils.splitString(value, ":")
    local gm = nil
    if #split == 1 then
        gm = string.format('%s%s', name, split[1])
    elseif #split == 2 then
        gm = string.format('%s%s:%s', name, split[1], split[2])
    end

    DebugModule.reqGM(gm)
end

function DebugModule.maxLvs()
    -- main关卡进度
    SendHandlers.ReqGmcmd("maxLvs")
end

function DebugModule.minLvs()
    -- main关卡进度
    SendHandlers.ReqGmcmd("minLvs")
end

function DebugModule.addAllEquip()
    SendHandlers.ReqGmcmd("addAllEquip")
end
function DebugModule.addAllRimuruStone(sender, menu, value)
    DebugModule.reqNamedGM("addAllRimuruStone:", value)
end

function DebugModule.finishAllTask()
    -- main关卡进度
    SendHandlers.ReqGmcmd("finishAllTask")
end

function DebugModule.addNewElementEquip(sender, menu, value)
    DebugModule.reqNamedGM('addNewElementEquip:', value)
end

function DebugModule.multiMain(sender, menu, value)
    if string.find(value, "-") then
        local args = string.split(value, "-")
        local key1, key2, key3
        if table.count(args) == 2 then
            key1 = 1
            key2 = tonumber(args[1])
            key3 = tonumber(args[2])
        elseif table.count(args) == 3 then
            key1 = tonumber(args[1])
            key2 = tonumber(args[2])
            key3 = tonumber(args[3])
        end
        if key1 and key2 and key3 then
            value = DataTable.ResStageMulti[key1][key2][key3].idx
        end
    end
    -- main关卡进度
    DebugModule.reqNamedGM('multipleMain:', value)
end

function DebugModule.main(sender, menu, value)
    if string.find(value, "-") then
        local args = string.split(value, "-")
        local key1, key2, key3
        if table.count(args) == 2 then
            key1 = 1
            key2 = tonumber(args[1])
            key3 = tonumber(args[2])
        elseif table.count(args) == 3 then
            key1 = tonumber(args[1])
            key2 = tonumber(args[2])
            key3 = tonumber(args[3])
        end
        if key1 and key2 and key3 then
            value = DataTable.ResStage[key1][key2][key3].idx
        end
    end
    -- main关卡进度
    DebugModule.reqNamedGM('main', value)
end

function DebugModule.next(sender, menu, value)
    -- 伪跨天(分钟)
    DebugModule.reqNamedGM('next', value)
end

function DebugModule.redeemCode()
    -- main关卡进度
    SendHandlers.ReqGmcmd("createCode")
end

function DebugModule.openUI(sender, menu, value)
    --打开ui
    UIManager.getUI(value, true)
end

function DebugModule.bigBagItem()
    for i, v in pairs(DataTable.ResItem) do
        SendHandlers.ReqGmcmd(string.format("addItem%s:%s", v.id, 1000000))
    end
end

function DebugModule.OnTestPay(sender, menu, value)
end

function DebugModule.OnTestPay6()
end

function DebugModule.OnAddOrder()
    DebugModule.reqNamedGM("addOrder", 100002)
end

function DebugModule.OnAddDaibi(sender, menu, value)
    local str = "100020:" .. value
    DebugModule.reqNamedGM('addItem', str)
end

function DebugModule.OnAddVipExp(sender, menu, value)
    local id = tonumber(value)
    SendHandlers.ReqGameVIP(-1, id)
end

function DebugModule.OnAddDaibi(sender, menu, value)
    local str = "100020:" .. value
    DebugModule.reqNamedGM('addItem', str)
end

function DebugModule.addEgg(sender, menu, idx)
    SendHandlers.ReqDragonEggs(idx)
end

function DebugModule.dragonNet(sender, menu, idx)
    local bis = string.find(idx, ",") ~= nil
    local skillClan = true
    if idx:find("^" .. "-3") then
        skillClan = false
    end
    if bis and not skillClan then
        local arr = string.split(idx, ',')
        SendHandlers.ReqDragonData(tonumber(arr[1]), nil, tostring(arr[2]), nil, nil, tonumber(arr[3]))
    else
        SendHandlers.ReqDragonData(idx)
    end
end

function DebugModule.soulStoneNet(sender, menu, value)
    SendHandlers.ReqGmcmd(string.format("addSoulStone:%s", value))
end

function DebugModule.getAllsoulStoneNet()

    for i,v in pairs(ResHeroSoulStoneData) do
        SendHandlers.ReqGmcmd(string.format("addSoulStone:%d:1", i))
    end

    
end

--功能列表
DebugModule.FUNC_MENU = {
    { name = "新手引导(ID)", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.guide },
    { name = "关卡进度(ID)", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.main },
    { name = "多队关卡进度(ID)", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.multiMain},
    { name = "添加全部英雄", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.addAllHero },
    { name = "伪跨天(分钟)", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.next },
    { name = "打开UI(界面表uiName)", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.openUI },
    { name = "自定义GM3", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.reqGM },
    { name = "DataCore", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.dataCoreData },
    { name = "一键满级", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.maxLvs },
    { name = "一键0级", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.minLvs },
    { name = "添加全部装备", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.addAllEquip },
    { name = "添加星核石", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.addAllRimuruStone },
    --{ name = "一键添加神器", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.addAllArtifact },
    { name = "一键完成活动任务", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.finishAllTask },
    { name = "生成兑换码", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.redeemCode },
    { name = "添加订单", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.OnAddOrder },
    { name = "充值测试", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.OnTestPay },
    { name = "充值6元礼包", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.OnTestPay6 },
    { name = "添加充值抵扣币", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.OnAddDaibi },
    { name = "增加VIP经验", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.OnAddVipExp },
    { name = "龙蛋协议", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.addEgg },
    { name = "龙协议", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.dragonNet },
    { name = "添加魂石", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.soulStoneNet },
    { name = "一键获取魂石", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.getAllsoulStoneNet },
    { name = "Item大礼包", typ = DebugConst.BTN_TYPE_BUTTON, func = DebugModule.bigBagItem },
    { name = "添加纹章", typ = DebugConst.BTN_TYPE_INPUT, func = DebugModule.addNewElementEquip },
}

return DebugModule
