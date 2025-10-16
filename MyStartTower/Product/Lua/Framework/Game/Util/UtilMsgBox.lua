


-- 飘字

local tab = {}

---@type function() 打开通用提示框
---@param text string 通用提示内容
function tab.OpenShowInfo(text)
    UIJump.ToOpenConfirmBoxShowInfo(text)
end

---@type function() 打开通用提示框并且添加回调事件
---@param text string 通用提示内容
---@param yesFun function 确定回调
---@param noFun function | nil 取消回调
---@param otherFun function | nil 其他回调
function tab.OpenShowInfoAndCallBack(text, yesFun, noFun, otherFun)
    UIJump.ToOpenConfirmBoxShowInfoCallBack(text, yesFun, noFun, otherFun)
end

---@type function() 打开通用提示框并且添加回调事件
---@param confirmID number 提示表ID ResClientConfirm表
---@param yesFun function 确定回调
---@param noFun function | nil 取消回调
---@param otherFun function | nil 其他回调
function tab.OpenShowByIDAndCallBack(confirmID, yesFun, noFun, otherFun)
    UIJump.ToOpenConfirmBoxWithId(confirmID, yesFun, noFun, otherFun)
end

---@type function() 打开通用提示框
---@param yesStr string 确认按钮名称
---@param noStr string 取消按钮名称
---@param otherStr string | nil 其他按钮名称（重新挑战） 非必填
function tab.SetBtnName(yesStr, noStr, otherStr)
    Blackboard.UIEvent.SendMessage(UIName.UIConfirmBox, UIEventID.UIConfirmBox_SetBtnName, yesStr, noStr, otherStr)
end

---@type function() 修改通用提示框按钮名称
---@param yesShow string 确认按钮名称
---@param noShow string 取消按钮名称
---@param otherShow string | nil 其他按钮名称（重新挑战） 非必填
function tab.SetBtnShow(yesShow, noShow, otherShow)
    Blackboard.UIEvent.SendMessage(UIName.UIConfirmBox, UIEventID.UIConfirmBox_SetBtnShow, yesShow, noShow, otherShow)
end

Util.MsgBox = tab
