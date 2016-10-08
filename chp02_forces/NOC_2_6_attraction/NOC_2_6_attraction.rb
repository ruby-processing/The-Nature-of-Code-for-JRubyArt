#  NOC_2_6_attraction
# The Nature of Code
# http://natureofcode.com
# A class for a draggable attractive body in our world

require_relative 'attractor'
require_relative 'mover'

attr_reader :attractor, :attractor_mover

def setup
  sketch_title 'Attraction'
  @attractor_mover = Mover.new
  @attractor = Attractor.new(location: Vec2D.new(width / 2, height / 2))
end

def draw
  background(255)
  attraction = attractor.attract(mover: attractor_mover)
  attractor_mover.apply_force(force: attraction)
  attractor_mover.update
  attractor.drag(position: Vec2D.new(mouse_x, mouse_y))
  attractor.hover(position: Vec2D.new(mouse_x, mouse_y))
  attractor.display
  attractor_mover.display
end

def mouse_pressed
  attractor.clicked(position: Vec2D.new(mouse_x, mouse_y))
end

def mouse_released
  attractor.stop_dragging
end

def settings
  size(640, 360)
end
