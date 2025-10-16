local UIConst = require("Core/UI/UIConst")

local strClassName = "UIBaseControl"

---@class UIBaseControl
local UIBaseControl = Class(strClassName)

local tolua = tolua

local Vector2 = Vector2
local Vector3 = Vector3
local Quaternion = Quaternion

-- 构造函数。
function UIBaseControl:ctor(parent, path)
    self.mParent = parent                   --上一级容器界面/控件
    self.mWindow = parent.mWindow or parent --所在最上层canvas
    self.mRoot = parent.mRoot or parent     --所在最近的上级window/child/loopcell
    self.mPath = path
    self._isGray = false
end

function UIBaseControl:_getControlType()
    return UIConst.ControlTypeGameObject
end

function UIBaseControl:getControlType(  )
    return self:_getControlType()
end

function UIBaseControl:_packageCallback(func)
    if not func then
        logerror("UIBaseControl:_packageCallback error, func is nil")
        return nil
    end
    local function callback(root, sender, ...)
        if self.mWindow and self.mWindow.isInShow and (not self.mWindow:isInShow()) and not UIConst.EXECUTABLE_CONTROL_TYPE[self:_getControlType()] then      -- 当前窗口已经关闭了  此时不需要响应触发
            return
        end
        --if self.mWindow and not UIConst.EXECUTABLE_CONTROL_TYPE[self:_getControlType()] then      -- 当前窗口正在打开  此时不需要响应触发
        --    print("UIBaseControl:_packageCallback error, window is opening", self.mWindow and self.mWindow.mUIName)
        --    return
        --end
        if root == self.mRoot and sender == self:getComObj() then
            func(self.mParent, self, ...)
        end


    end
    return callback
end

function UIBaseControl:getController()
    if self._controller == nil then
        self._controller = self.mRoot:getController()
    end
    return self._controller
end

function UIBaseControl:getComObj()
    if self._obj == nil then

        local ctr=self:getController()
        local typ=self:_getControlType()

        self._obj = ctr:GetCom(typ, self.mPath)
    end
    return self._obj
end

function UIBaseControl:isAlive()
    return not tolua.isnull(self:getComObj())
end

function UIBaseControl:getGameObject()
    local obj = self:getComObj()
    if self:_getControlType() == UIConst.ControlTypeGameObject then
        self._gameObject = obj
    elseif self._obj ~= nil then
        self._gameObject = obj.gameObject
    end
    return self._gameObject
end

function UIBaseControl:getVisible()
    if self._visible == nil then
        local go = self:getGameObject()
        self._visible = false
        if go then
            self._visible = go.activeSelf
        end
    end
    return self._visible
end

function UIBaseControl:setVisible(v, forceUpdate)
    if forceUpdate or self:getVisible() ~= v then
        local go = self:getGameObject()
        if go ~= nil then
            self._visible = v
            if go.activeSelf ~= v then
                go:SetActive(v)
            end
        end
    end
end

function UIBaseControl:setObjEnabled(enabled)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.enabled = enabled
    end
end

-- 改变可见度
function UIBaseControl:changeVisible()
    self:setVisible(not self:getVisible())
end

function UIBaseControl:setArchor(minX, minY, maxX, maxY)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.transform.anchorMin = Vector2(minX, minY)
        obj.transform.anchorMax = Vector2(maxX, maxY)
    end
end

function UIBaseControl:getPosition()
    local pos = self:getComObj().transform.anchoredPosition
    return {x = pos.x, y = pos.y}
end

function UIBaseControl:setPosition(x, y)
    local curPos = self:getPosition()
    if x == nil then
        x = curPos.x
    end
    if y == nil then
        y = curPos.y
    end
    self._obj.transform.anchoredPosition = Vector2(x, y)
end

function UIBaseControl:getAbsPosition()
    local pos = self:getComObj().transform.position
    return {x = pos.x, y = pos.y}
end

function UIBaseControl:setAbsPosition(x, y, z)
    local oldPosZ = self:getComObj().transform.position.z
    self._obj.transform.position = Vector3(x, y, oldPosZ)
