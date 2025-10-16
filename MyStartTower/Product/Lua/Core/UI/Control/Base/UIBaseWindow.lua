local IUIBase = require("Core/UI/Control/Base/IUIBase")
local UIUtils = Framework.UI.UIUtils
local VersionUtils = require("Core/System/VersionUtils")

---@class UIBaseWindow : IUIBase
local UIBaseWindow = Class("UIBaseWindow", IUIBase)

-- 成员变量。
UIBaseWindow.DELAY_INIT_CD = 0.1    --延迟加载child时间

local GraphicType = typeof(UnityEngine.UI.GraphicRaycaster)
-- 构造函数。
function UIBaseWindow:ctor(prefabPath, order, needShow, uiName)
    if order == nil then
        order = 50
    end
    if needShow == nil then
        needShow = false
    end
    self._order = order         --当前缓存深度值
    self._orderOrg = order      --原始深度值
    self._visible = needShow
    self.mWindow = self
    self._hide = false
    local obj = UIManager.GetAdvanceLoaderPrefab(prefabPath)
    if obj then
        --print("---   UI已经加载过，ui = "..prefabPath)
        UIUtils.CreateUIWindow(prefabPath, self, needShow, order, obj)
    else
        UIUtils.CreateUIWindow(prefabPath, self, needShow, order)
    end
    --
    self._hide2Destroy = nil    --隐藏时是否销毁界面
    self.visibleHadChange = false --是否被set过visible





    -- 以下是重构过的代码
    self.__uiName = uiName
    self.__windowObject = self:GetGameObject()
    ---@type UITopBarComponent
    self.__topBarComp = nil
    ---@type UIReturnBoxComponent
    self.__returnBoxComp = nil
end

function UIBaseWindow:destroy()
    EventManager.Global.UnRegisterEvent(EventType.UpdateInventory, self._evtOnInventoryUpdate)
    self:UILiftOnDestroy()
    if self._timerInit ~= nil then
        self._timerInit:Stop()
    end
    self:_bindRelease()
    UIBaseWindow.super.destroy(self)
end

function UIBaseWindow:postInit(uiName, uiData)
    self.mUIName = uiName
    self.mUIData = uiData
    self.mUIGroup = uiData.ui_group





    self:__initTopBarComponent()
    self:__initReturnBoxComponent()

    self._evtOnInventoryUpdate = function() self:__onInventoryUpdate() end
    EventManager.Global.RegisterEvent(EventType.UpdateInventory, self._evtOnInventoryUpdate)

    self:UILiftOnInit()
end




function UIBaseWindow:onInit()
    UIBaseWindow.super.onInit(self)
end

function UIBaseWindow:onOpen()
    -- 这里的接口有耦合，只要UI被打开就调用一次
    -- 1.打开UI时调用一次(合理)
    -- 2.已经关闭UI重新自动打开时也会被调用一次(不合理)
    -- 3.隐藏的UI再次显示的时候，不会调用(合理)


    -- 老代码
    if self.mUIData and self.mUIData.ui_block then
        UIManager.showBlock(self)
    end



    self:onVisibleChanged(true)




    --self:bgmOn()


    -- 老代码


    -- 尼玛，战斗中退出回主UI的时候，主UI的open会连续调用2次
    --if self._timerEnterAni then
    --    LuaCallCs.LogError("---    尼玛，战斗中退出回主UI的时候，主UI的open会连续调用2次")
    --end

    self:_breakTimerEnterAni()
    self:UILiftOnOpen()


    print("---   播放UI音乐..   "..self.mUIName)
    UIManager.InterfacePlayUIMusic(self.mUIName)
    ----功能测试
    --if self.mUIName == UIName.UIMain then
    --    EventManager.Global.Dispatch(EventType.AudioSystemPlayMusic, "Audio/Dynamic/BGM/UI_yx_fight_bgm", 0.7, true)
    --elseif self.mUIName == UIName.UIAnnounce then
    --    EventManager.Global.Dispatch(EventType.AudioSystemPlayMusic, "Audio/Dynamic/BGM/mountain_fire_music", 0.7, false)
    --elseif self.mUIName == UIName.UIServerList then
    --    EventManager.Global.Dispatch(EventType.AudioSystemPlayMusic, "Audio/Dynamic/BGM/moguo", 0.7, true)
    --elseif self.mUIName == UIName.UIActiveTask then
    --    EventManager.Global.Dispatch(EventType.AudioSystemPlayMusic, "Audio/Dynamic/BGM/CG_music_card", 0.7, false)
    --end
    ----功能测试



    self._timerEnterAni = Util.Timer.AddTimer(0.2, function()
        self._timerEnterAni = nil
        self:UILiftOnEnterAniFinish()
        print("---   界面开启动画播放完毕, 可以添加新手引导的触发接口...")
        local triggerParam = Util.FindUI.UINameToID(self.mUIName)
        EventManager.Global.Dispatch(EventType.GuideSystemTrigger, GuideDefine.TriggerType.UIOpen, triggerParam)
    end)
