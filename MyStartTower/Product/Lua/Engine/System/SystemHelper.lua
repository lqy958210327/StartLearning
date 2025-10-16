


---@class SystemHelper
SystemHelper = {}

SystemHelper.Init = function()
    print("---   SystemManager Init!")
    SystemMgr:Get():InternalInit()
end

SystemHelper.Clear = function()
    print("---   SystemManager Clear!")
    SystemMgr:Get():InternalClear()
end

SystemHelper.GameStart = function()
    print("---   SystemManager GameStart!")
    SystemMgr:Get():InternalGameStart()
end

SystemHelper.GameEnd = function()
    print("---   SystemManager GameEnd!")
    SystemMgr:Get():InternalGameEnd()
end

---@param key number
---@param system SystemBase
SystemHelper.RegisterSystem = function(key, system)
    SystemMgr:Get():InternalRegisterSystem(key, system)
end


