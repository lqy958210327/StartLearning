

---@class UIJump UI静态工具类，用于界面跳转
UIJump = { }

------ShowTips------------------------------------
---@type fun(text:string) 触发滚动提示
---@param text string 显示内容
function UIJump.ShowScrollTips(text)
    -- 这个功能还能用，不改了，调整一下调用接口
    UIManager.InterfaceOpenUI(UIName.UINoticeBox)
    Blackboard.UIEvent.SendMessage(UIName.UINoticeBox, UIEventID.UINoticeBox_ShowTips, text, 1)
end

---@type fun(info:string, confiremAction:fun()) 通用提示弹窗
---@param info string 显示内容
---@param confiremAction fun() 确认回调
function UIJump.ShowConfirmTips(info, confiremAction)
    local uiName = UIName.UIRefreshTip
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRefreshTip_ShowTips, info, confiremAction)
end


------英雄职业、阵营、等介绍------------------------------------


---@type fun(heroConfigEnum:HeroConfigEnum, heroConfig:table) 触发滚动提示
---@param heroConfigEnum HeroConfigEnum  英雄配置枚举
---@param heroConfig nil | table 英雄配置id
---打开英雄类型介绍界面
function UIJump.ToOpenUIHeroTypeByHeroTag(heroTag, heroConfigEnum)
    ---临时代码:适配=>UICampCareerConst.Data数据中的定义
    local index = 1
    if heroConfigEnum == HeroConfigEnum.Element then
        index = 3
    elseif heroConfigEnum == HeroConfigEnum.Career then
        index = 2
    elseif heroConfigEnum == HeroConfigEnum.Camp then
        index = 1
    elseif heroConfigEnum == HeroConfigEnum.Orientation then
        index = 4
    end
    --------------------------------------------------
    


end

---@type fun(heroGid:string, heroConfigEnum:HeroConfigEnum) 打开英雄类型介绍界面
---@param heroGid string 英雄gid
---@param heroConfigEnum HeroConfigEnum 英雄配置枚举
function UIJump.ToOpenUIHeroTypeByHeroGid(heroGid, heroConfigEnum)
    local heroEntity = HeroHelper.GetEntity(heroGid)
    if heroEntity == nil then
        return
    end

    UIJump.ToOpenUIHeroTypeByHeroTag(heroEntity.resid, heroConfigEnum)

    ---临时代码:适配=>UICampCareerConst.Data数据中的定义
    -- local index = 1
    -- if heroConfigEnum == HeroConfigEnum.Element then
    --     index = 3
    -- elseif heroConfigEnum == HeroConfigEnum.Career then
    --     index = 2
    -- elseif heroConfigEnum == HeroConfigEnum.Camp then
    --     index = 1
    -- elseif heroConfigEnum == HeroConfigEnum.Orientation then
    --     index = 4
    -- end
    -- --------------------------------------------------
    
    -- local heroData = HeroHelper.GetHeroData(heroGid)
    -- local ui = UIManager.getUI("UICampCareer", true) 
    -- ui:setData(heroData, index)
end



------UIHeroReset------------------------------------
---@type fun(heroGid:string) 打开英雄重置界面
---@param heroGid string 英雄gid
---打开英雄重置界面
function UIJump.ToOpenUIHeroReset(heroGid)


end

------UIHero------------------------------------
---@type fun(heroGid:string, menuIndex:UIHeroMenuBarEnum) 打开英雄界面
---@param heroGid string | nil 英雄gid
---@param menuIndex UIHeroMenuBarEnum | number |nil 英雄菜单枚举
function UIJump.ToOpenUIHero(heroGid, menuIndex)
    local uiName = UIName.UIHero
    UIManager.getUI(uiName, true)
    local uiHeroData = UIHeroData(heroGid, menuIndex)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIHero_Refresh, uiHeroData)
end


------魂石------------------------------------
function UIJump.ToOpenUIHeroSoulStone(heroGid)
    UIJump.ToOpenUIHero(heroGid, UIHeroMenuBarEnum.SoulStone)
end


------UIHeroTips------------------------------------



---@type fun(heroGid: string, isJumpAlbum:boolean) 打开英雄提示界面
---@param heroGid string 英雄实体数据
---@param isJumpAlbum boolean 是否要跳转到展示页
---@param layout UITempSmallHeroHeadLayout 可选项
---打开英雄提示界面
function UIJump.ToOpenUIHeroTipsByHeroGid(heroGid, isJumpAlbum, btnCloseCB, layout)
    local heroEntity = HeroHelper.GetEntity(heroGid)
    local roleTipsData = RoleTipsDataExt.AdapterHeroEntity(heroEntity)
    UIJump.__toOpenUIHeroTipsByHeroEntity(roleTipsData, isJumpAlbum, btnCloseCB, layout)
end

---@type fun(heroGid: string, isJumpAlbum:boolean) 打开英雄提示界面
---@param heroEnt HeroEntity 英雄实体数据
---@param isJumpAlbum boolean 是否要跳转到展示页
---@param layout UITempSmallHeroHeadLayout 可选项
---打开英雄提示界面
function UIJump.ToOpenUIHeroTipsByHeroEntity(heroEnt, isJumpAlbum, btnCloseCB, layout)
    local roleTipsData = RoleTipsDataExt.AdapterHeroEntity(heroEnt)
    UIJump.__toOpenUIHeroTipsByHeroEntity(roleTipsData, isJumpAlbum, btnCloseCB)
end

---@type fun(heroTag: number, isJumpAlbum:boolean) 打开英雄提示界面
---@param heroTag number 英雄配置id
---@param isJumpAlbum boolean 是否要跳转到展示页
---@param layout UITempSmallHeroHeadLayout 可选项
---打开英雄提示界面
function UIJump.ToOpenUIHeroTipsByHeroTag(heroTag, isJumpAlbum, btnCloseCB, layout)
    local heroEntity = HeroEntityExt.AdapterHeroConfig(heroTag)
    local roleTipsData = RoleTipsDataExt.AdapterHeroCustom(heroEntity.resid, heroEntity.level, heroEntity.star, 0)
    UIJump.__toOpenUIHeroTipsByHeroEntity(roleTipsData, isJumpAlbum, btnCloseCB, layout)
