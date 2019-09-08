local Level = require('src/Level')
local Brick = require('src/Brick')

local LevelMaker = Class{}

function LevelMaker:init()
    --
end

function LevelMaker:createLevel()
    local brick = Brick(10, 10)
    local bricks = { brick }
    for i = 2, 10 do
        bricks[i] = Brick(brick:boundingBox().width * (i-1) + 10, 10)
    end
    return Level(bricks)
end

return LevelMaker
