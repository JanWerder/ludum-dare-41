Tower = Class{
	init = function(self, x, y)
		self.x = x
		self.y = y
		self.range = nil
		self.damage = nil
		self.shootCount = nil
		self.name = nil
		self.image = nil
	end;
	
	
	-- GETTER --
	getPositionX = function(self)
		return self.x
	end;
	
	getPositionY = function(self)
		return self.y
	end;
	
	getRange = function(self)
		return self.range
	end;
	
	getDamage = function(self)
		return self.position
	end;
	
	getShootCount = function(self)
		return self.shootCount
	end;
	
	getName = function(self)
		return self.name
	end;
	
	getImage = function(self)
		return self.image
	end;
	
	
	
	-- SETTER --
	setPositionX = function(self, x)
		self.x = x
	end;
	
	setPositionY = function(self, y)
		self.y = y
	end;
	
	setRange = function(self, range)
		self.range = range
	end;
	
	setDamage = function(self, damage)
		self.damage = damage
	end;
	
	setShootCount = function(self, shootCount)
		self.shootCount = shootCount
	end;
	
	setName = function(self, name)
		self.name = name
	end;
	
	setImage = function(self, image)
		self.image = image
	end;

}