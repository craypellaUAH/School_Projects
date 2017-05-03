------------------------------------------------------------------------------------
-- Cray Pella
-- CS 371
-- H/W 4
-- 
-- File: gameOver.lua
--
-- Desc: This file sets up and displays the game over screen depending on if 
--       the player won or lost
-- 
-- Scene Files:
--  start.lua
--  game.lua
--  gameOver.lua
--
------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local soundTable=require("soundTable");
local widget = require('widget')
local json = require("json")
local levels = require("levels")
local physics = require("physics")
local Enemy = require("Enemy")
physics.start(); -- start physics
physics.setGravity(0,0); 
local CollisionFilters = {}
CollisionFilters.player = {categoryBits=1, maskBits = 12}
CollisionFilters.bullet = {categoryBits=2, maskBits = 4}
CollisionFilters.enemy = {categoryBits=4, maskBits = 3}
CollisionFilters.enemyBullet = {categoryBits=8, maskBits = 1}
CollisionFilters.traps = {categoryBits=16, maskBits = 1}

--[[
tempVar = 0
hit = 1
stopper = 0
playerX = 178
playerY = 305
playerLife = 5
lvlNum = 1
trapNum = 2
trapLoc = {{x = 182, y = 121}, {x = 56, y = 375}}
fightTime = 20
forrestLvl_1 = { 
 powerType = 2,
 powerUp = {2, 2},
 powerUpImages = {"heart.png", "heart.png"},
 powerUps = {{x = 90, y = 100}, {x = 90, y = 200}, {x = 90, y = 300}, {x = 90, y = 400} },
 enemy = 1,
 enemies = {{x = 268, y = 160}},
 enemyTrack = 0,
 enemyTracks = {{x = 268, y = 200}},
 door = 3,
 imageDoor = "door.png",
 doors = {{x = 182, y = 83}, {x = 268, y = 468}, {x = 48, y = 468}},
 sideWall = 6, 
 imageName = "plantWall.png",
 sideWalls = {{x = 128, y = 239}, {x = 225, y = 239}, {x = 223, y = 344}, {x = 191, y = 344}, {x = 160, y = 344}, {x = 128, y = 344} },
 downWall = 2,
 imageName2 = "downWallForrest.png",
 downWalls = {{x = 115, y = 284}, {x = 235, y = 284}},
}
 doorSwitch = math.random(forrestLvl_1.door)]]--

function playerMove(event)
  if(tempVar == 1) then
    transition.cancel(player) 
  end

  if(player.x == event.x and player.y < event.y) then
    player:setSequence("player_down")
  elseif(player.x < event.x and player.y < event.y) then
    player:setSequence("player_right")
  elseif(player.x > event.x and player.y < event.y) then
    player:setSequence("player_left")
  elseif(player.y > event.y) then
    player:setSequence("player_up")
  end
  player:play()

  if(event.x > player.x) then

    timeX = event.x - player.x
  elseif(event.x == player.x) then
    timeX = 1
  else
    timeX = player.x - event.x
  end

  if(event.y > player.y) then
    timeY = event.y - player.y
  else
    timeY = player.y - event.y
  end

  moveTime = math.sqrt((timeX^2)+(timeY^2))*15
  transition.to( player, { time=moveTime, x=event.x, y=event.y, onComplete = fixPlayer } )
  tempVar = 1
end


function fixPlayer(event)
  tempVar = 0
  player:setSequence("player_stand")   
end


function resolve(event)
  if(player.x > other.x and player.y > other.y)then
  	player.x = player.x + 1
  	player.y = player.y + 1
  elseif(player.x < other.x and player.y > other.y)then
  	player.x = player.x - 1
  	player.y = player.y + 1
  elseif(player.x > other.x and player.y < other.y)then
  	player.x = player.x + 1
  	player.y = player.y - 1
  elseif(player.x < other.x and player.y < other.y)then
  	player.x = player.x - 1
  	player.y = player.y - 1
  end	
end


function playerCol(event)
	if(event.other.tag == 1 and stopMotion == 0)then
	
  	if(hit == 1)then
			transition.cancel(player)
			other = event.other
 			tempVar = 0
  		player:setSequence("player_stand")  
  		timer.performWithDelay(50, resolve )
  		hit = 0
		else
			hit = 1
		end

	else
  		stopMotion = 1
	end 

end