end


function UIBaseWindow:_breakTimerEnterAni()
    if self._timerEnterAni then
        Util.Timer.BreakTimer(self._timerEnterAni)
        self._timerEnterAni = nil
    end
end


function UIBaseWindow:onOpenOver()
    self:onVisibleChanged(true)
end

function UIBaseWindow:onOpenBeging()
    --self.mOpening = false
end

function UIBaseWindow:playAni(aniName, callback, immidiatly)
    UIBaseWindow.super.playAni(self, aniName, callback, immidiatly)
    --if self.mOpening then
    --    self:OnOpenEnd()
    --end
end

function UIBaseWindow:onClose()
    self:_breakTimerEnterAni()
    self:UILiftOnClose()
    EventManager.Global.Dispatch(EventType.GuideSystemBreakWeakGuide, Util.FindUI.UINameToID(self.mUIName))

    local triggerParam = Util.FindUI.UINameToID(self.mUIName)
    EventManager.Global.Dispatch(EventType.GuideSystemTrigger, GuideDefine.TriggerType.UIClose, triggerParam)

    if self._hide2Destroy and not self._visible then
        if self.mUIName ~= nil then
            UIManager.delUI(self.mUIName)
        else
            self:destroy()
        end
    end
    self:onVisibleChanged(false)
    self:bgmOff()
end





-- 可见发生变化时调用
function UIBaseWindow:onVisibleChanged(isSee)

end

-- 设置界面可见度
-- 会强制取消Hide
-- 请不要在外部关闭界面时使用setVisible(false,false,true)


function UIBaseWindow:setVisible(v, hideAndDestroy, noAni,playAudio)
    -- 过滤 对当前的hide和visible进行过滤
    -- 真正显示/隐藏   显示=取消隐藏的事件active或者layer   隐藏=deactive
    -- hideanddestroy的特殊处理

    if playAudio == nil then
        playAudio = false
    end

    if self.id == nil then
        local str = "---   尝试setVisible已经销毁的界面  uiName = "..(self.mUIName or "")
        LuaCallCs.ThrowException(str)
        return
    end

    if self.visibleHadChange and v and self._visible and not self._hide then
        -- logerror("重复进行显示操作",v,self._visible,self._hide)
        return
    end

    if self.visibleHadChange and not v and self._hide then
        if hideAndDestroy == false then
            if self._visible and (self.mUIGroup ~= nil or (self.mUIData and (self.mUIData.shut_down_cam or self.mUIData.need_hdr))) then
                --打断互斥
                self._visible = false
                UIManager.visibleReject(self)
            end
            -- logerror("重复进行隐藏操作")
            return
        end
    end
    if self.visibleHadChange and not v and not self._visible then
        if hideAndDestroy == false then
            -- logerror("重复进行隐藏操作")
            self:OnCloseEnd()
            return
        end
    end
    self._visible = v
    if not self._visible then
        if hideAndDestroy == nil then hideAndDestroy = true end
        self._hide2Destroy = hideAndDestroy
        if self._hide2Destroy then
            self:_bindRelease()
        end
    else
        self:setHide(false,nil,true)
    end
    if self._boundUIs then
        for i, ui in pairs(self._boundUIs) do
            ui:setVisible(self._visible)
        end
    end

    -- 调整显示互斥规则：
    -- by：盛旺
    -- 由于：互斥会带调用setHide，触发onClose方法
    -- 所以：开启后显示,关闭先隐藏，确保onClose方法先被触发

    -- 关闭先隐藏
    if not v then
        UIUtils.SetUIVisible(self.id, self._visible, noAni or false,playAudio)
    end
    if self.mUIGroup ~= nil or (self.mUIData and (self.mUIData.shut_down_cam or self.mUIData.need_hdr)) then
        UIManager.visibleReject(self)
    end
    if self.id then
        -- 开启后显示
        if v then
            UIUtils.SetUIVisible(self.id, self._visible, noAni or false,playAudio)
        end
        self.visibleHadChange = true
    end
