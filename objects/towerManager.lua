require "objects/tower/tower"
require "objects/tower/towerBasic"

TowerManager = Class{
	init = function(self)
		self.towers = {}
	end
}

function TowerManager:addTower(x, y, name)
	if name == 'basic' then
		local tower = TowerBasic(x, y)
	end
	
	if tower ~= nil then
		table.insert(self.towers, tower)
	end
end