end

---@type fun(monsterTag:number)
---@param monsterTag number 怪物id
---打开角色提示界面
function UIJump.ToOpenUIRoleTipsByMonsterTag(monsterTag, battleId)
    local data = RoleTipsDataExt.AdapterMonsterConfig(monsterTag, battleId)
    UIJump.__toOpenUIHeroTipsByHeroEntity(data, false, nil)
end


---@type fun(tag, level, star, capacity, isJumpAlbum)
---@param tag number 英雄配置id
---@param level number 英雄等级
---@param star number 英雄星级
---@param capacity number 英雄战力
---@param isJumpAlbum boolean 是否要跳转到展示页
---@param layout UITempSmallHeroHeadLayout 可选项
---打开英雄提示界面
function UIJump.ToOpenUIHeroTipsByCustom(tag, level, star, capacity, isJumpAlbum, btnCloseCB, layout)
    local roleTipsData = RoleTipsDataExt.AdapterHeroCustom(tag, level, star, capacity or 0)
    UIJump.__toOpenUIHeroTipsByHeroEntity(roleTipsData, isJumpAlbum, btnCloseCB, layout)
end

---@type fun(heroEntity: HeroEntity | nil, isJumpAlbum:boolean) 打开英雄提示界面
---@param roleTipsData RoleTipsData | nil
---@param isJumpAlbum boolean 是否要跳转到展示页
---@param layout UITempSmallHeroHeadLayout 可选项
---打开英雄提示界面
function UIJump.__toOpenUIHeroTipsByHeroEntity(roleTipsData, isJumpAlbum, btnCloseCB, layout)
    roleTipsData:ActiveJumpAlbum(isJumpAlbum)
    roleTipsData:WithCloseAction(btnCloseCB)

    UIManager.InterfaceOpenUI(UIName.UIRoleTips)
    Blackboard.UIEvent.SendMessage(UIName.UIRoleTips, UIEventID.UIRoleTips_Refresh, roleTipsData, layout)
end

------UIPropTips------------------------------------

function UIJump.ToOpenUIPropTips(propType)
    local uiName = UIName.UIPropTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIPropTips_Refresh, propType)
end

------UIHeroStarUp------------------------------------

---@type fun(heroGid:string) 打开英雄升星界面
---@param heroGid string 英雄gid
---打开英雄提示界面
function UIJump.ToOpenUIHeroStarUpByHeroGid(heroGid)
    local uiName = UIName.UIHeroStarUp
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIHeroStarUp_Refresh, heroGid)
end


------ UIAlbum ------------------------------------
---@type fun(element:number) 打开图鉴界面
function UIJump.ToOpenUIAlbum(element)
    local uiName = UIName.UIAlbum
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIAlbum_Refresh, element)
end

---@type fun(element:number) 打开图鉴属性界面
function UIJump.ToOpenUIAlbumIntimacyProp(element)
    local uiName = UIName.UIAlbumIntimacyProp
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIAlbumIntimacyProp_Refresh, element)
end

---@type fun(element:number) 打开图鉴亲密度界面
function UIJump.ToOpenUIAlbumIntimacyJump(element)
    local uiName = UIName.UIAlbumIntimacyJump
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIAlbumIntimacyJump_Refresh, element)
end

------角色详情------------------------------------
---@type fun(heroTag:number) 打开角色详情界面
function UIJump.ToOpenUIHeroDetails(heroTag)
    local uiName = UIName.UIHeroDetails
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIHeroDetails_Refresh, heroTag)
end



------UIHeroEmblem------------------------------------
---@type fun(heroGid:string) 打开纹章强化界面
function UIJump.ToOpenUIEmblemStrengthen(mainEmblemGid)
    if mainEmblemGid == nil or mainEmblemGid == "" then
        LuaCallCsUtilCommon.LogError("ToOpenUIEmblemStrengthen error ! param mainEmblemGid is nil")
        return
    end
    local uiName = UIName.UIEmblemStrengthen
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIEmblemStrengthen_Refresh, mainEmblemGid)
end


---@type fun(emblemGid:string) 打开纹章提示界面
---@param emblemGid string 纹章gid
---通过纹章Gid打开纹章提示界面
function UIJump.ToOpenUIEmblemTipsByEmblemGid(emblemGid)
    
    if emblemGid == nil or emblemGid == "" then
        LuaCallCsUtilCommon.LogError("ToOpenUIEmblemTips error ! param mainEmblemGid is nil")
        return
    end

    local uiName = UIName.UIEmblemTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIEmblemTips_RefreshEntityGid, emblemGid)
end

---@type fun(configTag:number) 打开纹章提示界面
---@param configTag number 纹章配置id
---通过纹章配置id打开纹章提示界面
function UIJump.ToOpenUIEmblemTipsByConfigTag(configTag)
    local uiName = UIName.UIEmblemTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIEmblemTips_RefreshConfigTag, configTag)
end

---@type fun(suitTag:number) 打开纹章套装提示界面
---@param suitTag number 纹章套装配置id
---通过纹章套装id打开纹章套装提示界面
function UIJump.ToOpenUIEmblemSuitTips(suitTag)
    local uiName = UIName.UIEmblemSuitTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIEmblemSuitTips_Refresh, suitTag)
end

---@type fun(suitTag:number,x:number,y:number) 打开装备套装提示界面
---@param suitTag number 装备套装配置id
---@param x number 位置x
---@param y number 位置y
---通过装备套装id打开装备套装提示界面
function UIJump.ToOpenUIEquipSuitTips(suitTag,x,y)
    local uiName = UIName.UIEquipSuitTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIEquipSuitTips_Refresh, suitTag,x,y)
end

