function game:init()
    game.stage = 1
    game.money = 80
    game.towerManager = TowerManager()
    game.soundAreYouReady = love.audio.newSource("sound/are_you_ready_easteregg.mp3", "static")
    game.soundAreYouReady:play()
    music = love.audio.newSource("sound/template_soundtrack.mp3")
    music:setLooping(true)
    music:setVolume(0.2)
    music:play()
end

function game:enter()
    if game.stage == 4 then
        Gamestate.switch(loveyou)
    end
    love.physics.setMeter(32)
    game.map = sti("maps/defense.lua")
	
    game.mapSize = {x = 640, y = 384}
    game.imgHeart = love.graphics.newImage("img/celeriac.png")
    game.imgBasil = love.graphics.newImage("img/basil.png")
    game.imgWavedone = love.graphics.newImage("img/wavedone.png")
    game.imgCountdown = love.graphics.newImage("img/countdown.png")
    game.aniGridCountdown = Anim8.newGrid(100, 100, game.imgCountdown:getWidth(), game.imgCountdown:getHeight())
    game.aniCountdown = Anim8.newAnimation(game.aniGridCountdown('1-5',1), 1)

    game.camera = Camera()
    game.cameraCenter = { x = 350, y = 200}
    game.camera:fade(1, {0, 0, 0, 0})

    game.paths = {}

    local originDirection = {-1,0}
    local currentField = {}
    for y=1,12 do
        local props = game.map:getTileProperties("grid", 1, y)
        if props.path then
            local calcPath = {}

            table.insert(calcPath, { x = 1, y = y })
            currentField = { x = 1, y = y }
            
            
            calcPath = utils:createPath(originDirection, currentField, calcPath, game.map)
            table.insert(game.paths, calcPath)
        end
    end    

    game.creepsManager = CreepManager()
    
    game.lifePoints = 3
    game.wave = 1
    game.nextWaveTimer = 0
    
    game.spawnBoxes = {}

    game.buttonStates = {}
    game.buildMode = nil
    game.moneyBackground = love.graphics.newImage("img/money_bg.png")
    game.mscBoom = love.audio.newSource("sound/boom.mp3")
    game.mscWavewin = love.audio.newSource("sound/wavewin.mp3")
    game:waveInit()
end

function game:waveInit()
	game.nextWaveTimer = 6
    game.aniCountdown:gotoFrame(5)
    game.firstWave = true
end

function game:waveStart()
	--generate Spawnboxes
	for i,path in pairs(game.paths) do
		table.insert(game.spawnBoxes, SpawnBox(path[1].x, path[1].y, i))
		game.spawnBoxes[utils:tableLength(game.spawnBoxes)]:readSpawnConfig(game.stage, game.wave)
	end
end

function game:update(dt)

    suit.updateMouse(game.camera.mx, game.camera.my)

    if game.lifePoints < 1 then
        game.camera:fade(1, {0, 0, 0, 255})
        Timer.after(1, function() Gamestate.switch(gameOver) end)
    end

    --lovebird.update()
    game.map:update(dt)

    game.creepsManager:update(dt, self)
    game.towerManager:update(dt, self)

	-- Check SpawnBoxes
    for k,spawnBox in pairs(game.spawnBoxes) do
		if utils:tableLength(spawnBox.spawns) > 0 then
			spawnBox:update(dt, self)
		else
			table.remove(game.spawnBoxes, k)
		end
	end	
	
	-- Check Wave & Wins
	if utils:tableLength(game.spawnBoxes) <= 0 and utils:tableLength(game.creepsManager.creeps) <= 0 and utils:tableLength(game.creepsManager.deadCreeps) > 0 and game.nextWaveTimer == 0 then
		game.mscWavewin:play() 
		game.wave = game.wave + 1
        if game.stages[game.stage][game.wave] then
            game.nextWaveTimer = 6
            game.firstWave = false
			game.aniCountdown:gotoFrame(5)
        else
            if gameAttack.stage ~= nil then
                gameAttack.stage = gameAttack.stage + 1
            end
            if game.lifePoints < 1 then
                game.camera:fade(1, {0, 0, 0, 255})
                Timer.after(1, function() Gamestate.switch(gameOver) end)
            else
                Gamestate.switch(gameAttack)
            end
        end
	end
	
    if game.buildMode then
        local x = game.camera.mx
        local y = game.camera.my
        game.buildMode.buildAllowed = false
        if x > 0 and y > 0 and x < game.mapSize.x and y < game.mapSize.y then
            game.buildMode.tileX, game.buildMode.tileY = utils:convertPositionToTile(x, y)
            game.buildMode.posX, game.buildMode.posY = utils:convertTileToPosition(game.buildMode.tileX, game.buildMode.tileY)
            local props = game.map:getTileProperties("grid", game.buildMode.tileX , game.buildMode.tileY)
            if not props.path and not game.towerManager:getTowerAtTile(game.buildMode.tileX, game.buildMode.tileY) then
                game.buildMode.buildAllowed = true
            end
        end
    end 

    game.aniCountdown:update(dt)
    Timer.update(dt)

    if game.nextWaveTimer > 0 then
        game.nextWaveTimer = game.nextWaveTimer - dt
    elseif game.nextWaveTimer < 0 then
        game.mscBoom:play()
		game:waveStart()
		game.nextWaveTimer = 0
    end

    game.camera:update(dt)
    if utils:tableLength(game.camera.vertical_shakes) == 0 then
        game.camera.x, game.camera.y =  game.cameraCenter.x, game.cameraCenter.y
    end    
end

