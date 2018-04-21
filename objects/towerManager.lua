require "objects/tower/tower"
require "objects/tower/towerKnife"
require "objects/tower/towerOliveOil"
require "objects/tower/towerCatapult"
require "objects/tower/towerSalt"
require "objects/projectile"

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
	if name == 'oliveOil' then
		tower = TowerOliveOil(x, y)
	end
	if name == 'catapult' then
		tower = TowerCatapult(x, y)
	end
	if name == 'salt' then
		tower = TowerSalt(x, y)
	end

	if tower ~= nil then
		table.insert(self.towers, tower)
	end
end

function TowerManager:getTowerAtTile(tileX, tileY)
	for _,tower in pairs(self.towers) do
		if tower.x == tileX and tower.y == tileY then
			return tower
		end
	end
	return nil
end