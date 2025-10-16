-- 空的类型填写  以便使主城的属性计算能使用战场的自动计算

-- @author ZH
-- @date 2017-04-13

--------------------------------------------------------------状态管理类---------------------------------------------------------------------------
local strClassName = "EmptyProp"
local EmptyProp = Class(strClassName)

-- 构造函数。
function EmptyProp:ctor(master)
    self.master = master
end

function EmptyProp:getProp( propName, defaultValue ) 
    if self.props then
        return self.props[propName] or defaultValue
    else
        return defaultValue
    end
end

return EmptyProp

