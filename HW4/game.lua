------------------------------------------------------------------------------------
-- Cray Pella
-- CS 371
-- H/W 4
-- 
-- File: game.lua
--
-- Desc: This file sets up and displays the game screen.
-- 
-- Scene Files:
--  start.lua
--  game.lua
--  gameOver.lua
--
------------------------------------------------------------------------------------
local physics = require("physics");
local composer = require("composer")
local Enemy = require ("Enemy");
local soundTable=require("soundTable");
local Pentagon = require ("Pentagon");
local Triangle = require ("Triangle")
local scene = composer.newScene()
physics.start(); -- start physics
physics.setGravity(0,0); 
display.setStatusBar( display.HiddenStatusBar )

-- Set up collision filter
local CollisionFilters = {}
CollisionFilters.player = {categoryBits=1, maskBits = 12}
CollisionFilters.bullet = {categoryBits=2, maskBits = 4}
CollisionFilters.enemy = {categoryBits=4, maskBits = 3}
CollisionFilters.enemyBullet = {categoryBits=8, maskBits = 1}
stop = 1
hits = 0 
u = 0  -- u is used as a control variable to adjust triangle enemies movement
--triExist = 0
tris = {} -- tris is a table holding all triangle enemies generated
pents = {} -- pents is a table holding all pentagon enemies generated
pCnt = 0 -- number of pentagon enemies created
tCnt = 0 -- number of triange enemies created
--local tripod = display.newGroup()

------------------------------------------------------------------
-- next
--  param: N/A
--  This function is used to clean up any bullets fired and go to 
--  the gameOver scene
------------------------------------------------------------------
function next()
  Runtime:dispatchEvent({name = "destroyBulletTri"}) -- remove any bullets shot by triangle enemies
  Runtime:dispatchEvent({name = "destroyBullet"}) -- remove any bullets shot by pentagon enemies
  scoreText:removeSelf() -- remove score bar
  Runtime._functionListeners = nil -- removes all Runtime Listeners
 -- Runtime._tableListeners = nil
  if(cube.hp < 1) then -- if hp is zero 
    var1 = "Game Over"
  else
    var1 = "VICTORY!"
  end
  cube = nil  
  local options = { -- options used for gotoScene call
    effect = "fade",
    time = 300,
    params =
    {
      var2 = var1
    }
  }
  composer.gotoScene("gameOver", options)
end

------------------------------------------------------------------
-- endGame
--  param: N/A
--  This function is used to clean up any enemies on screen after 
--  the game over
------------------------------------------------------------------
function endGame()
  timer.cancel(spawner) -- stop spawning enemies
  cube.isVisible = false -- hide cube
  stop = 0
  Runtime:dispatchEvent({name = "destroyPent"}) -- remove pentagon enemies
  Runtime:dispatchEvent({name = "destroyTri"}) -- remove triangle enemies
    -- Runtime:dispatchEvent({name = "destroy"})
  timer.performWithDelay(1000, next)
end

------------------------------------------------------------------
-- playerCol
--  param: event
--  This function is used to handle collisions between the player
--  and other objects
------------------------------------------------------------------
local function playerCol(event)
  if(event.other.tag == "enemy" ) then -- if triangle or pentagon
    event.other.pp.HP = 1
    event.other.pp:hit()
    cube.hp = cube.hp - 1
    audio.play( soundTable["hurt"] );
  else                                -- else enemy bullet
    cube.hp = cube.hp - 1
    audio.play( soundTable["hurt2"] );
  end

  if(cube.hp < 1 and stop == 1) then -- if player hp below zero, stop used 
                                      -- to handle multiple collisions
    if(u == 1) then  -- cancel movement updates for triangle enemies
      timer.cancel(tid)
      u = 0
    end
    timer.cancel(ender)
    endGame()
  end
end

------------------------------------------------------------------
-- gameControl
--  param: N/A
--  This function is used to generate enemies randomly
------------------------------------------------------------------
function gameControl()
  local temp = math.random(1,2)
  if(temp == 1) then -- generate pentagon
    pents[pCnt] = Pentagon:new({xPos=math.random(0, display.contentWidth), yPos=0});
    pents[pCnt]:spawn(); 
    pents[pCnt]:forward();
    pents[pCnt]:shoot(2000);
    pCnt = pCnt + 1
  else   -- generate triangle
    tris[tCnt] = Triangle:new({xPos=math.random(0, display.contentWidth), yPos=0});
    tris[tCnt]:spawn();
    tris[tCnt]:forward(cube);
    tris[tCnt]:shoot(1500);
    tCnt = tCnt + 1
  end 
  spawner = timer.performWithDelay(math.random(500, 3000), gameControl)
end

