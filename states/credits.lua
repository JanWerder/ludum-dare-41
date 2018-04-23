function credits:enter()    
    menu.input = {text = ""}
end

function credits:draw()
	imageMenu = love.graphics.newImage("img/icon.png")
	local menuPolygon = {100, 275, 480, 275, 480, 535, 100, 535}
	love.graphics.draw(imageMenu, 0, 0, 0, 1, 0.75)
	love.graphics.push("all")
	love.graphics.setColor(50,50,50,225)
	love.graphics.polygon("fill", menuPolygon)
	love.graphics.pop()

	
	-- Text
	suit.layout:reset(120,286)
	suit.Label("Thank you for playing this game.", {align = "left"}, suit.layout:row(400,20))
	suit.Label("", {align = "left"}, suit.layout:row())
	suit.Label("Tributes go to ... for publishing such awesome music", {align = "left"}, suit.layout:row())	
	suit.Label("Check them out", {align = "left"}, suit.layout:row())
	-- Start Button
	if suit.Button("Got it!", suit.layout:row(350,40)).hit then
		credits:start()
	end
    suit.draw()
end

function credits:start()
	Gamestate.switch(menu)
end

function credits:keyreleased(key, code)
    if key == 'return' then
        credits:start()
    end
end
