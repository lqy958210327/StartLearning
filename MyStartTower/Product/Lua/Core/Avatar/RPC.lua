local RPC = {}


function RPC.roleInfo(name, gender, head)
    local clientPkg = protoFrameCache['kCSMsgRoleInfo']

    local specEntry = clientPkg['csp.role_info_c']
    specEntry['name'] = name
    specEntry['gender'] = gender
    specEntry['head'] = head

    RPCService._packAndSend(clientPkg)
end



function RPC.executeGM(gmstr, server)
    local clientPkg = protoFrameCache['kCSMsgExecuteGM']

    local specEntry = clientPkg['csp.gm_c']
    specEntry['gmstr'] = gmstr
    specEntry['server'] = server

    RPCService._packAndSend(clientPkg)
end

function RPC.mailUpdate(read, del)
    local clientPkg = protoFrameCache['kCSMsgMailUpdate']

    local specEntry = clientPkg['csp.mail_update_c']
    specEntry['read'] = read
    specEntry['del'] = del

    RPCService._packAndSend(clientPkg)
end

function RPC.mailGetAttach(mailid)
    local clientPkg = protoFrameCache['kCSMsgMailGetAttach']

    local specEntry = clientPkg['csp.mail_get_attach_c']
    specEntry['mailid'] = mailid

    RPCService._packAndSend(clientPkg)
end



function RPC.buddyAdd(uid)
    local clientPkg = protoFrameCache['kCSMsgBuddyAdd']

    local specEntry = clientPkg['csp.buddy_add_c']
    specEntry['uid'] = uid

    RPCService._packAndSend(clientPkg)
end


function RPC.opActGetAward(act_id, index, param)
    local clientPkg = protoFrameCache['kCSMsgOpActGetAward']

    local specEntry = clientPkg['csp.opact_get_award_c']
    specEntry['act_id'] = act_id
    specEntry['index'] = index
    specEntry['param'] = param

    RPCService._packAndSend(clientPkg)
end



function RPC.bingoSetBigReward(activity_id, reward_id)
    local clientPkg = protoFrameCache['kCSMsgBingoSetBigReward']

    local specEntry = clientPkg['csp.bingo_set_big_reward_c']
    specEntry['activity_id'] = activity_id
    specEntry['reward_id'] = reward_id

    RPCService._packAndSend(clientPkg)
end




function RPC.opActSetFocus(act_id, miss_focus)
    local clientPkg = protoFrameCache['kCSMsgOpActSetFocus']

    local specEntry = clientPkg['csp.opact_set_focus_c']
    specEntry['act_id'] = act_id
    specEntry['miss_focus'] = miss_focus

    RPCService._packAndSend(clientPkg)
end

function RPC.opActShopRefresh(act_id, cur_round)
    local clientPkg = protoFrameCache['kCSMsgOpActShopRefresh']

    local specEntry = clientPkg['csp.opact_shop_refresh_c']
    specEntry['act_id'] = act_id
    specEntry['cur_round'] = cur_round

    RPCService._packAndSend(clientPkg)
end

function RPC.opActAchieveFinalAward(act_id)
    local clientPkg = protoFrameCache['kCSMsgOpActAchieveFinalAward']

    local specEntry = clientPkg['csp.opact_achieve_final_award_c']
    specEntry['act_id'] = act_id

    RPCService._packAndSend(clientPkg)
end





function RPC.opActLotteryGetRank(act_id)
    local clientPkg = protoFrameCache['kCSMsgOpActLotteryGetRank']

    local specEntry = clientPkg['csp.opact_lottery_get_rank_c']
    specEntry['act_id'] = act_id

    RPCService._packAndSend(clientPkg)
end

function RPC.opActShopLevelUp(act_id, level)
    local clientPkg = protoFrameCache['kCSMsgOpActShopLevelUp']

    local specEntry = clientPkg['csp.opact_shop_level_up_c']
    specEntry['act_id'] = act_id
    specEntry['level'] = level

    RPCService._packAndSend(clientPkg)
end




function RPC.opactFirePlaceGetAward(act_id, sock_id, index)
    local clientPkg = protoFrameCache['kCSMsgOpactFirePlaceGetAward']

    local specEntry = clientPkg['csp.opact_fire_place_c']
    specEntry['act_id'] = act_id
    specEntry['sock_id'] = sock_id
    specEntry['index'] = index

    RPCService._packAndSend(clientPkg)
