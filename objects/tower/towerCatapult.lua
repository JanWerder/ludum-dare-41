TowerCatapult = Class{
	__includes = Tower;
	
	init = function(self, x, y)
		Tower.init(self, x, y)
		
		--- Tower Customizing --- 
		-- damage Var's
		self:setRange(TowerCatapult.range)
		self:setDamage(0.8)
		self:setShootCount(25)
		
		-- general stuff
		self:setName('Catapult')
		self:setImage(love.graphics.newImage("img/catapult_still.png"))
		self:setImageShootLength(3)
		self:setImageShoot(love.graphics.newImage("img/catapult.png"))
		
		self.oliveDrop = love.graphics.newImage("img/walnut.png")
		self.dropSpeed = 150
	end,
	menuImage = love.graphics.newImage("img/catapult_stillx64.png"),
	imageStill = love.graphics.newImage("img/catapult_still.png"),
	shootsound = love.audio.newSource("sound/catapult.mp3", "static"),
	price = 25,
	range = 150
}	

function TowerCatapult:shoot(creeps)
	if creeps[1] then		
		table.insert(self.projectiles, Projectile( self.worldX, self.worldY, self.oliveDrop, self.dropSpeed, creeps[1], self.damage, self.name))
		self.shootsound:play()
	end	
end

