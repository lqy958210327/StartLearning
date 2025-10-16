local UIUtils = Framework.UI.UIUtils
--local strClassName = "BlockBox"
local BlockBox = Class("BlockBox", UIControls.Window)

function BlockBox:show(info)
    self.info = info
    local ui = UIManager.getUI(self.info.name, nil, false)
    if ui then
        self:setOrder(ui:getOrder() - 1)
    end
    self:setVisible(true)
end

function BlockBox:hide()
    self:setVisible(false, false)
end

function BlockBox:setVisible(v, hideAndDestroy)
    if v and self._visible then
        self:onVisibleChanged(true)
        UIUtils.UpdateBlurImmune(self.id)
        return
    end
    BlockBox.super.setVisible(self, v, hideAndDestroy)
end

function BlockBox:onVisibleChanged(isSee)
    BlockBox.super.onVisibleChanged(self, isSee)
    local layer = isSee and self:getOrder() or 999999
    UIUtils.SetBlurOrder(layer)
end

return BlockBox