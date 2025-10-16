local ResInfoNotice = DataTable.ResInfoNotice
local InfoNoticeString = ConstTable.InfoNoticeString

---@class InfoNoticeBox:UIBaseWindow
local InfoNoticeBox = Class("InfoNoticeBox", UIControls.Window)

-- 构造函数。
function InfoNoticeBox:UILiftOnInit()
    self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
    self.textContent = UIControls.Label(self, "BgPanel/TextRule")
    self.panelScroll = UIControls.Panel(self, "BgPanel/ScrollView")
    self.textScroll = UIControls.Label(self, "BgPanel/ScrollView/Content/TextRule")
    self.closeBtn=UIControls.JButton(self,"Close")
    self.closeBtn:AddClickEvent( function() self:_onBtnCloseClick()  end )
end

function InfoNoticeBox:OnRegisterEvent()
    self:RegisterEventByID(UIEventID.InfoNoticeBoxSetData, self._setData)
end

function InfoNoticeBox:_onBtnCloseClick()
    UIManager.InterfaceCloseUI(UIName.UIInfoNoticeBox)
end

function InfoNoticeBox:_setData( noticeId )
    if ResInfoNotice[noticeId] then
        self:showNotice(ResInfoNotice[noticeId].title or InfoNoticeString.title, ResInfoNotice[noticeId].content or InfoNoticeString.content, ResInfoNotice[noticeId].isScroll)
    else
        self:setVisible(false)
    end
end



function InfoNoticeBox:showNotice( title, content, showScroll )
    if not self:getVisible() then
        self:setVisible(true)
    end
    self.textTitle:setText(title)
    if showScroll == 1 then
        self.textContent:setVisible(false)
        self.panelScroll:setVisible(true)
        self.textScroll:setText(content)
    else
        self.textContent:setVisible(true)
        self.panelScroll:setVisible(false)
        self.textContent:setText(content)
    end
end

return InfoNoticeBox
