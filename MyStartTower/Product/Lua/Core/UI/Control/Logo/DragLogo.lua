
---@class DragLogo : UIBaseLogo
local DragLogo = Class("DragLogo", UIControls.Logo)
-- 构造函数。
function DragLogo:ctor(entity, prefabPath, x, y)
    self.entity = entity
    self.isHero = false
    self:setSelect(false)
end

function DragLogo:setTarget(heroConfigId, monsterConfigId, lv)
    LuaCallCs.GameObjectActive(self:GetGameObject(), heroConfigId ~= nil or monsterConfigId ~= nil)

    self.isHero = (heroConfigId ~= nil) and true or false    --判断是英雄还是怪

    local heroConfigID = heroConfigId
    local monsterConfigID = monsterConfigId
    local lvText = lv
    local careerAtlas, careerIcon = self:_analyseCareer(heroConfigID, monsterConfigID)
    local elementAtlas, elementIcon = self:_analyseElement(heroConfigID, monsterConfigID)
    local rarity = self:_analyseRarity(heroConfigID, monsterConfigID)
    ---@type UIFormationDB
    local db = GameDB.GetDB(DBId.Formation)
    local isStrongerHero = db:IsStrongerHero(heroConfigId)

    --LuaCallCs.UI.UGUISetTextMeshProAndHex(self:GetGameObject(),"textLvNum", lvText, lvColor)
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(),"textLvNum", lvText)
    LuaCallCs.UI.UGUISetImageSync(self:GetGameObject(), "iconEle", elementAtlas, elementIcon)
    LuaCallCs.UI.UGUISetImageSync(self:GetGameObject(), "IconCareer", careerAtlas, careerIcon)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "isBoss", monsterConfigID and MonsterHelper.IsBoss(monsterConfigID))
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "isHeroStronger", isStrongerHero)
    for i = 1, 6 do
        LuaCallCs.SetGameObjectActive(self:GetGameObject(), "iconRarity_"..i, rarity == i)
    end
end

function DragLogo:showHP(isShow, hp, mp)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "BloodGroup", isShow)
    if isShow then
        LuaCallCs.UI.UGUISliderSetValue(self:GetGameObject(), "sliderBlood", hp*0.0001)
        LuaCallCs.UI.UGUISliderSetValue(self:GetGameObject(), "sliderMp", mp*0.01)
    end
end

function DragLogo:_analyseCareer(heroConfigID, monsterConfigID)
    local career = 0
    if heroConfigID then
        career = DataTable.ResHero[heroConfigID].career
    end
    if monsterConfigID then
        career = DataTable.ResMonster[monsterConfigID].career
    end
    local atlas, icon = HeroHelper.GetCareerMiniIcon(career, false)
    return atlas, icon
end

function DragLogo:_analyseElement(heroConfigID, monsterConfigID)
    local elem = 0
    if heroConfigID then
        elem = DataTable.ResHero[heroConfigID].elem
    end
    if monsterConfigID then
        elem = DataTable.ResMonster[monsterConfigID].elem
    end
    local atlas, icon = ElementHelper.GetElementMiniIcon(elem, false)
    return atlas, icon
end

function DragLogo:_analyseRarity(heroConfigID, monsterConfigID)
    local rarity = 0
    if heroConfigID then
        rarity = DataTable.ResHero[heroConfigID].rarity_id
    end
    if monsterConfigID then
        rarity = DataTable.ResMonster[monsterConfigID].rarity_id
    end
    return rarity
end






function DragLogo:setSelect(isSelect,playAudio)
    --self.imgSelect:setVisible(isSelect)
    if isSelect then
        --self.imgSelect:playEffectByPath(EFFPATH.."efx_ui_select.prefab")
        print("---   这里可能要展示个特效, effName = efx_ui_select.prefab")
        if playAudio then
            print("---   这里可能要播放音效")
            --self.audioSelect:playAudio()
        end
    end
end

function DragLogo:playBattleSupport()
    --self.aniSupport:setVisible(true)
    --self.aniSupport:startAni("ShowSupport", true)
    print("---   这是原来的打开阵营加成特效")
end

function DragLogo:playBattleOvercome(isLoop)
    --self.aniOvercome:setVisible(true)
    --if isLoop then
    --    self.aniOvercome:startAniLoop("ShowGroupOrderLoop")
    --else
    --    self.aniOvercome:startAni("ShowGroupOrder", true)
    --end
    print("---   这是原来的打开阵营压制特效")
end

function DragLogo:stopBattleOvercome()
    --self.aniOvercome:setVisible(false)
    print("---   这是原来的关闭阵营压制特效")
end

return DragLogo
