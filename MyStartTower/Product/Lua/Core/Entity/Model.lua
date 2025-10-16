---------------------------------
-- TODO:染色相关
-- shaderLodHigh-->applyShaderLod
---------------------------------
require("Optimize/Module/Battle/BattleRes/Manager/BattleEffectManager")
local ModelTool = require "Core/Entity/ModelTool"

local Model = Class("Model")

-- 构造函数:如果跟entity绑定,则传入entityID
-- 不传则代表不是entity的model
-- oriModelData{
--      model_type  可选，Const.MODEL_TYPE
--      model_id    model_type为默认时，必须存在
--      animator    model_type为默认时，必须存在，全路径包括后缀
--      path        model_type为Simple时，必须存在
--      use_lod     可选int  0 原模型  1 lod简模  2 高模
--      scale       可选float  保持原样为1  会在CommonModelData的基础上进行缩放
--      star        英雄星级
-- }
function Model:ctor(loadedCallback, entityId )
    if not entityId then
        entityId = -1
    end
    self:InitField()
    --self._parentId = entityId
    -- 加载完毕后模型自己做的处理
    --self._isLoaded = false
    --self._loadedCallback = {}
    if loadedCallback then
        self:addLoadedCallback(loadedCallback)
    end
end

function Model:destroy()
    if self.isInCallback then
        self.destroyAfterCallback = true
        return
    end

    self:releaseGameObject()
    --self:clearLoadedCallback()
    self:InitField()
end

---@private 初始化字段
function Model:InitField()
    self._modelGuid = "" ---@type string model的唯一标识
    self._isLoaded = false ---@type boolean 是否加载完毕
    self.modelAux = nil ---@type ModelAux model的辅助脚本（C#）
    self._modelInstance = nil ---@type GameObject model的游戏物体
    self._loadedCallback = {} ---@type fun() model加载完毕后的回调函数列表
end

----------------------Data--------------------------------------
function Model:setModelData( oriData )  -- 兼容之前写的结构，数据已经打包好了
    self._modelData = ModelTool.analyzeModelData(oriData)
end




-----------------------Load--------------------------------------
-- 真正开始加载的过程
function Model:loadGameObject(isSync, needShow)
    if not self._modelData["avatar"] then
        logerror("Avatar is null.")
        return
    end
    if needShow == nil then
        needShow = true 
    end
    self.showOnLoaded = needShow
    if not isSync then
        local modelData = ModelData():WithAssetPath(self._modelData.avatar)
                                     :WithTag(self._modelData.model_id)
                                     :WithAnimator(self._modelData.animator)

        self._modelGuid, self._modelInstance = BattleModelManager.GetFromCache(modelData)
        LuaCallCs.Battle.ModelBindAnimator(self._modelInstance, modelData:GetAnimator())
        self.modelAux = LuaCallCs.GetComponent.GetModelAux(self._modelInstance)
        self.modelAux:WithRecycleAction( function() BattleModelManager.ReturnToCache(self._modelGuid) end)
        self.modelAux:Init(self._modelGuid)
        self:onModelObjectLoaded()
        --self._modelInsId = ModelFactory.CreateModelAll(self._modelData, Functor(self.onModelObjectLoaded, self), self.showOnLoaded, LoaderMode.Async)
    else
        logerror("Model:loadGameObject() does not support sync loading!!")
    end
end

function Model:releaseGameObject( )

    if self.modelAux then
        self.modelAux:Recycle() -- 已通过self.modelAux:WithRecycleAction(...)注册了回收事件
    end

    --if self._modelGuid then
    --    BattleModelManager.ReturnToCache(self._modelGuid)
    --end

    --if self._modelInsId then
    --    ModelFactory.ReleaseModel(self._modelInsId)
    --    self._modelInsId = nil
    --    self._modelInstance = nil
    --end
end

-- 注册模型加载后的回调,是model:onModelObjectLoaded最后一步
function Model:addLoadedCallback( func )
    table.insert(self._loadedCallback, func)
end

function Model:clearLoadedCallback(  )
    self._loadedCallback = {}
end


function Model:isLoaded()
    return self._isLoaded
end

function Model:GetModel()
    return self._modelInstance
end


-- 模型加载完毕后的回调,在里面执行注册的函数
-- 不鼓励重写此函数,而使用注册的方式(addLoadedCallback)
-- sealed
function Model:onModelObjectLoaded()
    --self._modelInsId = modelId
    --self._modelInstance = ModelFactory.GetModelObject(self._modelInsId)
    --self.modelAux = self._modelInstance:GetComponent(ModelAuxType)
    -- self:applyShaderLod() -- apply shaderLod before recoloring
    -- self:_initApplyDressColor()
    --self.modelAux = self._modelInstance:GetComponent(ModelAuxType)

    self:_scaleModel()
    self._isLoaded = true

    self.isInCallback = true
    if self._loadedCallback then
        for k,v in pairs(self._loadedCallback) do
            if nil ~= v then
                v(self)
            end
        end  
    end
    self.isInCallback = false

    -- 发型有两个特殊逻辑，此处处理2
    -- 1. 华服的fixedsuit标记，使得只能使用华服套装自带的发型
    -- 2. 当装备非华服套装原配发型时，body节点下面，名称带orighair的要隐藏
    -- self:checkIfDisableDressExclusiveParts()

    if self.destroyAfterCallback then
        self.destroyAfterCallback = nil
        self:destroy()
    end
end








-------------------Change---------------------------





function Model:changeModelAll( oriModelData, callback )
    logerror("Model:changeModelAll()已废弃, 请检查堆栈调用")
    --self._modelData = ModelTool.analyzeModelData(oriModelData)
    --ModelFactory.ReplaceModelAll(self._modelInsId, self._modelData, callback)
