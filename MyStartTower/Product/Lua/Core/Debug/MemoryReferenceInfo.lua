--
-- Collect memory reference info.
--
-- @filename  MemoryReferenceInfo.lua
-- @author    WangYaoqi
-- @date      2016-02-03

-- Return methods.
local cPublications = {m_cMethods = {}, m_cHelpers = {}, m_cBases = {}}

local RECORD_TABLE = 1
local RECORD_FUNCTION = 2
local RECORD_USERDATA = 3
local RECORD_THREAD = 4
cPublications.m_cConfig = {[RECORD_TABLE] = 1, [RECORD_FUNCTION] = 1, [RECORD_USERDATA] = 1, [RECORD_THREAD] = 1}

-- Get the format string of date time.
local function FormatDateTimeNow()
	local cDateTime = os.date("*t")
	local strDateTime = string.format("%04d%02d%02d-%02d%02d%02d", tostring(cDateTime.year), tostring(cDateTime.month), tostring(cDateTime.day),
		tostring(cDateTime.hour), tostring(cDateTime.min), tostring(cDateTime.sec))
	return strDateTime
end

-- Get the string result without overrided __tostring.
local function GetOriginalToStringResult(cObject)
	if not cObject then
		return ""
	end

	local cMt = getmetatable(cObject)
	if not cMt then
		return tostring(cObject)
	end

	-- Check tostring override.
	local strName = ""
	local cToString = rawget(cMt, "__tostring")
	if cToString then
		rawset(cMt, "__tostring", nil)
		strName = tostring(cObject)
		rawset(cMt, "__tostring", cToString)
	else
		strName = tostring(cObject)
	end

	return strName
end

-- Create a container to collect the mem ref info results.
local function CreateObjectReferenceInfoContainer()
	-- Create new container.
	local cContainer = {}

	-- Contain [table/function] - [reference count] info.
	local cObjectReferenceCount = {}
	setmetatable(cObjectReferenceCount, {__mode = "k"})

	-- Contain [table/function] - [name] info.
	local cObjectAddressToName = {}
	setmetatable(cObjectAddressToName, {__mode = "k"})

	-- Set members.
	cContainer.m_cObjectReferenceCount = cObjectReferenceCount
	cContainer.m_cObjectAddressToName = cObjectAddressToName
	cContainer.m_cTypeTableContainer = {}
	cContainer.m_cFuncCountContainer = {}
	cContainer.m_cUserdataInfoContainer = {}

	-- For stack info.
	cContainer.m_nStackLevel = -1
	cContainer.m_strShortSrc = "None"
	cContainer.m_nCurrentLine = -1

	return cContainer
end

-- Create a container to collect the mem ref info results from a dumped file.
-- strFilePath - The file path.
local function CreateObjectReferenceInfoContainerFromFile(strFilePath)
	-- Create a empty container.
	local cContainer = CreateObjectReferenceInfoContainer()
	cContainer.m_strShortSrc = strFilePath

	-- Cache ref info.
	local cRefInfo = cContainer.m_cObjectReferenceCount
	local cNameInfo = cContainer.m_cObjectAddressToName

	-- Read each line from file.
	local strHeader = nil
	local strAddr = nil
	local strName = nil
	local strRefCount = nil
	for strLine in io.lines(strFilePath) do
		strHeader = string.sub(strLine, 1, 2)
		if "--" ~= strHeader then
			local _, _, strAddr, strName, strRefCount = string.find(strLine, "(.+)\t(.*)\t(%d+)")
			if strAddr then
				cRefInfo[strAddr] = strRefCount
				cNameInfo[strAddr] = strName
			end
		end
	end

	return cContainer
end

-- Create a container to collect the mem ref info results from a dumped file.
-- strObjectName - The object name you need to collect info.
-- cObject - The object you need to collect info.
local function CreateSingleObjectReferenceInfoContainer(strObjectName, cObject)
	-- Create new container.
	local cContainer = {}

	-- Contain [address] - [true] info.
	local cObjectExistTag = {}
	setmetatable(cObjectExistTag, {__mode = "k"})

	-- Contain [name] - [true] info.
	local cObjectAliasName = {}

	-- Contain [address] - [true] info.
	local cObjectAccessTag = {}
	setmetatable(cObjectAccessTag, {__mode = "k"})

	-- Set members.
	cContainer.m_cObjectExistTag = cObjectExistTag
	cContainer.m_cObjectAliasName = cObjectAliasName
	cContainer.m_cObjectAccessTag = cObjectAccessTag

	-- For stack info.
	cContainer.m_nStackLevel = -1
	cContainer.m_strShortSrc = "None"
	cContainer.m_nCurrentLine = -1

	-- Init with object values.
	cContainer.m_strObjectName = strObjectName
	cContainer.m_strAddressName = GetOriginalToStringResult(cObject)
	cContainer.m_cObjectExistTag[cObject] = true

	return cContainer
