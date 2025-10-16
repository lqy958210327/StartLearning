


---@class GameProgressBase
GameProgressBase = Class("GameProgressBase")

function GameProgressBase:InternalInit()
    self:OnInit()
end

function GameProgressBase:InternalClear()
    self:OnClear()
end

function GameProgressBase:InternalEnter(lastProgress, ...)
    -- 注意：如果是状态机，这里是不应该该加扩展参数的，毕竟这不是个真正的状态机，将就着用吧
    print("---   GameProgress切换 Enter: name = "..self.__class.typeName)
    self:OnEnter(lastProgress, ...)
end

function GameProgressBase:InternalExit()
    -- self.typeName 不建议这么调用这个字段名字,这是底层的class里的字段，这个字段索引不到
    print("---   GameProgress切换 Exit: name = "..self.__class.typeName)
    self:OnExit()
end

function GameProgressBase:OnInit()

end

function GameProgressBase:OnClear()

end

function GameProgressBase:OnEnter(lastProgress, ...)

end

function GameProgressBase:OnExit()

end
