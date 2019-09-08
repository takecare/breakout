generatePaddlesQuads = function (atlas)
    local x = 0
    local y = 64

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        -- smallest
        quads[counter] = Quad(love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions()), 32, 16)
        counter = counter + 1
        -- medium
        quads[counter] = Quad(love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions()), 64, 16)
        counter = counter + 1
        -- large
        quads[counter] = Quad(love.graphics.newQuad(x + 96, y, 96, 16, atlas:getDimensions()), 96, 16)
        counter = counter + 1
        -- huge
        quads[counter] = Quad(love.graphics.newQuad(x, y + 16, 128, 16, atlas:getDimensions()), 128, 16)
        counter = counter + 1

        -- prepare X and Y for the next set of paddles
        x = 0
        y = y + 32
    end

    return quads
end

generateBallsQuads = function (atlas)
    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = Quad(love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions()), 8, 8)
        x = x + 8
        counter = counter + 1
    end

    x = 96
    y = 56

    for i = 0, 2 do
        quads[counter] = Quad(love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions()), 8, 8)
        x = x + 8
        counter = counter + 1
    end

    return quads
end

generateBricksQuads = function (atlas)
    local tilewidth = 32
    local tileheight = 16

    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] = Quad(
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions()),
                tilewidth,
                tileheight
            )
            sheetCounter = sheetCounter + 1
        end
    end

    local sliced = {}
  
    for i = 1 or 1, 21 or #spritesheet, step or 1 do
      sliced[#sliced+1] = spritesheet[i]
    end
  
    return sliced
end
