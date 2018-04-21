function gameOver:enter()
    print("Congratz, you lost")
end

function gameOver:draw()
    love.graphics.print("Congratz, you lost", 100, 100)
end

function gameOver:update()
    
end