local UIConst = require("Core/UI/UIConst")
local EventConst = require("Core/EventConst")
local GameSettings = require "Core/Helper/GameSettings"
local NativeHelper = require("Core/Helper/NativeHelper")
local DeviceHelper = require("Core/Helper/DeviceHelper")
-- local Time = Time
local UIManager = {}

local self = UIManager

---@type table<string, UIBaseWindow>
self._uiObjs = {}           --uiName:uiMapData
self._uiRejectGroups = {}   --uiGroup:{list uiName}
local GROUP_MAIN = 20       -- 主界面组
self._uiBlockList = {}      --idx:blockInfo
self._uiCacheDelDict = {}   -- 缓存用字典

--状态切换常驻UI(必须没有互斥组)
self._uiResident = {
    ["UIClickEffect"] = "Show",
    ["NoticeBox"] = "Show",
    ["UIScrollTxt"] = "Show",
    ["UIBlockCanvas"] = true,
    ["debug"] = true,
    --["loadingui"] = true,
    --["mainStageLoading"] = true,
}

self.clickInfos = {}

-- 判断UI是否显示
function UIManager.isShowUI(uiName)
    local ui = self.getUI(uiName, nil, false)
    return ui and ui:isInShow()
end



-- 封装一步 尝试获得并隐藏UI
function UIManager.tryHideUI(uiName)
    if self._uiObjs[uiName] then
        UIManager.getUI(uiName, false)
    end
end

-- 封装一步，只尝试获取UI，不存在的话返回nil
function UIManager.tryGetUI(uiName)
    return UIManager.getUI(uiName, nil, false)
end



-- 封装一步，获取UI，不存在的话就创建
function UIManager.createUI(uiName)
    return UIManager.getUI(uiName, true)
end



--通过UIConst的Map中的uiName获取指定界面
--neecShow 默认不改变
--needCreate 默认true
function UIManager.getUI(uiName, needShow, needCreate, playerAudio)
    if needCreate == nil then
        needCreate = true
    end

    if playerAudio == nil then
        playerAudio = false
    end
    
    ---Log("UI打开这里建立一个映射表，映射内容为功能ID，对应ResConditionLimitData内的ID")
    local isOpen, lock_text = true
    -- if needShow then
    --     log("yw---------UIManager开启UI uiName needShow needCreate :", uiName, needShow, debug.traceback())
    -- end
    if needShow and not isOpen then
        MsgManager.notice(lock_text)
        return
    end

    ---@type UIBaseWindow
    local uiObj = self._uiObjs[uiName]

    if uiObj ~= nil then
        if needShow ~= nil then
            --and uiObj:getVisible() ~= needShow
            uiObj:setVisible(needShow, nil, nil, playerAudio)
        end
        if self._uiCacheDelDict[uiName] and needCreate then
            self._uiCacheDelDict[uiName] = nil
            uiObj:reuseCache()
        end
    elseif needCreate then
        local uiData = DataTable.ResUIMap[uiName]
        if uiData ~= nil then
            local luaClass = require(uiData.pathLua)

            uiObj = luaClass(uiData.prefab, uiData.ui_order, needShow, uiName)

            --[[
            luaClass(uiData.prefab, uiData.ui_order, needShow)  这里执行了很多操作：
            1.Lua侧 调用UIBaseWindow的ctor方法
            2.Lua侧 调用C#侧 Framework.UI.UIUtils.CreateUIWindow() 这个方法
            3.C#侧加载了Prefab，加载完之后给Prefab挂上了一个UIController
            4.C#侧调用Lua侧方法 OnCtorEnd(),这个方法在 IUIBase.lua中,UIBaseWindow中没有实现这个方法
            5.C#侧调用Lua侧方法 OnInitEnd(),这个方法在 IUIBase.lua中,UIBaseWindow中没有实现这个方法
            6.C#侧在Prefab上挂上适配相关的C#代码，在prefab上强制挂了一个新的Canvas
            --]]

            uiObj:postInit(uiName, uiData)
            self._uiObjs[uiName] = uiObj

            if needShow ~= nil then
                uiObj:setVisible(needShow, nil, nil, playerAudio)
            end


            uiObj:InternalRegisterEvent()
        else
            logerror(string.format('not contain ui name:%s ', uiName))
        end
    end
    return uiObj
