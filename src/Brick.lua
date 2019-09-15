local Object = require('src/Object')
local Brick = Class{__includes = Object}

function Brick:init(x, y)
    self.x = x
    self.y = y
    self.alive = true
    self.tier = 2
    self.color = 1
end

function Brick:update(dt)
    -- needed?
end

function Brick:render()
    if self.alive then
        love.graphics.draw(gTextures['breakout'], self:sprite(), self.x, self.y)
    end
end

function Brick:boundingBox()
    local quad = self:quad()
    return {
        x = self.x,
        y = self.y,
        width = quad.width,
        height = quad.height
    }
end

function Brick:collidesWith(object)
    if not self.alive then
        return false
    end

    local myBox = self:boundingBox()
    local box = object:boundingBox()

    return myBox.x < box.x + box.width and myBox.x + myBox.width > box.x
        and myBox.y < box.y + box.height and myBox.y + myBox.height > box.y
end

function Brick:collidedWith(box)
    self.alive = false
    gSounds['brickhit2']:play()
end

function Brick:quad()
    return gSprites['bricks'][1 + ((self.color - 1) * 4) + self.tier]
end

function Brick:sprite()
    return self:quad().sprite
end

return Brick
