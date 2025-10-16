


---@class LuaCallCs
LuaCallCs = {}

LuaCallCs.LogError = function(log, isTraceback)
    if isTraceback then
        local traceback = debug.traceback()
        log = log.."\n"..traceback
    end
    CS_Debug.LogError(log)
end

LuaCallCs.GetInstanceID = function(obj)
    if not IsNull(obj) then
        return obj:GetInstanceID()
    end
    return nil
end

---@type function() : string 返回全局唯一guid
LuaCallCs.NewGuid = function() return CS_LuaCallCs.NewGuid() end

LuaCallCs.SetGameObjectName = function(obj, name)
    CS_LuaCallCs.SetGameObjectName(obj, name)
end

LuaCallCs.IsEditor = function()
    return CS_LuaCallCs.IsEditor()
end

LuaCallCs.ThrowException = function(error)
    CS_LuaCallCs.ThrowException(error)
end

LuaCallCs.GetObject = function(obj, name)
    return CS_LuaCallCs.GetObject(obj, name)
end

LuaCallCs.GetObjectExactMatch = function(obj, path)
    return CS_LuaCallCs.GetObjectExactMatch(obj, path)
end

LuaCallCs.SetGameObjectActive = function(parent, path, value)
    CS_LuaCallCs.SetGameObjectActive(parent, path, value)
end

LuaCallCs.SetGameObjectActiveExactMatch = function(parent, path, value)
    CS_LuaCallCs.SetGameObjectActiveExactMatch(parent, path, value)
end

LuaCallCs.GameObjectActive = function(object, value)
    CS_LuaCallCs.GameObjectActive(object, value)
end

LuaCallCs.GetGameObjectActive = function(object,path )
    return CS_LuaCallCs.GetGameObjectActive(object, path)
end

LuaCallCs.SetParentAndReset = function(parent, object)
    CS_LuaCallCs.SetParentAndReset(parent, object)
end

LuaCallCs.ResetLocalPosition = function(object)
    CS_LuaCallCs.ResetLocalPosition(object)
end

LuaCallCs.ResetLocalRotation = function(object)
    CS_LuaCallCs.ResetLocalRotation(object)
end

LuaCallCs.SetGameObjLocalPosition = function(object, x,y,z)
    CS_LuaCallCs.SetGameObjLocalPosition(object, x,y,z)
end

LuaCallCs.SetGameObjLocalRotation = function(object, x,y,z)
    CS_LuaCallCs.SetGameObjLocalRotation(object, x,y,z)
end

LuaCallCs.SetGameObjectLocalScale = function(object, scale)
    CS_LuaCallCs.SetGameObjectLocalScale(object, scale)
end

LuaCallCs.SetGameObjectLocalScaleXYZ = function(object, x, y, z)
    CS_LuaCallCs.SetGameObjectLocalScaleXYZ(object, x, y, z)
end

LuaCallCs.CreateGameObjectDontDestroy = function(name)
    return CS_LuaCallCs.CreateGameObjectDontDestroy(name)
end

LuaCallCs.FuncRefByCSharpHandleRegister = function(mono)
    CS_LuaCallCs.FuncRefByCSharpHandleRegister(mono)
end





LuaCallCs.LoadPrefabSync = function(res)
    return CS_LuaCallCs.LoadPrefabSync(res)
end

LuaCallCs.LoadPrefabAsync = function(res, callback)
    CS_LuaCallCs.LoadPrefabAsync(res, callback)
end

LuaCallCs.DisposePrefab = function(obj)
    CS_LuaCallCs.DisposePrefab(obj)
end

LuaCallCs.ReleasePrefab = function(res)
    CS_LuaCallCs.ReleasePrefab(res)
end

LuaCallCs.LoadScene = function(res, callback)
    CS_LuaCallCs.LoadScene(res, callback)
end

LuaCallCs.ReleaseScene = function(callback)
    CS_LuaCallCs.ReleaseScene(callback)
end

LuaCallCs.SceneGetLoadProgress = function()
    return CS_LuaCallCs.SceneGetLoadProgress()
end

LuaCallCs.SceneGetRootGameObjects = function()
    return CS_LuaCallCs.SceneGetRootGameObjects()
end

LuaCallCs.SceneIsLoading = function()
    return CS_LuaCallCs.SceneIsLoading()
end

LuaCallCs.SceneIsUnloading = function()
    return CS_LuaCallCs.SceneIsUnloading()
end

LuaCallCs.SceneGetCurResName = function()
    return CS_LuaCallCs.SceneGetCurResName()
end

LuaCallCs.GetEntityRootGameObject = function()
    return CS_LuaCallCs.GetEntityRootGameObject()
end