---@type fun(uiEquipTipsData:UIEquipTipsData) 打开装备提示界面
---@param uiEquipTipsData UIEquipTipsData 纹章提示信息
function UIJump.ToOpenUIEquipTips(uiEquipTipsData)
    local uiName = UIName.UIEquipTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIEquipTips_Refresh, uiEquipTipsData)
end

---@type fun(equipTag:number) 打开装备提示界面 通过 装备id
---@param equipTag number 装备id
function UIJump.ToOpenUIEquipTipsByTag(equipTag)
    local equipTipsData = UIEquipTipsData()
    equipTipsData:WithEquipTag(equipTag)
    UIJump.ToOpenUIEquipTips(equipTipsData)
end

---@type fun(equipTag:number) 打开装备提示界面 通过 装备Gid
---@param equipTag number 装备id
---@param equipGid number 装备实体id
function UIJump.ToOpenUIEquipTipsByGid(equipTag, equipGid)
    local equipTipsData = UIEquipTipsData()
    equipTipsData:WithEquipTag(equipTag)
    equipTipsData:WithEquipGid(equipGid)
    UIJump.ToOpenUIEquipTips(equipTipsData)
end

------排行榜相关------------------------------------

---@type fun(rankData:table) 打开主UI排行榜
---@param rankData table 排行榜数据
function UIJump.ToOpenUIMonument(rankData)
    local uiName = UIName.UIMonument
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIMonument_Refresh, rankData)
end

---@type fun(rankData:table) 打开独立单UI排行榜
---@param rankData table 排行榜数据
function UIJump.ToOpenUIAloneRank(rankData)
    local uiName = UIName.UIAloneRank
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIAloneRank_Refresh, rankData)
end

---@type fun(rankData:table) 打开独立多UI排行榜
---@param rankData table 排行榜数据
function UIJump.ToOpenUIMultipleRank(rankData)
    local uiName = UIName.UIMultipleRank
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIMultipleRank_Refresh, rankData)
end

---@type fun(emblemGid:string) 打开升级突破提示界面
function UIJump.ToOpenUIHeroBreak(heroGid)
    local uiName = UIName.UIHeroBreak
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIHeroBreak_Refresh, heroGid)

    --local quick = UIManager.getUI("UIQuickLvTip", true)
    --if quick == nil then
    --   return
    --end
    --local heroEntity = HeroHelper.GetEntity(heroGid)
    --if heroEntity == nil then
    --    return
    --end
    --
    --local lvCosts = HeroHelper.GetHeroLvCostData(heroEntity.resid, heroEntity.level)
    --if lvCosts == nil then
    --    return
    --end
    --
    --local cost = {}
    --cost.res_id = {}
    --cost.res_num = {}
    --for i = 1, #lvCosts do
    --    local costData = lvCosts[i]
    --    cost.res_id[i] = costData:GetTag()
    --    cost.res_num[i] = costData:GetNum()
    --end
    --quick:refresh(heroEntity, nil, heroEntity.level + 1, cost)
end

---@type function(exchangeItemID, needNum, confirmAction, cancelAction) 打开兑换提示界面
---@param exchangeItemID number 被兑换的道具ID
---@param needNum number 需要被兑换的道具数量
---@param confirmAction function | nil 确定回调
---@param cancelAction function| nil 取消回调
function UIJump.ToOpenUIConfirmTipsExchange(exchangeItemID, needNum, confirmAction, cancelAction)
    local uiName = UIName.UIConfirmTipsExchange
    UIManager.getUI(uiName, true)

    local uiDataTips = UIManager.getUI(uiName, true) ---@type UIConfirmTipsExchange | nil
    if(uiDataTips ~= nil) then
        uiDataTips:init()
        uiDataTips:setExchangeData(exchangeItemID, needNum, confirmAction, cancelAction)
    end
end

------UISkillUnlock----------------------------------
---@type fun(skillTag:number, skillLv:number) 打开技能解锁界面
function UIJump.ToOpenUISkillUnlock( skillTag, skillLv )
    local uiName = UIName.UISkillUnlock
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UISkillUnlock_Refresh, skillTag, skillLv )
end

------UISkillTips------------------------------------

---@type fun(skillTipsData:SkillTipsData) 打开技能提示界面
function UIJump.ToOpenUISkillTips(skillTipsData)
    local uiName = UIName.UISkillTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UISkillTips_Refresh, skillTipsData)
end

---@type fun(skillTag:number, skillShowTypeEnum:SkillShowTypeEnum, skillLv:number, heroEntity:HeroEntity) 打开技能提示界面
---@param skillTag number 技能id
---@param skillShowTypeEnum SkillShowTypeEnum 技能展示类型
---@param skillLv number 技能等级
---@param heroEntity HeroEntity 英雄实体
---@return UISkillTipsPanel
---打开技能提示界面(通过英雄实体数据)
function UIJump.ToOpenUISkillTipsByHeroEntity(skillTag, skillShowTypeEnum, skillLv, heroEntity)
    local skillTipsData = SkillTipsData.AdapterHeroEntity(skillTag, skillShowTypeEnum, skillLv, heroEntity)
    UIJump.ToOpenUISkillTips(skillTipsData)
end

---@type fun(skillTag:number, skillShowTypeEnum:SkillShowTypeEnum, skillLv:number, heroTag) 打开技能提示界面
---@param skillTag number 技能id
---@param skillShowTypeEnum SkillShowTypeEnum 技能展示类型
---@param skillLv number 技能等级
---@param heroTag number 英雄id
---@return UISkillTipsPanel
---打开技能提示界面(通过英雄配置数据)
function UIJump.ToOpenUISkillTipsByHeroConfig(skillTag, skillShowTypeEnum, skillLv, heroTag)
    local skillTipsData = SkillTipsData.AdapterHeroConfig(skillTag, skillShowTypeEnum, skillLv, heroTag)
    UIJump.ToOpenUISkillTips(skillTipsData)
end

