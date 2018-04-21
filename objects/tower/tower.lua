Tower = Class{
	init = function(self, x, y)
		self.x = x
		self.y = y
		self.range = nil
		self.damage = nil
		self.shootCount = nil -- x Schüsse pro Minute
		self.shootLength = nil
		self.name = nil
		self.image = nil
		self.imageShoot = nil
		self.animationShoot = nil
		self.animationShootFrames = 0
		self.imageShootLength = nil
		self.cooldownTimer = 0
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

function Tower:setRange(range)
	self.range = range
end

function Tower:setDamage(damage)
	self.damage = damage
end

function Tower:setShootCount(shootCount)
	self.shootCount = shootCount
end

function Tower:setShootLength(shootLength)
	self.shootLength = shootLength
end

function Tower:setName(name)
	self.name = name
end

function Tower:setImage(image)
	self.image = image
end

function Tower:setImageShoot(imageShoot)
	self.imageShoot = imageShoot
	self.aniGrid = Anim8.newGrid(32, 32, imageShoot:getWidth(), imageShoot:getHeight())
	self.animationShoot = Anim8.newAnimation(self.aniGrid('1-'.. self.imageShootLength,1), 0.2, 'pauseAtStart')
end

function Tower:setImageShootLength(imageShootLength)
	self.imageShootLength = imageShootLength
end

-- Tower Functions
function Tower:update(dt)
	self.cooldownTimer = self.cooldownTimer + dt
	if self.cooldownTimer > 60 / self.shootCount then
		-- Turm ist bereit zum schießen
		creeps = game.creepsManager:getCreepsInRange(self.x, self.y, self.range)
		if creeps ~= nil then
			-- Ziele in der Nähe gefunden
			self:shoot(creeps)
			self.cooldownTimer = 0
			self.animationShoot:resume()
		end
	end
	self.animationShoot:update(dt)
end

function Tower:draw()
	if self.animationShoot.status ~= "paused" then
		self.animationShoot:draw(self.imageShoot, self.x, self.y)
	else
		love.graphics.draw(self.image, self.x, self.y)
	end
end

function Tower:shoot(creeps)
	print('schuss!')
	
end





















