local Model = require "Core/Entity/Model"

local EntityFactory = Framework.Entity.EntityFactory

local Entity = Class("Entity")

local Const = Const
local Vector3 = Vector3
local Slot = Slot

--entity
-- 1.持有1个gameobject
-- 2.gameobject上挂有 entityController，与C#交互

--可选Component：1.model 2.movement 3.topNum 4.NavmeshAgent  5.Collider

function Entity:ctor(entityId, entityName)
    self.entityType = Const.WORLD_ENTITY_UNKNOWN
    self.id = tonumber(entityId)
    self.name = entityName
    self.logicGroup = GameFsm.getCurState().stateName
    self.controller = EntityFactory.CreateEntity(self.id, self.name, self.logicGroup)
    self.gameObject = self.controller.gameObject
    self.modelLoaded = false    --是否载入模型
    self._cachedPos = Vector3(0, 0, 0)      --缓存的位置对象，用于减少每帧的内存分配
    self:registerCallback()

    self:initEntityComponent()
end

function Entity:isDestroyed()
    return self._isDestroyed and true or false
end

function Entity:destroy()
    self._isDestroyed = true
    
    self:onDeselected()
    self:revertChilds()
    self:releaseModel()
    EntityFactory.ReleaseEntity(self.id)
    self:clearCallback()
    self.controller = nil
    self.gameObject = nil
end

function Entity:registerCallback( )

    -- c#callback print_func_ref_by_csharp
    -- self.objectSelectedCallback = Slot(self.OnEntitySelected, self)
    self.objectSelectedCallback = function(...)
        return self:OnEntitySelected(...)
    end
    -- self.objectLongTapCallback = Slot(self.OnEntityLongTap, self)
    self.objectLongTapCallback = function(...)
        return self:OnEntityLongTap(...)
    end

    self.controller:RegisterDelegate(Const.ENTITY_DELEGATE_EVENT.OnObjectSelected, self.objectSelectedCallback)
    self.controller:RegisterDelegate(Const.ENTITY_DELEGATE_EVENT.OnObjectLongTap, self.objectLongTapCallback)
end

function Entity:clearCallback( )
    self.controller:CancelDelegate(Const.ENTITY_DELEGATE_EVENT.OnObjectSelected)
    self.controller:CancelDelegate(Const.ENTITY_DELEGATE_EVENT.OnObjectLongTap)

    if self.objectSelectedCallback then
        self.objectSelectedCallback = nil
    end
    if self.objectLongTapCallback then
        self.objectLongTapCallback = nil
    end
    if self.enterTriggerCallback then
        self.enterTriggerCallback = nil
    end
    if self.exitTriggerCallback then
        self.exitTriggerCallback = nil
    end
    if self.modelLoadedCallback then
        self.modelLoadedCallback = nil
    end
    if self.mModelLoadedCallback then
        self.mModelLoadedCallback = nil
    end
end

-- 注册模型加载后的回调,发生在OnModelLoadedEnd之前,是model:onModelObjectLoaded最后一步
function Entity:addModelLoadedDelegate(func)
    self.entityModel:addLoadedCallback(func)
end



-- virtual
function Entity:initEntityComponent(  )

end

-- virtual
function Entity:getLayer()
    return Const.LAYER_UNDEFINED
end


------------------------------模型相关操作----------------------------
-- 创建模型
function Entity:createModel(modelData)
    self:_createModel(modelData)
end

function Entity:_createModel(modelData)
    if not self.modelLoadedCallback then
        self.modelLoadedCallback = Slot(self.OnModelLoadedEnd, self)
    end

    if self.entityModel ~= nil then
        logerror("Entity:createModel() called again with model already created!!")
        self.entityModel:destroy()
        self.entityModel = nil
    end
    self.modelLoaded = false
    if self.entityModel == nil and modelData then
        self.entityModel = Model( self.modelLoadedCallback, self.id)
        self.entityModel:setModelData(modelData)
        self.entityModel:loadGameObject()
    end 
    return self.entityModel
end

--默认直接调用真正的_releaseModel方法
function Entity:releaseModel()
    self:_releaseModel()
end

function Entity:_releaseModel()
    if self.entityModel then
        self.entityModel:destroy()
        self.entityModel = nil
    end
    self.controller:OnModelReleased()
    self.modelLoaded = false
end

function Entity:isModelLoaded()
    return self.modelLoaded
end



-------------------Entity 用到的委托----------------------
-- 模型加载完毕
function Entity:OnModelLoadedEnd(  )
    self.controller:InitModelAfterLoaded(self.entityModel:GetModel())
    self.modelLoaded = true
    self.entityModel:setModelLayer(self:getLayer())
    --self.entityModel:setOutline(false)
    if self.mModelLoadedCallback then
        self.mModelLoadedCallback()
    end
end

-- entity被选中
function Entity:OnEntitySelected(keepAutoNav)
    -- local ca = GameContext.CurrentEntity
    -- local worldPlayer = ca and ca.tstpMgr.player
    -- if worldPlayer then
    --     worldPlayer:onSelectEntity(self)
    -- end
