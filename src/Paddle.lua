local Object = require('src/Object')
local Paddle = Class{__includes = Object}

local PADDLE_X_OFFSET = 32
local PADDLE_Y_OFFSET = 32
local SPEED = 250

function Paddle:init(x, y)
    self.skin = 1
    self.size = 2
    self.x = x ~= nil and x or VIRTUAL_WIDTH / 2 - PADDLE_X_OFFSET
    self.y = y ~= nil and y or VIRTUAL_HEIGHT - PADDLE_Y_OFFSET
    self.dx = 0
end

function Paddle:handleInput()
    -- hacky way of having different levels off acceleration:
    -- define ranges and check in which range dx is in, using diferent
    -- dividends accordingly
    
    if love.keyboard.isDown('left') then
        self.dx = self.dx - SPEED / 40
        if (self.dx < -SPEED) then
            self.dx = -SPEED
        end
    elseif love.keyboard.isDown('right') then
        self.dx = self.dx + SPEED / 40
        if (self.dx > SPEED) then
            self.dx = SPEED
        end
    else
        self.dx = 0
    end
end

function Paddle:keyPressed(key)
    if key == 'p' then
        self.skin = self.skin < 4 and self.skin + 1 or 1
    end
end

function Paddle:update(dt)
    local width = self:quad().width
    local x = self.x + self.dx * dt
    self.x = self.dx < 0 and math.max(0, x) or math.min(VIRTUAL_WIDTH - width, x)
end

function Paddle:render()
    love.graphics.draw(gTextures['breakout'], self:sprite(), self.x, self.y)
end

function Paddle:quad()
    return gSprites['paddles'][self.size + 4 * (self.skin - 1)]
end

function Paddle:sprite()
    return self:quad().sprite
end

function Paddle:boundingBox()
    local quad = self:quad()
    return {
        x = self.x,
        y = self.y,
        width = quad.width,
        height = quad.height
    }
end

function Paddle:collidesWith(object)
    local myBox = self:boundingBox()
    local box = object:boundingBox()
    return myBox.x < box.x + box.width and myBox.x + myBox.width > box.x
        and myBox.y < box.y + box.height and myBox.y + myBox.height > box.y
end

return Paddle
