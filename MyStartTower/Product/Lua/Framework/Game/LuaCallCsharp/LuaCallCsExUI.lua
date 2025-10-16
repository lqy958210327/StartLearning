


local table = {}




--JButton
function table.SetJButton(obj, path, evt, p1, p2)
    return CS_LuaCallCs.SetJButton(obj, path, evt, p1, p2)
end
function table.JButtonOnToggle(btn, value)
    CS_LuaCallCs.JButtonOnToggle(btn, value)
end
function table.JButtonInvokeClickEvent(btn)
    CS_LuaCallCs.JButtonInvokeClickEvent(btn)
end
function table.JButtonOnDisable(btn, isDisable)
    CS_LuaCallCs.JButtonOnDisable(btn, isDisable)
end
function table.JButtonBreakHold(btn)
    CS_LuaCallCs.JButtonBreakHold(btn)
end
function table.GetJButton(obj, path)
    return CS_LuaCallCs.GetJButton(obj, path)
end
--JButton


--UIToggleGroup
function table.UIToggleGroupWithClickAction(obj, path, evt)
    return CS_LuaCallCs.UIToggleGroupWithClickAction(obj, path, evt)
end
function table.UIToggleGroupSetUpdate(toggle, index, force)
    CS_LuaCallCs.UIToggleGroupSetUpdate(toggle, index, force)
end
function table.UIToggleGroupResetToggle(toggle)
    CS_LuaCallCs.UIToggleGroupResetToggle(toggle)
end
function table.UIToggleGroupSetClick(toggle, index, force)
    CS_LuaCallCs.UIToggleGroupSetClick(toggle, index, force)
end
function table.UIToggleGroupCurrentIndex(toggle)
    return CS_LuaCallCs.UIToggleGroupCurrentIndex(toggle)
end
function table.UIToggleGroupRefreshJButton(toggleGroup)
    return CS_LuaCallCs.UIToggleGroupRefreshJButton(toggleGroup)
end
--UIToggleGroup

--JSwitchButton变身按钮
function table.GetJSwitchButton(obj, path)
    return CS_LuaCallCs.GetJSwitchButton(obj, path)
end
function table.JSwitchButtonAddClickEvent(btn, evt)
    CS_LuaCallCs.JSwitchButtonAddClickEvent(btn, evt)
end
function table.JSwitchButtonSetSwitchFinishCallback(btn, evt)
    CS_LuaCallCs.JSwitchButtonSetSwitchFinishCallback(btn, evt)
end
function table.JSwitchButtonSwitchNext(btn)
    CS_LuaCallCs.JSwitchButtonSwitchNext(btn)
end
function table.JSwitchButtonForceSwitch(btn, idx)
    CS_LuaCallCs.JSwitchButtonForceSwitch(btn, idx)
end
function table.JSwitchButtonActiveTemplate(btn, idx, value)
    CS_LuaCallCs.JSwitchButtonActiveTemplate(btn, idx, value)
end
function table.JSwitchButtonInvokeClickEvent(btn)
    CS_LuaCallCs.JSwitchButtonInvokeClickEvent(btn)
end
function table.JSwitchButtonClearCache(btn)
    CS_LuaCallCs.JSwitchButtonClearCache(btn)
end
--JSwitchButton变身按钮

--MoreRawScrollView
function table.GetMoreRawScrollView(obj, path)
    return CS_LuaCallCs.GetMoreRawScrollView(obj, path)
end
function table.MoreRawScrollViewSetup(scrollView, total, raws)
    CS_LuaCallCs.MoreRawScrollViewSetup(scrollView, total, raws)
end
function table.MoreRawScrollViewItemReloadCallback(scrollView, func)
    CS_LuaCallCs.MoreRawScrollViewItemReloadCallback(scrollView, func)
end
function table.MoreRawScrollViewRefreshCurrentList(scrollView, isForce)
    if isForce == nil then isForce = false end
    CS_LuaCallCs.MoreRawScrollViewRefreshCurrentList(scrollView, isForce)
end
function table.MoreRawScrollViewMoveToStartPos(scrollView)
    CS_LuaCallCs.MoreRawScrollViewMoveToStartPos(scrollView)
end
function table.MoreRawScrollViewScrollToItem(scrollView, idx)
    CS_LuaCallCs.MoreRawScrollViewScrollToItem(scrollView, idx)
