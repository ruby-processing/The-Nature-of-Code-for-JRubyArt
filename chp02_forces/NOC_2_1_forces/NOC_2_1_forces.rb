# The Nature of Code
# http://natureofcode.com
require_relative 'mover'

attr_reader :m

def setup
  sketch_title 'Forces'
  @m = Mover.new
end

def draw
  background(255)
  wind = Vec2D.new(0.01, 0)
  gravity = Vec2D.new(0, 0.1)
  m.apply_force(force: wind)
  m.apply_force(force: gravity)
  m.update
  m.display
  m.check_edges(max_x: width, max_y: height)
end

def settings
  size(640, 360)
end