end

local function RecordKeyInfo( container, key, objectKey, refStr )
	if not container[key] then
		container[key] = {0}
	end
	if not container[key][objectKey] then
		container[key][objectKey] = {}
		container[key][1] = container[key][1] + 1
	end
	table.insert(container[key][objectKey], refStr)
end
-- Collect memory reference info from a root table or function.
-- strName - The root object name that start to search, default is "_G" if leave this to nil.
-- cObject - The root object that start to search, default is _G if leave this to nil.
-- cDumpInfoContainer - The container of the dump result info.
local testF = 0
local function CollectObjectReferenceInMemory(strName, cObject, cDumpInfoContainer)
	if not cObject then
		return
	end

	if not strName then
		strName = ""
	end

	-- Check container.
	if (not cDumpInfoContainer) then
		cDumpInfoContainer = CreateObjectReferenceInfoContainer()
	end

	-- Check stack.
	if cDumpInfoContainer.m_nStackLevel > 0 then
		local cStackInfo = debug.getinfo(cDumpInfoContainer.m_nStackLevel, "Sl")
		if cStackInfo then
			cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
			cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
		end

		cDumpInfoContainer.m_nStackLevel = -1
	end

	-- Get ref and name info.
	local cRefInfoContainer = cDumpInfoContainer.m_cObjectReferenceCount
	local cNameInfoContainer = cDumpInfoContainer.m_cObjectAddressToName
	local cTypeTableContainer = cDumpInfoContainer.m_cTypeTableContainer
	local cFuncCountInfo = cDumpInfoContainer.m_cFuncCountContainer
	local cUserdataInfo = cDumpInfoContainer.m_cUserdataInfoContainer
	
	local typeName = nil
	local strType = type(cObject)
	if "table" == strType then
		-- Check table with class name.
		if rawget(cObject, "getType") then
			typeName = cObject:getType()
			strName = strName.."["..typeName.."]"
		-- elseif rawget(cObject, "typeName") then
		-- 	if "string" == type(cObject.typeName) then
		-- 		strName = strName .. "[typeName:" .. cObject.typeName .. "]"
		-- 	end
		-- elseif rawget(cObject, "__cname") then
		-- 	if "string" == type(cObject.__cname) then
		-- 		strName = strName .. "[__cname:" .. cObject.__cname .. "]"
		-- 	end
		-- elseif rawget(cObject, "class") then
		-- 	if "string" == type(cObject.class) then
		-- 		strName = strName .. "[class:" .. cObject.class .. "]"
		-- 	end
		-- elseif rawget(cObject, "_className") then
		-- 	if "string" == type(cObject._className) then
		-- 		strName = strName .. "[_className:" .. cObject._className .. "]"
		-- 	end
		end

		-- Check if table is _G.
		if cObject == _G then
			strName = strName .. "[_G]"
		end

		-- Get metatable.
		local bWeakK = false
		local bWeakV = false
		local cMt = getmetatable(cObject)
		if cMt then
			-- Check mode.
			local strMode = rawget(cMt, "__mode")
			if strMode then
				if "k" == strMode then
					bWeakK = true
				elseif "v" == strMode then
					bWeakV = true
				elseif "kv" == strMode then
					bWeakK = true
					bWeakV = true
				end
			end
		end

		if cPublications.m_cConfig[RECORD_TABLE] then
			if typeName then
				RecordKeyInfo(cTypeTableContainer, typeName, cObject, strName)
			end
			-- cRefInfoContainer[cObject] = (cRefInfoContainer[cObject] and (cRefInfoContainer[cObject] + 1)) or 1
		end
		-- 已经记录则返回
		if cNameInfoContainer[cObject] then
			if #strName < #cNameInfoContainer[cObject] then
				cNameInfoContainer[cObject] = strName
			end
			return
		end
		-- 没记录时  对于table的class直接可以记录到名字就可以了  引用上边的TableReference已记录
		if typeName then
			cNameInfoContainer[cObject] = typeName
		else
			cNameInfoContainer[cObject] = strName
		end

		-- Dump table key and value.
		for k, v in pairs(cObject) do
			-- Check key type.
			local strKeyType = type(k)
			if "table" == strKeyType then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName, k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName, v, cDumpInfoContainer)
				end
			elseif "function" == strKeyType then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName, k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName, v, cDumpInfoContainer)
				end
			elseif "thread" == strKeyType then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName, k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName, v, cDumpInfoContainer)
				end
			elseif "userdata" == strKeyType then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName, k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName, v, cDumpInfoContainer)
				end
			else
				CollectObjectReferenceInMemory(strName .. "." .. tostring(k), v, cDumpInfoContainer)
			end
		end

		-- Dump metatable.
		if cMt then
			CollectObjectReferenceInMemory(strName ..".[metatable]", cMt, cDumpInfoContainer)
		end
	elseif "function" == strType then
		-- Get function info.
		local cDInfo = debug.getinfo(cObject, "Su")

		-- Write this info.
		if cPublications.m_cConfig[RECORD_FUNCTION] then
			local keyName = "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"
			RecordKeyInfo(cFuncCountInfo, keyName, cObject, strName)
			-- cRefInfoContainer[cObject] = (cRefInfoContainer[cObject] and (cRefInfoContainer[cObject] + 1)) or 1
		end
		if cNameInfoContainer[cObject] then
			return
		end

		-- Set name.
		strName = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"
		cNameInfoContainer[cObject] = strName
		-- Get upvalues.
		local nUpsNum = cDInfo.nups
		for i = 1, nUpsNum do
			local strUpName, cUpValue = debug.getupvalue(cObject, i)
			local strUpValueType = type(cUpValue)
			--print(strUpName, cUpValue)
			if "table" == strUpValueType then
				CollectObjectReferenceInMemory(strName .. ".[ups:table:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif "function" == strUpValueType then
				CollectObjectReferenceInMemory(strName .. ".[ups:function:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif "thread" == strUpValueType then
				CollectObjectReferenceInMemory(strName .. ".[ups:thread:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif "userdata" == strUpValueType then
				CollectObjectReferenceInMemory(strName .. ".[ups:userdata:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			end
		end

		-- Dump environment table.
		local cEnv = debug.getfenv(cObject)
		if cEnv then
			CollectObjectReferenceInMemory(strName ..".[function:environment]", cEnv, cDumpInfoContainer)
		end
	elseif "thread" == strType then
		-- Add reference and name.
		if cPublications.m_cConfig[RECORD_THREAD] then
			-- cRefInfoContainer[cObject] = (cRefInfoContainer[cObject] and (cRefInfoContainer[cObject] + 1)) or 1
		end
		if cNameInfoContainer[cObject] then
			if #strName < #cNameInfoContainer[cObject] then
				cNameInfoContainer[cObject] = strName
			end
			return
		end

		-- Set name.
		cNameInfoContainer[cObject] = strName

		-- Dump environment table.
		local cEnv = debug.getfenv(cObject)
		if cEnv then
			CollectObjectReferenceInMemory(strName ..".[thread:environment]", cEnv, cDumpInfoContainer)
		end

		-- Dump metatable.
		local cMt = getmetatable(cObject)
		if cMt then
			CollectObjectReferenceInMemory(strName ..".[thread:metatable]", cMt, cDumpInfoContainer)
		end
	elseif "userdata" == strType then
		-- Add reference and name.

		if cPublications.m_cConfig[RECORD_USERDATA] then
			-- cRefInfoContainer[cObject] = (cRefInfoContainer[cObject] and (cRefInfoContainer[cObject] + 1)) or 1
			local cMt = getmetatable(cObject)
			if cMt then
				local name = cMt['.name']
				if name then
					RecordKeyInfo(cUserdataInfo, name, cObject, strName)
				end
			end
		end
		if cNameInfoContainer[cObject] then
			if #strName < #cNameInfoContainer[cObject] then
				cNameInfoContainer[cObject] = strName
			end
			return
		end

		-- Set name.
		cNameInfoContainer[cObject] = strName

		-- Dump environment table.
		local cEnv = debug.getfenv(cObject)
		if cEnv then
			CollectObjectReferenceInMemory(strName ..".[userdata:environment]", cEnv, cDumpInfoContainer)
		end

		-- Dump metatable.
		local cMt = getmetatable(cObject)
		if cMt then
			CollectObjectReferenceInMemory(strName ..".[userdata:metatable]", cMt, cDumpInfoContainer)
		end
	-- else
	-- 	-- For "number", "string" and "boolean".

	-- 	-- Add reference and name.
	-- 	cRefInfoContainer[cObject] = (cRefInfoContainer[cObject] and (cRefInfoContainer[cObject] + 1)) or 1
	-- 	if cNameInfoContainer[cObject] then
	-- 		return
	-- 	end

	-- 	-- Set name.
	-- 	cNameInfoContainer[cObject] = strName .. "[[[[" .. strType .. ":" .. tostring(cObject) .. "]]]]"
	end
end

-- Collect memory reference info of a single object from a root table or function.
-- strName - The root object name that start to search, can not be nil.
-- cObject - The root object that start to search, can not be nil.
-- cDumpInfoContainer - The container of the dump result info.
local function CollectSingleObjectReferenceInMemory(strName, cObject, cDumpInfoContainer)
	if not cObject then
		return
	end

	if not strName then
		strName = ""
	end

	-- Check container.
	if (not cDumpInfoContainer) then
		cDumpInfoContainer = CreateObjectReferenceInfoContainer()
	end

	-- Check stack.
	if cDumpInfoContainer.m_nStackLevel > 0 then
		local cStackInfo = debug.getinfo(cDumpInfoContainer.m_nStackLevel, "Sl")
		if cStackInfo then
			cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
			cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
		end

		cDumpInfoContainer.m_nStackLevel = -1
	end

	local cExistTag = cDumpInfoContainer.m_cObjectExistTag
	local cNameAllAlias = cDumpInfoContainer.m_cObjectAliasName
	local cAccessTag = cDumpInfoContainer.m_cObjectAccessTag
	
	local strType = type(cObject)
	if "table" == strType then
		-- Check table with class name.
		if rawget(cObject, "__cname") then
			if "string" == type(cObject.__cname) then
				strName = strName .. "[class:" .. cObject.__cname .. "]"
			end
		elseif rawget(cObject, "class") then
			if "string" == type(cObject.class) then
				strName = strName .. "[class:" .. cObject.class .. "]"
			end
		elseif rawget(cObject, "_className") then
			if "string" == type(cObject._className) then
				strName = strName .. "[class:" .. cObject._className .. "]"
			end
		end

		-- Check if table is _G.
		if cObject == _G then
			strName = strName .. "[_G]"
		end

		-- Get metatable.
		local bWeakK = false
		local bWeakV = false
		local cMt = getmetatable(cObject)
		if cMt then
			-- Check mode.
			local strMode = rawget(cMt, "__mode")
			if strMode then
				if "k" == strMode then
					bWeakK = true
				elseif "v" == strMode then
					bWeakV = true
				elseif "kv" == strMode then
					bWeakK = true
					bWeakV = true
				end
			end
		end

		-- Check if the specified object.
		if cExistTag[cObject] and (not cNameAllAlias[strName]) then
			cNameAllAlias[strName] = true
		end

		-- Add reference and name.
		if cAccessTag[cObject] then
			return
		end

		-- Get this name.
		cAccessTag[cObject] = true

		-- Dump table key and value.
		for k, v in pairs(cObject) do
			-- Check key type.
			local strKeyType = type(k)
			if "table" == strKeyType then
				if not bWeakK then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:key.table]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif "function" == strKeyType then
				if not bWeakK then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:key.function]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif "thread" == strKeyType then
				if not bWeakK then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:key.thread]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif "userdata" == strKeyType then
				if not bWeakK then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:key.userdata]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			else
				CollectSingleObjectReferenceInMemory(strName .. "." .. k, v, cDumpInfoContainer)
			end
		end

		-- Dump metatable.
		if cMt then
			CollectSingleObjectReferenceInMemory(strName ..".[metatable]", cMt, cDumpInfoContainer)
		end
	elseif "function" == strType then
		-- Get function info.
		local cDInfo = debug.getinfo(cObject, "Su")
		local cCombinedName = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"

		-- Check if the specified object.
		if cExistTag[cObject] and (not cNameAllAlias[cCombinedName]) then
			cNameAllAlias[cCombinedName] = true
		end

		-- Write this info.
		if cAccessTag[cObject] then
			return
		end

		-- Set name.
		cAccessTag[cObject] = true
		strName = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"
		-- Get upvalues.
		local nUpsNum = cDInfo.nups
		for i = 1, nUpsNum do
			local strUpName, cUpValue = debug.getupvalue(cObject, i)
			local strUpValueType = type(cUpValue)
			--print(strUpName, cUpValue)
			if "table" == strUpValueType then
				CollectSingleObjectReferenceInMemory(strName .. ".[ups:table:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif "function" == strUpValueType then
				CollectSingleObjectReferenceInMemory(strName .. ".[ups:function:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif "thread" == strUpValueType then
				CollectSingleObjectReferenceInMemory(strName .. ".[ups:thread:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif "userdata" == strUpValueType then
				CollectSingleObjectReferenceInMemory(strName .. ".[ups:userdata:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			end
		end

		-- Dump environment table.
		local cEnv = debug.getfenv(cObject)
		if cEnv then
			CollectSingleObjectReferenceInMemory(strName ..".[function:environment]", cEnv, cDumpInfoContainer)
		end
	elseif "thread" == strType then
		-- Check if the specified object.
		if cExistTag[cObject] and (not cNameAllAlias[strName]) then
			cNameAllAlias[strName] = true
		end

		-- Add reference and name.
		if cAccessTag[cObject] then
			return
		end

		-- Get this name.
		cAccessTag[cObject] = true

		-- Dump environment table.
		local cEnv = debug.getfenv(cObject)
		if cEnv then
			CollectSingleObjectReferenceInMemory(strName ..".[thread:environment]", cEnv, cDumpInfoContainer)
		end

		-- Dump metatable.
		local cMt = getmetatable(cObject)
		if cMt then
			CollectSingleObjectReferenceInMemory(strName ..".[thread:metatable]", cMt, cDumpInfoContainer)
		end
	elseif "userdata" == strType then
		-- Check if the specified object.
		if cExistTag[cObject] and (not cNameAllAlias[strName]) then
			cNameAllAlias[strName] = true
		end

		-- Add reference and name.
		if cAccessTag[cObject] then
			return
		end

		-- Get this name.
		cAccessTag[cObject] = true

		-- Dump environment table.
		local cEnv = debug.getfenv(cObject)
		if cEnv then
			CollectSingleObjectReferenceInMemory(strName ..".[userdata:environment]", cEnv, cDumpInfoContainer)
		end

		-- Dump metatable.
		local cMt = getmetatable(cObject)
		if cMt then
			CollectSingleObjectReferenceInMemory(strName ..".[userdata:metatable]", cMt, cDumpInfoContainer)
		end
	end
end

local function OutputKeyInfo( cOutputer, keyInfo, keyStr, compareInfo )
	cOutputer("\n\n\n\n")
	cOutputer("-----------------------------------------------------------\n")
	cOutputer("-- "..keyStr.."创建信息 -------------------------------------------\n")
	cOutputer("-----------------------------------------------------------\n")
	for typeName, typeInfo in pairs(keyInfo) do
		local objectCount = typeInfo[1]
		cOutputer("Class:"..typeName.."\t" .."创建".. keyStr .. "次数:"..objectCount.."\t\n")
	end

	cOutputer("\n\n\n\n")
	cOutputer("-- 对象引用详细信息 -------------------------------------------\n")
	for typeName, typeInfo in pairs(keyInfo) do
		local objectCount = typeInfo[1]
		cOutputer("Class:"..typeName.."\t" .. "创建"..keyStr.."次数:"..objectCount.."\t\n")
		for c, infos in pairs(typeInfo) do
			if c ~= 1 then
				cOutputer(keyStr..GetOriginalToStringResult(c).." 引用次数:"..#infos.."\t\n")
				for index, referStr in pairs(infos) do
					cOutputer( "++++++++"..referStr .. "\n")
				end
			end
		end
	end
	print("zh---------------------", keyStr, compareInfo)
	if compareInfo then
		cOutputer("\n\n\n\n")
		cOutputer("-- "..keyStr.."对比信息 -------------------------------------------\n")
		for typeName, typeInfo in pairs(keyInfo) do
			local nowCount = typeInfo[1]
			local preCount = 0
			if compareInfo[typeName] then
				preCount = compareInfo[typeName][1]
			end
			if nowCount > preCount then
				cOutputer(keyStr..":"..typeName.."\t" .. "原"..keyStr.."次数:"..preCount.." 现在"..keyStr.."次数:"..nowCount.." 改变值:"..(nowCount - preCount).."\t\n")
			end
		end
	end
end

-- The base method to dump a mem ref info result into a file.
-- strSavePath - The save path of the file to store the result, must be a directory path, If nil or "" then the result will output to console as print does.
-- strExtraFileName - If you want to add extra info append to the end of the result file, give a string, nothing will do if set to nil or "".
-- nMaxRescords - How many rescords of the results in limit to save in the file or output to the console, -1 will give all the result.
-- strRootObjectName - The header info to show the root object name, can be nil.
-- cRootObject - The header info to show the root object address, can be nil.
-- cDumpInfoResultsBase - The base dumped mem info result, nil means no compare and only output cDumpInfoResults, otherwise to compare with cDumpInfoResults.
-- cDumpInfoResults - The compared dumped mem info result, dump itself only if cDumpInfoResultsBase is nil, otherwise dump compared results with cDumpInfoResultsBase.
local function OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, cDumpInfoResultsBase, cDumpInfoResults, preTableInfo, preFuncInfo, preUserdataInfo)
	-- Check results.
	if not cDumpInfoResults then
		return
	end

	-- Get time format string.
	local strDateTime = FormatDateTimeNow()

	-- Collect memory info.
	local cRefInfoBase = (cDumpInfoResultsBase and cDumpInfoResultsBase.m_cObjectReferenceCount) or nil
	local cNameInfoBase = (cDumpInfoResultsBase and cDumpInfoResultsBase.m_cObjectAddressToName) or nil
	local cRefInfo = cDumpInfoResults.m_cObjectReferenceCount
	local cNameInfo = cDumpInfoResults.m_cObjectAddressToName

	local cTypeTableInfo = cDumpInfoResults.m_cTypeTableContainer
	local cFuncCountInfo = cDumpInfoResults.m_cFuncCountContainer
	local cUserdataInfo = cDumpInfoResults.m_cUserdataInfoContainer

	-- Create a cache result to sort by ref count.
	local cRes = {}
	local nIdx = 0
	for k in pairs(cRefInfo) do
		nIdx = nIdx + 1
		cRes[nIdx] = k
	end

	-- Sort result.
	table.sort(cRes, function (l, r)
		return cRefInfo[l] > cRefInfo[r]
	end)

	-- Save result to file.
	local bOutputFile = strSavePath and (string.len(strSavePath) > 0)
	local cOutputHandle = nil
	local cOutputEntry = print
	
	if bOutputFile then
		-- Check save path affix.
		local strAffix = string.sub(strSavePath, -1)
		if ("/" ~= strAffix) and ("\\" ~= strAffix) then
			strSavePath = strSavePath .. "/"
		end

		-- Combine file name.
		local strFileName = strSavePath .. "LuaMemRefInfo-All"
		if (not strExtraFileName) or (0 == string.len(strExtraFileName)) then
			strFileName = strFileName .. "-[" .. strDateTime .. "].txt"
		else
			strFileName = strFileName .. "-[" .. strDateTime .. "]-[" .. strExtraFileName .. "].txt"
		end

		local cFile = assert(io.open(strFileName, "w"))
		cOutputHandle = cFile
		cOutputEntry = cFile.write
	end

	local cOutputer = function (strContent)
		if cOutputHandle then
			cOutputEntry(cOutputHandle, strContent)
		else
			cOutputEntry(strContent)
		end
	end

	-- Write table header.
	if cDumpInfoResultsBase then
		cOutputer("--------------------------------------------------------\n")
		cOutputer("-- This is compared memory information.\n")

		cOutputer("--------------------------------------------------------\n")
		cOutputer("-- Collect base memory reference at line:" .. tostring(cDumpInfoResultsBase.m_nCurrentLine) .. "@file:" .. cDumpInfoResultsBase.m_strShortSrc .. "\n")
		cOutputer("-- Collect compared memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
	else
		cOutputer("--------------------------------------------------------\n")
		cOutputer("-- Collect memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
	end

	cOutputer("--------------------------------------------------------\n")
	cOutputer("-- [Table/Function Address/Name]\t[Reference Count]\n")
	cOutputer("--------------------------------------------------------\n")

	if strRootObjectName and cRootObject then
		cOutputer("-- From Root Object: " .. GetOriginalToStringResult(cRootObject) .. " (" .. strRootObjectName .. ")\n")
	end

	-- Save each info.
	for i, v in ipairs(cRes) do
		if (not cDumpInfoResultsBase) or (not cRefInfoBase[v]) then
			if (nMaxRescords > 0) then
				if (i <= nMaxRescords) then
					cOutputer(GetOriginalToStringResult(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
				end
			else
				cOutputer(GetOriginalToStringResult(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
			end
		end
	end

	OutputKeyInfo(cOutputer, cTypeTableInfo, "对象", preTableInfo)
	OutputKeyInfo(cOutputer, cFuncCountInfo, "函数", preFuncInfo)
	OutputKeyInfo(cOutputer, cUserdataInfo, "C#对象", preUserdataInfo)

	if bOutputFile then
		io.close(cOutputHandle)
	end
end





-- The base method to dump a mem ref info result of a single object into a file.
-- strSavePath - The save path of the file to store the result, must be a directory path, If nil or "" then the result will output to console as print does.
-- strExtraFileName - If you want to add extra info append to the end of the result file, give a string, nothing will do if set to nil or "".
-- nMaxRescords - How many rescords of the results in limit to save in the file or output to the console, -1 will give all the result.
-- cDumpInfoResults - The dumped results.
local function OutputMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, cDumpInfoResults)
	-- Check results.
	if not cDumpInfoResults then
		return
	end

	-- Get time format string.
	local strDateTime = FormatDateTimeNow()

	-- Collect memory info.
	local cObjectAliasName = cDumpInfoResults.m_cObjectAliasName

	-- Save result to file.
	local bOutputFile = strSavePath and (string.len(strSavePath) > 0)
	local cOutputHandle = nil
	local cOutputEntry = print
	
	if bOutputFile then
		-- Check save path affix.
		local strAffix = string.sub(strSavePath, -1)
		if ("/" ~= strAffix) and ("\\" ~= strAffix) then
			strSavePath = strSavePath .. "/"
		end

		-- Combine file name.
		local strFileName = strSavePath .. "LuaMemRefInfo-Single"
		if (not strExtraFileName) or (0 == string.len(strExtraFileName)) then
			strFileName = strFileName .. "-[" .. strDateTime .. "].txt"
		else
			strFileName = strFileName .. "-[" .. strDateTime .. "]-[" .. strExtraFileName .. "].txt"
		end

		local cFile = assert(io.open(strFileName, "w"))
		cOutputHandle = cFile
		cOutputEntry = cFile.write
	end

	local cOutputer = function (strContent)
		if cOutputHandle then
			cOutputEntry(cOutputHandle, strContent)
		else
			cOutputEntry(strContent)
		end
	end

	-- Write table header.
	cOutputer("--------------------------------------------------------\n")
	cOutputer("-- Collect single object memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
	cOutputer("--------------------------------------------------------\n")

	-- Calculate reference count.
	local nCount = 0
	for k in pairs(cObjectAliasName) do
		nCount = nCount + 1
	end

	-- Output reference count.
	cOutputer("-- For Object: " .. cDumpInfoResults.m_strAddressName .. " (" .. cDumpInfoResults.m_strObjectName .. "), have " .. tostring(nCount) .. " reference in total.\n")
	cOutputer("--------------------------------------------------------\n")

	-- Save each info.
	for k in pairs(cObjectAliasName) do
		if (nMaxRescords > 0) then
			if (i <= nMaxRescords) then
				cOutputer(k .. "\n")
			end
		else
			cOutputer(k .. "\n")
		end
	end

	if bOutputFile then
		io.close(cOutputHandle)
	end
end

-- Fileter an existing result file and output it.
-- strFilePath - The existing result file.
-- strFilter - The filter string.
-- bIncludeFilter - Include(true) or exclude(false) the filter.
-- bOutputFile - Output to file(true) or console(false).
local function OutputFilteredResult(strFilePath, strFilter, bIncludeFilter, bOutputFile)
	if (not strFilePath) or (0 == string.len(strFilePath)) then
		print("You need to specify a file path.")
		return
	end

	if (not strFilter) or (0 == string.len(strFilter)) then
		print("You need to specify a filter string.")
		return
	end

	-- Read file.
	local cFilteredResult = {}
	for strLine in io.lines(strFilePath) do
		local nBegin, nEnd = string.find(strLine, strFilter)
		if nBegin and nEnd then
			if bIncludeFilter then
				table.insert(cFilteredResult, strLine)
			end
		else
			if not bIncludeFilter then
				table.insert(cFilteredResult, strLine)
			end
		end
	end

	-- Write filtered result.
	local cOutputHandle = nil
	local cOutputEntry = print

	if bOutputFile then
		-- Combine file name.
		local _, _, strResFileName = string.find(strFilePath, "(.*)%.txt")
		strResFileName = strResFileName .. "-Filter-" .. ((bIncludeFilter and "I") or "E") .. "-[" .. strFilter .. "].txt"

		local cFile = assert(io.open(strResFileName, "w"))
		cOutputHandle = cFile
		cOutputEntry = cFile.write
	end

	local cOutputer = function (strContent)
		if cOutputHandle then
			cOutputEntry(cOutputHandle, strContent)
		else
			cOutputEntry(strContent)
		end
	end

	-- Output result.
	for i, v in ipairs(cFilteredResult) do
		cOutputer(v .. "\n")
	end

	if bOutputFile then
		io.close(cOutputHandle)
	end
end

-- Dump memory reference at current time.
-- strSavePath - The save path of the file to store the result, must be a directory path, If nil or "" then the result will output to console as print does.
-- strExtraFileName - If you want to add extra info append to the end of the result file, give a string, nothing will do if set to nil or "".
-- nMaxRescords - How many rescords of the results in limit to save in the file or output to the console, -1 will give all the result.
-- strRootObjectName - The root object name that start to search, default is "_G" if leave this to nil.
-- cRootObject - The root object that start to search, default is _G if leave this to nil.
local function DumpMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, preTableInfo, preFuncInfo, preUserdataInfo)
	-- Get time format string.
	local strDateTime = FormatDateTimeNow()

	-- Check root object.
	if cRootObject then
		if (not strRootObjectName) or (0 == string.len(strRootObjectName)) then
			strRootObjectName = tostring(cRootObject)
		end
	else
		cRootObject = debug.getregistry()
		strRootObjectName = "registry"
	end

	-- for index, value in pairs(cRootObject[4]) do
	-- 	print ("zh-----------", index, value)
	-- end

	-- Create container.
	local cDumpInfoContainer = CreateObjectReferenceInfoContainer()
	local cStackInfo = debug.getinfo(2, "Sl")
	if cStackInfo then
		cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
		cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
	end

	-- Collect memory info.
	CollectObjectReferenceInMemory(strRootObjectName, cRootObject, cDumpInfoContainer)
	
	-- Dump the result.
	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, nil, cDumpInfoContainer, preTableInfo, preFuncInfo, preUserdataInfo)
	local cTypeTableInfo = cDumpInfoContainer.m_cTypeTableContainer
	local outTableInfo = {}
	for typeName, typeInfo in pairs(cTypeTableInfo) do
		outTableInfo[typeName] = {}
		outTableInfo[typeName][1] = typeInfo[1]
	end
	local cFuncCountInfo = cDumpInfoContainer.m_cFuncCountContainer
	local outFuncInfo = {}
	for typeName, typeInfo in pairs(cFuncCountInfo) do
		outFuncInfo[typeName] = {}
		outFuncInfo[typeName][1] = typeInfo[1]
	end
	local cUserdataInfo = cDumpInfoContainer.m_cUserdataInfoContainer
	local outUserdataInfo = {}
	for typeName, typeInfo in pairs(cUserdataInfo) do
		outUserdataInfo[typeName] = {}
		outUserdataInfo[typeName][1] = typeInfo[1]
	end
	return outTableInfo, outFuncInfo, outUserdataInfo
end

-- Dump compared memory reference results generated by DumpMemorySnapshot.
-- strSavePath - The save path of the file to store the result, must be a directory path, If nil or "" then the result will output to console as print does.
-- strExtraFileName - If you want to add extra info append to the end of the result file, give a string, nothing will do if set to nil or "".
-- nMaxRescords - How many rescords of the results in limit to save in the file or output to the console, -1 will give all the result.
-- cResultBefore - The base dumped results.
-- cResultAfter - The compared dumped results.
local function DumpMemorySnapshotCompared(strSavePath, strExtraFileName, nMaxRescords, cResultBefore, cResultAfter)
	-- Dump the result.
	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, nil, nil, cResultBefore, cResultAfter)
end

-- Dump compared memory reference file results generated by DumpMemorySnapshot.
-- strSavePath - The save path of the file to store the result, must be a directory path, If nil or "" then the result will output to console as print does.
-- strExtraFileName - If you want to add extra info append to the end of the result file, give a string, nothing will do if set to nil or "".
-- nMaxRescords - How many rescords of the results in limit to save in the file or output to the console, -1 will give all the result.
-- strResultFilePathBefore - The base dumped results file.
-- strResultFilePathAfter - The compared dumped results file.
local function DumpMemorySnapshotComparedFile(strSavePath, strExtraFileName, nMaxRescords, strResultFilePathBefore, strResultFilePathAfter)
	-- Read results from file.
	local cResultBefore = CreateObjectReferenceInfoContainerFromFile(strResultFilePathBefore)
	local cResultAfter = CreateObjectReferenceInfoContainerFromFile(strResultFilePathAfter)

	-- Dump the result.
	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, nil, nil, cResultBefore, cResultAfter)
end

-- Dump memory reference of a single object at current time.
-- strSavePath - The save path of the file to store the result, must be a directory path, If nil or "" then the result will output to console as print does.
-- strExtraFileName - If you want to add extra info append to the end of the result file, give a string, nothing will do if set to nil or "".
-- nMaxRescords - How many rescords of the results in limit to save in the file or output to the console, -1 will give all the result.
-- strObjectName - The object name reference you want to dump.
-- cObject - The object reference you want to dump.
local function DumpMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, strObjectName, cObject)
	-- Check object.
	if not cObject then
		return
	end

	if (not strObjectName) or (0 == string.len(strObjectName)) then
		strObjectName = GetOriginalToStringResult(cObject)
	end

	-- Get time format string.
	local strDateTime = FormatDateTimeNow()

	-- Create container.
	local cDumpInfoContainer = CreateSingleObjectReferenceInfoContainer(strObjectName, cObject)
	local cStackInfo = debug.getinfo(2, "Sl")
	if cStackInfo then
		cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
		cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
	end

	-- Collect memory info.
	CollectSingleObjectReferenceInMemory("registry", debug.getregistry(), cDumpInfoContainer)
	
	-- Dump the result.
	OutputMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, cDumpInfoContainer)
end

cPublications.m_cMethods.DumpMemorySnapshot = DumpMemorySnapshot
cPublications.m_cMethods.DumpMemorySnapshotCompared = DumpMemorySnapshotCompared
cPublications.m_cMethods.DumpMemorySnapshotComparedFile = DumpMemorySnapshotComparedFile
cPublications.m_cMethods.DumpMemorySnapshotSingleObject = DumpMemorySnapshotSingleObject

cPublications.m_cHelpers.FormatDateTimeNow = FormatDateTimeNow
cPublications.m_cHelpers.GetOriginalToStringResult = GetOriginalToStringResult

cPublications.m_cBases.CreateObjectReferenceInfoContainer = CreateObjectReferenceInfoContainer
cPublications.m_cBases.CreateObjectReferenceInfoContainerFromFile = CreateObjectReferenceInfoContainerFromFile
cPublications.m_cBases.CreateSingleObjectReferenceInfoContainer = CreateSingleObjectReferenceInfoContainer
cPublications.m_cBases.CollectObjectReferenceInMemory = CollectObjectReferenceInMemory
cPublications.m_cBases.CollectSingleObjectReferenceInMemory = CollectSingleObjectReferenceInMemory
cPublications.m_cBases.OutputMemorySnapshot = OutputMemorySnapshot
cPublications.m_cBases.OutputMemorySnapshotSingleObject = OutputMemorySnapshotSingleObject
cPublications.m_cBases.OutputFilteredResult = OutputFilteredResult

return cPublications
