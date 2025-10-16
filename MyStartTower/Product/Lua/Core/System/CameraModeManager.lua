local BattleConst = require "Core/Common/FrameBattle/BattleConst"
local CameraModeManager = {}
local GameSettings = require("Core/Helper/GameSettings")
local self = CameraModeManager

local CameraManager = CameraManager
local CameraControllerNodeType = CameraControllerNodeType
local Const = require("Core/Const")

local CAMERA_NODE_TYPE_TARGET = 1

-- 初始化 摄像机(不是摄像机控制节点)
function CameraModeManager.init()
    CameraModeManager._gyroEnabled = false;
    CameraManager.Init(Const.CAMERA_GROUP_PREFAB)
    self.setMSAA(GameSettings.msaaSample)
    -- self.trackCamera = CameraManager.AddControllerNode(Const.CAMERA_CONTROL_NODE_TRACK, CameraControllerNodeType.TrackController)
    -- CameraManager.SetTrackNode(self.trackCamera)
    CameraManager.SetModeChangeCallBack(CameraModeManager.onCameraChanged)
end

function CameraModeManager.destroy()
    CameraManager.SetModeChangeCallBack(nil)
    CameraManager.DestroyInstance()
end

-- 初始化 Animator动画控制的镜头轨迹控制节点
function CameraModeManager.initCameraControllerNode()
    if not self.animatorCamera then
        self.animatorCamera = CameraManager.AddControllerNode(Const.CAMERA_CONTROL_NODE_ANIMATOR, CameraControllerNodeType.AnimatorTargetController)
    end
    if not self.mainCamera then
        self.mainCamera = CameraManager.AddControllerNode(Const.CAMERA_CONTROL_NODE_FREE, CameraControllerNodeType.FreeTargetController)
    end
    if not self.battleCamera then
        self.battleCamera = CameraManager.AddControllerNode(Const.CAMERA_CONTROL_NODE_BATTLE, CameraControllerNodeType.TargetController)
    end
end



function CameraModeManager.setBattleMode(translateTime)
    CameraManager.SetClipPlane(BattleConst.NEAR_CLIP_PLANE, BattleConst.FAR_CLIP_PLANE)
    CameraManager.SetDefaultNode(self.battleCamera)
    CameraManager.SwitchToNode(translateTime or 0, self.battleCamera)
    CameraManager.DeactiveAllUnusedNode()
end


---]]







function CameraModeManager.onCameraChanged( fromCamera, toCamera )
    if fromCamera == self.nearCamera then
        ClientUtils.checkExitCamNearView(true)
    end
end


function CameraModeManager.set2DHDR( enable )
    CameraManager.Set2DHDR(enable)
end



function CameraModeManager.setMSAA( msaaSample )
    CameraManager.AllowMSAA(msaaSample)
end



return CameraModeManager