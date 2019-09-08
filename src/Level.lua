Level = Class{}

function Level:init(bricks)
    self.bricks = bricks ~= nil and bricks or {}
end

function Level:render()
    for i, brick in pairs(self.bricks) do
        brick:render()
    end
end

function Level:collidesWith(object)
    for i, brick in pairs(self.bricks) do
        if brick:collidesWith(object) then
            brick:collidedWith(object:boundingBox())
            object:collidedWith(brick:boundingBox())
        end
    end
end

return Level
