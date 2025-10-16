
-- entity 通用接口，未分类接口

---@class EntityCmd
EntityCmd = {}

---@return BaseEntity 私有方法，禁止调用
EntityCmd._entity = function(id)
    return EntityDict:Get():GetEntity(id)
end


local table = {}

function table.EntityInit(entId, info)
    -- info是战斗盒子里的数据
    local unitInfo = info.unitInfo
    local combatInfo = info.combatInfo
    local pos = unitInfo.pos
    local configId = unitInfo.resId
    local heroGid = unitInfo.gid
    local unitType = unitInfo.type
    local level = combatInfo.level
    local star = unitInfo.star
    local hp = combatInfo.hp
    local maxHp = combatInfo.mhp
    local mp = combatInfo.mana
    local maxMp = combatInfo.max_mana
    local camp = info.camp


    ---@type BattleEntity
    local ent = EntityCmd._entity(entId)
    ent.CompInfo._isHero = (unitType == "Hero")
    ent.CompInfo._heroConfigId = (unitType == "Hero") and configId or 0
    ent.CompInfo._heroGid = (unitType == "Hero") and heroGid or ""
    ent.CompInfo._isMonster = (unitType == "Monster")
    ent.CompInfo._monsterConfigId = (unitType == "Monster") and configId or 0
    ent.CompInfo._isRimuru = (unitType == "Rimuru")
    ent.CompInfo._rimuruId = (unitType == "Rimuru") and configId or 0
    ent.CompInfo._isSummoned = (pos == nil)
    ent.CompInfo._level = level
    ent.CompInfo._star = star
    ent.CompInfo._camp = camp
    ent.CompInfo._pos = pos


    ent.CompProp:SetProp(EntPropType.Hp, hp)
    ent.CompProp:SetProp(EntPropType.MaxHp, maxHp)
    ent.CompProp:SetProp(EntPropType.Mp, mp)
    ent.CompProp:SetProp(EntPropType.MaxMp, maxMp)
    ent.CompProp:SetProp(EntPropType.Shield, 0)
    ent.CompProp:SetProp(EntPropType.MaxShield, 0)
end

function table.OnHpChange(entId, oldHp, hp, maxHp)
    ---@type BattleEntity
    local ent = EntityCmd._entity(entId)
    ent.CompProp:SetProp(EntPropType.Hp, hp)
    ent.CompProp:SetProp(EntPropType.MaxHp, maxHp)
    WarManager:Get():OnEntityHpChange(entId, oldHp, hp, maxHp)
end

function table.OnMpChange(entId, mp, maxMp, speed)
    ---@type BattleEntity
    local ent = EntityCmd._entity(entId)
    ent.CompProp:SetProp(EntPropType.Mp, mp)
    ent.CompProp:SetProp(EntPropType.MaxMp, maxMp)
    if speed then -- speed = nil 表示没有变化
        ent.CompProp:SetProp(EntPropType.MpSpeed, speed)
    end

    local tarMp = 0
    local time = 0
    if speed == 0 then
        tarMp = mp
        time = 0
    elseif speed > 0 then
        tarMp = maxMp
        time = maxMp / speed
    elseif speed < 0 then
        tarMp = 0
        time = -maxMp / speed
    end
    EntityCmd.BattleActor.SetHUDMana(entId)
    WarManager:Get():OnEntityMpChange(entId, mp, tarMp, time, maxMp)

    if mp >= maxMp then
        if EntityCmd.Base.GetCamp(entId) == BattleConst.CAMP_PLAYER_IDX then
            local configId = EntityCmd.Base.GetHeroConfigId(entId)
            EventManager.Global.Dispatch(EventType.GuideSystemTrigger, GuideDefine.TriggerType.HeroManaFull, configId)
        end
    end
end

function table.OnDead(entId)
    WarManager:Get():OnEntityDead(entId)
end

function table.OnReborn(entId)

end


local ShowType = {
    None = 0,
    Timeline = 1, -- timeline
    Video = 2, -- video
    CutIn = 3, -- cut in
}


