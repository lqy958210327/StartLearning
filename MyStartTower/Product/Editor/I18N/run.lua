-- set bin path
package.path = package.path .. ";./bin/lib/?.lua"
-- print(package.path)

local i18n = require("i18n")

-- 排除文件
i18n.add_exclude({
})

-- 语言文件的名字后缀
i18n.add_lang({
    "en", --英语
    "de", --德语
    "fr", --法语
    "es", --西班牙语
    "pt", --葡萄牙语
    "it", --意大利语
    "ru", --俄语
    "pl", --波兰语
    "id", --印尼语
    "th", --泰语
})

-- 不排序（新增字段不放到最后）
i18n.bupaixu = {
    --["test.lua"] = true,
}

--local dirs = { "./I18N/test", }
--i18n.langTable = "./I18N/out/conf/lang_"
--i18n.transFile = "./I18N/out/transFile.csv"

local dirs = { "../Lua/Game","../Lua/Config/DataTable","../Lua/Config/ConstTable" }
local dirs_unmark = { "../Lua" }
i18n.langTable = "../../../design/I18N/Langs/lang_"
i18n.transFile = "../../../design/I18N/Trans/TransFile.csv"

for i, v in pairs(arg) do
    print("arg:", i,v)
end

if arg[1] == "make" then
    -- 提取字段到csv并生成lua
    i18n.create_translation(dirs)
elseif arg[1] == "refresh" then
    -- 读取csv翻译到lang文件
    i18n.update_translation()
elseif arg[1] == "mark" then
    -- 给翻译的字段添加__(__为全局翻译方法)
    i18n.append__(dirs)
elseif arg[1] == "unmark" then
    -- 给翻译的字段移除__(__为全局翻译方法)
    i18n.remove__(dirs_unmark)
end
