require "objects/creeps/creep"
require "objects/creeps/creepBasic"

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