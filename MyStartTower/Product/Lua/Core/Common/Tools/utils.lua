local lBit = bit

local utils = {}

utils._utf8Headers = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}

function utils.getLogging( logger )
    return function( title, message )
        --print(message)
        if logger then
            if message and type(message) == 'string' then
                logger:info( title..message )
            elseif message and type(message) == 'table' then
                logger:info( title..utils.dumpTab(message) )
            else
                logger:info( title )
            end
        end
    end
end

--设置某战场的logger(Common/logging/file)    在此以后  可以全局调用utils.logToLogger写入该战场内日志
function utils.setLoggingLogger( logger )
    utils.logToLogger = utils.getLogging( logger )
end

utils.setLoggingLogger()

--返回给定table中value为给定值的索引，只查找table的list部分
function utils.getIndexByValue( argTable, argValue )
    if not argTable or not argValue then
        return -1
    end
    for i,value in ipairs(argTable) do
        if value == argValue then
            return i
        end
    end
    return -1
end

function utils.getSortingFunc( attrName, isLess )
    return function(a, b)
        if a[attrName] and b[attrName] then
            if isLess then
                return a[attrName] < b[attrName]
            else
                return a[attrName] > b[attrName]
            end
        elseif a[attrName] then
            return true
        end
    end
end

function utils.getTableElemCount( tab ,exceptNil)
    if not tab then
        return 0
    end
    local count = 0
    for k,value in pairs(tab) do
        if exceptNil then
            if value~=nil then
                count = count + 1
            end
        else
            count = count + 1
        end
    end
    return count
end

--拷贝table
function utils.copyTable( table )
    local newTable = {}
    for i,value in pairs(table) do
        newTable[i] = value
    end
    return newTable
end

function utils.dumpTab(tab)
    return utils.execDumpTab(tab,nil,{})
end

