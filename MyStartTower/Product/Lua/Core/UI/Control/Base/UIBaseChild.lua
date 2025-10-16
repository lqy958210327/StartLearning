local IUIBase = require("Core/UI/Control/Base/IUIBase")
local UIUtils = Framework.UI.UIUtils
---@class UIBaseChild
local UIBaseChild = Class("UIBaseChild", IUIBase)

-- 构造函数。
function UIBaseChild:ctor(parent, url, prefabPath, x, y, defaultVisible, delayInit, siblingIdx, extraNodeName)
    self.mParent = parent
    self.mWindow = parent.mWindow or parent
    if defaultVisible == nil then
        defaultVisible = false
    end
    self._visible = defaultVisible
    x = x or 0
    y = y or 0
    local parentUID = self.mParent.id or self.mParent.mRoot.id
    self._initFunc = Functor(UIUtils.CreateUIChild, prefabPath, self, parentUID, url, x, y, self._visible, siblingIdx or -1, extraNodeName or "")
    if delayInit == nil then
        self._initFunc()
    end
end

function UIBaseChild:getController()
    if self._controller == nil then
        self._initFunc()
    end
    return self._controller
end

-- 设置界面可见度
-- 有时间优化成设置false 时不需要强制初始化
function UIBaseChild:setVisible(v, playAudio)
    if playAudio == nil then
        playAudio = false
    end
    if self.id == nil then
        self:getController()
    end
    self._visible = v
    UIUtils.SetUIVisible(self.id, v, false,playAudio)
end

function UIBaseChild:setPosition(x, y)
    self:getController().transform.anchoredPosition = UnityEngine.Vector3(x, y, 0)
end

function UIBaseChild:moveToPosition(x, y, moveTime)
    self:getController():SetPosition(x, y, 0, moveTime or 0);
end

function UIBaseChild:getPosition()
    local pos = self:getController().transform.anchoredPosition
    return {x = pos.x, y = pos.y}
end

function UIBaseChild:setRotateByXYZ(x, y, z)
    local obj = self:getController()
    if obj ~= nil then
        local curRotateEuler = obj.transform.localEulerAngles
        --经试验，取出的localEulerAngles的x和y好像是反的。先这样写，如果发现问题再及时纠正。
        obj.transform.localEulerAngles = Vector3((x or curRotateEuler.y), (y or curRotateEuler.x), (z or curRotateEuler.z))
    end
end

function UIBaseChild:setLayoutSize(width, height)
    width = width or -1
    height = height or -1
    self:getController():SetLayoutSize(width, height)
end

local Vector3 = Vector3
local Vector3_ONE = Vector3(1, 1, 1)
local Vector3_ZERO = Vector3(0, 0, 0)
function UIBaseChild:setHide(hide)
    if self._hide ~= hide then
        self._hide = hide
        if self._hide then
            UIUtils.ScaleHideUI(self.id, 1)
        else
            UIUtils.ScaleHideUI(self.id, 0)
        end
    end
end



return UIBaseChild