end




function RPC.opActOnHookRoleFirstIn(act_id)
    local clientPkg = protoFrameCache['kCSMsgOpActOnHookRoleFirstIn']

    local specEntry = clientPkg['csp.opact_onhook_first_in']
    specEntry['act_id'] = act_id

    RPCService._packAndSend(clientPkg)
end




function RPC.opActOnHookRoleDeliver(act_id, item_index)
    local clientPkg = protoFrameCache['kCSMsgOpActOnHookRoleDeliver']

    local specEntry = clientPkg['csp.opact_onhook_deliver']
    specEntry['act_id'] = act_id
    specEntry['item_index'] = item_index

    RPCService._packAndSend(clientPkg)
end







function RPC.opActDrawGetShareAward(act_id)
    local clientPkg = protoFrameCache['kCSMsgOpActDrawGetShareAward']

    local specEntry = clientPkg['csp.opact_draw_get_share_award']
    specEntry['act_id'] = act_id

    RPCService._packAndSend(clientPkg)
end

function RPC.opActDrawReplaceShareAward(act_id)
    local clientPkg = protoFrameCache['kCSMsgOpActDrawReplaceShareAward']

    local specEntry = clientPkg['csp.opact_draw_replace_share_award']
    specEntry['act_id'] = act_id

    RPCService._packAndSend(clientPkg)
end









function RPC.opActClanBossDispatch(act_id, boss_id, layer, gid)
    local clientPkg = protoFrameCache['kCSMsgOpActClanBossDispatch']

    local specEntry = clientPkg['csp.opact_clan_boss_dispatch_c']
    specEntry['act_id'] = act_id
    specEntry['boss_id'] = boss_id
    specEntry['layer'] = layer
    specEntry['gid'] = gid

    RPCService._packAndSend(clientPkg)
end

function RPC.opActClanBossGetStageAward(act_id, boss_id, layer, index)
    local clientPkg = protoFrameCache['kCSMsgOpActClanBossGetStageAward']

    local specEntry = clientPkg['csp.opact_clan_boss_get_stage_award_c']
    specEntry['act_id'] = act_id
    specEntry['boss_id'] = boss_id
    specEntry['layer'] = layer
    specEntry['index'] = index

    RPCService._packAndSend(clientPkg)
end

function RPC.opActClanBossGetAchieveAward(act_id)
    local clientPkg = protoFrameCache['kCSMsgOpActClanBossGetAchieveAward']

    local specEntry = clientPkg['csp.opact_clan_boss_get_achieve_award_c']
    specEntry['act_id'] = act_id

    RPCService._packAndSend(clientPkg)
end






function RPC.rechargeGenerateOrderID(channel_account, recharge_id, product_id, amount, first_bonus, normal_bonus, use_type, sel_id)
    local clientPkg = protoFrameCache['kCSMsgRechargeGenerateOrderID']

    local specEntry = clientPkg['csp.recharge_generate_orderid_c']
    specEntry['channel_account'] = channel_account
    specEntry['recharge_id'] = recharge_id
    specEntry['product_id'] = product_id
    specEntry['amount'] = amount
    specEntry['first_bonus'] = first_bonus
    specEntry['normal_bonus'] = normal_bonus
    specEntry['use_type'] = use_type
    specEntry['sel_id'] = sel_id

    RPCService._packAndSend(clientPkg)
end

function RPC.rechargeCancelOrder(recharge_id, orderid)
    local clientPkg = protoFrameCache['kCSMsgRechargeCancelOrder']

    local specEntry = clientPkg['csp.recharge_cancel_order_c']
    specEntry['recharge_id'] = recharge_id
    specEntry['orderid'] = orderid

    RPCService._packAndSend(clientPkg)
end

function RPC.rechargeListGet(rechargedata)
    local clientPkg = protoFrameCache['kCSMsgRechargeListGet']

    local specEntry = clientPkg['csp.recharge_list_get_c']
    specEntry['rechargedata'] = rechargedata

    RPCService._packAndSend(clientPkg)
end