function utils.execDumpTab(tab,ind,parentTabs)
    if tab==nil then return "nil" end
    local str = "{"
    local ind = ind or "  "

    parentTabs[tab] = true
    for k,v in pairs(tab) do
        if type(k) == "string" then
            k = tostring(k).." = "
        else
            k = "["..tostring(k).."] = "
        end--//end if

        local s = ""
        if type(v) == "nil" then
            s = "nil"
        elseif type(v) == "boolean" then
            if(v) then s="true"; else s="false"; end
        elseif type(v) == "number" then
            s=v;
        elseif type(v)=="string" then
            if v:find('\0') then
                s = 'BIT_STR'
            else
                s="\""..v.."\""
            end
        elseif type(v) == "table" then
            if parentTabs[v] ~= true then
                s=utils.execDumpTab(v, ind.."  ", parentTabs)
                s=string.sub(s,1,#s-1);
            else
                s=tostring(v)
            end
        elseif type(v)=="function" then
            s="function"
        elseif type(v)=="thread" then
            s="thread : "..tostring(v)
        elseif type(v)=="userdata" then
            s="userdata : "..tostring(v)
        else
            s="nuknow : "..tostring(v)
        end--//end if
        --//Contact
        str=str.."\n"..ind..k..s.." ,"
    end --//end for
    --//return the format string
    parentTabs[tab] = nil
    local sss=string.sub(str,1,#str-1)
    if #ind>0 then ind=string.sub(ind,1,#ind-2) end
    sss=sss.."\n"..ind.."}\n"
    return sss--string.sub(str,1,#str-1).."\n"..ind.."}\n";
end--//end function

function utils.thorLog(t, logtype, tag ,title)
    if tag ~= nil then
        print(tag.."+++++++++++++++++++++++++++++++++")
    end
    logtype = logtype or 0
    local logFunc = nil
    if logtype == 0 then
        logFunc = log
    elseif logtype == 1 then
        logFunc = log
    else
        logFunc = logerror
    end

    if "table" ~= type(t) then
        logFunc(title and title .. '\r\n' .. t or t)
    else
        local tolog = utils.dumpTab(t)
        logFunc(title and title .. '\r\n' .. tolog or tolog)
    end
end
--utils['setLoggingLogger'] = setLoggingLogger

function utils.splitString(str, delimiter)
    if str==nil or str=='' or delimiter==nil then
        return {str}
    end
    local matchDet = string.gsub(delimiter, "([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1")   -- 需要转义的字符增加%
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..matchDet) do
        table.insert(result, match)
    end
    return result
end


function utils.splitStringIntoArgs(str, delimiter, argCount)
    local args = utils.splitString(str, delimiter)
    if argCount then
        for i = 1, argCount - #args do
            table.insert(args, "")
        end
    end
    return unpack(args)
end

function utils.trimStartEnd( str )
    if not str then
        return
    end
    return string.gsub(str, "^[%s]*(.-)[%s]*$", "%1")
end

function utils.replaceString(s, pattern, repl)
    local i,j = string.find(s, pattern, 1, true)
    if i and j then
        local ret = {}
        local start = 1
        while i and j do
            table.insert(ret, string.sub(s, start, i - 1))
            table.insert(ret, repl)
            start = j + 1
            i,j = string.find(s, pattern, start, true)
        end
        table.insert(ret, string.sub(s, start))
        return table.concat(ret)
    end
    return s
end

--luaTable的序列化
function utils.serialize(t)
    local mark={}
    local assign={}
    local function table2str(t, parent)
        mark[t] = parent
        local ret = {}
        for f,v in pairs(t) do
            local k = type(f) == "number" and "["..f.."]" or "['"..f.."']"  --type(f)=="number" and "["..f.."]" or f
            local dotkey = parent..k -- (type(f)=="number" and k or "."..k)
            local t = type(v)
            if t == "userdata" or t == "function" or t == "thread" or t == "proto" or t == "upval" then
                --ignore
            elseif t == "table" then
                if mark[v] then
                    table.insert(assign, dotkey.."="..mark[v])
                else
                    table.insert(ret, string.format("%s=%s", k, table2str(v, dotkey)))
                end
            elseif t == "string" then
                table.insert(ret, string.format("%s=%q", k, v))
            elseif t == "number" then
                if v == math.huge then
                    table.insert(ret, string.format("%s=%s", k, "math.huge"))
                elseif v == -math.huge then
                    table.insert(ret, string.format("%s=%s", k, "-math.huge"))
                else
                    table.insert(ret, string.format("%s=%s", k, tostring(v)))
                end
            else
                table.insert(ret, string.format("%s=%s", k, tostring(v)))
            end
        end
        return "{"..table.concat(ret,",").."}"
    end

    if type(t) == "table" then
        return string.format("%s%s",  table2str(t,"_"), table.concat(assign," "))
    else
        return tostring(t)
    end
end

--luaTable序列化文本的反序列化
function utils.unserialize(str)
    local EMPTY_TABLE = {}
    if str == nil or str == "nil" then
        return nil
    elseif type(str) ~= "string" then
        return EMPTY_TABLE
    elseif #str == 0 then
        return EMPTY_TABLE
    end
    local code, ret = pcall(loadstring(string.format("do local _=%s return _ end", str)))

    if code then
        return ret
    else
        return EMPTY_TABLE
    end
end

function utils.utf8len(input, chnCount)
    if chnCount == nil then
        chnCount = 1
    end
    local len  = string.len(input)
    local left = len
    local cnt  = 0
    local arr  = utils._utf8Headers
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        local count = 1
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                if i ~= 1 then
                    count = chnCount
                end
                break
            end
            i = i - 1
        end
        cnt = cnt + count
    end
    return cnt
end

function utils.substring(input, chnCount,keepLength)
    if chnCount == nil then
        chnCount = 1
    end
    local len  =0
    local left =1
    local byteLen=string.len(input)
    local arr  = utils._utf8Headers
    while left<byteLen do
        local tmp = string.byte(input, left)
        local i   = #arr
        local count = 1
        while arr[i] do
            if tmp >= arr[i] then

                if i ~= 1 then
                    count = chnCount
                end
                break
            end
            i = i - 1
        end
        len=len+count
        if len>keepLength then
            break
        else
            left = left + i
        end
    end
    return string.sub(input, 1, left-1)
end

function utils.utf8Substring(input, startIndex, endIndex)
    local startByte = 0
    local endByte = 0
    local len  = string.len(input)
    local left = len
    local curIndex  = 1
    local curByte = 1
    local arr  = utils._utf8Headers
    while left > 0 do
        if startIndex == curIndex then
            startByte = curByte
        end
        if startByte ~= 0 and endByte ~= 0 then
            break
        end
        local tmp = string.byte(input, -left)
        local i = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                --if i ~= 1 then --这里当年应该没有考虑到1个字节的字符，所以现在干掉by刘虎
                    curByte = curByte + i
                --end
                break
            end
            i = i - 1
        end
        if endIndex == curIndex then
            endByte = curByte - 1
        end
        if startByte ~= 0 and endByte ~= 0 then
            break
        end
        curIndex = curIndex + 1
    end
    if startByte == 0 or endByte == 0 then
        return nil
    else
        return string.sub(input, startByte, endByte)
    end
end

function utils.deepcopy(ori_tab)
    if (type(ori_tab) ~= "table") then
        return nil
    end
    local new_tab = {}
    for i,v in pairs(ori_tab) do
        local vtyp = type(v)
        if (vtyp == "table") then
            new_tab[i] = utils.deepcopy(v)
        elseif (vtyp == "thread") then
            new_tab[i] = v
        elseif (vtyp == "userdata") then
            new_tab[i] = v
        else
            new_tab[i] = v
        end
    end
    return new_tab
end

function utils.deepcompare(t1,t2)
    if t1 == t2 then
        return true
    end

    local ty1, ty2 = type(t1), type(t2)
    if ty1 ~= ty2 then
        return false
    end

    if ty1 ~= 'table' then
        return t1 == t2
    end

    local checked = {}

    for k1, v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not utils.deepcompare(v1,v2) then
            return false
        end
        checked[k1] = true
    end
    for k2,v2 in pairs(t2) do
        if not checked[k2] then
            local v1 = t1[k2]
            if v1 == nil or not utils.deepcompare(v1,v2) then
                return false
            end
        end
    end
    return true
end

--数字转换为中文，97-九十七
function utils.formatNumber(num)
    local places = { '', '十', '百', '千', '万', '十', '百', '千', '亿', '十', '百', '千', '万' }
    if type(num) ~= "number" then
        return string.format(num .. "is not a num")
    end
    local numStr = tostring(num)
    local len = string.len(numStr)
    local str = ''
    local has0 = false
    for i = 1, len do
        local n = tonumber(string.sub(numStr, i, i))
        local p = len - i + 1
        if n > 0 and has0 == true then
            --连续多个零只显示一个
            str = str .. '零'
            has0 = false
        end
        if p % 4 == 2 and n == 1 then
            --十位数如果是首位则不显示一十这样的
            if len > p then
                str = str .. Const.NUMBER_TO_WORD[n]
            end
            str = str .. places[p]
        elseif n > 0 then
            str = str .. Const.NUMBER_TO_WORD[n]
            str = str .. places[p]
        elseif n == 0 then
            if p % 4 == 1 then
                --各位是零则补单位
                str = str .. places[p]
            else
                has0 = true
            end
        end
    end
    return str
end

function utils.getTableValue(tab, keyName, defValue)
    if tab == nil then
        tab = {}
    end
    local v = tab[keyName]
    if v == nil or v == 0 or v == "" then
        return defValue
    else
        return v
    end
end

function  utils.getLength(v1)
    if v1 == nil then
        return nil
    end
    local l = 0
    for i, _ in ipairs(v1) do
        l = l + (v1[i])^2
    end
    return l^0.5
end

local vector_keys = {'x', 'y', 'z'}
function  utils.getDistance(v1, v2)
    if v1 == nil or v2 == nil or #v1 ~= #v2 then
        return nil
    end
    local acc = 0
    if v1[1] then
        for i, _ in ipairs(v1) do
            acc = acc + (v2[i] - v1[i])^2
        end
    else
        for _, key in ipairs(vector_keys) do
            acc = acc + (v2[key] - v1[key])^2
        end
    end
    return acc^0.5
end

function utils.getDistance2D(x1, y1, x2, y2)
    return ((x2 - x1)^2 + (y2 - y1)^2)^0.5
end

function  utils.isCloseEnough(v1, v2, distance)
    if distance == nil or distance < 0 then
        return nil
    end
    return utils.getDistance(v1, v2) <= distance
end

function  utils.dot(v1, v2)
    if v1 == nil or v2 == nil or #v1 ~= #v2 then
        return nil
    end
    local dot = 0
    for i, _ in ipairs(v1) do
        dot = dot + v2[i] * v1[i]
    end
    return dot
end

function  utils.normalize(v1)
    if v1 == nil then
        return nil
    end
    local length = utils.getLength(v1)
    if length == 0 then
        return nil
    end
    local normal = {}
    for i, _ in ipairs(v1) do
        normal[i] = v1[i] / length
    end
    return normal
end

function  utils.getNearest(posOrigin, entries, fields)
    if not (type(posOrigin) == "table" and type(entries) == "table") then
        logerror("invalid param!!")
        return
    end
    local minDis = math.huge
    local minPos = nil
    local minIndex = nil
    local curDis = nil
    for i, curPos in pairs(entries) do
        if fields ~= nil then
            for _, field in ipairs(fields) do
                curPos = curPos[field]
                if curPos == nil then
                    break
                end
            end
        end
        curDis = utils.getDistance(posOrigin, curPos)
        if curDis ~= nil and curDis < minDis then
            minIndex = i
            minPos = curPos
            minDis = curDis
        end
    end
    return minIndex
end

function utils.getBitsDictFromByteString( byteString )
    if not byteString then
        return {}
    end
    local bytesList = {byteString:byte(1,-1)} -- string每一位转化成一byte
    local bitCount = 8  --8位
    local bitList = {}
    for index = 1, #bytesList do
        for j = 1, bitCount do
            if lBit.band(bytesList[index], lBit.lshift(1, bitCount - j)) ~= 0 then
                -- 从左到右的位置
                local position = (index-1)*bitCount + j
                bitList[position] = true
            end
        end
    end
    return bitList
end
function utils.getBitsDictFromIntArray( intList )
    if not intList then
        return {}
    end
    local bitList = {}
    for index = 1, #intList do
        bitList[intList[index]] = true
    end
    return bitList
end

-- 解析服务端的bytes数据,返回的table是"bit为1的位置"列表
function utils.getBitsListFromByteString( byteString )
    if not byteString then
        return {}
    end
    local bytesList = {byteString:byte(1,-1)} -- string每一位转化成一byte
    local bitCount = 8  --8位
    local bitList = {}
    for index = 1, #bytesList do
        for j = 1, bitCount do
            if lBit.band(bytesList[index], lBit.lshift(1, bitCount - j)) ~= 0 then
                -- 从左到右的位置
                local position = (index-1)*bitCount + j
                table.insert(bitList, position)
            end
        end
    end
    return bitList
end

function utils.getNumListFromString( str, delimiter )
    local numStrList = utils.splitString(str, delimiter)
    local numList = {}
    for _, numStr in ipairs(numStrList) do
        if numStr ~= "" then
            local num = tonumber(numStr)
            if num then
                table.insert(numList, num)
            end
        end
    end
    return numList
end

local REVERSE_NUM = {128, 64, 32, 16, 8, 4, 2, 1}
function utils.getByteStringFromBitsList(bitList, maxStrNum)
    table.sort(bitList)
    local byteString = ""
    for index = 1, maxStrNum or 1 do
        local count = 0
        for _, value in ipairs(bitList) do
            if value > (index * 8 - 8) and value <= index * 8 then
                count = count + REVERSE_NUM[value - index * 8 + 8]
            end
        end
        byteString = byteString..string.char(count)
    end
    return byteString
end

-- 获得富文本带色字符串
function utils.getColorfulStr(str,color)
    return "<color=#"..color.hex..">"..str.."</color>"
end

--获得unitycolor（1，1，1，1）
function utils.getUnityColor( resColorData )
    return Framework.UI.UIUtils.GetColor(resColorData.hex)
end

function utils.removeTableElements( dic,removeNum,sortFunc )
    if dic==nil or type(dic)~='table' then
        logerror("table expect")
        return
    end
    local temp={}
    for key,value in pairs(dic) do
        if value then
            table.insert(temp,key)
        end
    end
    table.sort(temp,function ( v1,v2 )
        return sortFunc(dic[v1],dic[v2])
    end)
    for i=1,math.min(removeNum,#temp) do
        dic[temp[i]]=nil
    end
end

function utils.PrintNotSame(value1, value2, needPrint)
    if type(value1) == 'table' and type(value2) == 'table' then
        local same = true
        for key, value in pairs(value1) do
            if not utils.PrintNotSame(value, value2[key], needPrint) then
                same = false
                if needPrint then
                    print("zh---------------------- 遍历1时 不一致", key, value, value2[key])
                end
            end
        end
        for key, value in pairs(value2) do
            if not utils.PrintNotSame(value, value1[key], needPrint) then
                same = false
                if needPrint then
                    print("zh---------------------- 遍历2时 不一致", key, value1[key], value)
                end
                same =  false
            end
        end
        return same
    else
        if type(value1) == "number" and type(value2) == "number" and math.abs(value1 - value2) <= 0.000001 then
            return true
        end
        return value1 == value2
    end
end

local orderCache = {}
local argsCache = {}
function utils.format(fmt, ...)
    for k, v in pairs(orderCache) do
        orderCache[k] = nil
    end
    for k, v in pairs(argsCache) do
        argsCache[k] = nil
    end
    local num = select('#', ...)
    for i = 1, num do
        argsCache[i] = select(i, ...)
    end
    local done = 0
    fmt = fmt:gsub('%%(%d*):?([-+%d%.]*[cdfosxX])', function(order, placeholder)
            done = done + 1
            local arg = argsCache[tonumber(order)]
            if nil == arg then
                logerror("format args mismatch:", fmt)
                arg = argsCache[done] or ""
            end
            table.insert(orderCache, arg)
            return  "%" .. placeholder
        end)
    local status, ret = pcall(string.format, fmt, unpack(done ~= 0 and orderCache or argsCache))
    if status then
        return ret
    else
        logerror("format error:", fmt)
        return fmt
    end
end

local function _detect(parent, word, idx)
    local len = string.len(word)
  
	local ch = string.sub(word, 1, 1)
	local child = parent[ch]
    
    if not child then
    elseif type(child) == 'table' then
        if len > 1 then
            if child.isTail then
	            return _detect(child, string.sub(word, 2), idx+1) or idx
            else
                return _detect(child, string.sub(word, 2), idx+1)
            end
        elseif len == 1 then
            if child.isTail == true then
                return idx
            end
        end
    elseif (child == true) then
    	return idx
    end
    return false
end

local function _word2Tree(root, word)
	if string.len(word) == 0 then return end

	local function _byte2Tree(r, ch, tail)
		if tail then
            if type(r[ch]) == 'table' then
                r[ch].isTail = true
            else
                r[ch] = true
            end
		else
            if r[ch] == true then
                r[ch] = { isTail = true }
            else
			    r[ch] = r[ch] or {}
            end
		end
		return r[ch]
	end
	
	local tmpparent = root
	local len = string.len(word)
    for i=1, len do
    	if tmpparent == true then
    		tmpparent = { isTail = true }
    	end
    	tmpparent = _byte2Tree(tmpparent, string.sub(word, i, i), i==len)
    end
end

local _maskWord = '*'
local _maskWord1 = '啊'
local function getStringInner(s)
	if type(s) ~= 'string' then return end

	local i = 1
	local len = string.len(s)
	local word, idx, tmps
	local _tree = {}
    local words = SensitiveCfg
	for _, word in pairs(words) do
		_word2Tree(_tree, word)
	end
	while true do
    	word = string.sub(s, i)
    	idx = _detect(_tree, word, i)

    	if idx then
    		tmps = string.sub(s, 1, i-1)
    		for j=1, idx-i+1 do
    			tmps = tmps .. _maskWord
    		end
    		s = tmps .. string.sub(s, idx+1)
    		i = idx+1
    	else
    		i = i + 1
    	end
    	if i > len then
    		break
    	end
	end
	
    return s
end

local function getStringInnerName(s)
	if type(s) ~= 'string' then return end

	local i = 1
	local len = string.len(s)
	local word, idx, tmps
	local _tree = {}
    local words = SensitiveCfg
	for _, word in pairs(words) do
		_word2Tree(_tree, word)
	end
	while true do
    	word = string.sub(s, i)
    	idx = _detect(_tree, word, i)

    	if idx then
    		tmps = string.sub(s, 1, i-1)
    		for j=1, idx-i+1 do
    			tmps = tmps .. _maskWord1
    		end
    		s = tmps .. string.sub(s, idx+1)
    		i = idx+1
    	else
    		i = i + 1
    	end
    	if i > len then
    		break
    	end
	end
	
    return s
end

function utils.Filter(strText)
    if type(strText) ~= 'string' then return end

	local newS = string.gsub(strText, " ", "")
	newS = string.gsub(newS, "&", "")
	newS = string.gsub(newS, "*", "")
	if getStringInner(newS) ~= newS then
		strText = newS
	end
	strText = getStringInner(strText)
    return strText
end
function utils.FilterName(strText)
    if type(strText) ~= 'string' then return end

	local newS = string.gsub(strText, " ", "")
	newS = string.gsub(newS, "&", "")
	newS = string.gsub(newS, "*", "")
	if getStringInnerName(newS) ~= newS then
		strText = newS
	end
	strText = getStringInnerName(strText)
    return strText
end

--在table找target是否存在
function utils.Exist(luTable,target)
    local result = false
    for k, v in pairs(luTable) do
        if v == target then
            result = true
            break
        end
    end
    return result
end



--名字只包含：数字、字母、中文
function utils.CheckName(_name)
    local ss = {}
    for k = 1, #_name do
        local c = string.byte(_name, k)
        if not c then break end
        if (c >= 48 and c <= 57) or (c >= 65 and c <=90) or (c >=97 and c <= 122) then
            ss[#ss + 1] = string.char(c)
        elseif c >= 228 and c <= 233 then
            local c1 = string.byte(_name, k + 1)
            local c2 = string.byte(_name, k + 2)
            if c1 and c2 then
                local a1, a2, a3, a4 = 128, 191, 128, 191
                if c == 228 then
                    a1 = 184
                elseif c == 233 then
                    a2, a4 = 190, c1 ~= 190 and 191 or 165
                end
                if c1 >= a1 and c1 <= a2 and c2 <= a4 then
                    k = k + 2
                    ss[#ss + 1] = string.char(c, c1, c2)
                end
            end
        end  
    end
    if #ss > 0 then
        local len = 0
        for k, v in pairs(ss) do
            len = len + #v
        end
        if #_name == len then
            return true
        else
            return false
        end
    else
        return false
    end
end

return utils
