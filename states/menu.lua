function menu:enter()    
    menu.input = {text = ""}
end

function menu:draw()
	imageMenu = love.graphics.newImage("img/icon.png")
	local menuPolygon = {50, 175, 420, 175, 420, 435, 50, 435}
	love.graphics.draw(imageMenu, 0, 0, 0, 1, 0.75)
	love.graphics.push("all")
	love.graphics.setColor(50,50,50,225)
	love.graphics.polygon("fill", menuPolygon)
	love.graphics.pop()

	
	-- Text
	suit.layout:reset(60,186)
	suit.Label("Hello there!", {align = "left"}, suit.layout:row(400,20))
	suit.Label("Welcome to the world of chefs! My name is Spruce! ", {align = "left"}, suit.layout:row())
	suit.Label("People call me the professor of chefs.", {align = "left"}, suit.layout:row())	
	suit.Label("This world is inhabited by creatures called chefs.", {align = "left"}, suit.layout:row())
	suit.Label("For some people, chefs are just people who make food.", {align = "left"}, suit.layout:row())
	suit.Label("Others use them for fights.", {align = "left"}, suit.layout:row())
	suit.Label("Myself...I study chefs as a profession.", {align = "left"}, suit.layout:row())
	suit.layout:row(400,10)
	suit.Label("Care to win the hearts of the best chefs", {align = "left"}, suit.layout:row(400,20))
	suit.Label("and become the master of chefs?", {align = "left"}, suit.layout:row())
	suit.layout:row(400,5)
	-- Start Button
	if suit.Button("Yes, I do!", suit.layout:row(350,40)).hit then
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
