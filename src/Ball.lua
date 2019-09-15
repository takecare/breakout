local Object = require('src/Object')
local Ball = Class{__includes = Object}

local TOP_WALL = 0
local BOTTOM_WALL = 0
local RIGHT_WALL = 0
local LEFT_WALL = 0

function Ball:init(x, y)
    self.skin = 1
    self.x = x ~= nil and x or VIRTUAL_WIDTH / 2 - 32
    self.y = y ~= nil and y or VIRTUAL_HEIGHT - 64
    -- self.width = 8
    -- self.height = 8
    self.dx = 0
    self.dy = 0

    -- hack: as when the file is loaded VIRTUAL_* are not defined
    BOTTOM_WALL = VIRTUAL_HEIGHT
    RIGHT_WALL = VIRTUAL_WIDTH
end

function Ball:update(dt)
    local width = self:quad().width
    local height = self:quad().height

    if self.x < LEFT_WALL then -- hit left wall
        gSounds['wallhit']:play()
        self.x = LEFT_WALL
        self.dx = self.dx * -1
    elseif self.x + width > RIGHT_WALL then -- hit right wall
        gSounds['wallhit']:play()
        self.x = RIGHT_WALL - width
        self.dx = self.dx * -1
    elseif self.y < TOP_WALL then -- hit top wall
        gSounds['wallhit']:play()
        self.y = TOP_WALL
        self.dy = self.dy * -1
    elseif self.y + height > BOTTOM_WALL then -- ball went out
        self:reset() -- TODO
    end

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:reset()
    self.dx = 0
    self.x = VIRTUAL_HEIGHT / 2
    self.y = VIRTUAL_WIDTH / 2
end

function Ball:serve()
    self.dy = -100
    self.dx = math.random() > 0.5 and -80 or 80
end

function Ball:render()
    love.graphics.draw(gTextures['breakout'], self:sprite(), self.x, self.y)
end

function Ball:quad()
    return gSprites['balls'][1]
end

function Ball:sprite()
    return self:quad().sprite
end

function Ball:boundingBox()
    local quad = self:quad()
    return {
        x = self.x,
        y = self.y,
        width = quad.width,
        height = quad.height
    }
end

function Ball:collidesWith(object)
    local myBox = self:boundingBox()
    local box = object:boundingBox()
    return myBox.x < box.x + box.width and myBox.x + myBox.width > box.x
        and myBox.y < box.y + box.height and myBox.y + myBox.height > box.y
end

function Ball:collidedWith(object)
    -- TODO better collision support for when the ball hits the side of a brick
    if self.y < object.y then
        self.dy = -100
        self.y = object.y - self:boundingBox().height
    else
        self.dy = 100
        -- self.y = object.y + self:boundingBox().height
    end
end

return Ball
