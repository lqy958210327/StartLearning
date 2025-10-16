local IUIBase = require("Core/UI/Control/Base/IUIBase")
local UIUtils = Framework.UI.UIUtils

local ScrollViewLoopCell = Class("ScrollViewLoopCell", IUIBase)
-- 成员变量。
local LayoutElementType = typeof(UnityEngine.UI.LayoutElement)

-- 构造函数。
function ScrollViewLoopCell:ctor(scrollLoop, prefabPath, idx, width, height, parentUid)
    self.mScrollLoop = scrollLoop
    self.mIndex = idx
    self.mParent = scrollLoop.mParent
    self.mWindow = scrollLoop.mWindow
    local parentUID = self.mParent.id or self.mParent.mRoot.id
    if parentUid ~= nil then
        parentUID = parentUid
    end
    UIUtils.CreateUILoopCell(prefabPath, self, width or 0, height or 0, scrollLoop._obj, parentUID)
end

function ScrollViewLoopCell:destroy()
    --自动销毁
end

-------------------↓ C#回掉函数（不可继承）↓-------------------

--界面因为滚动回收至池子时
function ScrollViewLoopCell:OnClearStart()
    self:onClear()
end

function ScrollViewLoopCell:OnIndexChanged(newIdx)
    self.mIndex = newIdx
end

-------------------↑ C#回掉函数（不可继承）↑-------------------

function ScrollViewLoopCell:onClear()
    -- self.mIndex = nil
end

-- 不支持设置visible
function ScrollViewLoopCell:setVisible(v)

end

function ScrollViewLoopCell:getVisible()
    
end

function ScrollViewLoopCell:setLayoutSize(width, height)
    if self._layoutEmt == nil then
        self._layoutEmt = self:getController():GetComponent(LayoutElementType)
    end
    if width ~= nil then
        self._layoutEmt.preferredWidth = width
    end
    if height ~= nil then
        self._layoutEmt.preferredHeight = height
    end
end

return ScrollViewLoopCell

