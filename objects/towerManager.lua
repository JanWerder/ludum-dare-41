require "objects/tower/tower"
require "objects/tower/towerBasic"

TowerManager = Class{
	init = function(self)
		self.towers = {}
	end;
	
	addTower = function(self, x, y, name)
		if name == 'basic' then
			tower = TowerBasic(self, x, y)
		end
		
		table.insert(towers, tower)
	end;
}