function RPC.rechargeGetFirstAward(day)
    local clientPkg = protoFrameCache['kCSMsgRechargeGetFirstAward']

    local specEntry = clientPkg['csp.recharge_get_first_award_c']
    specEntry['day'] = day

    RPCService._packAndSend(clientPkg)
end




function RPC.draw(type, count, cost_type, camp_type, total_count)
    local clientPkg = protoFrameCache['kCSMsgDraw']

    local specEntry = clientPkg['csp.draw_c']
    specEntry['type'] = type
    specEntry['count'] = count
    specEntry['cost_type'] = cost_type
    specEntry['camp_type'] = camp_type
    specEntry['total_count'] = total_count

    RPCService._packAndSend(clientPkg)
end

function RPC.drawNewbie(record_index)
    local clientPkg = protoFrameCache['kCSMsgDrawNewbie']

    local specEntry = clientPkg['csp.draw_newbie_c']
    specEntry['record_index'] = record_index

    RPCService._packAndSend(clientPkg)
end










function RPC.pVEStart(_type, _spec)
    --['csp.pve_start_c']
    --['csp.pve_start_notify']

    -- 联网并且不是测试战斗，发送请求
    if not IS_EDITOR_BATTLE  then
        SendHandlers.ReqBattleAction(_type, _spec)
        return
    end


end



function RPC.pVEStartCallBack(start)

    if start.type == BattleConst.BATTLE_TYPE_NONE then
        LuaCallCs.LogError("---   战斗出错了，服务器找不到这场战斗，客户端强制退出战斗！！！")
        Util.BattleExitJump.ExitBattle()
        return
    end

    BattleProgressManager:Get():EnterFight(start)
end

--function RPC.pVEFinish(type, result, common, spec, gm)
--    --['csp.pve_finish_c']
--    --['csp.pve_finish_s']
--    -- log("pVEFinish")
--
--    Cache.cachedBattleDiffs = nil
--
--    -- 联网并且不是测试战斗，发送请求
--    if not IS_EDITOR_BATTLE and not IS_TEST_BATTLE then
--        SendHandlers.ReqCSPVEFinish({ type = type, result = result, common = common, spec = spec, gm = gm; })
--        return
--    end
--
--    local finish = {
--        common = common,
--        spec = spec,
--    }
--
--    -- 无网络请求，直接回调完成
--    RPC.pVEFinishCallBack(type, result, finish)
--end

function RPC.pVEFinishNew(data)
    --['csp.pve_finish_c']
    --['csp.pve_finish_s']
    -- log("pVEFinish")

    --Cache.cachedBattleDiffs = nil

    -- 联网并且不是测试战斗，发送请求
    if not IS_EDITOR_BATTLE  then
        SendHandlers.ReqCSPVEFinish(data)
        return
    end

    --local finish = {
    --    common = common,
    --    spec = spec,
    --}

    -- 无网络请求，直接回调完成 -- FIXME 参数不对
    print("---   单机测试，战斗结束，这里没有处理...")
    --RPC.pVEFinishCallBack()
end



function RPC.pVEFinishCallBack(battleType, battleId, isWin, details)

    if not GameFsm.InterfaceIsInState(Const.STATE_BATTLE) then
        -- 不应该出现这种情况
        LuaCallCs.LogError("---   数据不同步：接收到战斗结算消息，当前已不在战斗中...   battleId = "..battleId)
        return
    end

    local battleState = GameFsm.getState(Const.STATE_BATTLE)
    battleState:onBattleResult(battleType, battleId, isWin, details)
end




function RPC.pVEBattleReplay(battle_id, battle_type)
    local clientPkg = protoFrameCache['kCSMsgPVEBattleReplay']

    local specEntry = clientPkg['csp.pve_battle_replay_c']
    specEntry['battle_id'] = battle_id
    specEntry['battle_type'] = battle_type

    RPCService._packAndSend(clientPkg)
end










function RPC.formationSnapshot(pos, snapshot)
    local clientPkg = protoFrameCache['kCSMsgFormationSnapshot']

    local specEntry = clientPkg['csp.formation_snapshot_c']
    specEntry['pos'] = pos
    specEntry['snapshot'] = snapshot

    RPCService._packAndSend(clientPkg)
end



