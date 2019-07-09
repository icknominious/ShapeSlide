local Shape = require("Shape")

local Pentagon = Shape:new({tag="pentagon"});

function Pentagon:spawn (x,y,color,tag,sound)

    self.coordinates = {0,-18,-17,-6,-11,15,11,15,17,-6};
    self.physParams = {density=1.0, friction=0.0, bounce=0.2, shape = self.coordinates}
    self.shape = display.newPolygon(x, y, self.coordinates);
    self.color = color;
    self.shape.tag = tag;
    self.shape.sound = sound;
    self:build(self.shape, self.color, self.physParams)
  
end

function Pentagon:remove()
    Shape:remove(self.shape);
    self.shape:removeSelf();
    self = nil;
end

return Pentagon