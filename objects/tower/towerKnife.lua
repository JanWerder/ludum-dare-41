TowerKnife = Class{
	__includes = Tower;
	
	init = function(self, x, y)
		Tower.init(self, x, y)
		
		--- Tower Customizing --- 
		-- damage Var's
		self:setRange(250)
		self:setDamage(1)
		self:setShootCount(10)
		
		-- general stuff
		self:setName('Basic')
		self:setImage(love.graphics.newImage("img/Knifestand-still.png"))
		self:setImageShootLength(3)
		self:setImageShoot(love.graphics.newImage("img/knifestand-Sheet.png"))
		
		self.knife = love.graphics.newImage("img/knife_projectile.png")
		self.knifeSpeed = 300
	end
}	

function TowerKnife:shoot(creeps)
	table.insert(self.projectiles, Projectile( self.worldX, self.worldY, self.knife, self.knifeSpeed, creeps[1], self.damage))
end

