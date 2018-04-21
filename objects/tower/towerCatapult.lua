TowerCatapult = Class{
	__includes = Tower;
	
	init = function(self, x, y)
		Tower.init(self, x, y)
		
		--- Tower Customizing --- 
		-- damage Var's
		self:setRange(TowerCatapult.range)
		self:setDamage(2)
		self:setShootCount(15)
		
		-- general stuff
		self:setName('Catapult')
		self:setImage(love.graphics.newImage("img/catapult_still.png"))
		self:setImageShootLength(3)
		self:setImageShoot(love.graphics.newImage("img/catapult.png"))
		
		self.oliveDrop = love.graphics.newImage("img/oliveoil_drop.png")
		self.dropSpeed = 300
	end,
	menuImage = love.graphics.newImage("img/catapult_stillx64.png"),
	imageStill = love.graphics.newImage("img/catapult_still.png"),
	range = 325
}	

function TowerCatapult:shoot(creeps)
	if creeps[1] then		
		table.insert(self.projectiles, Projectile( self.worldX, self.worldY, self.oliveDrop, self.dropSpeed, creeps[1], self.damage, self.name))
	end
end

