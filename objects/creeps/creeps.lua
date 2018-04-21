Creeps = Class{
	init = function(self, x, y)
		self.x = x
		self.y = y
		self.live = nil
		self.speed = nil
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
	
	getLive = function(self)
		return self.live
	end;
	
	getSpeed = function(self)
		return self.speed
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
	
	setLive = function(self, live)
		self.live = live
	end;
	
	setSpeed = function(self, speed)
		self.speed = speed
	end;
	
	setName = function(self, name)
		self.name = name
	end;
	
	setImage = function(self, image)
		self.image = image
	end;

}