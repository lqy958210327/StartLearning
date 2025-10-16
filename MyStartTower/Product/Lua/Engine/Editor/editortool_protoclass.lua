


local cs_write_file = function(path, contents)
    CS.System.IO.File.WriteAllLines(path, contents)
end


local typemap = {}
typemap["int32"] = "number"
typemap["uint32"] = "number"
typemap["fixed32"] = "number"
typemap["sfixed32"] = "number"
typemap["sint32"] = "number"
typemap["int64"] = "number"
typemap["uint64"] = "number"
typemap["fixed64"] = "number"
typemap["sfixed64"] = "number"
typemap["sint64"] = "number"
typemap["double"] = "number"
typemap["float"] = "number"
typemap["string"] = "string"
typemap["bytes"] = "string"
typemap["bool"] = "boolean"


---@param dll_pb table protobuf库
---@param path string protobuf 注释文件导出路径
local function read(dll_pb, path)
    local contents = {}
    local fileName = path.."/protoclass.lua"

    local pbtypes = {}
    for fullname, basename, type in dll_pb.types() do
        local temp = {}
        temp[1] = fullname
        temp[2] = basename
        temp[3] = type
        table.insert(pbtypes, temp)
    end
    table.sort(pbtypes,function (a,b)
        return a[2] < b[2]
    end)

    table.insert(contents,"---------- 协议类结构注释，不require")
    for i = 1, #pbtypes do
        local fullname = pbtypes[i][1]
        local basename = pbtypes[i][2]
        local type = pbtypes[i][3]
        
        table.insert(contents,"\n")
        local strclass = "---@class SC_"..basename--.."\n"
        table.insert(contents,strclass)
        for name, idx, type, dufault, flag, oneof in dll_pb.fields(fullname) do
            local temp1,temp2,temp3 = dll_pb.type(type)
            --print("---   111", name, idx, type, dufault, flag, oneof,temp1,temp2,temp3)
            local fieldtype = ""
            if flag == "repeated" then
                if temp2 ~= nil then
                    fieldtype = " table<number,SC_"..temp2..">"
                else
                    fieldtype = " table<number,"..typemap[type]..">"
                end
            end

            if flag == "optional" then
                if temp2 ~= nil then
                    fieldtype = " SC_"..temp2
                else
                    if typemap[type] ~= nil then
                        fieldtype = " "..typemap[type]
                    else
                        print("---   waring!!!   缺少基础类型对应表   type = ",type)
                    end
                end
            end

            if flag == "packed" then
                if typemap[type] ~= nil then
                    fieldtype = " table<number,"..typemap[type]..">"
                else
                    print("---   waring!!!   缺少基础类型对应表   type = ",type)
                end
            end

            if fieldtype == "" then
                print("---   waring!!!   fieldtype = nil", name, idx, type, dufault, flag, oneof,temp1,temp2,temp3)
            end

            local strfield = "---@field "..name..fieldtype
            table.insert(contents,strfield)
        end
    end
    cs_write_file(fileName, contents)
    print("proto注释刷新成功！！")
end

return {Generate = read}