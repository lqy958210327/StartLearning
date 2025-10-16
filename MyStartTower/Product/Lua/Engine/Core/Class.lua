-- 类定义，不支持多重继承

local GLDeclare = require "Core/Framework/Global"

-- 所有定义过的类列表，key为类的类型名称，value为对应的虚表
local __ClassTypeList = { }

-- 类的继承关系数据，用于处理Hotfix等逻辑。
-- 数据形式：key为ClassType，value为继承自它的子类列表。
local __InheritRelationship = {}

-- 用于调试用的，打印所有的继承关系
local print = print
local __classCounter = 0
local function __printSingleClass(cType, depth)
    local prefix = ""
    for i = 1, depth do
        prefix = prefix .. "    "
    end
    __classCounter = __classCounter + 1
    print (prefix, "|---", cType.typeName)
    if __InheritRelationship[cType] and #__InheritRelationship[cType] > 0 then
        for temp, tempType in ipairs(__InheritRelationship[cType]) do
            __printSingleClass(tempType, depth+1)
        end
    end
end

local function __printAllInherits()
    print "display all inherits of class."
    __classCounter = 0
    local noSuperNumber = 0
    for key, value in pairs(__InheritRelationship) do
        if key.superType == nil then
            print "========================================"
            noSuperNumber = noSuperNumber + 1
            __printSingleClass(key, 0)
        end
    end
    print ("The number of class is ", __classCounter, ". The number of class without super class is ", noSuperNumber)

    local count = 0
    for key, value in pairs(__ClassTypeList) do
        count = count +1
    end
    print ("Double check number of class: ", count)
end

if (not IsGLDeclared("PrintAllInherits")) or(not PrintAllInherits) then
    GLDeclare("PrintAllInherits", __printAllInherits)
end

local function __getInheritChildren( classType, output )
    if output[classType] then
        return
    else
        output[classType] = true
        if __InheritRelationship[classType] then
            for index, childType in pairs(__InheritRelationship[classType]) do
                __getInheritChildren(childType, output)
            end
        end
    end
end

local function __HotfixClassFunction(classType, funcName, newFunc)
    local classVtbl = __ClassTypeList[classType]
    if classVtbl and funcName and newFunc then
        local preFunc = classVtbl[funcName]
        classVtbl[funcName] = newFunc
        local children = {}
        __getInheritChildren(classType, children)
        for replaceClass, value in pairs(children) do
            local vtbl = __ClassTypeList[replaceClass]
            if rawget(vtbl, funcName) == preFunc then
                vtbl[funcName] = newFunc
            end
            if replaceClass ~= classType then
                local super = replaceClass.super
                if rawget(super, funcName) == preFunc then
                    super[funcName] = newFunc
                end
            end
        end
    elseif classVtbl == nil and classType and type(classType) == "table" then
        classType[funcName] = newFunc
    end
end

if (not IsGLDeclared("HotfixClassFunction")) or(not HotfixClassFunction) then
    GLDeclare("HotfixClassFunction", __HotfixClassFunction)
end


local function __createSingletonClass(cls, ...)
    if cls._instance == nil then
        cls._instance = cls.new(...)
    end
    return cls._instance
end

local TypeNames = {}

