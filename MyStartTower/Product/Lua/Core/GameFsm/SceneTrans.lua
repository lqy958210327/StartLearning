

local GameObject = UnityEngine.GameObject

local strClassName = "SceneTrans"


---@class SceneTrans 场景点位信息
local SceneTrans = Class(strClassName)
-- 构造函数。
function SceneTrans:ctor(sceneNo)
    -- 查表找对应的信息
    self.sceneInfo = DataTable.ResScene[sceneNo]
    if not self.sceneInfo then
        logerror("未找到的场景，id：",sceneNo)
        return
    end
    -- 格子的朝向
    self.gridAngle = self.sceneInfo.dir or 0
    self.dragRotation = self.sceneInfo.drag_camera_rotation
    self.dragFOV = self.sceneInfo.drag_camera_FOV
    self.dragDis = self.sceneInfo.drag_camera_dis
    self._sceneMusic = self.sceneInfo.scene_music
    --self._sceneMusic = "Audio/Dynamic/BGM/moguo"--测试数据

    local gridDirection = math.rad(self.gridAngle)
    self.leftDir = Vector3(-math.cos(gridDirection), 0, -math.sin(gridDirection))
    self.upDir = Vector3(-self.leftDir.z, 0, self.leftDir.x)
    local centerPoint = self.sceneInfo.origin_point
    if not centerPoint then
        LuaCallCs.ThrowException("---   SceneTrans初始化异常：场景表配置错误，origin_point = nil, sceneId = "..sceneNo)
    end
    self.centerPoint = Vector3(centerPoint[1], centerPoint[2], centerPoint[3])      -- 战斗的中心点  根据坐标计算偏移值时需要

    local startPos = self.sceneInfo.camera_pos
    if startPos then
        self.cameraStartPos = Vector3(startPos[1],startPos[2],startPos[3])
    else
        self.cameraStartPos = Vector3(0, 0, 0)
    end
    local rot = self.sceneInfo.camera_rot
    if rot then
        self.cameraRot= Quaternion.Euler(rot[1],rot[2],rot[3])
    else
        self.cameraRot = Quaternion.Euler(0,0,0)
    end


    -- to add
    -- 转换为静态
    -- state.cameraFadeDuration
    -- state.cameraOffsetX
end

function SceneTrans:newCenterPointGo()
    self.centerPointGo = GameObject('CenterPoint')
    self.centerPointGo.transform.position = self.centerPoint
    self.centerPointGo.transform.localRotation = Quaternion.Euler(0,-self.gridAngle,0)
end

function SceneTrans:destroyCenterPointGo()
    if self.centerPointGo then
        UnityEngine.Object.Destroy(self.centerPointGo)
        self.centerPointGo = nil
    end
end

function SceneTrans:newCameraCenterPointGo(position)
    if self.cameraCenterPointGo == nil then
        self.cameraCenterPointGo = GameObject('CameraCenterPoint')
    end
    if position then
        self.cameraCenterPointGo.transform.position = position
    end




end


function SceneTrans:newCameraBattleEndLookAtPos(pos)

    self.cameraBattleEndLookAtPos = UnityEngine.GameObject.Find('cameraBattleEndLookAtPos')



    if pos then
        self.cameraBattleEndLookAtPos.transform.position = self.cameraCenterPointGo.transform.position
    end


end

function SceneTrans:destroyCameraCenterPointGo()
    if self.cameraCenterPointGo then
        UnityEngine.Object.Destroy(self.cameraCenterPointGo)
        self.cameraCenterPointGo = nil
    end
end

function SceneTrans:getCenterPointPos()
    if self.centerPointGo then
        return self.centerPointGo.transform.position
    else
        return self.centerPoint
    end
end

function SceneTrans:getFixedRotate()
    return Vector3(0, self.gridAngle, 0)
end



function SceneTrans:getShadowCenterAndRadius(state,isBattleFinished)
    local centerPoint = self.cameraCenterPointGo and self.cameraCenterPointGo.transform.position or self.centerPoint
    local x = centerPoint.x
    local y = centerPoint.y
    local z = centerPoint.z

    local radius, dis

    if isBattleFinished then
        -- 战斗结算时的模型展示视角
        radius = 3.5
        dis = 0
    elseif state.isZombie then
        -- 植物大战僵尸关卡视角
        dis = 3
        radius = 11

    else
        -- 普通战斗
        dis = 0
        radius = 8.5
    end

    if dis ~= 0 then
        local leftDir = self.leftDir
        x = x + leftDir.x * dis
        y = y + leftDir.y * dis
        z = z + leftDir.z * dis
    end

    return x, y, z, radius
end



function SceneTrans:setBattleStartOffset(cameraOffsetX)
    self.cameraCenterPointGo.transform.position = self.centerPoint + self.upDir * 1.2 + self.leftDir * (cameraOffsetX or 0) * 18
    self.centerPointGo.transform.position = self.centerPoint + self.leftDir * (cameraOffsetX or 0) * 18
end

function SceneTrans:GetSceneMusic()
    return self._sceneMusic
end



return SceneTrans
