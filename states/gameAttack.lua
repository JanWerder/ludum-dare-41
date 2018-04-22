function gameAttack:init()
    gameAttack.stage = 1
    -- gameAttack.money = 80
end

function gameAttack:enter()
    love.physics.setMeter(32)

    gameAttack.map = sti("maps/attack.lua", "", 0, 0)
	
    gameAttack.mapSize = {x = 640, y = 384}
    gameAttack.imgHeart = love.graphics.newImage("img/celeriac.png")
    gameAttack.imgBasil = love.graphics.newImage("img/basil.png")

    gameAttack.camera = Camera()
    gameAttack.cameraCenter = { x = 300, y = 200}
    gameAttack.camera:fade(1, {0, 0, 0, 0})

    Moan.setCamera(gameAttack.camera)
    gameAttack.gordon = love.graphics.newImage("img/cook_gordon.png")
    gameAttack.jamie = love.graphics.newImage("img/cook_jamie.png")
    gameAttack.nigella = love.graphics.newImage("img/cook_nigella.png")
    gameAttack.avatar = love.graphics.newImage("img/cook_sarah.png")

    gameAttack.messages = require 'objects/conversations'

    Timer.after(1, function() gameAttack:speak(gameAttack.stage, 1) end)
    Timer.after(10, function() gameAttack:speak(gameAttack.stage, 2) end)
    Timer.after(20, function() gameAttack:speak(gameAttack.stage, 3) end)
    Timer.after(30, function() Timer.clear() end)

    gameAttack.paths = {}

    local originDirection = {-1,0}
    local currentField = {}
    for y=1,12 do
        local props = gameAttack.map:getTileProperties("grid", 1, y)
        if props.path then
            local calcPath = {}

            table.insert(calcPath, { x = 1, y = y })
            currentField = { x = 1, y = y }
            
            
            calcPath = utils:createPath(originDirection, currentField, calcPath, gameAttack.map)
            table.insert(gameAttack.paths, calcPath)
        end
    end    

    gameAttack.creepsManager = CreepManager()
    gameAttack.towerManager = TowerManager()
	
    gameAttack.spawnBoxes = {}

    gameAttack.wave = 1
    gameAttack.lifePoints = math.floor(1.5 * gameAttack.stage)
    -- gameAttack.money = 50 * gameAttack.stage
    gameAttack.money = 150 * gameAttack.stage
    gameAttack.spawnStates = {}
    gameAttack.spawnMode = nil
    gameAttack.moneyBackground = love.graphics.newImage("img/money_bg.png")    
    
    towerAttack = require('objects/stagesAttack')
    for _,tower in pairs(towerAttack[gameAttack.stage]) do
        gameAttack.towerManager:addTower(self, tower[2], tower[3], tower[1])
    end
	gameAttack:stageInit()
end

function gameAttack:stageInit()
	--generate Spawnboxes
	for i,path in pairs(gameAttack.paths) do
		table.insert(gameAttack.spawnBoxes, SpawnBox(path[1].x, path[1].y, i))
	end
end

function gameAttack:waveStart()
	for _,spawnBox in pairs(gameAttack.spawnBoxes) do
		spawnBox:startStage()
	end
end

function gameAttack:update(dt)

    if gameAttack.lifePoints < 1 then
        game.stage = game.stage+1
        Gamestate.switch(game)
    end

	-- GameOver setzen
	if utils:tableLength(gameAttack.spawnBoxes) <= 0 and utils:tableLength(gameAttack.creepsManager.creeps) <= 0 then
		gameAttack.camera:fade(1, {0, 0, 0, 255})
        Timer.after(1, function() Gamestate.switch(gameOver) end)
	end

    Moan.update(dt)

    if Moan.printedText == Moan.currentMessage or Moan.paused == true then
        if not Moan.timerStarted then
            Moan.timerStarted = true
            Timer.after(3, function() Moan.keyreleased("space") Moan.timerStarted = false end)
        end
    end

    suit.updateMouse(gameAttack.camera.mx, gameAttack.camera.my)

    lovebird.update()
    gameAttack.map:update(dt)

    gameAttack.creepsManager:update(dt, self)
    gameAttack.towerManager:update(dt, self)

	-- Check SpawnBoxes
    for k,spawnBox in pairs(gameAttack.spawnBoxes) do
		if utils:tableLength(spawnBox.spawns) > 0 then
			spawnBox:update(dt, self)
		elseif utils:tableLength(spawnBox.spawns) <= 0 and spawnBox:isStageStarted() then
			table.remove(gameAttack.spawnBoxes, k)
		end
	end
	
	-- Check Wave & Wins
	if utils:tableLength(gameAttack.spawnBoxes) <= 0 and utils:tableLength(gameAttack.creepsManager.creeps) <= 0 and utils:tableLength(gameAttack.creepsManager.deadCreeps) > 0 and gameAttack.nextWaveTimer == 0 then
		gameAttack.mscWavewin:play() 
		gameAttack.wave = gameAttack.wave + 1
        if gameAttack.stages[gameAttack.stage][gameAttack.wave] then
			gameAttack.nextWaveTimer = 6
			gameAttack.aniCountdown:gotoFrame(5)
        else
			Gamestate.switch(gameAttack)
        end
	end	

    if gameAttack.spawnMode then
        local x = gameAttack.camera.mx
        local y = gameAttack.camera.my
        gameAttack.spawnMode.spawnBoxIndex = nil
		for k,spawnBox in pairs(gameAttack.spawnBoxes) do
			if spawnBox:isPointInBox(x,y) then
                gameAttack.spawnMode.spawnBoxIndex = k
                break
			end
		end
	end

    Timer.update(dt)

    gameAttack.camera:update(dt)
    if utils:tableLength(gameAttack.camera.vertical_shakes) == 0 then
        gameAttack.camera.x, gameAttack.camera.y =  gameAttack.cameraCenter.x, gameAttack.cameraCenter.y
    end   
