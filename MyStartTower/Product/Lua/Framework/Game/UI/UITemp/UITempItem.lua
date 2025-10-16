

local _idx = 1
---@type table<number,UITempItem>
local tempMap = {}

---@return UITempItem
local __spawnTemp = function()
    local temp = UITempItem()
    temp:_init(_idx)
    tempMap[_idx] = temp
    _idx = _idx + 1
    return temp
end

---@return UITempItem
local __getTemp = function(id)
    local temp = tempMap[id]
    return temp
end

local __analyseQualityIcon = function(quality)
    local cfg = DataTable.ResItemQualityData[quality]
    return cfg.QualityPath, cfg.QualityImg, cfg.BasePath, cfg.BaseImg
end

local __analyseItemTypeDetailParam = function(id, count, moduleId)
    local _Icon = nil -- 头像
    local _BgIconAtlas = nil --
    local _BgIcon = nil -- 背景图标
    local _QualityIconAtlas = nil -- 品质图标图集
    local _QualityIcon = nil -- 品质图标
    local _Quality = nil -- 品质级别
    -- 特殊道具专属
    local _EquipSuitIconAtlas = nil -- 套装图标图集
    local _EquipSuitIcon = nil -- 套装图标
    local _CareerIconAtlas = nil -- 职业图标图集
    local _CareerIcon = nil -- 职业图标
    local _existCount = true

    local cfg = DataTable.ResItem[id]
    if cfg then
        _Icon = ItemHelper.GetItemRawImageIcon(id)
        _Quality = cfg.quality
        _QualityIconAtlas, _QualityIcon, _BgIconAtlas, _BgIcon =  __analyseQualityIcon(cfg.quality)
        _existCount = true
    end

    if cfg == nil and DataTable.ResEquipData[id] then
        cfg = DataTable.ResEquipData[id]
        _Icon = DataTable.ResEquipDefine[cfg.level][cfg.position].iconPath
        _Quality = cfg.big_quality
        _QualityIconAtlas, _QualityIcon, _BgIconAtlas, _BgIcon =  __analyseQualityIcon(cfg.big_quality)
        _CareerIconAtlas, _CareerIcon = HeroHelper.GetCareerMiniIcon(cfg.career, false)
        _existCount = false
    end

    if cfg == nil and DataTable.ResEmblem[id] then
        cfg = DataTable.ResEmblem[id]
        _Icon = EmblemHelper.GetEmblemIcon(id)
        _Quality = cfg.big_quality
        _QualityIconAtlas, _QualityIcon, _BgIconAtlas, _BgIcon =  __analyseQualityIcon(cfg.big_quality)
        _existCount = false
    end

    if cfg == nil and RimuruHelper.GetStoneConfig(id) then
        cfg = RimuruHelper.GetStoneConfig(id)
        _Icon = cfg.icon
        _QualityIconAtlas, _QualityIcon, _BgIconAtlas, _BgIcon =  __analyseQualityIcon(cfg.quality)
        _existCount = false
    end

    if cfg == nil then
        -- 注意：道具只支持四个表(Item, 装备模板, 魂石，文章, 利姆鲁符石)，其他的表都不支持，如果需要其他类型，把其他类型包装成道具展示
        LuaCallCs.ThrowException("---   设置UITempItem失败：所有表里(道具，装备，文章，魂石)都找不到配置，cfgId = "..id)
    end

    local param = UITempItemDetailParam()
    param.ModuleId = moduleId
    param.Id = id
    param.Count = count
    param.Icon = _Icon
    param.Quality = _Quality
    param.BgIconAtlas = _BgIconAtlas
    param.BgIcon = _BgIcon
    param.QualityIconAtlas = _QualityIconAtlas
    param.QualityIcon = _QualityIcon
    param.EquipSuitIconAtlas = _EquipSuitIconAtlas
    param.EquipSuitIcon = _EquipSuitIcon
    param.CareerIconAtlas = _CareerIconAtlas
    param.CareerIcon = _CareerIcon
    param.ExistCount = _existCount
    return param
end

local __analyseDetailParam = function(id, count, moduleId)
    moduleId = moduleId or UIModuleID.Default
    count = count or 0
    local param
    if DataTable.ResHero[id] then
        param = UITempItemDetailParam()
        param.IsHero = true
        param.Id = id
        param.ModuleId = moduleId
        param.Count = ""
    else
        param = __analyseItemTypeDetailParam(id, count, moduleId)
    end
    return param
end

---@class UITempItem
UITempItem = Class("UITempItem")
function UITempItem:_init(id)
    self._id = id
end
function UITempItem:_bindObj(obj)
    self._obj = obj ---@type GameObject
