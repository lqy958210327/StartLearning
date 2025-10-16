-- 战场内黑盒操作输入相关类  定义了操作的类型及参数格式 
-- 由于服务器只负责转发  所以需要pack操作和unpack操作自己对参数进行封装  

local MatrixOp = {}

function MatrixOp.packMatrixOp(opCode, ...)
    return table.concat({...}, ',')
end

function MatrixOp.unpackMatrixOp(opCode, data)
    local t = {}
    for v in string.gmatch(data, "(%d+)") do
        table.insert(t, tonumber(v))
    end
    return t
end

return MatrixOp
