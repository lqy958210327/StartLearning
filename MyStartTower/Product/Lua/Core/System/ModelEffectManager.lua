local strClassName = "ModelEffectManager"
local ModelEffectManager = Class(strClassName)

local DOTweenComponent = Framework.EffectSystem.DOTweenComponent
local CueDataBank = EditorTable.CueDataBank
-----------------------------
-- 模型特效Manager，有如下隐藏规则
--  1. 每个模型身上每种类型的特效同时只能存在一份
--  2. 如果存在多份，生命周期以后面的为主
-- 
-- TODO:
--  1. entityId没必要引入，考虑直接用actor作为key？
-----------------------------
function ModelEffectManager:ctor()
    assert(ModelEffectManager._instance == nil, "[ERROR] The ModelEffectManager instance is created already!")
    --print("ModelEffectManager ctor")
    self:init()
end

local EffectType = {
    ["Scale"] = 0,
    ["Hide"] = 1,
    ["AddMaterial"] = 2,
    ["ChangeMotion"] = 3,
    ["ChangeModel"] = 4,
    ["Transparency"] = 5,
    ["Fresnel"] = 6,
}
function ModelEffectManager:init(  )
    self.effectStayDict = {
        [EffectType.Scale] = {},    -- 模型缩放的常驻情况
        [EffectType.Hide] = {},     -- 模型隐藏的常驻情况
        [EffectType.AddMaterial] = {},-- 模型增加材质的常驻情况
        [EffectType.ChangeMotion] = {}, -- 模型替换动作的常驻情况
        [EffectType.ChangeModel] = {}, -- 替换模型的常驻情况
        [EffectType.Transparency] = {}, -- 模型透明的常驻情况
        [EffectType.Fresnel] = {}, -- 菲涅尔的常驻情况
    }
    self.modelEffectTimer = { 
        [EffectType.Scale] = {}, 
        [EffectType.Hide] = {}, 
        [EffectType.AddMaterial] = {},
        [EffectType.ChangeMotion] = {},
        [EffectType.ChangeModel] = {},
        [EffectType.Transparency] = {},
        [EffectType.Fresnel] = {},
    }

    self.recoverFuncMap = {
        [EffectType.Scale] = self.recoverModelScale,
        [EffectType.Hide] = self.recoverModelHide,
        [EffectType.AddMaterial] = self.recoverModelMaterial,
        [EffectType.ChangeMotion] = self.recoverModelMotion,
        [EffectType.ChangeModel] = self.recoverModelChange,
        [EffectType.Transparency] = self.recoverModelTransparency,
        [EffectType.Fresnel] = self.recoverModelFresnel,
    }
end

function ModelEffectManager:destroy( )
    self:stopAllTimer()
end

function ModelEffectManager:stopAllTimer(  )
    for timerType, entityDict in pairs(self.modelEffectTimer) do
        for entityId, timerDict in pairs(entityDict) do
            for effectId, timer in pairs(timerDict) do
                timer:Stop()
                timer = nil
            end
        end
    end
end