------------------------------------------------------------------
-- startGame
--  param: N/A
--  This function is used to start the game.
------------------------------------------------------------------
function startGame()
  ender = timer.performWithDelay(180000, endGame) -- ends game after 3 minutes
  gameControl()
end

------------------------------------------------------------------
-- move
--  param: event
--  This function is used to handle player movement and control
--  triangle enemy movement
------------------------------------------------------------------
local function move ( event )
	if event.phase == "began" then		
		cube.markX = cube.x 
    if(u == 1) then
      timer.cancel(tid)
      u = 0
    end
	elseif event.phase == "moved" then	 
	 	local x = (event.x - event.xStart) + cube.markX	 	
	 	if (x <= 20 + cube.width/2) then
		   cube.x = 20+cube.width/2;
		elseif (x >= display.contentWidth-20-cube.width/2) then
		   cube.x = display.contentWidth-20-cube.width/2;
		else
		   cube.x = x;		
		end
    if(u == 0) then
		  tid = timer.performWithDelay(100, 
      function() 
        Runtime:dispatchEvent({name = "triMove", player = cube}) -- make all triangle enemies
                                                                 -- adjust movement
      end,
      -1)
	    u = 1
    end
  end  
end

------------------------------------------------------------------
-- pastPlayer
--  param: event
--  This function is used to clean up any enemies that move off
--  screen.
------------------------------------------------------------------
function pastPlayer(event)
   if(event.other.tag == "enemy" ) then
      event.other.pp.HP = 1
      event.other.pp:hit()
   end
end

------------------------------------------------------------------
-- updateScore
--  param: N/A
--  This function is used to adjust player score
------------------------------------------------------------------
function updateScore()
  scoreText:removeSelf()
  scoreText = 
  display.newEmbossedText(string.format("Hit: %d", hits), 200, 50, native.systemFont, 40 );
  scoreText:setFillColor( 0,0.5,0 );

  local color = 
  {
    highlight = {0,1,1},   
    shadow = {0,1,1}  
  }
  scoreText:setEmbossColor( color );
end

------------------------------------------------------------------
-- fire
--  param: event
--  This function is used to handle firing player bullets
------------------------------------------------------------------
local function fire (event) 
  if(cube ~= nil) then
  local p = display.newCircle (cube.x, cube.y-16, 5);
	p.anchorY = 1;
	p:setFillColor(0,1,0);
	physics.addBody (p, "dynamic", {radius=5, bounce = 0.0, filter = CollisionFilters.bullet} );
	p:applyForce(0, -0.4, p.x, p.y);
	audio.play( soundTable["shootSound"] );

	local function removeProjectile (event)
    if (event.phase=="began") then
	   	event.target:removeSelf();
      event.target=nil;
      hits = hits + 1
      event.other.pp:hit();
      updateScore()
    end
  end
    p:addEventListener("collision", removeProjectile);
 end
end

-- "scene:create()"
function scene:create( event )
 
  local sceneGroup = self.view
    -----------------------------background--------------------------------
  wid, hgt = display.contentWidth, display.contentHeight
  local background = display.newImage("sky.png", wid/2, hgt/2 )
 
  sceneGroup:insert(background)
  blockBar = display.newRect(display.contentWidth/2, display.contentHeight + 50, display.contentWidth, 10 )
  sceneGroup:insert(blockBar)
  blockBar.isVisible = false
  physics.addBody(blockBar, "kinematic", {filter = CollisionFilters.player})
  blockBar:addEventListener("collision", pastPlayer)
  controlBar = display.newRect (display.contentCenterX, display.contentHeight-65, display.contentWidth, 70);
  controlBar:setFillColor(1,1,1,0.2);
  sceneGroup:insert(controlBar)
---- Main Player
  cube = display.newCircle (display.contentCenterX, display.contentHeight-150, 15);
  physics.addBody (cube, "kinematic", {filter = CollisionFilters.player});
  cube:addEventListener("collision", playerCol)
  cube.hp = 5
  cube.isSensor = true
  sceneGroup:insert(cube)

  controlBar:addEventListener("touch", move);

-- Projectile 
  cnt = 0;

    Runtime:addEventListener("tap", fire)  

---Score
scoreText = 
    display.newEmbossedText(string.format("Hit: %d", hits), 200, 50,
                             native.systemFont, 40 );

scoreText:setFillColor( 0,0.5,0 );

local color = 
{
	highlight = {0,1,1},   
	shadow = {0,1,1}  
}
scoreText:setEmbossColor( color );

scoreText.hit = 0;
      -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      composer.removeHidden() -- remove all scenes and reset game from credits scene
      startGame()
-- Play the background music on channel 1, loop infinitely, and fade in over 5 seconds 



   -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
     
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