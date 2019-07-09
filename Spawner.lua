--Spawner object, responsible for determining when and where to spawn shapes
local Circle = require ("Circle")
local Triangle = require ("Triangle")
local Square = require ("Square")
local Pentagon = require ("Pentagon")

local Object = require("Object")

local Spawner = Object:new({tag="spawner"})

function Spawner:start(spawnRate, colorCount)    

    local function spawnShape(event)
        
        local colorChoice = math.random(event.source.colorCount) 
        local shapeChoice = math.random(4)

        local colorString
        local colorRGB
        local sound

        if (colorChoice == 1) then
            colorString = "red"
            colorRGB = {1,0,0}
            sound = "a"
        elseif (colorChoice == 2) then
            colorString = "orange"
            colorRGB = {1,0.5,0}
            sound = "b"
        elseif (colorChoice == 3) then
            colorString = "yellow"
            colorRGB = {1,1,0}
            sound = "c"
        elseif (colorChoice == 4) then
            colorString = "green"
            colorRGB = {0,1,0}
            sound = "d"
        elseif (colorChoice == 5) then
            colorString = "blue"
            colorRGB = {0.1,0.1,1}
            sound = "e"
        elseif (colorChoice == 6) then
            colorString = "indigo"
            colorRGB = {0.4,0,1}
            sound = "f"
        elseif (colorChoice == 7) then
            colorString = "violet"
            colorRGB = {0.9,0,1}
            sound = "g"
        else
            print("colorChoice out of bounds")
        end

        if (shapeChoice == 1) then
            local testShape = Circle:new()
            testShape:spawn(math.random(100,300), -30, colorRGB, colorString, sound)
        elseif (shapeChoice == 2) then
            local testShape = Triangle:new()
            testShape:spawn(math.random(100,300), -30, colorRGB, colorString, sound)
        elseif (shapeChoice == 3) then
            local testShape = Square:new()
            testShape:spawn(math.random(100,300), -30, colorRGB, colorString, sound)
        elseif (shapeChoice == 4) then
            local testShape = Pentagon:new()
            testShape:spawn(math.random(100,300), -30, colorRGB, colorString, sound)
        else
            print ("shapeChoice out of bounds")
        end

    end

    self.spawnRate = spawnRate or 1
    self.spawnTimer = timer.performWithDelay( 1000/spawnRate, spawnShape, 0 )  
    self.spawnTimer.colorCount = colorCount or 7
end



return Spawner