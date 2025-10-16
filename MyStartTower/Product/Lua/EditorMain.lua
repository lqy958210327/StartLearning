


require("Engine/require_list")

require("Engine/editor_require_list")

require "Runner/Common/Utils/protobuf"

-- 指令：由C#侧调用
EditorCmdGenerateProtobufClass = function()
    local _assetName = string.format("HotUpdate/Scriptable/protocol.pb.bytes", pbfile)
    _assetName = CS.UnityEngine.Application.dataPath.."/".._assetName
    local data = CS.System.IO.File.ReadAllBytes(_assetName)
    if data then
        protobuf.register(data)
    else
        assert(false, "---   .pb文件加载失败:".._assetName)
    end
    EditorToolGenerateProtobufClass.Generate(protobuf, "Product/Lua")
end





-- 指令：由C#侧调用