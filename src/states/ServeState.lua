local Paddle = require('src/Paddle')
local Ball = require('src/Ball')
local Brick = require('src/Brick')
local LevelMaker = require('src/LevelMaker')
local Level = require('src/Level')

local ServeState = Class{__includes = BaseState}

local VERTICAL_MARGIN = 30
local HORIZONTAL_MARGIN = 20
local NUM_ROWS = 5

function ServeState:init()
    self.isPaused = false

    self.paddle = Paddle()
    local paddleBox = self.paddle:boundingBox()
    self.ball = Ball(0, paddleBox.y - paddleBox.height, paddleBox.width / 2)
    local ballBox = self.ball:boundingBox()
    self.ball.x = paddleBox.x  + paddleBox.width / 2 - ballBox.width / 2

    self.levelMaker = LevelMaker()
    self.level = self.levelMaker:createLevel(HORIZONTAL_MARGIN, VERTICAL_MARGIN, NUM_ROWS)
end

function ServeState:enter(params)
    if not params then
        return 
    end

    self.paddle = params.paddle
    self.level = params.level
    
    local paddleBox = self.paddle:boundingBox()
    self.ball = Ball(0, paddleBox.y - paddleBox.height, paddleBox.width / 2)
    local ballBox = self.ball:boundingBox()
    self.ball.x = paddleBox.x  + paddleBox.width / 2 - ballBox.width / 2
end

function ServeState:exit()
    -- TODO
end

function ServeState:update(dt)
    if self.isPaused then
        return
    end

    self.paddle:handleInput()
    self.ball:handleInput()

    self.paddle:update(dt)
    self.ball:update(dt)
end

function ServeState:keyPressed(key)
    if key == 'escape' then
        gSounds['pause']:play()
        self:pause()
    elseif key == 'space' then
        self:serve()
    else 
        self.paddle:keyPressed(key)
    end
end

function ServeState:serve()
    -- TODO: need to normalize paddle.dx
    self.ball.dx = 100 * self.paddle.dx
    gStateMachine:change(
            'play',
            {
                paddle = self.paddle,
                ball = self.ball,
                level = self.level
            }
        )
end

function ServeState:pause()
    self.isPaused = not self.isPaused
end

function ServeState:render()
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

return ServeState