end

--检测开启条件
function UIManager.CheckFuncOpen(uiName)
    --return isOpen, lock_text
    return true
end




-- 常驻
function UIManager.setUIResident()
    for uiName, show in pairs(self._uiResident) do
        if show == "Show" then
            self.getUI(uiName, true)
        end
    end
end

-- 缓存
function UIManager.setUICache(inLowMemory)
    if inLowMemory then
        UIConst.CacheDefaultTime = 0
        UIConst.CacheMaxNumber = 2
        UIConst.CacheConfig = {
            --["UIHeroCanvas"] = 120
        }
    else
        -- UI缓存机制  为0或者不存在时表示即时删除  大于0表示缓存时间  小于0表示永久存在 无视删除机制
        UIConst.CacheDefaultTime = 0
        UIConst.CacheMaxNumber = 30
        UIConst.CacheConfig = {
            ["UIHero"] = 240, ---新英雄界面
            -- ["UIHeroCanvas"] = 240, ---旧英雄界面
            --["UITask"] = 240,
            ["UIMap"] = 240,
            ["UIActivityPanel"] = 240,
            ["UIRecruit"] = 240,
            ["UIActivityMall"] = 240,
            -- ["UIMainBag"] = 240,
            ["UIMain"] = 240,
            ["UISoulStoneRecruit"] = 240,
            -- ["UIHeroUpStarCanvas"] = 240, ---旧升星界面
            ["UIHeroStarUp"] = 240, ---新升星界面
            --["UIHeroDataSell"] = 240,
            --["UIChat"] = 240,
            ["UIMonument"] = 240,

            
            --["UIMainCity"] = 240,
            --["UIActivityPanelNew"] = 240,
            --["battleDragHeroDlg"] = 240,--缓存后导致自身战斗数据不更新
            -- ["UIMainTaskPage"] = 240,
            --["UIMail"] = 240,
            -- ["heroMainDlg"]     = 30, -- 因为out动画会设置alpha但是in动画不会设置，所以在UI修改动画之前先不优化这个
            ["UIFormationView"] = 240,
        }
    end
end

-- 状态回调 onStateEnter onStateExit
function UIManager.stateEnter(preStateName, stateName)
    print("UIManager state enter ", stateName, " from ", preStateName)
end

function UIManager.stateExit(stateName, nextStateName)
    print("UIManager state exit ", stateName, " to ", nextStateName)
    self.clearRejectGroup()
    --处理子状态离开跳转新状态的逻辑--此处会做子状态跳转至大状态的情况
    local curState = GameFsm.getState(stateName)
    if curState and curState.fsm and curState.fsm.mCurState then
        UIManager.stateExit(curState.fsm.mCurState, nextStateName)
    end
    --处理界面跳转逻辑
    for uiName, uiObj in pairs(self._uiObjs) do
        --状态切换销毁除常驻界面之外的其它界面
        if uiObj ~= nil and nextStateName ~= nil and self._uiResident[uiName] == nil then
            uiObj:setVisible(false, false, true)
            self.delUI(uiName, true)
        end
    end
end

-- 销毁所有UI
function UIManager.delAllUI()
    for uiName, ui in pairs(self._uiObjs) do
        self._uiObjs[uiName] = nil
        ui:destroy()
    end
end

function UIManager.delUI(uiName)
    local uiCacheTime = UIManager.getUICacheTime(uiName)
    -- print("====delUI===",uiName, uiCacheTime ,self._uiCacheNumber, self._uiCacheDelDict[uiName]);
    -- UI缓存机制  为0或者不存在时表示即时删除  大于0表示缓存时间  小于0表示永久存在 无视删除机制

    if uiCacheTime > 0  then
        if not self._uiCacheDelDict[uiName] then
            self._uiCacheNumber = self._uiCacheNumber + 1
        end
        self._uiCacheDelDict[uiName] = Time.time + uiCacheTime
        local ui = self._uiObjs[uiName]
        if ui then
            ui:inCache()
        end
    else
        UIManager._realDelUI(uiName)
    end
