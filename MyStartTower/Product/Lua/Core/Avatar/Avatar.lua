local ClientAvatar = require "Core/Avatar/ClientAvatar"
local Avatar = {}



-- ↓↓↓ 网络处理 ↓↓↓ --

function Avatar.fakeAvatar()
    -- log("RECONNECT .fakeAvatar")
    -- 1.Avatar还未登录，直接返回
    if CurAvatar and CurAvatar.isAccount then
        return
    end

    -- 2.Avatar已经登录，销毁旧内容
    if CurAvatar and not CurAvatar.isAccount then
        CurAvatar:destroy()
    end

    -- 3.生成新Avatar数据
    ClientAvatar()

    -- 4.设置重连标记

    --hero
    CurAvatar.heroDic = {}

    --item

    --equip

    --skin



    --battle
    CurAvatar.formation = {}



end



function Avatar.fakeReady()
    -- 账号信息
    CurAvatar.uid = Util.Account.PlayerUid()
    -- 客户端运行时的一些数据保存在这里，断线重连时不清除，切换账号时清除
    if ClientUtils.uid == nil or ClientUtils.uid ~= CurAvatar.uid then
        ClientUtils.uid = CurAvatar.uid
        ClientUtils.record = {}
    end

    CurAvatar.gender = DataCore.player.gender
    SvrListManager._svrDict = { [0] = { name = "" } }
    local name = string.format("0-%s", Util.Account.PlayerName())
    CurAvatar:initPlayerName(name)

    -- 同步数据,战斗需要
    Avatar.initMixin()
    -- log("RECONNECT .fakeReady")

    -- 当前的战斗数据
    local battleInfo = {}
    local state = GameFsm.getCurState()
    if GameFsm.isBattleState(state.stateName) then
        --battleInfo.type = state.battleType
        battleInfo.battle_common = {
            seed = state.randomSeed,
            pve_id = state.battleNo,
        }
    end

    local enter_game = {
        time = DataCore.player.serverSec, -- 同步服务器时间
        role_data = {
            base = {
                deviceid = SDKAgent.getNativeDeviceID() -- TODO：设备ID检测
            },
            necessary = {
                battle = battleInfo -- TODO:添加战斗重连网络数据(此处先跳过)
            }
        }
    }

    local time_zone = DataCore.account.timeZoon -- 同步服务器时区差时，单位为s（时区*3600）
    CurAvatar:onDataReady()
    GameFsm.onReady(enter_game, time_zone)
end

function Avatar.isReady()
    return CurAvatar and CurAvatar.syncDataReady
end

-- ↑↑↑ 网络处理 ↑↑↑ --

-- ↓↓↓ 业务逻辑 ↓↓↓ --

--function Avatar._fixHero(hero)
--    -- LOG：接入装备
--    local equips = {}
--    for _, equip_gid in ipairs(hero.equip) do
--        table.insert(equips, { gid = equip_gid })
--    end
--
--    hero.equip = equips
--
--end






function Avatar.initMixin(battleType)
    --Avatar._initHeroMixin()
end





-- 初始化英雄数据
function Avatar._initHeroMixin()

    --local heroes = table.copy(table.values(DataCore.heroes))
    --for i, hero in ipairs(heroes) do
    --    Avatar._fixHero(hero)
    --end

    --CurAvatar:initHeroMixin()
end


return Avatar
