PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0
    self.lastY = -PIPE_HEIGHT + love.math.random(80) + 20
end

function PlayState:update(dt)
    self.timer = self.timer + dt

    if self.timer > 2 then
    
        local y = math.max(-PIPE_HEIGHT + 10, 
            math.min(self.lastY + love.math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))
        self.timer = 0
    end

    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
            end
        end
        pair:update(dt) 
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    self.bird:update(dt)

    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gStateMachine:change('score', {
                    score = self.score
                })
            end
        end
    end

    if self.bird.y > VIRTUAL_HEIGHT - 15 or self.bird.y + 150 < VIRTUAL_HEIGHT - 288 then
        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(gfonts['flappyFont'])
    love.graphics.print('Score: '.. tostring(self.score), 8, 8)
    self.bird:render()
end