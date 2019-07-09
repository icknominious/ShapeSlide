local physics = require("physics")

local Object = require("Object");

local Obstacle = Object:new({tag="obstacle"});

function Obstacle:build(x,y, physParams)

    local x = x or math.random (30,150)
    local y = y or math.random (10,50)

    local willRotate = math.random(2)    --will rotate? 50/50
    local willMove = math.random(2)      --will move? 50/50

    self.shape = display.newRect(math.random (60, display.actualContentWidth-60),math.random (200, display.actualContentHeight-60), x, y)
    self.shape:setFillColor(unpack({0.3,0.3,0.3}))
    self.physics = physParams or {density=1.0, friction=0.0, bounce=0.8};
    self.rotationDirection = 180

    physics.addBody (self.shape,"static", self.physics);

    if(willMove == 1) then --will move
        local rightOrLeft = math.random (2) --will move right or left?
        self.transitionTime = math.random(1000,5000)    --how fast?
        self.xSlide = math.random(100,250)      --how far?
        if(willRotate == 1) then --and rotate
            self.rotation = math.random(90,180)
            local clockwiseOrCounterCC = math.random(2) --will rotate which way
            if(clockwiseOrCounterCC == 1)   then  --flip rotation
                self.rotation = -self.rotation
                self.rotationDirection = -self.rotationDirection
            end
            if(rightOrLeft==1) then --move right without rotating
                self:goRightandRotate()
            else                        --move left without rotating
                self:goLeftandRotate()
            end
        elseif(rightOrLeft==1) then  -- will move but won't rotate, go right
            self:goRight()
        else
            self:goLeft()   --otherwise go left
        end
    elseif (willRotate==1) then --wont move but will rotate
        self.rotation = math.random(90,180)
        local clockwiseOrCounterCC = math.random(2) --will rotate which way
        if(clockwiseOrCounterCC == 1)   then  --flip rotation
            self.rotation = -self.rotation
            self.rotationDirection = -self.rotationDirection
        end
        self:rotate()   --rotate
    end
    --otherwise don't move or rotate, static obstacle

end

function Obstacle:goRight ()	
   transition.to(self.shape, {x=self.shape.x + self.xSlide, time=self.transitionTime, 
      onComplete= function (obj) self:goLeft () end });	
end

function Obstacle:goLeft ()	
   transition.to(self.shape, {x=self.shape.x - self.xSlide, time=self.transitionTime, 
      onComplete= function (obj) self:goRight () end });	
end

function Obstacle:rotate ()	
   transition.to(self.shape, {x=self.shape.x, time=self.transitionTime, rotation=self.rotation, 
      onComplete= function (obj) self.rotation=self.rotation+self.rotationDirection self:rotate () end });	
end

function Obstacle:goRightandRotate()
    transition.to(self.shape, {x=self.shape.x + self.xSlide, time=self.transitionTime, rotation=self.rotation,
      onComplete= function (obj) self.rotation=self.rotation+self.rotationDirection self:goLeftandRotate () end });	
end

function Obstacle:goLeftandRotate()
    transition.to(self.shape, {x=self.shape.x - self.xSlide, time=self.transitionTime, rotation=self.rotation,
      onComplete= function (obj) self.rotation=self.rotation+self.rotationDirection self:goRightandRotate () end });	
end

function Obstacle:remove()
    physics.removeBody(self.shape);
    self.shape:removeSelf();
    self = nil;
end

return Obstacle