require "objects/Creeps/Creep"

CreepBasic = Class{
	__includes = Creep;
	
	init = function(self, x, y)
		Creep.init(self, x, y)
		
		--- Creep Customizing --- 
		-- damage Var's
		--[[self.setLive(self, 1)
		self.setSpeed(self, 1)
		
		-- general stuff
		self.setName(self, 'Basic')
		self.setImage(self, '')]]
	end
}	

