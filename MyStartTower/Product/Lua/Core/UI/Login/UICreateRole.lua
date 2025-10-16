--local UIMiscConfig = ConstTable.UIMiscConfig
local ResNameData = DataTable.ResNameData
local CreateRoleString = ConstTable.CreateRoleString
--local strClassName = "CreateRoleDlg"
---@class UICreateRole : UIBaseWindow
local UICreateRole = Class("UICreateRole", UIControls.Window)

function UICreateRole:UILiftOnInit()
    LuaCallCs.UI.SetJButton(self:GetGameObject(), "BtnRandom", function(p1, p2) self:_onClickBtnRandomName() end)
    LuaCallCs.UI.SetJButton(self:GetGameObject(), "BtnStart", function(p1, p2) self:_onClickBtnStart() end)
end

function UICreateRole:OnRegisterEvent()
    self.slot4Refresh = Slot(self._setData,self)
    EventCenter.addEventListener(EventConst.CDC_PLAYERINFO, self.slot4Refresh)
end

function UICreateRole:_setData(relicsList)
    EventManager.Global.Dispatch(EventType.PlotEndBename)
    self:setVisible(false)
end

function UICreateRole:UILiftOnOpen()
    self:_onClickBtnRandomName()
end

function UICreateRole:_setName(value)
    LuaCallCs.UI.UGUIInputFieldSetValue(self:GetGameObject(), "InputUserName", value)
end

function UICreateRole:_onClickBtnStart()
    --if self.clickCd then return end
    local name =  LuaCallCs.UI.UGUIInputFieldGetValue(self:GetGameObject(), "InputUserName")
    -- print('click change name=====================')
    -- 昵称 SDK校验
    local isPass = Analytics.reviewNicknameV2(name)
    if not isPass then
        self:_setName("")
        return
    end

    -- local failMsg = utils.FilterName(name)
    local msg = ClientUtils.checkPlayerName(name)
    if msg ~= "" then
        Util.Notice.Show(msg)
        self:_setName("")
        return
    end
    -- if   not utils.CheckName(name) or string.find(failMsg,"*") then
    --     MsgManager.notice("名字包含非法字符请重新输入！")
    --     self:setRandomName("")
    --     return
    -- end

    --self:setRandomName(name)
    --self.eff:playEffect()
    --if self.changeNameFunc then
    --    self.changeNameFunc()
    --end
    SendHandlers.ReqPlayerInfo(name, MsgOptModifyPlayerInfo.ChangeName)
    -- SendHandlers.ReqPlayerInfo(self.selectedHeadId.."",4)
    -- SendHandlers.ReqPlayerInfo(self.selectedGender.."",3)
    -- self.headId
    -- CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_CREATE_CHAR)
    -- CurAvatar:sendRoleInfo(name, self.selectedGender, self.selectedHeadId)
end

function UICreateRole:_onClickBtnRandomName()
    --男
    if self.selectedGender == Const.GENDER_MAN then
        --local tb1 = {}
        --local tb2 = {}
        --local tb3 = {}
        --for k, v in pairs(ResNameData) do
        --    if v.type == 1 then
        --        table.insert(tb1,v)
        --    elseif v.type == 3 or v.type == 4 then
        --        table.insert(tb2,v)
        --    elseif v.type == 5 or v.type == 6 then
        --        table.insert(tb3,v)
        --    end
        --end
        --
        --local t1 = 0
        --if #tb1 >= 1 then
        --    t1 = math.random(#tb1)
        --end
        --local t2 = 0
        --if #tb2 >= 1 then
        --    t2 = math.random(#tb2)
        --end
        --local t3 = 0
        --if #tb3 >= 1 then
        --    t3 = math.random(#tb3)
        --end
        --
        --local strName = ""
        --if tb1[t1] and tb1[t1].name then
        --    strName = strName..tb1[t1].name
        --end
        --if tb2[t2] and tb2[t2].name then
        --    strName = strName..tb2[t2].name
        --end
        --if tb3[t3] and tb3[t3].name then
        --    strName = strName..tb3[t3].name
        --end
        --if strName ~= "" then
        --    self:setRandomName(strName)
        --else
        --    MsgManager.notice("没有可随机的名字")
        --end
    elseif self.selectedGender == Const.GENDER_WOMAN  then  --女
        --local tb1 = {}
        --local tb2 = {}
        --local tb3 = {}
        --for k, v in pairs(ResNameData) do
        --    if v.type == 2 then
        --        table.insert(tb1,v)
        --    elseif v.type == 3 or v.type == 4 then
        --        table.insert(tb2,v)
        --    elseif v.type == 7 or v.type == 8 then
        --        table.insert(tb3,v)
        --    end
        --end
        --
        --local t1 = 0
        --if #tb1 >= 1 then
        --    t1 = math.random(#tb1)
        --end
        --local t2 = 0
        --if #tb2 >= 1 then
        --    t2 = math.random(#tb2)
        --end
        --local t3 = 0
        --if #tb3 >= 1 then
        --    t3 = math.random(#tb3)
        --end
        --
        --local strName = ""
        --if tb1[t1] and tb1[t1].name then
        --    strName = strName..tb1[t1].name
        --end
        --if tb2[t2] and tb2[t2].name then
        --    strName = strName..tb2[t2].name
        --end
        --if tb3[t3] and tb3[t3].name then
        --    strName = strName..tb3[t3].name
        --end
        --if strName ~= "" then
        --    self:setRandomName(strName)
        --else
        --    MsgManager.notice("没有可随机的名字")
        --end
    else
        local tb1 = {}
        local tb2 = {}
        local tb3 = {}
        for k, v in pairs(ResNameData) do
            if v.type == 1 then
                table.insert(tb1,v)
            elseif v.type == 3 or v.type == 4 then
                table.insert(tb2,v)
            elseif v.type == 5 or v.type == 6 then
                table.insert(tb3,v)
            end
        end

        local t1 = 0
        if #tb1 >= 1 then
            t1 = math.random(#tb1)
        end
        local t2 = 0
        if #tb2 >= 1 then
            t2 = math.random(#tb2)
        end
        local t3 = 0
        if #tb3 >= 1 then
            t3 = math.random(#tb3)
        end

        local strName = ""
        if tb1[t1] and tb1[t1].name then
            strName = strName..tb1[t1].name
        end
        if tb2[t2] and tb2[t2].name then
            strName = strName..tb2[t2].name
        end
        if tb3[t3] and tb3[t3].name then
            strName = strName..tb3[t3].name
        end
        if strName ~= "" then
            self:_setName(strName)
        else
            MsgManager.notice("没有可随机的名字")
        end

    end

end





return UICreateRole