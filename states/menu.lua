function menu:enter()    
    menu.input = {text = ""}
end

function menu:draw()
	imageMenu = love.graphics.newImage("img/icon.png")
	local menuPolygon = {80, 230, 420, 230, 420, 400, 80, 400}
	love.graphics.draw(imageMenu, 0, 0, 0, 1, 0.75)
	love.graphics.push("all")
	love.graphics.setColor(50,50,50,200)
	love.graphics.polygon("fill", menuPolygon)
	love.graphics.pop()

	
	-- Text
	suit.layout:reset(100,250)
	suit.Label("Hello,", {align = "left"}, suit.layout:row(200,20))
	suit.Label("it's my quest to assemble the best chef team", {align = "left"}, suit.layout:row(300,20))
	suit.Label("in the world.", {align = "left"}, suit.layout:row(300,20))	
	suit.Label("Want to help me? Press start!", {align = "left"}, suit.layout:row(200,20))
	suit.layout:row(200,20)
	
	-- Start Button
	if suit.Button("Start", suit.layout:row(300,40)).hit then
		menu:start()
	end
    suit.draw()
end

function menu:start()
	Gamestate.switch(game)
end

function menu:keyreleased(key, code)
    if key == 'return' then
       menu:start()
    end
end
