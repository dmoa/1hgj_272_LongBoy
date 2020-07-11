local Balls = {
    balls_data = {}
}

function Balls:draw()
    for _, ball in ipairs(self.balls_data) do
        lg.setColor(ball.color)
        lg.circle("fill", ball.x, ball.y, ball.radius)
    end
end

function Balls:update(dt)
    if #self.balls_data == 0 then
        for i=1,12 do
            self:add_ball()
        end
    end
end

function Balls:add_ball()
    for i = 1, 5 do
        local overlap = false
        local new_r = love.math.random(15, 50)
        local newX = love.math.random(new_r, game_width - new_r)
        local newY = love.math.random(new_r, game_height * 0.6)
        for _, ball in ipairs(self.balls_data) do
            if CC(ball.x, ball.y, ball.radius, newX, newY, new_r) then
                overlap = true
                break
            end
        end
        if not overlap then
            table.insert(self.balls_data, {x = newX, y = newY, radius = new_r, color = {love.math.random(0.8,1), love.math.random(0.8,1), love.math.random(0.8,1)}})
            return
        end
    end
end

function Balls:restart()
    self.balls_data = {}
end


return Balls