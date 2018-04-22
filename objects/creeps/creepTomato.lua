require "objects/Creeps/Creep"

CreepTomato = Class{
	__includes = Creep;
	
	init = function(self, x, y)
		Creep.init(self, x, y)
		
		--- Creep Customizing --- 
		-- damage Var's
		self:setLife(4)
		self:setHeadMoney(4)
		self:setSpeed(40)
		self:setWidth(32)
		self:setHeight(32)
		
		-- general stuff
		self:setName('Tomato')
		self:setImage(love.graphics.newImage("img/tomato.png"))
	end,
	menuImage = love.graphics.newImage("img/deathtomato.png"),
	imageStill = love.graphics.newImage("img/deathtomato.png"),
	price = 15
}	
function CreepTomato:setDead()
	self:setImage(love.graphics.newImage("img/deathtomato.png"))
	self:setSpeed(0)
end