function RPC.formationSnapshotGet(pos)
    local clientPkg = protoFrameCache['kCSMsgFormationSnapshotGet']

    local specEntry = clientPkg['csp.formation_snapshot_get_c']
    specEntry['pos'] = pos

    RPCService._packAndSend(clientPkg)
end

















function RPC.equipWear(hero, equip_id)
    local clientPkg = protoFrameCache['kCSMsgEquipWear']

    local specEntry = clientPkg['csp.equip_wear_c']
    specEntry['hero'] = hero
    specEntry['equip_id'] = equip_id

    RPCService._packAndSend(clientPkg)
end

function RPC.equipOff(hero, pos)
    local clientPkg = protoFrameCache['kCSMsgEquipOff']

    local specEntry = clientPkg['csp.equip_off_c']
    specEntry['hero'] = hero
    specEntry['pos'] = pos

    RPCService._packAndSend(clientPkg)
end

function RPC.equipSell(equip_id)
    local clientPkg = protoFrameCache['kCSMsgEquipSell']

    local specEntry = clientPkg['csp.equip_sell_c']
    specEntry['equip_id'] = equip_id

    RPCService._packAndSend(clientPkg)
end

function RPC.equipLevelUp(gid, cost_gid, item_id, item_num, cur_exp)
    local clientPkg = protoFrameCache['kCSMsgEquipLevelUp']

    local specEntry = clientPkg['csp.equip_levelup_c']
    specEntry['gid'] = gid
    specEntry['cost_gid'] = cost_gid
    specEntry['item_id'] = item_id
    specEntry['item_num'] = item_num
    specEntry['cur_exp'] = cur_exp

    RPCService._packAndSend(clientPkg)
end

function RPC.equipSwap(hero_gids)
    local clientPkg = protoFrameCache['kCSMsgEquipSwap']

    local specEntry = clientPkg['csp.equip_swap_c']
    specEntry['hero_gids'] = hero_gids

    RPCService._packAndSend(clientPkg)
end



function RPC.artifactWear(hero, artifact_id)
    local clientPkg = protoFrameCache['kCSMsgArtifactWear']

    local specEntry = clientPkg['csp.artifact_wear_c']
    specEntry['hero'] = hero
    specEntry['artifact_id'] = artifact_id

    RPCService._packAndSend(clientPkg)
end

function RPC.artifactOff(hero, off_artifact_id)
    local clientPkg = protoFrameCache['kCSMsgArtifactOff']

    local specEntry = clientPkg['csp.artifact_off_c']
    specEntry['hero'] = hero
    specEntry['off_artifact_id'] = off_artifact_id

    RPCService._packAndSend(clientPkg)
end

function RPC.artifactSell(artifact_id)
    local clientPkg = protoFrameCache['kCSMsgArtifactSell']

    local specEntry = clientPkg['csp.artifact_sell_c']
    specEntry['artifact_id'] = artifact_id

    RPCService._packAndSend(clientPkg)
end










function RPC.achieveGetAward(achieve_id)
    local clientPkg = protoFrameCache['kCSMsgAchieveGetAward']

    local specEntry = clientPkg['csp.achieve_get_award_c']
    specEntry['achieve_id'] = achieve_id

    RPCService._packAndSend(clientPkg)
end

function RPC.achieveProgressUpdateClient(achieve_type, progress)
    local clientPkg = protoFrameCache['kCSMsgAchieveProgressUpdateClient']

    local specEntry = clientPkg['csp.achieve_progress_update_client_c']
    specEntry['achieve_type'] = achieve_type
    specEntry['progress'] = progress

    RPCService._packAndSend(clientPkg)
end




function RPC.roleMiscYD(data, type)
    local clientPkg = protoFrameCache['kCSMsgRoleMiscYD']

    local specEntry = clientPkg['csp.role_misc_yd_c']
    specEntry['data'] = data
    specEntry['type'] = type

    RPCService._packAndSend(clientPkg)
end

















function RPC.cDKey(cdkey)
    local clientPkg = protoFrameCache['kCSMsgCDKey']

    local specEntry = clientPkg['csp.cdkey_c']
    specEntry['cdkey'] = cdkey

    RPCService._packAndSend(clientPkg)
end







