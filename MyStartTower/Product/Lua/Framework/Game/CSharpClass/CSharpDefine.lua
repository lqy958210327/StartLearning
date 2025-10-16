

-- Lua侧要访问的C#类结构，LuaCallCsharp中会提供足够的方法，所以业务侧不要调用这些类型

CS_LuaCallCs = CS.Slime.LuaCallCs.LuaCallCsharpUtil

CS_Debug = CS.UnityEngine.Debug

CS_PlayerPrefs = CS.UnityEngine.PlayerPrefs

CS_DOTweenModuleUI = CS_LuaCallCs.DOTweenModuleUI

CS_TMP_InputField = CS_LuaCallCs.Extend_TMP_InputField

CS_SystemInfo = CS.UnityEngine.SystemInfo