end

function UIBaseWindow:uniteVisible(v,hideAndDestroy)

end

--通过修改层级隐藏界面
function UIBaseWindow:setHide(v, showAni)
    -- 过滤 对当前的hide和visible进行过滤
    -- 真正显示/隐藏      显示=取消隐藏的事件active或者layer   隐藏=layer=true
    if self._hide == v then
        return
    end
    if showAni == nil then
        showAni = false
    end
    self._hide = v

    if self._boundUIs then
        for i, ui in pairs(self._boundUIs) do
            ui:setHide(v, showAni, false)
        end
    end
    UIUtils.SetUIHide(self.id, v)
    if VersionUtils.getEngineVersion() < 85154 then
        if not self.casterInited then
            self.casterInited = true
            self.graphicCaster = self:getController().gameObject:GetComponent(GraphicType)
            if self.panelFund then
                self.fundGraphicCaster = self.panelFund:getController().gameObject:GetComponentInParent(GraphicType)
            end
        end
        if self.graphicCaster then
            self.graphicCaster.enabled = not v
        end
        if self.fundGraphicCaster then
            self.fundGraphicCaster.enabled = not v
        end
    end
    if v then
        self:setOrder()
        self:OnCloseEnd()
    else
        self:resetOrder()

        self:OnOpenStart()
        self:OnOpenEnd()
    end
    self:onVisibleChanged(not v)

end

function UIBaseWindow:isInShow()
    return self._visible and not self:getHide()
end

function UIBaseWindow:getHide()
    return self._hide
end

-- 设置界面深度值
function UIBaseWindow:setOrder(v)
    v = v or 0
    if self._order == v then
        return
    end
    self._order = v
    UIUtils.SetUIOrder(self.id, v)
end

function UIBaseWindow:getOrder()
    return self._order
end

function UIBaseWindow:resetOrder()
    self:setOrder(self._orderOrg)
end

--令当前界面的显隐绑定指定界面
--目标隐藏(visible/hide)会强制关闭当前界面
--目标显示也会强制显示(hide)当前界面
function UIBaseWindow:bindWindow(window)
    if self._boundWindow ~= nil then
        self:_bindRelease()
    end
    self._boundWindow = window
    if window then
        if window._boundUIs == nil then
            window._boundUIs = {}
        end
        window._boundUIs[self.id] = self
    end
end

function UIBaseWindow:_bindRelease()
    if self._boundWindow then
        if self._boundWindow._boundUIs then
            self._boundWindow._boundUIs[self.id] = nil
        end
    end
    self._boundWindow = nil
end

--所有被绑定在自己身上的ui的bind被清除
function UIBaseWindow:allBindedWindowRelease()
    if self._boundUIs then
        for _,window in pairs(self._boundUIs) do
            window:setVisible(false)
        end
        self._boundUIs = nil
    end
end

function UIBaseWindow:getMainCamVisible()
    if self.mUIData.shut_down_cam and self._visible and not self._hide then
        return false
    else
        return true
    end
end

function UIBaseWindow:need2DHDR(  )
    if self.mUIData.need_hdr and self._visible and not self._hide then
        return true
    else
        return false
    end
end



function UIBaseWindow:bgmOff( ... )

end




function UIBaseWindow:changeOutAnim( animName )
    self:getController():SetCloseAnimName(animName)
end

function UIBaseWindow:inCache( ... )
end

