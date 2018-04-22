SpawnBox = Class{
	init = function(self, x, y, pathIndex)
        self.position = {x = x, y = y}
		self.tilePosition = {}
		self.tilePosition.x, self.tilePosition.y = utils:convertTileToPosition(x, y)
        self.pathIndex = pathIndex
        self.spawns = {}
        self.timer = 0
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
                gameState.creepsManager:addCreep(self.tilePosition.x, self.tilePosition.y, self.spawns[1].type, self.pathIndex)
            end
            table.remove(self.spawns, 1)
        end
    end
end

function SpawnBox:draw()
    if not self.defenseMode then
		love.graphics.push("all")
		love.graphics.setColor(70,70,70,200)
		love.graphics.rectangle("fill", self.tilePosition.x, self.tilePosition.y-16, 64, 64)
		love.graphics.pop()
    end
end