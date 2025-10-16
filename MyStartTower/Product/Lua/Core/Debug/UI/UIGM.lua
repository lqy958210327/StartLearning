local GMBtn = require("Core/Debug/UI/GMBtn")
local UIGMBattle = require("Core/Debug/UI/UIGMBattle")
local UIGMDialog = require("Core/Debug/UI/UIGMDialog")
local UIGMDevelopment = require("Core/Debug/UI/UIGMDevelopment")
local UIGMGameplay = require("Core/Debug/UI/UIGMGameplay")
local UIGMProgrammingTool = require("Core/Debug/UI/UIGMProgrammingTool")
local UIGMSystem = require("Core/Debug/UI/UIGMSystem")

---@class UIGM : UIBaseWindow
local UIGM = Class("UIGM", UIControls.Window)

-- 构造函数。
function UIGM:ctor()
    self.curGMType = nil    ---@type number 当前显示的GM类型
    self.curGMUI = nil      ---@type table 当前显示的GMUI
    self.curGMData = {}     ---@type table<number, GMUIData>
    self.searchList = {}    ---@type table<number, GMUIData>
    
    self._gmBtnScr = LuaCallCs.UI.GetMoreRawScrollView(self:GetGameObject(), "gmBtnScr")
    LuaCallCs.UI.SetJButton(self:GetGameObject(), "closeBtn", function() self:setVisible(false) end)

    LuaCallCs.UI.SetJButton(self:GetGameObject(), "searchBtn", function() self:TouchSearch() end)
end

function UIGM:OnRegisterEvent()
    self:RegisterEventByID(UIEventID.UIGM_RefreshType, self.RefreshType)
end

function UIGM:RefreshType(gmType)
    if self.curGMType == gmType then
        self:setVisible(false)
        return
    end
    self.curGMType = gmType

    self.searchList = {}
    self:RefreshUI()
    self:ShowGMInfo()
end

function UIGM:TouchSearch()
    local searchStr = LuaCallCs.UI.UGUIInputFieldGetValue(self:GetGameObject(), "searchTxt")

    self.searchList = {}
    for i, data in ipairs(self.curGMData) do
        local isContains = Util.StringContains(searchStr, data.Name)
        if isContains then
            table.insert(self.searchList, data)
        end
    end
    if table.count(self.searchList) > 0 then
        self:ShowSearchGM()
    else
        self:ShowGMInfo()
    end
end

function UIGM:RefreshUI()
    ---@type GMDB
    local db = GameDB.GetDB(DBId.GM)

    if self.curGMType == GMEmun.Battle then
        self.curGMData = db:GetGMUIDataList(GMEmun.Battle)
        self.curGMUI = UIGMBattle()
        LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "gmTitleTxt", "F1战斗GM")
    elseif self.curGMType == GMEmun.GMDBDialog then
        self.curGMData = db:GetGMUIDataList(GMEmun.GMDBDialog)
        self.curGMUI = UIGMDialog()
        LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "gmTitleTxt", "F2剧情GM")
    elseif self.curGMType == GMEmun.GMDBGameplay then
        self.curGMData = db:GetGMUIDataList(GMEmun.GMDBGameplay)
        self.curGMUI = UIGMGameplay()
        LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "gmTitleTxt", "F3玩法GM")
    elseif self.curGMType == GMEmun.GMDBDevelopment then
        self.curGMData = db:GetGMUIDataList(GMEmun.GMDBDevelopment)
        self.curGMUI = UIGMDevelopment()
        LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "gmTitleTxt", "F4养成GM")
    elseif self.curGMType == GMEmun.GMDBSystem then
        self.curGMData = db:GetGMUIDataList(GMEmun.GMDBSystem)
        self.curGMUI = UIGMSystem()
        LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "gmTitleTxt", "F5系统GM")
    elseif self.curGMType == GMEmun.GMDBProgrammingTool then
        self.curGMData = db:GetGMUIDataList(GMEmun.GMDBProgrammingTool)
        self.curGMUI = UIGMProgrammingTool()
        LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "gmTitleTxt", "F6程序GM")
    else
        logerror("找不到GM类型！？？？  "..self.curGMType)
    end
    ---找不到数据时，直接把GM数据传给DB数据
    if not self.curGMData then
        self.curGMData = self.curGMUI:SetDBData()
    end
end

function UIGM:ShowGMInfo()
    LuaCallCs.UI.MoreRawScrollViewItemReloadCallback(self._gmBtnScr, function(scroll, obj, idx)
        idx = idx + 1
        ---@type GMInfo
        local data = self.curGMData[idx]
        ---@type GMBtn
        local debugBtn = GMBtn()
        debugBtn:init(obj)
        debugBtn:setting(data)
    end)
    LuaCallCs.UI.MoreRawScrollViewSetup(self._gmBtnScr, table.count(self.curGMData), 5)
end

function UIGM:ShowSearchGM()
    LuaCallCs.UI.MoreRawScrollViewItemReloadCallback(self._gmBtnScr, function(scroll, obj, idx)
        idx = idx + 1
        ---@type GMInfo
        local data = self.searchList[idx]
        ---@type GMBtn
        local debugBtn = GMBtn()
        debugBtn:init(obj)
        debugBtn:setting(data)
    end)
    LuaCallCs.UI.MoreRawScrollViewSetup(self._gmBtnScr, table.count(self.searchList), 5)
end

function UIGM:UILiftOnClose()
    self.curGMType = nil
end

return UIGM

