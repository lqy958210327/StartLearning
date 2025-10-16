local tab = {}

--RectTransform扩展接口
function tab.DOAnchorPos(target, endX, endY, duration, snapping, onComplete)
    CS_DOTweenModuleUI.DOAnchorPos(target, endX, endY, duration, snapping, onComplete)
end
function tab.DOSizeDelta(target, endX, endY, duration, onComplete)
    CS_DOTweenModuleUI.DOSizeDelta(target, endX, endY, duration, onComplete)
end

function tab.DOScale(target, endX, endY, endZ, duration, onComplete)
    CS_DOTweenModuleUI.DOScale(target, endX, endY, endZ, duration, onComplete)
end

LuaCallCs.DOTweenModuleUI = tab
