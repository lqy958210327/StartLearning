local strClassName = "ClickLayer"
local ClickLayer = Class(strClassName, UIControls.Window)

function ClickLayer:UILiftOnInit()
    self.panelEfx = UIControls.Panel(self,"GameObject")
end

function ClickLayer:enableClickEfx( v )
    self.panelEfx:setVisible(v)
end

return ClickLayer

