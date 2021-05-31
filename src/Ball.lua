local Object = require('src/Object')
local Collision = require('src/Collision')
local Ball = Class{__includes = Object}

local TOP_WALL = 0
local BOTTOM_WALL = 0
local RIGHT_WALL = 0
local LEFT_WALL = 0
local SPEED = 110

function Ball:init(x, y, margin)
    self.skin = 1
    self.x = x ~= nil and x or VIRTUAL_WIDTH / 2 - 32
    self.y = y ~= nil and y or VIRTUAL_HEIGHT - 64
    self.margin = margin ~= nil and margin or 0
    self.dx = 0
    self.dy = 0

    self.collision = {
        top = Collision(),
        left = Collision(),
        bottom = Collision(),
        right = Collision()
    }

    -- hack: as when the file is loaded VIRTUAL_* are not defined we need this here in our constructor
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
    end

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:handleInput()
    if love.keyboard.isDown('left') and self.x >= self.margin then
        self.dx = -SPEED
    elseif love.keyboard.isDown('right') and self.x <= RIGHT_WALL - self.margin then
        self.dx = SPEED
    else
        self.dx = 0
    end
end

function Ball:isOut()
    return self.y + self:quad().height > BOTTOM_WALL
end

function Ball:reset()
    self.dx = 0
    self.x = VIRTUAL_HEIGHT / 2
    self.y = VIRTUAL_WIDTH / 2
end

function Ball:serve()
    self.dy = -100
    -- self.dx = math.random() > 0.5 and -80 or 80
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

function Ball:collidesWith(other)
    local me = self:boundingBox()
    local other = other:boundingBox()

    local minX = me.x
    local maxX = me.x + me.width
    local minY = me.y
    local maxY = me.y + me.height
    
    local otherMinX = other.x
    local otherMaxX = other.x + other.width
    local otherMinY = other.y
    local otherMaxY = other.y + other.height

    local otherOnLeft = minX > otherMinX and minX < otherMaxX
    local otherOnRight = maxX > otherMinX and maxX < otherMaxX
    local otherSmallerWidth = minX < otherMinX and maxX > otherMaxX
    local otherGreaterWidth = minX > otherMinX and maxX < otherMaxX
    
    local otherSmallerHeight = minY < otherMinY and maxY > otherMaxY
    local otherGreaterHeight = minY > otherMinY and maxY < otherMaxY
    local otherOnTop = minY > otherMinY and minY < otherMaxY
    local otherBottom = maxY > otherMinY and maxY < otherMaxY

    self.collision.top.colliding =
        (minY > otherMinY and minY < otherMaxY) and (otherOnLeft or otherOnRight or otherSmallerWidth)
    self.collision.right.colliding =
        (otherMinX < minX and minX < otherMaxX) and (otherSmallerHeight or otherOnTop or otherBottom)
    self.collision.bottom.colliding =
        (otherMinY < maxY and otherMaxY > maxY) and (otherSmallerWidth or otherOnLeft or otherSmallerWidth)
    self.collision.left.colliding =
        (otherMinX < maxX and otherMaxX > maxX) and (otherSmallerHeight or otherOnTop or otherBottom)

    if self.collision.top.colliding then
        self.collision.top.yStart = minY
        self.collision.top.yEnd = minY

        if otherSmallerWidth then
            self.collision.top.xStart = otherMinX
            self.collision.top.xEnd = otherMaxX
        elseif otherGreaterWidth then
            self.collision.top.xStart = minX
            self.collision.top.xEnd = maxX
        elseif otherOnLeft then
            self.collision.top.xStart = minX
            self.collision.top.xEnd = otherMaxX
        elseif otherOnRight then
            self.collision.top.xStart = otherMinX
            self.collision.top.xEnd = maxX
        end
    end

    if self.collision.right.colliding then
        self.collision.left.xStart = minX
        self.collision.left.xEnd = minX

        if otherSmallerHeight then
            self.collision.left.yStart = otherMinY
            self.collision.left.yEnd = otherMaxY
        elseif otherGreaterHeight then
            self.collision.left.yStart = minY
            self.collision.left.yEnd = maxY
        elseif otherOnTop then
            self.collision.left.yStart = minY
            self.collision.left.yEnd = otherMaxY
        elseif otherBottom then
            self.collision.left.yStart = maxY
            self.collision.left.yEnd = otherMinY
        end
    end

    if self.collision.bottom.colliding then
        self.collision.bottom.yStart = maxY
        self.collision.bottom.yEnd = maxY

        if otherSmallerWidth then
            self.collision.bottom.xStart = otherMinX
            self.collision.bottom.xEnd = otherMaxX
        elseif otherGreaterWidth then
            self.collision.bottom.xStart = minX
            self.collision.bottom.xEnd = maxX
        elseif otherOnLeft then
            self.collision.bottom.xStart = minX
            self.collision.bottom.xEnd = otherMaxX
        elseif otherOnRight then
            self.collision.bottom.xStart = otherMinX
            self.collision.bottom.xEnd = maxX
        end
    end

    if self.collision.left.colliding then
        self.collision.right.xStart = maxX
        self.collision.right.xEnd = maxX

        if otherSmallerHeight then
            self.collision.right.yStart = otherMinY
            self.collision.right.yEnd = otherMaxY
        elseif otherGreaterHeight then
            self.collision.right.yStart = minY
            self.collision.right.yEnd = maxY
        elseif otherOnTop then
            self.collision.right.yStart = minY
            self.collision.right.yEnd = otherMaxY
        elseif otherBottom then
            self.collision.right.yStart = maxY
            self.collision.right.yEnd = otherMinY
        end
    end

    return self.collision.top.colliding 
        or self.collision.left.colliding
        or self.collision.bottom.colliding
        or self.collision.right.colliding
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