end
function table.MoreRawScrollViewPlayEnterAni(scrollView)
    CS_LuaCallCs.MoreRawScrollViewPlayEnterAni(scrollView)
end
--MoreRawScrollView

--MenuPopupScrollView
function table.GetMenuPopupScrollView(obj, path)
    return CS_LuaCallCs.GetMenuPopupScrollView(obj, path)
end
function table.MenuPopupScrollViewSetup(scrollView, menuCount, popupCount, isFold)
    CS_LuaCallCs.MenuPopupScrollViewSetup(scrollView, menuCount, popupCount, isFold)
end
function table.MenuPopupScrollViewSetupCustomPopup(scrollView, popupCountList, isFold)
    CS_LuaCallCs.MenuPopupScrollViewSetupCustomPopup(scrollView, popupCountList, isFold)
end

function table.MenuPopupScrollViewFoldMenu(scrollView, menuIdx, isFold)
    CS_LuaCallCs.MenuPopupScrollViewFoldMenu(scrollView, menuIdx, isFold)
end

function table.MenuPopupScrollViewMenuItemReloadCallback(scrollView, func)
    CS_LuaCallCs.MenuPopupScrollViewMenuItemReloadCallback(scrollView, func)
end
function table.MenuPopupScrollViewPopupItemReloadCallback(scrollView, func)
    CS_LuaCallCs.MenuPopupScrollViewPopupItemReloadCallback(scrollView, func)
end
function table.MenuPopupScrollViewRefreshCurrentList(scrollView)
    CS_LuaCallCs.MenuPopupScrollViewRefreshCurrentList(scrollView)
end
function table.MenuPopupScrollViewMoveToStartPos(scrollView)
    CS_LuaCallCs.MenuPopupScrollViewMoveToStartPos(scrollView)
end
function table.MenuPopupScrollViewScrollToMenu(scrollView, menuIdx)
    CS_LuaCallCs.MenuPopupScrollViewScrollToMenu(scrollView, menuIdx)
end
function table.MenuPopupScrollViewPlayEnterAni(scrollView)
    CS_LuaCallCs.MenuPopupScrollViewPlayEnterAni(scrollView)
end
--MenuPopupScrollView


--ChatScrollView
function table.GetJChatScrollView(obj, path)
    return CS_LuaCallCs.GetJChatScrollView(obj, path)
end
function table.JChatScrollViewSetup(scrollView, templateList)
    CS_LuaCallCs.JChatScrollViewSetup(scrollView, templateList)
end
function table.JChatScrollViewAddMessage(scrollView, tempIdx)
    CS_LuaCallCs.JChatScrollViewAddMessage(scrollView, tempIdx)
end
function table.JChatScrollViewToNewMessage(scrollView)
    CS_LuaCallCs.JChatScrollViewToNewMessage(scrollView)
end
function table.JChatScrollViewToMessageByIdx(scrollView, idx)
    CS_LuaCallCs.JChatScrollViewToMessageByIdx(scrollView, idx)
end
function table.JChatScrollViewItemReloadCallback(scrollView, func)
    CS_LuaCallCs.JChatScrollViewItemReloadCallback(scrollView, func)
end
function table.JChatScrollViewReceiveNewMessageCallback(scrollView, func)
    CS_LuaCallCs.JChatScrollViewReceiveNewMessageCallback(scrollView, func)
end
--ChatScrollView

--扩展组件:多段血条组件
function table.HpComponentSetup(obj, cur, max, layer)
    CS_LuaCallCs.HpComponentSetup(obj, cur, max, layer)
end
function table.HpComponentSetValue(obj, value)
    CS_LuaCallCs.HpComponentSetValue(obj, value)
end
--扩展组件:多段血条组件

--扩展组件:血条组件
function table.JBloodSliderSetup(obj, path, cur, max)
    return CS_LuaCallCs.JBloodSliderSetup(obj, path, cur, max)
end
function table.JBloodSliderSetValue(blood, value, isTween)
    CS_LuaCallCs.JBloodSliderSetValue(blood, value, isTween)
end
--扩展组件:血条组件


--DoTween 扩展组件
function table.DoTweenRectTransformScale(obj, endScale)
    CS_LuaCallCs.DoTweenRectTransformScale(obj, endScale)
end

function table.DoTweenRectTransformFromToScale(obj, startScale, endScale)
    CS_LuaCallCs.DoTweenRectTransformFromToScale(obj, startScale, endScale)
