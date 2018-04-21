Tower = Class{
	init = function(self, x, y)
		self.x = x
		self.y = y
		self.range = nil
		self.damage = nil
		self.shootCount = nil
		self.name = nil
		self.image = nil
	end
}

-- GETTER --
function Tower:getPositionX()
	return self.x
end

function Tower:getPositionY()
	return self.y
end

function Tower:getRange()
	return self.range
end

function Tower:getDamage()
	return self.damage
end

function Tower:getShootCount()
	return self.shootCount
end

function Tower:getName()
	return self.name
end

function Tower:getImage()
	return self.image
end

	
-- SETTER --
function Tower:setPositionX(x)
	self.x = x
end

function Tower:setPositionY(y)
	self.y = y
end

function Tower:setRange()
	self.range = range
end

function Tower:setDamage()
	self.damage = damage
end

function Tower:setShootCount()
	self.shootCount = shootCount
end

function Tower:setName()
	self.name = name
end

function Tower:setImage()
	self.image = image
end

-- Tower Functions
function Tower:draw()
	
end

function Tower:shoot()
	creeps = CreepManager:getCreeps(self.x, self.y, self.range)

end





