end

function UIManager._realDelUI(uiName)
    local ui = self._uiObjs[uiName]
    if ui then
        --UIEventManager:Get():UnRegisterEvent(uiName)
        Blackboard.UIEvent.UnRegisterEvent(uiName)
        self._uiObjs[uiName] = nil
        ui:destroy()
        UIManager.ReleaseAdvancePrefab(uiName)
    end
end

--互斥逻辑不做界面销毁
function UIManager.visibleReject(uiObj)
    if self._flagReject or uiObj.mUIGroup == nil then
        --互斥处理中or无层次信息
        -- if uiObj.mUIData.shut_down_cam then         -- loading界面结束时需要重新check camera
        --     self.setMainCam( )
        -- end
        if uiObj.mUIData.shut_down_cam or uiObj.mUIData.need_hdr then
            self.onUIShowChanged()
        end
        return
    end
    local needShowMain = nil      -- 有些时候  需要恢复某些状态的主界面
    local defaultName = self._getStateDefaultCanvas()
    local show = not uiObj:getHide() and uiObj:getVisible()
    local uiGroupShowStack = self._uiRejectGroups[uiObj.mUIGroup] or list:new()
    self._flagReject = true
    local nowName = uiGroupShowStack:tail() --当前显示的界面
    local curName = uiObj.mUIName           --当前处理的界面
    -- 互斥链表
    print(string.format("当前显示:[%s],需要处理[%s],界面操作:[%s],互斥分组:[%s],互斥链表:[%s]",
            nowName, curName,
            show and "show" or "hide",
            uiObj.mUIGroup,
            uiGroupShowStack:tostring()))
    if show then
        if nowName ~= curName then
            --显示队列从后往前，找到则清除之前
            local iter = uiGroupShowStack:findlast(curName)
            if iter then
                local _ --返回前一节点的值 此逻辑上无用
                while iter ~= nil do
                    local uiName = iter.value
                    if uiName == defaultName then
                        break
                    end
                    if uiName ~= curName then
                        self.getUI(uiName, false, false)
                    end
                    uiGroupShowStack:remove(iter)
                    iter, _ = uiGroupShowStack:prev(iter)
                end
            end
            --隐藏当前
            if nowName then
                self.getUI(nowName):setHide(true)
            end
            --显示的加入队列
            uiGroupShowStack:push(curName)
        end
    else
        if nowName == curName then
            --删除显示着的界面
            uiGroupShowStack:pop()
            --将前一界面显示
            local preName = uiGroupShowStack:tail()
            if preName then
                self.getUI(preName):setHide(false, true)
            elseif nowName ~= defaultName and uiObj.mUIGroup == GROUP_MAIN then
                needShowMain = defaultName
            end
        else
            --隐藏非队尾界面
            --显示队列从后往前，找到则清除之前
            local iter = uiGroupShowStack:findlast(curName)
            local iterV
            if iter then
                while iter ~= nil do
                    local uiName = iter.value
                    if uiName ~= curName then
                        self.getUI(uiName, false, false)
                    end
                    uiGroupShowStack:remove(iter)
                    iter, iterV = uiGroupShowStack:prev(iter)
                end
            end
        end
    end
    -- 互斥链表
    print(string.format("互斥链表:[%s]", uiGroupShowStack:tostring()))
    self.onUIShowChanged()
    self._uiRejectGroups[uiObj.mUIGroup] = uiGroupShowStack
    self._flagReject = false
    if needShowMain then
        self.getUI(needShowMain, true)
    end
end



function UIManager.reconnectRefresh()
    -- 断线重连销毁所有界面并重新开启默认界面
    self.reloadDefaultCanvas()
end



-- 关闭状态下所有的界面并打开默认的界面
function UIManager.delRejectGroups()
    self._uiRejectGroups = {}
    for uiName, uiObj in pairs(self._uiObjs) do
        if uiObj.mUIGroup or uiObj.mUIData.with_state_close then
            uiObj:setVisible(false, false, true)
            self.delUI(uiName)
        end
    end
    self._uiBlockList = {}
    self._updateBlock()
    self.onUIShowChanged()
end

