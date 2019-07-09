-- default shape class to be inherited by specific shapes
local physics = require("physics");
local soundTable=require("soundTable");

local Object = require("Object");

local Shape = Object:new({tag="shape"});

function Shape:build (shape, color, physParams)

    self.physics = physParams or {density=1.0, friction=0.0, bounce=0.8};
    self.shape = shape;
    self.color = color;
    self.shape:setFillColor(unpack(self.color));
    self.shape.alpha = 0.7;

    physics.addBody (self.shape, self.physics);

    self.shape:applyForce( math.random(-100,100), 0, math.random(self.shape.x-15,self.shape.x+15), self.shape.y-5 )


    local function collisionHandler (event)

        local function fade (event)
            self.shape.alpha = 0.7
        end

        local vX, vY =  self.shape:getLinearVelocity()
        if (event.phase == "began" and vY > 125) then

            timer.performWithDelay( 250, fade, 1 )  
            event.target.alpha = 1.0
            audio.play(soundTable[event.target.sound], {fadein=500})

            if(event.target.tag == event.other.tag) then
                Runtime:dispatchEvent({name="pointAwardedEvent"})       --dispatch custom event to update score in stage.lua
            end
        end
    end

    self.shape:addEventListener("collision", collisionHandler);

end


function Shape:remove(shape)
    physics.removeBody(shape);
    self = nil;
end

return Shape

