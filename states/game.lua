function game:enter()
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

    game.mapSize = {x = 640, y = 384}
    game.creepsManager = CreepManager()
	game.towerManager = TowerManager()
    local posx, posy = utils:convertTileToPosition(game.path[1].x,game.path[1].y)
    
    game.money = 120
    
    game.towerManager:addTower(2, 3, "knife")
    game.towerManager:addTower(2, 4, "oliveOil")
    game.towerManager:addTower(2, 5, "catapult")
    game.towerManager:addTower(2, 6, "salt")

    game.lifePoints = 3
    game.stage = 1
    game.wave = 1
    game.creepsManager:startWave(game.stages[game.stage][game.wave])
    game.buttonStates = {}
    game.buildMode = nil
end

function game:update(dt)
    if game.lifePoints < 1 then
        Gamestate.switch(gameOver)
    end

    lovebird.update()
    map:update(dt)

    game.creepsManager:update(dt)
    game.towerManager:update(dt)

    if game.buildMode then
        local x = love.mouse.getX()
        local y = love.mouse.getY()
        game.buildMode.buildAllowed = false
        if x < game.mapSize.x and y < game.mapSize.y then
            game.buildMode.tileX, game.buildMode.tileY = utils:convertPositionToTile(x, y)
            game.buildMode.posX, game.buildMode.posY = utils:convertTileToPosition(game.buildMode.tileX, game.buildMode.tileY)
            local props = map:getTileProperties("grid", game.buildMode.tileX , game.buildMode.tileY)
            if not props.path and not game.towerManager:getTowerAtTile(game.buildMode.tileX, game.buildMode.tileY) then
                game.buildMode.buildAllowed = true
            end
        end
    end
    Timer.update(dt)
end

function game:draw()
    map:draw()
    game.creepsManager:draw()
    game.towerManager:draw()

    for i=1,game.lifePoints do
        love.graphics.circle("fill", 10 + 15*i, 10, 5)
    end
    suit.draw()

    if game.buildMode and love.mouse.getX() < game.mapSize.x and love.mouse.getY() < game.mapSize.y then
        love.graphics.draw(game.buildMode.image,game.buildMode.posX, game.buildMode.posY)
    end

    game:towerMenu()
end

function game:towerMenu()
    suit.layout:reset(640,7)
    suit.Label("Basil: " .. game.money, {align = "center"}, suit.layout:row(64,5))
    game.buttonStates = {}
    table.insert(game.buttonStates,{"knife", suit.ImageButton(TowerKnife.menuImage,{}, suit.layout:row(64,64)), TowerKnife})
    table.insert(game.buttonStates,{"catapult", suit.ImageButton(TowerCatapult.menuImage,{}, suit.layout:row()), TowerCatapult})
    table.insert(game.buttonStates,{"oliveOil", suit.ImageButton(TowerOliveOil.menuImage,{}, suit.layout:row()), TowerOliveOil})
    table.insert(game.buttonStates,{"salt", suit.ImageButton(TowerSalt.menuImage,{}, suit.layout:row()), TowerSalt})
end


function game:mousereleased(mx,my,button)
    if button == 1 then
        for k,v in pairs(game.buttonStates) do
            if game.buttonStates[k][2].hovered and game.money >= game.buttonStates[k][3].price then
                game.buildMode = {towerName = game.buttonStates[k][1], image = game.buttonStates[k][3].imageStill}
                break
            end
        end
        if game.buildMode and game.buildMode.buildAllowed then
            game.towerManager:addTower(game.buildMode.tileX, game.buildMode.tileY, game.buildMode.towerName)
            game.buildMode = nil
        end
    elseif button == 2 then
        game.buildMode = nil
    end
end