function UIBaseWindow:reuseCache( ... )
end


---------------------------- 以上是老的接口，非必要不要使用 ----------------------------

---------------------------- 以下是重构过的接口 ----------------------------
function UIBaseWindow:__onInventoryUpdate() -- 物品更新消息
    -- 货币栏刷新
    if self.__topBarComp then
        self.__topBarComp:UpdateCurrencyValue()
    end
end

function UIBaseWindow:__initTopBarComponent() -- 初始化顶部货币栏组件(UI里有这个组件，才会初始化)
    local obj = LuaCallCs.GetObject(self:GetGameObject(), "SLM_TopBarGroup")
    if obj then
        -- 这一段配置要挪到新的UI表里，暂时先不处理 2025.9.11]
        local list = Util.FindUI.GetUICurrencyList(self.__uiName)
        local comp = UITopBarComponent()
        comp:Init(obj, list)
        self.__topBarComp = comp
    end
end

function UIBaseWindow:__initReturnBoxComponent() -- 初始化返回按钮组件(UI里有这个组件，才会初始化)
    local obj = LuaCallCs.GetObject(self:GetGameObject(), "returnBox")
    if not obj then
        obj = LuaCallCs.GetObject(self:GetGameObject(), "returnBox2")     --第二类返回按钮
    end
    if obj then
        local name = Util.FindUI.GetUIName(self.__uiName)
        local tipsId = Util.FindUI.GetTipsID(self.__uiName)
        local comp = UIReturnBoxComponent()
        comp:Init(obj, self.__uiName, name, tipsId)
        self.__returnBoxComp = comp
    end
end

--[[
UI生命周期接口，之前的接口后续可以慢慢弃用，业务侧重写接口的时候可以完全重写，不需要额外调用父类方法
--]]

-- UI框架层接口
function UIBaseWindow:UILiftOnInit()

end
function UIBaseWindow:UILiftOnOpen()

end
function UIBaseWindow:UILiftOnClose()

end
function UIBaseWindow:UILiftOnDestroy()

end
function UIBaseWindow:UILiftOnEnterAniFinish() -- UI生命周期:开UI动画播放完毕(这套UI框架里，这个接口不严谨，不推荐大量使用)

end
function UIBaseWindow:InternalRegisterEvent()
    self:OnRegisterEvent()
end
---@type function ： 子UI需要实现这个方法，在这个方法中注册UI事件，注册事件调用 self:RegisterEventByID(id, func)
function UIBaseWindow:OnRegisterEvent()

end
function UIBaseWindow:RegisterEventByID(id, func)
    --UIEventManager:Get():RegisterEvent(self.mUIName, id, func)
    Blackboard.UIEvent.RegisterEvent(self.mUIName, id, func)
end
-- UI框架层接口


-- 其他业务性接口
function UIBaseWindow:GameInterfaceSetTopBar(currencyList) -- 其他业务性接口：设置货币栏
    if self.__topBarComp then
        self.__topBarComp:UpdateCurrencyList(currencyList)
    end
end

function UIBaseWindow:GameInterfaceSetReturnBoxName(name) -- 其他业务性接口：设置返回框
    if self.__returnBoxComp then
        self.__returnBoxComp:ResetName(name)
    end
end

function UIBaseWindow:GameInterfaceSetReturnBoxTips(tipsId) -- 其他业务性接口：设置返回框
    if self.__returnBoxComp then
        self.__returnBoxComp:ResetTipID(tipsId)
    end
end

function UIBaseWindow:GameInterfaceSetReturnBoxReturnEvent(func) -- 其他业务性接口：设置返回框
    if self.__returnBoxComp then
        self.__returnBoxComp:ResetReturnEvent(func)
    end
end

function UIBaseWindow:GameInterfaceSetReturnBoxEnable(enable) -- 其他业务性接口：设置返回框
    if self.__returnBoxComp then
        self.__returnBoxComp:SetShow(enable)
    end
end

function UIBaseWindow:GameInterfaceGetWindowObject() -- 其他业务性接口：获取窗口Object对象。不改有这种接口，为了适配老代码
    return self.__windowObject
end
-- 其他业务性接口

return UIBaseWindow