-- 参数含义为：
-- typeName: 字符串形式的类型名称
-- superType: 父类的类型，可以为nil
-- isSingleton: 是否是单例模式的类
local function __Class(typeName, superType, isSingleton)
    -- 该table为类定义对应的表
    local classType = { __IsClass = true }


    -- 类型名称
    classType.typeName = typeName
    if TypeNames[typeName] ~= nil then
        logerror("The class name is used already!!!" .. typeName)
    else
        TypeNames[typeName] = classType
    end

    -- 父类类型
    classType.superType = superType

    -- 在Class身上记录继承关系
    -- Todo：在修改了继承关系的情况下，Reload和Hotfix可能会存在问题
    classType._inheritsCount = 0
    if superType ~= nil then
        local cache = {}
        local counter = 1
        local curClass = superType
        while curClass do
            cache[counter] = curClass
            counter = counter + 1
            curClass = curClass.superType
        end
        classType._classInherits = cache
        classType._inheritsCount = counter
    end

    classType._IsSingleton = isSingleton or false

    -- 记录类的继承关系
    if superType then
        if __InheritRelationship[superType] == nil then
            __InheritRelationship[superType] = {}
        end
        table.insert(__InheritRelationship[superType], classType)
    else
        __InheritRelationship[classType] = {}
    end

    classType.ctor = false
    classType.dtor = false

    local function objToString(self)
        if not self.__instanceName then
            local str = tostring(self)
            local _, _, addr = string.find(str, "table%s*:%s*(0?[xX]?%x+)")
            self.__instanceName =  string.format("Class %s : %s", classType.typeName, addr)
        end

        return self.__instanceName
    end

    local function objGetClass(self)
        return classType
    end

    local function objGetType(self)
        return classType.typeName
    end

    -- 创建对象的方法。
    classType.new = function(...)
        -- 该table为对象对应的表
        local obj = { }

        -- 对象的toString方法，输出结果为类型名称 内存地址。
        obj.toString = objToString

        -- 获取类
        obj.getClass = objGetClass

        -- 获取类型名称的方法。
        obj.getType = objGetType

        -- 调试属性
        obj.__class = classType

        -- 递归的构造过程
        local createObj = function(class, object, ...)
            -- 优化递归过程中的函数调用
            if class.superType ~= nil then
                for i = class._inheritsCount-1, 1, -1 do
                    local curClass = class._classInherits[i]
                    if curClass.ctor then
                        curClass.ctor(object, ...)
                    end
                end
            end

            if class.ctor then
                class.ctor(object, ...)
            end

            -- local create
            -- create = function(c, ...)
            --     -- 先递归构造父类，然后构造自己
            --     if c.superType then
            --         create(c.superType, ...)
            --     end

            --     if c.ctor then
            --         c.ctor(object, ...)
            --     end
            -- end

            -- create(class, ...)
        end

        -- 设置对象表的metatable为虚表的索引内容
        setmetatable(obj, { __index = __ClassTypeList[classType]})

        -- 构造对象
        createObj(classType, obj, ...)
        return obj
    end

    -- 类的toString方法。
    classType.toString = function(self)
        return self.typeName
    end

    if classType._IsSingleton then
        classType.GetInstance = function(...)
            return __createSingletonClass(classType, ...)
        end
    end

    if superType then
        -- 有父类存在时，设置类身上的super属性
        classType.super = setmetatable( { },
        {
            __index = function(tbl, key)
                local func = __ClassTypeList[superType][key]
                if "function" == type(func) then
                    -- 缓存查找结果
                    -- Todo，要考虑reload的影响
                    tbl[key] = func
                    return func
                else
                    error("Accessing super class field are not allowed!")
                end
            end
        } )
    end

    -- 虚表对象。
    local vtbl = { }
    __ClassTypeList[classType] = vtbl

    -- 类的metatable设置，属性写入虚表，
    setmetatable(classType,
    {
        __index = function(tbl, key)
            return vtbl[key]
        end,

        __newindex = function(tbl, key, value)
            vtbl[key] = value
        end,

        -- 让类可以通过调用的方式构造。
        __call = function(self, ...)
            -- 处理单例的模式
            if classType._IsSingleton == true then 
                return __createSingletonClass(classType, ...)
            else
                return classType.new(...)
            end
        end
    } )

    -- 如果有父类存在，则设置虚表的metatable，属性从父类身上取
    -- 注意，此处实现了多层父类递归调用检索的功能，因为取到的父类也是一个修改过metatable的对象。
    if superType then
        setmetatable(vtbl,
        {
            __index = function(tbl, key)
                local ret = __ClassTypeList[superType][key]
                -- Todo 缓存提高了效率，但是要考虑reload时的处理。
                vtbl[key] = ret
                return ret
            end
        } )
    end

    return classType
end

-- 判断一个类是否是另外一个类的子类
local function __isSubClassOf(cls, otherCls)
    return type(otherCls) == "table" and
             type(cls.superType) == "table" and
           ( cls.superType == otherCls or __isSubClassOf(cls.superType, otherCls) )
end

if (not IsGLDeclared("isSubClassOf")) or(not isSubClassOf) then
    GLDeclare("isSubClassOf", __isSubClassOf)
end

-- 判断一个对象是否是一个类的实例（包含子类）
local function __isInstanceOf(obj, cls)
    local objClass = obj:getClass()
    return objClass ~= nil and type(cls) == 'table' and (cls == objClass or __isSubClassOf(objClass, cls) )
end

if (not IsGLDeclared("isInstanceOf")) or(not isInstanceOf) then
    GLDeclare("isInstanceOf", __isInstanceOf)
end

-- 将一个table中所有的属性和方法合并到一个class中，用于处理一个类比较大的设计
-- 注意，合并的方法的reload需要单独处理
local function __MixinClass(cls, mixin, checkMeta)
    assert(type(mixin) == 'table', "mixin must be a table")
    for name, attr in pairs(mixin) do
        if cls[name] == nil then
            cls[name] = attr
        else
            -- 属性名称相同不覆盖而是给出警告。
            print (string.format("[WARNING] The attribute name %s is already in the Class %s!", name, cls:toString()))
        end
    end
    if checkMeta then
        local metaTable = getmetatable(mixin)
        if metaTable and metaTable.__index then
            metaTable = metaTable.__index
            for name, attr in pairs(metaTable) do
                if cls[name] == nil then
                    cls[name] = attr
                end
            end
        end
    end
end

local function __MixinFunc(cls, mixin)
    assert(type(mixin) == 'table', "mixin must be a table")
    for name, _func in pairs(mixin) do
        if cls[name] == nil then
            cls[name] = _func
        else
            local func = cls[name]
            if type(func) == 'function' and type(_func) == 'function' then
                -- 方法循环调用
                -- 1.丢弃返回值
                -- 2.生成包装方法
                cls[name] = function(...)
                    func(...)
                    _func(...)
                end
                print (string.format("[WARNING] The namesake func %s has mixed in the Class %s!", name, cls:toString()))
            end
        end
    end
end

MixinFunc = __MixinFunc

--[[if (not IsGLDeclared("MixinClass")) or(not MixinClass) then
    GLDeclare("MixinClass", __MixinClass)
end]]
MixinClass = __MixinClass

--[[if (not IsGLDeclared("Class")) or(not Class) then
    GLDeclare("Class", __Class)
end]]
Class = __Class

return __Class