require "objects/Creeps/Creep"

CreepBasic = Class{
	__includes = Creep;
	
	init = function(self, x, y)
		Creep.init(self, x, y)
		
		--- Creep Customizing --- 
		-- damage Var's
		self:setLife(5)
		self:setSpeed(50)
		
		-- general stuff
		self:setName('Basic')
		self:setImage('')
	end
}	

