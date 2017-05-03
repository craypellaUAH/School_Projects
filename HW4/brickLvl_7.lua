---------------------------------------------------------------------------------------
-- Group Members: Cray Pella, 
-- CS 371
-- Group Project: Math Knight
-- 
-- File: brickLvl_7.lua
--
-- Desc: This file sets up and displays level 7 of the game. Refer to forrestLvl_1.lua 
--       more comments about this file. It is a copy of forrestLvl_1.lua and has 
--       essentially the same code.
-- 
---------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local soundTable=require("soundTable");
local widget = require('widget')
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

--------------------------------------------------------
-- func: playerMove
--  params: event
--  desc: This function is used by an event listener
--        and handles transitioning the player across
--        the screen
--------------------------------------------------------
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

--------------------------------------------------------
-- func: fixPlayer
--  params: event
--  desc: This function is used called at the end of 
--        each player transition to return the player
--        to the standing position
--------------------------------------------------------
function fixPlayer(event)
  tempVar = 0
  player:setSequence("player_stand")   
end

--------------------------------------------------------
-- func: resolve
--  params: event
--  desc: This function is used to relocate the player
--        after the player runs into a wall
--------------------------------------------------------
function resolve(event)
  if(stoper2 == 0) then
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
end

--------------------------------------------------------
-- func: playerCol
--  params: event
--  desc: This function is used by an event listener 
--        for the player. It determines how the player
--        reacts after hitting different types of 
--        objects.
--------------------------------------------------------
function playerCol(event)
  if(event.other.tag == 1 and stopMotion == 0)then
  
    if(hit == 1)then
      transition.cancel(player)
      other = event.other
      tempVar = 0
      player:setSequence("player_stand")  
      resolveTimer = timer.performWithDelay(50, resolve )
      hit = 0
    else
      hit = 1
    end

  else
      if(hit == 0)then
      stopper2 = 1
      stopMotion = 1
      end
    
  end 

end

--------------------------------------------------------
-- func: fight
--  params: N/A
--  desc: This function moves the game to the fight 
--        scene.
--------------------------------------------------------
function fight() 
  local options = { -- options used for gotoScene call
    effect = "zoomInOut",
    time = 500,
      params = {
      difficulty = difficulty,
      playerLife = playerLife,
      playerColor = playerColor,
       fightTime = fightTime,
      previousLvl = "brickLvl_7",
    }
  }
  composer.gotoScene("fightScene", options)
end

--------------------------------------------------------
-- func: nextLevel
--  params: N/A
--  desc: This function moves the game to next level
--------------------------------------------------------
function nextLevel() 
  local options = { -- options used for gotoScene call
    effect = "crossFade",
    time = 500,
    params = {
      difficulty = difficulty,
      playerLife = playerLife,
      playerColor = playerColor,
       fightTime = fightTime,
    }
  }
  composer.gotoScene("brickLvl_8", options)
end

--------------------------------------------------------
-- func: failPlayer
--  params: N/A
--  desc: This function moves the player back to the 
--        starting point of the current level. Called
--        when the player collides with the wrong door.
--------------------------------------------------------
function failPlayer()
          stopper = 0
          stopMotion = 0
          player.x = 162
          player.y = 277
end

function testerFunc(event)
	print(event.x)
	print(event.y)
end

--------------------------------------------------------
-- func: clearScreen
--  params: N/A
--  desc: This function removes all the currently 
--        viewable objects from the screen. 
--------------------------------------------------------
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
    for looper = 1, tempLvlHold.lamp do
    	lampLocal[looper]:removeSelf()
    end
    Runtime._functionListeners = nil 
end

--------------------------------------------------------
-- func: startOver
--  params: N/A
--  desc: This function moves the game to the Main Menu
--        after the player dies
--------------------------------------------------------
function startOver()
 local options = { -- options used for gotoScene call
    effect = "fade",
    time = 1000,
    params = {
    difficulty = difficulty,
      playerColor = playerColor,
    }
  }
  composer.gotoScene("Start", options)
end

--------------------------------------------------------
-- func: live_die
--  params: N/A
--  desc: This function is used to check if a player has
--        died (out of life) 
--------------------------------------------------------
function live_die()
  if(playerLife < 1) then
    audio.play(soundTable["lose"])
    clearScreen()
    timer.performWithDelay(5500, startOver)
  end
end

