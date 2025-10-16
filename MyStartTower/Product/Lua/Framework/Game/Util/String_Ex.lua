
local  function IsNilOrEmpty(str)
    return str == nil or string.len(str) == 0
end

string.IsNilOrEmpty = IsNilOrEmpty