function rightCharacter(event)

	--forrest Dungeon Set
  --[[wallRectTop = display.newRect(160, 52, 320, 23)
  wallRectTop:setFillColor(1,0,0, 0)
  physics.addBody (wallRectTop, "kinematic", {filter = CollisionFilters.enemy});
  wallRectLeft = display.newRect(14, 275, 28, 424)
  wallRectLeft:setFillColor(0,1,0, 0)
  physics.addBody (wallRectLeft, "kinematic", {filter = CollisionFilters.enemy});
  wallRectRight = display.newRect(306, 275, 26, 424)
  wallRectRight:setFillColor(0,1,1, 0)
  physics.addBody (wallRectRight, "kinematic", {filter = CollisionFilters.enemy});
  wallRectBottom = display.newRect(160, 504, 320, 33)
  wallRectBottom:setFillColor(1,1,1, 0)
  physics.addBody (wallRectBottom, "kinematic", {filter = CollisionFilters.enemy});
  ]]-- end forrest dungeon
  --[[wallRectRight.tag = 1
  wallRectBottom.tag = 1
  wallRectTop.tag = 1
  wallRectLeft.tag = 1]]--
   --print(display.contentHeight)
  -- print(display.contentWidth)
  --Wood Dungeon Set
 --[[ wallRectTop = display.newRect(160, 63, 319, 46)
  wallRectTop:setFillColor(1,0,0, 0)
  physics.addBody (wallRectTop, "kinematic", {filter = CollisionFilters.enemy});
  wallRectLeft = display.newRect(23,303, 46, 432)
  wallRectLeft:setFillColor(0,1,0, 0)
  physics.addBody (wallRectLeft, "kinematic", {filter = CollisionFilters.enemy});
  wallRectRight = display.newRect(296, 303, 46, 432)
  wallRectRight:setFillColor(0,1,1, 0)
  physics.addBody (wallRectRight, "kinematic", {filter = CollisionFilters.enemy});
  wallRectBottom = display.newRect(160, 496, 225, 46)
  wallRectBottom:setFillColor(1,1,1, 0)
  physics.addBody (wallRectBottom, "kinematic", {filter = CollisionFilters.enemy});
  ]]--end Wood Dungeon Set

  --[[Brick Dungeon Set
  wallRectTop = display.newRect(160, 67, 320, 54)
  wallRectTop:setFillColor(1,0,0, 0)
  physics.addBody (wallRectTop, "kinematic", {filter = CollisionFilters.enemy});
  wallRectLeft = display.newRect(27,279, 54, 370)
  wallRectLeft:setFillColor(0,1,0, 0)
  physics.addBody (wallRectLeft, "kinematic", {filter = CollisionFilters.enemy});
  wallRectRight = display.newRect(293, 279, 54, 370)
  wallRectRight:setFillColor(0,1,1, 0)
  physics.addBody (wallRectRight, "kinematic", {filter = CollisionFilters.enemy});
  wallRectBottom = display.newRect(160, 491, 320, 54)
  wallRectBottom:setFillColor(1,1,1, 0)
  physics.addBody (wallRectBottom, "kinematic", {filter = CollisionFilters.enemy});
  ]]--
  -- end Brick Dungeon Set

end

function fight() 
  local options = { -- options used for gotoScene call
    effect = "fade",
    time = 100,
    params = {
      difficulty = difficulty,
      playerLife = playerLife,
      playerColor = playerColor,
      previousLvl = "gameOver"
    }
  }
  composer.gotoScene("fightScene", options)
end


function nextLevel() 
  local options = { -- options used for gotoScene call
    effect = "fade",
    time = 300,
    params = {
    difficulty = difficulty,
      playerLife = playerLife,
      playerColor = playerColor,
    }
  }
  composer.gotoScene("forrestLvl_2", options)
end

function failPlayer()
          stopper = 0
          player.x = 178
          player.y = 305
end

