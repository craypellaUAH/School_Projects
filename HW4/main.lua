------------------------------------------------------------------------------------
-- Group Members: Cray Pella, Francisco Esteves, Johnathan Berry, Donald Maxwell
-- CS 371
-- Group Project: Math Knight
-- 
-- File: main.lua
--
-- Desc: Math Knight Group Project
-- 
-- Files Included:
--    - forrestLvl_1.lua
--    - forrestLvl_2.lua
--    - forrestLvl_3.lua
--    - woodLvl_4.lua
--    - woodLvl_5.lua
--    - woodLvl_6.lua
--    - brickLvl_7.lua
--    - brickLvl_8.lua
--    - brickLvl_9.lua 
--    - Enemy.lua
--    - fightScene.lua
--    - Tutorial.lua
--    - Credits.lua
--    - Start.lua
--    - Options.lua
--    - soundTable.lua
--
--  Music Sources:
--    - All music and sound effects are from youtube.com.
--    - Music and sound effects were edited using Audacity.
--
--  Art Sources: 
--     - All sprites were created by Cray Pella
--     - backgrounds for each level were created by Cray Pella
--     - backgrounds for each fight scene were pulled from opengameart.org
------------------------------------------------------------------------------------

local widget = require('widget')

local composer = require("composer")

audio.reserveChannels(4)

settings = 
{

	orientation = "landscapeLeft"
}

  local options = { -- options used for gotoScene call
    effect = "fade",
    time = 300,
    params=
    {
    	difficulty = 1,
    	playerColor = 1,
    	playerLife = 5,
    },
  }
  					--Options
composer.gotoScene("Start", options)
