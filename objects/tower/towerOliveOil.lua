TowerOliveOil = Class{
	__includes = Tower;
	
	init = function(self, x, y)
		Tower.init(self, x, y)
		
		--- Tower Customizing --- 
		-- damage Var's
		self:setRange(TowerOliveOil.range)
		self:setDamage(0.2)
		self:setShootCount(40)
		
		-- general stuff
		self:setName('Oliveoil')
		self:setImage(love.graphics.newImage("img/oliveoil_still.png"))
		self:setImageShootLength(4)
		self:setImageShoot(love.graphics.newImage("img/oliveoil.png"))
		
		self.oliveDrop = love.graphics.newImage("img/oliveoil_drop.png")
		self.dropSpeed = 150
	end,
	menuImage = love.graphics.newImage("img/oliveoil_stillx64.png"),
	imageStill = love.graphics.newImage("img/oliveoil_still.png"),
	shootsound = love.audio.newSource("sound/olive-oil.mp3", "static"),
	price = 30,
	range = 50
}	

function TowerOliveOil:shoot(creeps)
	if creeps[1] then		
		table.insert(self.projectiles, Projectile( self.worldX, self.worldY, self.oliveDrop, self.dropSpeed, creeps[1], self.damage, self.name))
		self.shootsound:play()
	end	
end