--------------------------------------------------------
-- func: doorTravel
--  params: event
--  desc: This function is used by an event listener for
--        each door. It determines if the player chose
--        correct door.
--------------------------------------------------------
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

--------------------------------------------------------
-- func: trap
--  params: event
--  desc: This function is used by an event listener for
--        each trap block. When the player collides with
--        a trap block, the game moves to the fight 
--        scene.
--------------------------------------------------------
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

--------------------------------------------------------
-- func: bannerUpdate
--  params: checker - is integer value used to determine
--                    if bannerUpdate have been called 
--                    once before.
--  desc: This function is used to update the displayed
--        life total of the player.
--------------------------------------------------------
function bannerUpdate(checker)
	if(checker == 1) then
		life:removeSelf()
	end
 	life = display.newText(playerLife, 150, 20, "Times New Roman", hgt/12)
  life:setFillColor(0,0,1)
end

--------------------------------------------------------
-- func: activatePowerUp
--  params: event
--  desc: This function is used by a event listener for
--        powerups. It determines what kind of powerup
--        the player has collided with and performs
--        the appropriate update to stats.
--------------------------------------------------------
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

--------------------------------------------------------
-- func: activateWordFight
--  params: event
--  desc: This function is by an event listener for each
--        enemy. When a player collides with an enemy
--        the player's life is reduced and the enemy is
--        destroyed.
--------------------------------------------------------
function activateWordFight(event)
  transition.cancel(player)
  audio.play(soundTable["enemyTrigger"])
  transition.cancel(event.target)
  table.remove(tempLvlHold.enemies, event.target.num)
  table.remove(tempLvlHold.enemyTracks, event.target.num)
  table.remove(enemiesPatroling, event.target.num)
  event.target:removeSelf()
  stopMotion = 0
  playerLife = playerLife - 2
  bannerUpdate(1)
  tempLvlHold.enemy = tempLvlHold.enemy - 1
  for looper = 1, tempLvlHold.enemy do
    enemiesPatroling[looper].num = looper
  end
  timer.performWithDelay(50, live_die)
end

function splitUpEnemy(currentEnemy)
	currentEnemy:patrol()
end

function scene:create( event )
 
  local sceneGroup = self.view
  difficulty = event.params.difficulty
  playerColor = event.params.playerColor
  fightTime = event.params.fightTime
    -----------------------------background--------------------------------
  wid, hgt = display.contentWidth, display.contentHeight