end

function UIBaseControl:setScale(scale)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.transform.localScale = Vector3(scale, scale, scale)
    end
end

function UIBaseControl:setScaleXYZ( x, y, z )
    local obj = self:getComObj()
    if obj ~= nil then
        obj.transform.localScale = Vector3(x, y, z)
    end
end

function UIBaseControl:getScale()
    local obj = self:getComObj()
    if obj ~= nil then
        local scale = obj.transform.localScale
        return {x = scale.x, y = scale.y}
    end
end

function UIBaseControl:setRotate(angle, roll)
    local obj = self:getComObj()
    if obj ~= nil then
        obj.transform.rotation = Quaternion.Euler(0, roll or 0, angle)
    end
end

function UIBaseControl:setRotateByXYZ(x, y, z)
    local obj = self:getComObj()
    if obj ~= nil then
        local curRotateEuler = obj.transform.localEulerAngles
        --经试验，取出的localEulerAngles的x和y好像是反的。先这样写，如果发现问题再及时纠正。
        obj.transform.localEulerAngles = Vector3((x or curRotateEuler.y), (y or curRotateEuler.x), (z or curRotateEuler.z))
    end
end

function UIBaseControl:getRotateEuler()
    local obj = self:getComObj()
    if obj ~= nil then
        return obj.transform.localEulerAngles
    end
end

function UIBaseControl:setHide(hide)
    if self._hide ~= hide then
        self._hide = hide
        local obj = self:getComObj()
        if self._hide then
            self:getController():ScaleHideUI(obj.transform, 1)
        else
            self:getController():ScaleHideUI(obj.transform, 0)
        end
    end
end

function UIBaseControl:setObjGray(isGray, forceUpdate)
    if self._isGray == isGray and not forceUpdate then
        return
    end
    local go = self:getGameObject()
    if go ~= nil then
        self._isGray = isGray
        self:getController():SetObjectGray(go, isGray)
    end
end

function UIBaseControl:setObjColor(color)
    if color == nil then
        return
    end
    local obj = self:getComObj()
    if obj ~= nil then
        self:getController():SetObjectColor(obj, color.hex)
    end
end



function UIBaseControl:playAnimator(stateName)
    local obj = self:getGameObject()
    if obj ~= nil then
        self:getController():PlayUIStateAnimator(obj, stateName)
    end
end

-- 延迟播放 用于Button里面的animator播放
function UIBaseControl:playStateAnimator( stateName )
    coroutine.start(self._playAnimCoroutine, self, stateName)
end

function UIBaseControl:_playAnimCoroutine( stateName )
    coroutine.step()
    if self.mRoot and self.mRoot.id~=nil then
        self:playAnimator(stateName)
    end
end

function UIBaseControl:setCanvasGroupAlpha(alpha)
    local obj = self:getGameObject()
    if obj ~= nil then
        self:getController():SetCanvasGroupAlpha(obj, alpha)
    end
end

function UIBaseControl:setAnchorPresets( anchorPreset )
    local obj = self:getGameObject()
    if obj~=nil then
        self:getController():SetAnchorPresets(obj, anchorPreset)
    end
end

-- AnchorPreset对应的pos和size
--  AnchorPresets.HorStretchBottom/AnchorPresets.HorStretchMiddle/AnchorPresets.HorStretchTop:
--  ==> pos:posY Height  size:left right
--  AnchorPresets.VertStretchCenter/AnchorPresets.VertStretchLeft/AnchorPresets.VertStretchRight:
--  ==> pos:posX Width  size:top bottom
--  AnchorPresets.StretchAll:
--  ==> pos:left right  size: top bottom
--  default:
--  ==> pos: posX posY  size: width height
function UIBaseControl:setRecttransform( anchorPreset, pos, size )
    local obj = self:getGameObject()
    if obj~=nil then
        self:getController():SetRect(obj, anchorPreset, pos, size)
    end
end

return UIBaseControl