function RPC.houseVisit(uid)
    local clientPkg = protoFrameCache['kCSMsgHouseVisit']

    local specEntry = clientPkg['csp.house_visit_c']
    specEntry['uid'] = uid

    RPCService._packAndSend(clientPkg)
end




function RPC.houseUnlockAwardGet()
    local clientPkg = protoFrameCache['kCSMsgHouseUnlockAwardGet']

    local specEntry = clientPkg['csp.house_unlock_award_get_c']

    RPCService._packAndSend(clientPkg)
end






function RPC.rankIndexGet(rank_type)
    local clientPkg = protoFrameCache['kCSMsgRankIndexGet']

    local specEntry = clientPkg['csp.rank_index_get_c']
    specEntry['rank_type'] = rank_type

    RPCService._packAndSend(clientPkg)
end

function RPC.rankGet(rank_type, page)
    local clientPkg = protoFrameCache['kCSMsgRankGet']

    local specEntry = clientPkg['csp.rank_get_c']
    specEntry['rank_type'] = rank_type
    specEntry['page'] = page

    RPCService._packAndSend(clientPkg)
end







function RPC.roleCommGet(uid, mask)
    local clientPkg = protoFrameCache['kCSMsgRoleCommGet']

    local specEntry = clientPkg['csp.role_comm_get_c']
    specEntry['uid'] = uid
    specEntry['mask'] = mask

    RPCService._packAndSend(clientPkg)
end


















function RPC.multiPVPRank(page)
    local clientPkg = protoFrameCache['kCSMsgMultiPVPRank']

    local specEntry = clientPkg['csp.multipvp_rank_c']
    specEntry['page'] = page

    RPCService._packAndSend(clientPkg)
end




function RPC.relicWear(hero_id, relic_id)
    local clientPkg = protoFrameCache['kCSMsgRelicWear']

    local specEntry = clientPkg['csp.relic_wear_c']
    specEntry['hero_id'] = hero_id
    specEntry['relic_id'] = relic_id

    RPCService._packAndSend(clientPkg)
end

function RPC.relicOff(hero_id)
    local clientPkg = protoFrameCache['kCSMsgRelicOff']

    local specEntry = clientPkg['csp.relic_off_c']
    specEntry['hero_id'] = hero_id

    RPCService._packAndSend(clientPkg)
end





function RPC.rechargeRebateAward()
    local clientPkg = protoFrameCache['kCSMsgRechargeRebateAward']

    local specEntry = clientPkg['csp.recharge_rebate_award_c']

    RPCService._packAndSend(clientPkg)
end








function RPC.opactArenaRankGet(act_id, league, page)
    local clientPkg = protoFrameCache['kCSMsgOpactArenaRankGet']

    local specEntry = clientPkg['csp.opact_arena_rank_get_c']
    specEntry['act_id'] = act_id
    specEntry['league'] = league
    specEntry['page'] = page

    RPCService._packAndSend(clientPkg)
end







function RPC.opActTowerGetBuff(act_id, tower_id, sys_buff, tower_buff)
    local clientPkg = protoFrameCache['kCSMsgOpActTowerGetBuff']

    local specEntry = clientPkg['csp.opact_tower_get_buff_c']
    specEntry['act_id'] = act_id
    specEntry['tower_id'] = tower_id
    specEntry['sys_buff'] = sys_buff
    specEntry['tower_buff'] = tower_buff

    RPCService._packAndSend(clientPkg)
end















