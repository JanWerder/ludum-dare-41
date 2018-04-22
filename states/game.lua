function game:enter()
    love.physics.setMeter(32)

    map = sti("maps/defense.lua")
    game.imgHeart = love.graphics.newImage("img/celeriac.png")

    game.paths = {}

    local originDirection = {-1,0}
    local currentField = {}
    for y=1,12 do
        local props = map:getTileProperties("grid", 1, y)
        if props.path then
            local calcPath = {}

            table.insert(calcPath, { x = 1, y = y })
            currentField = { x = 1, y = y }
            
            
            calcPath = utils:createPath(originDirection, currentField, calcPath)
            table.insert(game.paths, calcPath)
        end
    end    

    game.mapSize = {x = 640, y = 384}
    game.creepsManager = CreepManager()
    game.towerManager = TowerManager()
    
    game.lifePoints = 3
    game.money = 50
    game.stage = 1
    game.wave = 1
    game.creepsManager:startWave(game.stages[game.stage][game.wave])
    game.buttonStates = {}
    game.buildMode = nil
    game.moneyBackground = love.graphics.newImage("img/money_bg.png")
    game.music = love.audio.newSource("sound/template_soundtrack.mp3")
    game.music:setVolume(0.2)
    game.music:play()
end

function game:leave()
    game.music:stop()
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
        love.graphics.draw(game.imgHeart, 10 + 15*i)
    end

    if game.buildMode and love.mouse.getX() < game.mapSize.x and love.mouse.getY() < game.mapSize.y then
        love.graphics.push("all")
            if not game.buildMode.buildAllowed then
                love.graphics.setColor(255,0,0)
            end
            love.graphics.draw(game.buildMode.image,game.buildMode.posX, game.buildMode.posY)
            love.graphics.setColor(50,255,50,50)
            love.graphics.circle("fill", game.buildMode.posX+16, game.buildMode.posY+16, game.buildMode.range)
        love.graphics.pop()
    end

    local mouseX, mouseY = love.mouse.getPosition()
    
    for _,tower in pairs(game.towerManager.towers) do
        local hoverRange = { tower.worldX, tower.worldY, 
        tower.worldX+tower.image:getWidth(), tower.worldY, 
        tower.worldX+tower.image:getWidth(), tower.worldY+tower.image:getHeight(),
        tower.worldX, tower.worldY+tower.image:getHeight()
        }

        if mlib.polygon.checkPoint(mouseX, mouseY, hoverRange) then
            tower:drawRange()
        end
    end
    game:towerMenu()
    suit.draw()
end

function game:towerMenu()
    suit.layout:reset(640,6)
    love.graphics.draw(game.moneyBackground,640, 0)
    local colorBlack = {normal = {bg = {0,0,0}, fg = {0,0,0}}}
    local bgRed, bgGreen, bgBlue = 115,102,102
    suit.Label("Basil: " .. game.money, {align = "center", color=colorBlack}, suit.layout:row(64,8))
    game.buttonStates = {}
    suit.layout:row(64,8)

    love.graphics.push("all")
    if TowerKnife.price > game.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(game.buttonStates,{"knife", suit.ImageButton(TowerKnife.menuImage,{}, suit.layout:row(64,44)), TowerKnife})
    suit.Label(TowerKnife.price .. " Basil", {align = "center"}, suit.layout:row(64,18))
    suit.layout:row(64,4)
    love.graphics.pop()


    love.graphics.push("all")
    if TowerCatapult.price > game.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(game.buttonStates,{"catapult", suit.ImageButton(TowerCatapult.menuImage,{}, suit.layout:row(64,40)), TowerCatapult})
    suit.Label(TowerCatapult.price .. " Basil", {align = "center"}, suit.layout:row(64,16))
    love.graphics.pop()

    love.graphics.push("all")
    if TowerOliveOil.price > game.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(game.buttonStates,{"oliveOil", suit.ImageButton(TowerOliveOil.menuImage,{}, suit.layout:row(64,64)), TowerOliveOil})
    suit.Label(TowerOliveOil.price .. " Basil", {align = "center"}, suit.layout:row(64,8))
    suit.layout:row(64,8)
    love.graphics.pop()

    love.graphics.push("all")
    if TowerSalt.price > game.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(game.buttonStates,{"salt", suit.ImageButton(TowerSalt.menuImage,{}, suit.layout:row(64,64)), TowerSalt})
    suit.Label(TowerSalt.price .. " Basil", {align = "center"}, suit.layout:row(64,14))
    love.graphics.pop()
end


function game:mousereleased(mx,my,button)
    if button == 1 then
        for k,v in pairs(game.buttonStates) do
            if game.buttonStates[k][2].hovered and game.money >= game.buttonStates[k][3].price then
                game.buildMode = {towerName = game.buttonStates[k][1], image = game.buttonStates[k][3].imageStill, range = game.buttonStates[k][3].range}
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