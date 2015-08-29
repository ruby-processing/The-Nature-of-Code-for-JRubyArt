# The Nature of Code
# http://natureofcode.com
class Mover
  attr_reader :location
  def initialize(width, height)
    @location = Vec2D.new(rand(0..width), rand(0..height))
    @velocity = Vec2D.new(rand(-2.0..2.0), rand(-2.0..2.0))
  end

  def update
    @location += @velocity
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    ellipse(location.x, location.y, 48, 48)
  end

  def check_edges(width, height)
    unless (0..width).cover? location.x
      location.x = 0 if location.x > width
      location.x = width if location.x < 0
    end
    return if (0..height).cover? location.y
    location.y = 0 if location.y > height
    location.y = height if location.y < 0
  end
end

# NOC_1_7_motion101
attr_reader :mover

def setup
  sketch_title 'Motion 101'
  @mover = Mover.new(width, height)
end

def draw
  background(255)
  mover.update
  mover.check_edges(width, height)
  mover.display
end

def settings
  size(800, 200)
end
