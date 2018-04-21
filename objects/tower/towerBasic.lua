TowerBasic = Class{
	__includes = Tower;
	
	init = function(self, x, y)
		Tower.init(self, x, y)
		
		--- Tower Customizing --- 
		-- damage Var's
		self:setRange(1)
		self:setDamage(1)
		self:setShootCount(60)
		
		-- general stuff
		self:setName('Basic')
		self:setImage(love.graphics.newImage("img/tomato.png"))
		self:setImageShoot(love.graphics.newImage("img/tomato.png"))
		self:setImageShootLength(2)
	end
}	

