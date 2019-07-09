local Border = require ("Border")
local Spawner = require ("Spawner")
local PlayerObject = require ("PlayerObject")
local Obstacle = require ("Obstacle")


local composer = require( "composer" )
local widget = require "widget"
local scene = composer.newScene()

local physics = require "physics"


local spawner = Spawner:new()

-- forward declarations 
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

local playerValue
local obstacleValue
local spawnRateValue

local quitBtn

-- local function onQuitBtnRelease()
-- 	composer.gotoScene("menu")
-- 	return true	
-- end

function scene:create( event )

	playerValue = event.params.playerValue				--import params from last scene
	obstacleValue = event.params.obstacleValue
	spawnRateValue = event.params.spawnRateValue

	local sceneGroup = self.view
	local score = 0
	local scoreTracker = display.newText( "0", 25, 15, native.systemFont, 20)

	local scoreListener = function (event)
		score = score + 1
		scoreTracker.text = score
	end

	Runtime:addEventListener("pointAwardedEvent",scoreListener)				--event listener for custom event

	physics.start()										--setup physics
	physics.setGravity(0,3)
	physics.pause()

	local background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )		--change background to black
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( 0 )
	

	local border = Border:new()																					--build border for play area
	border:spawn()

	local overFlowBar = display.newRect( display.actualContentWidth/2, display.actualContentHeight+50, 700, 10 )		
	--overflow bar catches extra shapes, when this happens the game is over. It is not visible
	physics.addBody(overFlowBar, "static")

	local function gameOver()
		physics.pause()
		local gameOverMessage = display.newText( "Game Over!", display.actualContentWidth/2, display.actualContentHeight/2 -50, native.systemFont, 50)
		local finalScoreString = "Final Score: " .. scoreTracker.text
		local finalScoreMessage = display.newText( finalScoreString, display.actualContentWidth/2, display.actualContentHeight/2, native.systemFont, 30)	
		finalScoreMessage:toFront()
		gameOverMessage:toFront()
	end

	local function overFlowCollision (event)
		if (event.phase == "began") then
			gameOver()
		end
	end
	overFlowBar:addEventListener("collision", overFlowCollision);

	for i=1, playerValue do
		local player = PlayerObject:new()
		player:build()
		--sceneGroup:insert (player.shape)
	end

	for i=1, obstacleValue do
		local obstacle = Obstacle:new()
		obstacle:build()
		--sceneGroup:insert (obstacle.shape)
	end

	-- quitBtn = widget.newButton{
	-- 	label="X",
	-- 	labelColor = { default={255}, over={128} },
	-- 	default="button.png",
	-- 	over="button-over.png",
	-- 	width=10, height=10,
	-- 	onRelease = onQuitBtnRelease	-- event listener function
	-- }
	-- quitBtn.x = display.actualContentWidth - 25
	-- quitBtn.y = display.actualContentHeight - 25

	sceneGroup:insert( background )
	sceneGroup:insert (border.left)
	sceneGroup:insert (border.right)
	sceneGroup:insert (border.bottom)
	sceneGroup:insert (overFlowBar)
	sceneGroup:insert (scoreTracker)

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then

		physics.start()
		spawner:start(spawnRateValue)
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then

		physics.stop()
	elseif phase == "did" then

	end	
	
end

function scene:destroy( event )

	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil

	if quitBtn then
		quitBtn:removeSelf()	-- widgets must be manually removed
		quitBtn = nil
	end
end



-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene