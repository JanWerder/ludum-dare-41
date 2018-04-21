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
		self.knifeX, self.knifeY = nil
		self.knifeSpeed = 50
		self.target = nil
	end,
	menuImage = love.graphics.newImage("img/Knifestand-stillx64.png"),
	imageStill = love.graphics.newImage("img/Knifestand-still.png")
}	

function TowerKnife:shoot(creeps)
	self.target = creeps[1]
end

function Tower:update(dt)
	Tower.update(self, dt)
	local knifeVector
	if self.target ~= nil then
		-- new knife
		if self.knifeX == nil or self.knifeY == nil then
			self.knifeX = self.worldX
			self.knifeY = self.worldY
		end
		
		-- calc flight
		knifeVector = Vector.new(self.target.x - self.knifeX, self.target.y - self.knifeY)
		
		
		-- hit!
		if self.knifeX == self.target.x and self.knifeY == self.target.y then
			self.target:decreaseLife(self.damage)
			self.knifeX , self.knifeY, self.target = nil
		end
	end
end

function TowerKnife:draw()
	Tower.draw(self)
	
	if self.target ~= nil then
	
	end
end