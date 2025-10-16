local className = "UIRoleTipsData"
---@class RoleTipsData UIHeroTipsData的窗口数据
RoleTipsData = Class("RoleTipsData")
function RoleTipsData:ctor()
    self.name = "" ---@type string 名称
    self.roleTag = 0 ---@type number 角色id（可能是英雄，也可能是怪物）
    --self.icon_atlas = "" ---@type string 图标图集
    --self.icon_path = "" ---@type string 图标路径
    self.elite = 0 ---@type number 精英类型0普通，1精英(一般怪物用此标记)
    self.level = 0 ---@type number 等级
    self.element = 0 ---@type number 元素
    self.quality = 0 ---@type number 品质/星级
    self.camp = 0 ---@type number 阵营
    self.career = 0 ---@type number 职业
    self.orientation = 0 ---@type number 定位
    self.rarity = 0 ---@type number 稀有度
    self.capacity = 0 ---@type number 战力
    self.range = 0 ---@type number 攻击范围
    self.soulStone = {} ---@type table 魂石数据
    self.skillData = {} ---@type table<SkillShowTypeEnum, SkillData> 技能数据
    self.isJumpAlbum = false ---@type boolean 是否可跳转相册
    self._onCloseAction = nil ---@type function 点击关闭按钮的事件回调
    self.isHero = true ---@type boolean 是否是英雄数据，默认是
    self.battleId = 0 ---@type number 战斗id(只有怪物数据才有用到),在 RoleTipsDataExt.AdapterMonsterConfig 方法中设置
end


---配置点击关闭按钮的事件回调.默认没有回调
---@param func function
---@return RoleTipsData
function RoleTipsData:WithCloseAction(func)
    self._onCloseAction = func
    return self
end

---@param isActive boolean 是否可跳转
---@return RoleTipsData
---设置跳转图鉴功能
function RoleTipsData:ActiveJumpAlbum(isActive)
    self.isJumpAlbum = isActive
    return self
end

---@type fun(self: RoleTipsData) : boolean
---@return boolean 
---是否可跳转相册
function RoleTipsData:IsJumpAlbum()
    return self.isJumpAlbum or false
end

---@type fun(self: RoleTipsData) : function
---@return function 
---获取点击关闭按钮的事件回调
function RoleTipsData:GetCloseAction()
    return self._onCloseAction
end



------------------ RoleTipsDataExt ------------------------

---@class RoleTipsDataExt
RoleTipsDataExt = Class("RoleTipsDataExt")
---@type fun( heroEntity:HeroEntity) : RoleTipsData
---@param heroEntity HeroEntity 英雄实体数据
---@return RoleTipsData
---适配HeroEntity数据，转换成RoleTipsData
function RoleTipsDataExt.AdapterHeroEntity(heroEntity)
    local data = RoleTipsData()
    if heroEntity == nil then
        return data
    end
    local heroTag = heroEntity.resid
    local heroCfg = HeroHelper.GetHeroConfig(heroTag)
    if heroCfg == nil then
        return data
    end

    data.roleTag = heroTag
    data.name = heroCfg.hero_name
    --data.icon_atlas, data.icon_path = ModelHelper.getHeadPath(heroTag)
    data.element = heroCfg.elem
    data.camp = heroCfg.camp
    data.career = heroCfg.career
    data.orientation = heroCfg.pos
    data.rarity = heroCfg.rarity_id
    data.quality = heroEntity.star
    local lv = HeroHelper.GetHeroLevel(heroEntity)
    data.level = lv
    data.capacity = heroEntity.capacity
    data.range = heroCfg.attack_range or 1

    data.skillData = {}
    local skillId, skillLv = HeroHelper.GetCriticalSkillTagAndLv(heroTag, lv)
    data.skillData[SkillShowTypeEnum.Critical] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.Critical, skillLv == 0)

    skillId, skillLv = HeroHelper.GetEnterPassiveSkillTagAndLv(heroTag, lv)
    data.skillData[SkillShowTypeEnum.EnterPassive] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.EnterPassive, skillLv == 0)
    
    local heroStar = heroEntity.star
    skillId, skillLv = HeroHelper.GetHeroPassiveSkillTagAndLv(heroTag, heroStar)
    data.skillData[SkillShowTypeEnum.HeroPassive] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.HeroPassive, skillLv == 0)

    skillId, skillLv = HeroHelper.GetCaptainPassiveSkillTagAndLv(heroTag)
    data.skillData[SkillShowTypeEnum.CaptainPassive] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.CaptainPassive, skillLv == 0)

    skillId, skillLv = HeroHelper.GetAbilitySkillTagAndLv(heroTag, lv)
    data.skillData[SkillShowTypeEnum.Ability] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.Ability, skillLv == 0)
    return data