end

function gameAttack:draw()

    gameAttack.camera:attach()

    gameAttack.map:draw(gameAttack.camera.screen_x - gameAttack.camera.x,gameAttack.camera.screen_y - gameAttack.camera.y)
    
    love.graphics.push("all")
    love.graphics.setColor( 0, 0, 0)
    love.graphics.rectangle("fill", game.camera.x-game.camera.screen_x, game.camera.y+game.camera.screen_y/2+50,1200,300)
    love.graphics.pop()

    gameAttack.creepsManager:draw()
    gameAttack.towerManager:draw()
    
    for i=1,gameAttack.lifePoints do
        love.graphics.draw(gameAttack.imgHeart, 10 + 15*i)
    end

	local mouseX, mouseY = gameAttack.camera.mx, gameAttack.camera.my
    
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
	
    for _,spawnBox in pairs(gameAttack.spawnBoxes) do
		spawnBox:draw()
	end
	
    gameAttack:creepMenu()
    
    suit.draw()

    gameAttack.camera:detach()
    gameAttack.camera:draw()

    Moan.draw()
end

function gameAttack:creepMenu()
	love.graphics.draw(gameAttack.moneyBackground, -64, 0)
    local colorBlack = {normal = {bg = {0,0,0}, fg = {0,0,0}}}
    local bgRed, bgGreen, bgBlue = 115,102,102 --grey
    suit.layout:push()
	suit.layout:reset(-64,2)
	suit.layout:row(14,8)
	suit.ImageButton(gameAttack.imgBasil, {}, suit.layout:col(12,8))
	suit.Label(gameAttack.money, {align = "center", color=colorBlack}, suit.layout:col(32,16))
	gameAttack.spawnStates = {}    
    suit.layout:pop()

	
	suit.layout:reset(-48,32)
	
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
	
	-- Pause
    love.graphics.push("all")
    if CreepTomato.price > gameAttack.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
	local imagePause = love.graphics.newImage("img/pause.png")
    table.insert(gameAttack.spawnStates,{"pause", suit.ImageButton(imagePause,{}, suit.layout:row(64,32))})
    suit.layout:push(suit.layout:nextRow())
    suit.layout:row(0,8)   
    suit.layout:pop()
    suit.layout:row(16,padding)
    love.graphics.pop()
end


function gameAttack:mousereleased(mx,my,button)
    if button == 1 then
        for k,v in pairs(gameAttack.spawnStates) do
			if gameAttack.spawnStates[k][2].hovered and gameAttack.spawnStates[k][1] == 'pause' then 
                gameAttack.spawnMode = {creepName = gameAttack.spawnStates[k][1], image = "", range = 0}
				break
			end
            if gameAttack.spawnStates[k][2].hovered and gameAttack.money >= gameAttack.spawnStates[k][3].price then
                gameAttack.spawnMode = {creepName = gameAttack.spawnStates[k][1], class = gameAttack.spawnStates[k][3]}
                break
            end
        end
        if gameAttack.spawnMode and gameAttack.spawnMode.spawnBoxIndex ~= nil then
			if gameAttack.spawnMode.creepName ~= 'pause' then
				gameAttack.money = gameAttack.money - gameAttack.spawnMode.class.price
			end
			gameAttack.spawnBoxes[gameAttack.spawnMode.spawnBoxIndex]:addSpawn(gameAttack.spawnMode.creepName,1)
            gameAttack.spawnMode = nil
        else
            for k,spawnBox in pairs(gameAttack.spawnBoxes) do
                if spawnBox:isPointInBox(gameAttack.camera.mx, gameAttack.camera.my) then
                    local deletionType = gameAttack.spawnBoxes[k]:handleBoxClick(gameAttack.camera.mx, gameAttack.camera.my)

                    if deletionType == 'tomato' then
                        gameAttack.money = gameAttack.money + CreepTomato.price
                    elseif deletionType == 'carrot' then
                        gameAttack.money = gameAttack.money + CreepCarrot.price
                    elseif deletionType == 'eggplant' then
                        gameAttack.money = gameAttack.money + CreepEggplant.price
                    end	

                    break
                end
            end
        end
    elseif button == 2 then
        gameAttack.spawnMode = nil
    end
end

function gameAttack:speak(boss, index)
    for _,message in pairs(gameAttack.messages[boss][index]) do
        Moan.speak({message.name, message.color}, message.message, {image=message.avatar})        
    end
end

function gameAttack:keyreleased(key, code)
    if key == "e" and love.keyboard.isDown("lctrl") then
        gameAttack:waveStart()
    end
    if key == "d" and love.keyboard.isDown("lctrl") then
        gameAttack:waveStart()
    end
end