----------------Public--------------------------------------------------
function ModelEffectManager:playModelEffect( actor, effectId ,effectData)
    if not actor or not effectData then
        logerror("ModelEffectManager:playModelEffect,args error here!",actor, effectId)
        return
    end
    local effectType = effectData["type"]
    if effectType == EffectType.Scale then
        local scaleParam = effectData["modelScale"]
        if scaleParam then
            local scale = scaleParam["scale"]
            local mode = scaleParam["mode"]
            local duration = effectData["fadeIn"]
            self:playModelScale(actor, scale, duration, mode)
        end
    elseif effectType == EffectType.Hide then
        local hideParam = effectData["modelHide"]
        if hideParam then
            local hideHpLogo = hideParam["hideHpLogo"]
            local hideDamageNum = hideParam["hideDamageNum"]
            local skipHideModel = hideParam["skipHideModel"]
            self:playModelHide(actor, hideHpLogo, hideDamageNum, skipHideModel)
        end
    elseif effectType == EffectType.AddMaterial then
        local materialParam = effectData["modelAddMaterial"]
        if materialParam then
            local partStr = materialParam["part"]
            local materialPath = materialParam["materialPath"]
            self:playAddMaterial(actor, materialPath)
        end
    elseif effectType == EffectType.ChangeMotion then
        local motionParam = effectData["modelChangeMotion"]
        if motionParam then
            local oldStateName = motionParam["oldStateName"]
            local newStateName = motionParam["newStateName"]
            self:playChangeMotion(actor, oldStateName, newStateName)
        end
    elseif effectType == EffectType.ChangeModel then
        logerror("请检查effectId: "..effectId.." ; 替换模型功能已废弃")
        --local modelParam = effectData["modelChangeAll"]
        --if modelParam then
        --    local commonModelId = modelParam["commonModelId"]
        --    local animator = modelParam["animator"]
        --    local defaultAnim = modelParam["defaultAnim"]
        --    self:playChangeModelAll(actor, commonModelId, animator, defaultAnim)
        --end
    elseif effectType == EffectType.Transparency then
        local transparentParam = effectData["modelTransparency"]
        if transparentParam then
            local duration = effectData["fadeIn"]
            local alpha = transparentParam["alpha"]
            self:playModelTransparency(actor, alpha, duration)
        end
    elseif effectType == EffectType.Fresnel then
        local fresnelParam = effectData["modelFresnel"]
        if fresnelParam then
            local duration = effectData["fadeIn"]
            local amount = fresnelParam["amount"]
            local color = fresnelParam["color"]
            local size = fresnelParam["size"]
            self:playModelFresnel(actor, color, size, amount, duration)
        end
    end

    local howToPlay = effectData["howToPlay"]   -- 播放设置
    local length = effectData["length"]
    local entityId = actor.entityId
    if length and length > 0 then
        -- 定时回收的特效
        if not self.modelEffectTimer[effectType][entityId] then
            self.modelEffectTimer[effectType][entityId] = {}
        end
        if self.modelEffectTimer[effectType][entityId][effectId] then
            self.modelEffectTimer[effectType][entityId][effectId]:Stop()
            self.modelEffectTimer[effectType][entityId][effectId] = nil
        end
        self.modelEffectTimer[effectType][entityId][effectId] = Timer.New(Functor(self.recoverModelEffect, self, actor, effectId), length, 1, true)
        self.modelEffectTimer[effectType][entityId][effectId]:Start()
    else
        -- 常驻特效
        if not self.effectStayDict[effectType][entityId] then
            self.effectStayDict[effectType][entityId] = {}
        end
        self.effectStayDict[effectType][entityId][effectId] = true
    end 
end


function ModelEffectManager:recoverModelEffect( actor, effectId )
    local cueData = CueDataBank.getCueData(effectId)
    if not cueData then
        return
    end
    if not actor then
        return
    end
    local effectData = cueData["ModelEffect"]
    local effectType = effectData["type"]
    local length = effectData["length"]
    local entityId = actor.entityId
    -- 清理定时器
    if self.modelEffectTimer[effectType][entityId] and 
       self.modelEffectTimer[effectType][entityId][effectId] then
        self.modelEffectTimer[effectType][entityId][effectId]:Stop()
        self.modelEffectTimer[effectType][entityId][effectId] = nil
    end
    if not actor.gameObject then
        return
    end
    if length and length > 0 then
        -- 回收定时资源
        if not self.effectStayDict[effectType][entityId] or not self.effectStayDict[effectType][entityId][effectId] then
            -- 如果不存在常驻效果,则复位,如果存在则不进行操作
            self.recoverFuncMap[effectType](self, actor, effectId, effectData)
        end
    else
        -- 回收常驻特效
        self.recoverFuncMap[effectType](self, actor, effectId, effectData)
        if self.effectStayDict[effectType][entityId] then
            self.effectStayDict[effectType][entityId][effectId] = nil
        end
    end

end

function ModelEffectManager:clearEntityModelEffect( actor )
    if not actor or not actor.gameObject or not actor.entityId then
        return
    end

    local entityId = actor.entityId
    -- 常驻特效
    for effectType, entityDict in pairs(self.effectStayDict) do
        local effectDict = entityDict[entityId]
        if effectDict then
            for effectId, _ in pairs(effectDict) do
                self:recoverModelEffect(actor, effectId)
            end
        end
    end

    -- 定时器特效
    for effectType, entityDict in pairs(self.modelEffectTimer) do
        local timerDict = entityDict[entityId]
        if timerDict then
            for effectId, timer in pairs(timerDict) do
                if timer then
                    timer:Invoke()  -- 回调里已经清理定时器了  
                end
            end
        end
    end
