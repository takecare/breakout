local StartState = Class{__includes = BaseState}

local options = {
    {
        title = 'START',
        action = function() gStateMachine:change('play') end,
        render = function(this, isSelected)
            updateMenuColor(isSelected)
            love.graphics.printf(this.title, 0, VIRTUAL_HEIGHT / 2 + 60, VIRTUAL_WIDTH, 'center')
        end
    },
    {
        title = 'HIGH SCORES',
        action = function() gStateMachine:change('') end,
        render = function(this, isSelected)
            updateMenuColor(isSelected)
            love.graphics.printf(this.title, 0, VIRTUAL_HEIGHT / 2 + 85, VIRTUAL_WIDTH, 'center')
        end
    }
}
local currentlySelectedOption = 1

function updateMenuColor(isSelected)
    if isSelected then
        love.graphics.setColor(0.5, 1, 1)
    else 
        love.graphics.setColor(1, 1, 1)
    end
end

function StartState:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('BREAKOUT', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    for i, item in ipairs(options) do
        item:render(currentlySelectedOption == i)
    end
end

function StartState:keyPressed(key)
    if key == 'up' or key == 'down' then
        currentlySelectedOption = currentlySelectedOption == 1 and 2 or 1
        gSounds['paddlehit']:play()
    elseif key == 'enter' or key == 'return' or key == 'space' then
        options[currentlySelectedOption]:action()
    elseif key == 'escape' then
        love.event.quit()
    end
end

return StartState
