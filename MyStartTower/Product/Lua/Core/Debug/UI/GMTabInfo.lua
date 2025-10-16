local GMInfoList = {
    {GMTitle = "战斗GM", GMTip = "F1打开战斗GM界面", GMUIType = GMEmun.Battle},
    {GMTitle = "剧情GM", GMTip = "F2打开剧情GM界面", GMUIType = GMEmun.GMDBDialog},
    {GMTitle = "玩法GM", GMTip = "F3打开玩法GM界面", GMUIType = GMEmun.GMDBGameplay},
    {GMTitle = "养成GM", GMTip = "F4打开养成GM界面", GMUIType = GMEmun.GMDBDevelopment},
    {GMTitle = "系统GM", GMTip = "F5打开系统GM界面", GMUIType = GMEmun.GMDBSystem},
    {GMTitle = "程序工具", GMTip = "F6打开程序工具GM界面", GMUIType = GMEmun.GMDBProgrammingTool},
}

---@class GMInfo
local GMInfo = Class("GMInfo")

---@type fun()
---@param _gmTitle string 按钮名称
---@param _gmTip string 提示信息
---@param _gmUIType number UI类型  GMEmun
function GMInfo:init(_gmTitle, _gmTip, _gmUIType)
    self.GMTitle = _gmTitle
    self.GMTip = _gmTip
    self.GMUIType = _gmUIType
end

---@class GMTabInfo : UIBaseWindow
local GMTabInfo = Class("GMTabInfo", UIControls.Window)

-- 构造函数。
function GMTabInfo:UILiftOnInit()
    self.debugInfoList = {} ---@type table<number, GMInfo>
    self:refreshData()
    self._gmBtnScr = LuaCallCs.UI.GetMoreRawScrollView(self:GetGameObject(), "gmBtnScr")
    self:ShowGMInfo()
end

function GMTabInfo:refreshData()
    self.goTipStr = ""
    for i, gmData in ipairs(GMInfoList) do
        ---@type GMInfo
        local gmInfo = GMInfo()
        gmInfo:init(gmData.GMTitle, gmData.GMTip, gmData.GMUIType)
        table.insert(self.debugInfoList, gmInfo)

        if i <= 1 then
            self.goTipStr = gmData.GMTip
        else
            self.goTipStr = self.goTipStr.."\n"..gmData.GMTip
        end
    end
end

function GMTabInfo:UILiftOnOpen()
    
end

function GMTabInfo:ShowGMInfo()
    LuaCallCs.UI.MoreRawScrollViewItemReloadCallback(self._gmBtnScr, function(scroll, obj, idx)
        idx = idx + 1
        ---@type GMInfo
        local data = self.debugInfoList[idx]
        LuaCallCs.UI.UGUISetTextMeshPro(obj, "gmText", data.GMTitle)
        LuaCallCs.UI.SetJButton(obj, "BtnToggle", function()
            UIJump.ToOpenUIGMByType(data.GMUIType)
            self:setVisible(false)
        end)
    end)
    LuaCallCs.UI.MoreRawScrollViewSetup(self._gmBtnScr, table.count(self.debugInfoList), 1)
    
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "gmInfoTxt", self.goTipStr)
end

function GMTabInfo:UILiftOnClose()
    
end

return GMTabInfo

