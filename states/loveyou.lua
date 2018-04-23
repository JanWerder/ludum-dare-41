function loveyou:enter()
    Timer.clear()
    loveyou.imgBackground = love.graphics.newImage("img/loveu.png")
end

function loveyou:draw()
    love.graphics.draw(loveyou.imgBackground)
    suit.draw()
end

function loveyou:update()
    suit.layout:reset(love.graphics.getWidth( )/2-100,90)
    suit.Label("Congratz, you won the hearts of 3 famous chefs!", {align = "center"}, suit.layout:row(200,20))
    suit.layout:row()
    if suit.Button("Exit", suit.layout:row(200,30)).hit then
		love.event.quit()
	end
end