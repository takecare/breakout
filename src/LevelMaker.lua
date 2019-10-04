local Level = require('src/Level')
local Brick = require('src/Brick')

local LevelMaker = Class{}

function LevelMaker:init()
    --
end

function LevelMaker:createLevelFromMap(minHorizontalMargin, verticalMargin, map)
    -- TODO
end

function LevelMaker:createLevel(minHorizontalMargin, verticalMargin, numOfRows)
    -- local verticalMargin = verticalMargin ~= nil and verticalMargin or VERTICAL_MARGIN
    -- local minHorizontalMargin = minHorizontalMargin ~= nil and minHorizontalMargin or HORIZONTAL_MARGIN
    -- local numOfRows = numOfRows ~= nil and numOfRows or NUM_ROWS

    local x, y = unpack({minHorizontalMargin, verticalMargin})
    local brick = Brick(x, y)
    local bricks = { { brick } }
    local brickWidth = brick:boundingBox().width
    local brickHeight = brick:boundingBox().height

    local verticalMargin = verticalMargin < brickHeight and brickHeight or verticalMargin

    --[[
        1. determine available width for a row (assuming a row is the # of bricks you can fit into the available width)
        2. determine how much width does the row take
        3. determine how much width is left 
    ]]

    local availableWidth = VIRTUAL_WIDTH - 2 * minHorizontalMargin
    local maxBricksPerRow = math.floor(availableWidth / brickWidth)
    local maxRowWidth = maxBricksPerRow * brickWidth
    local remainingWidth = availableWidth - maxRowWidth
    local leftMargin = math.min(remainingWidth, minHorizontalMargin) / 2 + minHorizontalMargin

    brick.x = leftMargin

    DEBUGGER:add('level', {
        render = function() 
            local r,g,b,a = love.graphics.getColor()
            
            love.graphics.setColor(0.4,0.4,0.4,0.5)
            love.graphics.rectangle('fill',leftMargin,0, VIRTUAL_WIDTH - leftMargin * 2,VIRTUAL_HEIGHT)

            love.graphics.setColor(0.7,0.4,0.4,0.5)
            love.graphics.rectangle('fill',0,0,minHorizontalMargin,VIRTUAL_HEIGHT)
            love.graphics.rectangle('fill',VIRTUAL_WIDTH-minHorizontalMargin,0,minHorizontalMargin,VIRTUAL_HEIGHT)

            love.graphics.setColor(0.4,0.7,0.4,0.5)
            love.graphics.rectangle('fill',leftMargin,0,maxRowWidth,brickHeight)

            love.graphics.setColor(r,g,b,a)
        end
    })

    for y = 1, numOfRows do
        local row = {}
        for x = 1, maxBricksPerRow do
            table.insert(
                row,
                Brick(
                    brickWidth * (x-1) + leftMargin,
                    verticalMargin + verticalMargin * (y-1)
                )
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