---@type fun(skillTag:number, skillShowTypeEnum:SkillShowTypeEnum, skillLv:number) 打开技能提示界面
---@param skillTag number 技能id
---@param skillShowTypeEnum SkillShowTypeEnum 技能展示类型
---@param skillLv number 技能等级
---@return UISkillTipsPanel
---打开技能提示界面(通过魂石技能数据)
function UIJump.ToOpenUISkillTipsBySoulStoneSkill(skillTag, skillShowTypeEnum, skillLv)
    local skillTipsData = SkillTipsData.AdapterSoulStoneSkill(skillTag, skillShowTypeEnum, skillLv)
    UIJump.ToOpenUISkillTips(skillTipsData)
end

---@type fun(skillTag:number, skillShowTypeEnum:SkillShowTypeEnum, skillLv:number, monsterTag) 打开技能提示界面
---@param skillTag number 技能id
---@param skillShowTypeEnum SkillShowTypeEnum 技能展示类型
---@param skillLv number 技能等级
---@param monsterTag number 怪物id
---@return UISkillTipsPanel
---打开技能提示界面(通过怪物配置数据)
function UIJump.ToOpenUISkillTipsByMonsterTag(skillTag, skillShowTypeEnum, skillLv, monsterTag)
    local skillTipsData = SkillTipsData.AdapterMonster(skillTag, skillShowTypeEnum, skillLv, monsterTag)
    UIJump.ToOpenUISkillTips(skillTipsData)
end

---@type fun() 打开剧情界面
function UIJump.ToOpenUIPlot()
    local uiName = UIName.UIPlot
    UIManager.getUI(uiName, true)
end



---@type fun() 通用物品提示框信息
---@param cfgId number 配置ID，必填
---@param count number 数量，可选项
function UIJump.ToOpenUIDataTips(cfgId, count)
    local uiName = UIName.UIDataTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIDataTips_Refresh, cfgId, count)
end

---@type fun() 物品提示框，增加购买功能
---@param cfgId number 配置ID，必填
---@param count number 数量，可选项
---@param tipsFuncParam UIDataTipsFuncParam 方法
---@param buyNum number 购买次数
---@param allLimit number 每日限购
---@param costID number 单次购买消耗ID
---@param costNum number 单次购买消耗数量
---@param rateNum number 折扣数
function UIJump.ToOpenUIDataTipsFuncBuy(cfgId, count, tipsFuncParam, buyNum, allLimit, costID, costNum, rateNum)
    local uiName = UIName.UIDataTipsFuncBuy
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIDataTips_Buy_Refresh, cfgId, count, tipsFuncParam, buyNum, allLimit, costID, costNum, rateNum)
end

---@type fun() 物品提示框，合成功能
---@param cfgId number 配置ID，必填
---@param count number 数量，可选项
function UIJump.ToOpenUIDataTipsFuncCombin(cfgId, count)
    local uiName = UIName.UIDataTipsFuncCombin
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIDataTips_Combin_Refresh, cfgId, count)
end

---@type fun() 物品提示框，使用功能
---@param cfgId number 配置ID，必填
---@param count number 数量，可选项
function UIJump.ToOpenUIDataTipsFuncUse(cfgId, count)
    local uiName = UIName.UIDataTipsFuncUse
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIDataTips_Use_Refresh, cfgId, count)
end

---@type fun() 打开使用功能
---@param cfgId number 配置ID，必填
---@param count number 数量，可选项
function UIJump.ToOpenUIItemUse(cfgId, count)
    local uiName = UIName.UIItemUse
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIItemUse_Refresh, cfgId, count)
end

---@type fun() 打开合成功能
---@param cfgId number 配置ID，必填
---@param count number 数量，可选项
function UIJump.ToOpenUIItemCompound(cfgId, count)
    local uiName = UIName.UIItemCompound
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIItemCompound_Refresh, cfgId, count)
end


------------------------品质筛选------------------------

---@type fun(selectAction:fun(multiSelector: MultiSelector)) 打开品质筛选弹窗
---@param selectAction fun(multiSelector: MultiSelector)
function UIJump.ToOpenUIQualitySelect(selectAction)
    UIJump.ToOpenUIQualitySelectByAllParam(selectAction, CommonQualityList)
end

---@type fun(selectAction:fun(multiSelector: MultiSelector), selectable: table, operateCache:number) 打开品质筛选弹窗
---@param selectAction fun(multiSelector: MultiSelector)
---@param selectable table 可供选择的品质
---@param operateCache number 上次筛选时的最大品质
function UIJump.ToOpenUIQualitySelectByAllParam(selectAction, selectable, operateCache)
    local uiName = UIName.UIQualitySelect
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIQualitySelect_Refresh, selectAction, selectable, operateCache)
end

------------------------利姆鲁Rimuru------------------------

---@type fun() 打开利姆鲁Rimuru界面
function UIJump.ToOpenUIRimuru()
    UIJump.ToOpenUIRimuruByMenuIndex(1)
end

---@type fun(menuIndex:UIRimuruMenuBarEnum) 打开利姆鲁Rimuru界面
---@param menuIndex UIRimuruMenuBarEnum | nil 英雄菜单枚举
function UIJump.ToOpenUIRimuruByMenuIndex(menuIndex)
    local uiName = UIName.UIRimuru
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuru_Refresh, menuIndex)
end

---@type fun(uabilityTag:number) 打开利姆鲁独有技能提示界面
---@param uabilityTag number 独有技能Tag
function UIJump.ToOpenUIRimuruUabilityTips(uabilityTag)
    local uiName = UIName.UIRimuruUabilityTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruUabilityTips_Refresh, uabilityTag)
end

---@type fun(resistTag:number) 打开利姆鲁独有技能提示界面
---@param resistTag number 独有技能Tag
function UIJump.ToOpenUIRimuruResistTips(resistTag)
    local uiName = UIName.UIRimuruResistTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruResistTips_Refresh, resistTag)
end

---@type fun(evolveTag:number) 打开利姆鲁技能升级界面
---@param evolveTag number 技能升级Tag
function UIJump.ToOpenUIRimuruUabilityEvolve(evolveTag)
    local uiName = UIName.UIRimuruUabilityEvolve
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruUabilityEvolve_Refresh, evolveTag)
end

