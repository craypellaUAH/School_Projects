local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

local tempDifficulty = 0
--local color = 0
--1 = Easy  2 = Medium  3 = Hard
--1 = Red   2 = Blue   3 = Pink


 
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

   --Passes values for difficulty and color
   difficulty = event.params.difficulty
   color = event.params.playerColor

   --Displays images
   local bg = display.newImage("Sky.png", display.contentCenterX, display.contentCenterY)
   bg.width = 420
   bg.height = 520
   sceneGroup:insert(bg)
   local scroll = display.newImage("BigScroll.png", display.contentCenterX, display.contentCenterY)
   scroll:scale(0.3, 0.7)
   sceneGroup:insert(scroll)

   --[[
      Puts the X's at the correct location for when they were previously chosen when the scene is created
   ]]
   if(difficulty == 1) then
      DX = display.newImage("X.png", display.contentCenterX + 110, display.contentCenterY - 120)
      DX:scale(0.1, 0.1)
   elseif(difficulty == 2) then
      DX = display.newImage("X.png", display.contentCenterX + 110, display.contentCenterY - 70)
      DX:scale(0.1, 0.1)
   elseif(difficulty == 3) then
      DX = display.newImage("X.png", display.contentCenterX + 110, display.contentCenterY - 20)
      DX:scale(0.1, 0.1)
   end

   if(color == 1) then
      CX = display.newImage("X.png", display.contentCenterX + 110, display.contentCenterY + 30)
      CX:scale(0.1, 0.1)
   elseif(color == 2) then
      CX = display.newImage("X.png", display.contentCenterX + 110, display.contentCenterY + 80)
      CX:scale(0.1, 0.1)
   elseif(color == 3) then
      CX = display.newImage("X.png", display.contentCenterX + 110, display.contentCenterY + 130)
      CX:scale(0.1, 0.1)
   end
   sceneGroup:insert(DX)
   sceneGroup:insert(CX)


   --[[
      Function that selects difficulty. This function receives a touch event as an argument and then sets the
      difficulty variable and moves the X.
   ]]
   function difficultySelect(event)
      if(event.target.setDifficulty == 1) then
         DX.y = display.contentCenterY - 120
         difficulty = 1
      elseif(event.target.setDifficulty == 2) then
         DX.y = display.contentCenterY - 70
         difficulty = 2
      elseif(event.target.setDifficulty == 3) then
         DX.y = display.contentCenterY - 20
         difficulty = 3
      end
   end


   --[[
      Function that selects color. This function receives a touch event as an argument and then sets the
      difficulty variable and moves the X.
   ]]
   function colorSelect(event)
      if(event.target.setColor == 1) then
         CX. y = display.contentCenterY + 30
         color = 1
      elseif(event.target.setColor == 2) then
         CX. y = display.contentCenterY + 80
         color = 2
      elseif(event.target.setColor == 3) then
         CX. y = display.contentCenterY + 130
         color = 3
      end
   end

   --[[
      Creates the buttons for selecting color and difficulty. setDifficulty and setColor are used to track which buttons were pressed
   ]]
   easy = widget.newButton(
      {
         x = display.contentCenterX + 40,
         y = display.contentCenterY - 120,
         id = "startButton",
         label = "Easy",
         labelColor = {default = {0, 0, 0}, over = {0.8, 0.8, 0.8}},
         fontSize = 20,
         font = "Monotype Corsiva",
         onPress = difficultySelect,
         shape = "roundedRect",
         width = 100,
         height = 40,
         cornerRadius = 5,
         fillColor = {default = {0.35, 0.35, 0.35, 0.01}, over = {0.20, 0.20, 0.20}},
         strokeColor = {default = {0, 0, 0, 0.1}, over = {0.6, 0.6, 0.6}},
         strokeWidth = 2

      }
      )
   easy.setDifficulty = 1

   medium = widget.newButton(
      {
         x = display.contentCenterX + 40,
         y = display.contentCenterY - 70,
         id = "startButton",
         label = "Medium",
         labelColor = {default = {0, 0, 0}, over = {0.8, 0.8, 0.8}},
         fontSize = 20,
         font = "Monotype Corsiva",
         onPress = difficultySelect,
         shape = "roundedRect",
         width = 100,
         height = 40,
         cornerRadius = 5,
         fillColor = {default = {0.35, 0.35, 0.35, 0.01}, over = {0.20, 0.20, 0.20}},
         strokeColor = {default = {0, 0, 0, 0.1}, over = {0.6, 0.6, 0.6}},
         strokeWidth = 2

      }
      )
   difficultyText = display.newText("Diffculty", display.contentCenterX - 80, display.contentCenterY - 70, "Monotype Corsiva", 24 )
   difficultyText:setFillColor(0, 0, 0)
   sceneGroup:insert(difficultyText)
   medium.setDifficulty = 2

   hard = widget.newButton(
      {
         x = display.contentCenterX + 40,
         y = display.contentCenterY - 20,
         id = "startButton",
         label = "Hard",
         labelColor = {default = {0, 0, 0}, over = {0.8, 0.8, 0.8}},
         fontSize = 20,
         font = "Monotype Corsiva",
         onPress = difficultySelect,
         shape = "roundedRect",
         width = 100,
         height = 40,
         cornerRadius = 5,
         fillColor = {default = {0.35, 0.35, 0.35, 0.01}, over = {0.20, 0.20, 0.20}},
         strokeColor = {default = {0, 0, 0, 0.1}, over = {0.6, 0.6, 0.6}},
         strokeWidth = 2

      }
      )
   hard.setDifficulty = 3
   sceneGroup:insert(easy)
   sceneGroup:insert(medium)
   sceneGroup:insert(hard)

   red = widget.newButton(
      {
         x = display.contentCenterX + 40,
         y = display.contentCenterY + 30,
         id = "startButton",
         label = "Red",
         labelColor = {default = {0, 0, 0}, over = {0.8, 0.8, 0.8}},
         fontSize = 20,
         font = "Monotype Corsiva",
         onPress = colorSelect,
         shape = "roundedRect",
         width = 100,
         height = 40,
         cornerRadius = 5,
         fillColor = {default = {0.35, 0.35, 0.35, 0.01}, over = {0.20, 0.20, 0.20}},
         strokeColor = {default = {0, 0, 0, 0.1}, over = {0.6, 0.6, 0.6}},
         strokeWidth = 2

      }
      )
   red.setColor = 1
   blue = widget.newButton(
         {
            x = display.contentCenterX + 40,
            y = display.contentCenterY + 80,
            id = "startButton",
            label = "Blue",
            labelColor = {default = {0, 0, 0}, over = {0.8, 0.8, 0.8}},
            fontSize = 20,
            font = "Monotype Corsiva",
            onPress = colorSelect,
            shape = "roundedRect",
            width = 100,
            height = 40,
            cornerRadius = 5,
            fillColor = {default = {0.35, 0.35, 0.35, 0.01}, over = {0.20, 0.20, 0.20}},
            strokeColor = {default = {0, 0, 0, 0.1}, over = {0.6, 0.6, 0.6}},
            strokeWidth = 2

         }
         )
   blue.setColor = 2
   colorText = display.newText("Player Color", display.contentCenterX - 75, display.contentCenterY + 80, "Monotype Corsiva", 24 )
   colorText:setFillColor(0, 0, 0)
   sceneGroup:insert(colorText)
   pink = widget.newButton(
         {
            x = display.contentCenterX + 40,
            y = display.contentCenterY + 130,
            id = "startButton",
            label = "Pink",
            labelColor = {default = {0, 0, 0}, over = {0.8, 0.8, 0.8}},
            fontSize = 20,
            font = "Monotype Corsiva",
            onPress = colorSelect,
            shape = "roundedRect",
            width = 100,
            height = 40,
            cornerRadius = 5,
            fillColor = {default = {0.35, 0.35, 0.35, 0.01}, over = {0.20, 0.20, 0.20}},
            strokeColor = {default = {0, 0, 0, 0.1}, over = {0.6, 0.6, 0.6}},
            strokeWidth = 2
         }
         )
   pink.setColor = 3

   sceneGroup:insert(red)
   sceneGroup:insert(blue)
   sceneGroup:insert(pink)

   --[[
      Function for returning to the start menu. Passes variables difficulty and color.
   ]]
   function returnFunction (event)
      composer.removeScene("Options")
      composer.gotoScene("Start", {effect = "fade", time = "800", params = {difficulty = difficulty, playerColor = color}})
   end

   --Return button
   returnButton = widget.newButton(
         {
            x = display.contentCenterX,
            y = display.contentCenterY + 220,
            id = "startButton",
            label = "Return",
            labelColor = {default = {0, 0, 0}, over = {0.8, 0.8, 0.8}},
            fontSize = 24,
            font = "Monotype Corsiva",
            onPress = returnFunction,
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 5,
            fillColor = {default = {0.35, 0.35, 0.35, 0.01}, over = {0.35, 0.35, 0.35, 0.01}},
            strokeColor = {default = {0, 0, 0, 0.01}, over = {0, 0, 0, 0.01}},
            strokeWidth = 2
         }
         )
   sceneGroup:insert(returnButton)
   

   



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