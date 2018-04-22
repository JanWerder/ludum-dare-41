function loveyou:enter()
    Timer.clear()
    game:init()
end

function loveyou:draw()
    suit.draw()
end

function loveyou:update()
    suit.layout:reset(love.graphics.getWidth( )/2-100,love.graphics.getHeight( )/2-100)
    suit.Label("Congratz, you won the hearts of 3 famous chefs!", {align = "center"}, suit.layout:row(200,30))
    suit.layout:row()
    suit.layout:row()
    if suit.Button("Exit", suit.layout:row()).hit then
		love.event.quit()
	end
end