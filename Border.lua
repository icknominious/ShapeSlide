-- default shape class to be inherited by specific shapes
local physics = require("physics")

local Object = require("Object");

local Border = Object:new({tag="border"});

function Border:spawn ()

    self.color = {0.5,0.5,0.5}

    self.physics = {density=1.0, friction=0.0, bounce=0.8};
    self.left = display.newRect(0,display.actualContentHeight/2,5,display.actualContentHeight+100);
    self.right = display.newRect(display.actualContentWidth,display.actualContentHeight/2,5,display.actualContentHeight+100);
    self.bottom = display.newRect(display.actualContentWidth/2,display.actualContentHeight-20,display.actualContentWidth,50);

    self.left:setFillColor(unpack(self.color))
    self.right:setFillColor(unpack(self.color))
    self.bottom:setFillColor(unpack(self.color))
    self.bottom.tag = "bottom"

    physics.addBody (self.left, "static", self.physics)
    physics.addBody (self.right, "static", self.physics)
    physics.addBody (self.bottom, "static", {density=1.0, friction=0.0, bounce=0.3})

end

function Border:remove()
    physics.removeBody(self.left)
    physics.removeBody(self.right)
    physics.removeBody(self.bottom)
    self.left:removeSelf()
    self.right:removeSelf()
    self.bottom:removeSelf()
    self = nil 
end

return Border