end

function table.DoTweenRectTransformStopScale(obj)
    CS_LuaCallCs.DoTweenRectTransformStopScale(obj)
end

function table.DoTweenTransformPlayFromToByTime(obj, to, time, ease)
    CS_LuaCallCs.DoTweenTransformPlayFromToByTime(obj, to, time, ease)
end

function table.DoTweenTransformPlayFromTo(obj, from, to)
    CS_LuaCallCs.DoTweenTransformPlayFromTo(obj, from, to)
end

function table.DoTweenTransformPlayTo(obj, to)
    CS_LuaCallCs.DoTweenTransformPlayTo(obj, to)
end

function table.DoTweenTransformStop(obj)
    CS_LuaCallCs.DoTweenTransformStop(obj)
end

function table.DoTweenSliderPlay(obj, form, to)
    CS_LuaCallCs.DoTweenSliderPlay(obj, form, to)
end

function table.DoTweenSliderPlayDuring(obj, form, to, time)
    CS_LuaCallCs.DoTweenSliderPlayDuring(obj, form, to, time)
end

function table.DoTweenSliderPlayTo(obj, to)
    CS_LuaCallCs.DoTweenSliderPlayTo(obj, to)
end

function table.DoTweenSliderPlayToDuring(obj, to, time)
    CS_LuaCallCs.DoTweenSliderPlayToDuring(obj, to, time)
end

function table.DoTweenSliderStop(obj)
    CS_LuaCallCs.DoTweenSliderStop(obj)
end

function table.DoTweenImagePlayFromToByTime(obj, form, to, time)
    CS_LuaCallCs.DoTweenImagePlayFromToByTime(obj, form, to, time)
end

function table.DoTweenImagePlayFromTo(obj, form, to)
    CS_LuaCallCs.DoTweenImagePlayFromTo(obj, form, to)
end

function table.DoTweenImagePlayToByTime(obj, to, time)
    CS_LuaCallCs.DoTweenImagePlayToByTime(obj, to, time)
end

function table.DoTweenImagePlayTo(obj, to)
    CS_LuaCallCs.DoTweenImagePlayTo(obj, to)
end

function table.DoTweenImageStop(obj)
    CS_LuaCallCs.DoTweenImageStop(obj)
end

function table.DoTweenTextPlayFromToByTime(obj, form, to, time)
    CS_LuaCallCs.DoTweenTextPlayFromToByTime(obj, form, to, time)
end

function table.DoTweenTextPlayFromTo(obj, form, to)
    CS_LuaCallCs.DoTweenTextPlayFromTo(obj, form, to)
end

function table.DoTweenTextPlayFromToAndBackCall(obj, form, to, backCall)
    CS_LuaCallCs.DoTweenTextPlayFromToAndBackCall(obj, form, to, backCall)
end

function table.DoTweenTextPlayToByTime(obj, to, time)
    CS_LuaCallCs.DoTweenTextPlayToByTime(obj, to, time)
end

function table.DoTweenTextPlayTo(obj, to)
    CS_LuaCallCs.DoTweenTextPlayTo(obj, to)
end

function table.DoTweenTextStop(obj)
    CS_LuaCallCs.DoTweenTextStop(obj)
end
--DoTween 扩展组件

--image
function table.UGUISetImage(obj, path, atlas, spriteName, async)
    CS_LuaCallCs.UGUISetImage(obj, path, atlas, spriteName, async)
end

function table.UGUISetImageSync(obj, path, atlas, spriteName)
    CS_LuaCallCs.UGUISetImageSync(obj, path, atlas, spriteName)
end
function table.UGUISetImageFillAmount(obj, path, value)
    CS_LuaCallCs.UGUISetImageFillAmount(obj, path, value)
end

function table.UGUISetImageRGB(obj, path, color)
    CS_LuaCallCs.UGUISetImageRGB(obj, path, color)
end
--image

function table.UGUISetRawImage(obj, path, textureName, groupID)
    if groupID == nil or groupID == UIModuleID.Default then LuaCallCs.LogError("---   有内存泄露风险，UGUISetRawImage() 未指定groupID", true) end
    CS_LuaCallCs.UGUISetRawImage(obj, path, textureName, groupID)
end

function table.UGUISetRawImgSetNativeSize(obj, path)
    CS_LuaCallCs.UGUISetRawImgSetNativeSize(obj, path)
end

