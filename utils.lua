utils = {}

function utils:tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function utils:checkPath(originDirection, currentField)
    local directionsToCheck = {
        {1,0},
        {-1,0},
        {0,1},
        {0,-1}
    }
    for k,v in pairs(directionsToCheck) do
        if directionsToCheck[k][1] ~= originDirection[1] or directionsToCheck[k][2] ~= originDirection[2] then
            local checkX = currentField.x+directionsToCheck[k][1]
            local checkY = currentField.y+directionsToCheck[k][2]
            local props = map:getTileProperties("grid", checkX , checkY)
            if props.path then
                table.insert(game.path, { x = checkX, y = checkY })
                return { currentField.x-checkX, currentField.y-checkY },{ x = checkX, y = checkY }, true
            end
        end
    end
    return {},{},false
end

return utils