function clearScreen()
    life:removeSelf()
    lvlText:removeSelf()
    wallRectBottom:removeSelf()
    wallRectRight:removeSelf()
    wallRectLeft:removeSelf()
    wallRectTop:removeSelf()
    player:removeSelf()
    for looper = 1, tempLvlHold.enemy do
      transition.cancel(enemiesPatroling[looper].shape)
      enemiesPatroling[looper].shape:removeSelf()
    end
    for looper = 1, tempLvlHold.door do
      doors[looper]:removeSelf()
    end
    for looper = 1, trapNum do
      traps[looper]:removeSelf()
    end
    for looper = 1, tempLvlHold.sideWall do
      walls[looper]:removeSelf()
    end
    for looper = 1, tempLvlHold.downWall do
      wallsDown[looper]:removeSelf()
    end
    for looper = 1, tempLvlHold.powerUp[1] + tempLvlHold.powerUp[2] do
      powerUps[looper]:removeSelf()
    end
    Runtime._functionListeners = nil 
end

function doorTravel(event)
	if(stopper == 0) then
    transition.cancel(player)
    fixPlayer()
    stopper = 1
    if(event.target.num == 1) then
      audio.play(soundTable["nextLvl"])
      clearScreen()
  		timer.performWithDelay(4100, nextLevel)
  	else
      audio.play(soundTable["wrong"])
  	  timer.performWithDelay(100, failPlayer)     
  	end
	end
end

function trap(event)
  audio.play(soundTable["explodeSound"])
	transition.cancel(player)
  table.remove(trapLoc, event.target.num)
  table.remove(traps, event.target.num)
  event.target:removeSelf()
  trapNum = trapNum - 1
  if(stopper == 0)then 
    playerX = player.x
    playerY = player.y
    stopper = 1
    clearScreen()
  
  	timer.performWithDelay(100, fight)
  end
end

function bannerUpdate(checker)
	if(checker == 1) then
		life:removeSelf()
	end
 	life = display.newText(playerLife, 150, 20, "Times New Roman", hgt/12)
  life:setFillColor(0,0,1)
 
end


function activatePowerUp(event)
	if(event.target.num == 1) then
    audio.play(soundTable["hurt2"])
	  tempLvlHold.powerUp[1] = tempLvlHold.powerUp[1] - 1
    playerLife = playerLife + 1
    bannerUpdate(1)
  else
    audio.play(soundTable["hurt"])
    tempLvlHold.powerUp[2] = tempLvlHold.powerUp[2] - 1
    fightTime = fightTime + 1
 	end

	table.remove(powerUps, event.target.loc)
  table.remove(tempLvlHold.powerUps, event.target.loc)
  event.target:removeSelf()
 	for looper = 1, tempLvlHold.powerUp[1] + tempLvlHold.powerUp[2] do
 		powerUps[looper].loc = looper
 	end
 	stopMotion = 0
end


function activateWordFight(event)
  audio.play(soundTable["enemyTrigger"])
  transition.cancel(event.target)
  table.remove(tempLvlHold.enemies, event.target.num)
  table.remove(tempLvlHold.enemyTracks, event.target.num)
  event.target:removeSelf()
  stopMotion = 0
  playerLife = playerLife - 2
  bannerUpdate(1)
  tempLvlHold.enemy = tempLvlHold.enemy - 1
  for looper = 1, tempLvlHold.enemy do
    enemiesPatroling[looper].num = looper
  end
   
end


