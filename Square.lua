local Shape = require("Shape")

local Square = Shape:new({tag="square"});

function Square:spawn (x,y,color,tag,sound)

    self.shape = display.newRect(x, y, 28,28);
    self.color = color;
    self.shape.tag = tag;
    self.shape.sound = sound;
    self:build(self.shape, self.color)
  
end

function Square:remove()
    Shape:remove(self.shape);
    self.shape:removeSelf();
    self = nil;
end

return Square