function RPC.clanBattleEnter(activity_id, hero_gid, model)
    local clientPkg = protoFrameCache['kCSMsgClanBattleEnter']

    local specEntry = clientPkg['csp.clan_battle_enter_c']
    specEntry['activity_id'] = activity_id
    specEntry['hero_gid'] = hero_gid
    specEntry['model'] = model

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleExit(activity_id)
    local clientPkg = protoFrameCache['kCSMsgClanBattleExit']

    local specEntry = clientPkg['csp.clan_battle_exit_c']
    specEntry['activity_id'] = activity_id

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleOccupyGrid(activity_id, layer, grid_pos, path)
    local clientPkg = protoFrameCache['kCSMsgClanBattleOccupyGrid']

    local specEntry = clientPkg['csp.clan_battle_occupy_grid_c']
    specEntry['activity_id'] = activity_id
    specEntry['layer'] = layer
    specEntry['grid_pos'] = grid_pos
    specEntry['path'] = path

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleCancelGrid(activity_id, layer, grid_pos)
    local clientPkg = protoFrameCache['kCSMsgClanBattleCancelGrid']

    local specEntry = clientPkg['csp.clan_battle_cancel_grid_c']
    specEntry['activity_id'] = activity_id
    specEntry['layer'] = layer
    specEntry['grid_pos'] = grid_pos

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleOccupyMonster(activity_id, layer, grid_pos, path)
    local clientPkg = protoFrameCache['kCSMsgClanBattleOccupyMonster']

    local specEntry = clientPkg['csp.clan_battle_occupy_monster_c']
    specEntry['activity_id'] = activity_id
    specEntry['layer'] = layer
    specEntry['grid_pos'] = grid_pos
    specEntry['path'] = path

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleCancelMonster(activity_id, layer, grid_pos)
    local clientPkg = protoFrameCache['kCSMsgClanBattleCancelMonster']

    local specEntry = clientPkg['csp.clan_battle_cancel_monster_c']
    specEntry['activity_id'] = activity_id
    specEntry['layer'] = layer
    specEntry['grid_pos'] = grid_pos

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleOpenGrid(activity_id, layer, grid_pos)
    local clientPkg = protoFrameCache['kCSMsgClanBattleOpenGrid']

    local specEntry = clientPkg['csp.clan_battle_open_grid_c']
    specEntry['activity_id'] = activity_id
    specEntry['layer'] = layer
    specEntry['grid_pos'] = grid_pos

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleNextLayer(activity_id, grid_pos, path)
    local clientPkg = protoFrameCache['kCSMsgClanBattleNextLayer']

    local specEntry = clientPkg['csp.clan_battle_next_layer_c']
    specEntry['activity_id'] = activity_id
    specEntry['grid_pos'] = grid_pos
    specEntry['path'] = path

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleBuySkill(activity_id, skill_id)
    local clientPkg = protoFrameCache['kCSMsgClanBattleBuySkill']

    local specEntry = clientPkg['csp.clan_battle_buy_skill_c']
    specEntry['activity_id'] = activity_id
    specEntry['skill_id'] = skill_id

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleUseSkill(activity_id, layer, skill_id)
    local clientPkg = protoFrameCache['kCSMsgClanBattleUseSkill']

    local specEntry = clientPkg['csp.clan_battle_use_skill_c']
    specEntry['activity_id'] = activity_id
    specEntry['layer'] = layer
    specEntry['skill_id'] = skill_id

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleSetModel(activity_id, hero_gid, model)
    local clientPkg = protoFrameCache['kCSMsgClanBattleSetModel']

    local specEntry = clientPkg['csp.clan_battle_set_model_c']
    specEntry['activity_id'] = activity_id
    specEntry['hero_gid'] = hero_gid
    specEntry['model'] = model

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleGiveOrder(activity_id, layer, order, target)
    local clientPkg = protoFrameCache['kCSMsgClanBattleGiveOrder']

    local specEntry = clientPkg['csp.clan_battle_give_order_c']
    specEntry['activity_id'] = activity_id
    specEntry['layer'] = layer
    specEntry['order'] = order
    specEntry['target'] = target

    RPCService._packAndSend(clientPkg)
end




function RPC.clanBattleScoreInfuse(activity_id, infuse_id)
    local clientPkg = protoFrameCache['kCSMsgClanBattleScoreInfuse']

    local specEntry = clientPkg['csp.clan_battle_score_infuse_c']
    specEntry['activity_id'] = activity_id
    specEntry['infuse_id'] = infuse_id

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleGetScoreLog(activity_id)
    local clientPkg = protoFrameCache['kCSMsgClanBattleGetScoreLog']

    local specEntry = clientPkg['csp.clan_battle_get_score_log_c']
    specEntry['activity_id'] = activity_id

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleGetLog(activity_id)
    local clientPkg = protoFrameCache['kCSMsgClanBattleGetLog']

    local specEntry = clientPkg['csp.clan_battle_get_log_c']
    specEntry['activity_id'] = activity_id

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleGetClanAchieveAward(activity_id, achieve_id)
    local clientPkg = protoFrameCache['kCSMsgClanBattleGetClanAchieveAward']

    local specEntry = clientPkg['csp.clan_battle_get_clan_achieve_award_c']
    specEntry['activity_id'] = activity_id
    specEntry['achieve_id'] = achieve_id

    RPCService._packAndSend(clientPkg)
