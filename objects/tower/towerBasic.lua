require "objects/tower/tower"

TowerBasic = Class{
	__includes = Tower;
	
	init = function(self, x, y)
		Tower.init(self, x, y)
		
		--- Tower Customizing --- 
		-- damage Var's
		self.setRange(self, 1)
		self.setDamage(self, 1)
		self.setShootCount(self, 1)
		
		-- general stuff
		self.setName(self, 'Basic')
		self.setImage(self, '')
	end;
}	

