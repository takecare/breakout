local Collision = Class{}

function Collision:init()
    self.colliding = false
    self.xStart = nil
    self.yStart = nil
    self.xEnd = nil
    self.yEnd = nil
end

return Collision
