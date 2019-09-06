local Ball = Class{__includes = Object}

local TOP_WALL = 0
local BOTTOM_WALL = 0
local RIGHT_WALL = 0
local LEFT_WALL = 0

function Ball:init(x, y)
    self.skin = 1
    self.x = x ~= nil and x or VIRTUAL_WIDTH / 2 - 32
    self.y = y ~= nil and y or VIRTUAL_HEIGHT - 20
    -- self.width = 8
    -- self.height = 8
    self.dx = 0
    self.dy = 0

    -- hack! as when the file is loaded VIRTUAL_* are not defined
    BOTTOM_WALL = VIRTUAL_HEIGHT
    RIGHT_WALL = VIRTUAL_WIDTH
end

function Ball:update(dt)
    local width = self:quad().width
    if self.x <= LEFT_WALL then -- hit left wall
        self.dx = self.dx * -1
    elseif self.x + width >= RIGHT_WALL then -- hit right wall
        self.dx = self.dx * -1
    elseif self.dy > BOTTOM_WALL then -- ball went out
        self.dx = 0
        self.x = VIRTUAL_HEIGHT / 2
        self.y = VIRTUAL_WIDTH / 2
    elseif self.dy <= TOP_WALL then -- hit top wall
        self.dx = self.dx * -1
        self.dy = self.dy * -1
    end
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
        heigth = quad.height
    }
end

function Ball:collidesWith(box)
    -- TODO
end

return Ball
