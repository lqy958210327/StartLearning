local ResClientConfirm = DataTable.ResClientConfirm
local ConfirmString = ConstTable.ConfirmString
local ResItem = DataTable.ResItem
--------------ConfirmCostPanel---------------------



local strClassName = "ConfirmBox"
---@class ConfirmBox:UIBaseWindow
local ConfirmBox = Class(strClassName, UIControls.Window)
ConfirmBox.mShowID = 0

local CONFIRM_MODE_ONE_BTN = 1
local CONFIRM_MODE_TWO_BTN = 2
local CONFIRM_MODE_THREE_BTN = 3
-- 构造函数。
function ConfirmBox:UILiftOnInit()
    self:initUI()
    self.updateTimer = Timer.New(Slot(self.onTimeHide, self), 1, -1)
    self.updataContentTimer = Timer.New(Slot(self.onContentTimeUpdate, self), 1, -1)
end

function ConfirmBox:initUI()
    self.textTitle = UIControls.Label(self, "Bg/TextTitle")
    self.textTimeContent = UIControls.Label(self, "Bg/ContentPanel/TextTime")
    self.textTimeContent:setVisible(false)

    LuaCallCs.UI.SetJButton(self:GetGameObject(), "BtnConfirm", function() self:onClickBtnConfirm() end)
    LuaCallCs.UI.SetJButton(self:GetGameObject(), "BtnDeny", function() self:onClickBtnDeny() end)
    LuaCallCs.UI.SetJButton(self:GetGameObject(), "BtnOtherFunc", function() self:onBtnOtherFuncClick() end)

    self:setCancelBtnColor(ConfirmString.noText)
    self:setSureBtnColor(ConfirmString.yesText)

    self.attentionSwitch = UIControls.Toggle(self,"Bg/AttentionSwitch","Label")
    self.attentionSwitch:addEventValueChanged(self.attentionSwitchClick)
end

function ConfirmBox:OnRegisterEvent()
    self:RegisterEventByID(UIEventID.UIConfirmBox_ShowInfo, self.showInfo)
    self:RegisterEventByID(UIEventID.UIConfirmBox_ShowInfoCallBack, self.showInfoCallBack)
    self:RegisterEventByID(UIEventID.UIConfirmBox_WishId, self.showWithId)
    self:RegisterEventByID(UIEventID.UIConfirmBox_ShowType, self.show)
    
    self:RegisterEventByID(UIEventID.UIConfirmBox_SetBtnName, self.RefreshBtnName)
    self:RegisterEventByID(UIEventID.UIConfirmBox_SetBtnShow, self.RefreshBtnShow)
end

function ConfirmBox:RefreshBtnName(yesStr, noStr, otherStr)
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "confirmText", yesStr)
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "denyText", noStr)
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "otherText", otherStr)
end

function ConfirmBox:RefreshBtnShow(yesShow, noShow, otherShow)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "BtnConfirm", yesShow)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "BtnDeny", noShow)
    LuaCallCs.SetGameObjectActive(self:GetGameObject(), "BtnOtherFunc", otherShow)
end

function ConfirmBox:setSureBtnColor(txt)
    -- self.btnConfirmBtn:setText('<color=#F1E5CE>'..txt..'</color>')
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "confirmText", txt)
end

function ConfirmBox:setCancelBtnColor(txt)
    -- self.btnDenyBtn:setText('<color=#F9C9C9>'..txt..'</color>')
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "denyText", txt)
end

function ConfirmBox:setOtherBtnColor(txt)
    -- self.btnOtherFuncBtn:setText('<color=#E7EFFF>'..txt..'</color>')
end

function ConfirmBox:attentionSwitchClick(sender,isOn)
    -- 触发点击音效
end

function ConfirmBox:onTimeHide()
    if self.dur == 0 then
        if self.timeOutFunc then
            self.timeOutFunc()
        end
        self:hide()
    end
    self:setSureBtnColor(string.format(ConfirmString.yesTextTime, self.dur))
    self.dur = self.dur - 1
end

function ConfirmBox:checkCostInfo(checkIndex)
    if self.costInfo and self.costInfo[checkIndex] then
        local failed_text = self.costInfo[checkIndex].failed_text
        local func = self.costInfo[checkIndex].func
        if func then
            local iconPath, icon, allNum, needNum = func()
            if needNum > allNum then
                return failed_text or ConfirmString.checkCostText
            end
        else
            local itemID = self.costInfo[checkIndex].item
            local needNum = self.costInfo[checkIndex].num or 1
            local itemData = ResItem[itemID] or {}
            local nowNum = ItemHelper.GetItemCount(itemID)
            if needNum > nowNum then
                return failed_text or string.format(ConfirmString.checkCostTextItem, (itemData.name or ""))
            end
        end
    end
end

function ConfirmBox:onClickBtnDeny(sender)
    --local costFadeback = self:checkCostInfo(2)
    --if costFadeback then
    --    MsgManager.notice(costFadeback)
    --    return
    --end
    self:hide()
    if self.noFunc ~= nil then
        self.noFunc()
    end
end

