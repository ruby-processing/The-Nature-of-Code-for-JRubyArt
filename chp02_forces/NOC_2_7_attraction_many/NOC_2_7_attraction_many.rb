# NOC_2_7_attraction_many
# The Nature of Code
# http://natureofcode.com
require_relative 'mover'
require_relative 'attractor'

attr_reader :attractor, :movers

def setup
  sketch_title 'Noc 2 7 Attraction Many'
  @movers = Array.new(10) { Mover.new(rand(width), rand(height), rand(0.1 .. 2)) }
  @attractor = Attractor.new(width, height)
end

def draw
  background(255)
  attractor.display
  attractor.drag
  attractor.hover(mouse_x, mouse_y)
  movers.each do |m|
    force = attractor.attract(m)
    m.apply_force(force)
    m.update
    m.display
  end
end

def mouse_pressed
  attractor.clicked(mouse_x, mouse_y)
end

def mouse_released
  attractor.stop_dragging
end

def settings
  size(640, 360)
end

