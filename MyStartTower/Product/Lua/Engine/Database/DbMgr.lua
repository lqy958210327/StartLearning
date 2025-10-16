


-- 数据模块 管理器，叫Db 是因为 Module这个单词已经被人用了
--[[
1.业务层规划的数据统一继承自DbBase，只继承一层，不要继承更多层
2.所有继承自DbBase的数据，有DbMgr统一管理，包括初始化，数据清理，数据获取。
3.业务侧需要做的是：
    a.定义DBId
    b.继承DbBase 定义自己的数据
    c.把自定义数据的 路径添加到DbPath中
    d.通过DbMgr获取数据，对数据进行取值和赋值操作
--]]

---@class DbMgr 模块数据件管理器，各个功能模块的数据部分放在这里统一管理
DbMgr = Class("DbMgr")

function DbMgr:ctor()
    ---@type DbMgr
    self._instance = nil
    ---@type table<number, DbBase>
    self._dbDict = {}
end

function DbMgr:Get()
    if self._instance == nil then
        self._instance = DbMgr()
    end
    return self._instance
end

function DbMgr:InternalInit()

end

---@param db DbBase
function DbMgr:InternalRegisterDb(id, db)
    if self._dbDict[id] then
        LuaCallCsUtilCommon.LogError("---   DB重复注册，id = " .. id)
        return
    end
    self._dbDict[id] = db
    db:InternalInit()
end


---@param id number
---@return DbBase ：返回的是子类，因为注释问题，这里注释返回的是基类
function DbMgr:InternalGetDB(id)
    return self._dbDict[id]
end

function DbMgr:InternalClear()
    for k, v in pairs(self._dbDict) do
        v:InternalClear()
    end
    self._dbDict = {}
end