


---@class BattleLogo : UIBaseLogo
local BattleLogo = Class("BattleLogo", UIControls.Logo)

--状态显示最大值
local STATE_SHOW_MAX = 9





function BattleLogo:InitData(entId, heroCfgId, monsterCfgId, camp, hp, maxHp, mp, maxMp, manaGen)
    self._entId = entId
    self.isSelf = (camp == BattleConst.CAMP_PLAYER_IDX)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "sliderSelfBlood", self.isSelf)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "sliderEnemyBlood", not self.isSelf)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "isBoss", monsterCfgId and MonsterHelper.IsBoss(monsterCfgId))

    self._selfBlood = LuaCallCs.UI.JBloodSliderSetup(self:GetGameObject(), "sliderSelfBlood", hp, maxHp)
    self._enemyBlood = LuaCallCs.UI.JBloodSliderSetup(self:GetGameObject(), "sliderEnemyBlood", hp, maxHp)

    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "obj_ent_name", false)

    self:setShield(0, 0)
    self:_setHp(hp, maxHp, false)
    self:setMana(mp, maxMp, manaGen)
    self:_setState()
end

function BattleLogo:_setHp(hp, mhp, isTween)
    if self.isSelf then
        LuaCallCs.UI.JBloodSliderSetValue(self._selfBlood, hp, isTween)
    else
        LuaCallCs.UI.JBloodSliderSetValue(self._enemyBlood, hp, isTween)
    end
end

function BattleLogo:UpdateHp(hp, mhp)
    self:_setHp(hp, mhp, true)
end

function BattleLogo:setMana(mana, maxMana, manaSpeed)
    local from = mana / maxMana
    local to = from
    if manaSpeed > 0 then
        to = 1
    elseif manaSpeed < 0 then
        to = 0
    else
        to = from
    end
    local obj = LuaCallCs.GetObject(self:GetGameObject(), "sliderMp")
    LuaCallCs.UI.DoTweenImagePlayFromTo(obj, from, to)
end

function BattleLogo:setShield(shield, maxShield)
    local per = (maxShield > 0) and (shield / maxShield) or 0
    LuaCallCs.UI.UGUISliderSetValue(self:GetGameObject(), "sliderShield", per)
end

function BattleLogo:onAddState(userId, stateId, stateLevel, layer)
    self:_setState()
end

function BattleLogo:onDelState(userId, stateId, refreshState)
    self:_setState()
end

function BattleLogo:_setState()
    local stateList = EntityCmd.Buff.GetBuffList(self._entId)
    for i = 1, STATE_SHOW_MAX do
        local state = stateList[i]
        local stateId = state and state.BuffID or nil
        local stateLv = state and state.BuffLV or nil
        local stateLayer = state and state.BuffLayer or nil
        local isShow = BattleStateHelper.IsBuffShow(stateId, stateLv)
        local obj = LuaCallCs.GetObject(self:GetGameObject(), "buff_"..i)
        LuaCallCs.GameObjectActive(obj, isShow)

        if isShow then
            local atlas, icon = BattleStateHelper.GetBuffIcon(stateId, stateLv)
            LuaCallCs.UI.UGUISetImageSync(obj, "imgBuffIcon", atlas, icon)
            LuaCallCs.UI.UGUISetTextMeshPro(obj,"texBuffLayer", stateLayer)
        end
    end
end

function BattleLogo:ShowEntityID()
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "obj_ent_name", true)
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(),"text_ent_name", self._entId)
end

return BattleLogo
