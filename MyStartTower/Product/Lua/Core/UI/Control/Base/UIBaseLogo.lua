local IUIBase = require("Core/UI/Control/Base/IUIBase")
local UIUtils = Framework.UI.UIUtils

---@class UIBaseLogo : IUIBase
local UIBaseLogo = Class("UIBaseLogo", IUIBase)
-- 成员变量。

-- 构造函数。
function UIBaseLogo:ctor(entityController, prefabPath, x, y)
    self.entityController = entityController
    self._visible = true
    x = x or 0
    y = y or 0
    self.id = UIUtils.CreateToplogo(prefabPath, self, self.entityController, x, y)
end

-- 设置界面可见度
function UIBaseLogo:setVisible(v,playAudio)
    if playAudio == nil then
        playAudio = true
    end
    self._visible = v
    UIUtils.SetUIVisible(self.id, v ,false,playAudio)
end

function UIBaseLogo:isInShow()
    return self._visible
end

function UIBaseLogo:setHide(hide)
    if self._hide ~= hide then
        self._hide = hide
        if self._hide then
            UIUtils.ScaleHideUI(self.id, 1)
        else
            UIUtils.ScaleHideUI(self.id, 0)
        end
    end
end

return UIBaseLogo