end
function UITempItem:_setData(param, layout,isShowTips, func )
    self._param = param ---@type UITempItemDetailParam
    self._layout = layout and layout or UITempItemLayout(false) ---@type UITempItemLayout

    self._itemObj = LuaCallCs.GetObject(self._obj, "type_item")
    self._heroObj = LuaCallCs.GetObject(self._obj, "type_hero")


    LuaCallCs.GameObjectActive(self._itemObj, not self._param.IsHero)
    LuaCallCs.GameObjectActive(self._heroObj, self._param.IsHero)

    if self._param.IsHero then
        UITemp.SmallHeroHead.SetDataByHeroID(self._heroObj, self._param.Id, self._param.ModuleId)
    else
        LuaCallCs.UI.UGUISetRawImage(self._itemObj, "item_img_Icon", self._param.Icon, self._param.ModuleId)
        LuaCallCs.UI.UGUISetImageSync(self._itemObj, "item_img_Quality", self._param.QualityIconAtlas, self._param.QualityIcon)

        LuaCallCs.SetGameObjectActive(self._itemObj, "item_img_Base", self._param.BgIcon ~= nil)
        if self._param.BgIcon ~= nil then
            LuaCallCs.UI.UGUISetImageSync(self._itemObj, "item_img_Base", self._param.BgIconAtlas, self._param.BgIcon)
        end

        LuaCallCs.SetGameObjectActive(self._itemObj, "item_img_EquipMetier", self._param.CareerIcon ~= nil)
        if self._param.CareerIcon ~= nil then
            LuaCallCs.UI.UGUISetImageSync(self._itemObj, "item_img_EquipMetier", self._param.CareerIconAtlas, self._param.CareerIcon)
        end

        LuaCallCs.SetGameObjectActive(self._itemObj, "item_img_EquipSuit", self._param.EquipSuitIcon ~= nil)
        if self._param.EquipSuitIcon ~= nil then
            LuaCallCs.UI.UGUISetImageSync(self._itemObj, "item_img_EquipSuit", self._param.EquipSuitIconAtlas, self._param.EquipSuitIcon)
        end

        local isShowCount = self._param.ExistCount and self._layout.IsShowCount
        LuaCallCs.SetGameObjectActive(self._itemObj, "item_txt_Count", isShowCount)
        if isShowCount then
            LuaCallCs.UI.UGUISetTextMeshPro(self._itemObj, "item_txt_Count", Util.NumFormat.ShortNum(self._param.Count))
        end

        ---品质显示特效
        if self._param.Quality then
            LuaCallCs.SetGameObjectActive(self._itemObj, "eff_Quality_0"..self._param.Quality, true)
        end

        LuaCallCs.UI.SetJButton(self._itemObj, "btn_item",function() 
            if isShowTips == nil or isShowTips == true then
                self:_onClickBtnItem()  
            end
            if func ~= nil then
                func()
            end 
        end)
    end

    self:_setTagHaveGet(false)
    self:_setCanGet(false)
end

function UITempItem:_setTagHaveGet(value)
    LuaCallCs.SetGameObjectActive(self._obj, "img_Get", value)
end

function UITempItem:_setCanGet(value)
    LuaCallCs.SetGameObjectActive(self._obj, "obj_canget", value)
end
function UITempItem:_onClickBtnItem()
    print("---   点击UITempItem   id = "..self._param.Id)

    if self._layout.CustomClickEvt then
        self._layout.CustomClickEvt(self._param.Id)
    else
        DataTipsHelper.ToOpenDataTipsByCfgID(self._param.Id, self._param.Count)
    end
end

-----------------------外部可见的接口和结构体--------------------------

---@class UITempItemDetailParam
UITempItemDetailParam = Class("UITempItemDetailParam")
function UITempItemDetailParam:ctor()
    self.IsHero = false -- 是否是英雄
    self.Id = nil -- 配置ID
    self.Icon = nil -- 头像
    self.Quality = nil -- 品质
    self.BgIconAtlas = nil --
    self.BgIcon = nil -- 背景图标
    self.QualityIconAtlas = nil -- 品质图标图集
    self.QualityIcon = nil -- 品质图标
    self.Count = nil -- 等级
    self.ExistCount = true -- 是否存在数量(道具本身不存在数量这个属性，那么即使设置了数量也不显示)
    self.ModuleId = nil -- 模块ID

    -- 特殊道具专属
    self.EquipSuitIconAtlas = nil -- 套装图标图集
    self.EquipSuitIcon = nil -- 套装图标
    self.CareerIconAtlas = nil -- 职业图标图集
    self.CareerIcon = nil -- 职业图标
end

---@class UITempItemLayout
UITempItemLayout = Class("UITempItemLayout")
function UITempItemLayout:ctor(isShowCount, clickEvt)
    self.IsShowCount = isShowCount -- 是否显示数量
    self.CustomClickEvt = clickEvt
end


local tab = {}

-- 特别注意：！！！
-- 通用物品组件分为两个样式：物品、英雄，不要在划分更多样式了，如果样式过多，那这就不是通用物品组件，不能按照通用物品组件的设计思路来实现。

---@param obj GameObject
---@param cfgId number 配置ID，必填
---@param moduleId number 模块ID，如果不填，无法精准卸载RawImage资源
---@param count number 数量，可选项
---@param layout UITempItemLayout 可选项
---@return number
function tab.SetDataByID(obj, cfgId, moduleId, count, layout,isShowTips,func)
    local param = __analyseDetailParam(cfgId, count, moduleId)
    local temp = __spawnTemp()
    temp:_bindObj(obj)
    temp:_setData(param, layout,isShowTips,func)
    return temp._id
end

---@return number
function tab.SpawnTemp(obj)
    local temp = __spawnTemp()
    temp:_bindObj(obj)
    return temp._id
end

---@param id number
function tab.TempSetData(id, cfgId, moduleId, count, layout)
    local temp = __getTemp(id)
    if temp then
        local param = __analyseDetailParam(cfgId, count, moduleId)
        temp:_setData(param, layout)
    end
end

---@param id number
---@param value boolean 这个道具是否以获得
function tab.HaveGet(id, value)
    local item = __getTemp(id)
    if item then
        item:_setTagHaveGet(value)
    end
end

function tab.CanGet(id,value)
    local item=__getTemp(id)
    if item then
        item:_setCanGet(value)
    end
end

---@param id number
function tab.TempSetActive(id, value)
    local temp = __getTemp(id)
    if temp then
        LuaCallCs.GameObjectActive(temp._obj, value)
    end
end


UITemp.Item = tab