--local background = display.newImage("wooddungeon.png", wid/2, 280 )
  local background = display.newImage("brickdungeon.png", wid/2, 280 )
  --local background = display.newImage("forrestdungeon.png", wid/2, 280 )
  sceneGroup:insert(background)
  local banner = display.newImage("banner.png", wid/2, 20 )
  sceneGroup:insert(banner)
  tempVar = 0
  hit = 1
  stopper = 0
  stopper2 = 0
  playerX = 162
  playerY = 277
  playerLife = event.params.playerLife
  lvlNum = 7
  trapNum = 8
  trapLoc = {{x = 226, y = 273}, {x = 88, y = 274}, {x = 99, y = 113}, {x = 237, y = 160}, {x = 244, y = 363}, {x = 215, y = 444}, {x = 117, y = 352}, {x = 139, y = 445}}

  forrestLvl_1 = { 
  	lamp = 6,
  	lamps = {{x = 56, y = 454}, {x = 260, y = 453}, {x = 260, y =260}, {x = 62, y = 280}, {x = 62, y = 101}, {x = 261, y = 104}},
    powerType = 1,
    powerUp = {2, 0},
    powerUpImages = {"heart.png"},
    powerUps = {{x = 238, y = 119}, {x = 78, y = 346}},
    enemy = 2,
    enemies = {{x = 168, y = 117}, {x = 157, y = 364}},
    enemyTracks = {{x = 168, y = 211}, {x = 213, y = 368}},
    door = 2,
    imageDoor = "door.png",
    doors = {{x = 75, y = 450}, {x = 241, y = 203}},
 	sideWall = 6,
	imageName = "sideWallBrick.png",
	sideWalls = {{x = 128, y = 235},{x = 170, y = 235},{x = 234, y = 235},{x = 194, y = 306},{x = 150, y = 306}, {x = 86, y = 306}},
	downWall = 9,
	imageName2 = "downWallBrick.png",
	downWalls = {{x = 225, y = 337},{x = 225, y = 375},{x = 183, y = 419},{x = 139, y = 338},{x = 139, y = 374},{x = 96, y = 419},{x = 100, y = 179},{x = 151, y = 136},{x = 211, y = 173}},

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
     playerLife = event.params.playerLife
   	--audio.play(soundTable["themeMusic"])
   	bannerUpdate(0)

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
    hit = 1

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

--lamp sprite
local options4 = 
{
	frames = 
{
	{x = 0 , y = 0, width = 8, height = 22 }, --1
{x = 9, y = 0, width = 10, height = 22}, --2
{x =  19, y = 0, width = 10, height = 22}, --3
{x =  29, y = 0, width = 15, height = 22}, --4

}
};

local sheet4 = graphics.newImageSheet("lampSheet.png", options4);

local seqData4 = {
	{name = "lamp", frames = {1,2,3,4}, time = 600},
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
   
--Runtime:addEventListener('tap', testerFunc)   
   composer.removeHidden() 
   powerUps = {}
   doors = {}
   traps = {}
   enemiesPatroling = {}
   lampLocal = {}
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


    -- power ups
    for looper = 1, tempLvlHold.powerType do
    	for looperInception = 1, tempLvlHold.powerUp[looper] do
    		if(looper == 1) then
    			typeFix = 0
    		else
    			typeFix = tempLvlHold.powerUp[looper-1]
    		end
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

    -- doors
    for looper = 1, tempLvlHold.door do
      doors[looper] = display.newImage("door.png", tempLvlHold.doors[looper].x, tempLvlHold.doors[looper].y )
      sceneGroup:insert(doors[looper])
      physics.addBody (doors[looper], "kinematic", {filter = CollisionFilters.enemy});
      doors[looper].tag = 2
      doors[looper]:addEventListener("collision", doorTravel)
      if(looper == doorSwitch) then
        doors[looper].num = 1
      else
        doors[looper].num = 2
      end
    end

    -- traps
  	for looper = 1, trapNum do
      traps[looper] = display.newRect(trapLoc[looper].x, trapLoc[looper].y, 15, 15)
      traps[looper]:setFillColor(1, 0, 0, 0)
      traps[looper].num = looper
      sceneGroup:insert(traps[looper])
      physics.addBody (traps[looper], "kinematic", {bounce = 0.0, filter = CollisionFilters.enemy});
      traps[looper].isSensor = true
      traps[looper]:addEventListener("collision", trap)
      traps[looper].tag = 0
    end

    -- sideWalls
      for looper = 1, tempLvlHold.sideWall do
        walls[looper] = display.newImage(tempLvlHold.imageName, tempLvlHold.sideWalls[looper].x, tempLvlHold.sideWalls[looper].y )
        sceneGroup:insert(walls[looper])
        physics.addBody (walls[looper], "kinematic", {filter = CollisionFilters.enemy});
        walls[looper].tag = 1
      end

      -- downWalls
   for looper = 1, tempLvlHold.downWall do
    wallsDown[looper] = display.newImage(tempLvlHold.imageName2, tempLvlHold.downWalls[looper].x, tempLvlHold.downWalls[looper].y )
    sceneGroup:insert(wallsDown[looper])
    physics.addBody (wallsDown[looper], "kinematic", {filter = CollisionFilters.enemy});
    wallsDown[looper].tag = 1
  
  end  

  for looper = 1, tempLvlHold.lamp do
   		lampLocal[looper] = display.newSprite(sheet4, seqData4);
		lampLocal[looper].x = tempLvlHold.lamps[looper].x
		lampLocal[looper].y = tempLvlHold.lamps[looper].y
		sceneGroup:insert(lampLocal[looper])
		lampLocal[looper]:setSequence("lamp")
   end

    lvlText = display.newText(lvlNum, 259, 20, "Times New Roman", hgt/12)
   lvlText:setFillColor(0,0,1)

-- Play the background music on channel 1, loop infinitely, and fade in over 5 seconds 



   -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
    live_die()
   	local themeMusicChannel = audio.play( soundTable["souls"], {channel=1, loops=-1} )
    audio.setVolume( 0.2, { channel=1 } ) 
    for looper = 1, tempLvlHold.enemy do
      --[[local funcHold = function() return splitUpEnemy(enemiesPatroling[looper]) end
		timer.performWithDelay( math.random(4000), funcHold)]]--
		enemiesPatroling[looper]:patrol()
    end
    for looper = 1, tempLvlHold.lamp do
    	lampLocal[looper]:play()
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