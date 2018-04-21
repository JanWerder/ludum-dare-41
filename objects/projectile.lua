Projectile = Class{
	init = function(self, x, y, image, speed, target, damage)
		self.position = {x = x, y = y}
		self.image = image
		self.speed = speed
		self.target = target
		self.damage = damage
		self.hasHit = false
	end
}

function Projectile:update(dt)	
	local offset = 5
	if self.position.x > self.target.x - offset and self.position.x < self.target.x + offset
	and self.position.y > self.target.y - offset and self.position.y < self.target.y + offset then
		-- hit!
		self.target:decreaseLife(self.damage)
		self.hasHit = true		
	else
		-- calc flight
		local knifeVector = Vector.new(self.target.x - self.position.x, self.target.y - self.position.y)
		knifeVector:normalizeInplace()
		self.position = self.position + knifeVector * self.speed * dt
	end
end

function Projectile:draw()	
	love.graphics.draw(self.image, self.position.x, self.position.y)
end