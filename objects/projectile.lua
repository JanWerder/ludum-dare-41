Projectile = Class{
	init = function(self, x, y, image, speed, target, damage, originName)
		self.position = {x = x, y = y}
		self.image = image
		self.speed = speed
		self.target = target
		self.damage = damage
		self.hasHit = false
		self.originName = originName
		self.hitsound = love.audio.newSource("sound/squish.mp3", "static")
		self.hitsound:setVolume(0.5)		

		if originName == "salt" then
			local img = love.graphics.newImage('img/salt_single.png')

			self.saltcloud = love.graphics.newParticleSystem(img, 32)
			self.saltcloud:setParticleLifetime(2, 3)
			self.saltcloud:setEmissionRate(200)
			self.saltcloud:setSizeVariation(1)
			self.saltcloud:setEmitterLifetime(1)
			self.saltcloud:setLinearAcceleration(-40, -40, 40, 40)
			self.saltcloud:setColors(255, 255, 255, 255, 255, 255, 255, 0)

			Timer.after(1, function() self.target:decreaseLife(self.damage) end)
			
		end
	end
}

function Projectile:update(dt)	
	local offset = 5
	if self.position.x > self.target.x - offset and self.position.x < self.target.x + offset
	and self.position.y > self.target.y - offset and self.position.y < self.target.y + offset then
		-- hit!		
		self.hitsound:play()
		self.target:decreaseLife(self.damage)
		self.hasHit = true
		if self.originName == "Oliveoil" then
			self.target:setSpeedMultiplier(0.5)
		end		
	else
		-- calc flight
		local flightVector = Vector.new(self.target.x - self.position.x, self.target.y - self.position.y):normalizeInplace()
		self.position = self.position + flightVector * self.speed * dt
	end

	if self.originName == "salt" then		
		Timer.after(3, function() self.hasHit = true end)	
	end

	if self.saltcloud then
		self.saltcloud:update(dt)
	end
end

function Projectile:draw()	
	if self.image then
		love.graphics.draw(self.image, self.position.x, self.position.y)
	end
	
	if self.saltcloud then
		love.graphics.draw(self.saltcloud, self.position.x+16, self.position.y+16)
	end
end