function UIJump.ToOpenUIRimuruResistEvolve(resistTag)
    local uiName = UIName.UIRimuruResistEvolve
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruResistEvolve_Refresh, resistTag)
end

function UIJump.ToOpenUIRimuruCrystalList(treeTag, placeTag)
    local uiName = UIName.UIRimuruCrystalList
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruCrystalList_Refresh, treeTag, placeTag)
end

---@type fun(treeTag:number, placeTag:number) 打开利姆鲁纹石列表界面
function UIJump.ToOpenUIRimuruMarbleList(treeTag, placeTag)
    local uiName = UIName.UIRimuruMarbleList
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruMarbleList_Refresh, treeTag, placeTag)
end

---@type fun(stoneType:RimuruStoneType) 打开利姆鲁石头分解界面
function UIJump.ToOpenUIRimuruStoneBreakdown(stoneType)
    local uiName = UIName.UIRimuruStoneBreakdown
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruStoneBreakdown_Refresh, stoneType)
end

---@type fun(treeTag:number) 打开利姆鲁星盘属性提示界面
function UIJump.ToOpenUIRimuruStoneTreePropTips(treeTag)
    local uiName = UIName.UIRimuruStoneTreePropTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruStoneTreePropTips_Refresh, treeTag)
end

---@type fun(curEnableStoneTreeTag:number) 打开魔王星盘切换界面
---@param curEnableStoneTreeTag number 当前启用的星盘Tag
function UIJump.ToOpenUIRimuruStoneTreeSwitch(curEnableStoneTreeTag)
    local uiName = UIName.UIRimuruStoneTreeSwitch
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIRimuruStoneTreeSwitch_Refresh, curEnableStoneTreeTag)
end

------------------------ 召唤 ------------------------

--- 召唤
---@type fun() 打开召唤成功UI
function UIJump.ToOpenUIRecruit(_type)
    UIManager.InterfaceOpenUI(UIName.UIRecruit)
    Blackboard.UIEvent.SendMessage(UIName.UIRecruit, UIEventID.UIRecruit_Jump, _type)
end

---@type fun() 打开召唤成功UI
function UIJump.ToOpenUIRecruitWin(heroes, recruitID)
    UIManager.InterfaceOpenUI(UIName.UIRecruitWin)
    Blackboard.UIEvent.SendMessage(UIName.UIRecruitWin, UIEventID.UIRecruitWin_Refresh, heroes, recruitID)
end

---@type fun() 打开新人200抽 召唤成功UI
function UIJump.ToOpenUIRecruitNovice(recruitID)
    UIManager.InterfaceOpenUI(UIName.UIRecruitNovice)
    Blackboard.UIEvent.SendMessage(UIName.UIRecruitNovice, UIEventID.UIRecruitNovice_Refresh, recruitID)
end

---@type fun(heorID) 打开召唤成功UI
---@param heorID number 英雄配置ID
function UIJump.ToOpenUIHeroAcquireByHeroID(heorID, closeCallBackFunc)
    UIManager.InterfaceOpenUI(UIName.UIHeroAcquire)
    Blackboard.UIEvent.SendMessage(UIName.UIHeroAcquire, UIEventID.UIHeroAcquire_RefreshOrAddShow_ByID, heorID, closeCallBackFunc)
end

---@type fun() 打开召唤成功UI
---@param heroGid table<number> 英雄实体ID列表
function UIJump.ToOpenUIHeroAcquireByHeroGID(heroGid, closeCallBackFunc)
    UIManager.InterfaceOpenUI(UIName.UIHeroAcquire)
    Blackboard.UIEvent.SendMessage(UIName.UIHeroAcquire, UIEventID.UIHeroAcquire_RefreshOrAddShow_ByGID, heroGid, closeCallBackFunc)
end
--- 召唤

function UIJump.ToOpenUIMainTaskGetHero(itemList, calBackFunc)
    local uiName = UIName.UIMainTaskGetHero
    UIManager.InterfaceOpenUI(uiName)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIMainTaskGetHero_Refresh, itemList, calBackFunc)
end

--- 打开活动主UI
function UIJump.ToOpenUIActivity()
    local uiName = UIName.UIActivityPanel
    UIManager.InterfaceOpenUI(uiName)
end

--------------------------活动相关UI------------------------
---@function 根据活动ID打开活动
---@param activityID number 活动ID
function UIJump.ToOpenUIActivityByActivityID(activityID)
    local uiName = UIName.UIActivityPanel
    UIManager.InterfaceOpenUI(uiName)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIActivity_Jump, activityID)
end

---@function 打开启程好礼任务
function UIJump.ToOpenUISevenSign(_activityId)
    local uiName = UIName.UISevenSign
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UISevenSign_Open, _activityId)
end

---@function 打开多日签到活动UI
function UIJump.ToOpenUIHeroSign(_activityId)
    local uiName = UIName.UIHeroSign
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIHeroSign_Open, _activityId)
end

---@function 打开自己的玩家信息
function UIJump.ToOpenSelfPlayer()
    UIManager.InterfaceOpenUI(UIName.UIPlayerProfile)
    Blackboard.UIEvent.SendMessage(UIName.UIPlayerProfile, UIEventID.UIPlayerProfileReadSelf)
end

---@function 打开自己的玩家信息修改界面
function UIJump.ToOpenSelfPlayerModify()
    UIManager.InterfaceOpenUI(UIName.UIPlayerProfileModify)
end

---@function 打开其他玩家的玩家信息
---@param msg SC_PlayerProfile
function UIJump.ToOpenOtherPlayer(msg)
    UIManager.InterfaceOpenUI(UIName.UIPlayerProfile)
    Blackboard.UIEvent.SendMessage(UIName.UIPlayerProfile, UIEventID.UIPlayerProfileSetOther, msg)
end

