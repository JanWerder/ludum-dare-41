function gameAttack:enter()
    love.physics.setMeter(32)

    map = sti("maps/defense.lua", "", 128, 0)
	
    gameAttack.mapSize = {x = 640, y = 384}
	tileOffset = {x = 128, y = 0}
    gameAttack.imgHeart = love.graphics.newImage("img/celeriac.png")
    gameAttack.imgBasil = love.graphics.newImage("img/basil.png")

    gameAttack.paths = {}

    local originDirection = {-1,0}
    local currentField = {}
    for y=1,12 do
        local props = map:getTileProperties("grid", 1, y)
        if props.path then
            local calcPath = {}

            table.insert(calcPath, { x = 1, y = y })
            currentField = { x = 1, y = y }
            
            
            calcPath = utils:createPath(originDirection, currentField, calcPath)
            table.insert(gameAttack.paths, calcPath)
        end
    end    

    gameAttack.creepsManager = CreepManager()
    gameAttack.towerManager = TowerManager()
    
    gameAttack.lifePoints = 3
    gameAttack.money = 50
    gameAttack.stage = 1
    gameAttack.wave = 1

    gameAttack.creepsManager:startWave(gameAttack.stages[gameAttack.stage][gameAttack.wave])
    gameAttack.spawnStates = {}
    gameAttack.spawnMode = nil
    gameAttack.moneyBackground = love.graphics.newImage("img/money_bg.png")
    gameAttack.music = love.audio.newSource("sound/template_soundtrack.mp3")
    gameAttack.music:setVolume(0.2)
    gameAttack.music:play()

end

function gameAttack:leave()

end

function gameAttack:update(dt)
    lovebird.update()
    map:update(dt)

    gameAttack.creepsManager:update(dt, self)
    gameAttack.towerManager:update(dt, self)

	

	if gameAttack.spawnMode then
        local x = love.mouse.getX()
        local y = love.mouse.getY()
        gameAttack.spawnMode.spawnAllowed = false
		if x < gameAttack.mapSize.x and y < gameAttack.mapSize.y then
            gameAttack.spawnMode.tileX, gameAttack.spawnMode.tileY = utils:convertPositionToTile(x, y)
            gameAttack.spawnMode.posX, gameAttack.spawnMode.posY = utils:convertTileToPosition(gameAttack.spawnMode.tileX, gameAttack.spawnMode.tileY)
            local props = map:getTileProperties("grid", gameAttack.spawnMode.tileX , gameAttack.spawnMode.tileY)
			
            if not props.path and not game.towerManager:getTowerAtTile(game.buildMode.tileX, game.buildMode.tileY) then
                game.buildMode.buildAllowed = true
            end
        end
	end

    Timer.update(dt)
end

function gameAttack:draw()
    map:draw()
    gameAttack.creepsManager:draw()
    gameAttack.towerManager:draw()

	
	
	
	
	-- Hover over tower
    for _,tower in pairs(gameAttack.towerManager.towers) do
        local hoverRange = { tower.worldX, tower.worldY, 
        tower.worldX+tower.image:getWidth(), tower.worldY, 
        tower.worldX+tower.image:getWidth(), tower.worldY+tower.image:getHeight(),
        tower.worldX, tower.worldY+tower.image:getHeight()
        }

        if mlib.polygon.checkPoint(mouseX, mouseY, hoverRange) then
            tower:drawRange()
        end
    end
    gameAttack:creepMenu()
	
	-- spawning boxes
	gameAttack.spawnBoxes = {{x = 100, y = 100, width = 132, height = 132}} -- ins customizing!
	love.graphics.push("all")
	love.graphics.setColor(50,255,50,0)
	love.graphics.rectangle("fill", gameAttack.spawnBoxes[1].x, gameAttack.spawnBoxes[1].y, gameAttack.spawnBoxes[1].width, gameAttack.spawnBoxes[1].height)
	love.graphics.pop()
	
    suit.draw()
end

function gameAttack:creepMenu()
	love.graphics.draw(gameAttack.moneyBackground, 64, 0)
    local colorBlack = {normal = {bg = {0,0,0}, fg = {0,0,0}}}
    local bgRed, bgGreen, bgBlue = 115,102,102 --grey
    suit.layout:push()
        suit.layout:reset(64,2)
        suit.layout:row(14,8)
        suit.ImageButton(gameAttack.imgBasil, {}, suit.layout:col(12,8))
        suit.Label(gameAttack.money, {align = "center", color=colorBlack}, suit.layout:col(32,16))
        gameAttack.spawnStates = {}    
    suit.layout:pop()

	
	suit.layout:reset(80,32)
	
	-- Carrot
    love.graphics.push("all")
    if CreepCarrot.price > gameAttack.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(gameAttack.spawnStates,{"carrot", suit.ImageButton(CreepCarrot.menuImage,{}, suit.layout:row(64,32)), CreepCarrot})
    suit.layout:push(suit.layout:nextRow())
    suit.layout:row(0,8)
    suit.ImageButton(gameAttack.imgBasil, {}, suit.layout:col(16,8))
    suit.Label(CreepCarrot.price, {align = "left"}, suit.layout:col(26,16))    
    suit.layout:pop()
    suit.layout:row(16,padding)
    love.graphics.pop()
	
	-- Eggplant
    love.graphics.push("all")
    if CreepEggplant.price > gameAttack.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(gameAttack.spawnStates,{"eggplant", suit.ImageButton(CreepEggplant.menuImage,{}, suit.layout:row(64,32)), CreepEggplant})
    suit.layout:push(suit.layout:nextRow())
    suit.layout:row(0,8)
    suit.ImageButton(gameAttack.imgBasil, {}, suit.layout:col(16,8))
    suit.Label(CreepEggplant.price, {align = "left"}, suit.layout:col(26,16))    
    suit.layout:pop()
    suit.layout:row(16,padding)
    love.graphics.pop()
	
	-- Tomato
    love.graphics.push("all")
    if CreepTomato.price > gameAttack.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(gameAttack.spawnStates,{"tomato", suit.ImageButton(CreepTomato.menuImage,{}, suit.layout:row(64,32)), CreepTomato})
    suit.layout:push(suit.layout:nextRow())
    suit.layout:row(0,8)
    suit.ImageButton(gameAttack.imgBasil, {}, suit.layout:col(16,8))
    suit.Label(CreepTomato.price, {align = "left"}, suit.layout:col(26,16))    
    suit.layout:pop()
    suit.layout:row(16,padding)
    love.graphics.pop()

end


function gameAttack:mousereleased(mx,my,button)
    if button == 1 then
        for k,v in pairs(gameAttack.spawnStates) do
            if gameAttack.spawnStates[k][2].hovered and gameAttack.money >= gameAttack.spawnStates[k][3].price then
                gameAttack.spawnMode = {towerName = gameAttack.spawnStates[k][1], image = gameAttack.spawnStates[k][3].imageStill, range = gameAttack.spawnStates[k][3].range}
                break
            end
        end
        if gameAttack.spawnMode and gameAttack.spawnMode.buildAllowed then
			--TODO Creep merken
			print("neuer Creep!")
			
            gameAttack.spawnMode = nil
        end
    elseif button == 2 then
        gameAttack.spawnMode = nil
    end
end