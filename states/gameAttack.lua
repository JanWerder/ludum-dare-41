function gameAttack:enter()
    love.physics.setMeter(32)

    map = sti("maps/defense.lua")

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

    gameAttack.mapSize = {x = 640, y = 384}
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

    gameAttack.creepsManager:update(self, dt)
    gameAttack.towerManager:update(self, dt)




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
    suit.layout:reset(640,6)
    love.graphics.draw(gameAttack.moneyBackground,640, 0)
    local colorBlack = {normal = {bg = {0,0,0}, fg = {0,0,0}}}
    local bgRed, bgGreen, bgBlue = 115,102,102
    suit.Label("Basil: " .. gameAttack.money, {align = "center", color=colorBlack}, suit.layout:row(64,8))
    gameAttack.buttonStates = {}
    suit.layout:row(64,8)

    love.graphics.push("all")
    if TowerKnife.price > gameAttack.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(gameAttack.buttonStates,{"knife", suit.ImageButton(TowerKnife.menuImage,{}, suit.layout:row(64,44)), TowerKnife})
    suit.Label(TowerKnife.price .. " Basil", {align = "center"}, suit.layout:row(64,18))
    suit.layout:row(64,4)
    love.graphics.pop()


    love.graphics.push("all")
    if TowerCatapult.price > gameAttack.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(gameAttack.buttonStates,{"catapult", suit.ImageButton(TowerCatapult.menuImage,{}, suit.layout:row(64,40)), TowerCatapult})
    suit.Label(TowerCatapult.price .. " Basil", {align = "center"}, suit.layout:row(64,16))
    love.graphics.pop()

    love.graphics.push("all")
    if TowerOliveOil.price > gameAttack.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(gameAttack.buttonStates,{"oliveOil", suit.ImageButton(TowerOliveOil.menuImage,{}, suit.layout:row(64,64)), TowerOliveOil})
    suit.Label(TowerOliveOil.price .. " Basil", {align = "center"}, suit.layout:row(64,8))
    suit.layout:row(64,8)
    love.graphics.pop()

    love.graphics.push("all")
    if TowerSalt.price > gameAttack.money then
        love.graphics.setColor(bgRed, bgGreen, bgBlue)
    end
    table.insert(gameAttack.buttonStates,{"salt", suit.ImageButton(TowerSalt.menuImage,{}, suit.layout:row(64,64)), TowerSalt})
    suit.Label(TowerSalt.price .. " Basil", {align = "center"}, suit.layout:row(64,14))
    love.graphics.pop()
end


function gameAttack:mousereleased(mx,my,button)





end