Const.CACHED_ATTENTION_RECORD_TABLE = {}
function ConfirmBox:onClickBtnConfirm(sender)
    local costFadeback = self:checkCostInfo(1)
    if costFadeback then
        MsgManager.notice(costFadeback)
        return
    end
    if self.confirmId and self:getToggleState() then
        Const.CACHED_ATTENTION_RECORD_TABLE[self.confirmId] = true
    end
    self:hide()
    if self.yesFunc ~= nil then
        self.yesFunc()
    end
end

function ConfirmBox:onBtnOtherFuncClick(sender)
    local costFadeback = self:checkCostInfo(3)
    if costFadeback then
        MsgManager.notice(costFadeback)
        return
    end
    self:hide()
    if self.otherFunc ~= nil then
        self.otherFunc()
    end
end

function ConfirmBox:show(confirmType, ...)
    self.costInfo = nil
    self.textTimeContent:setVisible(false)
    return self:_show(confirmType, ...)
end

function ConfirmBox:showInfo(infoStr)
    self:_show(UIConst.CONFIRM_ONEBTN, "提示", infoStr, nil, "确定")
end

function ConfirmBox:showInfoCallBack(infoStr, cbYes, cbNo)
    self:_show(UIConst.CONFIRM_TWOBTN, "提示", infoStr, cbYes, cbNo, -1, "确定", "取消")
end

function ConfirmBox:showWithId(confirmId, cbYes, cbNo, cbOther, costInfo, contentParams, str_)
    local confirmData = ResClientConfirm[confirmId]
    if confirmData then
        if costInfo and costInfo[3] and confirmData.other_failed_text then
            costInfo[3].failed_text = confirmData.other_failed_text
        end
        local content = confirmData.content
        if contentParams then
            content = string.format(content, unpack(contentParams))
        end


        self.costInfo = costInfo
        self.textTimeContent:setVisible(false)
        if confirmData.other_text then
            self:_show(UIConst.CONFIRM_THREEBTN, confirmData.title, content, { cbYes, cbNo,cbOther}, -1, {confirmData.confirm_text, confirmData.cancel_text, confirmData.other_text})
        elseif confirmData.cancel_text then
            self:_show(UIConst.CONFIRM_TWOBTN, confirmData.title, content, cbYes, cbNo, -1, confirmData.confirm_text, confirmData.cancel_text)
        else
            self:_show(UIConst.CONFIRM_ONEBTN, confirmData.title, content, cbYes, confirmData.confirm_text)
        end
        if confirmData.open_attention == 1 then
            self.confirmId = confirmId
            self:showToggle(nil, confirmData.default_attention == 1)
        end
    else
       logerror("ResClientConfirm 缺少弹窗信息 ID："..confirmId)
    end
end

function ConfirmBox:_show(confirmType, ...)
    self.confirmId = nil
    self.attentionSwitch:setVisible(false)
    self:setSureBtnColor(ConfirmString.yesText)
    self.updateTimer:Stop()
    --todo 需要做提示缓存
    if confirmType == UIConst.CONFIRM_ONEBTN then
        self.mode = CONFIRM_MODE_ONE_BTN
        self:_showOneBtn(...)
    elseif confirmType == UIConst.CONFIRM_TWOBTN then
        self.mode = CONFIRM_MODE_TWO_BTN
        self:_showTwoBtn(...)
    elseif confirmType == UIConst.CONFIRM_THREEBTN then
        self.mode = CONFIRM_MODE_THREE_BTN
        self:_showThreeBtn(...)
    else
        return
    end
    self:_showCostInfo()
    if not self:getVisible() then
        self:setVisible(true)
    end
    ConfirmBox.mShowID = ConfirmBox.mShowID + 1
    return ConfirmBox.mShowID
end

function ConfirmBox:hide(confirmID)
    if confirmID ~= nil and confirmID ~= ConfirmBox.mShowID then
        return
    end
    self.updateTimer:Stop()
    if self.updataContentTimer then
        self.yesFuncOnTimerFinish = nil
        self.updataContentTimer:Stop()
    end    
    self:setVisible(false)
end

function ConfirmBox:hideAll()
    self:hide()
end

function ConfirmBox:_showOneBtn(title, content, yesFunc, yesText, txtAlign)
    self.textTitle:setText(title)
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "TextContent", content)

    self.yesFunc = yesFunc
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnConfirm", true)
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnDeny", false)
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnOtherFunc", false)

    self:setSureBtnColor(yesText or ConfirmString.yesText)
end

function ConfirmBox:_showTwoBtn(title, content, yesFunc, noFunc, dur, yesText, noText, timeOutFunc, txtAlign)
    self.textTitle:setText(title)
    -- self.textContent:setText(content)
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "TextContent", content)
    -- if txtAlign == nil then
    --     txtAlign = UIConst.TXTALIGN_UC
    -- end
    -- if txtAlign then
    --     self.textContent:setAlign(txtAlign)
    -- end
    self.yesFunc = yesFunc
    self.noFunc = noFunc
    -- self.btnConfirm:setVisible(true)
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnConfirm", true)
    -- self.btnDeny:setVisible(true)
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnDeny", true)
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnOtherFunc", false)

    self:setSureBtnColor(yesText or ConfirmString.yesText)

    -- self.btnDenyBtn:setEnable(true)
    self:setCancelBtnColor(noText or ConfirmString.noText)

    self.timeOutFunc = timeOutFunc
    if dur ~= nil and dur > 0 then 
        self.dur = dur
        self.updateTimer:Restart()
    end
