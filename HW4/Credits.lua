local composer = require( "composer" )
local scene = composer.newScene()

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view
 	
	-- Initialize the scene here.
	-- Example: add display objects to "sceneGroup", add touch listeners, etc.

	--Displays sky
	local bg = display.newImage("Sky.png", display.contentCenterX, display.contentCenterY)
	bg.width = 420
	bg.height = 520
	sceneGroup:insert(bg)

	--Displays all the text for the credits and victory message
	local subText1 = display.newText("Congratulations!", display.contentCenterX, 60, "Monotype Corsiva", 34)
	local subText2 = display.newText("You Win!", display.contentCenterX, 100, "Monotype Corsiva", 34)
	local subText3 = display.newText("Credits", display.contentCenterX, display.contentCenterY - 20, "Monotype Corsiva", 40)
	subText1:setFillColor(0,0,0)
	subText2:setFillColor(0,0,0)
	subText3:setFillColor(0,0,0)
	local nameText1 = display.newText("Cray Pella", display.contentCenterX, display.contentCenterY + 40, "Monotype Corsiva", 26)
	local nameText2 = display.newText("Francisco Esteves", display.contentCenterX, display.contentCenterY + 80, "Monotype Corsiva", 26)
	local nameText3 = display.newText("Jonathan Berry", display.contentCenterX, display.contentCenterY + 120, "Monotype Corsiva", 26)
	local nameText4 = display.newText("Donald Maxwell", display.contentCenterX, display.contentCenterY + 160, "Monotype Corsiva", 26)
	nameText1:setFillColor(0,0,0)
	nameText2:setFillColor(0,0,0)
	nameText3:setFillColor(0,0,0)
	nameText4:setFillColor(0,0,0)
	sceneGroup:insert(subText1)
	sceneGroup:insert(subText2)
	sceneGroup:insert(subText3)
	sceneGroup:insert(nameText1)
	sceneGroup:insert(nameText2)
	sceneGroup:insert(nameText3)
	sceneGroup:insert(nameText4)

	--[[
		Function for reseting back to the start screen
	]]
	function reset()
		composer.removeScene("Credits")
		composer.gotoScene("Start", {effect = "fade", time = "800", params = {difficulty = 1, playerColor = 1}})
	end

end
 
-- "scene:show()"
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	  -- Called when the scene is still off screen (but is about to come on screen).
	elseif ( phase == "did" ) then
	  -- Called when the scene is now on screen.
	  -- Insert code here to make the scene come alive.
	  -- Example: start timers, begin animation, play audio, etc.

	  --Timer that resets back to start screen after 3.5 seconds
	  t = timer.performWithDelay(3500, reset)
	end
end
 
-- "scene:hide()"
function scene:hide( event )
 
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	  -- Called when the scene is on screen (but is about to go off screen).
	  -- Insert code here to "pause" the scene.
	  -- Example: stop timers, stop animation, stop audio, etc.

	  --Cancels timer when the scene finishes
	  timer.cancel(t)
	elseif ( phase == "did" ) then
	  -- Called immediately after scene goes off screen.
	end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene