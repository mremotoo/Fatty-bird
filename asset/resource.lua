require 'asset.StateMachine'

gfonts = {
    ['smallFont'] = love.graphics.newFont('asset/font/flappy.ttf', 8),
    ['mediumFont'] = love.graphics.newFont('asset/font/flappy.ttf', 14),
    ['flappyFont'] = love.graphics.newFont('asset/font/flappy.ttf', 28),
    ['hugeFont'] = love.graphics.newFont('asset/font/flappy.ttf', 56)
}

gStateMachine = StateMachine {
    ['title'] = function() return TitleScreenState() end,
    ['countdown'] = function() return CountdownState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end
}