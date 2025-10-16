

---@class DbBase 模块数据件基类
DbBase = Class("DbBase")

function DbBase:ctor()

end

function DbBase:InternalInit()
    self:OnInit()
end

function DbBase:InternalClear()
    self:OnClear()
end

---@type function ：可以被继承重写，登录游戏就会调用一次
function DbBase:OnInit()

end

---@type function ：可以被继承重写，登出游戏就会调用一次
function DbBase:OnClear()

end