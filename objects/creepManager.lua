require "objects/creeps/creep"
require "objects/creeps/creepTomato"
require "objects/creeps/creepEggplant"
require "objects/creeps/creepCarrot"

CreepManager = Class{
	init = function(self)
		self.creeps = {}
		self.deadCreeps = {}
		self.singleCreepDelay = 3
		self.singleCreepTime = 0
		self.waveIndexTime = 10
		self.waveIndex = nil
		self.waveTime = nil
		self.waveConfig = nil
		self.creepsToSpawn = {}
	end
}

function CreepManager:addCreep(x, y, name)
    local creep = nil

	if name == 'tomato' then
	    creep = CreepTomato(x, y)
	end

	if name == 'carrot' then
	    creep = CreepCarrot(x, y)
	end

	if name == 'eggplant' then
	    creep = CreepEggplant(x, y)
	end
		
	if creep then
		table.insert(self.creeps, creep)
	end
end

function CreepManager:getCreepsInRange(towerX,towerY,range)--world coordinates
	local foundCreeps = {}

	for _,creep in pairs(self.creeps) do
		if mlib.circle.checkPoint(creep.x+creep.width/2, creep.y+creep.height/2, towerX+16, towerY+16, range) and creep.life > 0 then
			table.insert(foundCreeps, creep)
		end
	end
	
	return foundCreeps
end

function CreepManager:startWave(wave)
	self.waveIndex = 0
	self.waveTime = self.waveIndexTime
	self.waveConfig = wave
	self.singleCreepTime = self.singleCreepDelay
	self.waveIndexTime = 10
end

function CreepManager:removeCreep(creep)
	table.remove(self.creeps, creep)
end

function CreepManager:update(dt)
	for k,creep in pairs(self.creeps) do
		creep:update(dt, k)
		if creep.life == 0 then
			game.money = game.money + creep:getHeadMoney()
			creep:setDead()
			table.insert(self.deadCreeps, creep) --TODO
			table.remove(self.creeps, k)
		end
	end

	if self.waveConfig then
		self.waveTime = self.waveTime+dt
		if self.waveTime > self.waveIndexTime then
			self.waveTime = 0
			self.waveIndex = self.waveIndex+1
			if self.waveConfig[self.waveIndex] then
				self.waveIndexTime = self.waveConfig[self.waveIndex][3]
				for i=1, self.waveConfig[self.waveIndex][1] do
					table.insert(self.creepsToSpawn, self.waveConfig[self.waveIndex][2])
				end
			else
				self.waveConfig = nil
			end
		end
	end

	if self.creepsToSpawn and self.creepsToSpawn ~= {} then
		self.singleCreepTime = self.singleCreepTime+dt
		if self.singleCreepTime > self.singleCreepDelay then
			self.singleCreepTime = 0
			local posx, posy = utils:convertTileToPosition(game.path[1].x,game.path[1].y)
			game.creepsManager:addCreep(posx, posy, self.creepsToSpawn[1])
			table.remove(self.creepsToSpawn,1)
		end
	end
end

function CreepManager:draw()
	for _,deadCreep in pairs(self.deadCreeps) do
		deadCreep:draw()
	end
	for _,creep in pairs(self.creeps) do
		creep:draw()
	end
end