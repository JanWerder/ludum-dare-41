require "objects/creeps/creeps"

CreepsBasic = Class{
	__includes = Creeps;
	
	init = function(self, x, y)
		Creeps.init(self, x, y)
		
		--- Creeps Customizing --- 
		-- damage Var's
		self.setLive(self, 1)
		self.setSpeed(self, 1)
		
		-- general stuff
		self.setName(self, 'Basic')
		self.setImage(self, '')
	end;
}	

