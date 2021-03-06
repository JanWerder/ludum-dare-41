require "objects/creeps/creep"
require "objects/creeps/creepTomato"
require "objects/creeps/creepEggplant"
require "objects/creeps/creepCarrot"
require "objects/creeps/creepGordon"
require "objects/creeps/creepJamie"
require "objects/creeps/creepNigella"

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

function CreepManager:addCreep(x, y, name, pathIndex)
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

	if name == 'gordon' then
	    creep = CreepGordon(x, y)
	end	

	if name == 'jamie' then
	    creep = CreepJamie(x, y)
	end	

	if name == 'nigella' then
	    creep = CreepNigella(x, y)
	end	
		
	if creep then
		creep:setPathIndex(pathIndex)
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

	table.sort(foundCreeps, function(a,b) return a.nextStep > b.nextStep end)
	
	return foundCreeps
end

function CreepManager:removeCreep(creep)
	table.remove(self.creeps, creep)
end

function CreepManager:update(dt, gameState)
	for k,creep in pairs(self.creeps) do
		creep:update(dt, gameState, k)
		if creep.life == 0 then
			gameState.money = gameState.money + creep:getHeadMoney()
			creep:setDead()
			table.insert(self.deadCreeps, creep) --TODO
			table.remove(self.creeps, k)
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