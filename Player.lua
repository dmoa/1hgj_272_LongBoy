local Player = {
    image = lg.newImage("player.png"),
    x = 0,
    y = 750,
    xv = 150,
    ball = {
        x = game_width / 2,
        y = game_height - 250,
        r = 25,
        xv = 250,
        yv = 250,
        color = {1, 1, 1}
    }
}

Player.width = Player.image:getWidth() * 0.9

function Player:draw()
    lg.setColor(1, 1, 1)
    lg.draw(self.image, self.x, self.y, 0, self.width / self.image:getWidth())
    lg.setColor(self.ball.color)
    lg.circle("fill", self.ball.x, self.ball.y, self.ball.r)
end

function Player:update(dt)
    self:update_paddle(dt)
    self:update_ball(dt)
    self:check_other_balls()
end

function Player:update_paddle(dt)
    if input.right() then
        self.x = self.x + self.xv * dt
    end
    if input.left() then
        self.x = self.x - self.xv * dt
    end
    if self.x < 0 then self.x = 0 end
    if self.x + self.width > game_width then self.x = game_width - self.width end
end

function Player:update_ball(dt)
    local b = self.ball

    b.x = b.x + b.xv * dt
    b.y = b.y + b.yv * dt

    if b.x - b.r < 0 or b.x + b.r > game_width then
        b.xv = b.xv * -1
    end
    if b.y - b.r < 0 then
        b.yv = b.yv * -1
    end

    if (b.x > self.x and b.x < self.x + self.width and b.y + b.r > self.y) then
        b.y = self.y - b.r
        b.yv = b.yv * -1
    end

    if b.y - b.r > game_height then
        restart()
    end

    b.color = {love.math.random(), love.math.random(), love.math.random()}
end

function Player:check_other_balls()
    local b = self.ball
    for k, ball in ipairs(balls.balls_data) do
        if CC(ball.x, ball.y, ball.radius, b.x, b.y, b.r) then
            table.remove(balls.balls_data, k)
            self:shrink()
            score = score + 1
            score_text:set("Score: "..score)
            return
        end
    end
end

function Player:shrink()
    self.width = self.width * 0.9
    self.xv = self.xv * 1.2
end

function Player:restart()
    self.width = self.image:getWidth() * 0.9
    self.x = 0
    self.ball.x = game_width / 2
    self.ball.y = game_height - 250
end

return Player