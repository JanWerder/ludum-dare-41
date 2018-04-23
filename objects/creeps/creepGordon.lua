require "objects/creeps/creep"

CreepGordon = Class{
	__includes = Creep;
	
	init = function(self, x, y)
		Creep.init(self, x, y)
		
		--- Creep Customizing --- 
		-- damage Var's
		self:setLife(10)
		self:setHeadMoney(10)
		self:setSpeed(40)
		self:setWidth(32)
		self:setHeight(32)
		
		-- general stuff
		self:setName('Gordon')
		self:setImage(love.graphics.newImage("img/cook_gordonrun.png"))
	end,
	menuImage = love.graphics.newImage("img/gordon_dead.png"),
	imageStill = love.graphics.newImage("img/gordon_dead.png"),
	price = 200000
}

function CreepGordon:setDead()
	self:setImage(love.graphics.newImage("img/gordon_dead.png"))
	self:setSpeed(0)
end
