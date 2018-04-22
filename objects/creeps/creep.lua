Creep = Class{
	init = function(self, x, y)
		self.x = x
		self.y = y
		self.width = nil
		self.height = nil
		self.life = nil
		self.speed = nil
		self.name = nil
		self.image = nil
		self.nextStep = 2
		self.speedMultiplier = 1
		self.headMoney = nil
		self.isDead = false
		self.pathIndex = nil
	end
}

-- GETTER --
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

function Creep:getWidth()
	return self.width
end

function Creep:getHeight()
	return self.height
end

function Creep:getHeadMoney()
	return self.headMoney
end

-- SETTER --
function Creep:setWidth(width)
	self.width = width
end

function Creep:setHeight(height)
	self.height = height
end


function Creep:setLife(life)
	self.life = life
	self.maxLife = life
end

function Creep:setSpeed(speed)
	self.speed = speed
end

function Creep:setName(name)
	self.name = name
end

function Creep:setImage(image)
	self.image = image
	if self.life > 0 then
		self.aniGrid = Anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
		self.animation = Anim8.newAnimation(self.aniGrid('1-4',1), 0.1)
	else
		self.isDead = true
		self.angle = math.pi / 180 * love.math.random(0,360)
	end
end

function Creep:attack(index)
	game.creepsManager:removeCreep(index)
	game.lifePoints =game.lifePoints -1
end

function Creep:setHeadMoney(headMoney)
	self.headMoney = headMoney
end

function Creep:setPathIndex(pathIndex)
	self.pathIndex = pathIndex
end
-- GENERAL --
function Creep:update(dt, index)
	local offset = 3
	local speed = self:getSpeed()

	local nextTileX, nextTileY = utils:convertTileToPosition(game.paths[self.pathIndex][self.nextStep].x, game.paths[self.pathIndex][self.nextStep].y)

	if self.x > nextTileX - offset and self.x < nextTileX + offset
	and self.y > nextTileY - offset and self.y < nextTileY + offset then
		self.nextStep = self.nextStep + 1
		if self.nextStep > utils:tableLength(game.paths[self.pathIndex]) then
			self:attack(index)
		end
	else
		if self.x <= nextTileX then
			self.x = self.x  + speed * self.speedMultiplier * dt
		end

		if self.x > nextTileX then
			self.x = self.x  - speed * self.speedMultiplier * dt
		end

		if self.y <= nextTileY then
			self.y = self.y  + speed * self.speedMultiplier * dt
		end

		if self.y > nextTileY then
			self.y = self.y  - speed * self.speedMultiplier * dt
		end
	end

	self.animation:update(dt)
end

function Creep:draw()
	if self.isDead then
		love.graphics.draw(self.image, self.x, self.y, self.angle, 1, 1, 16, 16)
	else
		love.graphics.rectangle("line", self.x+5, self.y-10, self.width-10, 6)
		love.graphics.push("all")
		love.graphics.setColor(255, 50,50)
		love.graphics.rectangle("fill", self.x+6, self.y-9, (self.width-11)*(self.life/self.maxLife),5) -- Lifebar
		love.graphics.pop()
		self.animation:draw(self.image, self.x, self.y)
	end
end

function Creep:decreaseLife(damage)
	self.life = self.life - damage
	if self.life <= 0 then
		self.life = 0
	end
end

function Creep:setSpeedMultiplier(multiplier)
	self.speedMultiplier = multiplier

	Timer.during(3, function() self.speedMultiplier = multiplier end)
	Timer.after(3, function() self.speedMultiplier = 1 end)	
end
