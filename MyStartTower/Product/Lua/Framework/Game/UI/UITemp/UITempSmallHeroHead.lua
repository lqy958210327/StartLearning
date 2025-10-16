

local __analyseDetailParam = function(id, star, lv, lvState, moduleId)
    local cfg = HeroHelper.GetHeroConfig(id)
    if star == nil then star = cfg.ori_star end
    if lv == nil then lv = 1 end
    if lvState == nil then lvState = CorridorEnum.None end
    local modelCfg = DataTable.ResCommonModel[cfg.model]
    local rarity = cfg.rarity_id
    local rarityCfg = CommonHelper.GetRarityConfig(rarity)
    local param = UITempSmallHeroHeadDetailParam()
    param.ConfigID = id
    param.ModuleId = moduleId
    param.Icon = modelCfg.head_code
    param.Rarity = rarity
    param.RarityAtlas = rarityCfg.rarity_head_sign_path
    param.RaritySprite = rarityCfg.rarity_head_sign
    param.IsMaking = cfg.making == 0
    param.LV = lv
    param.Star = star
    param.LVState = lvState
    param.ElementIconAtlas, param.ElementIcon = ElementHelper.GetElementMiniIcon(cfg.elem, false)
    param.CareerAtlas, param.Career = HeroHelper.GetCareerMiniIcon(cfg.career, false)
    return param
end

---@class UITempSmallHeroHead
UITempSmallHeroHead = Class("UITempSmallHeroHead")
function UITempSmallHeroHead:_setData(obj, param, layout,func,isOpenTips)
    self._obj = obj ---@type GameObject
    self._param = param ---@type UITempSmallHeroHeadDetailParam
    self._layout = layout and layout or UITempSmallHeroHeadLayout(false) ---@type UITempSmallHeroHeadLayout
    self._isOpenTips = isOpenTips == nil and  true or false

    LuaCallCs.SetGameObjectActive(self._obj, "img_Select", false)
    LuaCallCs.UI.UGUISetRawImage(self._obj, "raw_Icon", self._param.Icon, self._param.ModuleId)
    LuaCallCs.UI.UGUISetImageSync(self._obj, "img_Rarity", self._param.RarityAtlas, self._param.RaritySprite)
    LuaCallCs.UI.UGUISetImageSync(self._obj, "img_Element", self._param.ElementIconAtlas, self._param.ElementIcon)
    LuaCallCs.UI.UGUISetImageSync(self._obj, "img_Career", self._param.CareerAtlas, self._param.Career)
    LuaCallCs.SetGameObjectActive(self._obj, "fx_Rarity_3", self._param.Rarity == 3)
    LuaCallCs.SetGameObjectActive(self._obj, "fx_Rarity_4", self._param.Rarity == 4)
    LuaCallCs.SetGameObjectActive(self._obj, "fx_Rarity_5", self._param.Rarity == 5)
    LuaCallCs.SetGameObjectActive(self._obj, "img_Making", self._param.IsMaking)
    local isShowLv = self._layout.IsShowLv
    LuaCallCs.SetGameObjectActive(self._obj, "txt_Lv", isShowLv)
    if isShowLv then
        local lvColor = "ffffff"    --OC老逻辑，共鸣颜色(self._param.LVState == CorridorEnum.Resonance) and "78FA37" or "ffffff"
        LuaCallCs.UI.UGUISetTextMeshProAndHex(self._obj, "txt_Lv", tostring(self._param.LV), lvColor)
    end
    LuaCallCs.UI.SetJButton(self._obj, "JButton",function() 
        if func  then
            func()
        end
        if self._isOpenTips then
            self:_onClickBtnItem() 
        end
    end)
    self:_setStar(self._param.Star)
end

function UITempSmallHeroHead:WithGid(gid)
    self._param.Gid = gid
    return self;
end

function UITempSmallHeroHead:_setStar(star)
    local result = Util.CalculateHeroStarSprite(star)
    for i = 1, 5 do
        local data = result[i]
        local path = "img_star_"..i
        LuaCallCs.UI.UGUISetImageSync(self._obj, path, data[1], data[2])
    end
end

function UITempSmallHeroHead:_selectHead(value)
    LuaCallCs.SetGameObjectActive(self._obj, "img_Select", value)
end

function UITempSmallHeroHead:WithClickAction(clickAction)
    self._clickAction = clickAction
    return self;
