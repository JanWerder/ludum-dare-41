function game:enter()
    --Camera Module
    --camera = Camera()

    love.physics.setMeter(32)

    map = sti("maps/defense.lua")

    game.path = {}

    local originDirection = {-1,0}
    local currentField = {}
    for y=1,12 do
        local props = map:getTileProperties("grid", 1, y)
        if props.path then
            table.insert(game.path, { x = 1, y = y })
            currentField = { x = 1, y = y }
        end
    end

    utils:createPath(originDirection, currentField)

    game.creepsManager = CreepManager()
	game.towerManager = TowerManager()
    local posx, posy = utils:convertTileToPosition(game.path[1].x,game.path[1].y)
    game.creepsManager:addCreep(posx, posy, "basic")
    game.towerManager:addTower(30, 50, "knife")
    game.stage = 1
    game.wave = 1
    game.creepsManager:startWave(game.stages[game.stage][game.wave])
end

function game:update(dt)
    --Camera Module
    --camera:update(dt)
    lovebird.update()
    map:update(dt)

    game.creepsManager:update(dt)
    game.towerManager:update(dt)
end

function game:draw()
    --camera:attach()
    -- Draw your game here
    --camera:detach()
    --camera:draw()

    map:draw()
    game.creepsManager:draw()
    game.towerManager:draw()
end