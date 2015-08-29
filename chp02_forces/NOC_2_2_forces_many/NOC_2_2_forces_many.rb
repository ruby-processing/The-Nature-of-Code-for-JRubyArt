# The Nature of Code
# http://natureofcode.com
require_relative 'mover'

def setup
  sketch_title 'Forces Many'
  @movers = Array.new(20) { Mover.new(rand(0.1..4), 0, 0) }
end

def draw
  background(255)
  @movers.each do |m|
    wind = Vec2D.new(0.01, 0)
    gravity = Vec2D.new(0, 0.1)
    m.apply_force(force: wind)
    m.apply_force(force: gravity)
    m.update
    m.display
    m.check_edges(max_x: width, max_y: height)
  end
end

def settings
  size(800, 200)
end
