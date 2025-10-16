local Random = {}

-- 新增位运算模块
local bits = {}
function bits.rshift(x, shift)
    x = math.floor(x % 0x100000000)
    return math.floor(x / (2^shift)) % 0x100000000
end

function bits.lshift(x, shift)
    return (math.floor(x) * (2^shift)) % 0x100000000
end

function bits.band(x, y)
    local result = 0
    for i = 0, 31 do
        local mask = 2^i
        if (x % (2*mask) >= mask) and (y % (2*mask) >= mask) then
            result = result + mask
        end
    end
    return result
end

function bits.bxor(x, y)
    local result = 0
    for i = 0, 31 do
        local mask = 2^i
        local x_bit = x % (2*mask) >= mask
        local y_bit = y % (2*mask) >= mask
        if x_bit ~= y_bit then
            result = result + mask
        end
    end
    return result
end

-- 梅森旋转算法参数
local n = 624
local m = 397
local a = 0x9908B0DF
local u = 29
local d = 0xFFFFFFFF
local s = 17
local b = 0x9D2C5680
local t = 37
local c = 0xEFC60000
local l = 18

function Random:random(lower, upper)
    if not self.mt then
        self:init()
    end
    
    if self.index >= n then
        self:twist()
    end
    
    local y = self.mt[self.index]
    y = bits.bxor(y, bits.rshift(y, u))
    y = bits.bxor(y, bits.band(bits.lshift(y, s), b))
    y = bits.bxor(y, bits.band(bits.lshift(y, t), c))
    y = bits.bxor(y, bits.rshift(y, l))
    
    self.index = self.index + 1
    
    -- 生成32位整数
    local num = bits.band(y, 0xFFFFFFFF)
    if lower and upper then
        return lower + (num % (upper - lower + 1))
    end
    return num
end

function Random:init()
    self.mt = {}
    self.mt[1] = bits.band(self.seed, 0xFFFFFFFF)
    for i = 2, n do
        local prev = self.mt[i-1]
        self.mt[i] = bits.band(0x6C078965 * bits.bxor(prev, bits.rshift(prev, 30)) + (i-1), 0xFFFFFFFF)
    end
    self.index = n+1
end

function Random:twist()
    for i = 1, n do
        local x = bits.band(self.mt[i], 0x80000000) + bits.band(self.mt[(i % n)+1], 0x7FFFFFFF)
        self.mt[i] = bits.bxor(self.mt[(i + m - 1) % n + 1], bits.rshift(x, 1))
        if bits.band(x, 1) ~= 0 then
            self.mt[i] = bits.bxor(self.mt[i], a)
        end
    end
    self.index = 1
end

local RandomMt = {__index = Random}
local function newRandom(seed)
    return setmetatable({seed = seed or 100}, RandomMt)
end

return newRandom