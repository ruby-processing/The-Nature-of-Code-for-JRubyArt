# The Nature of Code
# http://natureofcode.com
require_relative 'mover'

SIZE = 15

def setup
  sketch_title 'Forces No Friction'
  srand(1)
  @movers = (0..SIZE).map { Mover.new(rand(1.0..4), rand(width), 0) }
end

def draw
  background(255)
  @movers.each do |m|
    wind = Vec2D.new(0.01, 0)
    gravity = Vec2D.new(0, 0.1 * m.mass)
    m.apply_forces(wind, gravity)
    m.update
    m.display
    m.check_edges(max_x: width, max_y: height)
  end
end

def settings
  size(383, 200)
end
