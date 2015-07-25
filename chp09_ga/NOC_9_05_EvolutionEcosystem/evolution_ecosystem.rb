# EvolutionEcoSystem
# The Nature of Code
# A World of creatures that eat food
# The more they eat, the longer they survive
# The longer they survive, the more likely they are to reproduce
# The bigger they are, the easier it is to land on food
# The bigger they are, the slower they are to find food
# When the creatures die, food is left behind


require_relative 'world'

include Eco

attr_reader :world

def setup
  sketch_title 'Evolution Ecosystem'
  @world = World.new(20, width, height)
end

def draw
  background(255)
  world.run
end

def mouse_pressed
  world.born(mouse_x, mouse_y)
end

def mouse_dragged
  world.born(mouse_x, mouse_y)
end

def settings
  size(640, 360)
  smooth 4
end

