


local UIBaseControl = require("Core/UI/Control/Base/UIBaseControl")

---@class JMoreRowScrollView : UIBaseControl
local JMoreRowScrollView = Class("JMoreRowScrollView", UIBaseControl)
-- 构造函数。
function JMoreRowScrollView:ctor()

end

function JMoreRowScrollView:_getControlType()
    return UIConst.JMoreRowScrollView
end

function JMoreRowScrollView:Setup(total, row)
    local scrollView = self:getComObj()
    if scrollView then
        scrollView:Setup(total, row)
    end
end

function JMoreRowScrollView:ItemReloadCallback(func)
    local scrollView = self:getComObj()
    if scrollView then
        LuaCallCsUtilCommon.FuncRefByCSharpHandleRegister(scrollView)
        scrollView:ItemReloadCallback(func)
    end
end

function JMoreRowScrollView:RefreshCurrentList(isForce)
    local scrollView = self:getComObj()
    if scrollView then
        scrollView:RefreshCurrentList(isForce)
    end
end

function JMoreRowScrollView:MoveToStartPos()
    local scrollView = self:getComObj()
    if scrollView then
        scrollView:MoveToStartPos()
    end
end

function JMoreRowScrollView:ScrollToItem(idx)
    local scrollView = self:getComObj()
    if scrollView then
        scrollView:ScrollToItem(idx)
    end
end

function JMoreRowScrollView:PlayEnterAni()
    local scrollView = self:getComObj()
    if scrollView then
        scrollView:PlayEnterAni()
    end
end

function JMoreRowScrollView:GetItemCell(dataIndex)
    local scrollView = self:getComObj()
    if scrollView then
        return scrollView:GetItemCell(dataIndex)
    end
    return nil
end


return JMoreRowScrollView

