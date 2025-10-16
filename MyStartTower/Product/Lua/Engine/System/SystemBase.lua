

-- 不开放update接口，防止业务层滥用

---@class SystemBase 系统模块 基类
SystemBase = Class("SystemBase")

function SystemBase:InternalInit()
    self:OnInit()
end

function SystemBase:InternalClear()
    self:OnClear()
end

function SystemBase:InternalGameStart()
    self:OnGameStart()
end

function SystemBase:InternalGameEnd()
    self:OnGameEnd()
end

---@type function ：可以被继承重写，只调用一次，相当于构造函数
function SystemBase:OnInit()

end

---@type function ：可以被继承重写，只调用一次，相当于析构函数
function SystemBase:OnClear()

end

---@type function ：可以被继承重写，登录游戏就会调用一次
function SystemBase:OnGameStart()

end

---@type function ：可以被继承重写，退出游戏就会调用一次
function SystemBase:OnGameEnd()

end