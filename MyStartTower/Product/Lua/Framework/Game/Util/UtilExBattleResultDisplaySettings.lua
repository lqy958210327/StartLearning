


local getBattleResultDisplayCfg = function(battleId)
    local cfg = DataTable.ResBattleConfig[battleId]
    if cfg == nil then
        LuaCallCsUtilCommon.ThrowException("---   战场配置数据空！ battleId = "..battleId)
    end
    if cfg.result_display_settings == nil then
        LuaCallCsUtilCommon.ThrowException("---   配置数据异常：result_display_settings = nil   battleId="..battleId)
    end
    local displayCfg = DataTable.ResBattleResultDisplayData[cfg.result_display_settings]
    if displayCfg == nil then
        LuaCallCsUtilCommon.ThrowException("---   配置数据异常：ResBattleResultDisplayData = nil   id ="..cfg.result_display_settings)
    end
    return displayCfg
end


local tab = {}

function tab.WinType(battleId)
    local cfg = getBattleResultDisplayCfg(battleId)
    if cfg.win_display_type == nil then
        cfg.win_display_type = 0
    end
    -- 战斗胜利结算UI 基础样式
    -- nil/0：默认，只有战斗胜利文字
    -- 1: PVP结算UI
    -- 2: 3v3结算UI
    return cfg.win_display_type
    --return 0--测试数据
end

function tab.LoseType(battleId)
    local cfg = getBattleResultDisplayCfg(battleId)
    if cfg.lose_display_type == nil then
        cfg.lose_display_type = 0
    end
    -- 战斗失败结算UI 基础样式
    -- nil/0：默认
    -- 1: PVP失败
    -- 2: 3v3失败
    return cfg.lose_display_type
    --return 0--测试数据
end

function tab.WinExtraInfo(battleId)
    local cfg = getBattleResultDisplayCfg(battleId)
    if cfg.win_extra_info == nil then
        cfg.win_extra_info = {}
    end
    -- 战斗胜利额外信息
    -- 1: 获得奖励的奖励列表
    -- 2: 主线推图专属的-挂机收益变化，afk标记
    -- 3: 囚魔至于专属的
    -- 4: 世界boss专属的
    -- 5: 获得奖励的奖励列表，奖励上附带首通小标签
    -- 6: 工会boss专属
    return cfg.win_extra_info
    --return {6}--测试数据
end

function tab.ShowWinNextBtn(battleId)
    local cfg = getBattleResultDisplayCfg(battleId)
    if cfg.win_next_show == nil then
        cfg.win_next_show = 0
    end
    -- 是否展示战斗胜利UI的下一关按钮
    -- nil/0：不展示
    -- 1：展示
    return cfg.win_next_show == 1
    --return true--测试数据
end

function tab.ShowWinReChallengeBtn(battleId)
    local cfg = getBattleResultDisplayCfg(battleId)
    if cfg.win_restart_show == nil then
        cfg.win_restart_show = 0
    end
    -- 是否展示战斗胜利UI的重新挑战按钮
    -- nil/0：不展示
    -- 1：展示
    return cfg.win_restart_show == 1
end

Util.ResultDisplaySetting = tab
