
local tab = {}

function tab.SetArrow(obj, path, sceneStartObj, sceneEndObj)
    CS_LuaCallCs.GuideArrowAniSetArrow(obj, path, sceneStartObj, sceneEndObj)
end

function tab.SetArrowUIToScene(obj, path, startUI, sceneEndObj)
    CS_LuaCallCs.GuideArrowAniSetArrowUIToScene(obj, path, startUI, sceneEndObj)
end

function tab.CalculateGuideMask(obj, path, guideRect)
    CS_LuaCallCs.CalculateGuideMask(obj, path, guideRect)
end


LuaCallCs.Guide = tab
