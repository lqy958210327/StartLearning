

local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

local function toggleUI(uiName)
    if UIManager.InterfaceIsShow(uiName) then
        UIManager.InterfaceCloseUI(uiName)
    else
        UIManager.InterfaceOpenUI(uiName)
    end
end

local function Update()
    if Input.GetKeyDown(KeyCode.F1) then
        UIJump.ToOpenUIGMByType(GMEmun.Battle)
    end
    if Input.GetKeyDown(KeyCode.F2) then
        UIJump.ToOpenUIGMByType(GMEmun.GMDBDialog)
    end
    if Input.GetKeyDown(KeyCode.F3) then
        UIJump.ToOpenUIGMByType(GMEmun.GMDBGameplay)
    end
    if Input.GetKeyDown(KeyCode.F4) then
        UIJump.ToOpenUIGMByType(GMEmun.GMDBDevelopment)
    end
    if Input.GetKeyDown(KeyCode.F5) then
        UIJump.ToOpenUIGMByType(GMEmun.GMDBSystem)
    end
    if Input.GetKeyDown(KeyCode.F6) then
        UIJump.ToOpenUIGMByType(GMEmun.GMDBProgrammingTool)
    end
    if Input.GetKeyDown(KeyCode.F7) then
    end
    if Input.GetKeyDown(KeyCode.LeftControl) then
        --GM_GetItem_C_State = true
    end
    if Input.GetKeyDown(KeyCode.LeftShift) then
        --GM_GetItem_S_State = true
    end
    if Input.GetKeyUp(KeyCode.LeftControl) then
        --GM_GetItem_C_State = false
    end
    if Input.GetKeyUp(KeyCode.LeftShift) then
        --GM_GetItem_S_State = false
    end
    if Input.GetKeyDown(KeyCode.Tab) then
        toggleUI(UIName.GMTabInfo)
    end
end


GameUpdate:Get():AddUpdate(GameUpdateID.EditorLoop, function() Update() end)