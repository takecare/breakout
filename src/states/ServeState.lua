local ServeState = Class{__includes = BaseState}

function ServeState:init() 
    -- TODO create level
    -- TODO create paddle
    -- TODO create ball
end

function ServeState:enter(params) 
    -- TODO do we need this?
end

function ServeState:exit() end

function ServeState:update(dt) 
    -- TODO move paddle across x axis
    -- TODO move ball across x axis
end

function ServeState:keyPressed(key) 
    -- TODO escape pauses
    -- TODO space serves (move to next state)
end

function ServeState:render()
    -- TODO draw bricks
    -- TODO draw paddle
    -- TODO draw ball
end

return ServeState
