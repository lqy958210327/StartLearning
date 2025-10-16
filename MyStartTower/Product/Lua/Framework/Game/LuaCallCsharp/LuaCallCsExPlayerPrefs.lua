


local table = {}


local KeyAddGUID = function(key)
    if key == nil or key == "" then
        local errorKey = "key is nil or empty"
        logerror(errorKey)
        return errorKey
    end
    return key
    --return key.."_"..Util.Account.PlayerUid()
end

function table.HasKey(key)
    return CS_PlayerPrefs.HasKey(KeyAddGUID(key))
end
function table.GetString(key, default)
    default = default or ""
    assert(type(default) == "string", "---   数据类型必须时string，PlayerPrefs.GetString()")
    return CS_PlayerPrefs.GetString(KeyAddGUID(key), default)
end
function table.GetFloat(key, default)
    default = default or 0
    assert(type(default) == "number", "---   数据类型必须时number，PlayerPrefs.GetFloat()")
    return CS_PlayerPrefs.GetFloat(KeyAddGUID(key), default)
end
function table.GetInt(key, default)
    default = default or 0
    assert(type(default) == "number", "---   数据类型必须时number，PlayerPrefs.GetInt()")
    return CS_PlayerPrefs.GetInt(KeyAddGUID(key), default)
end
function table.SetString(key, value)
    assert(type(value) == "string", "---   数据类型必须时number，PlayerPrefs.SetString()")
    CS_PlayerPrefs.SetString(KeyAddGUID(key), value)
end
function table.SetFloat(key, value)
    assert(type(value) == "number", "---   数据类型必须时number，PlayerPrefs.SetFloat()")
    CS_PlayerPrefs.SetFloat(KeyAddGUID(key), value)
end
function table.SetInt(key, value)
    assert(type(value) == "number", "---   数据类型必须时number，PlayerPrefs.SetInt()")
    CS_PlayerPrefs.SetInt(KeyAddGUID(key), value)
end
function table.Save(key, value)
    CS_PlayerPrefs.Save(KeyAddGUID(key), value)
end



LuaCallCs.PlayerPrefs = table