end

function RPC.clanBattleGetMemberAchieveAward(activity_id, achieve_id)
    local clientPkg = protoFrameCache['kCSMsgClanBattleGetMemberAchieveAward']

    local specEntry = clientPkg['csp.clan_battle_get_member_achieve_award_c']
    specEntry['activity_id'] = activity_id
    specEntry['achieve_id'] = achieve_id

    RPCService._packAndSend(clientPkg)
end






function RPC.heroLevelUp(hero_gid, next_lv)
    local clientPkg = protoFrameCache['kCSMsgHeroLevelUp']

    local specEntry = clientPkg['csp.hero_level_up_c']
    specEntry['hero_gid'] = hero_gid
    specEntry['next_lv'] = next_lv

    RPCService._packAndSend(clientPkg)
end

function RPC.heroStepUp(hero_gid)
    local clientPkg = protoFrameCache['kCSMsgHeroStepUp']

    local specEntry = clientPkg['csp.hero_step_up_c']
    specEntry['hero_gid'] = hero_gid

    RPCService._packAndSend(clientPkg)
end






function RPC.heroOffWears(op_type, gid)
    local clientPkg = protoFrameCache['kCSMsgHeroOffWears']

    local specEntry = clientPkg['csp.hero_off_wears_c']
    specEntry['op_type'] = op_type
    specEntry['gid'] = gid

    RPCService._packAndSend(clientPkg)
end



function RPC.heroPaint(res_id, paint_level)
    local clientPkg = protoFrameCache['kCSMsgHeroPaint']

    local specEntry = clientPkg['csp.hero_paint_c']
    specEntry['res_id'] = res_id
    specEntry['paint_level'] = paint_level

    RPCService._packAndSend(clientPkg)
end



function RPC.heroDevelop(res_id, develop_id, level)
    local clientPkg = protoFrameCache['kCSMsgHeroDevelop']

    local specEntry = clientPkg['csp.hero_develop_c']
    specEntry['res_id'] = res_id
    specEntry['develop_id'] = develop_id
    specEntry['level'] = level

    RPCService._packAndSend(clientPkg)
end




function RPC.equipSchemeUpdate(data, version, update)
    local clientPkg = protoFrameCache['kCSMsgEquipSchemeUpdate']

    local specEntry = clientPkg['csp.equip_scheme_update_c']
    specEntry['data'] = data
    specEntry['version'] = version
    specEntry['update'] = update

    RPCService._packAndSend(clientPkg)
end

function RPC.equipSchemeApply(sel_id, version)
    local clientPkg = protoFrameCache['kCSMsgEquipSchemeApply']

    local specEntry = clientPkg['csp.equip_scheme_apply_c']
    specEntry['sel_id'] = sel_id
    specEntry['version'] = version

    RPCService._packAndSend(clientPkg)
end




function RPC.equipSchemeDelete(sel_id, version)
    local clientPkg = protoFrameCache['kCSMsgEquipSchemeDelete']

    local specEntry = clientPkg['csp.equip_scheme_delete_c']
    specEntry['sel_id'] = sel_id
    specEntry['version'] = version

    RPCService._packAndSend(clientPkg)
end

function RPC.heartBeat(count, data)
    -- 'csp.heart_beat_c'

    SendHandlers.ReqHeartBeat(nil, count, data)
end

function RPC.heartBeatCallBack(time, count)

    CurAvatar:onHeartBeatResp(time, count)
end

function RPC.netDelay(ms)
    local clientPkg = protoFrameCache['kCSMsgNetDelay']

    local specEntry = clientPkg['csp.net_delay_c']
    specEntry['ms'] = ms

    RPCService._packAndSend(clientPkg)
end







function RPC.wChatRegister()
    local clientPkg = protoFrameCache['kCSMsgWChatRegister']

    local specEntry = clientPkg['csp.chat_register_c']

    RPCService._packAndSend(clientPkg)
end






return RPC
