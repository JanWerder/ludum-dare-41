require "objects/creeps/creeps"
require "objects/creeps/creepsBasic"

CreepsManager = Class{
	init = function(self)
		self.creeps = {}
	end
}
function CreepsManager:addCreep(x, y, name)
    local creep = nil
	if name == 'basic' then
	    creep = CreepsBasic(x, y)
	end
		
	table.insert(self.creeps, creep)
end
