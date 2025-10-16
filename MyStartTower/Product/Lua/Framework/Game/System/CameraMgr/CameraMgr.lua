


---@class CameraMgr : SystemBase
CameraMgr = Class("CameraMgr", SystemBase)

function CameraMgr:OnInit()
    ---@type table<CameraType, userdata> ：存的是 GameObject，GameObject上有虚拟相机
    self._cameraObjDict = {}
    ---@type CameraType
    self._curCameraType = nil

    self._evtSetCamera = function(cameraType, cameraObj) self:SetCamera(cameraType, cameraObj) end
    self._evtChangeCamera = function(cameraType) self:OnChangeCamera(cameraType) end
    EventManager.Global.RegisterEvent(EventType.CameraMgrSetCamera, self._evtSetCamera)
    EventManager.Global.RegisterEvent(EventType.CameraMgrChangeCamera, self._evtChangeCamera)
end

function CameraMgr:OnClear()
    EventManager.Global.UnRegisterEvent(EventType.CameraMgrSetCamera, self._evtSetCamera)
    EventManager.Global.UnRegisterEvent(EventType.CameraMgrChangeCamera, self._evtChangeCamera)
end

function CameraMgr:OnGameStart()

end

function CameraMgr:OnGameEnd()
    self._cameraObjDict = {}
end

function CameraMgr:SetCamera(cameraType, cameraObj)
    assert(cameraType, "---   数据异常: cameraType = nil")
    assert(self._curCameraType ~= cameraType, "---   数据异常: 当前相机正在使用，无法替换CameraObject或清除CameraObject, cameraType = "..cameraType)

    self._cameraObjDict[cameraType] = cameraObj
    if not IsNull(cameraObj) then
        LuaCallCs.GameObjectActive(cameraObj, false)
    end
end

---@param cameraType CameraType
function CameraMgr:OnChangeCamera(cameraType)
    assert(cameraType, "---   数据异常: cameraType = nil")
    self:_disableLastCamera()

    if self._cameraObjDict[cameraType] then
        print("---   CameraMgr：切换虚拟相机，cameraType = "..cameraType)
        local curCamera = self._cameraObjDict[cameraType]
        if curCamera then
            if IsNull(curCamera) then
                LuaCallCs.LogError("---   CameraObject被意外删除，Current CameraType = "..cameraType)
            else
                LuaCallCs.GameObjectActive(curCamera, true)
            end
        end

        self._curCameraType = cameraType
    else
        print("---   本次切换虚拟相机不生效，自动切换为主相机！ 没有设置虚拟相机CameraObject，cameraType = "..cameraType)
    end
end

function CameraMgr:_disableLastCamera()
    local lastCamera = self._cameraObjDict[self._curCameraType]
    if lastCamera then
        if IsNull(lastCamera) then
            LuaCallCs.LogError("---   CameraObject被意外删除，Last CameraType = "..self._curCameraType)
        else
            LuaCallCs.GameObjectActive(lastCamera, false)
        end
    end
    self._curCameraType = nil
end
