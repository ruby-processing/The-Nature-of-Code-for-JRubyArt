# The Nature of Code
# http://natureofcode.com


class Mover
  attr_reader :location
  def initialize(width, height)
    @location = Vec2D.new(rand(0 .. width), rand(0 .. height))
    @velocity = Vec2D.new(rand(-2.0 .. 2.0), rand(-2.0 .. 2.0))
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
    if location.x > width
      location.x = 0
    elsif location.x < 0
      location.x = width
    end
    if location.y > height
      location.y = 0
    elsif location.y < 0
      location.y = height
    end
  end
end

# NOC_1_7_motion101
attr_reader :mover

def setup
  sketch_title 'Noc 1 7 Motion101'
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

