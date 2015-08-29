# The Nature of Code
# http://natureofcode.com
class Mover
  RADIUS = 24
  def initialize(location:)
    @location = location
    @velocity = Vec2D.new(0, 0)
    @topspeed = 6
  end

  def update
    mouse = Vec2D.new(mouse_x, mouse_y)
    acceleration = mouse - @location
    acceleration.normalize!
    acceleration *= 0.2
    @velocity += acceleration
    @velocity.set_mag(@topspeed) { @velocity.mag > @topspeed }
    @location += @velocity
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    ellipse(@location.x, @location.y, 2 * RADIUS, 2 * RADIUS)
  end
end

# NOC_1_10_motion101_acceleration
def setup
  sketch_title 'Motion 101 Acceleration'
  @mover = Mover.new(location: Vec2D.new(rand(width / 2), rand(height / 2.0)))
end

def draw
  background(255)
  @mover.update
  @mover.display
end

def settings
  size(800, 200)
end