function table.ReleaseTextureByGroup(groupID)
    CS_LuaCallCs.ReleaseTextureByGroup(groupID)
end

function table.ForceReleaseTexture(textureName)
    CS_LuaCallCs.ForceReleaseTexture(textureName)
end

function table.UIGUISetRawImageLight(obj, path, light)
    CS_LuaCallCs.UIGUISetRawImageLight(obj, path, light)
end

function table.UGUISetLabel(obj, path, text)
    CS_LuaCallCs.UGUISetLabel(obj, path, text)
end

function table.UGUISetTextMeshProAndHex(obj, path, text, hex)
    CS_LuaCallCs.UGUISetTextMeshProAndHex(obj, path, text, hex)
end
function table.UGUISetTextMeshPro(obj, path, text)
    CS_LuaCallCs.UGUISetTextMeshPro(obj, path, text)
end

function table.UGUISetTextMeshProHex(obj, path, hex)
    CS_LuaCallCs.UGUISetTextMeshProHex(obj, path, hex)
end

--InputField
function table.UGUIInputFieldSetValue(obj, path, text)
    CS_LuaCallCs.UGUIInputFieldSetValue(obj, path, text)
end

function table.UGUIInputFieldGetValue(obj, path)
    return CS_LuaCallCs.UGUIInputFieldGetValue(obj, path)
end
--InputField

--Slider
function table.UGUISliderSetValue(obj, path, value)
    CS_LuaCallCs.UGUISliderSetValue(obj, path, value)
end

function table.UGUISliderSetMaxValue(obj, path, value)
    CS_LuaCallCs.UGUISliderSetMaxValue(obj, path, value)
end
--Slider

--JSlider
function table.GetJSlider(obj, path)
    return CS_LuaCallCs.GetJSlider(obj, path)
end
function table.JSliderSetValue(slider, value)
    CS_LuaCallCs.JSliderSetValue(slider, value)
end
function table.JSliderSetOnValueChanged(slider, callback)
    CS_LuaCallCs.JSliderSetOnValueChanged(slider, callback)
end

function table.SetJSliderThresholdsShowList(obj, path, thresholds)
    CS_LuaCallCs.SetJSliderThresholdsShowList(obj, path, thresholds)
end

---@type function
---@param value number | nil 0或者nil为第一段1/2分割，1表示1/3分割，2表示2/3分割
function table.SetJSliderThresholdsSplitFirstSegment(obj, path, value)
    if not value then value = 0 end
    CS_LuaCallCs.SetJSliderThresholdsSplitFirstSegment(obj, path, value)
end

function table.SetJSliderThresholdsValue(obj, path, value)
    CS_LuaCallCs.SetJSliderThresholdsValue(obj, path, value)
end

--JSlider

function table.UGUIDragButtonInScrollViewAddEvent(obj, path, onDragBegin, onDragEnd, onDrag)
    CS_LuaCallCs.UGUIDragButtonInScrollViewAddEvent(obj, path, onDragBegin, onDragEnd, onDrag)
end

function table.JScreenShakePlay(obj, path)
    return CS_LuaCallCs.JScreenShakePlay(obj, path)
end

function table.JScreenShakeStop(obj, path)
    return CS_LuaCallCs.JScreenShakeStop(obj, path)
end

function table.JScreenShakePlayByTime(obj, path, time)
    return CS_LuaCallCs.JScreenShakePlayByTime(obj, path, time)
end

--JSpine
function table.SetJSpine(obj, path, autoPlayOnStart)
    return CS_LuaCallCs.SetJSpine(obj, path, autoPlayOnStart)
end

function table.JSpinePlay(obj, path, animationName, loop, mixDuration)
    CS_LuaCallCs.JSpinePlay(obj, path, animationName, loop, mixDuration)
end

function table.JSpinePause(obj, path)
    CS_LuaCallCs.JSpinePause(obj, path)
end

function table.JSpineStop(obj, path, clearQueue)
    CS_LuaCallCs.JSpineStop(obj, path, clearQueue)
end

function table.SetJSpineLoop(obj, path, loop)
    CS_LuaCallCs.SetJSpineLoop(obj, path, loop)
end

function table.SetJSpineMixDuration(obj, path, duration)
    CS_LuaCallCs.SetJSpineMixDuration(obj, path, duration)
end

function table.IsJSpinePlaying(obj, path)
    return CS_LuaCallCs.IsJSpinePlaying(obj, path)