function UIManager.reloadDefaultCanvas()
    self.delRejectGroups()
    self.openDefaultCanvas()
end

-- 默认的界面
function UIManager._getStateDefaultCanvas()
    local defaultName = nil
    if false then


    elseif GameFsm.InterfaceIsInState(Const.STATE_MAIN) then
        defaultName = "UIMain"
    end
    return defaultName
end

-- 打开默认的界面
function UIManager.openDefaultCanvas(triggerUI)
    local defaultName = self._getStateDefaultCanvas()
    if defaultName and defaultName ~= triggerUI then
        local ui = self.getUI(defaultName, nil, false)
        if not (ui and ui:isInShow()) then
            UIManager.getUI(defaultName, true)
        end
    end
end

-- 当前是否在看状态的默认界面
function UIManager.isInDefaultCanvas()
    local defaultName = self._getStateDefaultCanvas()
    local ui = self.getUI(defaultName, nil, false)
    return ui and ui:isInShow()
end

--tgtobj为空时会清空所有的互斥界面链【慎用】
function UIManager.clearRejectGroup(tgtObj)
    self._flagReject = true
    if tgtObj == nil then
        for uiName, uiObj in pairs(self._uiObjs) do
            if uiObj.mUIGroup then
                self.clearRejectGroup(uiObj)
            end
        end
        self.onUIShowChanged()
    elseif tgtObj.mUIGroup then
        local uiGroupShowStack = self._uiRejectGroups[tgtObj.mUIGroup]
        if uiGroupShowStack then
            while uiGroupShowStack:head() do
                self.getUI(uiGroupShowStack:shift(), false, false)
            end
        end
    else
        tgtObj:setVisible(false)
    end
    self._flagReject = false
end

--显示通用WindowUI用黑色底图
function UIManager.showBlock(uiObj)
    if uiObj.mUIData == nil or uiObj.mUIData.ui_block == nil then
        return
    end
    for _, info in pairs(self._uiBlockList) do
        if info.name == uiObj.mUIName then
            return
        end
    end
    local canClose = uiObj.mUIData.ui_block == 1
    local bgAlpha = uiObj.mUIData.block_alpha or 1
    local pauseDelay = uiObj.mUIData.block_pause_delay      -- Blur 的 pauseDelay
    --按序插入对应界面
    local curOrder = uiObj:getOrder() or 0
    local newInfo = { name = uiObj.mUIName, funcV = uiObj.oriSetVisible or uiObj.setVisible, funcH = uiObj.oriSetHide or uiObj.setHide,
                      close = canClose, alpha = bgAlpha, hide = false, pauseDelay = pauseDelay,hideBlack = uiObj.mUIData.hideBlack, }
    local index = nil
    for i, info in ipairs(self._uiBlockList) do
        -- _uiBlockList中按order的顺序储存,目前方案是order大的放在后面
        -- 使用>保证，同层的界面，后来的放在后面
        local ui = self.getUI(info.name, nil, false)
        if ui and ui:getOrder() > curOrder then
            table.insert(self._uiBlockList, i, newInfo)
            index = i
            break
        end
    end
    if index == nil then
        table.insert(self._uiBlockList, newInfo)
    end
    --调整目标界面显隐函数
    local function setVisible(ui, v, ...)
        if not v then
            UIManager.clearBlock(ui, ...)
        else
            uiObj.oriSetVisible(uiObj, true, ...)
        end
    end
    if not uiObj.oriSetVisible then
        uiObj.oriSetVisible = uiObj.setVisible
    end
    uiObj.setVisible = setVisible
    --调整目标界面隐藏函数
    local function setHide(ui, v, ...)
        UIManager.hideBlock(ui, v, ...)
    end
    if not uiObj.oriSetHide then
        uiObj.oriSetHide = uiObj.setHide
    end
    uiObj.setHide = setHide
    --更新block
    self._updateBlock()
end

function UIManager._updateBlock()
    local blockBox = self.getUI(UIName.UIBlockCanvas)
    -- 取出order最大的值来显示
    local nextInfo
    for i = #self._uiBlockList, 1, -1 do
        nextInfo = self._uiBlockList[i]
        if nextInfo and nextInfo.hide then
            nextInfo = nil
        end
        if nextInfo then
            break
        end
    end
    if nextInfo ~= nil then
        blockBox:show(nextInfo)
    else
        blockBox:hide()
    end
