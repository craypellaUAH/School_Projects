------------------------------------------------------------------------------------
-- Cray Pella
-- CS 371
-- H/W 4
-- 
-- File: enemy.lua
--
-- Desc: This file and code was provided by the instructor.
-- 
------------------------------------------------------------------------------------


local soundTable=require("soundTable");
local CollisionFilters = {}
CollisionFilters.player = {categoryBits=1, maskBits = 12}
CollisionFilters.bullet = {categoryBits=2, maskBits = 4}
CollisionFilters.enemy = {categoryBits=4, maskBits = 3}
CollisionFilters.enemyBullet = {categoryBits=8, maskBits = 1}


local Enemy = {tag=2}--, HP=1, xPos=0, yPos=0, fR=0, sR=0, bR=0, fT=1000, sT=500, bT	=500};


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

sheet3 = graphics.newImageSheet("slimeSheet.png", options3)

seqData3 = {
  {name = "slimeLeft", frames = {6,7,8,9,10}, time = 1500},
  {name = "slimeRight", frames = {5,4,3,2,1}, time = 1500},
}

function Enemy:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Enemy:spawn(xLoc, yLoc, xP, yP)
 self.shape=display.newSprite(sheet3, seqData3);
 self.xPos = xLoc
 self.yPos = yLoc
 self.xPatrol = xP
 self.yPatrol = yP
 self.shape.x = self.xPos
 self.shape.y = self.yPos
 self.direction = 0
 --print(self.shape.x .. self.shape.y)
 self.shape.pp = self;  -- parent object
 self.shape.tag = self.tag; -- “enemy”
 --physics.addBody(self.shape, "kinematic", {filter = CollisionFilters.enemy}); 
 --self.shape:setSequence("slimeLeft")


end

function Enemy:patrol()   
	--self.shape:play()
	if(self.direction == 0) then
  if(self.shape.x < self.xPatrol) then
    self.shape:setSequence("slimeLeft")
  else
    self.shape:setSequence("slimeRight")
  end
   transition.to(self.shape, {x=self.xPatrol, y=self.yPatrol, time = 5000, onComplete = function (obj) self:patrol() end});
   self.direction = 1
else
    if(self.shape.x < self.xPos) then
    self.shape:setSequence("slimeLeft")
  else
    self.shape:setSequence("slimeRight")
  end
	transition.to(self.shape, {x=self.xPos, y=self.yPos, time = 5000, onComplete = function (obj) self:patrol() end});
   self.direction = 0
end
self.shape:play()
end

function Enemy:move ()	
	self:forward();
end

return Enemy

