Level = Class{}

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
