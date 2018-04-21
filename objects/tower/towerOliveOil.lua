TowerOliveOil = Class{
	__includes = Tower;
	
	init = function(self, x, y)
		Tower.init(self, x, y)
		
		--- Tower Customizing --- 
		-- damage Var's
		self:setRange(275)
		self:setDamage(0.5)
		self:setShootCount(30)
		
		-- general stuff
		self:setName('Oliveoil')
		self:setImage(love.graphics.newImage("img/oliveoil_still.png"))
		self:setImageShootLength(4)
		self:setImageShoot(love.graphics.newImage("img/oliveoil.png"))
		
		self.oliveDrop = love.graphics.newImage("img/oliveoil_drop.png")
		self.dropSpeed = 300
	end
}	

function TowerOliveOil:shoot(creeps)
	if creeps[1] then		
		table.insert(self.projectiles, Projectile( self.worldX, self.worldY, self.oliveDrop, self.dropSpeed, creeps[1], self.damage, self.name))
	end
end

