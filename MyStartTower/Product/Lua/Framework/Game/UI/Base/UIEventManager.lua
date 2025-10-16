


--[[

UIEventManager用Blackboard实现，这部分功能废弃


---@class UIEventManager UI事件管理器，这个UIEventManager设计的很简单，不过够用了
UIEventManager = Class("UIEventManager")

function UIEventManager:ctor()
    ---@type UIEventManager
    self._instance = nil


    ---@type table<string, table<UIEventID, string>>
    self._viewDict = {}
end

function UIEventManager:Get()
    if self._instance == nil then
        self._instance = UIEventManager()
    end
    return self._instance
end


function UIEventManager:Init()

end

function UIEventManager:Clear()

end

---@type function ： 注册事件，这里要注意，view取的是UIKey，不是UI对象
---@param view string UIKey，不是UI对象
---@param id UIEventID EventID
---@param evt string 方法名字
function UIEventManager:RegisterEvent(view, id, evt)
    -- 参数View应该是UI对象，不应该是UIKey。
    -- 这里的设计是基于一个View只有一个UI对象的前提，而且通过UIManager.Get()取得的UI认为是可以完全可信的。
    -- 另外，现在Lua侧 UI的生命周期设计的也不合理。
    if view == nil or id == nil or evt == nil then
        return
    end

    if self._viewDict[view] == nil then
        self._viewDict[view] = {}
    end
    if self._viewDict[view][id] == nil then
        self._viewDict[view][id] = evt
    else
        LuaCallCsUtilCommon.LogError("---   UIEventManager重复注册:view = ".. view .. "   id = " .. id .. "   evt = " .. evt)
    end
end

---@param view string UIKey，不是UI对象
function UIEventManager:UnRegisterEvent(view)
    self._viewDict[view] = nil
end


---@param id UIEventID
function UIEventManager:Dispatch(id, ...)
    for k, v in pairs(self._viewDict) do
        if v[id] then
            UIEventManager:Get():SendMessage(k, id, ...)
        end
    end
end

---@param view string UIKey，不是UI对象
---@param id UIEventID EventID
function UIEventManager:SendMessage(view, id, ...)
    if self._viewDict[view] then
        if self._viewDict[view][id] then
            if UIManager.isShowUI(view) then
                local ui = UIManager.tryGetUI(view)
                self._viewDict[view][id](ui, ...)
            end
        end
    end
end


]]--