end

-- entity被长按
function Entity:OnEntityLongTap(  )
end

--------------------Entity 用到的委托函数 END-------------------

---------------Public-----------------------
----- Play animator ----------
function Entity:playAnimator( animName )
    if self.modelLoaded and self.entityModel then
        animName = self:_checkMotionChanged(animName)
        self.entityModel:playAnimation(animName, true)
    end
end



function Entity:playAnimationWithDuration( animName, duration )
    if self.modelLoaded and self.entityModel then
        animName = self:_checkMotionChanged(animName)
        self.entityModel:playAnimationWithDuration( animName, duration )
    end
end

function Entity:setAnimSpeed( animSpeed )
    if self.modelLoaded and self.entityModel then
        self.entityModel:setAnimSpeed( "speed", animSpeed )
    end
end



function Entity:changeMotion( oldStateName, newStateName )
    if not self._motionChangeDict then
        self._motionChangeDict = {}
    end
    self._motionChangeDict[oldStateName] = newStateName
end

function Entity:recoverMotion( oldStateName )
    if self._motionChangeDict then
        self._motionChangeDict[oldStateName] = nil
    end
end

function Entity:_checkMotionChanged( stateName )
    if self._motionChangeDict and self._motionChangeDict[stateName] then
        return self._motionChangeDict[stateName]
    else
        return stateName
    end
end

------- model --------
function Entity:setModelVisible( isVisible )
    if self.modelLoaded and self.entityModel then
        self.entityModel:setModelVisible(isVisible)
    end
end

function Entity:addMaterial( materialPath )
    if self.modelLoaded and self.entityModel then
        self.entityModel:addMaterial(materialPath)
    end
end

function Entity:delMaterial( materialPath )
    if self.modelLoaded and self.entityModel then
        self.entityModel:delMaterial(materialPath)
    end
end

function Entity:recoverMaterial( ... )
    if self.modelLoaded and self.entityModel then
        self.entityModel:recoverMaterial()
    end
end

function Entity:fadeInTransparency( alpha, duration )
    if self.modelLoaded and self.entityModel then
        self.entityModel:setMaterialTransparency()
        self.entityModel:smoothSetMaterialTrans(1, alpha, duration)
    end
end

function Entity:fadeOutTransparency(alpha, duration )
    if self.modelLoaded and self.entityModel then
        if duration <= 0 then
            self:_revertTransparency()
        else
            if not self.slotOfRevertTran then
                self.slotOfRevertTran = Slot(self._revertTransparency, self)
            end
            self.entityModel:smoothSetMaterialTrans(alpha, 1, duration, self.slotOfRevertTran)
        end
    end
end

function Entity:_revertTransparency(  )
    if self.modelLoaded and self.entityModel then
        self.entityModel:revertMaterialTransparency()
    end
end

function Entity:fadeInFresnel(color, size, amount, duration )
    if self.modelLoaded and self.entityModel then
        self.entityModel:setMaterialFresnel(color,size)
        self.entityModel:smoothSetMaterialFresnel(0, amount, duration)
    end
end

function Entity:fadeOutFresnel(amount, duration )
    if self.modelLoaded and self.entityModel then
        if duration <= 0 then
            self:_revertFresnel()
        else
            if not self.slotOfRevertFresnel then
                self.slotOfRevertFresnel = Slot(self._revertFresnel, self)
            end
            self.entityModel:smoothSetMaterialFresnel(amount, 0, duration, self.slotOfRevertFresnel)
        end
    end
end

function Entity:_revertFresnel(  )
    if self.modelLoaded and self.entityModel then
        self.entityModel:revertMaterialFresnel()
    end
end

-- 变形
function Entity:modelTransform( commonModelId )
end

function Entity:recoverModelTransform(  )
end
------- animate offset--------------
function Entity:startAnimationOffset(clipUrl)
    if not self.animOffsetAux then
        self:addAnimationOffsetAux()
    end
    if self.animOffsetAux then
        self.animOffsetAux:StartAnimationOffset(clipUrl)
    end
end

function Entity:stopAnimationOffset(  )
    if self.animOffsetAux then
        self.animOffsetAux:StopAnimationOffset()
    end
end

------- Show number----------------

---@type fun(data:FloatingWordsData) 显示飘字
---@param data FloatingWordsData 飘字数据
function Entity:ShowWords(data)
    LuaCallCs.FloatingWords.ShowWord(self.gameObject, data)
end

------ Components------
function Entity:addNavmeshAgent(  )
    if not self.controller then
        return
    end
    self.navMeshAgent = self.controller:AddNavmeshAgent()
    if not self.navMeshAgent then
        logerror("Can't add navMeshAgent to entity!")
        return
    end
    self.navMeshAgent.angularSpeed = 1000
    self.navMeshAgent.acceleration = 1000
    self.navMeshAgent.autoBraking = true
    self.navMeshAgent.updateRotation = false
    self.navMeshAgent.stoppingDistance = 0
    --self.navMeshAgent.baseOffset = -0.1
