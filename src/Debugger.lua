local Debugger = Class{}

function Debugger:init(objects)
    self.objects = objects ~= nil and objects or {}
end

function Debugger:add(key, value)
    if key == nil or value == nil then
        error('both key and value are mandatory paramaters')
    end

    if value.update == nil then
        value.update = function(dt) end
    end

    if value.render == nil then
        value.render = function() end
    end

    if value.handleInput == nil then
        value.handleInput = function() end
    end

    if value.keyPressed == nil then
        value.keyPressed = function(key) end
    end

    self.objects[key] = value
end

function Debugger:remove(key)
    self.objects[key] = nil
end

function Debugger:update(dt)
    for k, v in pairs(self.objects) do
        v:update(dt)
    end
end

function Debugger:render()
    for k, v in pairs(self.objects) do
        v:render()
    end
end

function Debugger:handleInput()
    for k, v in pairs(self.objects) do
        v:handleInput()
    end
end

function Debugger:keyPressed(key)
    for k, v in pairs(self.objects) do
        v:keyPressed(key)
    end
end

return Debugger