function scene:create( event )
 
  local sceneGroup = self.view
  difficulty = event.params.difficulty
  playerColor = event.params.playerColor
    -----------------------------background--------------------------------
  wid, hgt = display.contentWidth, display.contentHeight
  --local background = display.newImage("wooddungeon.png", wid/2, 280 )
  --local background = display.newImage("brickdungeon.png", wid/2, 280 )
  local background = display.newImage("forrestdungeon.png", wid/2, 280 )
  -- composer.removeScene("game")
  sceneGroup:insert(background)
  local banner = display.newImage("banner.png", wid/2, 20 )
  -- composer.removeScene("game")
  sceneGroup:insert(banner)
  physicsDisplayObjects = {}
  tempVar = 0
  hit = 1
  stopper = 0
  playerX = 178
  playerY = 305
  playerLife = 5
  lvlNum = 1
  trapNum = 2
  trapLoc = {{x = 182, y = 121}, {x = 56, y = 375}}
  fightTime = 20
  forrestLvl_1 = { 
    powerType = 2,
    powerUp = {2, 2},
    powerUpImages = {"heart.png", "heart.png"},
    powerUps = {{x = 90, y = 100}, {x = 90, y = 200}, {x = 90, y = 300}, {x = 90, y = 400} },
    enemy = 1,
    enemies = {{x = 268, y = 160}},
    enemyTrack = 0,
    enemyTracks = {{x = 268, y = 200}},
    door = 3,
    imageDoor = "door.png",
    doors = {{x = 182, y = 83}, {x = 268, y = 468}, {x = 48, y = 468}},
    sideWall = 6, 
    imageName = "plantWall.png",
    sideWalls = {{x = 128, y = 239}, {x = 225, y = 239}, {x = 223, y = 344}, {x = 191, y = 344}, {x = 160, y = 344}, {x = 128, y = 344} },
    downWall = 2,
    imageName2 = "downWallForrest.png",
    downWalls = {{x = 115, y = 284}, {x = 235, y = 284}},
  }
  doorSwitch = math.random(forrestLvl_1.door)
      --Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view

   local phase = event.phase

   if ( phase == "will" ) then
   	--audio.play(soundTable["themeMusic"])
    playerLife = event.params.playerLife
   	bannerUpdate(0)
   	wallRectTop = display.newRect(160, 52, 320, 23)
    wallRectTop:setFillColor(1,0,0, 0)
    physics.addBody (wallRectTop, "kinematic", {filter = CollisionFilters.enemy});
    wallRectLeft = display.newRect(14, 275, 28, 424)
    wallRectLeft:setFillColor(0,1,0, 0)
    physics.addBody (wallRectLeft, "kinematic", {filter = CollisionFilters.enemy});
    wallRectRight = display.newRect(306, 275, 26, 424)
    wallRectRight:setFillColor(0,1,1, 0)
    physics.addBody (wallRectRight, "kinematic", {filter = CollisionFilters.enemy});
    wallRectBottom = display.newRect(160, 504, 320, 33)
    wallRectBottom:setFillColor(1,1,1, 0)
    physics.addBody (wallRectBottom, "kinematic", {filter = CollisionFilters.enemy});
    -- end forrest dungeon
    wallRectRight.tag = 1
    wallRectBottom.tag = 1
    wallRectTop.tag = 1
    wallRectLeft.tag = 1
    sceneGroup:insert(wallRectTop)
    sceneGroup:insert(wallRectLeft)
    sceneGroup:insert(wallRectRight)
    sceneGroup:insert(wallRectBottom)

 
    stopper = 0
    stopMotion = 0
    physics.setGravity(0,0)
    hit = 0

 options = 
{
   frames = 
   {
      {x = 0 , y = 0, width = 15, height = 23 }, --1
      {x = 16, y = 0, width = 14, height = 23}, --2
      {x =  32, y = 0, width = 15, height = 23}, --3
      {x =  47, y = 0, width = 15, height = 23}, --4
      {x =  62, y = 0, width = 15, height = 23}, --5
      {x =  77, y = 0, width = 15, height = 23}, --6
      {x =  92, y = 0, width = 15, height = 23}, --7
      {x =  0, y = 23, width = 14, height = 23},--8
      {x =  15, y = 23, width = 14, height = 23},--9
      {x =  30, y = 23, width = 14, height = 23},--10
      {x =  47, y = 23, width = 14, height = 23},--11
      {x =  62, y = 23, width = 14, height = 23},--12
      {x =  77, y = 23, width = 14, height = 23}--13
   }
}
  if(playerColor == 1) then -- red
    sheet = graphics.newImageSheet( "playerSpriteSheetRed.png", options)
  elseif(playerColor == 2) then -- blue
    sheet = graphics.newImageSheet( "playerSpriteSheetBlue.png", options)
  else -- pink
    sheet = graphics.newImageSheet( "playerSpriteSheetPink.png", options)
  end

seqData = {
   {name = "player_stand", frames ={1}},
   {name = "player_down", frames = {2,3,4}, time = 400},
   {name = "player_up", frames = {6,7}, time = 300},
   {name = "player_left", frames = {11,12,13}, time = 400},
   {name = "player_right", frames = {8,9,10}, time = 400},
}

