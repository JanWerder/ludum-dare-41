Projectile = Class{
	init = function(self, x, y, image, speed, target, damage, originName)
		self.position = {x = x, y = y}
		self.image = image
		self.speed = speed
		self.target = target
		self.damage = damage
		self.hasHit = false
		self.originName = originName
	end
}

function Projectile:update(dt)	
	local offset = 5
	if self.position.x > self.target.x - offset and self.position.x < self.target.x + offset
	and self.position.y > self.target.y - offset and self.position.y < self.target.y + offset then
		-- hit!		
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
end

function Projectile:draw()	
	love.graphics.draw(self.image, self.position.x, self.position.y)
end