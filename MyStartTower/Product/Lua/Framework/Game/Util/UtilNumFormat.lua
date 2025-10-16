


-- 数字缩写格式

local tab = {}


local  calculate = function(numStr)
    local  value = tonumber(numStr)

    local int_part = math.floor(value)
    local frac_part = value - int_part

    local newValue = 0
    if frac_part > 0 then
        newValue = string.format("%.1f", value )
    else
        newValue = string.format("%d", value )
    end
    return newValue
end

function tab.ShortNum(value)
    local str = ""
    if value < 0 then
        str = '-'
        value = -value
    end

    if value >= 10000000 then
        value = string.format("%.1f", value/1000000)
        local newValuStr = calculate(value)
        return str..newValuStr.."M"
    elseif value >= 10000 then
        value = string.format("%.1f", value/1000)
        local newValuStr = calculate(value)
        return str..newValuStr.."K"
    else
        return str..math.floor(value)
    end
end

Util.NumFormat = tab
