


---@class BbHelper
BbHelper = {}

BbHelper.Init = function()
    print("---   Blackboard system init!")
    BbMgr:Get():Init()
end

BbHelper.Clear = function()
    print("---   Blackboard system Clear!")
    BbMgr:Get():Clear()
end

---@return BbBase
BbHelper.GetBB = function(bbKey) return BbMgr:Get():GetBB(bbKey) end
---@return boolean
BbHelper.ExistBB = function(bbKey) return BbMgr:Get():GetBB(bbKey) ~= nil end

BbHelper.RegisterBB = function(bbKey)
    assert(type(bbKey) == "number", "---   bbKey 必须是number类型")
    if BbHelper.ExistBB(bbKey) then
        print("---   重复注册黑板， bbKey = "..bbKey)
        return nil
    end
    local bb = BbBase()
    BbMgr:Get():RegisterBB(bbKey, bb)
    return bb
end

---@param bbKey number key，业务侧自己定义，number类型的
---@param bb BbBase 自定义的黑板
---@return BbBase
BbHelper.RegisterCustomBB = function(bbKey, bb)
    assert(type(bbKey) == "number", "---   bbKey 必须是number类型")
    assert(bb ~= nil, "---   注册自定义黑板异常，bb = nil，检查代码格式")
    if BbHelper.ExistBB(bbKey) then
        print("---   重复注册黑板， bbKey = "..bbKey)
        return nil
    end
    BbMgr:Get():RegisterBB(bbKey, bb)
    return bb
end

---@return BBItemBase
BbHelper.GetBBItem = function(bbKey, itemKey)
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb then
        return bb:InternalGetItem(itemKey)
    end
    return nil
end

---@return boolean
BbHelper.ExistBBItem = function(bbKey, itemKey)
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb then
        return bb:InternalExistItem(itemKey)
    end
    return false
end

BbHelper.RemoveBBItem = function(bbKey, itemKey)
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb then
        bb:InternalRemoveItem(itemKey)
    end
end

---@type fun(bbKey:number, itemKey:number, value:boolean):BBItemBool ：向黑板中添加标准bool类型的item
BbHelper.AddBoolItem = function(bbKey, itemKey, value)
    assert(type(bbKey) == "number", "---   bbKey类型必须是number")
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    assert(type(value) == "boolean", "---   boolItem的默认值类型必须是boolean, bbKey = "..bbKey.."  itemKey = "..itemKey)
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb and (not bb:InternalExistItem(itemKey)) then
        local item = BBItemBool()
        bb:InternalAddItem(itemKey, item)
        item:InternalInitValue(value)
        return item
    end
    assert(false, "---   添加BBItem异常，Blackboard为nil，或者重复添加BBItem")
end

---@type fun(bbKey:number, itemKey:number, value:number):BBItemNumber ：向黑板中添加标准number类型的item
BbHelper.AddNumberItem = function(bbKey, itemKey, value)
    assert(type(bbKey) == "number", "---   bbKey类型必须是number")
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    assert(type(value) == "number", "---   numberItem的默认值类型必须是number, bbKey = "..bbKey.."  itemKey = "..itemKey)
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb and (not bb:InternalExistItem(itemKey)) then
        local item = BBItemNumber()
        bb:InternalAddItem(itemKey, item)
        item:InternalInitValue(value)
        return item
    end
    assert(false, "---   添加BBItem异常，Blackboard为nil，或者重复添加BBItem")
end

---@type fun(bbKey:number, itemKey:number, value:string):BBItemString ：向黑板中添加标准string类型的item
BbHelper.AddStringItem = function(bbKey, itemKey, value)
    assert(type(bbKey) == "number", "---   bbKey类型必须是number")
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    assert(type(value) == "string", "---   stringItem的默认值类型必须是string, bbKey = "..bbKey.."  itemKey = "..itemKey)
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb and (not bb:InternalExistItem(itemKey)) then
        local item = BBItemString()
        bb:InternalAddItem(itemKey, item)
        item:InternalInitValue(value)
        return item
    end
    assert(false, "---   添加BBItem异常，Blackboard为nil，或者重复添加BBItem")
end

---@type fun(bbKey:number, itemKey:number, value:table):BBItemTable ：向黑板中添加标准table类型的item
BbHelper.AddTableItem = function(bbKey, itemKey, value)
    assert(type(bbKey) == "number", "---   bbKey类型必须是number")
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    if value then
        assert(type(value) == "table", "---   tableItem的默认值类型必须是table, bbKey = "..bbKey.."  itemKey = "..itemKey)
    end
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb and (not bb:InternalExistItem(itemKey)) then
        local item = BBItemTable()
        bb:InternalAddItem(itemKey, item)
        item:InternalInitValue(value)
        return item
    end
    assert(false, "---   添加BBItem异常，Blackboard为nil，或者重复添加BBItem")
end

---@type fun(bbKey:number, itemKey:number):BBItemNumberRank ：向黑板中添加number排行类型的item
BbHelper.AddNumberRankItem = function(bbKey, itemKey)
    assert(type(bbKey) == "number", "---   bbKey类型必须是number")
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb and (not bb:InternalExistItem(itemKey)) then
        local item = BBItemNumberRank()
        bb:InternalAddItem(itemKey, item)
        return item
    end
    assert(false, "---   添加BBItem异常，Blackboard为nil，或者重复添加BBItem")
end

---@type fun(bbKey:number, itemKey:number):BBItemDict ：向黑板中添加字典类型的item
BbHelper.AddDictItem = function(bbKey, itemKey)
    assert(type(bbKey) == "number", "---   bbKey类型必须是number")
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb and (not bb:InternalExistItem(itemKey)) then
        local item = BBItemDict()
        bb:InternalAddItem(itemKey, item)
        return item
    end
    assert(false, "---   添加BBItem异常，Blackboard为nil，或者重复添加BBItem")
end

---@type fun(bbKey:number, itemKey:number, value:userdata):BBItemUserdata ：向黑板中添加标准userdata类型的item
BbHelper.AddUserdataItem = function(bbKey, itemKey, value)
    assert(type(bbKey) == "number", "---   bbKey类型必须是number")
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    if value then
        assert(type(value) == "userdata", "---   BBItemUserdata的默认值类型必须是userdata, bbKey = "..bbKey.."  itemKey = "..itemKey)
    end
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb and (not bb:InternalExistItem(itemKey)) then
        local item = BBItemUserdata()
        bb:InternalAddItem(itemKey, item)
        item:InternalInitValue(value)
        return item
    end
    assert(false, "---   添加BBItem异常，Blackboard为nil，或者重复添加BBItem")
end

---@type fun(bbKey:number, itemKey:number, item:BBItemBase):BBItemBase ：向黑板中添加自定义类型的item
BbHelper.AddCustomItem = function(bbKey, itemKey, item)
    assert(type(bbKey) == "number", "---   bbKey类型必须是number")
    assert(type(itemKey) == "number", "---   itemKey类型必须是number")
    assert(item ~= nil, "---   AddCustomItem异常：item = nil")
    assert(item.InternalInit ~= nil and item.InternalClear ~= nil, "---   AddCustomItem异常：item 没有继承 BBItemBase")--lua语言的特殊性，没法精准限制类型
    local bb = BbMgr:Get():GetBB(bbKey)
    if bb and (not bb:InternalExistItem(itemKey)) then
        bb:InternalAddItem(itemKey, item)
        return item
    end
    assert(false, "---   添加BBItem异常，Blackboard为nil，或者重复添加BBItem")
end
