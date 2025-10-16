


---@class DBHelper
DBHelper = {}

DBHelper.Init = function()
    print("---   DBSystem Init!")
    DbMgr:Get():InternalInit()
end

---@param key number
---@param db DbBase
DBHelper.RegisterDB = function(key, db)
    DbMgr:Get():InternalRegisterDb(key, db)
end

DBHelper.Clear = function()
    print("---   DBSystem Clear!")
    DbMgr:Get():InternalClear()
end

DBHelper.GetDB = function(key)
    return DbMgr:Get():InternalGetDB(key)
end