function game:draw()

    game.camera:attach()

    game.map:draw(game.camera.screen_x - game.camera.x,game.camera.screen_y - game.camera.y)
    game.creepsManager:draw()
    game.towerManager:draw()

    for i=1,game.lifePoints do
        love.graphics.draw(game.imgHeart, 10 + 15*i)
    end

    if game.buildMode and game.buildMode.posX and game.camera.mx < game.mapSize.x and game.camera.my < game.mapSize.y then
        love.graphics.push("all")
            if not game.buildMode.buildAllowed then
                love.graphics.setColor(255,0,0)
            end
            love.graphics.draw(game.buildMode.class.imageStill,game.buildMode.posX, game.buildMode.posY)
            love.graphics.setColor(50,255,50,50)
            love.graphics.circle("fill", game.buildMode.posX+16, game.buildMode.posY+16, game.buildMode.class.range)
        love.graphics.pop()
    end

    local mouseX, mouseY = game.camera.mx, game.camera.my
    
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
	
    for _,spawnBox in pairs(game.spawnBoxes) do
		if utils:tableLength(spawnBox.spawns) > 0 then
			spawnBox:draw()
		end
	end
	
    game:towerMenu()
    suit.draw()

    if game.nextWaveTimer > 0 and game.nextWaveTimer < 5 and not game.firstWave then
        love.graphics.draw(game.imgWavedone, game.camera.x-game.imgWavedone:getWidth()/2, game.camera.y-game.imgWavedone:getHeight()/2)
        game.aniCountdown:draw(game.imgCountdown, game.camera.x-game.imgCountdown:getWidth()/10, game.camera.y-game.imgWavedone:getHeight()/2+150)
    end

    game.camera:detach()
    game.camera:draw()
end

function game:towerMenu()
    
    local padding = 40
    
    love.graphics.draw(game.moneyBackground, game.mapSize.x, 0)
    local colorBlack = {normal = {bg = {0,0,0}, fg = {0,0,0}}}
    local bgRed, bgGreen, bgBlue = 115,102,102
    suit.layout:push()
        suit.layout:reset(game.mapSize.x,2)
        suit.layout:row(14,8)
        suit.ImageButton(game.imgBasil, {}, suit.layout:col(12,8))
        suit.Label(game.money, {align = "center", color=colorBlack}, suit.layout:col(32,16))
        game.buttonStates = {}    
    suit.layout:pop()

    suit.layout:reset(game.mapSize.x,32)

    love.graphics.push("all")
    if TowerKnife.price > game.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(game.buttonStates,{"knife", suit.ImageButton(TowerKnife.menuImage,{}, suit.layout:row(64,44)), TowerKnife})
    -- suit.Label(TowerKnife.price .. " Basil", {align = "center"}, suit.layout:row(64,18))
    -- suit.layout:row(64,4)

    suit.layout:push(suit.layout:nextRow())
    suit.layout:row(16,8)
    suit.ImageButton(game.imgBasil, {}, suit.layout:col(16,8))
    suit.Label(TowerKnife.price, {align = "left"}, suit.layout:col(26,16))    
    suit.layout:pop()
    suit.layout:row(16,padding)
    love.graphics.pop()


    love.graphics.push("all")
    if TowerCatapult.price > game.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(game.buttonStates,{"catapult", suit.ImageButton(TowerCatapult.menuImage,{}, suit.layout:row(64,40)), TowerCatapult})
        
    suit.layout:push(suit.layout:nextRow())
    suit.layout:row(16,8)
    suit.ImageButton(game.imgBasil, {}, suit.layout:col(16,8))
    suit.Label(TowerCatapult.price, {align = "left"}, suit.layout:col(26,16))    
    suit.layout:pop()
    suit.layout:row(16,padding)

    love.graphics.pop()

    love.graphics.push("all")
    if TowerOliveOil.price > game.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(game.buttonStates,{"oliveOil", suit.ImageButton(TowerOliveOil.menuImage,{}, suit.layout:row(64,64)), TowerOliveOil})
    -- suit.Label(TowerOliveOil.price .. " Basil", {align = "center"}, suit.layout:row(64,8))
    -- suit.layout:row(64,8)

    suit.layout:push(suit.layout:nextRow())
    suit.layout:row(16,8)
    suit.ImageButton(game.imgBasil, {}, suit.layout:col(16,8))
    suit.Label(TowerOliveOil.price, {align = "left"}, suit.layout:col(26,16))    
    suit.layout:pop()
    suit.layout:row(16,padding)

    love.graphics.pop()

    love.graphics.push("all")
    if TowerSalt.price > game.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(game.buttonStates,{"salt", suit.ImageButton(TowerSalt.menuImage,{}, suit.layout:row(64,64)), TowerSalt})
    -- suit.Label(TowerSalt.price .. " Basil", {align = "center"}, suit.layout:row(64,14))

    suit.layout:push(suit.layout:nextRow())
    suit.layout:row(16,8)
    suit.ImageButton(game.imgBasil, {}, suit.layout:col(16,8))
    suit.Label(TowerSalt.price, {align = "left"}, suit.layout:col(26,16))    
    suit.layout:pop()
    suit.layout:row(16,padding)

    love.graphics.pop()
end


function game:mousereleased(mx,my,button)
    if button == 1 then
        for k,v in pairs(game.buttonStates) do
            if game.buttonStates[k][2].hovered and game.money >= game.buttonStates[k][3].price then
                game.buildMode = {towerName = game.buttonStates[k][1], class = game.buttonStates[k][3]}
                break
            end
        end
        if game.buildMode and game.buildMode.buildAllowed then
			game.money = game.money - game.buildMode.class.price
            game.towerManager:addTower(self, game.buildMode.tileX, game.buildMode.tileY, game.buildMode.towerName)
            game.buildMode = nil
        end
    elseif button == 2 then
        game.buildMode = nil
    end
end
