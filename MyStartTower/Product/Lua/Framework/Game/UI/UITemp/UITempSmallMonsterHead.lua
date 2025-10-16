

local __analyseDetailParam = function(id,  battleId,moduleId)
    local cfg = MonsterHelper.GetMonsterConfig(id)
    local modelCfg = DataTable.ResCommonModel[cfg.model]
    local rarity = cfg.rarity_id
    local rarityCfg = CommonHelper.GetRarityConfig(rarity)
    local param = UITempSmallMonsterHeadDetailParam()
    param.ConfigID = id
    param.ModuleId = moduleId
    param.BattleID = battleId
    param.Icon = modelCfg.head_code
    param.IsBoss = MonsterHelper.IsBoss(id)
    param.IsElite = MonsterHelper.IsElite(id)
    param.Rarity = rarity
    param.RarityAtlas = rarityCfg.rarity_head_sign_path
    param.RaritySprite = rarityCfg.rarity_head_sign
    param.LV = MonsterHelper.GetMonsterLv(id, battleId)
    param.ElementIconAtlas, param.ElementIcon = ElementHelper.GetElementMiniIcon(cfg.elem, false)
    param.CareerAtlas, param.Career = HeroHelper.GetCareerMiniIcon(cfg.career, false)
    param.IsMaking = cfg.making == 1
    return param
end

---@class UITempSmallMonsterHead
UITempSmallMonsterHead = Class("UITempSmallMonsterHead")
function UITempSmallMonsterHead:_setData(obj, param, layout)
    self._obj = obj ---@type GameObject
    self._param = param ---@type UITempSmallMonsterHeadDetailParam
    self._layout = layout and layout or UITempSmallMonsterHeadLayout(false) ---@type UITempSmallMonsterHeadLayout

    LuaCallCs.SetGameObjectActive(self._obj, "img_Select", false)
    LuaCallCs.UI.UGUISetRawImage(self._obj, "raw_Icon", self._param.Icon, self._param.ModuleId)
    LuaCallCs.UI.UGUISetImageSync(self._obj, "img_Rarity", self._param.RarityAtlas, self._param.RaritySprite)
    LuaCallCs.UI.UGUISetImageSync(self._obj, "img_Element", self._param.ElementIconAtlas, self._param.ElementIcon)
    LuaCallCs.UI.UGUISetImageSync(self._obj, "img_Career", self._param.CareerAtlas, self._param.Career)
    LuaCallCs.SetGameObjectActive(self._obj, "img_IsBoss", self._param.IsBoss)
    LuaCallCs.SetGameObjectActive(self._obj, "img_IsElite", self._param.IsElite)
    LuaCallCs.SetGameObjectActive(self._obj, "fx_Rarity_3", self._param.Rarity == 3)
    LuaCallCs.SetGameObjectActive(self._obj, "fx_Rarity_4", self._param.Rarity == 4)
    LuaCallCs.SetGameObjectActive(self._obj, "fx_Rarity_5", self._param.Rarity == 5)
    LuaCallCs.SetGameObjectActive(self._obj, "img_Making", self._param.IsMaking)
    local isShowLv = self._layout.IsShowLv
    LuaCallCs.SetGameObjectActive(self._obj, "txt_Lv", isShowLv)
    if isShowLv then
        LuaCallCs.UI.UGUISetTextMeshPro(self._obj, "txt_Lv", tostring(self._param.LV))
    end
    LuaCallCs.UI.SetJButton(self._obj, "JButton",function() self:_onClickBtnItem() end)
end

function UITempSmallMonsterHead:_selectHead(value)
    LuaCallCs.SetGameObjectActive(self._obj, "img_Select", value)
end
function UITempSmallMonsterHead:_onClickBtnItem()
    --print("---   点击UITempSmallMonsterHead   id = "..self._param.ConfigID)
    UIJump.ToOpenUIRoleTipsByMonsterTag(self._param.ConfigID, self._param.BattleID)
end







-----------------------外部可见的接口和结构体--------------------------

---@class UITempSmallMonsterHeadDetailParam
UITempSmallMonsterHeadDetailParam = Class("UITempSmallMonsterHeadDetailParam")
function UITempSmallMonsterHeadDetailParam:ctor()
    self.ConfigID = nil -- 配置id
    self.Icon = nil -- 头像
    self.Rarity = nil -- 稀有度
    self.RarityAtlas = nil -- 稀有度图集
    self.RaritySprite = nil -- 稀有度图
    self.ElementIconAtlas = nil
    self.ElementIcon = nil -- 元素图标
    self.CareerAtlas = nil
    self.Career = nil -- 职业
    self.LV = nil -- 等级
    self.IsBoss = nil -- 是否是Boss
    self.IsElite = nil -- 是否是精英
    self.ModuleId = nil -- 模块ID
    self.BattleID = nil -- 战场id
    self.IsMaking = true -- 是否制作中
end

---@class UITempSmallMonsterHeadLayout
UITempSmallMonsterHeadLayout = Class("UITempSmallMonsterHeadLayout")
function UITempSmallMonsterHeadLayout:ctor(isShowLv)
    self.IsShowLv = isShowLv -- 是否显示等级
end

local tab = {}

---@param obj GameObject
---@param monsterCfgId number 怪配置ID，必填
---@param battleId number 战场ID，必填
---@param moduleId number 模块ID，如果不填，无法精准卸载RawImage资源
---@param layout UITempSmallMonsterHeadLayout 可选项
---@return UITempSmallHeroHead
function tab.SetDataByMonsterID(obj, monsterCfgId, battleId, moduleId, layout)
    local param = __analyseDetailParam(monsterCfgId, battleId, moduleId)
    local temp = UITempSmallMonsterHead()
    temp:_setData(obj, param, layout)
    return temp
end

---@param obj GameObject
---@param param UITempSmallMonsterHeadDetailParam
---@param layout UITempSmallMonsterHeadLayout
function tab.SetDataByDetail(obj, param, layout)
    -- 理解成本高，不建议业务侧用
    local temp = UITempSmallMonsterHead()
    temp:_setData(obj, param, layout)
    return temp
end

---@param head UITempSmallMonsterHead
---@param isSelect boolean 是否选中
function tab.SelectCard(head, isSelect)
    if head then
        head:_selectHead(isSelect)
    end
end

---@param head UITempSmallMonsterHead
function tab.SetRedDot(head)
    print("---   还没对接红点系统的接口...")
end

UITemp.SmallMonsterHead = tab