end

function UIManager.hideBlock(uiObj, isHide, ...)
    if #self._uiBlockList == 0 or uiObj == nil then
        return
    end
    for i, info in ipairs(self._uiBlockList) do
        if info.name == uiObj.mUIName then
            self._uiBlockList[i].hide = isHide
            self._uiBlockList[i].funcH(uiObj, isHide, ...)
            break
        end
    end
    --更新block
    self._updateBlock()
end

function UIManager.clearBlock(uiObj, ...)
    if #self._uiBlockList == 0 then
        return
    end
    --处理指定ui的block信息，默认最上层
    local index = #self._uiBlockList
    local tgtInfo = nil
    if uiObj ~= nil then
        for i, info in ipairs(self._uiBlockList) do
            if info.name == uiObj.mUIName then
                index = i
                break
            end
        end
        tgtInfo = self._uiBlockList[index]
    else
        tgtInfo = self._uiBlockList[index]
        uiObj = self.getUI(tgtInfo.name)
    end
    table.remove(self._uiBlockList, index)
    uiObj.setVisible = tgtInfo.funcV
    uiObj:setVisible(false, ...)
    --更新block
    self._updateBlock()
end

-- 确认框
function UIManager.showConfirm(confirmType, ...)
    log('[showConfirm]已过时，使用[showConfirmWithId]代替')
    return UIJump.ToOpenConfirmBoxShowType(confirmType, ...)
end

function UIManager.showConfirmWithId(confirmId, cbYes, cbNo, cbOther, costInfo, contentParams, str_)
    if Const.CACHED_ATTENTION_RECORD_TABLE and Const.CACHED_ATTENTION_RECORD_TABLE[confirmId] then
        cbYes()
    else
        return UIJump.ToOpenConfirmBoxWithId(confirmId, cbYes, cbNo, cbOther, costInfo, contentParams, str_)
    end
end





function UIManager.setCamHDR()
    if GameSettings.isLowQuality() then
        -- 2D相机的HDR也跟随画质一致
        return
    end
    local useHdr = false
    for uiName, uiObj in pairs(self._uiObjs) do
        useHdr = uiObj:need2DHDR()
        if useHdr then
            break
        end
    end
    CameraModeManager.set2DHDR(useHdr)
end


-- 根据configName直接调用
function UIManager.playTalkDialog(configName, finishCB)
    print('paly talk dialog:'..configName)
    local UIName = "UITalkDialog"
    local tmp = UIManager.getUI(UIName, nil,false)
    if tmp then
        print('talk dialog is playing')
        return
    end
    local dialogUI = UIManager.getUI(UIName, true)
    dialogUI:StartTalkDialog(configName, finishCB)
end


function UIManager.playAVG(sectionID, pageID, finishCB, isNewbie, extraDelay)

    --if ResTalkCarousel[sectionID] then
    --    UIManager._playCarouselAVG(sectionID, finishCB)
    --    return
    --end

    UIManager.playSingleAVG(sectionID, pageID, finishCB, isNewbie, extraDelay)

end



function UIManager.playSingleAVG(sectionID, pageID, finishCB, isNewbie, extraDelay)



    UIManager._realPlayAVG(sectionID, pageID, finishCB, isNewbie, extraDelay)
end

function UIManager._realPlayAVG(sectionID, pageID, finishCB, isNewbie, extraDelay)
    -- 开始播放avg时上传glog 参数为段落名
    --if CurAvatar then
    --    CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_START_AVG, sectionID)
    --end


    UIManager.lastAvgIsNewbie = isNewbie


    logerror("不包含avg：", sectionID)
    if finishCB then
        finishCB()
    end
    do
        return
    end
    -- 普通AVG


end



-- 当前显示的UI对象发生改变时，需要触发的检查
-- 可能一帧触发多次
function UIManager.onUIShowChanged()
    UIManager.setCamHDR()
end

