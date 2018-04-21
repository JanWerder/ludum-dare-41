require "objects/Creeps/Creep"

CreepCarrot = Class{
	__includes = Creep;
	
	init = function(self, x, y)
		Creep.init(self, x, y)
		
		--- Creep Customizing --- 
		-- damage Var's
		self:setLife(4)
		self:setHeadMoney(4)
		self:setSpeed(60)
		self:setWidth(32)
		self:setHeight(32)
		
		-- general stuff
		self:setName('Carrot')
		self:setImage(love.graphics.newImage("img/carrot.png"))
	end
}
