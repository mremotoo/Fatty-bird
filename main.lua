require 'asset.dependencies'

local background = love.graphics.newImage('asset/gfx/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('asset/gfx/ground.png')
local groundScroll = 0

local backgroundScrollSpeed = 30
local groundScrollSpeed = 60
local backgroundLoopPoint = 413

local scrolling = true

love.graphics.setDefaultFilter('nearest', 'nearest')

love.window.setTitle('MyFatty Bird')

love.graphics.setFont(gfonts['flappyFont'])

push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
})

gStateMachine:change('title')

love.keyboard.keysPressed = {}

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then 
        love.event.quit() 
    end  
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    
    backgroundScroll = (backgroundScroll + backgroundScrollSpeed * dt)
    % backgroundLoopPoint

    groundScroll = (groundScroll + groundScrollSpeed * dt)
    % VIRTUAL_WIDTH

    gStateMachine:update(dt)    
    
    love.keyboard.keysPressed = {}
end

function love.draw() 
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)

    gStateMachine:render()
    
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT -16)
    
    push:finish()
    displayFPS()
end

function displayFPS()
    love.graphics.setFont(gfonts['mediumFont'])
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), WINDOW_WIDTH - 55, 5)
end