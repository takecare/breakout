Class = require('modules/class')
push = require('modules/push')
StateMachine = require('modules/StateMachine')

BaseState = require('src/states/BaseState')
StartState = require('src/states/StartState')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

gFonts = {}
gTextures = {}
gSounds = {}
gStateMachine = {}

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('')

    gFonts['small'] = love.graphics.newFont('assets/font.ttf', 8)
    gFonts['medium'] = love.graphics.newFont('assets/font.ttf', 16)
    gFonts['large'] = love.graphics.newFont('assets/font.ttf', 32)
    
    gTextures['arrows'] = love.graphics.newImage('assets/arrows.png')
    gTextures['background'] = love.graphics.newImage('assets/background.png')
    gTextures['blocks'] = love.graphics.newImage('assets/blocks.png')
    gTextures['breakout'] = love.graphics.newImage('assets/breakout.png')
    gTextures['hearts'] = love.graphics.newImage('assets/hearts.png')
    gTextures['particle'] = love.graphics.newImage('assets/particle.png')

    gSounds['brickhit1'] = love.audio.newSource('assets/brick-hit-1.wav', 'static')
    gSounds['brickhit2'] = love.audio.newSource('assets/brick-hit-2.wav', 'static')
    gSounds['confirm'] = love.audio.newSource('assets/confirm.wav', 'static')
    gSounds['highscore'] = love.audio.newSource('assets/high-score.wav', 'static')
    gSounds['hurt'] = love.audio.newSource('assets/hurt.wav', 'static')
    gSounds['music'] = love.audio.newSource('assets/music.wav', 'static')
    gSounds['noselect'] = love.audio.newSource('assets/no-select.wav', 'static')
    gSounds['paddlehit'] = love.audio.newSource('assets/paddle-hit.wav', 'static')
    gSounds['pause'] = love.audio.newSource('assets/pause.wav', 'static')
    gSounds['recover'] = love.audio.newSource('assets/recover.wav', 'static')
    gSounds['score'] = love.audio.newSource('assets/score.wav', 'static')
    gSounds['select'] = love.audio.newSource('assets/select.wav', 'static')
    gSounds['victory'] = love.audio.newSource('assets/victory.wav', 'static')
    gSounds['wallhit'] = love.audio.newSource('assets/wall-hit.wav', 'static')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- TODO setup state machine
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end
    }
end

function love.update(dt)
    -- TODO forward to state
end

function love.draw()
    -- TODO forward to state
    displayFps()
end

function love.keypressed(key)
    gStateMachine:keyPressed(key)
end

function love.resize(w, h)
    push:resize(w, h)
end

function displayFps()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print(tostring(love.timer.getFPS()), 5, 5)
end
