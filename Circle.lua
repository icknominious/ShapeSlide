local Shape = require("Shape")

local Circle = Shape:new({tag="circle"});

function Circle:spawn (x,y,color,tag,sound)

    self.physParams = {density=1.0, friction=0.0, bounce=0.2, radius=14}
    self.shape = display.newCircle(x, y, 14);
    self.color = color;
    self.shape.tag = tag;
    self.shape.sound = sound;
    self:build(self.shape, self.color, self.physParams)
  
end

function Circle:remove()
    Shape:remove(self.shape);
    self.shape:removeSelf();
    self = nil;
end

return Circle