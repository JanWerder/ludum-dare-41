require "objects/creeps/creep"
require "objects/creeps/creepBasic"
require "objects/creeps/creepTomato"

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
		
	table.insert(self.creeps, creep)
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