LuaCallCs.EffectPoolRootSetActive = function(value)
    CS_LuaCallCs.EffectPoolRootSetActive(value)
end

LuaCallCs.GetObjectPosition = function(obj)
    return  CS_LuaCallCs.GetObjectPosition(obj)
end

LuaCallCs.InitDragRotate = function(obj, rotateSpeed, enable)
    return  CS_LuaCallCs.InitDragRotate(obj, rotateSpeed, enable)
end

LuaCallCs.WithDragRotateSpeed = function(obj, rotateSpeed)
    return  CS_LuaCallCs.WithDragRotateSpeed(obj, rotateSpeed)
end

LuaCallCs.WithDragRotateEnable = function(obj, enable)
    return  CS_LuaCallCs.WithDragRotateEnable(obj, enable)
end

--LuaCallCs.ScenicHerotDragging = function(obj,rotationSpeed, isDragging)
--    return  CS_LuaCallCs.ScenicHerotDragging(obj,rotationSpeed, isDragging)
--end
--
--LuaCallCs.DestroyScenicHerotDragging = function(obj,rotationSpeed)
--    return  CS_LuaCallCs.DestroyScenicHerotDragging(obj,rotationSpeed)
--end

LuaCallCs.CheckLuaFileExist = function(fileName)
    return CS_LuaCallCs.CheckLuaFileExist(fileName)
end

LuaCallCs.SkillLineLockTargetSetLine = function(obj, attack, target)
    CS_LuaCallCs.SkillLineLockTargetSetLine(obj, attack, target)
end
LuaCallCs.SkillLineLockTargetFree = function(controller)
    CS_LuaCallCs.SkillLineLockTargetFree(controller)
end

LuaCallCs.SimpleFxComponentPlay = function(parent, path, resName) -- 同步播放特效
    CS_LuaCallCs.SimpleFxComponentPlay(parent, path, resName)
end

LuaCallCs.SimpleFxComponentPlayAsync = function(parent, path, resName) -- 异步播放特效
    CS_LuaCallCs.SimpleFxComponentPlayAsync(parent, path, resName)
end

LuaCallCs.SimpleFxComponentFree = function(parent, path) -- 释放特效
    CS_LuaCallCs.SimpleFxComponentFree(parent, path)
end

LuaCallCs.ScenicHeroAnimactionPlay = function(obj, animationNames, timeIntervals)
    return  LuaCallCs.AnimactionPlay(obj, animationNames, timeIntervals)
end

LuaCallCs.ScenicHeroAnimactionForcePlay = function(obj,animationName,onAnimationComplete)
    return  LuaCallCs.AnimactionForcePlay(obj,animationName,onAnimationComplete)
end

LuaCallCs.DestroyScenicHeroAnimactionComp = function(obj)
    return  LuaCallCs.DestroyAnimactionComp(obj)
end

LuaCallCs.AnimactionPlay = function(obj, animationNames, timeIntervals)
    return  CS_LuaCallCs.AnimactionPlay(obj, animationNames, timeIntervals)
end

LuaCallCs.AnimactionForcePlay = function(obj,animationName,onAnimationComplete)
    return  CS_LuaCallCs.AnimactionForcePlay(obj,animationName,onAnimationComplete)
end

LuaCallCs.AnimactionPause = function (obj)
    return CS_LuaCallCs.AnimactionPause(obj)
end

LuaCallCs.AnimactionResume = function (obj)
    return CS_LuaCallCs.AnimactionResume(obj)
end

LuaCallCs.DestroyAnimactionComp = function(obj)
    return  CS_LuaCallCs.DestroyAnimactionComp(obj)
end

LuaCallCs.AdaptivePopupPart = function(obj, rectWidth, rectHeight)
    CS_LuaCallCs.AdaptivePopupPart(obj, rectWidth, rectHeight)
end

LuaCallCs.CalculateGuideRect = function(guideObj, guideTargetObj)
    CS_LuaCallCs.CalculateGuideRect(guideObj, guideTargetObj)
end

LuaCallCs.CheckLocationValid = function(resName)
    return CS_LuaCallCs.CheckLocationValid(resName)
end

LuaCallCs.TryGetEffectController = function(go)
    return CS_LuaCallCs.TryGetEffectController(go)
end

--- 以什么颜色开幕
LuaCallCs.SceneCurtainUp = function(color, delay, onComplete)
    CS_LuaCallCs.SceneCurtainUp(color.r, color.g, color.b, color.a, delay, onComplete)
end

--- 以什么颜色落幕
LuaCallCs.SceneCurtainDown = function(color, delay, onComplete)
    CS_LuaCallCs.SceneCurtainDown(color.r, color.g, color.b, color.a, delay, onComplete)
end