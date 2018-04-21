Creep = Class{
	init = function(self, x, y)
		self.x = x
		self.y = y
		self.life = nil
		self.speed = nil
		self.name = nil
		self.image = nil
	end
}

-- GETTER --
function Creep:getPositionX()
	return self.x
end

function Creep:getPositionY()
	return self.y
end

function Creep:getLife()
	return self.life
end

function Creep:getSpeed()
	return self.speed
end

function Creep:getName()
	return self.name
end

function Creep:getImage()
	return self.image
end



-- SETTER --
function Creep:setPositionX(x)
	self.x = x
end

function Creep:setPositionY(y)
	self.y = y
end

function Creep:setLife(life)
	self.life = life
end

function Creep:setSpeed(speed)
	self.speed = speed
end

function Creep:setName(name)
	self.name = name
end

function Creep:setImage(image)
	self.image = image
end


-- GENERAL --
function Creep:update(dt)
	
end

function Creep:draw()
	love.graphics.circle("fill", self:getPositionX(), self:getPositionY(), 5, 20)
end
