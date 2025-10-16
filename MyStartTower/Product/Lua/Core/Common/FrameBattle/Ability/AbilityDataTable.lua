local AbilityDataTable = {
    BattleConst = require "Core/Common/FrameBattle/BattleConst",
    BattleMiscConfig = require "Core/Common/BattleMiscConfig",
    ResAttrConfig = require "Config/DataTable/ResAttrConfig",
    ResAttrAttrMap = require "Config/DataTable/ResAttrAttrMap",
    ResPassiveSkill = require "Config/DataTable/ResPassiveSkill",
    ResPassiveEffect = require "Config/DataTable/ResPassiveEffect",
    ResStateData = require "Config/DataTable/ResStateData",
    ResSkillConfig = require "Config/DataTable/ResSkillConfig",
    ResAttackEffect = require "Config/DataTable/ResAttackEffect",
    ResProbConfig = require "Config/DataTable/ResProbConfig",
    ResHeroData = require "Config/DataTable/ResHeroData",
    ResMonsterTypeData = require "Config/DataTable/ResMonsterTypeData",
    ResMonsterAttrData = require "Config/DataTable/ResMonsterAttrData",
    ResBattleField = require "Config/DataTable/ResBattleField",
    ResBattleWaveMonster = require "Config/DataTable/ResBattleWaveMonster",
    ResBattleWaveBoss = require "Config/DataTable/ResBattleWaveBoss",
    ResBattleTrap = require "Config/DataTable/ResBattleTrap",
    SkillData = {}
}
local CueDataBank = require "Config/EditorTable/CueDataBank" 

local SkillDataPath = "Config/EditorTable/SkillData/"
function AbilityDataTable.loadEditorData(file)
    local fullDataPath = SkillDataPath .. file
    local weaponData = require (fullDataPath)
    if weaponData ~= nil then
        for id, data in pairs(weaponData) do
            if type(id) == 'number' then
                AbilityDataTable.SkillData[id] = data
            end
        end
        local cueFile = weaponData["cueFile"]
        if cueFile and cueFile~="" then
            CueDataBank.initCueData(cueFile)
        end
    end
end


return AbilityDataTable