end

function UITempSmallHeroHead:_onClickBtnItem()
    --if self._clickAction then
    --    self._clickAction()
    --    return
    --end
    -- print("---   点击UITempSmallHeroHead   id = "..self._param.ConfigID)

    --local layout = UITempSmallHeroHeadLayout()
    --layout.IsShowLv = true
    --UIJump.ToOpenUIHeroTipsByHeroTag(self._param.ConfigID, nil, nil, layout)
    local tag = self._param.ConfigID
    local level = self._param.LV
    local star = self._param.Star
    local gid = self._param.Gid
    local entity = HeroHelper.GetEntity(gid)
    local capacity = entity and entity.capacity or 0
    local isJumpAlbum = false
    local btnCloseCB = nil
    local layout = UITempSmallHeroHeadLayout()
    layout.IsShowLv = true
    UIJump.ToOpenUIHeroTipsByCustom(tag, level, star, capacity, isJumpAlbum, btnCloseCB, layout)
    --UIJump.ToOpenUIHeroTipsByHeroEntity()
end



-----------------------外部可见的接口和结构体--------------------------

---@class UITempSmallHeroHeadDetailParam
UITempSmallHeroHeadDetailParam = Class("UITempSmallHeroHeadDetailParam")
function UITempSmallHeroHeadDetailParam:ctor()
    self.Gid = nil -- 实体唯一ID
    self.ConfigID = nil -- 配置id
    self.Icon = nil -- 头像
    self.Rarity = nil -- 稀有度
    self.RarityAtlas = nil -- 稀有度图集
    self.RaritySprite = nil -- 稀有度图
    self.Star = nil -- 星级
    self.ElementIconAtlas = nil
    self.ElementIcon = nil -- 元素图标
    self.CareerAtlas = nil
    self.Career = nil -- 职业
    self.LV = nil -- 等级
    self.LVState = nil -- 等级状态(是否共鸣)
    self.IsMaking = true -- 是否制作中
    self.ModuleId = nil -- 模块ID
end

---@class UITempSmallHeroHeadLayout
UITempSmallHeroHeadLayout = Class("UITempSmallHeroHeadLayout")
function UITempSmallHeroHeadLayout:ctor(isShowLv)
    self.IsShowLv = isShowLv -- 是否显示等级
end

local tab = {}

---@param obj GameObject
---@param heroCfgId number 英雄配置ID，必填
---@param moduleId number 模块ID，如果不填，无法精准卸载RawImage资源
---@param star number 星级，可选项(默认是英雄配置)
---@param lv number 等级，可选项(默认1级)
---@param lvState CorridorEnum 等级状态，可选项(默认未共鸣)
---@param layout UITempSmallHeroHeadLayout 可选项
---@return UITempSmallHeroHead
function tab.SetDataByHeroID(obj, heroCfgId, moduleId, star, lv, lvState, layout , func, isOpenTips)
    local param = __analyseDetailParam(heroCfgId, star, lv, lvState, moduleId)
    local temp = UITempSmallHeroHead()
    temp:_setData(obj, param, layout,func,isOpenTips)
    return temp
end

---@param obj GameObject
---@param entity HeroEntity 英雄实体，必填
---@param moduleId number 模块ID，如果不填，无法精准卸载RawImage资源
---@param layout UITempSmallHeroHeadLayout 可选项
function tab.SetDataByHeroEntity(obj, entity, moduleId, layout)
    local lv, lvState = HeroHelper.GetHeroLevel(entity)
    local param = __analyseDetailParam(entity.resid, entity.star, lv, lvState, moduleId)
    local temp = UITempSmallHeroHead()
    temp:_setData(obj, param, layout)
    return temp
end


---@param obj GameObject
---@param param UITempSmallHeroHeadDetailParam
---@param layout UITempSmallHeroHeadLayout
function tab.SetDataByDetail(obj, param, layout)
    -- 理解成本高，不建议业务侧用
    local temp = UITempSmallHeroHead()
    temp:_setData(obj, param, layout)
    return temp
end

---@param head UITempSmallHeroHead
---@param isSelect boolean 是否选中
function tab.SelectCard(head, isSelect)
    if head then
        head:_selectHead(isSelect)
    end
end

---@param head UITempSmallHeroHead
function tab.SetRedDot(head)
    print("---   还没对接红点系统的接口...")
end

UITemp.SmallHeroHead = tab