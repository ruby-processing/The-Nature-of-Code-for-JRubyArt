# The Nature of Code
# http://natureofcode.com


require_relative 'mover'

def setup
  sketch_title 'Noc 2 1 Forces'
  @m = Mover.new
end

def draw
  background(255)
  wind = Vec2D.new(0.01, 0)
  gravity = Vec2D.new(0, 0.1)
  @m.apply_force(wind)
  @m.apply_force(gravity)
  @m.update
  @m.display
  @m.check_edges(width, height)
end

def settings
  size(640, 360)
end

