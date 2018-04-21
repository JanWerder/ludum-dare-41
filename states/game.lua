function game:enter()
    --Camera Module
    --camera = Camera()

    love.physics.setMeter(32)

    map = sti("maps/defense.lua")

    game.path = {}

    local originDirection = {-1,0}
    local currentField = {}
    for y=1,12 do
        local props = map:getTileProperties("grid", 1, y)
        if props.path then
            table.insert(game.path, { x = 1, y = y })
            currentField = { x = 1, y = y }
        end
    end

    local goFurther = true
    while goFurther == true do
        originDirection, currentField, goFurther = utils:checkPath(originDirection, currentField)
    end

end

function game:update(dt)
    --Camera Module
    --camera:update(dt)
    lovebird.update()
    map:update(dt)
end

function game:draw()
    --camera:attach()
    -- Draw your game here
    --camera:detach()
    --camera:draw()

    map:draw()
end