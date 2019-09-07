local PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.isPaused = false
    self.color = {}
    self.paddle = Paddle()
    self.ball = Ball()
end

function PlayState:enter(params)
    -- TODO
end

function PlayState:exit()
    -- TODO
end

function PlayState:update(dt)
    if self.isPaused then
        return
    end
    self.ball:update(dt)
    self.paddle:update(dt)

    if self.ball:collidesWith(self.paddle) then
        gSounds['paddlehit']:play()
        self.ball:collidedWith(self.paddle)
        self.paddle:collidedWith(self.ball)
        self:pause()
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
        local r, g, b, a = love.graphics.getColor()
        self.color = { r, g, b, a }
        love.graphics.setColor({ 0.5, 0.5, 0.5, 0.5 })
    end

    self.paddle:render()
    self.ball:render()

    if self.isPaused then
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    end
end

return PlayState
