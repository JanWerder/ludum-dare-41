function gameAttack:enter()
    love.physics.setMeter(32)

    map = sti("maps/defense.lua", "", 128, 0)
	
    gameAttack.mapSize = {x = 640, y = 384}
	tileOffset = {x = 128, y = 0}

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
    gameAttack.buttonStates = {}
    gameAttack.buildMode = nil
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
    suit.draw()
end

function gameAttack:creepMenu()
	love.graphics.draw(gameAttack.moneyBackground, 64, 0)
    local colorBlack = {normal = {bg = {0,0,0}, fg = {0,0,0}}}
    local bgRed, bgGreen, bgBlue = 115,102,102 --grey
    suit.layout:push()
        suit.layout:reset(64,2)
        suit.layout:row(14,8)
        --suit.ImageButton(gameAttack.imgBasil, {}, suit.layout:col(12,8))
        suit.Label(gameAttack.money, {align = "center", color=colorBlack}, suit.layout:col(32,16))
        gameAttack.buttonStates = {}    
    suit.layout:pop()

	
	suit.layout:reset(0,32)




end


function gameAttack:mousereleased(mx,my,button)





end