----------------- 检查UI缓存机制
function UIManager.onUICacheCheck()
    self._uiCacheNumber = 0
    for uiName, delTime in pairs(self._uiCacheDelDict) do
        local ui = self._uiObjs[uiName]
        if ui then
            if Time.time >= delTime and not ui:getVisible() then
                ui:destroy()
                self._uiObjs[uiName] = nil
                self._uiCacheDelDict[uiName] = nil
                --UIEventManager:Get():UnRegisterEvent(uiName)
                Blackboard.UIEvent.UnRegisterEvent(uiName)
            else
                self._uiCacheNumber = self._uiCacheNumber + 1
            end
        else
            self._uiCacheDelDict[uiName] = nil
        end
    end
end

function UIManager.ClearUICache()
    self._uiCacheNumber = 0
    for uiName, delTime in pairs(self._uiCacheDelDict) do
        local ui = self._uiObjs[uiName]
        if ui then
            --if not ui:getVisible() then
            ui:destroy()
            self._uiObjs[uiName] = nil
            self._uiCacheDelDict[uiName] = nil
            --UIEventManager:Get():UnRegisterEvent(uiName)
            Blackboard.UIEvent.UnRegisterEvent(uiName)
            -- else
            --     self._uiCacheNumber = self._uiCacheNumber + 1
            -- end
        else
            self._uiCacheDelDict[uiName] = nil
        end
    end
end


function UIManager.getUICacheTime(uiName)
    if UIConst.CacheConfig[uiName] and (self._uiCacheNumber < UIConst.CacheMaxNumber or self._uiCacheDelDict[uiName] or UIConst.CacheConfig[uiName] < 0) then
        return UIConst.CacheConfig[uiName]
    end
    return UIConst.CacheDefaultTime
end

local CACHE_CHECK_TIME = 30
UIManager.cacheTimer = Timer.New(UIManager.onUICacheCheck, CACHE_CHECK_TIME, -1)
UIManager.cacheTimer:Start()

------------------Emulator的相关设置
-- 针对模拟器做的一些修改
function UIManager.emulatorAdjust()
    if not DeviceHelper.isAndroid() then
        return
    end
    if NativeHelper.preCheckEmulator(UIManager._onEmulatorChecked) then
        UIManager._onEmulatorChecked()
    end
end

function UIManager._onEmulatorChecked(...)
    local isEmulator
    if VersionUtils.hasAbilityEmulatorCheck() then
        isEmulator = NativeHelper.isEmulator()
    else
        local LuaToolkit = Framework.Tools.LuaToolkit
        isEmulator = not LuaToolkit.Is64Bit()   -- 旧的判定条件
    end

    if isEmulator then
        -- 据此判断是模拟器
        local model = string.lower(DeviceHelper.deviceModel)
        if string.find(model, "mumu") then
            -- mumu模拟器

        else
            -- 其他
            -- 在蓝叠模拟器上发现登录界面开了2D相机的HDR后角色部分会有一大堆黑掉，而其他界面就没这个问题
            -- 猜测因为登录界面使用了HDR但是没加Tonemapping，导致蓝叠等模拟器出现兼容问题
            -- 特殊处理一下，关闭登录界面的2D HDR
            DataTable.ResUIMap['login']['need_hdr'] = nil
            --local loginDlg = UIManager.getUI("login", nil, false)
            --if loginDlg then
            --    -- 如果login界面已经显示出来
            --    UIManager.setCamHDR()
            --end
        end
    end
end




local _advanceCfg = {
    ----"System/Hero_new/UIHeroCanvas",
    --"System/BattleDragon/UIBattleDragonCanvas",
    --"System/Recruit/UIRecruit",
    --"System/MainMenu/UIMall",
    --"System/Friends/UIFriends",
    --"System/Activity/UIMainTaskPage",
    ----"System/TeamSet/TeamSetMainCanvas",
    --"System/BattleLevel/UIMap",
    --"System/Maincity/UIMainCity",
    --"System/Bag/UIMainBag",
    ----"System/Hero/UIHeroSellPreview",
    ----"System/Hero_new/UIHeroUpStarCanvas",
    --"System/HolyMountain/UIMonument",
    --"system/Task/UITask",
    --"System/Chat/UIChat",
    --"System/Activity/ActivityNew/UIActivityPanelNew",
    --"system/uimail/uimail",
}
local _advanceLoader = {}
local _advancePrefab = {}

