
local DESTROY_TIME  = 10

ScenicControlMgr = Class("ScenicControlMgr", SystemBase)

function ScenicControlMgr:OnInit()
    self._FreePool = { }
    self._currTemplate = nil
    self._enableModel = true
    self:CrateRootObj()
    self:RegisterListerEvent()
end

function ScenicControlMgr:CrateRootObj()
    local obj  = UnityEngine.GameObject('ScenicRoot')
    obj.transform.localPosition  = Vector3(2000,2000,0)
    obj.transform.localRotation = Quaternion.Euler(0,0,0)

    UnityEngine.Object.DontDestroyOnLoad(obj)
    self._rootObj = obj --舞台对象“ScenicRoot”
end

function ScenicControlMgr:RegisterListerEvent()
    self._evtScenicLoad = function(scenicType,modelTag) self:ScenicLoadFun(scenicType,modelTag) end
    self._evtScenicUnLoad = function() self:ScenicUnLoadFun() end
    self._evtScenicEnableModle = function() self:SetModelEnable(true) end
    self._evtScenicDisableModle = function() self:SetModelEnable(false) end

    EventManager.Global.RegisterEvent(EventType.ScenicLoad, self._evtScenicLoad)
    EventManager.Global.RegisterEvent(EventType.ScenicUnLoad, self._evtScenicUnLoad)
    EventManager.Global.RegisterEvent(EventType.ScenicEnableModel, self._evtScenicEnableModle)
    EventManager.Global.RegisterEvent(EventType.ScenicDisableModel, self._evtScenicDisableModle)
end

--[[
 data
    data.sceneModlePath 
    data.roleObjPath
    data.scenePos
    data.roleObjPos
--]]
    
function ScenicControlMgr:ScenicLoadFun(scenicType,modelTag)

    Util.Scenic.SetScenicType(scenicType)

    -- 新参数为 scenicType 和 modelTag
    -- Scenic配置可以通过 Util.Scenic.GetScenicConfig(scenicType) 来获取
    -- 用 ModelUtils.getCommonModelData(modelTag)获取模型数据

    local scenicData = Util.Scenic.GetScenicConfig(scenicType)
    assert(scenicData~=nil,"ResScenicData 配置不存在 id ="..scenicType) 

    local modelCfg = Util.Scenic.GetModelConfig(modelTag)
    if modelCfg == nil then
        logerror("ResCommonModel Show Data is NUll: ", modelTag)
        return
    end


    local data = 
    {
        sceneModlePath  = scenicData.Sceeicpath,
        scenePos = scenicData.SceeicPos == nil and {0,0,0 } or scenicData.SceeicPos,
        show_TimeLinePath =  scenicData.timeline_type == 0 and modelCfg.show_model_path or modelCfg.show_timeline_path,
        show_TimeLinePos = scenicData.role_pos == nil and {0,0,0 } or scenicData.role_pos ,
        show_TimeLineRot =  scenicData.role_rot == nil and {0,0,0 } or scenicData.role_rot,
    }

    local modelScale = modelCfg.show_model_scale

    if self._currTemplate then
        self:ScenicUnLoadFun()
    end



    self._currTemplate =  {}
    local currTemplate = self._currTemplate
    currTemplate.scenicType = scenicType --缓存场景类型
    currTemplate.modelTag = modelTag --缓存模型类型
    currTemplate.timeline_type = scenicData.timeline_type
    currTemplate.sceneModlePath = data.sceneModlePath
    if not string.IsNilOrEmpty ( data.sceneModlePath) then
        local  obj  = nil
        if self._FreePool[data.sceneModlePath] then
            local poolData =  self._FreePool[data.sceneModlePath]
            obj = poolData.modle
            self._FreePool[data.sceneModlePath] = nil 
        else
            obj =  LuaCallCs.LoadPrefabSync(data.sceneModlePath)
        end

        if obj  then
            currTemplate.SceneModle = obj
            LuaCallCs.SetParentAndReset(self._rootObj,obj)
            LuaCallCs.SetGameObjLocalPosition(obj,data.scenePos[1],data.scenePos[2],data.scenePos[3])
            LuaCallCs.GameObjectActive(obj,true)
            LuaCallCs.Scenic.ChangeStageBackGround(obj, modelCfg.UI_BG_path..".png")
        end
    end


    if self._enableModel then
        currTemplate.show_TimeLinePath = data.show_TimeLinePath
        if not string.IsNilOrEmpty (data.show_TimeLinePath) then
            local  obj  = nil
            if self._FreePool[data.show_TimeLinePath] then
                local poolData =  self._FreePool[data.show_TimeLinePath]
                obj = poolData.modle
                self._FreePool[data.show_TimeLinePath] = nil
            else
                obj = LuaCallCs.LoadPrefabSync(data.show_TimeLinePath)
            end

            if obj  then
                currTemplate.TimeLineObjModle = obj

                if currTemplate.SceneModle then
                    local modelRootObj = LuaCallCs.GetObject(currTemplate.SceneModle,"ModelRoot")
                    LuaCallCs.SetParentAndReset((modelRootObj == nil and self._rootObj or modelRootObj),obj)
                else
                    LuaCallCs.SetParentAndReset(self._rootObj,obj)
                end
                LuaCallCs.SetGameObjectLocalScale(obj, modelScale)

                LuaCallCs.GameObjectActive(obj,true)
                LuaCallCs.ScenicHerotDragging(obj,10000,false)
                local propCamera_ =  LuaCallCs.GetObject(obj,"PropCamera_")
                LuaCallCs.GameObjectActive(propCamera_,false)

                local modelRoot =  LuaCallCs.GetObject(obj,"Model")

                local modelAnim = modelRoot == nil and obj or modelRoot
                --角色入场timeline是否播放过
                if(Util.Scenic.GetScenicTypeCacheAnim(data.show_TimeLinePath) ) then -- true => stop timeline 播放普通动作
                    LuaCallCs.ScenicHerotDragging(obj,10000,true)
                    if scenicData.timeline_type ~= 0 then
                        LuaCallCs.Timeline.Stop(obj )
                    end
                else -- false => play timeline 播放入场动作
                    if scenicData.timeline_type ~= 0 then
                        LuaCallCs.Timeline.Play(obj )
                        LuaCallCs.GameObjectActive(propCamera_,true)
                    end

                    LuaCallCs.ScenicHeroAnimactionForcePlay(modelAnim ,scenicData.entrance,function()
                        LuaCallCs.ScenicHerotDragging(obj,10000,true)
                        LuaCallCs.GameObjectActive(propCamera_,false)
                    end)
                    Util.Scenic.SetScenicTypeCacheAnim(data.show_TimeLinePath);
                end
                LuaCallCs.ScenicHeroAnimactionPlay(modelAnim, modelCfg.scenic_show_group, modelCfg.scenic_show_cd)

            end
        end
    end

