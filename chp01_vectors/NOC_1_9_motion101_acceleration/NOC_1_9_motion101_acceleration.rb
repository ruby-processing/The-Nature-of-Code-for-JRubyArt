# The Nature of Code
# http://natureofcode.com
class Mover
  RADIUS = 24
  attr_reader :max_y, :max_x, :location

  def initialize(max_x:, max_y:)
    @max_x = max_x - RADIUS
    @max_y = max_y - RADIUS
    @location = Vec2D.new(rand(RADIUS..max_x), rand(RADIUS..max_y))
    @velocity = Vec2D.new(0, 0)
    @topspeed = 6
  end

  def update
    acceleration = Vec2D.random
    acceleration *= rand(0..2.0)
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

  def check_edges
    unless (RADIUS..max_x).cover? location.x
      location.x = RADIUS if location.x > max_x
      location.x = max_x if location.x < RADIUS
    end
    return if (RADIUS..max_y).cover? location.y

    location.y = RADIUS if location.y > max_y
    location.y = max_y if location.y < RADIUS
  end
end

# NOC_1_9_motion101_acceleration
def setup
  sketch_title 'Motion 101 Acceleration'
  @mover = Mover.new(max_x: width, max_y: height)
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
