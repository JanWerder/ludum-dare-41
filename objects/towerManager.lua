require "objects/tower/tower"
require "objects/tower/towerBasic"

TowerManager = Class{
	init = function(self)
		self.towers = {}
	end
}

function Tower:update(dt)
	for _,tower in pairs(self.towers) do
		tower.update(dt)
	end
end

function TowerManager:draw()
	for _,tower in pairs(self.towers) do
		tower.draw()
	end
end

function TowerManager:reset()
	self.towers = {}
end

function TowerManager:addTower(x, y, name)
	local tower = nil
	if name == 'basic' then
		tower = TowerBasic(x, y)
	end
	
	if tower ~= nil then
		table.insert(self.towers, tower)
	end
end


