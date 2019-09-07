local Object = Class{}

--[[ as our clas implementation does not support proper inheritance, this base
'Object' class acts only as documentation on what an Object is (i.e. its
contract) in our game ]]

function Object:init() end
function Object:handleInput() end
function Object:update(dt) end
function Object:render() end
function Object:boundingBox() end
function Object:collidesWith(box) end
function Object:collidedWith(box) end

return Object
