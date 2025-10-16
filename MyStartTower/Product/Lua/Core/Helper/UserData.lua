


local strClassName = "UserData"
local UserData = Class(strClassName)

function UserData.saveCommonData(key, value)
    LuaCallCs.PlayerPrefs.SetString(key, value)
end

function UserData.loadCommonData(key)
    return LuaCallCs.PlayerPrefs.GetString(key)
end


return UserData