end

function ScenicControlMgr:ScenicUnLoadFun()
    if self._currTemplate == nil then
        return
    end
    local data = self._currTemplate  
    if data.SceneModle  then
        if  self._FreePool[data.sceneModlePath]  then
            LuaCallCs.DisposePrefab( data.SceneModle)
        else
            LuaCallCs.GameObjectActive(data.SceneModle,false)
            self._FreePool[data.sceneModlePath] = {Time = DESTROY_TIME,modle = data.SceneModle }
        end
    else
        if(data.sceneModlePath) then
            LuaCallCs.ReleasePrefab(data.sceneModlePath)
        end
    end

    if data.TimeLineObjModle  then
        LuaCallCs.SetParentAndReset(self._rootObj,data.TimeLineObjModle)
        local modelRoot =  LuaCallCs.GetObject(data.TimeLineObjModle,"Model")
        LuaCallCs.DestroyScenicHeroAnimactionComp((modelRoot == nil and data.TimeLineObjModle or modelRoot))
        LuaCallCs.DestroyScenicHerotDragging(data.TimeLineObjModle)

        if  self._FreePool[data.show_TimeLinePath]  then
            LuaCallCs.DisposePrefab( data.TimeLineObjModle)
        else
            LuaCallCs.GameObjectActive(data.TimeLineObjModle,false)

            self._FreePool[data.show_TimeLinePath] = {Time = DESTROY_TIME,modle = data.TimeLineObjModle }
        end
    else
        if(data.show_TimeLinePath) then
            LuaCallCs.ReleasePrefab(data.show_TimeLinePath)
        end
    end

    --EventManager.Global.Dispatch(EventType.CameraMgrChangeCamera,CameraType.MainCamera)
    self._currTemplate = nil
end

function ScenicControlMgr:SetModelEnable(enable)
    if self._enableModel == enable then
        return
    end

    self._enableModel = enable
    if self._currTemplate ~= nil and self._currTemplate.SceneModle ~= nil then
        local modelRootObj = LuaCallCs.GetObject(self._currTemplate.SceneModle,"ModelRoot")
        if modelRootObj ~= nil then
            LuaCallCs.GameObjectActive(modelRootObj, enable)
        end
    end

    if enable and self._currTemplate ~= nil then
        local scenicType = self._currTemplate.scenicType
        local modelTag = self._currTemplate.modelTag
        self:ScenicLoadFun(scenicType, modelTag)
    end
end


function ScenicControlMgr:UnRegisterListerEvent()
    EventManager.Global.UnRegisterEvent(EventType.ScenicLoad, self._evtScenicLoad)
    EventManager.Global.UnRegisterEvent(EventType.ScenicUnLoad, self._evtScenicUnLoad)
    EventManager.Global.UnRegisterEvent(EventType.ScenicEnableModel, self._evtScenicEnableModle)
    EventManager.Global.UnRegisterEvent(EventType.ScenicDisableModel, self._evtScenicDisableModle)
end


local count = 1
function ScenicControlMgr:Update(deltaTime, unscaledDeltaTime)
    local dTime = deltaTime
    self:Tick(dTime)
end

function ScenicControlMgr:Tick(dTime)
    for path ,value in pairs(self._FreePool) do 
        value.Time = value.Time  - dTime
         if value.Time<=0 then
             LuaCallCs.DisposePrefab(value.modle)
             self._FreePool[path] = nil 
         end
    end
end

function ScenicControlMgr:ImmediatelyClear()
    for path ,value in pairs(self._FreePool) do 
        LuaCallCs.DisposePrefab(value.modle)
        self._FreePool[path] = nil 
    end

end

function ScenicControlMgr:ImmediatelyClearAll()
    self:ScenicUnLoadFun()
    self:ImmediatelyClear()
    Util.Scenic.ClearScenicCacheAnim()
end

function ScenicControlMgr:OnGameStart()
    GameUpdate:Get():AddUpdate(GameUpdateID.ScenicControl , self.Update, self)
end

function ScenicControlMgr:OnGameEnd()
    GameUpdate:Get():RemoveUpdate(GameUpdateID.ScenicControl)
    self:UnRegisterListerEvent()
    self:ImmediatelyClearAll()
end

function ScenicControlMgr:OnClear()
    GameUpdate:Get():RemoveUpdate(GameUpdateID.ScenicControl)
    self:UnRegisterListerEvent()
    self:ImmediatelyClearAll()
end