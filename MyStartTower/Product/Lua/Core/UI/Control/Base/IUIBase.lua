-- IUIBase类的定义
-- @author
-- @date

local strClassName = "IUIBase"

---@class IUIBase
local IUIBase = Class(strClassName)
local UIUtils = Framework.UI.UIUtils

-- 构造函数。
function IUIBase:ctor()
    
end

function IUIBase:destroy()
    if self.id ~= nil then
        UIUtils.DestroyUI(self.id)
        self.id = nil
    end
end

-------------------↓ C#回掉函数（不可继承）↓-------------------

function IUIBase:OnCtorEnd(id, controller)
    self.id = id
    self._controller = controller
end

-- 界面加载完毕时
function IUIBase:OnInitEnd()
    self:onInit()
end

-- 界面即将销毁时
function IUIBase:OnDestroyStart()
    ClientTimerManager.RemoveSecondTickRoot(self.id)
    self:onDestroy()
end

-- 界面显示时
function IUIBase:OnOpenStart()
    if not self:getVisible() then
        return
    end
    self:onOpen()
end

-- 界面显示时
function IUIBase:OnOpenEnd()
    if not self:getVisible() then
        return
    end
    self:onOpenOver()
end

-- 界面隐藏时
function IUIBase:OnCloseEnd()
    self:onClose()
    if self.eventClose then
        self:eventClose()
    end
end

-------------------↑ C#回掉函数（不可继承）↑-------------------
----------------------↓ 初始化流程函数 ↓----------------------

function IUIBase:onInit()
    self._uiLayer = self:getLayer(true)
end

function IUIBase:onDestroy()
    self.id = nil
end

function IUIBase:onOpen()
    -- body
end

function IUIBase:onOpenOver()
    -- body
end

function IUIBase:onClose()
    -- body
end

----------------------↑ 初始化流程函数 ↑----------------------

function IUIBase:getController()
    return self._controller
end

function IUIBase:GetGameObject()
    if self._controller then
        return self._controller.gameObject
    end
    return nil
end

function IUIBase:GetRectTransform()
    if self._controller then
        return self._controller:GetRectTransform()
    end
    return nil
end

--是否初始化完成
function IUIBase:isInit()
    return self._controller ~= nil
end

-- 设置界面可见度(变化中则是目标可见度)
function IUIBase:setVisible(v)
    self._visible = v
end

-- 获取界面可见度
function IUIBase:getVisible()
    return self._visible
end

-- 改变界面可见度
function IUIBase:changeVisible()
    self:setVisible(not self._visible)
end

function IUIBase:setPosition(x, y)
    self:getController():SetPosition(x, y, 0)
end

function IUIBase:getPosition()
    local pos = self:getController().transform.localPosition
    return {x = pos.x, y = pos.y}
end

function IUIBase:setAbsPosition(x, y)
    self:getController():SetAbsPosition(x, y, 0)
end

function IUIBase:getAbsPosition()
    local pos = self:getController().transform.position
    return {x = pos.x, y = pos.y}
end

function IUIBase:setScale( scale )
    self:getController().transform.localScale = Vector3(scale, scale, scale)
end

function IUIBase:setLayer(layer)
    self:getController():SetLayerName(layer)
    self._uiLayer = layer
end

function IUIBase:getLayer(refresh)
    if refresh then
        return self:getController():GetLayerName()
    else
        return self._uiLayer
    end
end

function IUIBase:playStateAnimator( stateName )
    coroutine.start(self._playAnimCoroutine, self, stateName)
end



function IUIBase:setRenderMode(renderMode)
    if renderMode >= 0 then
        self:getController():SetRenderMode(renderMode)
    end
end

function IUIBase:getRenderMode()
    return self:getController():GetRenderMode()
end

function IUIBase:_playAnimCoroutine( stateName )
    coroutine.step()
    if self.id then
        self:getController():PlayStateAnimator(stateName)
    end
end

function IUIBase:setObjGray(isGray)
    if self._isGray == isGray then
        return
    end
    local go = self:getController().gameObject
    if go ~= nil then
        self._isGray = isGray
        self:getController():SetObjectGray(go, isGray)
    end
end

local RectTransformType = typeof(UnityEngine.RectTransform)
function IUIBase:getRectSize(  )
    local go = self:getController().gameObject
    if go then
        local rectTran = go:GetComponent(RectTransformType)
        if rectTran then
            return rectTran.rect
        end
    end
end

function IUIBase:setName(name)
    local go = self:getController().gameObject
    if go ~= nil then
        go.name = name
    end
end

function IUIBase:cleanCanvasGroupAlpha(gameObject)
    local go = self:getController()
    if go ~= nil then
        go:CleanCanvasGroupAlpha(gameObject)
    end
end








function IUIBase:SetActive(v, forceUpdate)
    if forceUpdate or self:getVisible() ~= v then
        local go = self:GetGameObject()
        if go ~= nil then
            self._visible = v
            if go.activeSelf ~= v then
                go:SetActive(v)
            end
        end
    end
end

return IUIBase

