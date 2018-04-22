TowerSalt = Class{
	__includes = Tower;
	
	init = function(self, x, y)
		Tower.init(self, x, y)
		
		--- Tower Customizing --- 
		-- damage Var's
		self:setRange(TowerSalt.range)
		self:setDamage(0.5)
		self:setShootCount(30)
		
		-- general stuff
		self:setName('salt')
		self:setImage(love.graphics.newImage("img/salt_still.png"))
		self:setImageShootLength(2)
		self:setImageShoot(love.graphics.newImage("img/salt.png"))
		
		--self.oliveDrop = love.graphics.newImage("img/oliveoil_drop.png")
		self.dropSpeed = 30		
	end,
	menuImage = love.graphics.newImage("img/salt_stillx64.png"),
	imageStill = love.graphics.newImage("img/salt_still.png"),
	shootsound = love.audio.newSource("sound/salt-shaker.mp3", "static"),
	price = 30,
	range = 100
}	

function TowerSalt:shoot(creeps)
	for _,creep in pairs(creeps) do
		table.insert(self.projectiles, Projectile( self.worldX, self.worldY, self.oliveDrop, self.dropSpeed, creep, self.damage, self.name))
		self.shootsound:play()
	end	
end

function TowerSalt:update(dt)
	Tower.update(self, dt)
end

function TowerSalt:draw()
	Tower.draw(self)
end
