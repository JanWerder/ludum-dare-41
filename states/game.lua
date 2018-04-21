function game:enter()
    --Camera Module
    --camera = Camera()

    love.physics.setMeter(32)

    map = sti("maps/defense.lua")

    path = {}

    for x=1,20 do
        for y=1,12 do
            local props = map:getTileProperties("grid", x, y)
            --print(inspect(props))
            if props.path then
                table.insert(path, { x = x, y = y })
            end
        end
    end

    print(inspect(path))

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