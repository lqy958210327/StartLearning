local HeroPropEditor = {}

local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local FrameMgr = require "Core/Debug/Modules/Demo/DemoFrameMgr"


function HeroPropEditor.bindCSharp(cSharp)
    HeroPropEditor.mono = cSharp

    if IS_EDITOR then
        FrameMgr:WithHeroPropEditorAction(function() HeroPropEditor.updateData() end)
    end
end

function HeroPropEditor.updateData()

    local state = GameFsm.getCurState()
    if state == nil then
        return
    end

    local matrix = state.mMatrixInstance
    if matrix == nil then
        return
    end

    local snapshot = matrix:snapshotAttr()
    local entities = snapshot.unit
    HeroPropEditor.mono:Sync(entities)
end

return HeroPropEditor
