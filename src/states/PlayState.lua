local Paddle = require('src/Paddle')
local Ball = require('src/Ball')
local Brick = require('src/Brick')
local LevelMaker = require('src/LevelMaker')
local Level = require('src/Level')

local PlayState = Class{__includes = BaseState}

local VERTICAL_MARGIN = 20
local HORIZONTAL_MARGIN = 10
local NUM_ROWS = 3

function PlayState:init()
    self.isPaused = false
    self.paddle = Paddle()
    self.ball = Ball()
    self.levelMaker = LevelMaker()
    self.level = self.levelMaker:createLevel(HORIZONTAL_MARGIN, VERTICAL_MARGIN, NUM_ROWS)
end

function PlayState:update(dt)
    if self.isPaused then
        return
    end

    self.ball:update(dt)
    self.paddle:update(dt)

    self.level:collidesWith(self.ball)

    if self.ball:collidesWith(self.paddle) then
        gSounds['paddlehit']:play()
        self.ball:collidedWith(self.paddle)
        self.paddle:collidedWith(self.ball)
    end
end

function PlayState:keyPressed(key)
    if key == 'escape' then
        gSounds['pause']:play()
        self:pause()
    elseif key == 'space' then
        self.ball:serve()
    else 
        self.paddle:keyPressed(key)
    end
end

function PlayState:pause()
    self.isPaused = not self.isPaused
end

function PlayState:render()
    if self.isPaused then
        love.graphics.setColor({ 0.5, 0.5, 0.5, 0.5 })
    end

    self.level:render()
    self.paddle:render()
    self.ball:render()

    if self.isPaused then
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    end
end

return PlayState
