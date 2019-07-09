-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn

local sceneParams = {}

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	

	composer.gotoScene( "stage", {effects="fade", time=200, params=sceneParams} )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "background.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY



local options = {
    width = 301,
    height = 79,
    numFrames = 8,
    sheetContentWidth = 301,  
    sheetContentHeight = 632 
}
 
local logoImageSheet = graphics.newImageSheet( "ss_logo.png", options )

local sequenceData =
{
	name="logo",
	start = 1,
	count = 8,
    time=500,
    loopCount = 0,   
    loopDirection = "forward"    
}
 
local logo = display.newSprite( logoImageSheet, sequenceData )
logo.x = display.contentCenterX - 5
logo.y = display.contentCenterY - 150
logo:play()
	

	playBtn = widget.newButton{
		label="Start Game",
		labelColor = { default={255}, over={128} },
		default="button.png",
		over="button-over.png",
		width=150, height=60,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.contentHeight - 125




	local playerText = display.newText( "Player Shapes:", display.contentCenterX-85, display.contentCenterY-50, native.systemFont, 12)
	local playerValueText = display.newText( "1", display.contentCenterX+95, display.contentCenterY-50, native.systemFont, 18)
	sceneParams.playerValue = 1

	-- Slider1 listener
	local function playerObjSliderListener( event )
		if(event.value <20) then
			sceneParams.playerValue = 1
			playerValueText.text = "1"
		elseif (event.value <40 and event.value>=20) then
			sceneParams.playerValue = 2
			playerValueText.text = "2"
		elseif (event.value <60 and event.value>=40) then
			sceneParams.playerValue = 3
			playerValueText.text = "3"
		elseif (event.value <80 and event.value>=60) then
			sceneParams.playerValue = 4
			playerValueText.text = "4"
		else
			sceneParams.playerValue = 5
			playerValueText.text = "5"
		end
			
	end

	local playerObjSlider = widget.newSlider(
		{
			x = display.contentCenterX+20,
			y = display.contentCenterY-50,
			width = 100,
			value = 0,  -- Start slider at 10% (optional)
			listener = playerObjSliderListener
		}
	)

 
	

	local obstacleText = display.newText( "Obstacle Shapes:", display.contentCenterX-90, display.contentCenterY, native.systemFont, 12)
	local obstacleValueText = display.newText( "0", display.contentCenterX+95, display.contentCenterY, native.systemFont, 18)
	sceneParams.obstacleValue = 0
	-- Slider2 listener
	local function obstacleObjSliderListener( event )
    	if(event.value <20) then
			sceneParams.obstacleValue = 0
			obstacleValueText.text = "0"
		elseif (event.value <40 and event.value>=20) then
			sceneParams.obstacleValue = 1
			obstacleValueText.text = "1"
		elseif (event.value <60 and event.value>=40) then
			sceneParams.obstacleValue = 2
			obstacleValueText.text = "2"
		elseif (event.value <80 and event.value>=60) then
			sceneParams.obstacleValue = 3
			obstacleValueText.text = "3"
		else
			sceneParams.obstacleValue = 4
			obstacleValueText.text = "4"
		end
	end
 
	local obstacleObjSlider = widget.newSlider(
		{
			x = display.contentCenterX+20,
			y = display.contentCenterY,
			width = 100,
			value = 0,  -- Start slider at 10% (optional)
			listener = obstacleObjSliderListener
		}
	)

	local spawnRateText = display.newText( "Shape Spawn Rate:", display.contentCenterX-95, display.contentCenterY+50, native.systemFont, 12)
	local spawnRateValueText = display.newText( "0.5x", display.contentCenterX +97, display.contentCenterY+50, native.systemFont, 18)
	sceneParams.spawnRateValue = 0.5
	-- Slider3 listener
	local function spawnRateObjSliderListener( event )
    	if(event.value <33) then
			sceneParams.spawnRateValue = 0.5
			spawnRateValueText.text = "0.5x"
		elseif (event.value <66 and event.value>=34) then
			sceneParams.spawnRateValue = 1
			spawnRateValueText.text = "1x"
		else 
			sceneParams.spawnRateValue = 2
			spawnRateValueText.text = "2x"
		end
	end
 
	local spawnRateObjSlider = widget.newSlider(
		{
			x = display.contentCenterX+20,
			y = display.contentCenterY+50,
			width = 100,
			value = 0,  
			listener = spawnRateObjSliderListener
		}
	)

	local helpText1 = display.newText( "Drag white shapes to try and knock the other shapes around.", display.actualContentWidth/2, display.actualContentHeight-75, native.systemFont, 9)
	local helpText2 = display.newText( "Tap the white shapes to rotate them.", display.actualContentWidth/2, display.actualContentHeight-60, native.systemFont, 9)
	local helpText3 = display.newText( "Points are awarded for having same colors hit each other at high speeds.", display.actualContentWidth/2, display.actualContentHeight-45, native.systemFont, 9)
	local helpText4 = display.newText( "If too many shapes fall out the top, game over!.", display.actualContentWidth/2, display.actualContentHeight-30, native.systemFont, 9)

	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( logo )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( playerText )
	sceneGroup:insert( playerValueText )
	sceneGroup:insert( playerObjSlider )
	sceneGroup:insert( obstacleObjSlider )
	sceneGroup:insert( obstacleValueText )
	sceneGroup:insert( obstacleText )
	sceneGroup:insert( spawnRateObjSlider )
	sceneGroup:insert( spawnRateText )
	sceneGroup:insert( spawnRateValueText )
	sceneGroup:insert ( helpText1 )
	sceneGroup:insert ( helpText2 )
	sceneGroup:insert ( helpText3 )
	sceneGroup:insert ( helpText4 )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
	if playerObjSlider then
		playerObjSlider:removeSelf()	
		playerObjSlider = nil
	end
	if obstacleObjSlider then
		obstacleObjSlider:removeSelf()	
		obstacleObjSlider = nil
	end
	if spawnRateObjSlider then
		spawnRateObjSlider:removeSelf()	
		spawnRateObjSlider = nil
	end

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene