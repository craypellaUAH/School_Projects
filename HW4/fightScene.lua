------------------------------------------------------------------------------------
-- Group Members: Cray Pella, Francisco Esteves, Johnathan Berry, Donald Maxwell
-- CS 371
-- Group Project: Math Knight
-- 
-- File: fightScene.lua
--
-- Desc: This file sets up and displays the fight scene.
-- 
------------------------------------------------------------------------------------
local physics = require("physics");
local composer = require("composer")
local soundTable=require("soundTable");
local scene2 = composer.newScene()
local CollisionFilters = {}
CollisionFilters.player = {categoryBits=1, maskBits = 12}
CollisionFilters.bullet = {categoryBits=2, maskBits = 4}
CollisionFilters.enemy = {categoryBits=4, maskBits = 3}
CollisionFilters.enemyBullet = {categoryBits=8, maskBits = 1}

stopAtk = 0 -- used to control player attacks
nextProb = 0 -- used to control displaying new problems
correct = 0 -- used to keep track of the number of correct answers
absoluteStop = 0 -- used to stop all motion

-----------------------------------------------------------------------------
-- func: back
--  params: N/A
--  desc: This function is used to determine if the player goes back to the 
--        previous game scene or goes back to the main menu due to zero life.
-----------------------------------------------------------------------------
function back()
  lifeLeft = playerLife - lifeLoss
  local options = { -- options used for gotoScene call
    effect = "fade",
    time = 300,
    params =
    {
      difficulty = difficulty,
      playerLife = lifeLeft,
      playerColor = playerColor,
    }
  }
  Runtime._functionListeners = nil
  if(lifeLeft < 1)then -- player died, go to main menu
    composer.gotoScene("Start", options)
  else -- player lost or won but did completely lose all life
    composer.gotoScene(returnLvl, options)
  end
end

-----------------------------------------------------------------------------
-- func: dropSquare
--  params: N/A
--  desc: This function is used to create two enemies.
-----------------------------------------------------------------------------
function dropSquare()
  enemy1 = display.newSprite(sheet3, seqData3);
  enemy1.x = 80
  enemy1.y = 52
  enemy1:scale(3,3)
  enemy1:setSequence("slimeLeft")
  enemy1:play()
  physics.addBody(enemy1, "dynamic", {bounce = 0.0});

  enemy2 = display.newSprite(sheet3, seqData3);
  enemy2.x = 240
  enemy2.y = 52
  enemy2:scale(3,3)
  enemy2:setSequence("slimeRight")
  enemy2:play()
  physics.addBody(enemy2, "dynamic", {bounce = 0.0});
end

-----------------------------------------------------------------------------
-- func: timerStart
--  params: N/A
--  desc: This function is used to display and update the timer
-----------------------------------------------------------------------------
function timerStart()
  if(begin == 1) then -- if clock has been called at least once before
  clockText:removeSelf() -- remove previous timer text
  end

  clockText = display.newEmbossedText("TIME:" .. clockNum, display.contentWidth/2, display.contentHeight/8,
                            native.systemFont, display.contentWidth/6) 
  clockText:setFillColor(1,1,1)

  color = 
  {
    highlight = { r=0, g=0, b=0 },
    shadow = { r=0, g=0, b=0 },
  }
  clockText:setEmbossColor( color )
  begin = 1
  clockNum = clockNum - 1
  if(clockNum > -1) then -- if timer not equal to zero
      clockTimer = timer.performWithDelay(1000, timerStart)
  else
    tag = 3
    death() -- lose
  end
end

-----------------------------------------------------------------------------
-- func: problemEasy
--  params: N/A
--  desc: This function is used to create and display an easy problem
-----------------------------------------------------------------------------
function problemEasy()
  if(setting == 1) then -- for levels 1-3
    num1 = math.random(10)
    num2 = math.random(10)
  elseif(setting == 2) then -- for levels 4-6
    num1 = math.random(10)
    num2 = math.random(100)
  else                     -- for levels 7-9
    num1 = math.random(100)
    num2 = math.random(100)
  end
  if(math.random(2) == 2) then
    answer = num1 + num2
    fake = num1 + num2 + 1
    problem = num1 .. "+" .. num2
  else
    answer = num1 - num2
    fake = num1 - num2 + 1
    problem = num1 .. "-" .. num2
  end
  prob = display.newEmbossedText(problem, display.contentWidth/2, display.contentHeight/3,
                            native.systemFont, display.contentWidth/6 )
  prob:setFillColor(1,1,1)
  prob:setEmbossColor(color)
  if(math.random(2) == 2) then
    right = display.newEmbossedText(answer, 80, 495,
                            native.systemFont, display.contentWidth/6 )
    right.side = 1
    wrong = display.newEmbossedText(fake, 240, 495,
                            native.systemFont, display.contentWidth/6 )
    wrong.side = 2
  else
    right = display.newEmbossedText(answer, 240, 495,
                            native.systemFont, display.contentWidth/6 )
    right.side = 2
    wrong = display.newEmbossedText(fake, 80, 495,
                            native.systemFont, display.contentWidth/6 )
    wrong.side = 1
  end 
  right:setFillColor(1,1,1)
  wrong:setFillColor(1,1,1)
  right:setEmbossColor(color)
  wrong:setEmbossColor(color)
end

-----------------------------------------------------------------------------
-- func: problemMedium
--  params: N/A
--  desc: This function is used to create and display a medium problem
-----------------------------------------------------------------------------
function problemMedium()
  if(setting == 1) then -- for levels 1-3
    num1 = math.random(5)
    num2 = math.random(5)
  elseif(setting == 2) then -- for levels 4-6
    num1 = math.random(10)
    num2 = math.random(10)
  else                     -- for levels 7-9
    num1 = math.random(10)
    num2 = math.random(15)
  end
  
  answer = num1 * num2
  if(answer%2 == 1) then
    fake = num1 * (num2 + 1)
  else
    fake = num1 * (num2 + 2 )
  end

  problem = num1 .. "*" .. num2

  prob = display.newEmbossedText(problem, display.contentWidth/2, display.contentHeight/3,
                            native.systemFont, display.contentWidth/6 )
  prob:setFillColor(1,1,1)
  prob:setEmbossColor(color)
  if(math.random(2) == 2) then
    right = display.newEmbossedText(answer, 80, 495,
                            native.systemFont, display.contentWidth/6 )
    right.side = 1
    wrong = display.newEmbossedText(fake, 240, 495,
                            native.systemFont, display.contentWidth/6 )
    wrong.side = 2
  else
    right = display.newEmbossedText(answer, 240, 495,
                            native.systemFont, display.contentWidth/6 )
    right.side = 2
    wrong = display.newEmbossedText(fake, 80, 495,
                            native.systemFont, display.contentWidth/6 )
    wrong.side = 1
  end 
  right:setFillColor(1,1,1)
  wrong:setFillColor(1,1,1)
  right:setEmbossColor(color)
  wrong:setEmbossColor(color)
end

-----------------------------------------------------------------------------
-- func: problemHard
--  params: N/A
--  desc: This function is used to create and display a hard problem
-----------------------------------------------------------------------------
function problemHard()
  if(setting == 1) then -- for levels 1-3
    num1 = math.random(5)
    num2 = math.random(5)
    num3 = math.random(5)
  elseif(setting == 2) then -- for levels 4-6
    num1 = math.random(10)
    num2 = math.random(10)
    num3 = math.random(10)
  else                     -- for levels 7-9
    num1 = math.random(10)
    num2 = math.random(15)
    num3 = math.random(10)
  end
  
  holdTemp = math.random(4)

  if(holdTemp == 1)then
    answer = num1*num2-num3
    if(answer%2 == 1) then
      fake = num1 * (num2 + 1) - num3
    else
      fake = num1 * num2 - num3 + 1
    end
    problem = num1 .. "*" .. num2 .. "-" .. num3
  elseif(holdTemp == 2)then
    answer = num1 + num2 - num3
    if(answer%2 == 1) then
      fake = num1 + (num2 + 1)-num3
    else
      fake = num1 + num2 - num3+1
    end
    problem = num1 .. "+" .. num2 .. "-" .. num3
  elseif(holdTemp == 3) then
    answer = num1 - num2 * num3
    if(answer%2 == 1) then
      fake = num1 - (num2 + 1)*num3
    else
      fake = num1 - num2 * num3+1
    end
    problem = num1 .. "-" .. num2 .. "*" .. num3
  else
    answer = num1*num2+num3
    if(answer%2 == 1) then
      fake = num1 * (num2 + 1)+num3
    else
      fake = num1 * num2 + num3+1
    end
    problem = num1 .. "*" .. num2 .. "+" .. num3
  end
  prob = display.newEmbossedText(problem, display.contentWidth/2, display.contentHeight/3,
                            native.systemFont, display.contentWidth/6 )
  prob:setFillColor(1,1,1)
  prob:setEmbossColor(color)
  if(math.random(2) == 2) then
    right = display.newEmbossedText(answer, 80, 495,
                            native.systemFont, display.contentWidth/6 )
    right.side = 1
    wrong = display.newEmbossedText(fake, 240, 495,
                            native.systemFont, display.contentWidth/6 )
    wrong.side = 2
  else
    right = display.newEmbossedText(answer, 240, 495,
                            native.systemFont, display.contentWidth/6 )
    right.side = 2
    wrong = display.newEmbossedText(fake, 80, 495,
                            native.systemFont, display.contentWidth/6 )
    wrong.side = 1
  end 
  right:setFillColor(1,1,1)
  wrong:setFillColor(1,1,1)
  right:setEmbossColor(color)
  wrong:setEmbossColor(color)
end

-----------------------------------------------------------------------------
-- func: generateProblem
--  params: N/A
--  desc: This function is used to set up the timer and call the correct 
--        problem depending on difficulty
-----------------------------------------------------------------------------
function generateProblem()
  begin = 0
  dropSquare()
  if(nextProb == 1) then 
    prob:removeSelf()
    wrong:removeSelf()
    right:removeSelf()
  end
  nextProb = 1

  if(difficulty == 1) then -- easy
    clockNum = 6 + fightTime
    problemEasy()
  elseif(difficulty == 2) then -- medium
    clockNum = 7 + fightTime
    problemMedium()
  else                         -- hard
    clockNum = 12 + fightTime
    problemHard()
  end
  timerStart()
end

-----------------------------------------------------------------------------
-- func: win
--  params: N/A
--  desc: This function is used when the player gets three problems correct 
-----------------------------------------------------------------------------
function win ()
    prob:removeSelf()
    wrong:removeSelf()
    right:removeSelf()
    lifeLoss = 0
    audio.play(soundTable["win"])
    timer.performWithDelay(3000, back)
end

-----------------------------------------------------------------------------
-- func: death
--  params: N/A
--  desc: This function is used when a player gets a problem incorrect 
-----------------------------------------------------------------------------
function death()
    if(tag == 2)then
        enemy1:removeSelf()
    elseif(tag == 1)then
      enemy2:removeSelf()
    else
      clockText:removeSelf()
      enemy1:removeSelf()
      enemy2:removeSelf()
    end
    prob:removeSelf()
    wrong:removeSelf()
    right:removeSelf()
    lifeLoss = 1 
    player2:setSequence("player_hit")
    player2:play()
    stayHit = 1
    audio.play(soundTable["enemyTrigger"])
    timer.performWithDelay(3000, back)
end

-----------------------------------------------------------------------------
-- func: checkAnswer
--  params: event
--  desc: This function is used to check if the player chose the correct 
--        answer.
-----------------------------------------------------------------------------
function checkAnswer(event) 
  timer.cancel(clockTimer)
  clockText:removeSelf()
  if(atk.side == right.side) then
    enemy1:removeSelf()
    enemy2:removeSelf()
    correct = correct + 1
    --next problem
    if(correct < 3)then
      timer.performWithDelay(1000, generateProblem)
    else
      absoluteStop = 1
      win()
    end
  else
    absoluteStop = 1
    if(event.other == enemy1) then
      tag = 1
    else
      tag = 2
    end
    event.other:removeSelf()
   
    death()
    --end scene
  end
end

-----------------------------------------------------------------------------
-- func: removeAtk
--  params: N/A
--  desc: This function is used to remove the player attack and return the
--        player to the stand position
-----------------------------------------------------------------------------
function removeAtk()
  if(stayHit == 0) then
    player2:setSequence("player_stand")
  end
  atk:removeSelf()
  stopAtk = 0
end

-----------------------------------------------------------------------------
-- func: playerAtk
--  params: event
--  desc: This function is used by an event listener for Runtime to create 
--        a player attack on the side of the screen that the player taps
-----------------------------------------------------------------------------
function playerAtk(event)
  if(stopAtk == 0 and absoluteStop == 0) then
    stopAtk = 1
    atk = display.newSprite(sheet2, seqData2);
    if(event.x < player2.x) then
      player2:setSequence("player_right")
      atk.x = 80
      atk.y = 446
      atk:setSequence("swordSwingRight")
      atk.side = 1
    else
      player2:setSequence("player_left")
      atk.x = 240
      atk.y = 446
      atk:setSequence("swordSwingLeft")
      atk.side = 2
    end
    atk:scale(3,3)
    atk:play()
    physics.addBody(atk, "kinematic", {bounce = 0.0});
    atk:addEventListener("collision", checkAnswer)
    timer.performWithDelay(1000, removeAtk)
  end
end

-- "scene:create()"
function scene2:create( event )
 
  local sceneGroup = self.view
   
    -- used for lettering lining
   color = 
    {
      highlight = { r=0, g=0, b=0 },
      shadow = { r=0, g=0, b=0 },
    }
    -----------------------------background--------------------------------
  wid, hgt = display.contentWidth, display.contentHeight
  stayHit = 0 -- used for attack collisions with enemies
  local optionsBack = 
  {
    frames = 
    {
      {x = 640, y = 0, width = 320, height = 520}, 
      {x = 320, y = 0, width = 320, height = 520},
      {x = 0 , y = 0, width = 320, height = 520 }, 
    }
  }
  sheetBack = graphics.newImageSheet( "fightBackGround2.png", optionsBack)
  returnLvl = event.params.previousLvl
  -- used to determine the fight background
  if(returnLvl == "forrestLvl_1" or returnLvl == "forrestLvl_2" or returnLvl == "forrestLvl_3")then
     setting = 1
  elseif(returnLvl == "woodLvl_4" or returnLvl == "woodLvl_5" or returnLvl == "woodLvl_6") then
      setting = 2
  else
      setting = 3
  end  
  
  local background = display.newImage(sheetBack, setting )
  background.x = display.contentWidth / 2;
  background.y= display.contentHeight / 2;
  sceneGroup:insert(background)
  
  lifeLoss = 0 -- used to affect player life if the player loses
  playerLife = event.params.playerLife
  difficulty = event.params.difficulty
  fightTime = event.params.fightTime

  -- invisible blocks used to hold and stop enemies
  wallRect = display.newRect(160, 500, 320, 40)
  wallRect:setFillColor(0,1,0, 0)
  physics.addBody (wallRect, "kinematic", {bounce = 0.0});
  sceneGroup:insert(wallRect)

  enemy1Hold = display.newRect(80, 460, 40, 2)
  enemy1Hold:setFillColor(0,1,0, 0)
  physics.addBody (enemy1Hold, "kinematic", {bounce = 0.0});
  sceneGroup:insert(enemy1Hold)

  enemy2Hold = display.newRect(240, 460, 40, 2)
  enemy2Hold:setFillColor(0,1,0, 0)
  physics.addBody (enemy2Hold, "kinematic", {bounce = 0.0});
  sceneGroup:insert(enemy2Hold)
  -- end invisible blocks used to hold and stop enemies
 
 -- player sheet
  local options = 
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
      {x =  77, y = 23, width = 14, height = 23},--13
      {x = 0, y = 46, width = 15, height = 23},
      {x = 16, y = 47, width = 15, height = 21},
   }
}

  -- sword sheet
  local options2 = 
{
   frames = 
   {
      {x = 0 , y = 0, width = 15, height = 21 }, --1
      {x = 16, y = 0, width = 11, height = 21}, --2
      {x = 27, y = 0, width = 11, height = 21},
      {x = 38, y = 0, width = 15, height = 21},

   }
}

-- enemy sheet
local options3 = 
{
  frames =
  {
     {x = 0 , y = 0, width = 22, height = 21 }, --1
      {x = 22, y = 0, width = 18, height = 21},
      {x = 40, y = 0, width = 18, height = 21}, 
      {x = 58, y = 0, width = 18, height = 21},
      {x = 76, y = 0, width = 18, height = 21}, 
      {x = 95, y = 0, width = 18, height = 21 }, --1
      {x = 113, y = 0, width = 18, height = 21},
      {x = 131, y = 0, width = 18, height = 21}, 
      {x = 149, y = 0, width = 18, height = 21},
      {x = 167, y = 0, width = 22, height = 21}, 
}
}

-- determine what color the player sprite is
if(event.params.playerColor == 1) then
 sheet = graphics.newImageSheet( "playerSpriteSheetRed.png", options)
elseif(event.params.playerColor == 2) then
  sheet = graphics.newImageSheet( "playerSpriteSheetBlue.png", options)
  else
 sheet = graphics.newImageSheet( "playerSpriteSheetPink.png", options)
  end
sheet2 = graphics.newImageSheet( "swordRed.png", options2)
sheet3 = graphics.newImageSheet("slimeSheet.png", options3)

seqData3 = {
  {name = "slimeLeft", frames = {6,7,8,9,10}, time = 1500},
  {name = "slimeRight", frames = {5,4,3,2,1}, time = 1500},
}

local seqData = {
   {name = "player_stand", frames ={1}},
   {name = "player_down", frames = {2,3,4}, time = 400},
   {name = "player_up", frames = {6,7}, time = 300},
   {name = "player_left", frames = {8}},
   {name = "player_right", frames = {13}},
   {name = "player_hit", frames = {14,15}, time = 1000},
}

seqData2 = {
  {name = "sword", frames = {2}},
  {name = "swordSwingLeft", frames = {2,1}, time = 500},
  {name = "swordSwingRight", frames = {3,4}, time = 500},
  
}

player2 = display.newSprite(sheet, seqData);
player2.x = 160
player2.y = 440
player2:scale(3, 3)
Runtime:addEventListener('tap', playerAtk)

player2:setSequence("player_stand")
player2.isVisible = true

sceneGroup:insert(player2)

physics.start(); -- start physics
physics.setGravity(0, 6); 


---Score

      -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene2:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
    --audio.play(soundTable["fightMusic"])
    local fightMusicChannel = audio.play( soundTable["fightMusic"], {channel=2, loops=-1} )
    audio.setVolume( 0.2, { channel=2 } ) 
      --composer.removeHidden() -- remove all scenes and reset game from credits scene

-- Play the background music on channel 1, loop infinitely, and fade in over 5 seconds 



   -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
     generateProblem()
     -- timer.performWithDelay(3000, showScene2)
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end
 
-- "scene:hide()"
function scene2:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
    audio.stop()
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then

      -- Called immediately after scene goes off screen.
   end
end
 
-- "scene:destroy()"
function scene2:destroy( event )
 
   local sceneGroup = self.view
   
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene2:addEventListener( "create", scene2 )
scene2:addEventListener( "show", scene2 )
scene2:addEventListener( "hide", scene2 )
scene2:addEventListener( "destroy", scene2 )
 
---------------------------------------------------------------------------------
 
return scene2