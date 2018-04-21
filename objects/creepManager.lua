require "objects/creeps/creep"
require "objects/creeps/creepTomato"
require "objects/creeps/creepEggplant"
require "objects/creeps/creepCarrot"

CreepManager = Class{
	init = function(self)
		self.creeps = {}
	end
}

function CreepManager:addCreep(x, y, name)
    local creep = nil
	if name == 'basic' then
	    creep = CreepBasic(x, y)
	end

	if name == 'tomato' then
	    creep = CreepTomato(x, y)
	end

	if name == 'carrot' then
	    creep = CreepCarrot(x, y)
	end

	if name == 'eggplant' then
	    creep = CreepEggplant(x, y)
	end
		
	table.insert(self.creeps, creep)
end

function CreepManager:getCreepsInRange(x,y,range)
	--TODO
	return {}
end

function CreepManager:startWave(wave)

end

function CreepManager:update(dt)
	for _,creep in pairs(self.creeps) do
		creep:update(dt)
	end
end

function CreepManager:draw()
	for _,creep in pairs(self.creeps) do
		creep:draw()
	end
end