end

function ConfirmBox:_showThreeBtn(title, content, funcs, dur, texts, timeOutFunc, txtAlign)
    self.textTitle:setText(title)
    -- self.textContent:setText(content)
    LuaCallCs.UI.UGUISetTextMeshPro(self:GetGameObject(), "TextContent", content)
    -- if txtAlign == nil then
    --     txtAlign = UIConst.TXTALIGN_UC
    -- end
    -- if txtAlign then
    --     self.textContent:setAlign(txtAlign)
    -- end
    self.yesFunc = funcs[1]
    self.noFunc = funcs[2]
    self.otherFunc = funcs[3]
    local yesText = texts[1]
    local noText = texts[2]
    local otherText = texts[3]
    -- self.btnConfirm:setVisible(true)
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnConfirm", true)
    -- self.btnDeny:setVisible(true)
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnDeny", true)
    LuaCallCsUtilCommon.SetGameObjectActive(self:GetGameObject(), "BtnOtherFunc", true)

    self:setSureBtnColor(yesText or ConfirmString.yesText)

    self:setCancelBtnColor(noText or ConfirmString.noText)

    self:setOtherBtnColor(otherText or ConfirmString.otherText)

    self.timeOutFunc = timeOutFunc
    if dur ~= nil and dur > 0 then 
        self.dur = dur
        self.updateTimer:Restart()
    end

end

function ConfirmBox:_showCostInfo()
    -- self:_setCostPanel(self.costPanels[1], self.costInfo, 1)
    -- if self.mode == CONFIRM_MODE_ONE_BTN then
    --     self.costPanels[2]:setVisible(false)
    --     self.costPanels[3]:setVisible(false)
    -- else
    --     self:_setCostPanel(self.costPanels[2], self.costInfo, 2)
    --     if self.mode == CONFIRM_MODE_TWO_BTN then
    --         self.costPanels[3]:setVisible(false)
    --     else
    --         self:_setCostPanel(self.costPanels[3], self.costInfo, 3)
    --     end
    -- end
end

function ConfirmBox:_setCostPanel(costPanel, costInfo, order)
    if costInfo and costInfo[order] then
        local costData = costInfo[order]
        if costData.func then
            costPanel:setByfunc(costData.func)
        else
            costPanel:setItem(costData.item, costData.num or 1)
        end
    else
        costPanel:setVisible(false)
    end
end

function ConfirmBox:showToggle( content,chooseState )
    chooseState = chooseState or false
    self.attentionSwitch:setVisible(true)
    if content ~= nil then
        self.attentionSwitch:setText(content)
    end
    self.attentionSwitch:setOnVoidUnChange(chooseState)
end

function ConfirmBox:getToggleState( ... )
    return self.attentionSwitch:isOn()
end

function ConfirmBox:startContentTimer(preText, nextText, timeLast, cbOnClickSure)
    self.contentTimePre = preText or ""
    self.contentTimeNext = nextText or ""
    self.updateTime = timeLast
    if cbOnClickSure then
        self.yesFuncOnTimerFinish = cbOnClickSure
    end
    if self.updataContentTimer then
        self.textTimeContent:setVisible(true)
        self.updataContentTimer:Restart()
    end
    self:onContentTimeUpdate()
end



function ConfirmBox:onContentTimeUpdate()
    if not self.updateTime then
        self.updataContentTimer:Stop()
        return
    end

    local timeLast = self.updateTime - TimeUtils.getServerTime()

    if timeLast < 0 then
        self.yesFunc = self.yesFuncOnTimerFinish and self.yesFuncOnTimerFinish or self.yesFunc
        self.updataContentTimer:Stop()
        return
    end

    local timeText
    --if timeLast - 3600*24 > 1 then
    --    timeText = math.floor(timeLast/(3600*24)).."天"
    --    self.updataContentTimer:Stop()
    --else
        timeText = TimeUtils.calcTimeTxt(timeLast)
    --end
    local str = self.contentTimePre..timeText..self.contentTimeNext
    self.textTimeContent:setText(str)
end

function ConfirmBox:tryCloseCanvas()
    if self.mode == CONFIRM_MODE_ONE_BTN then
        self:onClickBtnConfirm(self.btnConfirmBtn)
        return true
    elseif self.mode == CONFIRM_MODE_TWO_BTN and not self.noFunc then
        self:onClickBtnDeny(self.btnDenyBtn)
        return true
    end
    return false
end

function ConfirmBox:onClose(  )
    if self.updataContentTimer then
        self.yesFuncOnTimerFinish = nil
        self.updataContentTimer:Stop()
    end
    if self.updateTimer then
        self.updateTimer:Stop()
    end
    self.textTimeContent:setVisible(false)
end

return ConfirmBox
