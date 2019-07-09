-- default shape class to be inherited by specific shapes
local physics = require("physics")

local Object = require("Object");

local PlayerObject = Object:new({tag="playerObject"});

function PlayerObject:build(x,y, physParams)

    local x = x or math.random (30,120)
    local y = y or math.random (20,40)

    self.shape = display.newRect(math.random(display.actualContentWidth-20), math.random(100,display.actualContentHeight-40), x, y)
    self.shape:setFillColor(unpack({0.9,0.9,0.9}))
    self.physics = physParams or {density=1.0, friction=0.0, bounce=0.7};

    physics.addBody (self.shape,"static", self.physics);


    local function move (event)

        if event.phase == "began" then		
            self.shape.markX = self.shape.x
            self.shape.markY = self.shape.y 
        elseif event.phase == "moved" then	 	
            local x = (event.x - event.xStart) + self.shape.markX	 
            local y = (event.y - event.yStart) + self.shape.markY	
            
            if (x <= 10 + self.shape.width/2) then
                self.shape.x = 10+self.shape.width/2;
            elseif (x >= display.contentWidth-10-self.shape.width/2) then
                self.shape.x = display.contentWidth-10-self.shape.width/2;
            else
                self.shape.x = x;		
            end

            if (y <= 20 + self.shape.height/2) then
                self.shape.y = 20+self.shape.height/2;
            elseif (y >= display.contentHeight-20-self.shape.height/2) then
                self.shape.y = display.contentHeight-20-self.shape.height/2;
            else
                self.shape.y = y;		
            end            
        end
    end

    self.shape:addEventListener("touch", move);

    local function rotate (event)
        self.shape:rotate(45)
    end

    self.shape:addEventListener("tap", rotate);

end

function PlayerObject:remove()
    physics.removeBody(self.shape);
    self.shape:removeSelf();
    self = nil;
end

return PlayerObject

