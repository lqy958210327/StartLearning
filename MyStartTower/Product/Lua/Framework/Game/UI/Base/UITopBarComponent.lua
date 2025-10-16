
local SimpleItem = require "Game/UI/commonmisc/UICommonSimpleItem"

---@class UITopBarComponent 顶部货币栏组件
UITopBarComponent = Class("UITopBarComponent")

---@param currencyList number[] 货币类型列表
function UITopBarComponent:Init(obj, currencyList)
    if obj and currencyList then
        self._root = obj
        self._simpleItemObjList = {}       ---@type UICommonSimpleItem[]

        self:UpdateCurrencyList(currencyList)
    end
end

---@param currencyList number[] 货币类型列表
function UITopBarComponent:UpdateCurrencyList(currencyList)
    if currencyList then
        for i = 1, 4 do
            local simpleItemObj = self._simpleItemObjList[i]
            if not simpleItemObj then
                simpleItemObj = SimpleItem()
                simpleItemObj:init(LuaCallCs.GetObject(self._root,"SLM_TopBar_Item"..i))
                self._simpleItemObjList[i] = simpleItemObj
            end
            local itemId = currencyList[i]
            if itemId then
                simpleItemObj:SetVisible(true)
                simpleItemObj:SetCurrencyID(itemId)
            else
                simpleItemObj:SetVisible(false)
            end
        end
        self:SetVisible(true)
    else
        self:SetVisible(false)
    end
end

-- 刷新货币值
function UITopBarComponent:UpdateCurrencyValue()
    for i, simpleItemObj in ipairs(self._simpleItemObjList) do
        simpleItemObj:UpdateCurrencyValue()
    end
end

---@param value boolean 设置显隐
function UITopBarComponent:SetVisible(value)
    LuaCallCs.GameObjectActive(self._root, value)
end