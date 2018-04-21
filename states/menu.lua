function menu:enter()    
    menu.input = {text = ""}
end

function menu:draw()
    love.graphics.print("Press Enter to continue", 10, 10)

    --GUI
    suit.layout:reset(100,100)
	suit.Input( menu.input , suit.layout:row(200,30))
	suit.Label("Hello, ".. menu.input.text, {align = "left"}, suit.layout:row())
    suit.layout:row()
    
	if suit.Button("Close", suit.layout:row()).hit then
		love.event.quit()
	end
    suit.draw()
end

function menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(game)
    end
end
