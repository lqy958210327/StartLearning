package.cpath = package.cpath .. ';C:/Users/user/AppData/Roaming/JetBrains/Rider2025.1/plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
local dbg = require('emmy_core')
dbg.tcpConnect('localhost', 9966)


print("---   Lua流程：加载LuaProject...")

-- 加载engine
require("Engine/require_list")

-- 加载framework
require("Framework/require_list")

-- 定义为全局模块，整个lua程序的入口类
GameMain = {}

--主入口函数。从这里开始lua逻辑
local function Start()

	print("---   Lua流程：GameMain.start()  lua程序开始运行")

	-- 初始化全局变量
	require("Core/Define")--老代码

	--
	require("Optimize/require_list")

	require("GameInstance")

	-- GameStart
	Game.GameProgressInit()
end

local function Stop()
	print("---   Lua流程：GameMain.stop()   lua程序结束运行...")

	-- 模块注销
	Game.GameProgressDestroy()
end


local function Print()
	print('print_func_ref_by_csharp start.')
	local util = require "Runner.Common.XLua.xlua.util"
	util.print_func_ref_by_csharp()
	print('print_func_ref_by_csharp end.')
end


-- GameMain公共接口，其它的一律为私有接口，只能在本模块访问
GameMain.Start = Start
GameMain.Stop = Stop

-- 释放虚拟机之前会执行,打印C#对Lua函数的引用,用于排查回调
GameMain.Print = Print

print("---   Lua流程：加载LuaProject  finish...")

return GameMain
