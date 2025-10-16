local MsgReceiver = require("Core/System/MsgReceiver")

local UIConst = UIConst
local strClassName = "NoticeBox"


---@class NoticeBox : UIBaseWindow
local NoticeBox = Class(strClassName, UIControls.Window)

-- 构造函数。
function NoticeBox:UILiftOnInit()
    self:initUI()
    self.mMsgDatas = {}
end

function NoticeBox:destroy()
    self.receiver:destroy()
    NoticeBox.super.destroy(self)
end

function NoticeBox:initUI()
    self.core = self:getController():GetCom(UIConst.ControlTypeMsgMovePool, "Content1")
    self.TaskTipType1 = self:getController():GetCom(UIConst.ControlTypeMsgMovePool, "Content2")
    --self.TaskTipType2 = self:getController():GetCom(UIConst.ControlTypeMsgMovePool, "Content3")
    self.receiver = MsgReceiver({Const.CHANNEL_NOTICE,Const.CHANNEL_TASK})
    self.receiver.mEventReceive = Functor(self.onMsgReceive, self)
    -- self.receiver.mEventUpdate = Functor(self.onMsgUpdate, self)
end



function NoticeBox:showNotice(msgText, iconFilePath, iconSpriteName, sfxPath)
    if iconFilePath == nil then
        iconFilePath = ""
        iconSpriteName = ""
    end
    if sfxPath == nil then
        sfxPath = ""
    end
    -- self:autoSetCam()
    self.core:ShowMsg(msgText, iconFilePath, iconSpriteName, sfxPath)
    -- self:setVisible(true)
end

function NoticeBox:showTaskNotice(msgText, noticeType)
    local bgIcon={}
    local iconFilePath ="atlas_task_MoveMsg"
    local iconSpriteName =""
    local sfxPath =""
    if noticeType == 2 then--低级任务提示
        bgIcon ={"atlas_task_MoveMsg","map_unlocking19","map_unlocking17_1"}
        iconSpriteName ="map_unlocking15"
    elseif noticeType == 3 then--高级级任务提示
        bgIcon ={"atlas_task_MoveMsg","map_unlocking18","map_unlocking17"}
        iconSpriteName ="map_unlocking16"
    end
    self.TaskTipType1:ShowMsg(msgText, iconFilePath, iconSpriteName, sfxPath,bgIcon,self.ClickFun)
end

function NoticeBox:onMsgReceive(msgData,noticeType)
    if noticeType==2 or noticeType==3 then
        self:showTaskNotice(msgData.content,noticeType)
    else
        self:showNotice(msgData.content)
    end
end

function NoticeBox:onHide()
    self.BgNoticeImg:setVisible(false)
end
--点击打开对应UI界面
function NoticeBox:ClickFun()
    --print("asdsad")
end

function NoticeBox:ShowTips(text)
    self:showNotice(text)
end

function NoticeBox:OnRegisterEvent()
    self:RegisterEventByID(UIEventID.UINoticeBox_ShowTips, self.ShowTips)
end

return NoticeBox
