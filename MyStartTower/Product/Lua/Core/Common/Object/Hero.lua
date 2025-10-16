local BaseObject = require "Core/Common/Object/BaseObject"
local ResHero = DataTable.ResHero
local ResStarUpCondition = DataTable.ResStarUpCondition
local ResStar = DataTable.ResStar
local ResHeroStarImage = DataTable.ResHeroStarImage

local ResStep = DataTable.ResStep
local ResHeroCampCareerConfig = DataTable.ResHeroCampCareerConfig

local ResItemHeroBase = DataTable.ResItemHeroBase


local UIHeroCanvasConst = require("Game/UI/UIHero_new/UIHeroCanvasConst")




local isOfflineHero = NO_CSHARP

---@class Hero
local strClassName = "Hero"
local Hero = Class(strClassName, BaseObject)

function Hero:ctor(data)

end

--数据初始化
function Hero:_initData()
    Hero.super._initData(self)
    self.gid = self._serverData.gid or ""
    self.id = self._serverData.resid or self._serverData.resId or self._serverData.id

    self.resData = ResHero[self.id]
    if not self.resData then
        logerror("不存在的英雄id", self.id)
    end
    self.resid = self.id
    self.name = self.resData.hero_name or ""
    self.fullName = self.resData.full_name or ""


    self.isFront = self.resData.attack_range == 1

    self.posName = ResHeroCampCareerConfig[5][self.resData.pos].name
    self.pos = self.resData.pos
    self.career = self.resData.career
    self.quality = self.resData.quality
    self.camp = self.resData.camp
    self.elem = self.resData.elem
    self.team = self.resData.belong_team or 0
    self.banStarMaterial = self.resData.ban_star_material or 0
    if self.camp == HeroConst.CAMP_TYPE.SLIM_SNOW or self.camp == HeroConst.CAMP_TYPE.NINE_NIGHT then
        self.specialCamp = self.resData.belong_camp -- 特殊的光暗阵营可能属于某个特殊的装备塔
    end

    self.nextLvCapacity = self._serverData.nextLvCapacity
    self.star = self._serverData.star or self.resData.ori_star
    self.level = self._serverData.level or 1
    self.realLevel = self._serverData.level or 1
    self.step = self._serverData.step or 0
    self.wake = self._serverData.wake or 0
    self.lock = self._serverData.lock or 0
    self.skin = self._serverData.skin or 0
    self.base = self._serverData.base or 0
    self.capacity = self._serverData.capacity or 0
    self.image = math.max(1, self._serverData.image or 1)
    self.soulStoneList = self._serverData.soulStone or { "", "", "", "", "", "", "", "" }


    self.starUpPriority = self.resData.star_up_priority or 1
    self.heroBaseData = ResItemHeroBase[self.id]
    self.modelData = ModelUtils.getCommonModelData(self:getShowModelId())

    self:initStep()
    self:initEquipInfo()
    self.artifactGid = self._serverData.artifact
    self.relicId = self._serverData.relic
    self.relicPetGid = self._serverData.relic_pet
    self.inTeam = 0
    self.mazeStatus = 0
    self.mazeHpStep = 0.1
    self.isCryPriests = 0
    self.isCrySlot = 0
    self.inCry = 0
    self.itemType = Const.ITEM_TYPE_HERO

    self.forceSkillAnimOnce = self._serverData.forceSkillAnimOnce and true or false
    self.mainCityLevel = self._serverData.mainCityLevel

    --是否是我的英雄，因为看别人的英雄也是用的这个结构,默认是自己的,在roleinfo那里
    self.otherCrystalStep = 0
    self.otherCrystalType = 0

    self.stoneCapacity = self._serverData.stoneCapacity or 0
    self.soulStoneUnlockList = self._serverData.soulStoneSkill or {}
end

function Hero:setSkin(skinId)
    if self._serverData then
        self._serverData.skin = skinId
    end
    self.skin = skinId
    self.modelData = ModelUtils.getCommonModelData(self:getShowModelId())
end

function Hero:setBase(baseId)
    if self._serverData then
        self._serverData.base = baseId
    end
    self.base = baseId
end






function Hero:initStep()
    -- 真正生效的战斗阶数受等级和星级双重限制
    self.battleStep = math.min(self.step, self:getLvMaxStep(), self:getMaxStep())
    self:refreshSkillInfo()
