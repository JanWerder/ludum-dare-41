--Gamestate & Timer
Gamestate = require "libs.hump.gamestate"
Timer = require "libs.hump.timer"

inspect = require "libs.inspect.inspect"

--Web-Debug (http://localhost:8000/)
lovebird = require "libs.lovebird.lovebird"

--Helper Library
lume = require "libs.lume.lume"

--Hot-Swapping
lurker = require("libs.lurker.lurker")

--Camera
Camera = require 'libs.STALKER-X.camera'

--Animation
Anim8 = require 'libs.anim8.anim8'

--Collision
Bump = require 'libs.bump.bump'

--GUI
suit = require 'libs.suit'

--Tiled
sti = require 'libs.sti'

utils = require 'utils'

--Gamestates
menu = {}
game = {}

--Include the states 
require 'states.game'
require 'states.menu'

function love.load()
    lovebird.update()
    Gamestate.registerEvents()
    Gamestate.switch(game)    
end

function love:update(dt)
    lovebird.update()
    lurker.update()
end


--Forward the events to the GUI library
function love.textedited(text, start, length)
    suit.textedited(text, start, length)
end

function love.textinput(t)
	suit.textinput(t)
end

function love.keypressed(key)
	suit.keypressed(key)
end