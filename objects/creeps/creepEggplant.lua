require "objects/Creeps/Creep"

CreepEggplant = Class{
	__includes = Creep;
	
	init = function(self, x, y)
		Creep.init(self, x, y)
		
		--- Creep Customizing --- 
		-- damage Var's
		self:setLife(10)
		self:setHeadMoney(5)
		self:setSpeed(40)
		self:setWidth(32)
		self:setHeight(32)
		
		-- general stuff
		self:setName('Eggplant')
		self:setImage(love.graphics.newImage("img/eggplant.png"))
	end,
	menuImage = love.graphics.newImage("img/deatheggplant.png"),
	imageStill = love.graphics.newImage("img/deatheggplant.png"),
	price = 30
}	
function CreepEggplant:setDead()
	self:setImage(love.graphics.newImage("img/deatheggplant.png"))
	self:setSpeed(0)
end
