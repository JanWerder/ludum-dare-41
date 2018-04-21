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
	end
}	

function TowerKnife:shoot(creeps)
	creeps[1]:decreaseLife(self.damage)
end