end

function table.HasJSpineAnimation(obj, path, name)
    return CS_LuaCallCs.HasJSpineAnimation(obj, path, name)
end

function table.JSpineReset(obj, path)
    CS_LuaCallCs.JSpineReset(obj, path)
end

function table.JSkeletonGraphicSetLight(obj, light)
    CS_LuaCallCs.JSkeletonGraphicSetLight(obj, light)
end

function table.GetSpineCurrentAnimation(obj, path)
    return CS_LuaCallCs.GetSpineCurrentAnimation(obj, path) or ""
end

function table.RestartDoTweenAnimation(obj, value)
    return CS_LuaCallCs.RestartDoTweenAnimation_Text(obj, value)
end

function table.PlayDoTweenAnimation(obj, value)
    return CS_LuaCallCs.PlayDoTweenAnimation_Text(obj, value)
end

function table.StopDoTweenAnimation(obj)
    return CS_LuaCallCs.StopDoTweenAnimation(obj)
end

function table.KillDoTweenAnimation(obj)
    return CS_LuaCallCs.KillDoTweenAnimation(obj)
end


--扩展组件:DoTweenAnimationGroup
function table.GetDoTweenAnimationGroup(parent, path)
    return CS_LuaCallCs.GetDoTweenAnimationGroup(parent, path)
end

function table.DoTweenAnimationGroupRestart(group)
    CS_LuaCallCs.DoTweenAnimationGroupRestart(group)
end

 --禁用点击事件
function table.DisableUIEvent(value)
    CS_LuaCallCs.DisableUIEvent(value)
end

function table.MapLineRandererSetting(obj,pos1, pos2)
    CS_LuaCallCs.MapLineRandererSetting(obj,pos1,pos2)
end

function table.SetGraphicGray(parent, path, isGray)
    CS_LuaCallCs.SetGraphicGray(parent, path, isGray)
end

function table.ForceUpdateCanvases(obj)
    CS_LuaCallCs.ForceUpdateCanvases(obj)
end


function table.GuideRectFollowSetData(parent, path, guideTarget, guideRect)
    CS_LuaCallCs.GuideRectFollowSetData(parent, path, guideTarget, guideRect)
end

function table.GuideCircleFollowSetData(parent, path, guideTarget)
    CS_LuaCallCs.GuideCircleFollowSetData(parent, path, guideTarget)
end

---@type fun(balanceGo:GameObject, dragAction:fun()):void 设置天平拖动事件
function table.SetBalanceWithDragAction(balanceGo, dragAction)
    CS_LuaCallCs.SetBalanceWithDragAction(balanceGo, dragAction)
end

---@type fun(balanceGo:GameObject, maxAngle:number):void 设置天平最大倾角
function table.SetBalanceWithMaxAngle(balanceGo, maxAngle)
    CS_LuaCallCs.SetBalanceWithMaxAngle(balanceGo, maxAngle)
end

---@type fun(balanceGo:GameObject, curAngle:number):void 设置天平当前角度
function table.SetBalanceWithCurAngle(balanceGo, curAngle)
    CS_LuaCallCs.SetBalanceWithCurAngle(balanceGo, curAngle)
end

---@type fun(balanceGo:GameObject):void 设置天平位置刷新
function table.SetBalanceRefreshRotate(balanceGo)
    CS_LuaCallCs.SetBalanceRefreshRotate(balanceGo)
end


function table.DoTweenCanvasGroupAlphaPlayFromToByTime (obj, form, to, time)
    CS_LuaCallCs.DoTweenCanvasGroupAlphaPlayFromToByTime(obj, form, to, time)
end

function table.DoTweenCanvasGroupAlphaPlayFromTo (obj, form, to)
    CS_LuaCallCs.DoTweenCanvasGroupAlphaPlayFromTo(obj, form, to)
end

function table.DoTweenCanvasGroupAlphaPlayToByTime (obj, to, time)
    CS_LuaCallCs.DoTweenCanvasGroupAlphaPlayToByTime(obj, to, time)
end

function table.DoTweenCanvasGroupAlphaPlayTo (obj, to)
    CS_LuaCallCs.DoTweenCanvasGroupAlphaPlayTo(obj, to)
end

function table.DoTweenCanvasGroupAlphaStop (obj)
    CS_LuaCallCs.DoTweenCanvasGroupAlphaStop(obj)
end

LuaCallCs.UI = table