end

function Entity:addBoxCollider(  )
    local collider = self.controller:AddBoxCollider()
    collider.center = Vector3(0, 1.5, 0)
    collider.size = Vector3(2, 3, 2)
    collider.isTrigger = true
end

function Entity:addMovementAux()
    self.movementAux = self.controller:AddMovementAux()
    if not self.movementAux then
        logerror("Can't add MovementAUx to entity!")
        return
    end
end

function Entity:addAnimationOffsetAux(  )
    self.animOffsetAux = self.controller:AddAnimationOffsetAux()
    if not self.animOffsetAux then
        logerror("Can't add AnimationOffsetAux to entity!")
        return
    end
end

--------- child effect--------------------
function Entity:addChild( child, localPosition )
    if not self._childList then
        self._childList = {}
    end
    table.insert(self._childList, child)
    child.gameObject.transform.parent = self.gameObject.transform
    child.gameObject.transform.localPosition = localPosition   
end

function Entity:revertChilds(  )
    if not self._childList then
        return
    end
    for index, child in ipairs(self._childList) do
        if not tolua.isnull(child) and child.gameObject~=nil then
            child.gameObject.transform.parent = nil
            if child.turnOn then
                child:TurnOff()
            end
        end
    end
    self._childList = {}
end

-- 单独给选中特效增加接口
function Entity:addSelectedEffect( controller, localPosition )
    self.selectedEffect = controller
    local controllerTransform = controller.gameObject.transform
    if controllerTransform and self.gameObject then
        controllerTransform.parent = self.gameObject.transform
        controllerTransform.localPosition = localPosition   
    end
end

function Entity:onDeselected(  )
    if self.selectedEffect then
        local controller = self.selectedEffect
        controller.gameObject.transform.parent = nil
        if controller.turnOn then
            controller:TurnOff()
        end
        self.selectedEffect = nil
    end
end



------- position
function Entity:getPositionXYZ()
    if self.controller then
        local x, y, z
        x, y, z = self.controller:GetPosition(x,y,z)
        return x, y, z
    end
end

-- 注意本函数会有内存分配，不要在高频逻辑中使用。
function Entity:getPosition( )
    if self.controller then
        self:getPositionByCache()
        return Vector3(self._cachedPos.x, self._cachedPos.y, self._cachedPos.z)
    end
end

--使用缓存的版本，获取的坐标对象立即使用，并不会缓存，用于需要高频调用的地方
function Entity:getPositionByCache()
    if self.controller then
        local x, y, z
        x, y, z = self.controller:GetPosition(x,y,z)
        self._cachedPos.x = x
        self._cachedPos.y = y
        self._cachedPos.z = z
        return self._cachedPos
    end
end

function Entity:getInteractPosArray()
    local x, y, z = self:getPositionXYZ()
    return {x, y, z}
end

function Entity:getRotation(  )
    if self.controller then
        local x, y, z
        x, y, z = self.controller:GetRotation(x, y, z)
        return Vector3(x, y, z)
    end
end

function Entity:getRotationXYZ(  )
    if self.controller then
        local x, y, z
        x, y, z = self.controller:GetRotation(x, y, z)
        return x, y, z
    end
end

--调用C#提供的接口 gameobject的transform的position
function Entity:teleport(x, y, z)
    if self.controller then
        self.controller:Teleport(x,y,z)
    end
end

function Entity:teleportInTime( endPos,time,callBack )
    if self.controller then
        self.controller:TeleportInTime(endPos,time,callBack)
    end
end

function Entity:setRotate(y, x, z)
    local rotate = y or 0
    local x = 0 or x
    local z = 0 or z
    if self.controller then
        self.controller:Rotate(x, rotate, z)
    end
end

function Entity:setRotation( y, x, z )
    local x = x or 0
    local z = z or 0
    if y and self.controller then 
        self.controller:SetRotation(x, y, z)
    end
end

function Entity:setFaceToPos(x, y, z)
    local x0, y0, z0 = self:getPositionXYZ()
    local dir = math.atan2(x- x0, z - z0) / math.pi * 180
    self:setRotation(dir)
end

function Entity:setVisible(visible)
    if self.controller then
        self.controller:SetVisible(visible)
    end
end

function Entity:getVisible()
    if self.controller then
        return self.controller:GetVisible()
    end
    return false
end

function Entity:GetMountPosition(mountType)
    local x, y, z = 0, 0, 0
    if self.controller then
        x, y, z = self.controller:GetMountPosition(mountType, x, y, z)
        return x, y, z
    end
    return x, y, z
end

function Entity:GetMountRotation(mountType)
    local x, y, z = 0, 0, 0
    if self.controller then
        x, y, z = self.controller:GetMountRotation(mountType, x, y, z)
        return x, y, z
    end
    return x, y, z
end

return Entity