end

function Hero:getLvMaxStep()
    local lvMaxStep = 0
    for step, stepInfo in ipairs(ResStep) do
        if self.level < stepInfo.level_limit then
            break
        else
            lvMaxStep = step
        end
    end
    return lvMaxStep
end

function Hero:isMyHero(...)
    if (not isOfflineHero) and CurAvatar and CurAvatar.heroDic then
        return CurAvatar.heroDic[self.gid] ~= nil
    end
    return false
end

function Hero:initCrystalData()
    self.isCryPriests = self:isCrystalPriests() and 1 or 0
    self.isCrySlot = self:isCrystalSlot() and 1 or 0
    self.inCry = (self:isCrystalPriests() or self:isCrystalSlot()) and 1 or 0
    self.realLevel = self._serverData.level or 1
    local ssLevel = self._serverData.ssLevel
    if ssLevel and ssLevel > 0 then
        self.crystalLevel = ssLevel
    elseif (not isOfflineHero) and CurAvatar and CurAvatar.crystalData then
        self.crystalLevel = self.isCrySlot == 1 and math.min(CurAvatar.crystalData.level, self:getMaxLv()) or
        self.realLevel
    else
        self.crystalLevel = 1
    end
    self.level = math.max(self.realLevel, self.crystalLevel)
    self:initStep()
end

function Hero:isCrystalPriests()
    if not self:isMyHero() then
        return self.otherCrystalType == Const.TYPE_CRYSTAL_PRIESTS
    elseif (not isOfflineHero)  then
        return false
    else
        logerror("共鸣水晶系统还未初始化完成")
        return false
    end
end

function Hero:isCrystalSlot()
    if not self:isMyHero() then
        return self.otherCrystalType == Const.TYPE_CRYSTAL_SYMPATHIZER
    elseif (not isOfflineHero) then
        return false
    else
        logerror("共鸣水晶系统还未初始化完成")
        return false
    end
end

function Hero:getCrystalStep(...)
    if not self:isMyHero() then
        return self.otherCrystalStep
    elseif (not isOfflineHero) and CurAvatar and CurAvatar.crystalData then
        return CurAvatar.crystalData.step
    else
        return 1
    end
end


function Hero:getFakeCrystalColor(...)   --获取如果是共鸣者时候的等级文字颜色
    local slotColor = self:getCrystalStep() == 2 and UIColor.LVGONGM2 or UIColor.LVGONGMING
    return slotColor
end

function Hero:getShowLv()
    if not self:isMyHero() then
        return self.realLevel or self.level
    elseif self:getCrystalStep() == 1 then
        return self.level
    else
        --if self:isCrystalSlot() and ResCrystalLevelCost[self.level] then
        --    return ResCrystalLevelCost[self.level].show_level
        --else
        return self.level
        --end
    end
end

--campColorDic为阵营改变颜色的默认值
function Hero:getLvColor(campColorDic)
    local slotColor = self:getCrystalStep() == 2 and UIColor.LVGONGM2 or UIColor.LVGONGMING
    if self:isMyHero() then
        if (not isOfflineHero) and CurAvatar and self:isCrystalPriests()  then
            return UIColor.LVGONGM2
        elseif (not isOfflineHero) and CurAvatar and self:isCrystalSlot()  then
            return slotColor
        end
    else
        if self:isCrystalPriests() then
            return UIColor.LVGONGM2
        elseif self:isCrystalSlot() then
            return slotColor
        end
    end

    if campColorDic then
        return campColorDic[self.camp]
    else
        return UIColor.WHITE
    end
end

function Hero:isFullHp(...)
    return self.mazeHp == 10000
end

function Hero:refreshSkillInfo()


end




function Hero:initEquipInfo()
    self.equipList = {}
    if self._serverData and self._serverData.equip then
        for i, v in ipairs(self._serverData.equip) do
            if self._serverData.gid ~= "0" then --之前用v.gid 判断  但是没有，报错了 所以改成现在这样
                table.insert(self.equipList, v)
            end
        end
    end
end




