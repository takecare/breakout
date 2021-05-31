local Paddle = require('src/Paddle')
local Ball = require('src/Ball')
local Brick = require('src/Brick')
local LevelMaker = require('src/LevelMaker')
local Level = require('src/Level')

local PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.isPaused = false
    self.paddle = nil
    self.ball = nil
    self.level = nil
end

function PlayState:enter(params)
    self.isPaused = false
    self.paddle = params.paddle
    self.ball = params.ball
    self.level = params.level

    self.ball:serve()
end

function PlayState:update(dt)
    if self.isPaused then
        return
    end

    self.paddle:handleInput()

    self.ball:update(dt)
    self.paddle:update(dt)

    self.level:collidesWith(self.ball)

    if self.ball:collidesWith(self.paddle) then
        gSounds['paddlehit']:play()
        self.ball:collidedWith(self.paddle)
        self.paddle:collidedWith(self.ball)
    end

    if self.ball:isOut() then
        gStateMachine:change(
            'serve',
            {
                paddle = self.paddle,
                ball = self.ball,
                level = self.level
            }
        )
    end
end

function PlayState:keyPressed(key)
    if key == 'escape' then
        gSounds['pause']:play()
        self:pause()
    -- elseif key == 'space' then
    --     self.ball:serve()
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
