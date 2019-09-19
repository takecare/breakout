Level = Class{}

function printTable(table)
    for i,line in ipairs(table) do
      for j,v in ipairs(line) do
        print('('..i..','..j..'): '..v.x..','..v.y)
      end
    end
end

function Level:init(bricks)
    self.bricks = bricks ~= nil and bricks or {}
end

function Level:render()
    for ky, row in pairs(self.bricks) do
        for kx, brick in pairs(row) do
            brick:render()
        end
    end
end

function Level:collidesWith(object)
    for ky, row in pairs(self.bricks) do
        for kx, brick in pairs(row) do
            if brick:collidesWith(object) then
                brick:collidedWith(object:boundingBox())
                object:collidedWith(brick:boundingBox())
            end
        end
    end
end

return Level
