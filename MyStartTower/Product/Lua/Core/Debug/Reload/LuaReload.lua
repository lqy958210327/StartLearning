local LuaReload = {}

function LuaReload.init()
    local LuaReloader = require("Core/Debug/Reload/luahotupdate")
    local luaPath = Framework.Tools.FileUtils.GetLuaPath()
    local isMatch = string.find(luaPath, "/.LuaCode/")
    if isMatch == nil then
        return
    end
    LuaReloader.Init("Debug/Reload/hotupdatelist", {luaPath}) --please replace the second parameter with you src path
    LuaReloader.Update()
    LuaReload.LuaReloader = LuaReloader
end

function LuaReload.ReloadSpecialData( ... )
end

function LuaReload.reload()
    LuaReload.LuaReloader.Update()
    LuaReload.ReloadSpecialData()
end

return LuaReload
