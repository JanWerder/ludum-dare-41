Tower = Class{
	init = function(self, x, y)
		self.x = x
		self.y = y
		self.worldX, self.worldY = utils:convertTileToPosition(x, y)
		self.range = nil
		self.damage = nil
		self.shootCount = nil -- x Schüsse pro Minute
		self.name = nil
		self.image = nil
		self.imageShoot = nil
		self.animationShoot = nil
		self.animationShootFrames = 0
		self.imageShootLength = nil
		self.cooldownTimer = 0		
		self.projectiles = {}
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
function Tower:setRange(range)
	self.range = range
end

function Tower:setDamage(damage)
	self.damage = damage
end

function Tower:setShootCount(shootCount)
	self.shootCount = shootCount
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
		local creeps = game.creepsManager:getCreepsInRange(self.worldX, self.worldY, self.range)
		if creeps and creeps ~= {} and creeps[1] then
			-- Ziele in der Nähe gefunden
			self:shoot(creeps)
			self.cooldownTimer = 0
			self.animationShoot:resume()
		end
	end
	self.animationShoot:update(dt)
	for i,projectile in pairs(self.projectiles) do
		projectile:update(dt)
		if projectile.hasHit then			
			table.remove(self.projectiles, i)
		end
	end
end

function Tower:draw()
	if self.animationShoot.status ~= "paused" then
		self.animationShoot:draw(self.imageShoot, self.worldX, self.worldY)
	else
		love.graphics.draw(self.image, self.worldX, self.worldY)
	end

	for _,projectile in pairs(self.projectiles) do
		projectile:draw()
	end
end

function Tower:drawRange()
	love.graphics.push("all")
		love.graphics.setColor(50,255,50,50)
		love.graphics.circle("fill", self.worldX, self.worldY, self.range)
	love.graphics.pop()
end




















