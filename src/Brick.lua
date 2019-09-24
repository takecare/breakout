local Object = require('src/Object')
local Brick = Class{__includes = Object}

function Brick:init(x, y, tier, color)
    self.x = x
    self.y = y
    self.alive = true
    self.tier = tier ~= nil and tier or 2
    self.color = color ~= nil and color or 1
end

function Brick:update(dt)
    -- needed?
end

function Brick:render()
    if self.alive then
        local r,g,b,a = love.graphics.getColor()
        love.graphics.draw(gTextures['breakout'], self:sprite(), self.x, self.y)

        love.graphics.setColor(0.7,0.6,0.5,0.5)
        love.graphics.rectangle('fill',self.x,self.y,self:boundingBox().width,self:boundingBox().height)
        love.graphics.setColor(r,g,b,a)
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
