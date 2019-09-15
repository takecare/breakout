local Level = require('src/Level')
local Brick = require('src/Brick')

local LevelMaker = Class{}

function LevelMaker:init()
    --
end

function LevelMaker:createLevel()
    local x, y = unpack({30, 30})
    local brick = Brick(x, y)
    local bricks = { brick }
    local width = brick:boundingBox().width
    
    for i = 2, 10 do
        bricks[i] = Brick(width * (i-1) + x, y)
    end
    
    return Level(bricks)
end

return LevelMaker
