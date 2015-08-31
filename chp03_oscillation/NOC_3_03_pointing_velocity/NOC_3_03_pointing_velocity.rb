# NOC_3_03_pointing_velocity
# http://natureofcode.com
require_relative 'mover'
attr_reader :mover

def setup
  sketch_title 'Pointing Velocity'
  @mover = Mover.new(location: Vec2D.new(width / 2, height / 2))
end

def draw
  background(255)
  mover.update(mouse: Vec2D.new(mouse_x, mouse_y))
  mover.check_edges(max_x: width, max_y: height)
  mover.display
end

def settings
  size(640, 360)
end
