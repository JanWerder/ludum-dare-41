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
		
		self.knife = love.graphics.newImage("img/knifestand-Sheet.png")
		self.target = nil
	end
}	

function TowerKnife:shoot(creeps)
	self.target = creeps[1]
	self.target:decreaseLife(self.damage)
end

function Tower:update(dt)
	Tower:update(dt)
	
end

function TowerKnife:draw()
	Tower:draw()
	
	if
	
end