---@function 举报其他玩家
---@param playerId string 玩家ID
---@param playerName string 玩家名字
function UIJump.ToOpenPlayerReport(playerId, playerName)
    UIManager.InterfaceOpenUI(UIName.UIPlayerReport)
    Blackboard.UIEvent.SendMessage(UIName.UIPlayerReport, UIEventID.UIPlayerReportSetData, playerId, playerName)
end

---@function 打开称号tips
---@param id
function UIJump.ToOpenTitleTips(id)
    UIManager.InterfaceOpenUI(UIName.UITitleTips)
    Blackboard.UIEvent.SendMessage(UIName.UITitleTips, UIEventID.UITitleTipsSetData, id)
end

---@function 打开称号tips
---@param modelList number[] 勋章组
---@param idx number 选中的索引
function UIJump.ToOpenMedalTips(modelList, idx)
    UIManager.InterfaceOpenUI(UIName.UIMedalTips)
    Blackboard.UIEvent.SendMessage(UIName.UIMedalTips, UIEventID.UIMedalTipsSetData, modelList, idx)
end

---@function 打开元素buff加成界面
function UIJump.ToOpenElementBuffInfo(buffId)
    UIManager.InterfaceOpenUI(UIName.UICampBuffInfo)
    Blackboard.UIEvent.SendMessage(UIName.UICampBuffInfo, UIEventID.UICampBuffInfo_SetData, buffId)
end

---@function 打开任务界面-每日
function UIJump.ToOpenActiveTaskEveryday()
    UIManager.InterfaceOpenUI(UIName.UIActiveTask)
end

---@function 打开任务界面-每周
function UIJump.ToOpenActiveTaskWeakly()
    UIManager.InterfaceOpenUI(UIName.UIActiveTask)
    Blackboard.UIEvent.SendMessage(UIName.UIActiveTask, UIEventID.UIActiveTaskSelectToggle, 1)
end

---@function 打开主界面
function UIJump.ToOpenMain()
    UIManager.InterfaceCloseAll()
    UIManager.InterfaceOpenUI(UIName.UIMain)
end


---@function 打开资源副本
function UIJump.ToOpenBossTower(towerType)
    local ui =  UIManager.getUI(UIName.UIWarpSpace, true)
    if ui then
        ui:into(towerType)
    end
end

function UIJump.ToOpenUIStageDungeonMain(type)
    local StageDungeonModel =   require("Game/UI/UIStageDungeon/Model/StageDungeonModel")
    local  model = StageDungeonModel
    model.current_type = type
    UIManager.getUI(UIName.UIStageDungeonMain, true)
end


function UIJump.ToOpenUITimeReward()
    UIManager.InterfaceCloseAll()
    UIManager.InterfaceShowUI(UIName.UIMain)
    UIManager.getUI(UIName.UITimeReward, true):setData()
end

------ 战力提示 ------
function UIJump.ToOpenUICapacityTips(curValue, nextValue)
    local uiName = UIName.UICapacityTips
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UICapacityTips_Refresh, curValue, nextValue)
end

--- 非付费商店
---@param mallID number 跳转的商店ID 可选项
function UIJump.ToOpenUIAcitivtyMall(mallID)
    local uiName = UIName.UIActivityMall
    UIManager.getUI(uiName, true)
    if mallID then
        Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIActivityMall_Jump, mallID)
    end
end

function UIJump.ToOpenBossTowerPassReward(bossType, layer)
    UIManager.InterfaceOpenUI(UIName.UIBossTowerPassReward)
    Blackboard.UIEvent.SendMessage(UIName.UIBossTowerPassReward, UIEventID.UIBossTowerPassRewardSetData, bossType, layer)
end

---@type fun() 通用提示弹窗
---@param confirmType number 提示框类型
function UIJump.ToOpenConfirmBoxShowType(confirmType, ...)
    local uiName = UIName.UIConfirmBox
    UIManager.InterfaceOpenUI(uiName)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIConfirmBox_ShowType, confirmType, ...)
end

---@type fun(confirmId:number) 通用提示弹窗
---@param confirmId string 提示配置表ID
function UIJump.ToOpenConfirmBoxWithId(confirmId, cbYes, cbNo, cbOther, costInfo, contentParams, str_)
    local uiName = UIName.UIConfirmBox
    UIManager.InterfaceOpenUI(uiName)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIConfirmBox_WishId, confirmId, cbYes, cbNo, cbOther, costInfo, contentParams, str_)
end

---@type fun(confirmId:number) 通用提示弹窗 直接传入显示信息
---@param infoStr string 提示框信息
function UIJump.ToOpenConfirmBoxShowInfoCallBack(infoStr, cbYes, cbNo, cbOther)
    local uiName = UIName.UIConfirmBox
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIConfirmBox_ShowInfoCallBack, infoStr, cbYes, cbNo, cbOther)
end

---@type fun(confirmId:number) 通用提示弹窗 直接传入显示信息
---@param infoStr string 提示框信息
function UIJump.ToOpenConfirmBoxShowInfo(infoStr)
    local uiName = UIName.UIConfirmBox
    UIManager.InterfaceOpenUI(uiName)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UIConfirmBox_ShowInfo, infoStr, cbYes, cbNo, cbOther)
end

---@type fun(info:string, confiremAction:fun()) 通用提示弹窗
---@param costs table 显示内容
---@param backCallFunc fun() 确认回调
function UIJump.ToOpenCostConfirmBox(costs, getShowStr, remaining, backCallFunc)
    local uiName = UIName.UICostConfirmBox
    UIManager.getUI(uiName, true)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UICostConfirmBox_Refresh, costs, getShowStr, remaining, backCallFunc)
end

---@type fun() 热门英雄
function UIJump.ToOpenHotHeroTips(recommendId)
    UIManager.InterfaceOpenUI(UIName.UIHotHeroTips)
    Blackboard.UIEvent.SendMessage(UIName.UIHotHeroTips, UIEventID.UIHotHeroTips_SetData, recommendId)
end

