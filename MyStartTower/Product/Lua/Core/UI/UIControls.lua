--local Controls = GLDeclare("UIControls", {})
local Controls = {}
UIControls= Controls
--界面
Controls.Window = require("Core/UI/Control/Base/UIBaseWindow")
Controls.Child = require("Core/UI/Control/Base/UIBaseChild")
Controls.Logo = require("Core/UI/Control/Base/UIBaseLogo")
Controls.Control = require("Core/UI/Control/Base/UIBaseControl")
--基础控件
Controls.Panel = require("Core/UI/Control/Com/Panel")
Controls.Label = require("Core/UI/Control/Com/Label")
Controls.Image = require("Core/UI/Control/Com/Image")
Controls.RawImage = require("Core/UI/Control/Com/RawImage")
Controls.Button = require("Core/UI/Control/Com/Button")
Controls.Toggle = require("Core/UI/Control/Com/Toggle")
Controls.ToggleGroup = require("Core/UI/Control/Com/ToggleGroup")
Controls.Slider = require("Core/UI/Control/Com/Slider")
Controls.ScrollView = require("Core/UI/Control/Com/ScrollView")
--Tips

--拓展控件
Controls.UIAni = require("Core/UI/Control/Com/Animation")


Controls.ScrollViewLoopCell = require("Core/UI/Control/Scroll/ScrollViewLoopCell")
Controls.ScrollViewLoopV = require("Core/UI/Control/Scroll/ScrollRectLoopV")
Controls.ScrollViewLoopH = require("Core/UI/Control/Scroll/ScrollRectLoopH")

Controls.UICustomPolygon = require("Core/UI/Control/Com/UICustomPolygon")
Controls.JMoreRowScrollView = require("Core/UI/Control/Com/JMoreRowScrollView")
Controls.UIToggleGroup = require("Core/UI/Control/Com/UIToggleGroup")
Controls.JButton = require("Core/UI/Control/Com/JButton")
Controls.JSwitchButton = require("Core/UI/Control/Com/JSwitchButton")
Controls.UIGroupScrollView = require("Core/UI/Control/Com/UIGroupScrollView")


require("Game/UI/Common/UITween/UITweenData")
require("Game/UI/Common/UITween/UITweenWidget")

--Grid
-- 混合Mixinclass获得函数 比如装备等  要求mixinClass 必须用setmetatable的方式继承自 MixinItem
local function _GetGridClass(className, mixinClass, panelClass)
    local ClassType = Class(className, panelClass)
    MixinClass(ClassType, mixinClass, true)
    function ClassType:ctor()
        self:ctorMixin()
    end
    return ClassType
end








local BtnPlayerRankCell = require "Core/UI/MainState/Rank/BtnPlayerRankCell"
Controls.BtnPlayerRankCellLoop = _GetGridClass("BtnPlayerRankCellLoop", BtnPlayerRankCell, Controls.ScrollViewLoopCell)





--NumKeyboard
local NumKeyboard = require("Core/UI/Common/NumKeyboard")
local function initNumKeyboard(parent, path)
    return NumKeyboard(parent, path, "System/Common/Keyboard/KeyboardPanel")
end
Controls.NumKeyboard = initNumKeyboard

local UIConst = UIConst
--判断控件是否还存在
local function checkControl(parent, path, controlType)
    local root = parent.mRoot or parent
    if root ~= nil then
        if controlType == nil then
            controlType = UIConst.ControlTypeGameObject
        end
        return (root:getController():CheckCom(controlType, path) ~= 0)
    end
end
Controls.checkControlFunc = checkControl



return Controls