function Hero:getIconPath(isHead)
    if self.modelData then
        ---TODO  临时修改
        return ''
        --[[if string.find(self.modelData.head_path, 'atlas_') or string.find(self.modelData.icon_path, 'atlas_') then
            --兼容新系统——图集
            if isHead and self.modelData.head_path and self.modelData.head_name then
                return { self.modelData.head_path, self.modelData.head_name, true }
            end
            if not isHead and self.modelData.icon_path and self.modelData.icon_name then
                return { self.modelData.icon_path, self.modelData.icon_name, true }
            end
        else
            if isHead and self.modelData.head_path and self.modelData.head_name then
                return { "Atlas/" .. self.modelData.head_path, self.modelData.head_name }
            end
            if not isHead and self.modelData.icon_path and self.modelData.icon_name then
                return { "Atlas/" .. self.modelData.icon_path, self.modelData.icon_name }
            end
        end--]]
    end
end



function Hero:getBattleBgIconPath()
    return { "atlas_fightting_1", UIConst.BATTLE_HEAD_BG[self.star] }
end

function Hero:getBattleGroundBgIconPath()
    return { "atlas_fightting_2", UIConst.BATTLE_HEAD_BACKGROUND[self.star] }
end

function Hero:getQIconPath()
    if self.modelData then
        if self.modelData.q_icon_path and self.modelData.q_icon_name then
            return { "Atlas/" .. self.modelData.q_icon_path, self.modelData.q_icon_name }
        end
    end
end

function Hero:getPortraitIconPath()
    if self.modelData then
        if self.modelData.portrait_atlas and self.modelData.portrait_sprite then
            return { "Atlas/" .. self.modelData.portrait_atlas, self.modelData.portrait_sprite }
        end
    end
end

--头像背景及阶数背景
function Hero:getStepBgPath()
    local stepImgIdx = ResStarUpCondition[self.star].step_img_idx or 1
    return UIConst.HERO_CARD_SPRITE_BY_STEP[stepImgIdx]
end

--阶数本身
function Hero:getStepPath()
    if self.step > 0 then
        local stageSpriteName = self.step < 10 and "TxtStage0" or "TxtStage"
        return { "Atlas/HeroAtlas/HeroCardCommonAtlas", stageSpriteName .. self.step }
    end
end

function Hero:getQuality()
    if self.resData and self.resData.quality then
        return self.resData.quality
    end
end

--废弃
function Hero:getQualityPath(isLogo)
    if self.resData and self.resData.quality then
        if isLogo then
            return UIConst.HERO_QUALITY_LOGO_CONFIG[self.resData.quality]
        else
            return UIConst.HERO_QUALITY_CONFIG[self.resData.quality]
        end
    end
end

--废弃
function Hero:getStepImgPath()
    local stepImgIdx = ResStarUpCondition[self.star].step_img_idx or 1
    return UIConst.HERO_QUALITY_HEAD_CONFIG[stepImgIdx]
end

--todo
function Hero:getQualityPath_new()
    local path = UIHeroCanvasConst.HeroQualityData[self.star]
    return path
end

function Hero:getStepIdx()
    return ResStarUpCondition[self.star].step_img_idx or 1
end

---👇👇👇👇👇👇👇👇👇👇👇   new   👇👇👇👇👇👇👇👇👇👇👇
function Hero:getCareerPath()
    if self.resData and self.resData.career then
        return UIConst.getHeroCareerIconPath(self.resData.career)
    end
end

function Hero:getStarNum()
    local num = self.star - 11
    num = math.min(num, 5)
    return num
end

function Hero:getElementPath()
    if self.elem then
        return UIHeroCanvasConst.elementQuality[self.elem]
    end
end


function Hero:getCantSell()

end

--定位
function Hero:getOrientation()
    if self.pos ~= nil then
        local path = { "atlas_hero_info_new", "pos_" .. self.pos }
        return path
    end
    return nil
end

--头像底图
function Hero:getHeadBg()
    local path = UIHeroCanvasConst.headQualityPath[self.star]
    return path
end

--头像背景

function Hero:getHeadQuality()
    local qualityStep = math.min(self.star, 11)
    local path = { "atlas_hero_head_new", "herodetails_herohead_" .. qualityStep }
    return path
end

function Hero:getTitleName()
    if self.resData then
        return self.resData.title_name or ""
    end
    return ""
end



function Hero:getGroupPath()
    if self.resData and self.resData.camp then
        return UIConst.getHeroCampIconPath(self.resData.camp)
    end
end




