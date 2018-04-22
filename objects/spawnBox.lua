SpawnBox = Class{
	init = function(self, x, y, pathIndex)
        self.tilePosition = {x = x, y = y}
		self.position = {}
		self.position.x, self.position.y = utils:convertTileToPosition(x, y)
        self.pathIndex = pathIndex
        self.spawns = {}
        self.timer = 0
		self.polygon = {self.position.x, self.position.y-16, self.position.x+64, self.position.y-16, self.position.x+64, self.position.y+48, self.position.x, self.position.y+48}
        self.stageStarted = false
        self.defenseMode = false
    end
}

function SpawnBox:isStageStarted()
	return self.stageStarted
end

function SpawnBox:startStage()
    self.stageStarted = true
end

function SpawnBox:addSpawn(type, delay)
    table.insert(self.spawns, {type = type, delay = delay})
end

function SpawnBox:removeSpawn(index)
    table.remove(self.spawns, index)
end

function SpawnBox:isPointInBox(x,y)
	if mlib.polygon.checkPoint(x, y, self.polygon) then
		return true
	else
		return false
	end
end

function SpawnBox:readSpawnConfig(stage, wave)
    self.defenseMode = true
    stages = require 'objects.stages'

    for _,spawn in pairs(stages[stage][wave]) do
        local i = 1
        repeat
            self:addSpawn(spawn[2], spawn[3]) --spawn[3] - type --spawn[3]- delay
            i=i+1
        until i > spawn[1] -- amount
    end
    self:startStage()
end

function SpawnBox:update(dt, gameState)	
    if self:isStageStarted() and utils:tableLength(self.spawns) > 0 and self.spawns ~= {} and self.spawns ~= nil then
        self.timer = self.timer + dt
        if self.timer >= self.spawns[1].delay then
            self.timer = self.timer - self.spawns[1].delay
            if self.spawns[1].type ~= "pause" then
                gameState.creepsManager:addCreep(self.position.x, self.position.y, self.spawns[1].type, self.pathIndex)
            end
            table.remove(self.spawns, 1)
        end
    end
end

function SpawnBox:draw()
    if not self.defenseMode then
		love.graphics.push("all")
		love.graphics.setColor(70,70,70,200)
		love.graphics.polygon("fill", self.polygon)
		love.graphics.pop()
		
		local boxPosition = {x = 0, y = 0}
		for i,spawn in pairs(self.spawns) do
			boxPosition.x = 16 * ((i - 1) % 4)
			print('x:'..boxPosition.x )
			boxPosition.y = 16 * (math.floor((i-1) / 4) - 1)
			print('y:'..boxPosition.y )
			
		
			if spawn.type == 'tomato' then
				love.graphics.draw(CreepTomato.imageStill, boxPosition.x+self.position.x, boxPosition.y+self.position.y, 0, 0.5,0.5)
			end
			if spawn.type == 'carrot' then
				love.graphics.draw(CreepCarrot.imageStill, boxPosition.x+self.position.x, boxPosition.y+self.position.y, 0, 0.5,0.5)
			end
			if spawn.type == 'eggplant' then
				love.graphics.draw(CreepEggplant.imageStill, boxPosition.x+self.position.x, boxPosition.y+self.position.y, 0, 0.5,0.5)
			end
			if spawn.type == 'pause' then
			
			end		
		end
    end
end