player = display.newSprite(sheet, seqData);
player.x = playerX
player.y = playerY
Runtime:addEventListener('tap', playerMove)
local playerBodyOutline = graphics.newOutline(1, sheet, 1)
physics.addBody (player, "dynamic", {outline = playerBodyOutline, filter = CollisionFilters.player});
player.isFixedRotation = true
player:addEventListener("collision", playerCol)
sceneGroup:insert(player)
   
   composer.removeHidden() 
   powerUps = {}
   doors = {}
   traps = {}
   enemiesPatroling = {}
   walls = {}
   wallsDown = {}
   tempLvlHold = forrestLvl_1

  -- enemies
   for looper = 1, tempLvlHold.enemy do
        enemiesPatroling[looper] = Enemy:new()
        enemiesPatroling[looper]:spawn(tempLvlHold.enemies[looper].x, tempLvlHold.enemies[looper].y, tempLvlHold.enemyTracks[looper].x, tempLvlHold.enemyTracks[looper].y)
        physics.addBody(enemiesPatroling[looper].shape, "kinematic", {filter = CollisionFilters.enemy});
        enemiesPatroling[looper].shape:addEventListener("collision", activateWordFight)
        enemiesPatroling[looper].shape.num = looper
   end


    --doorSwitch = math.random(tempLvlHold.door)
    for looper = 1, tempLvlHold.powerType do
    	for looperInception = 1, tempLvlHold.powerUp[looper] do
    		if(looper == 1) then
    			typeFix = 0
    		else
    			typeFix = tempLvlHold.powerUp[looper-1]
    		end
    		--print(looperInception + typeFix)
    powerUps[looperInception + typeFix] = display.newImage(tempLvlHold.powerUpImages[looper], tempLvlHold.powerUps[looperInception + typeFix].x, tempLvlHold.powerUps[looperInception + typeFix].y )
    sceneGroup:insert(powerUps[looperInception + typeFix])
    physics.addBody (powerUps[looperInception + typeFix], "kinematic", {filter = CollisionFilters.enemy});
    powerUps[looperInception + typeFix].tag = 2
    powerUps[looperInception + typeFix ]:addEventListener("collision", activatePowerUp)
	 if(looper == 1) then
      powerUps[looperInception + typeFix].num = 1
    else
      powerUps[looperInception + typeFix].num = 2
    end
    powerUps[looperInception + typeFix].loc = looperInception + typeFix

	end
  	end

    for looper = 1, tempLvlHold.door do
    doors[looper] = display.newImage("door.png", tempLvlHold.doors[looper].x, tempLvlHold.doors[looper].y )
    sceneGroup:insert(doors[looper])
    physics.addBody (doors[looper], "kinematic", {filter = CollisionFilters.enemy});
    doors[looper].tag = 2
    doors[looper]:addEventListener("collision", doorTravel)
     if(looper == 1) then
      doors[looper].num = 1
    else
      doors[looper].num = 2
    end
   
   
  end

  	for looper = 1, trapNum do
    traps[looper] = display.newRect(trapLoc[looper].x, trapLoc[looper].y, 15, 15)
    traps[looper]:setFillColor(1, 0, 0, 1)
    traps[looper].num = looper
    sceneGroup:insert(traps[looper])
    physics.addBody (traps[looper], "kinematic", {bounce = 0.0, filter = CollisionFilters.enemy});
    traps[looper].isSensor = true
    traps[looper]:addEventListener("collision", trap)
   	--print("create "..looper)
    traps[looper].tag = 0
    
  end

   for looper = 1, tempLvlHold.sideWall do
    walls[looper] = display.newImage(tempLvlHold.imageName, tempLvlHold.sideWalls[looper].x, tempLvlHold.sideWalls[looper].y )
    sceneGroup:insert(walls[looper])
    physics.addBody (walls[looper], "kinematic", {filter = CollisionFilters.enemy});
    walls[looper].tag = 1
 
  end

   for looper = 1, tempLvlHold.downWall do
    wallsDown[looper] = display.newImage(tempLvlHold.imageName2, tempLvlHold.downWalls[looper].x, tempLvlHold.downWalls[looper].y )
    sceneGroup:insert(wallsDown[looper])
    physics.addBody (wallsDown[looper], "kinematic", {filter = CollisionFilters.enemy});
    wallsDown[looper].tag = 1
  
  end
--player sprite
    lvlText = display.newText(lvlNum, 259, 20, "Times New Roman", hgt/12)
   lvlText:setFillColor(0,0,1)

-- Play the background music on channel 1, loop infinitely, and fade in over 5 seconds 



   -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
     -- audio.play(soundTable["themeMusic"])
     for looper = 1, tempLvlHold.enemy do
        
         enemiesPatroling[looper]:patrol()
   end
     -- timer.performWithDelay(3000, showScene2)
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
   	audio.stop()
   	--sceneGroup:removeSelf()
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