---@type fun() 模块描述信息
function UIJump.ToOpenInfoNotice(noticeId)
    UIManager.InterfaceOpenUI(UIName.UIInfoNoticeBox)
    Blackboard.UIEvent.SendMessage(UIName.UIInfoNoticeBox, UIEventID.InfoNoticeBoxSetData, noticeId)
end

---@type fun() 打开通用奖励提示框
---@param rewardList CommonRewardItemData[] 奖励列表
function UIJump.ToOpenUICommonReward(rewardList)
    UIManager.InterfaceOpenUI(UIName.UICommonReward)
    Blackboard.UIEvent.SendMessage(UIName.UICommonReward, UIEventID.UICommonReward_Refresh, rewardList)
end

---@type fun(type : number, ...) 打开通用奖励提示框
function UIJump.ToUICommonRewardAddType(type, ...)
    UIManager.InterfaceOpenUI(UIName.UICommonReward)
    Blackboard.UIEvent.SendMessage(UIName.UICommonReward, UIEventID.UICommonReward_AddType, type, ...)
end

---@type fun() 打开视频播放器
---@param videoPath string 视频资源索引
---@param timeInSeconds string 跳转到某一时间 秒
---@param endCallback string 结束回调
---@param speed number 速度
---@param isJump boolean 是否可跳转
---@param isClose boolean 是否可关闭
function UIJump.ToUIAvgVideoPlayer(videoPath, timeInSeconds, endCallback, speed, isJump, isClose)
    local ui = UIManager.getUI(UIName.avgVideoPlayer, true)
    Blackboard.UIEvent.SendMessage(UIName.avgVideoPlayer, UIEventID.avgVideoPlayer_Refresh, videoPath, timeInSeconds, endCallback, speed, isJump, isClose)
    return ui
end

---@type fun() 打开TimeLineUI
---@param timelinePath string 资源路径
---@param parentObj table 父级的Object
---@param endCallBack fun() 关闭的回调
function UIJump.ToOpenTimeLine(timelinePath, parentObj, endCallBack)
    UIManager.InterfaceOpenUI(UIName.UITimeLine)
    Blackboard.UIEvent.SendMessage(UIName.UITimeLine, UIEventID.UITimeLine_Show, timelinePath, parentObj, endCallBack)
end

---@type fun() 打开TimeLineUI
---@param timelineObj table timeline实体Obj
---@param isShowSkip nil | boolean 是否显示跳过, 如果为空，默认显示
function UIJump.ToOpenTimeLineRefreshObj(timelineObj, isShowSkip)
    UIManager.InterfaceOpenUI(UIName.UITimeLine)
    Blackboard.UIEvent.SendMessage(UIName.UITimeLine, UIEventID.UITimeLine_RefreshObj, timelineObj, isShowSkip)
end

---@type fun() 打开GM
---@param gmType number GM类型
function UIJump.ToOpenUIGMByType(gmType)
    UIManager.InterfaceOpenUI(UIName.UIGM)
    Blackboard.UIEvent.SendMessage(UIName.UIGM, UIEventID.UIGM_RefreshType, gmType)
end



------------------ 联盟相关 League ------------------
---@type fun() 打开联盟界面
function UIJump.ToOpenUILeague()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end

    local hasLeague = LeagueHelper.HasLeague()
    if hasLeague then
        UIJump.ToOpenUILeagueMain()
    else
        UIJump.ToOpenUILeagueList()
    end
end

---@type fun() 打开联盟列表界面
function UIJump.ToOpenUILeagueList()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueList)
end

---@type fun() 打开创建联盟界面
function UIJump.ToOpenUILeagueCreator()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueCreator)
end

---@type fun() 打开联盟主界面
function UIJump.ToOpenUILeagueMain()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueMain)
end

---@type fun(flag:number[]) 打开联盟自定义旗帜界面
function UIJump.ToOpenUILeagueCustomFlag(flag)
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueCustomFlag)
    Blackboard.UIEvent.SendMessage(UIName.UILeagueCustomFlag, UIEventID.UILeagueCustomFlag_Refresh, flag)
end

---@type fun() 打开联盟自定义名称界面
function UIJump.ToOpenUILeagueCustomName()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueCustomName)
end

---@type fun() 打开联盟公告修改界面
function UIJump.ToOpenUILeagueCustomNotice()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueCustomNotice)
end

---@type fun() 打开联盟等级界面
function UIJump.ToOpenUILeagueLevel()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueLevel)
end

---@type fun() 打开联盟日志界面
function UIJump.ToOpenUILeagueLog()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueLog)
end

---@type fun() 打开联盟成员界面
function UIJump.ToOpenUILeagueMember()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueMember)
end

---@type fun() 打开联盟商人界面
function UIJump.ToOpenUILeagueBusyMan()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueBusyMan)
end

---@type fun() 打开联盟Boss界面
function UIJump.ToOpenUILeagueBoss()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueBossMain)
    Util.LeagueBossReport.AutoOpenReport()
end

---@type fun() 打开联盟宝藏界面
function UIJump.ToOpenUILeagueTreasure()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueTreasure)
end

---@type fun() 打开联盟任务界面
function UIJump.ToOpenUILeagueTask()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueTask)
end

---@type fun() 打开联盟邀请界面
function UIJump.ToOpenUILeagueInvitation()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueInvitation)
end

---@type fun() 打开联盟自定义广播界面
function UIJump.ToOpenUILeagueCustomBroadcast()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueCustomBroadcast)
end

---@type fun() 打开联盟自定义邮件界面
function UIJump.ToOpenUILeagueCustomMail()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueCustomMail)
end

---@type fun() 打开联盟自定义宝藏规则界面
function UIJump.ToOpenUILeagueCustomTreasureRule()
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueCustomTreasureRule)
end

---@type fun() 打开联盟自定义职位界面
---@param leagueGid number 联盟实体ID
---@param member LeagueMemberEntity 联盟成员实体
function UIJump.ToOpenUILeagueCustomDuty(leagueGid, member)
    local isClose = LeagueHelper.IsCloseAndTips()
    if isClose then return end
    UIManager.InterfaceOpenUI(UIName.UILeagueCustomDuty)
    Blackboard.UIEvent.SendMessage(UIName.UILeagueCustomDuty, UIEventID.UILeagueCustomDuty_Refresh, leagueGid, member)