end


-------------------提供的Public接口-------------------------
function Model:showModel( needShow )
    --ModelFactory.ShowModelAll(self._modelInsId, needShow)
    LuaCallCs.GameObjectActive(self:GetModel(), needShow)
end

--function Model:getModelObject(  )
--    if not self._modelInstance then
--        self._modelInstance = ModelFactory.GetModelObject(self._modelInsId)
--    end
--    return self._modelInstance
--end




local AnimatorType = typeof(UnityEngine.Animator)
function Model:getAnimator(  )
    if self:GetModel() then
        return self:GetModel():GetComponent(AnimatorType)
    end
end


function Model:setModelLayer( layer )
    --if self._modelInsId and layer ~= nil and layer >= 0 then
    --    ModelFactory.SetModelLayer(self._modelInsId, layer)
    --    self._modelInsLayer = layer
    --end

    if self.modelAux then
        self.modelAux:SetLayerRecursively(layer)
        self._modelInsLayer = layer
    end
end

function Model:getModelLayer( ... )
    return self._modelInsLayer
end










function Model:setVisible( isVisible )
    local go = self:GetModel()
    if go then
        local param = 0
        if isVisible then
            param = 1
        end
        Framework.Tools.LuaToolkit.SetGoActive(go, param)
    end
    self._visible = isVisible
end

function Model:setScale( scale )
    self._modelData["scale"] = scale
    self:_scaleModel()
end

function Model:getScale(  )
    return self._modelData["scale"] or 1
end

function Model:setModelVisible(visible)
    if self:modelAuxValid() then
        if visible then
            self.modelAux:ReshowModel()
        else
            self.modelAux:HideModel(false)
        end
    end
end



function Model:setAllVisible(visible)
    if self:GetModel() then
        self:GetModel():SetActive(visible and true or false)
    end
end



function Model:playAnimation(animName, updateNow)
    --print(self.modelAux)
    if self:modelAuxValid() then
        if updateNow then
            self.modelAux:PlayAnimatorNow(animName)
        else
            self.modelAux:PlayAnimator(animName)
        end
    end
end



function Model:playAnimationWithDuration( animName, duration )
    if self:modelAuxValid() then
        duration = duration or 0.0
        self.modelAux:PlayAnimatorByDuration(animName, duration)
    end
end





function Model:setAnimSpeed( speedParamName, animSpeed )
    if self:modelAuxValid() then
        self.modelAux:SetFloatParam(speedParamName, animSpeed)
    end
end

function Model:setModelAlwaysAnim(  )
    if self:modelAuxValid() then
        self.modelAux:SetAnimatorNoCulling()
    end
end








function Model:addMaterial( materialPath )
    if self:modelAuxValid() then 
        self.modelAux:AddMaterial(materialPath, false)
    end
end

function Model:delMaterial( materialPath )
    if self:modelAuxValid() then
        self.modelAux:DelMaterial(materialPath, false)
    end
end




function Model:recoverMaterial( ... )
    if self:modelAuxValid() then
        self.modelAux:RecoverMaterials()
    end
end

function Model:setMaterialTransparency( )
    if self:modelAuxValid() then
        self.modelAux:SetMaterialTransparency()
    end
end

function Model:revertMaterialTransparency( ... )
    if self:modelAuxValid() then
        self.modelAux:RevertMaterialTransparency()
    end
end

function Model:smoothSetMaterialTrans( startValue, endValue, duration, callback )
    if self:modelAuxValid() then
        self.modelAux:SmoothSetBlendAlpha(startValue, endValue, duration, callback)
    end
end


function Model:setMaterialFresnel(color,size)
    if self:modelAuxValid() then
        local uColor = UnityEngine.Color(color.r, color.g, color.b, color.a)
        self.modelAux:SetMaterialFresnel(uColor,size)
    end
end

function Model:revertMaterialFresnel( ... )
    if self:modelAuxValid() then
        self.modelAux:RevertMaterialFresnel()
    end
end

function Model:smoothSetMaterialFresnel( startValue, endValue, duration, callback )
    if self:modelAuxValid() then
        self.modelAux:SmoothSetFresnel(startValue, endValue, duration, callback)
    end
end

function Model:mirrorModel( needMirror )
    if self:modelAuxValid() then
        if needMirror then
            self.modelAux:MirrorModel()
        else
            self.modelAux:ResetMirror()
        end
    end
end

function Model:setOutline( isOn )
    -- if self:modelAuxValid() then
        -- self.modelAux:SetOutlineState(isOn)
    -- end
end

function Model:setTonemapping( isOn )
    if self:modelAuxValid() then
        self.modelAux:SetTonemapping(false)  -- 杨迪需求，所有加载出来的模型都不用tonemapping
    end
end

function Model:setRainyMat( isOn )
    if self:modelAuxValid() then
        self.modelAux:SetRainyAdjust(isOn)
    end
end

function Model:setFootStep( groupId )
    if self:modelAuxValid() then
        self.modelAux:SetFootStepGroup(groupId)
    end
end

function Model:setMute( soundIsMute, vocalIsMute )
    if self:modelAuxValid() then
        self.modelAux:SetModelMute(soundIsMute, vocalIsMute)
    end
end

function Model:modelAuxValid()
    return self.modelAux and not tolua.isnull(self.modelAux)
end

----------------------私有函数--------------------
function Model:_scaleModel(  )
    local modelScale = self._modelData["scale"]
    --if modelScale and modelScale ~= 1 then
    --    ModelFactory.ScaleModelAll(self._modelInsId, modelScale)
    --end

    if modelScale and self.modelAux then
        self.modelAux:SetLocalScale(modelScale)
    end
end







----------------------静态函数-------------------------------



-----------------------时装 染色-----------------------




return Model