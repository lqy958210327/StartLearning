


local ModelType = Const.MODEL_TYPE

local ModelTool = {}

-- 根据类型和数据源整理出模型信息
function ModelTool.analyzeModelData(oriModelData)
    local modelType = oriModelData["model_type"] or ModelType.Default
    local useLOD = oriModelData["use_lod"] or Const.MODEL_LOD_LV0

    local data = {}
    --print("------oriModelData" .. table.dump(oriModelData))
    if modelType == ModelType.Default then
        -- 默认模型
        local commonModelId = oriModelData["model_id"]
        if not commonModelId then
            logerror("Model ID Invalid.")
            return
        end

        ModelTool._prepareDefaultModelData(data, commonModelId, useLOD, oriModelData)
    else
        logerror("Model.ctor() unknown modelType " .. modelType .. "!!")
    end
    if oriModelData["model_id"] then
        data.model_id = oriModelData["model_id"]
    end
    if oriModelData["animator"] then
        data.animator = oriModelData["animator"]  -- 传入的animator是覆盖关系还是候补关系需要确定
    end

    if oriModelData["scale"] then
        data.scale = (data.scale or 1) * oriModelData["scale"]
    end

    if oriModelData["fashion_tag"] and data.avatar then
        data.avatar = data.avatar .. "_" .. oriModelData["fashion_tag"]
    end
    return data
end

function ModelTool._prepareDefaultModelData(data, commonModelId, useLOD, oriModelData)
    local defaultInfo, defaultData = ModelUtils.getModelDefaultData(commonModelId)
    if not defaultData then
        logerror("Cant find model default data:" .. commonModelId)
        return
    end


    local avatarPath = ModelTool.getAvatarPath(defaultData, "avatar_bone_lv", useLOD)
    if not avatarPath then
        logerror("Model data Invalid:" .. commonModelId)
        return
    end
    data.avatar = avatarPath

    local animPath = defaultData["ani_con_path"]
    local animName = defaultData["ani_con_name"]
    if not animPath or not animName then
        logerror("Model data Animator info Invalid:" .. commonModelId)
        return
    end
    data.animator = ModelTool.getControllerPath(animPath, animName)

    data.parts = {}
    local body_part = defaultData["body_part"]
    if body_part then
        -- data.parts = ModelUtils.getModelParts(body_part, oriModelData.star, basePath)
    end

    local scale = defaultInfo["scale"]
    if scale then
        data.scale = scale
    end
end


function ModelTool.getControllerPath(path, weaponType, isOverride)
    local extension
    if isOverride then
        extension = ".overrideController"
    else
        extension = ".controller"
    end

    if weaponType == nil then
        LuaCallCs.ThrowException("---   某个模型缺少了动画状态机，查一下配置...  策划定位一下是那个模型")
    end

    if path and path ~= "" then
        --return "Animators/" .. path .. "/" .. weaponType .. extension
        return path .. "/" .. weaponType .. extension
    else
        --return "Animators/" .. weaponType .. extension
        return weaponType .. extension
    end
end



function ModelTool.getAvatarPath(pathData, avatarBase, lodLv)
    local avatarKey = avatarBase .. lodLv
    local showAvatar = pathData[avatarKey]
    -- 如果是lod的模型但是实际没做lod，则找高模
    while (not showAvatar and lodLv ~= Const.MODEL_LOD_LV0) do
        lodLv = lodLv - 1
        avatarKey = avatarBase .. lodLv
        showAvatar = pathData[avatarKey]
    end

    return showAvatar
end


return ModelTool