




---@class SystemMgr 系统模块管理器，所有系统模块放在这里统一管理
SystemMgr = Class("SystemMgr")

function SystemMgr:ctor()
    ---@type SystemMgr
    self._instance = nil
    ---@type table<number, SystemBase>
    self._systemDict = {}
end

function SystemMgr:Get()
    if self._instance == nil then
        self._instance = SystemMgr()
    end
    return self._instance
end

function SystemMgr:InternalInit()

end

function SystemMgr:InternalClear()
    for k, v in pairs(self._systemDict) do
        v:InternalClear()
    end
    self._systemDict = {}
end

---@param system SystemBase
function SystemMgr:InternalRegisterSystem(id, system)
    assert(type(id) == "number", "---   注册 SystemMgr 异常, id类型必须是number")
    assert(type(system) == "table", "---   注册 SystemMgr 异常, system类型必继承SystemBase")
    assert(system.InternalInit ~= nil and system.InternalClear ~= nil and system.InternalGameEnd ~= nil and system.InternalGameStart ~= nil,
            "---   注册 SystemMgr 异常, system类型必继承SystemBase")--lua语言的特殊性，没法精准限制类型

    if self._systemDict[id] then
        print("---   SystemMgr重复注册，id = " .. id)
        return
    end
    self._systemDict[id] = system
    system:InternalInit()
end

function SystemMgr:InternalGameStart()
    for k, v in pairs(self._systemDict) do
        v:InternalGameStart()
    end
end

function SystemMgr:InternalGameEnd()
    for k, v in pairs(self._systemDict) do
        v:InternalGameEnd()
    end
end