end


---@type fun( heroTag:number) : RoleTipsData
---@param heroTag number 英雄id
---@return RoleTipsData
---适配HeroConfig数据，转换成RoleTipsData
function RoleTipsDataExt.AdapterHeroCustom(heroTag, lv, star, capacity)
    local data = RoleTipsData()
    local heroCfg = HeroHelper.GetHeroConfig(heroTag)
    if heroCfg == nil then
        return data
    end

    data.roleTag = heroTag
    data.name = heroCfg.hero_name
    --data.icon_atlas, data.icon_path = ModelHelper.getHeadPath(heroTag)
    data.element = heroCfg.elem
    data.camp = heroCfg.camp
    data.career = heroCfg.career
    data.orientation = heroCfg.pos
    data.rarity = heroCfg.rarity_id
    data.quality = star
    data.level = lv
    data.capacity = capacity
    data.range = heroCfg.attack_range or 1

    data.skillData = {}
    -- data.skillData[SkillShowTypeEnum.Attack] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.Attack, skillLv == 0)
    local skillId, skillLv = HeroHelper.GetAttackSkillTagAndLv(heroTag, lv)
    data.skillData[SkillShowTypeEnum.Ability] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.Ability, skillLv == 0)

    skillId, skillLv = HeroHelper.GetCriticalSkillTagAndLv(heroTag, lv)
    data.skillData[SkillShowTypeEnum.Critical] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.Critical, skillLv == 0)

    skillId, skillLv = HeroHelper.GetEnterPassiveSkillTagAndLv(heroTag, lv)
    data.skillData[SkillShowTypeEnum.EnterPassive] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.EnterPassive, skillLv == 0)

    skillId, skillLv = HeroHelper.GetHeroPassiveSkillTagAndLv(heroTag, star)
    data.skillData[SkillShowTypeEnum.HeroPassive] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.HeroPassive, skillLv == 0)

    skillId, skillLv = HeroHelper.GetCaptainPassiveSkillTagAndLv(heroTag)
    data.skillData[SkillShowTypeEnum.CaptainPassive] = SkillHelper.CreateSkillData(skillId, skillLv, SkillShowTypeEnum.CaptainPassive, skillLv == 0)
    return data
end

---@type fun( heroTag:number) : RoleTipsData
---@param heroTag number 英雄id
---@return RoleTipsData
---适配HeroConfig数据，转换成RoleTipsData
function RoleTipsDataExt.AdapterHeroConfig(heroTag)
    local heroCfg = HeroHelper.GetHeroConfig(heroTag)
    if heroCfg == nil then
        return RoleTipsData()
    end
    return RoleTipsDataExt.AdapterHeroCustom(heroTag, 1, heroCfg.ori_star, 0)
end

---@type fun( monsterTag:number) : RoleTipsData
---@param monsterTag number 怪物id
---@return RoleTipsData
---适配MonsterConfig数据，转换成RoleTipsData
function RoleTipsDataExt.AdapterMonsterConfig(monsterTag, battleId)
    local data = RoleTipsData() ---@type RoleTipsData
    data.isHero = false
    local monsterTypeCfg = MonsterHelper.GetMonsterTypeConfig(monsterTag)
    local monsterAttrTag = MonsterHelper.GetMonsterAttrTag(monsterTag)
    local monsterAttrLv = FormationHelper.GetBattleConfigAttrLevel(battleId)
    local monsterAttrCfg = MonsterHelper.GetMonsterAttrCfg(monsterAttrTag, monsterAttrLv)
    if monsterTypeCfg == nil or monsterAttrCfg == nil then
        return data
    end

    data.roleTag = monsterTag
    data.battleId = battleId
    data.name = monsterTypeCfg.name
    data.elite = monsterTypeCfg.elite or 0
    --data.icon_atlas, data.icon_path = ModelHelper.getHeadPath(monsterTypeCfg.model)
    data.element = monsterTypeCfg.elem
    data.camp = monsterTypeCfg.camp
    data.career = monsterTypeCfg.career
    data.orientation = monsterTypeCfg.pos
    data.rarity = 0

    data.quality = monsterAttrCfg.star or HeroStarEnum.Green
    data.level = monsterAttrCfg.level
    data.capacity = 0
    data.range = monsterTypeCfg.attack_range
    data.skillData = MonsterHelper.GetMonsterSkills( monsterTag, battleId )

    return data
end