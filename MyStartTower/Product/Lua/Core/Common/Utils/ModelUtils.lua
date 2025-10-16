local ResCommonModel = DataTable.ResCommonModel
local ResModelShow = DataTable.ResModelShow
local ResItemHeroBase = DataTable.ResItemHeroBase

local ModelUtils = {}

function ModelUtils.getCommonModelData( commonModelId )
    if not commonModelId then
        logerror("Common Model ID is null.")
        return
    end
    local modelData = ResCommonModel[commonModelId]
    if not modelData then
        logerror("Common Model Data is NUll: ", commonModelId)
        return
    end
    return modelData
end


-- 获取模型展示场景的Tag
function ModelUtils.GetModelScenicTag(modelTag)
    local modelCfg = ModelUtils.getCommonModelData(modelTag)
    if modelCfg == nil then
        logerror("Model Tag is NUll: ", modelTag)
        return 0
    end
    return modelCfg.scenic_id
end



function ModelUtils.getModelDefaultData(commonModelId)
    local resModelData = ModelUtils.getCommonModelData(commonModelId)
    if not resModelData then
        return
    end
    local defaultInfo = resModelData["default"]
    if not defaultInfo then
        return
    end
    local defaultId = defaultInfo["id"]
    if not defaultId then
        return
    end
    local defaultData = DataTable.ResModelDefault[defaultId]
    if not defaultData then
        logerror("Model Default Data is NUll: ", defaultId)
        return
    end
    return defaultInfo, defaultData
end

function ModelUtils.getModelShowData(commonModelId,showType)
    local resModelData = ModelUtils.getCommonModelData(commonModelId)
    if not resModelData then
        return
    end
    local showInfo = resModelData[showType]
    if not showInfo then
        return
    end
    local showId = showInfo["id"]
    if not showId then
        return
    end
    local showData = ResModelShow[showId]
    if not showData then
        logerror("Model Show Data is NUll: ", showId)
        return
    end
    return showInfo, showData
end





--TODO:是否可以优化 ResHeroBaseData这个表？
function ModelUtils.getHeroShowModelId(heroId, image)
    local heroBaseData = ResItemHeroBase[heroId]
    local image = image or 1
    if heroBaseData and heroBaseData[image] then
        return heroBaseData[image].model_id
    end
    return heroId

    
end

return ModelUtils