require "objects/Creeps/Creep"

CreepBasic = Class{
	__includes = Creep;
	
	init = function(self, x, y)
		Creep.init(self, x, y)
		
		--- Creep Customizing --- 
		-- damage Var's
		self:setLife(5)
		self:setSpeed(40)
		self:setWidth(32)
		self:setHeight(32)
		
		-- general stuff
		self:setName('Tomato')
		self:setImage(love.graphics.newImage("img/tomato.png"))
	end
}	