end

local DOTweenComponentType = typeof(DOTweenComponent)
function ModelEffectManager:playModelScale( actor, scaleRate, duration, mode )
    local dotCompoent = actor.gameObject:GetComponent(DOTweenComponentType)
    if not dotCompoent then
        dotCompoent = actor.gameObject:AddComponent(DOTweenComponentType)
    end
    dotCompoent:Scale(scaleRate, duration, mode)
end

function ModelEffectManager:recoverModelScale( actor, effectId )
    local dotCompoent = actor.gameObject:GetComponent(DOTweenComponentType)
    if not dotCompoent then
        dotCompoent = actor.gameObject:AddComponent(DOTweenComponentType)
    end
    local originalScale = 1
    local cueData = CueDataBank.getCueData(effectId)
    if not cueData then
        dotCompoent:Scale(originalScale, 1, 0)
        return
    end
    local effectData = cueData["ModelEffect"]
    local fadeOut = effectData["fadeOut"]
    local mode = effectData["modelScale"]["mode"]
    dotCompoent:Scale(originalScale, fadeOut, mode)
end

function ModelEffectManager:playModelHide( actor, hideHp, hideDamageNum, skipHideModel )
    if not skipHideModel and actor.setModelVisible then
        actor:setModelVisible(false)
    end
    if hideHp and actor.setLogoVisible then
        actor:setLogoVisible(false)
    end

    if hideDamageNum then
        actor.showDamageNum = false
    end
end

function ModelEffectManager:recoverModelHide( actor, effectId )
    local cueData = CueDataBank.getCueData(effectId)
    if not cueData then
        return
    end
    local effectData = cueData["ModelEffect"]
    if effectData then
        local hideParam = effectData["modelHide"]
        if not hideParam["skipHideModel"] then
            if actor and actor.modelObject then
                actor:setModelVisible(true)
            end
        end
        if hideParam["hideHpLogo"] then
            actor:refreshLogoVisible()
        end
        if hideParam["hideDamageNum"] then
            actor.showDamageNum = true
        end
    end
end

function ModelEffectManager:playAddMaterial(actor, path )
    actor:addMaterial( path )
end

function ModelEffectManager:recoverModelMaterial( actor, effectId, effectData )
    if not effectData then
        return
    end
    local materialParam = effectData["modelAddMaterial"]
    if materialParam then
        local materialPath = materialParam["materialPath"]
        actor:delMaterial(materialPath)
    end
end

function ModelEffectManager:playChangeMotion( actor, oldStateName, newStateName )
    actor:changeMotion(oldStateName, newStateName)
end

function ModelEffectManager:recoverModelMotion( actor, effectId)
    local cueData = CueDataBank.getCueData(effectId)
    if not cueData then
        return
    end
    local effectData = cueData["ModelEffect"]
    local effectType = effectData["type"]
    if effectType~=3 then
        return
    end
    local oldState = effectData["modelChangeMotion"]["oldStateName"]
    local newState = effectData["modelChangeMotion"]["newStateName"]
    actor:recoverMotion(oldState)
end

function ModelEffectManager:playChangeModelAll( actor, commonModelId, animator, defaultAnim )
    actor:modelTransform(commonModelId, animator, defaultAnim)
end

function ModelEffectManager:recoverModelChange( actor )
    actor:recoverModelTransform()
end

function ModelEffectManager:playModelTransparency( actor, alpha, duration )
    actor:fadeInTransparency(alpha, duration)

end

function ModelEffectManager:recoverModelTransparency( actor, effectId, effectData)
    if not effectData then
        return
    end
    local duration = effectData["fadeOut"]
    local transparentParam = effectData["modelTransparency"]
    local alpha = 0
    if transparentParam then
        alpha = transparentParam["alpha"]
    end
    actor:fadeOutTransparency(alpha, duration)
end

function ModelEffectManager:playModelFresnel(actor, color, size, amount, duration)
    actor:fadeInFresnel(color, size, amount, duration)

end

function ModelEffectManager:recoverModelFresnel( actor, effectId, effectData)
    if not effectData then
        return
    end
    local duration = effectData["fadeOut"]
    local fresnelParam = effectData["modelFresnel"]
    local amount = 10
    if fresnelParam then
        amount = fresnelParam["amount"]
    end
    actor:fadeOutFresnel(amount, duration)
end

return ModelEffectManager