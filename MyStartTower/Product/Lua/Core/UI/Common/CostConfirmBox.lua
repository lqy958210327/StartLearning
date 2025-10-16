---@class CostItem
local CostItem = Class("CostItem")

function CostItem:init(obj)
    self._root = obj
end

---@type fun(itemID:number, itemNum:number)
---@param itemID number 道具ID
---@param itemNum number 道具数量
---@return boolean isCostEnough 是否足够
function CostItem:ShowItmeData(itemID, itemNum)
    LuaCallCs.GameObjectActive(self._root, true)

    local itemData = ItemHelper.GetItemConfig(itemID)
    LuaCallCs.UI.UGUISetImage(self._root, "img_Cost", itemData.sourceIconPath, itemData.sourceIcon)

    local myItemNum = ItemHelper.GetItemCount(itemID)
    local isCostEnough = myItemNum >= itemNum
    local txtColor = isCostEnough and UIColor.BLACK or UIColor.RED
    LuaCallCs.UI.UGUISetTextMeshProAndHex(self._root, "txt_Cost", CommonHelper.formatCurrency(itemNum), txtColor.hex)
    return isCostEnough
end

---@class CostConfirmBox : UIBaseWindow
local CostConfirmBox = Class("CostConfirmBox", UIControls.Window)

-- 构造函数
function CostConfirmBox:UILiftOnInit()
    self._root = self:GetGameObject()

    LuaCallCs.UI.SetJButton(self._root, "btn_close", function() self:onClickBtnDeny() end)
    LuaCallCs.UI.SetJButton(self._root, "BtnDeny", function() self:onClickBtnDeny() end)
    LuaCallCs.UI.SetJButton(self._root, "BtnConfirm", function() self:onClickBtnConfirm() end)
end

function CostConfirmBox:OnRegisterEvent()
    self:RegisterEventByID(UIEventID.UICostConfirmBox_Refresh, self.RefreshView)
end

---@type fun(costs:table<number, SepatatorItemData>, getShowStr:string, remaining:number, backCallFunc:fun())
---@param costs table<number, SepatatorItemData> 消耗数据 必填项
---@param getShowStr string 获得提示 必填项
---@param remaining number 剩余次数提示 可选项
---@param backCallFunc fun() 确认回调 必填项
function CostConfirmBox:RefreshView(costs, getShowStr, remaining, backCallFunc)
    self.sureBackCallFunc = backCallFunc

    LuaCallCs.UI.UGUISetTextMeshPro(self._root, "TextContent", getShowStr)
    if remaining then
        LuaCallCs.UI.UGUISetTextMeshPro(self._root, "TextRemaining", remaining)
        LuaCallCs.SetGameObjectActive(self._root, "TextRemaining", true)
    else
        LuaCallCs.SetGameObjectActive(self._root, "TextRemaining", false)
    end

    self.isCostEnough = true
    for i, costData in ipairs(costs) do
        local _obj = LuaCallCs.GetObject(self._root, "item_CostTwo"..i)
        ---@type CostItem
        local costItme = CostItem()
        costItme:init(_obj)
        self.isCostEnough = self.isCostEnough and costItme:ShowItmeData(costData.itemID, costData.itemNum) 
    end
end

function CostConfirmBox:onClickBtnDeny()
    self:setVisible(false)
end

function CostConfirmBox:onClickBtnConfirm()
    if self.isCostEnough then
        if self.sureBackCallFunc then
            self.sureBackCallFunc()
        end
    else
        MsgManager.clientNotice(1023)
    end
    self:setVisible(false)
end

function CostConfirmBox:OnLeft()
end

return CostConfirmBox
