require "objects/tower/tower"
require "objects/tower/towerKnife"

TowerManager = Class{
	init = function(self)
		self.towers = {}
	end
}

function TowerManager:update(dt)
	for _,tower in pairs(self.towers) do
		tower:update(dt)
	end
end

function TowerManager:draw()
	for _,tower in pairs(self.towers) do
		tower:draw()
	end
end

function TowerManager:reset()
	self.towers = {}
end

function TowerManager:addTower(x, y, name)
	local tower = nil
	if name == 'knife' then
		tower = TowerKnife(x, y)
	end
	
	if tower ~= nil then
		table.insert(self.towers, tower)
	end
end


