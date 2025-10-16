----------------------------------------------
-- A table serialization utility for lua
-- Steve Dekorte, http://www.dekorte.com, Apr 2000
-- Freeware

-- Modify form Pickle.lua by JWH
-- 使用table.concat改进字符串连接的性能。
-- 修改对象实例函数为静态函数。
----------------------------------------------

local TablePickle = {}

-- 注意此处使用全局变量，不支持多线程并行的pickle和unpickle操作
TablePickle._tempTableToRef = nil
TablePickle._tempRefToTable = nil

function TablePickle.pickle(tbl)
    if type(tbl) ~= "table" then
        error(type(tbl) .. " can not be pickled, table only.")
    end
    TablePickle._tempTableToRef = {}
    TablePickle._tempRefToTable = {}
    local saveCount= 0
    TablePickle.ref(tbl)
    local retTbl = {"{"}

    while table.getn(TablePickle._tempRefToTable) > saveCount do
        saveCount = saveCount + 1
        local t = TablePickle._tempRefToTable[saveCount]
        table.insert(retTbl, "{\n")
        for i, v in pairs(t) do
            table.insert(retTbl, "[")

            TablePickle.value(i, retTbl)

            table.insert(retTbl, "]=")
            TablePickle.value(v, retTbl)
            table.insert(retTbl, ",\n")
        end
        table.insert(retTbl, "},\n")
    end

    table.insert(retTbl, "}")
    return table.concat(retTbl)
end

function TablePickle.value(v, retTbl)
    local vtype = type(v)
    if vtype == "string" then
        table.insert(retTbl, string.format("%q", v))
    elseif vtype == "number" then
        table.insert(retTbl, v)
    elseif vtype == "boolean" then
        table.insert(retTbl,tostring(v))
    elseif vtype == "table" then
        table.insert(retTbl, "{")
        table.insert(retTbl, TablePickle.ref(v))
        table.insert(retTbl, "}")
    -- else
        -- error("pickle a "..type(v).." is not supported")
    end
end

function TablePickle.ref(tbl)
    local ref = TablePickle._tempTableToRef[tbl]
    if not ref then
        if tbl == TablePickle then
            error("You should not picke the TablePickle class!")
        end
        table.insert(TablePickle._tempRefToTable, tbl)
        ref = table.getn(TablePickle._tempRefToTable)
        TablePickle._tempTableToRef[tbl] = ref
    end
    return ref
end

function TablePickle.unpickle(s)
    if type(s) ~= "string" then
        error("can't unpickle a "..type(s)..", only strings")
    end
    local gentables = loadstring("return "..s)
    local tables = gentables()

    for tnum = 1, table.getn(tables) do
        local t = tables[tnum]
        local tcopy = {};
        for i, v in pairs(t) do
            tcopy[i] = v
        end
        for i, v in pairs(tcopy) do
            local ni, nv
            if type(i) == "table" then
                ni = tables[i[1]] else ni = i
            end
            if type(v) == "table" then
                nv = tables[v[1]]
            else
                nv = v
            end
            t[i] = nil
            t[ni] = nv
        end
    end
    return tables[1]
end


-----------------------------------单元测试 Start------------------------------
-- local function eq(b)
--   if b then print(" succeeded") else print(" failed") end
-- end

-- local function test()
--     local t = {
--         name = "foo",
--         ssn=123456789,
--         contact = { phone = "555-1\r\n212", email = "foo@foo.com"},
--     }
--     t.t = { 1 }
--     t.contact.loop = t
--     t["a b"] = "zzz"
--     t[10] = 11
--     t[t] = 5
--     t[t.t] = 10

--     local s = TablePickle.pickle(t)
--     print("pickled string:\n\n"..s)

--     local ut = TablePickle.unpickle(s)
--     print("pickled string:\n\n" .. TablePickle.pickle( ut ))
--     print("loop test:   "); eq(ut == ut.contact.loop)
--     print("subitem test:"); eq(ut.contact.phone == t.contact.phone)
--     print("number value:"); eq(ut.ssn == t.ssn)
--     print("number index:"); eq(ut[10] == 11)
--     print("table index: "); eq(ut[ut] == 5)
-- end

-- test()
-----------------------------------单元测试 End------------------------------

return TablePickle