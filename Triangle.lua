local Shape = require("Shape")

local Triangle = Shape:new({tag="triangle"});

function Triangle:spawn (x,y,color,tag,sound)

    self.coordinates = {17,17,-17,17,0,-11}
    self.physParams = {density=1.0, friction=0.0, bounce=0.2, shape = self.coordinates}
    self.shape = display.newPolygon(x, y, self.coordinates);
    self.color = color;
    self.shape.tag = tag;
    self.shape.sound = sound;
    self:build(self.shape, self.color, self.physParams)
  
end

function Triangle:remove()
    Shape:remove(self.shape);
    self.shape:removeSelf();
    self = nil;
end

return Triangle