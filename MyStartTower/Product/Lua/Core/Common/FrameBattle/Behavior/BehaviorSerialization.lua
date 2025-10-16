local BehaviorState = require "Core/Common/FrameBattle/Behavior/BehaviorState"
local BehaviorDataBank = EditorTable.BehaviorDataBank
local BehaviorSerialization = {}

BehaviorSerialization.BH_Cache = {}
function BehaviorSerialization.init( parentSM, weaponType, overrideType)
    local bhStateDict = {}

    if BehaviorSerialization.BH_Cache[weaponType] then
        -- 有缓存
        local cacheBhData = BehaviorSerialization.BH_Cache[weaponType]
        for stateName, stateBhData in pairs(cacheBhData) do
            local tempState = BehaviorState(parentSM, stateName, nil, stateBhData)
            bhStateDict[stateName] = tempState
        end
    else
        -- 没有缓存, 执行初始化流程
        local BHData = BehaviorDataBank.getBehaviorData(weaponType)
        if BHData == nil then
            logerror("Error when load bh data:",weaponType)
            return 
        end
        --获取bh的数据
        local cacheBhData = {}
        for stateName,stateInfo in pairs(BHData) do
            local tempName = stateName
            local tempState = BehaviorState(parentSM,stateName,stateInfo)
            bhStateDict[tempName] = tempState
            cacheBhData[tempName] = tempState:getCacheData()
        end
        BehaviorSerialization.BH_Cache[weaponType] = cacheBhData
    end
    parentSM.mStateDict = bhStateDict
end

--清除
function BehaviorSerialization.clearCache(weaponType)
    BehaviorSerialization.BH_Cache[weaponType] = nil
end



return BehaviorSerialization

