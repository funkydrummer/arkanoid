require 'rubygems'
require 'gosu'

require_relative 'engine'
require_relative 'zorder'

require_relative 'energy_bar'
require_relative 'explosion'
require_relative 'hud'
require_relative 'edge'
require_relative 'ball'
require_relative 'block'
require_relative 'board'

game = Engine::Game.instance
game.show
