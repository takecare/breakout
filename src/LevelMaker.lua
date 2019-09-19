local Level = require('src/Level')
local Brick = require('src/Brick')

local LevelMaker = Class{}

function LevelMaker:init()
    --
end

function LevelMaker:createLevel()
    local desiredMargin = 30
    local x, y = unpack({desiredMargin, 30})
    local brick = Brick(x, y)
    local bricks = { { brick } }
    local width = brick:boundingBox().width

    local n = math.abs((VIRTUAL_WIDTH - x * 2) / width)
    local totalWidth = n * x
    local margin = (VIRTUAL_WIDTH - totalWidth) / 2

    brick.x = margin

    for y = 1, 4 do
        local row = {}
        for x = 1, n do
            table.insert(
                row,
                Brick(width * (x-1) + margin,
                desiredMargin + desiredMargin * (y-1))
            )
        end
        table.insert(bricks, row)
    end

    return Level(bricks)
end

function printTable(table)
    for i,line in ipairs(table) do
      for j,v in ipairs(line) do
        print('('..i..','..j..'): '..v.x..','..v.y)
      end
    end
end

return LevelMaker