function UIManager.AdvanceLoad(callBack)
    for i = 1, #_advanceCfg do
        --local key = _advanceCfg[i]
        --local path = "ui/"..key..".prefab"
        --local  func4Load  = Functor(self.onLoaderComplete, self, key)
        --local loader = Framework.Resource.LoaderFactory.LoadObject(path, Framework.Resource.LoaderMode.Async, func4Load)
        --_advanceLoader[key] = loader
    end
end

function UIManager:onLoaderComplete(pathStr)
    local url = pathStr
    local obj = _advanceLoader[url]:GetClone()
    _advancePrefab[url] = obj
    obj:SetActive(false)
end

function UIManager.GetAdvanceLoaderPrefab(resName)
    return _advancePrefab[resName]
end

function UIManager.ReleaseAdvancePrefab(uiName)
    local uiData = DataTable.ResUIMap[uiName]
    if uiData then
        local key = uiData.prefab
        local obj = _advancePrefab[key]
        if obj then
            _advancePrefab[key] = nil
            --print("---   释放预加载？")
            Framework.Resource.LoaderFactory.ReleaseLoader(_advanceLoader[key])
            _advanceLoader[key] = nil
        end
    end
end


function UIManager.PlayCloseUIAni(uiName)
    local ui = self._uiObjs[uiName]
    ui:getController():PlayCloseUIAni()
end


function UIManager.init()
    self._uiCacheNumber = 0
    --EventCenter.addEventListener(EventConst.GAME_STATE_LOADED, UIManager.stateEnter)
    EventCenter.addEventListener(EventConst.GAME_STATE_EXIT, UIManager.stateExit)
end

function UIManager.destroy()
    UIManager.delAllUI()
    --EventCenter.removeEventListener(EventConst.GAME_STATE_LOADED, UIManager.stateEnter)
    EventCenter.removeEventListener(EventConst.GAME_STATE_EXIT, UIManager.stateExit)
end

-- 打开UI
function UIManager.InterfaceOpenUI(name) -- UIName
    UIManager.getUI(name, true)
end

-- 关闭UI
function UIManager.InterfaceCloseUI(name)
    UIManager.getUI(name, false)
end

-- 隐藏UI，不是真的关闭UI
function UIManager.InterfaceHideUI(name)
    local ui = UIManager.getUI(name, nil, false)
    if ui then
        LuaCallCs.GameObjectActive(ui:GetGameObject(), false)
    end
end

-- 显示UI，不是打开UI
function UIManager.InterfaceShowUI(name)
    local ui = UIManager.getUI(name, nil, false)
    if ui then
        LuaCallCs.GameObjectActive(ui:GetGameObject(), true)
    end
end

-- 检测UI是否打开
function UIManager.InterfaceIsShow(name)
    local ui = UIManager.getUI(name, nil, false)
    return ui and ui:isInShow()
end

-- 预加载UI
function UIManager.InterfaceAdvanceLoadUI(name)
    UIManager.getUI(name, nil, true)
end

-- 关闭所有UI
function UIManager.InterfaceCloseAll()
    for uiName, ui in pairs(self._uiObjs) do
        UIManager.getUI(uiName, false)
    end
end

-- 在一个UI里按照全路径找一个object
function UIManager.InterfaceFindObjectInWindow(uiName, path)
    local ui = UIManager.getUI(uiName, nil, false)
    if ui then
        return LuaCallCs.GetObjectExactMatch(ui:GetGameObject(), path)
    end
    return nil
end


-- 播放UI对应的背景音乐
function UIManager.InterfacePlayUIMusic(uiName)
    local id = Util.FindUI.UINameToID(uiName)
    if id then
        local cfg = DataTable.ResViewData[id]
        if cfg and cfg.music then
            local isLoop = cfg.loop ~= 1
            EventManager.Global.Dispatch(EventType.AudioSystemPlayMusic, cfg.music, 0.7, isLoop)
        end
    end
end



return UIManager
