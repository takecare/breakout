Quad = Class{}

function Quad:init(sprite, width, height)
    self.sprite = sprite
    self.width = width
    self.height = height
end

function Quad:print()
    print(self.sprite)
    print(self.width)
    print(self.height)
end

local generatePaddlesQuads = function (atlas)
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

return generatePaddlesQuads
