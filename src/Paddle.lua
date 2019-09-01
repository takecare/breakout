local Paddle = Class{__includes = Object}

local PADDLE_Y_THRESHOLD = 32
local SPEED = 110

function Paddle:init(x, y, quad)
    self.skin = 1
    self.size = 2
    self.x = x ~= nil and x or VIRTUAL_WIDTH / 2 - 0
    self.y = y ~= nil and y or VIRTUAL_HEIGHT - PADDLE_Y_THRESHOLD
    self.dx = 0
end

-- TODO implement dragging: paddle moves a bit after player releasing key
function Paddle:handleInput()
    if love.keyboard.isDown('left') then
        self.dx = -SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = SPEED
    else
        self.dx = 0
    end
end

function Paddle:update(dt)
    self:handleInput()
    local width = self:quad().width
    local x = self.x + self.dx * dt
    self.x = self.dx < 0 and math.max(0, x) or math.min(VIRTUAL_WIDTH - width, x)
end

function Paddle:render()
    love.graphics.draw(gTextures['breakout'], self:sprite(), self.x, self.y)
end

function Paddle:quad()
    return gSprites['paddles'][self.skin]
end

function Paddle:sprite()
    return self:quad().sprite
end

return Paddle