function table.OnSkillBegin(entId, skillId, skillType, cardId, lockTarget, targets, showType, showTime, videoCue)
    if skillType == BattleEnum.SkillType.DaZhao then
        ---@type BattleEntity
        local ent = EntityCmd._entity(entId)

        if ent.CompInfo._camp == 1 then --我方阵营放大时播放timeline。
            ent.CompSkillCache._usingSkillId = skillId
            ent.CompSkillCache._lockTargetId = lockTarget
            ent.CompSkillCache._targetIdList = targets
            if showType == ShowType.Timeline then --timeline
                if SkillHelper.HasTimeline(skillId) then
                    EventManager.Global.Dispatch(EventType.RegisterSkillTimeEvent, entId, skillId)
                end
            elseif showType == ShowType.Video then --视频
                if videoCue and videoCue.cueList and #videoCue.cueList > 0 then
                    print("---   播放大招视频...   "..videoCue.cueList[1])
                    CueManager.playCue(ent.CompBattleActor._actor, videoCue.cueList[1])
                else
                    print("---   播放大招视频结束   ")
                end
            elseif showType == ShowType.CutIn then --cut in
                EventManager.Global.Dispatch(EventType.SkillCutInPlay, entId, skillId)
            end
        end
    end
    WarManager:Get():OnEntitySkillBegin(entId, skillId, skillType)
end

function table.OnSkillEnd(entId, isEnd, skillId, isClearDamageNum)
    --isEnd   true:正常结束   false:技能中断
    if isClearDamageNum then
        Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleSkillDamageNum, 0)
        Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleSkillHealNum, 0)
    end
    EntityCmd.Fx.EffectPoolRootSetActive(true)
    EntityCmd.Fx.FreeSkillFx(entId, skillId)
    WarManager:Get():OnEntitySkillEnd(entId, isEnd)
    EventManager.Global.Dispatch(EventType.UnRegisterSkillTimeEvent, entId, skillId, isEnd)
end

function table.OnAddBuff(entId, attackId, buffId, lv, layer)
    EntityCmd.Buff.AddBuff(entId, attackId, buffId, lv, layer)
    WarManager:Get():OnEntityAddBuff(entId, attackId, buffId, lv, layer)
end

function table.OnRemoveBuff(entId, attackId, buffId)
    EntityCmd.Buff.RemoveBuff(entId, attackId, buffId)
    WarManager:Get():OnEntityRemoveBuff(entId, attackId, buffId)
end


function table.OnShieldChange(entId, shield, maxShield)
    --totalShield:总护盾值   shield:普通护盾值   bloodShield:血量护盾值
    ---@type BattleEntity
    local ent = EntityCmd._entity(entId)
    ent.CompProp:SetProp(EntPropType.Shield, shield)
    ent.CompProp:SetProp(EntPropType.MaxShield, maxShield)
    EntityCmd.BattleActor.SetHUDShield(entId)
    WarManager:Get():OnEntityShieldChange(entId)
end

function table.OnDamage(entId, dmg, damageType, isCrit, attackerId, skillType, skillDamage )
    --UI上怪物血条要震动
    ---@type BattleEntity
    local ent = EntityCmd._entity(entId)
    if ent.CompInfo._isBloodShake then
        print("---   UI上怪物血条要震动")
        -- if  entId 是怪且配置的可震动，那么播放UI血条震动
    end

    --累计伤害数字
    if skillDamage and skillType == BattleEnum.SkillType.DaZhao and damageType == "hurtHp" then
        Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleSkillDamageNum, skillDamage)
    end

    --累计加血数字
    if skillDamage and skillType == BattleEnum.SkillType.DaZhao and damageType == "healHp" then
        Blackboard.WriteBBItemNumber(BbKey.Global, BbItemKey.BattleSkillHealNum, skillDamage)
    end

    EntityCmd.BattleActor.OnDamage(entId, dmg, damageType, isCrit, attackerId, skillType)
end


EntityCmd.Common = table