function Hero:getStarPath(star)
    star = star or self.star <= 0 and 1 or self.star
    if star then
        --兼容新系统——图集
        --local starPath = star < 10 and "iconstarts0" or "iconstarts"
        --return {"Atlas/HeroAtlas/HeroCardCommonAtlas", starPath..star}
        return { UIConst.HEROICONSTAR[star][1], UIConst.HEROICONSTAR[star][2] }
    end
end



function Hero:getBigStarPath(star)
    star = star or self.star <= 0 and 1 or self.star
    if star then
        --兼容新系统——图集
        --local starPath = star < 10 and "card_big_iconstartl0" or "card_big_iconstartl"
        --return {"Atlas/HeroAtlas/HeroCardCommonAtlas", starPath..star}
        return { UIConst.HEROICONSTAR[star][1], UIConst.HEROICONSTAR[star][2] }
    end
end




function Hero:getShowModelId()


    if self.resData and self.resData.model then
        return self.resData.model
    end
end

function Hero:getFashionTag()

end

function Hero:getShowBaseModelId()

    if self.base and self.heroBaseData and self.heroBaseData[self.base] and self.heroBaseData[self.base].base_id then
        return self.heroBaseData[self.base].base_id
    end
    if self.resData and self.resData.model then
        return self.resData.model
    end
end










function Hero:getInitMana()
    local initMana = self.resData.init_mana or 0
    --if self.skillPassive1 and ResHeroPassiveConfig[self.skillPassive1.id] and ResHeroPassiveConfig[self.skillPassive1.id][self.skillPassive1.level] then
    --    initMana = initMana + ResHeroPassiveConfig[self.skillPassive1.id][self.skillPassive1.level].add_mana
    --end
    return initMana
end

function Hero:getMaxStep()
    local maxStep = 1
    if not self:getMaxStar() then
        return maxStep
    end
    for step, stepInfo in ipairs(ResStep) do
        if self:getMaxStar() >= stepInfo.need_star_limit then
            maxStep = step
        end
    end
    return maxStep
end

--达到最高星级时的最大等级
function Hero:getMaxLv()
    local maxLv = 1
    if not self:getMaxStar() then
        return maxLv
    end
    maxLv = ResStar[self.resData.star_prop_id][self:getMaxStar()].max_level
    return maxLv
end

--当前星级的的最大等级
function Hero:getMaxStarLv()
    return ResStar[self.resData.star_prop_id][self.star].max_level
end

local ResStarCost = DataTable.ResStarCost
function Hero:getMaxStar()
    return self.resData.star_limit
end





function Hero:getQualityColor(getQuality)
    local quality = getQuality or self.quality

    local color = nil
    if quality == Const.OBJ_QUALITY_WHITE then
        color = UIColor.QUALITYGREEN
    elseif quality == Const.OBJ_QUALITY_GREEN then
        color = UIColor.QUALITYBLUE
    elseif quality == Const.OBJ_QUALITY_BLUE then
        color = UIColor.QUALITYPURPLE
    elseif quality == Const.OBJ_QUALITY_PURPLE then
        color = UIColor.QUALITYFUCHSIA
    elseif quality == Const.OBJ_QUALITY_GOLD then
        color = UIColor.QUALITYORANGE
    elseif quality == 6 then
        color = UIColor.QUALITYPINK
    elseif quality == 7 then
        color = UIColor.QUALITYRED
        -- elseif quality == 8 then
        --     color = UIColor.QUALITYORA03
        -- elseif quality == 9 then
        --     color = UIColor.QUALITYORA04
        -- elseif quality == 10 then
        --     color = UIColor.QUALITYORA05
    end
    return color
end



function Hero:isHero()
    return true
end



function Hero:setHeroStepUI(bgStage, txtStage, isNotHandleCamp)
    local step, star = self.step, self.star
    if bgStage then
        bgStage:setVisible(step > 0)
        txtStage:setVisible(step > 0)
    end
    if step <= 0 then
        return
    end
    local stepImgIdx = ResStarUpCondition[star].step_img_idx or 1

    txtStage:setText(step)

end






function Hero:getHeroTipsBgByStar()
    local starImgData = ResHeroStarImage[self.star]
    if starImgData ~= nil then
        return { [1] = starImgData.tips_path, [2] = starImgData.tips_bg }
    end
    return { [1] = "img_bagtips_alpha", [2] = "mall_x2" }
end

return Hero
