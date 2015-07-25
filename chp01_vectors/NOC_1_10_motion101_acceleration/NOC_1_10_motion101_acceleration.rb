# The Nature of Code
# http://natureofcode.com


class Mover
  def initialize(width, height)
    @location = Vec2D.new(rand(width/2.0), rand(height/2.0))
    @velocity = Vec2D.new(0, 0)
    @topspeed = 6
  end

  def update
    mouse = Vec2D.new(mouse_x, mouse_y)
    acceleration = mouse - @location
    acceleration.normalize!
    acceleration *= 0.2
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
end

# NOC_1_10_motion101_acceleration
def setup
  sketch_title 'Noc 1 10 Motion101 Acceleration'
  @mover = Mover.new(width, height)
end

def draw
  background(255)
  @mover.update
  @mover.display
end

def settings
  size(800, 200)
end

