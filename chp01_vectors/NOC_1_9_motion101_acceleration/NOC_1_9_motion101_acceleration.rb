# The Nature of Code
# http://natureofcode.com


class Mover
  attr_reader :height, :width
  def initialize(width, height)
    @width, @height = width, height
    @location = Vec2D.new(rand(width / 2.0), rand(height / 2.0))
    @velocity = Vec2D.new(0, 0)
    @topspeed = 6
  end

  def update
    acceleration = Vec2D.new(rand, rand)
    acceleration *= rand(0 .. 2.0)
    @velocity += acceleration
    @velocity.set_mag(@topspeed) {@velocity.mag > @topspeed}
    @location += @velocity
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    ellipse(@location.x, @location.y, 48, 48)
  end

  def check_edges
    if @location.x > width
      @location.x = 0
    elsif @location.x < 0
      @location.x = width
    end
    if @location.y > height
      @location.y = 0
    elsif @location.y < 0
      @location.y = height
    end
  end
end

#NOC_1_9_motion101_acceleration
def setup
  sketch_title 'Noc 1 9 Motion101 Acceleration'
  @mover = Mover.new(width, height)
end

def draw
  background(255)
  @mover.update
  @mover.check_edges
  @mover.display
end

def settings
  size(800, 200)
end

