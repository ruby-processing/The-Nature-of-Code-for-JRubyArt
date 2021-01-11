# The Nature of Code
# http://natureofcode.com
class Mover
  RADIUS = 24
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
    ellipse(location.x, location.y, RADIUS * 2, RADIUS * 2)
  end

  def check_edges(width, height)
    unless (RADIUS..width - RADIUS).cover? location.x
      location.x = RADIUS if location.x > width - RADIUS
      location.x = width - RADIUS if location.x < RADIUS
    end
    return if (RADIUS..height - RADIUS).cover? location.y

    location.y = RADIUS if location.y > height - RADIUS
    location.y = height - RADIUS if location.y < RADIUS
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
