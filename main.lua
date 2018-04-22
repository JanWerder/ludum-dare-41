--Gamestate & Timer
Gamestate = require "libs.hump.gamestate"
Timer = require "libs.hump.timer"

inspect = require "libs.inspect.inspect"

--Web-Debug (http://localhost:8000/)
lovebird = require "libs.lovebird.lovebird"

--Helper Library
lume = require "libs.lume.lume"
Class = require "libs.hump.class"
Vector = require "libs.hump.vector"
Timer = require "libs.hump.Timer"
mlib = require "libs.mlib.mlib"

--Hot-Swapping
lurker = require "libs.lurker.lurker"

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

--VN Library
Moan = require "libs.moan.moan"

utils = require 'utils' 

--Gamestates
menu = {}
game = {}
game.stages = require 'objects.stages'
gameAttack = {}
gameAttack.stages = require 'objects.stagesAttack'
gameOver = {}


--Include the states 
require 'states.game'
require 'states.gameAttack'
require 'states.menu'
require 'states.gameOver'


--Include game-object Manager
require 'objects.creepManager'
require 'objects.towerManager'
require 'objects.spawnBox'

function love.load()	
    Moan.font = love.graphics.newFont("font/JinxedWizards.ttf", 32)
    Moan.typeSound = love.audio.newSource("sound/typeSound.wav", "static")

    lovebird.update()
    Gamestate.registerEvents()
    --Gamestate.switch(game)  
    Gamestate.switch(gameAttack)    
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
    if key == "g" then
        Gamestate.switch(gameOver) 
    end
    
    if key == "a" then
        Gamestate.switch(gameAttack) 
    end

    if key == "s" then
        Gamestate.switch(game) 
    end

    Moan.keyreleased(key)
end