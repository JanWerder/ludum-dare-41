utils = {}

function utils:tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function utils:createPath(originDirection, currentField, calcPath)
    

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
                table.insert(calcPath, { x = checkX, y = checkY })
                utils:createPath({ currentField.x-checkX, currentField.y-checkY },{ x = checkX, y = checkY }, calcPath)
            end
        end
    end

    return calcPath
end

function utils:convertTileToPosition(tileX, tileY)
	-- tileOffset -> global in Gamestates
    local tileSize = 32
    local positionX = (tileX -1) * tileSize + tileOffset.x
    local positionY = (tileY -1) * tileSize + tileOffset.y
    return positionX, positionY
end

function utils:convertPositionToTile(positionX, positionY)
    local tileSize = 32
    local tileX = math.floor((positionX / tileSize))+1
    local tileY = math.floor((positionY / tileSize))+1
    return tileX, tileY
end

return utils