end

------------------------ 活动商店 ------------------------

---@type function() 打开活动商店等级预览界面
---@param activityId number 活动ID
function UIJump.ToOpenUIAcitivtyShopLv(activityId)
    UIManager.InterfaceOpenUI(UIName.UIActivityShopLv)
    Blackboard.UIEvent.SendMessage(UIName.UIActivityShopLv, UIEventID.UIActivityShopLv_Refresh, activityId)
end

---@type function() 打开活动商店成就界面
---@param activityId number 活动ID
function UIJump.ToOpenUIAcitivtyAchievement(activityId)
    UIManager.InterfaceOpenUI(UIName.UIAcitivtyAchievement)
    Blackboard.UIEvent.SendMessage(UIName.UIAcitivtyAchievement, UIEventID.UIAcitivtyAchievement_Refresh, activityId)
end

---@type function() 打开骰子活动游戏界面
---@param activityId number 活动ID
function UIJump.ToOpenUIDiceAdventureGame(activityId)
    UIManager.InterfaceOpenUI(UIName.UIDiceAdventureGame)
    Blackboard.UIEvent.SendMessage(UIName.UIDiceAdventureGame, UIEventID.UIDiceAdventureGame_Refresh, activityId)
end

---@type function() 打开骰子成就界面
---@param activityId number 活动ID
function UIJump.ToOpenUIDiceAchieve(activityId)
    UIManager.InterfaceOpenUI(UIName.UIDiceAchieve)
    Blackboard.UIEvent.SendMessage(UIName.UIDiceAchieve, UIEventID.UIDiceAchieve_Refresh, activityId)
end

---@type function() 打开骰子格子详情界面
---@param activityId number 活动ID
---@param gridIdx number 格子索引
function UIJump.ToOpenUIDiceGridDetails(activityId, gridIdx)
    UIManager.InterfaceOpenUI(UIName.UIDiceGridDetails)
    Blackboard.UIEvent.SendMessage(UIName.UIDiceGridDetails, UIEventID.UIDiceGridDetails_Refresh, activityId, gridIdx)
end

---@type function() 打开骰子自选界面
---@param activityId number 活动ID
function UIJump.ToOpenUIDiceSelect(activityId)
    UIManager.InterfaceOpenUI(UIName.UIDiceSelect)
    Blackboard.UIEvent.SendMessage(UIName.UIDiceSelect, UIEventID.UIDiceSelect_Refresh, activityId)
end

---@function 打开骰子事件界面
function UIJump.ToOpenUIDiceEvent(activityId, eventId)
    UIManager.InterfaceOpenUI(UIName.UIDiceEvent)
    Blackboard.UIEvent.SendMessage(UIName.UIDiceEvent, UIEventID.UIDiceEvent_Refresh, activityId, eventId)
end

---@function 打开七日签到活动UI
function UIJump.ToOpenUINoviceTaskPage(_activityId)
    local uiName = UIName.UINoviceTaskPage
    UIManager.InterfaceOpenUI(uiName)
    --Blackboard.UIEvent.SendMessage(uiName, UIEventID.UISevenSign_Open, _activityId)
end

---@function 打开七日签到活动UI
function UIJump.ToOpenUINoviceSummonAchievement(_activityId)
    local uiName = UIName.UINoviceSummonAchievement
    UIManager.InterfaceOpenUI(uiName)
    --Blackboard.UIEvent.SendMessage(uiName, UIEventID.UISevenSign_Open, _activityId)
end

---@type function() 打开付费商城
function UIJump.ToOpenUICashMall(shopId)
    -- shopId为空时，默认打开第一个店铺
    local uiName = UIName.UICashMall
    UIManager.InterfaceOpenUI(uiName)
    Blackboard.UIEvent.SendMessage(uiName, UIEventID.UICashMallSelectShop, shopId)
end

---@type function() 打开战令购买界面
function UIJump.ToOpenUIBattlePassBuy(shopId, rechargeId, unlockRewardId, buyRewardId)
    UIManager.InterfaceOpenUI(UIName.UIBattlePassBuy)
    Blackboard.UIEvent.SendMessage(UIName.UIBattlePassBuy, UIEventID.UIBattlePassBuy_Open, shopId, rechargeId, unlockRewardId, buyRewardId)
end

---@type function 打开军团训练 关卡界面
---@param firstClearance boolean 是否首通
function UIJump.ToEquipDungeonMain(type)
    UIManager.InterfaceOpenUI(UIName.UIEquipDungeonMain)
    Blackboard.UIEvent.SendMessage(UIName.UIEquipDungeonMain, UIEventID.UIEquipDungeonMainOpen,type)
end

---@type function 打开tu类型
---@param pushIds number[] 是否首通
function UIJump.ToOpenUIPushWindowByType(pushIds)
    UIManager.InterfaceOpenUI(UIName.UIPushWindow)
    Blackboard.UIEvent.SendMessage(UIName.UIPushWindow, UIEventID.UIPushWindow_OpenByType, pushIds)
end

---@type function 打开tu类型
---@param pushId number 是否首通
function UIJump.ToOpenUIPushWindowById(pushId)
    UIManager.InterfaceOpenUI(UIName.UIPushWindow)
    Blackboard.UIEvent.SendMessage(UIName.UIPushWindow, UIEventID.UIPushWindow_OpenByID, pushId)
end

---@type function() 打开月卡拍脸
function UIJump.ToOpenUIMonthlyCardPush()
    local uiName = UIName.UIMonthlyCardPush
    UIManager.InterfaceOpenUI(uiName)
end

---@type function() 打开首充拍脸
function UIJump.ToOpenUIFirstRechargePush()
    local uiName = UIName.UIFirstRechargePush
    UIManager.InterfaceOpenUI(uiName)
end
