function gameOver:enter()
    Timer.clear()
    game:init()
    gameAttack:init()
end

function gameOver:draw()
    suit.draw()
end

function gameOver:update()
    suit.layout:reset(love.graphics.getWidth( )/2-100,love.graphics.getHeight( )/2-130)
    suit.Label("Congratz, you lost", {align = "center"}, suit.layout:row(200,30))
    suit.layout:row()
	if suit.Button("Retry", suit.layout:row()).hit then
		Gamestate.switch(game) 
    end
    suit.layout:row()
    if suit.Button("Exit", suit.layout:row()).hit then
		love.event.quit()
	end
end