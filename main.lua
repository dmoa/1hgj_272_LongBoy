la = love.audio
ld = love.data
le = love.event
lfile = love.filesystem
lf = love.font
lg = love.graphics
li = love.image
lj = love.joystick
lk = love.keyboard
lm = love.math
lmouse = love.mouse
lp = love.physics
lsound = love.sound
lsys = love.system
lth = love.thread
lt = love.timer
ltouch = love.touch
lv = love.video
lw = love.window

lg.setDefaultFilter("nearest", "nearest", 1)
lg.setLineStyle('rough')

splash = require "libs/splash"
input = require "libs/input"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 2, {}, function()


push = require "libs/push"
game_width, game_height = 800, 800
windowL = 800
lw.setMode(windowL, windowL, {borderless = false})
push:setupScreen(game_width, game_height, windowL, windowL, {fullscreen = false, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())


require "CC"

player = require "Player"
balls = require "Balls"


font = lg.newFont(50)
score = 0
score_text = lg.newText(font, "score: "..score)


function love.draw()
    screen:apply()
    push:start()

    lg.draw(score_text, 0, 0)

    player:draw()
    balls:draw()

    push:finish()
end

function love.update(dt)
    screen:update(dt)
    player:update(dt)
    balls:update(dt)
end

function restart()
    player:restart()
    balls:restart()
    score = 0
    score_text:set("Score: "..score)
end

function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
end

function love.resize(w, h)
  push:resize(w, h)
  lg.clear()
end

end)